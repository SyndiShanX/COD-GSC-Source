/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_pickups.gsc
**************************************************/

#using script_1193c0b83fce13b;
#using script_15eddb0fac236a22;
#using script_21c19cfc7139d773;
#using script_2d9d24f7c63ac143;
#using script_32c2f4a699e57e1e;
#using script_3583ff375ab3a91e;
#using script_3aacf02225ca0da5;
#using script_3ff2458477d23489;
#using script_439d01e25d19543b;
#using script_498b5814b18986c9;
#using script_55e418c5cc946593;
#using script_5bc60484d17fa95c;
#using script_64acb6ce534155b7;
#using script_67cc94c07ab18d3a;
#using script_6fc415ff6a905dc1;
#using script_728ffcee8cbf30ee;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\equipment\hb_sensor;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\equipment\bandage;
#using scripts\mp\equipment\disguise;
#using scripts\mp\equipment\iodine_pills;
#using scripts\mp\equipment\nvg;
#using scripts\mp\equipment\throwing_knife_mp;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_blueprint_extract_spawn;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_dom_gulag;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\loot;
#using scripts\mp\overseer;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\pmc_missions;
#using scripts\mp\supers;
#using scripts\mp\supers\vehicle_drop;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace br_pickups;

function br_pickups_init() {
  level.br_pickups = spawnStruct();
  level.forcegivesuper = &forcegivesuper;
  level.showuseresultsfeedback = &showuseresultsfeedback;
  level.removeselfrevivetoken = &removeselfrevivetoken;
  level.var_f26b4e7eb9af8155 = &function_cdf7f2f6bd3207;
  level.var_c57ee1e174e42601 = &function_8206bc54a1ed73cb;
  thread function_5658dce20f11e8c4();
  level.var_86b2cfc21b9abcf8 = getdvarint(@ "hash_9aad06ff702ecdb7", 1);
  level.var_509664f56a31278f = getdvarint(@ "hash_55db2e273692b804", 1);
  level.var_cf32b38db66d1f3b = getdvarint(@ "hash_e9f0565782117772", 1);
  level.var_34906263684780b7 = getdvarint(@ "hash_3cbf2f4d297a0afb", 0);
  level.var_3ea6ceb7358d49df = getdvarint(@ "hash_260b2bc23af3a102", 1);
  level.var_41ed77c6e0438829 = getdvarint(@ "hash_81d6ab9018e6a6fe", 0);
  level.var_3d804d3022029476 = getdvarint(@ "hash_581d0f4c51272920", 1);
  level.br_pickups.var_5bbd561a9aa69746 = getdvarint(@ "hash_ec4c4df4cf064acf", 1) == 1;
  level.var_a9350d89a2e4d752 = getdvarint(@ "hash_6d4a21dadd19744d", 0);

  if(getDvar(@ "loot_table_name", "mp/loot/br/default/loot_item_defs.csv") != "mp/loot/br/default/loot_item_defs.csv") {
    level.var_a9350d89a2e4d752 = 0;
  }

  initarrays();

  if(istrue(level.var_a9350d89a2e4d752)) {
    function_d910e9a16fea4235();
    function_68c4db74396e7683();
  } else {
    function_e5528af9b712723f();
  }

  if(getDvar(@ "hash_7feb156ccfaf8ddf", "") != "") {
    function_32a0394cf13c8b29();
  }

  initscriptablemanagement();
  level.disableautolootpickup = getmatchrulesdata("brData", "disableAutoLootPickup");
  level.var_e5bb4d290468dd8 = getdvarint(@ "hash_5a47269347ae6efd", 4);
  level.var_17d5cea099c1ef53 = getdvarint(@ "hash_36a8422f72c9b425", 1);
  level.var_9fa4c8afefdc8734 = getdvarint(@ "hash_aaf53a2c0b576822", 0);
  level.var_7b6723a60d7478a0 = getdvarint(@ "hash_2f04a41993e8009a", 0);
  level.var_d3ef9649a38ffbe5 = getdvarint(@ "hash_3d4dc4c0031757df", 0);
  level.var_6fb51ff010511210 = getdvarint(@ "hash_a4f090b2c5573e4a", 0);
  level.var_152735d16e609bec = getdvarint(@ "hash_7cd2980eb93cd682", 0);
  level.var_f5a1dc77e6a05354 = getdvarint(@ "hash_bad88dadea6f5eaa", 0);
  level.var_a7c2a61a231cda3e = getdvarint(@ "hash_6ed187ba3b2a67d4", 0);
  level.var_108efba0ee1450a8 = getdvarint(@ "hash_53147c89008f8596", 0);
  level notify("br_pickups_init");
  scripts\mp\flags::gameflaginit("br_pickups_init", 1);
  level.gasmasklootid = getgasmasklootid("brloot_equip_gasmask");
  level.var_479d8ef7f76a4df6 = getgasmasklootid("brloot_equip_gasmask_durable");
  level.var_cb1a359321609c75 = getgasmasklootid("brloot_equip_gasmask_scuba");
  level.var_1170cfb92432a61d = getdvarfloat(@ "hash_27f5f1d2bc0ef94c", 0.75);
  level.var_152d5a9c5ac5cdad = getdvarfloat(@ "hash_ba9e8fbf0254be1e", 1);
  level.var_aa1aaed4a9b80d4b = getdvarint(@ "hash_3196e3743c6871b2", 3);
  level.var_7420ddc23aa7b431 = getdvarint(@ "hash_552a3359b82d470f", 1);
  level.var_a3443d8ebdaf7c00 = getdvarint(@ "hash_3481b39eb4c2f17a", 0);
  level.var_7582dc4260722bf1 = getdvarint(@ "hash_53d1e9738538bb23", 0);
  level.var_bc1086a365d70b30 = getdvarint(@ "hash_957bf05692b129ca", 1);
  level.var_e8fc7c00fd85a565 = getdvarint(@ "scr_br_auto_loot_plunder_container", 1);
  level.var_9dd3ce936c1dec1d = getdvarint(@ "scr_br_auto_loot_plunder_feedback", 1);
  utility::registersharedfunc("pickups", "isDogTag", &isdogtag);
  utility::registersharedfunc("pickups", "isGasMask", &isgasmask);
  level.var_66a7a8b388d5de9e = getdvarint(@ "hash_a55c2df135b06dc0", 2);
  level.var_66a7a8b388d5de9e = getdvarint(@ "hash_a55c2df135b06dc0", 2);
  namespace_7c996eebd51b5b1f::init();
  br_circle::registercirclecallbacks(2, &dangercircletick, &function_1a1709943670772a);
  level.var_5312bc14bd5db377 = getdvarfloat(@ "hash_58805f0cb8978a2a", 0.65);
  level.var_7f82d2e3f2ef4402 = getdvarint(@ "hash_ff8abba18e62faa0", 8);
  level.var_43c2a465029a4684 = getdvarint(@ "hash_27fc198432e29f5a", 30);
  level.var_42eb4fb7558dc1ec = getdvarint(@ "hash_a75f4828b96da3ab", 40);
  level.var_40111092ff73b724 = getdvarint(@ "hash_4b287dc805e35339", 5);
  level.var_7452545fbedecdba = getdvarint(@ "hash_c5bb640990a524c2", 1);
  level.var_793b39fdc6d2b17a = getdvarint(@ "hash_ad236b8f0eacdc66", 0) == 1;

  level thread function_d53595847895c537();
}

function function_d910e9a16fea4235() {
  level.var_970f64593dc93ff8 = [];
  level.var_ca63cdc28149e3b5 = [];
  var_a98d7d5830f7ebe6 = getscriptbundle(%"hash_19ee3c96a018bf35");

  if(isDefined(var_a98d7d5830f7ebe6) && isDefined(var_a98d7d5830f7ebe6.var_ce541b20ce9ca2a5)) {
    foreach(data in var_a98d7d5830f7ebe6.var_ce541b20ce9ca2a5) {
      var_890049f984dd3e53 = data.var_890049f984dd3e53;

      if(isDefined(var_890049f984dd3e53)) {
        var_97f1b48fd49a7224 = getscriptbundle(hashcat(%"hash_36fa976a8ae12763", var_890049f984dd3e53));

        if(isDefined(var_97f1b48fd49a7224) && isDefined(var_97f1b48fd49a7224.var_890049f984dd3e53)) {
          foreach(data in var_97f1b48fd49a7224.var_890049f984dd3e53) {
            lootitemdef = data.loot_item_def;

            if(isDefined(lootitemdef)) {
              var_4913ec7fd6df45ec = getscriptbundle(hashcat(%"loot_item_def:", lootitemdef));

              if(isDefined(var_4913ec7fd6df45ec)) {
                level.var_970f64593dc93ff8[lootitemdef] = var_4913ec7fd6df45ec;
                level.var_ca63cdc28149e3b5[var_4913ec7fd6df45ec.name] = lootitemdef;
              }
            }
          }
        }
      }
    }
  }
}

function initarrays() {
  if(!isDefined(level.br_pickups)) {
    level.br_pickups = spawnStruct();
  }

  level.br_pickups.createcallbacks = [];
  level.br_pickups.var_7c25f4fb48db3dd4 = [];
  level.br_pickups.droppedgasmasks = [];
  registerpickupcreatedcallback("brloot_equip_gasmask", &gasmask_onpickupcreated, 1);
  registerpickupcreatedcallback("brloot_equip_gasmask_durable", &gasmask_onpickupcreated, 1);
  registerpickupcreatedcallback("brloot_equip_gasmask_scuba", &gasmask_onpickupcreated, 1);
  level.br_pickups.br_equipname = [];
  level.br_pickups.stackable = [];
  level.br_pickups.maxcounts = [];
  level.br_pickups.counts = [];
  level.br_pickups.br_itemtype = [];
  level.br_pickups.var_db931093a6a130a5 = [];
  level.br_pickups.br_itemrow = [];
  level.br_pickups.br_itemrarity = [];
  level.br_pickups.br_value = [];
  level.br_pickups.br_equipnametoscriptable = [];
  level.br_pickups.br_weapontoscriptable = [];
  level.br_pickups.var_7b2bff2d04ee1017 = [];
  level.br_pickups.var_b13dc7e63676bbe7 = [];
  level.br_pickups.br_pickupsfx = [];
  level.br_pickups.br_killstreakreference = [];
  level.br_pickups.br_killstreaktoscriptable = [];
  level.br_pickups.br_superreference = [];
  level.br_pickups.var_14bd11727c4b6629 = [];
  level.br_pickups.var_838863c4848d4c26 = [];
  level.br_pickups.br_hasautopickup = [];
  level.br_pickups.var_c125a0ed111f1b8d = [];
  level.br_pickups.var_ea924219fe414fa2 = [];
  level.br_pickups.var_fac5bc934b8ffaa6 = [];
  level.br_pickups.uniquelootcallbacks = [];
  level.br_pickups.var_c4b4b56c76765330 = [];
  level.br_pickups.var_4138f9ddc1cd22d = [];
  level.br_pickups.translationoffset = [];
  level.br_pickups.rotationoffset = [];
  level.br_pickups.var_688c9b0a44e4a8ca = [];
  level.br_pickups.var_b8fad1cfd41d21da = [];
  level.br_pickups.var_a5e4b146866d7fd = [];
  level.br_pickups.var_4183295edcc21db0 = [];
  level.br_pickups.var_832ad168567520f7 = [];
  level.br_pickups.var_59e01317f76cf924 = [];
  level.br_pickups.var_caf82339100de589 = [];
  level.br_pickups.var_48c246b527477ef8 = [];
  level.br_pickups.br_allguns = [];
  level.br_pickups.br_lootguns = [];
  level.br_pickups.var_9e78b5ee377070a9 = [];
  level.br_pickups.var_692e058f97bcc055 = [];
  level.br_pickups.br_crateguns = [];
  level.br_pickups.br_crateitems = [];
  level.br_pickups.br_gulagpickups = [];
  level.br_pickups.var_1e6c5e03170cf425 = [];
  level.br_pickups.var_eb7725a8a6f2c64c = [];
  level.br_pickups.br_perks = [];
  level.br_lootiteminfo = [];
  level.br_weaponsprimary = [];
  level.br_weaponssecondary = [];
  level.br_throwables = [];
  level.br_usables = [];
  level.var_f2b443c644970bd7 = [];
  level.var_fb8e78837bc5ee6c = [];
  level.var_d8db1602c8bf473e = [];
  level.var_5635125e56693c8 = [];
  overrideitemcount("brloot_equip_gasmask_durable", getdvarint(@ "hash_20633082981b3a9c", 220));
  setdvarifuninitialized(@ "hash_61e10de0f675e9ad", 0);
  setdvarifuninitialized(@ "hash_ff7a56b91e81bd5d", 1);
  level.br_pickups.br_pickupdenyammonoroom = "MP/BR_AMMO_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyequipnoroom = "MP/BR_EQUIP_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyalreadyhaveweapon = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyarmornotbetter = "MP/BR_ARMOR_DENY_NOT_BETTER";
  level.br_pickups.br_pickupdenyalreadyhaveks = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
  level.br_pickups.var_17109b21f99ad76d = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
  level.br_pickups.var_540408f173ba9a3f = "MP_BR_INGAME/ALREADY_HAVE_GULAG_TOKEN";
  level.br_pickups.var_8c26c75f89041ddb = "MP_BR_INGAME/ALREADY_HAVE_SPRINT_BOOTS";
  level.br_pickups.br_pickupdenyalreadyhaverevive = "MP_BR_INGAME/ALREADY_HAVE_SELF_REVIVE_ITEM";
  level.br_pickups.br_pickupdenyarmorfull = "MP/BR_ARMOR_DENY_ARMOR_FULL";
  level.br_pickups.br_pickupdenyalreadyhaveplatepouch = "MP_BR_INGAME/ALREADY_HAVE_PLATE_POUCH_ITEM";
  level.br_pickups.br_pickupdenyparachuting = "MP/BR_PICKUP_DENY_PARACHUTING";
  level.br_pickups.br_pickupdenyalreadyhavequest = "MP_BR_INGAME/TABLET_PICKUP_FAILURE";
  level.br_pickups.br_pickupdenyplunderpickup = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
  level.br_pickups.br_pickupdenyjuggernaut = "KILLSTREAKS/JUGG_CANNOT_BE_USED";
  level.br_pickups.br_pickupalreadyhavespecialistbonus = "MP_BR_INGAME/ALREADY_HAVE_SPECIALIST_BONUS_ITEM";
  level.br_pickups.var_b4a939303c824805 = "MP_BR_INGAME/CIRCLE_PEEK_LIMIT";
  level.br_pickups.var_5fdcd05c466e7520 = "MP/BR_PICKUP_ITEM_MAX_LIMIT";
  level.br_pickups.var_a1a6a7680c4ff1eb = "MP/BR_ALREADY_EQUIPPED_ITEM";
  level.br_pickups.var_fde0e27b3a09bf3 = "MP/CANNOT_EQUIP_NOW";
  level.br_pickups.var_8840f100125d76c1 = "MP/CANNOT_USE_GAS_CAN";
  level.br_pickups.var_11ce58bf7ab6580b = "MP/CANNOT_USE_GAS_CAN_PALFA";
  level.br_pickups.var_4119211a43b2e452 = "MP/CANNOT_USE_GAS_CAN_IN_PALFA";
  level.br_pickups.var_fcdefa93bb57394a = "MP/CANNOT_USE_GAS_CAN_ELECTRIC";
  level.br_pickups.var_58fe23c2a80f28ed = "MP_BR_INGAME/MISSION_WHITELISTED";
  level.br_pickups.var_d8a2816e3697c70c = "MP_DMZ_MISSIONS/GEIGER_SEARCH_CONTRACT_CANCELLED_ERR";
  level.br_pickups.var_6944f496399a2a4 = "MP_BR_INGAME/TOO_MANY_TEAMMATES";
  level.br_pickups.br_pickupdenyplunderpickup = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
  level.br_pickups.var_58d0559b458fd450 = "MP/CANNOT_EQUIP_NOW";
  level.br_pickups.var_355cddb773cb000d = "MP/DENY_USE_CARRY";
  level.br_pickups.br_pickupdenyweaponpickupap = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
  level.br_pickups.var_7141c6c2372c0a82 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.var_8bffca3828fd297e = "MP/BR_EQUIP_DENY_PLATE_CARRIER_LESS";
  level.br_pickups.var_ec7422f11a61c100 = "MP/BR_EQUIP_DENY_BACKPACK_LESS";
  level.br_pickups.var_7bd397b2e9d8a434 = "MP/BR_EQUIP_DENY_PLATE_CARRIER_SAME";
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups.respawntokenenabled = getdvarint(@ "hash_c9d9bc1bae348282", 1);
  level.br_pickups.respawntokenclosewithgulag = getdvarint(@ "hash_8603626dc2ec647d", 1);
  level.br_pickups.var_a181de0ed6a505d5 = getdvarint(@ "hash_fbd4a4c8aa273539", 1);
  level.br_pickups.var_174664c71517f679 = getdvarint(@ "hash_410f6b398c585156", 1);
  level.br_pickups.var_5609de5240e42e84 = getdvarint(@ "hash_2df02ec7e7efe5c9", 1);
  level.br_pickups.var_4757cffcfe60dc3a = getdvarint(@ "hash_3ec4dd8ea4acc428", 0);
  level.br_pickups.yawoffsetoverride = undefined;
  level.br_pickups.distanceoverride = undefined;

  if(getdvarint(@ "hash_249a73868c9cd7d8", 0)) {
    function_f8b204e807cc62ed();
    function_e6cabc9f20dcbc23();
  }

  if(br_weapons::function_b1dd9dcae2f63965()) {
    br_weapons::function_b9da718e50063452();
  }

  scriptable::scriptable_addusedcallback(&function_e40eec61ee9d0889);
  scriptable::scriptable_addautousecallback(&function_e40eec61ee9d0889);
  level.var_b8e67f48a1d47883 = &function_23d6a60ccfa90b00;
}

function function_68c4db74396e7683() {
  index = 0;

  foreach(itemdef in level.var_970f64593dc93ff8) {
    itemtype = itemdef.type;

    if(!isDefined(itemtype)) {
      continue;
    }

    var_14004b68ddacb781 = itemdef.name;

    if(!isDefined(var_14004b68ddacb781)) {
      continue;
    }

    maxstacksize = itemdef.maxstacksize;

    if(!isDefined(maxstacksize)) {
      maxstacksize = 0;
    }

    level.br_pickups.br_value[var_14004b68ddacb781] = itemdef.value;
    level.br_pickups.maxcounts[var_14004b68ddacb781] = maxstacksize;
    level.br_pickups.br_hasautopickup[var_14004b68ddacb781] = itemdef.var_bb9e46e1d8130f2;
    level.br_pickups.br_itemrow[var_14004b68ddacb781] = index;
    index++;

    if(isDefined(itemdef.var_3dd78c239652c7d) && !itemdef.var_3dd78c239652c7d) {
      level.br_pickups.var_c125a0ed111f1b8d[var_14004b68ddacb781] = 1;
    }

    if(isDefined(itemdef.var_ea924219fe414fa2)) {
      var_e3a3e552ada5e66b = spawnStruct();
      var_e3a3e552ada5e66b.lootname = itemdef.var_ea924219fe414fa2;
      var_e3a3e552ada5e66b.var_dce7021a199f618f = 0;

      if(isDefined(itemdef.var_331d4c11aa8c43c)) {
        var_e3a3e552ada5e66b.var_dce7021a199f618f = itemdef.var_331d4c11aa8c43c;
      }

      level.br_pickups.var_ea924219fe414fa2[var_14004b68ddacb781] = var_e3a3e552ada5e66b;
    }

    if(isDefined(itemdef.var_fac5bc934b8ffaa6)) {
      level.br_pickups.var_fac5bc934b8ffaa6[var_14004b68ddacb781] = itemdef.var_fac5bc934b8ffaa6;
    }

    if(isDefined(itemdef.var_a38e261031751c09) && itemdef.var_a38e261031751c09 == 1) {
      level.br_pickups.var_b8fad1cfd41d21da[var_14004b68ddacb781] = itemdef.var_a38e261031751c09;
    } else {
      level.br_pickups.var_b8fad1cfd41d21da[var_14004b68ddacb781] = 0;
    }

    var_52e1d38987af61c3 = itemdef.var_52e1d38987af61c3;
    level.br_pickups.var_a5e4b146866d7fd[var_14004b68ddacb781] = isDefined(var_52e1d38987af61c3) && var_52e1d38987af61c3 != % "";

    if(itemtype != #"tablet") {
      var_d530bdb3d172e1cb = 0;
      var_d530bcb3d172df98 = 0;
      var_d530bfb3d172e631 = 0;

      if(isDefined(itemdef.originx)) {
        var_d530bdb3d172e1cb = itemdef.originx;
      }

      if(isDefined(itemdef.originy)) {
        var_d530bcb3d172df98 = itemdef.originy;
      }

      if(isDefined(itemdef.originz)) {
        var_d530bfb3d172e631 = itemdef.originz;
      }

      offsetrotationx = 0;
      offsetrotationy = 0;
      offsetrotationz = 0;

      if(isDefined(itemdef.rotatex)) {
        offsetrotationx = itemdef.rotatex;
      }

      if(isDefined(itemdef.rotatey)) {
        offsetrotationy = itemdef.rotatey;
      }

      if(isDefined(itemdef.rotatez)) {
        offsetrotationz = itemdef.rotatez;
      }

      level.br_pickups.translationoffset[var_14004b68ddacb781] = (var_d530bdb3d172e1cb, var_d530bcb3d172df98, var_d530bfb3d172e631);
      level.br_pickups.rotationoffset[var_14004b68ddacb781] = (offsetrotationx, offsetrotationy, offsetrotationz);
    }

    level.br_pickups.var_688c9b0a44e4a8ca[var_14004b68ddacb781] = isDefined(itemdef.var_128743b61c17f6b5) && itemdef.var_128743b61c17f6b5 == #"brightGold";
    lootid = itemdef.lootid;

    if(itemtype == #"weapon") {
      raritystring = itemdef.rarity;
      pickupsound = itemdef.pickupsfx;

      if(isDefined(itemdef.baseweapon)) {
        level.var_fb8e78837bc5ee6c[var_14004b68ddacb781] = itemdef.baseweapon;
      }

      lootreference = itemdef.externalreference;

      if(isDefined(lootreference) && lootreference != #"") {
        level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
        level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
      }

      attachmentcount = undefined;

      if(isDefined(lootid) && lootid > 0) {
        weaponroot = function_1cc3fd00b6ccc3ba(lootid);
        assertex(isDefined(weaponroot), "<dev string:x1c>" + lootid);
        variantid = function_64ccc54bdbae5cf6(lootid);
        attachmentlistbundle = itemdef.attachmentlist;
        attachmentlist = getscriptbundle(hashcat(%"hash_6ab26ee9c0dc2c2f", attachmentlistbundle));
        attachmenttoidmap = [];

        if(isDefined(attachmentlist)) {
          foreach(data in attachmentlist.attachment_list) {
            if(isDefined(data.attachmentid)) {
              attachmenttoidmap[data.attachment] = data.attachmentid;
              continue;
            }

            attachmenttoidmap[data.attachment] = 0;
          }

          attachmentcount = attachmentlist.attachment_list.size;
        }

        baseweaponname = weaponroot;
        camo = undefined;

        if(isDefined(itemdef.camo)) {
          camo = itemdef.camo;
        } else {
          camo = function_89383ba5ee5f2b5f(var_14004b68ddacb781, camo);
        }

        if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
          camo = "camo_11a";
        }

        fullweaponobj = undefined;

        if(!isDefined(attachmenttoidmap)) {
          fullweaponobj = weapon::buildweapon_blueprint(weaponroot, camo, undefined, variantid);
        } else {
          fullweaponobj = weapon::buildweapon_attachmentidmap(weaponroot, attachmenttoidmap, camo, undefined, variantid);
        }

        fullweaponname = getcompleteweaponname(fullweaponobj);
      } else {
        baseweaponname = itemdef.baseweapon;
        attachmentlistbundle = itemdef.attachmentlist;
        attachmentlist = getscriptbundle(hashcat(%"hash_6ab26ee9c0dc2c2f", attachmentlistbundle));
        attachmentsarray = [];

        if(isDefined(attachmentlist)) {
          i = 0;

          foreach(data in attachmentlist.attachment_list) {
            if(isDefined(data.attachmentid)) {
              attachmentsarray[i] = data.attachment + "|" + utility::string(data.attachmentid);
            } else {
              attachmentsarray[i] = data.attachment;
            }

            i++;
          }
        }

        if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
          fullweaponobj = weapon::buildweapon(baseweaponname, attachmentsarray, "camo_11a", "none", -1);
        } else {
          camo = function_89383ba5ee5f2b5f(undefined, "none");
          fullweaponobj = weapon::buildweapon(baseweaponname, attachmentsarray, camo, "none", -1);
        }

        fullweaponname = getcompleteweaponname(fullweaponobj);
        variantlootid = loot::getlootidfromref(baseweaponname);

        if(isDefined(variantlootid)) {
          lootidname = "" + variantlootid;
        }
      }

      rarity = itemdef.rarity;
      rarityint = function_ec07a134a6ed91fd(rarity, var_14004b68ddacb781);

      if(rarityint != -1) {
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = rarityint;

        if(!isDefined(level.br_pickups.var_692e058f97bcc055[rarityint])) {
          level.br_pickups.var_692e058f97bcc055[rarityint] = [];
        }

        level.br_pickups.var_692e058f97bcc055[rarityint][level.br_pickups.var_692e058f97bcc055[rarityint].size] = var_14004b68ddacb781;
      }

      level.br_pickups.br_itemtype[var_14004b68ddacb781] = itemtype;
      level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = pickupsound;
      level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = var_14004b68ddacb781;
      level.br_lootiteminfo[var_14004b68ddacb781] = spawnStruct();
      level.br_lootiteminfo[var_14004b68ddacb781].baseweapon = baseweaponname;
      level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname = fullweaponname;
      level.br_lootiteminfo[var_14004b68ddacb781].fullweaponobj = fullweaponobj;

      if(isDefined(attachmentcount)) {
        level.br_lootiteminfo[var_14004b68ddacb781].attachmentcount = attachmentcount;
      }

      if(isDefined(rarityint)) {
        if(rarityint != 10) {
          level.br_pickups.br_weapontoscriptable[fullweaponname] = var_14004b68ddacb781;
          level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = lootid;
          level.br_pickups.var_b13dc7e63676bbe7[lootid] = var_14004b68ddacb781;
        }
      }

      gametype = game_utility::getsubgametype();
      var_dbd4af6757751f2c = hashcat(#"no", gametype);
      itemdefname = level.var_ca63cdc28149e3b5[itemdef.name];

      if(isDefined(itemdefname) && isDefined(var_dbd4af6757751f2c)) {
        tagvalue = getscriptbundlefieldvalue(hashcat(%"loot_item_def:", itemdefname), var_dbd4af6757751f2c);

        if(isDefined(tagvalue) && tagvalue == 0 || !isDefined(tagvalue)) {
          if(isDefined(itemdef.baseweaponmp) && itemdef.baseweaponmp != "") {
            level.br_pickups.var_9e78b5ee377070a9[fullweaponname] = var_14004b68ddacb781;
          }
        }
      }
    } else {
      if(isDefined(itemdef.baseweapon) && itemdef.baseweapon == "equip_mutant_emp_ball_jup_mp" && function_d75b73c443421047()) {
        equipname = "equip_mutant_emp_ball";
      } else {
        equipname = itemdef.baseweapon;
      }

      if(isDefined(equipname) && equipname != "") {
        level.br_pickups.br_equipname[var_14004b68ddacb781] = equipname;
        level.br_pickups.br_equipnametoscriptable[equipname] = var_14004b68ddacb781;

        if(itemtype == #"lethal" || itemtype == #"tactical") {
          level.var_fb8e78837bc5ee6c[var_14004b68ddacb781] = equipname;
        }
      }

      var_54e2cc4157b862bd = itemdef.slotoverride;

      if(isDefined(var_54e2cc4157b862bd) && var_54e2cc4157b862bd != #"none") {
        if(var_54e2cc4157b862bd == #"lethal") {
          if(isDefined(equipname) && equipname != "" && isDefined(level.equipment.table[equipname])) {
            level.equipment.table[equipname].defaultslot = "primary";
          }

          level.br_throwables[level.br_throwables.size] = var_14004b68ddacb781;
        } else if(var_54e2cc4157b862bd == #"tactical") {
          if(isDefined(equipname) && equipname != "" && isDefined(level.equipment.table[equipname])) {
            level.equipment.table[equipname].defaultslot = "secondary";
          }

          level.br_usables[level.br_usables.size] = var_14004b68ddacb781;
        } else if(var_54e2cc4157b862bd == #"heal") {
          if(isDefined(equipname) && equipname != "" && isDefined(level.equipment.table[equipname])) {
            level.equipment.table[equipname].defaultslot = "health";
          }
        } else if(var_54e2cc4157b862bd == #"super") {
          if(isDefined(equipname) && equipname != "" && isDefined(level.equipment.table[equipname])) {
            level.equipment.table[equipname].defaultslot = "super";
          }
        } else {
          assertmsg("<dev string:x3c>" + function_3c8848a3a11b2553(var_14004b68ddacb781) + "<dev string:x62>");
        }
      }

      lootreference = itemdef.externalreference;

      if(isDefined(lootreference) && lootreference != "") {
        level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
        level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
      }

      if(itemtype == #"killstreak" || itemtype == #"killstreak_nodrop") {
        level.br_pickups.br_killstreakreference[var_14004b68ddacb781] = lootreference;
        level.br_pickups.br_killstreaktoscriptable[lootreference] = var_14004b68ddacb781;
      } else if(itemtype == #"super" || itemtype == #"super_nodrop") {
        level.br_pickups.br_superreference[var_14004b68ddacb781] = lootreference;
      } else if(itemtype == #"lethal" || itemtype == #"lethal_nodrop") {
        level.br_pickups.var_1e6c5e03170cf425[level.br_pickups.var_1e6c5e03170cf425.size] = var_14004b68ddacb781;
      } else if(itemtype == #"tactical" || itemtype == #"tactical_nodrop") {
        level.br_pickups.var_eb7725a8a6f2c64c[level.br_pickups.var_eb7725a8a6f2c64c.size] = var_14004b68ddacb781;
      } else if(itemtype == #"perk" || itemtype == #"perk_nodrop") {
        level.br_pickups.br_perks[level.br_pickups.br_perks.size] = var_14004b68ddacb781;
      }

      var_51426ae160732e49 = 0;

      if(isDefined(itemdef.startquantity)) {
        var_51426ae160732e49 = itemdef.startquantity;
      }

      maxstacksize = 0;

      if(isDefined(itemdef.maxstacksize)) {
        maxstacksize = itemdef.maxstacksize;
      }

      var_10a92702735eff08 = 0;

      if(isDefined(itemdef.var_4138f9ddc1cd22d)) {
        var_10a92702735eff08 = itemdef.var_4138f9ddc1cd22d;
      }

      if(itemtype == #"ammo") {
        if(!isDefined(level.br_ammo_max)) {
          br_weapons::br_ammo_init();
        }

        level.br_ammo_max[var_14004b68ddacb781] = maxstacksize;
      }

      level.br_pickups.stackable[var_14004b68ddacb781] = maxstacksize > 1;
      level.br_pickups.counts[var_14004b68ddacb781] = var_51426ae160732e49;
      level.br_pickups.var_4138f9ddc1cd22d[var_14004b68ddacb781] = var_10a92702735eff08;
      level.br_pickups.br_itemtype[var_14004b68ddacb781] = itemtype;
      level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = itemdef.pickupsfx;
      rarityint = function_ec07a134a6ed91fd(itemdef.rarity, var_14004b68ddacb781);

      if(rarityint != -1) {
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = rarityint;
      }

      if(isDefined(lootid) && lootid > 0) {
        level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = lootid;
        level.br_pickups.var_b13dc7e63676bbe7[lootid] = var_14004b68ddacb781;
      }

      if(itemtype == #"breakable_tool") {
        dummyvalue = 1;
        level.var_f2b443c644970bd7[var_14004b68ddacb781] = dummyvalue;
      }
    }

    level.br_pickups.var_c4b4b56c76765330[var_14004b68ddacb781] = itemdef.nospawn;

    if(isDefined(lootid) && lootid > 0 && isDefined(itemdef.var_832ad168567520f7)) {
      level.br_pickups.var_832ad168567520f7[lootid] = itemdef.var_832ad168567520f7;
    }

    if(isDefined(itemdef.var_832ad168567520f7)) {
      level.br_pickups.var_59e01317f76cf924[var_14004b68ddacb781] = itemdef.var_832ad168567520f7;
    }

    if(isDefined(itemdef.var_caf82339100de589)) {
      level.br_pickups.var_caf82339100de589[var_14004b68ddacb781] = itemdef.var_caf82339100de589;
    }

    if(isDefined(itemdef.var_48c246b527477ef8)) {
      level.br_pickups.var_48c246b527477ef8[var_14004b68ddacb781] = itemdef.var_48c246b527477ef8;
    }
  }

  function_2d397216d0fc2167();
  level.var_970f64593dc93ff8 = undefined;
  level.var_ca63cdc28149e3b5 = undefined;
}

function function_2d397216d0fc2167() {
  foreach(scriptablename, itemtype in level.br_pickups.br_itemtype) {
    switch (itemtype) {
      case #"trader":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "trader";
        break;
      case #"cache":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "cache";
        break;
      case #"plea":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "plea";
        break;
      case #"kiosk":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "kiosk";
        break;
      case #"questsafe":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "questsafe";
        break;
      case #"keycard":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "keycard";
        break;
      case #"activitystarter":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "activitystarter";
        break;
      case #"ammo":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "ammo";
        break;
      case #"health":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "health";
        break;
      case #"tablet":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "tablet";
        break;
      case #"attachment":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "attachment";
        break;
      case #"container":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "container";
        break;
      case #"gear":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "gear";
        break;
      case #"super":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "super";
        break;
      case #"valuable":
        level.br_pickups.var_8bc2150d96509171[scriptablename] = "valuable";
        break;
      case #"radio":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "radio";
        break;
      case #"disguise":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "disguise";
        break;
      case #"dogtag":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "dogtag";
        break;
      case #"note":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "note";
        break;
      case #"mission":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "mission";
        break;
      case #"extractable":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "extractable";
        break;
      case #"elite_arrow":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "elite_arrow";
        break;
      case #"exfil":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "exfil";
        break;
      case #"gascan":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "gascan";
        break;
      case #"token":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "token";
        break;
      case #"tactical":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "tactical";
        break;
      case #"key":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "key";
        break;
      case #"killstreak":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "killstreak";
        break;
      case #"nvg":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "nvg";
        break;
      case #"lethal":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "lethal";
        break;
      case #"perk":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "perk";
        break;
      case #"helmet":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "helmet";
        break;
      case #"perkpack":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "perkpack";
        break;
      case #"personal":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "personal";
        break;
      case #"plate_carrier":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "plate_carrier";
        break;
      case #"nodrop":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "nodrop";
        break;
      case #"plunder":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "plunder";
        break;
      case #"trophy":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "trophy";
        break;
      case #"revive":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "revive";
        break;
      case #"voucher":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "voucher";
        break;
      case #"weapon":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "weapon";
        break;
      case #"weaponcase":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "weaponCase";
        break;
      case #"xp":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "xp";
        break;
      case #"restock":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "restock";
        break;
      case #"gametype_item":
        level.br_pickups.var_2d9176b507230cab[scriptablename] = "gametype_item";
        break;
      default:
        println("<dev string:x67>" + function_3c8848a3a11b2553(scriptablename) + "<dev string:x7d>" + function_3c8848a3a11b2553(itemtype) + "<dev string:x62>");
        break;
    }
  }
}

function function_ec07a134a6ed91fd(rarity, var_14004b68ddacb781) {
  rarityint = -1;

  if(isDefined(rarity)) {
    if(rarity == #"common") {
      rarityint = 0;
    } else if(rarity == #"uncommon") {
      rarityint = 1;
    } else if(rarity == #"rare") {
      rarityint = 2;
    } else if(rarity == #"epic") {
      rarityint = 3;
    } else if(rarity == #"legendary") {
      rarityint = 4;
    } else if(rarity == #"ultra") {
      rarityint = 5;
    } else if(rarity == #"playercustom") {
      rarityint = 10;
    } else if(rarity == #"missionobj") {
      rarityint = 11;
    } else if(rarity == #"specialmission") {
      rarityint = 12;
    } else if(rarity == #"reusablecrate") {
      rarityint = 13;
    } else if(rarity == #"personalsupplycache") {
      rarityint = 14;
    } else {
      println("<dev string:x98>" + function_3c8848a3a11b2553(var_14004b68ddacb781) + "<dev string:x62>");
    }
  }

  return rarityint;
}

function function_e5528af9b712723f() {
  level.brloottablename = getDvar(@ "loot_table_name", "mp/loot/br/default/loot_item_defs.csv");

  if(level.brloottablename == "") {
    level.brloottablename = "mp/loot/br/default/loot_item_defs.csv";
  }

  level.var_6178ce645aeeb787 = getDvar(@ "loot_table_zone", "mp/loot/br/default/loot_table_zones.csv");

  if(level.var_6178ce645aeeb787 == "") {
    level.var_6178ce645aeeb787 = "mp/loot/br/default/loot_table_zones.csv";
    setDvar(@ "loot_table_zones", level.var_6178ce645aeeb787);
  }

  var_6a537ee3949585f4 = [];
  var_5c845b7a0ef0780f = 0;
  var_55dff3c24d1396c9 = "+";
  lastrow = tablelookupgetnumrows(level.brloottablename);

  for(row = 0; row < lastrow; row++) {
    key = tablelookupbyrow(level.brloottablename, row, 0);

    if(!isDefined(key)) {
      continue;
    }

    if(key == "item") {
      itemtype = tablelookupbyrow(level.brloottablename, row, 2);

      if(!isDefined(itemtype)) {
        continue;
      }

      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      itemvalue = tablelookupbyrow(level.brloottablename, row, 7);
      level.br_pickups.br_value[var_14004b68ddacb781] = int(itemvalue);
      lootidname = tablelookupbyrow(level.brloottablename, row, 5);
      var_2ad07b9c3adc39e3 = int(tablelookupbyrow(level.brloottablename, row, 17));
      level.br_pickups.maxcounts[var_14004b68ddacb781] = var_2ad07b9c3adc39e3;
      level.br_pickups.br_hasautopickup[var_14004b68ddacb781] = int(tablelookupbyrow(level.brloottablename, row, 20));
      level.br_pickups.br_itemrow[var_14004b68ddacb781] = int(row);
      var_a38e261031751c09 = tablelookupbyrow(level.brloottablename, row, 33);

      if(var_a38e261031751c09 != "") {
        level.br_pickups.var_b8fad1cfd41d21da[var_14004b68ddacb781] = int(var_a38e261031751c09);
      }

      var_52e1d38987af61c3 = tablelookupbyrow(level.brloottablename, row, 34);
      level.br_pickups.var_a5e4b146866d7fd[var_14004b68ddacb781] = isDefined(var_52e1d38987af61c3) && var_52e1d38987af61c3 != "";
      notetext = tablelookupbyrow(level.brloottablename, row, 32);
      level.br_pickups.var_4183295edcc21db0[var_14004b68ddacb781] = isDefined(notetext) && notetext != &"";

      if(itemtype != "tablet") {
        var_d530bdb3d172e1cb = float(tablelookupbyrow(level.brloottablename, row, 21));
        var_d530bcb3d172df98 = float(tablelookupbyrow(level.brloottablename, row, 22));
        var_d530bfb3d172e631 = float(tablelookupbyrow(level.brloottablename, row, 23));
        offsetrotationx = float(tablelookupbyrow(level.brloottablename, row, 24));
        offsetrotationy = float(tablelookupbyrow(level.brloottablename, row, 25));
        offsetrotationz = float(tablelookupbyrow(level.brloottablename, row, 26));
        level.br_pickups.translationoffset[var_14004b68ddacb781] = (var_d530bdb3d172e1cb, var_d530bcb3d172df98, var_d530bfb3d172e631);
        level.br_pickups.rotationoffset[var_14004b68ddacb781] = (offsetrotationx, offsetrotationy, offsetrotationz);
      }

      level.br_pickups.var_688c9b0a44e4a8ca[var_14004b68ddacb781] = tablelookupbyrow(level.brloottablename, row, 28) == "brightGold";

      if(itemtype == "weapon") {
        raritystring = tablelookupbyrow(level.brloottablename, row, 3);
        pickupsound = tablelookupbyrow(level.brloottablename, row, 14);
        lootreference = tablelookupbyrow(level.brloottablename, row, 18);

        if(isDefined(lootreference) && lootreference != "") {
          level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
          level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
        }

        if(isDefined(lootidname) && lootidname.size > 0) {
          lootid = int(lootidname);
          weaponroot = function_1cc3fd00b6ccc3ba(lootid);
          var_25152a36c536d7f = loot::function_793e8a72cedb8ef3(lootid);
          var_655be453564ea032 = weapon::getweaponvarianttablename(weaponroot);

          if(getDvar(@ "hash_9cc91f7c70752fa7", "1") == "1") {
            weaponroot = tablelookupbyrow(level.brloottablename, row, 8);
            variantid = 0;
          } else {
            variantid = int(tablelookup(var_655be453564ea032, 1, var_25152a36c536d7f, 0));
          }

          attachmentsstring = tablelookupbyrow(level.brloottablename, row, 9);
          attachmentsarray = [];
          attachmenttoidmap = [];

          if(isDefined(attachmentsstring) && attachmentsstring.size) {
            attachmentsarray = strtok(attachmentsstring, var_55dff3c24d1396c9);
          }

          if(isDefined(attachmentsarray)) {
            foreach(attach in attachmentsarray) {
              array = strtok(attach, "|");

              if(array.size > 1) {
                attachmenttoidmap[array[0]] = int(array[1]);
                continue;
              }

              attachmenttoidmap[array[0]] = 0;
            }
          }

          baseweaponname = weaponroot;
          camo = undefined;
          fullweaponname = tablelookupbyrow(level.brloottablename, row, 10);
          parts = strtok(fullweaponname, "+");

          foreach(part in parts) {
            if(getsubstr(part, 0, 4) == "camo") {
              camo = strtok(part, "|")[1];
            }
          }

          if(!isDefined(camo)) {
            camo = function_89383ba5ee5f2b5f(lootreference, camo);
          }

          if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
            camo = "camo_11a";
          }

          fullweaponobj = undefined;

          if(!isDefined(attachmenttoidmap)) {
            fullweaponobj = weapon::buildweapon_blueprint(weaponroot, camo, undefined, variantid);
          } else {
            fullweaponobj = weapon::buildweapon_attachmentidmap(weaponroot, attachmenttoidmap, camo, undefined, variantid);
          }

          fullweaponname = getcompleteweaponname(fullweaponobj);

          if(getDvar(@ "hash_9cc91f7c70752fa7", "1") != "1") {
            weaponrarity = "<dev string:xbe>";
            titlestring = tablelookupbyrow(level.brloottablename, row, 11);
            descstring = tablelookup(var_655be453564ea032, 1, var_25152a36c536d7f, 17);
            icon = weapon::function_b8811a0fc04e4b9d(weaponroot, #"image", "<dev string:xc3>");
            attachmentsall = weapon::weaponattachcustomtoidmap(weaponroot, variantid);
            attachmentsdefault = weapon::weaponattachdefaulttoidmap(weaponroot, variantid);
            attachmentsstring = "<dev string:xc3>";

            if(isDefined(attachmentsall)) {
              foreach(key, aid in attachmentsall) {
                if(isDefined(attachmentsdefault) && isDefined(attachmentsdefault[key])) {
                  continue;
                }

                if(attachmentsstring != "<dev string:xc3>") {
                  attachmentsstring += var_55dff3c24d1396c9;
                }

                attachmentsstring += key;
              }
            }

            var_6a537ee3949585f4[var_6a537ee3949585f4.size] = weapon::function_13aeabbe4210eadc(var_14004b68ddacb781, weaponrarity, lootid, baseweaponname, attachmentsstring, fullweaponname, titlestring, descstring, icon, pickupsound);
            var_287363cd98ae15a8 = tablelookupbyrow(level.brloottablename, row, 8);
            var_361a437d788f1ff4 = tablelookupbyrow(level.brloottablename, row, 11);
            var_2278b4e29d8c7ddd = tablelookupbyrow(level.brloottablename, row, 13);

            if(raritystring != weaponrarity) {
              var_5c845b7a0ef0780f = 1;
            }

            if(var_287363cd98ae15a8 != baseweaponname) {
              println("<dev string:xc7>" + var_14004b68ddacb781 + "<dev string:xf6>" + var_287363cd98ae15a8 + "<dev string:xfd>" + baseweaponname + "<dev string:x107>");
              var_5c845b7a0ef0780f = 1;
            }

            if(var_361a437d788f1ff4 != fullweaponname) {
              println("<dev string:x10c>" + var_14004b68ddacb781 + "<dev string:xf6>" + var_361a437d788f1ff4 + "<dev string:xfd>" + fullweaponname + "<dev string:x107>");
              var_5c845b7a0ef0780f = 1;
            }

            if(var_2278b4e29d8c7ddd != icon) {
              println("<dev string:x13b>" + var_14004b68ddacb781 + "<dev string:xf6>" + var_2278b4e29d8c7ddd + "<dev string:xfd>" + icon + "<dev string:x107>");
              var_5c845b7a0ef0780f = 1;
            }
          }
        } else {
          baseweaponname = tablelookupbyrow(level.brloottablename, row, 8);
          attachmentsstring = tablelookupbyrow(level.brloottablename, row, 9);
          attachmentsarray = [];

          if(isDefined(attachmentsstring) && attachmentsstring.size) {
            attachmentsarray = strtok(attachmentsstring, var_55dff3c24d1396c9);
          }

          if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
            fullweaponobj = weapon::buildweapon(baseweaponname, attachmentsarray, "camo_11a", "none", -1);
          } else {
            camo = function_89383ba5ee5f2b5f(undefined, "none");
            fullweaponobj = weapon::buildweapon(baseweaponname, attachmentsarray, camo, "none", -1);
          }

          fullweaponname = getcompleteweaponname(fullweaponobj);
          variantlootid = loot::getlootidfromref(baseweaponname);

          if(isDefined(variantlootid)) {
            lootidname = "" + variantlootid;
          }

          if(int(raritystring) != 10) {
            titlestring = tablelookupbyrow(level.brloottablename, row, 11);
            icon = tablelookupbyrow(level.brloottablename, row, 13);
            var_6a537ee3949585f4[var_6a537ee3949585f4.size] = weapon::function_13aeabbe4210eadc(var_14004b68ddacb781, raritystring, "<dev string:xc3>", baseweaponname, attachmentsstring, fullweaponname, titlestring, &"<dev string:xc3>", icon, pickupsound);
            var_361a437d788f1ff4 = tablelookupbyrow(level.brloottablename, row, 10);

            if(var_361a437d788f1ff4 != fullweaponname) {
              println("<dev string:x10c>" + var_14004b68ddacb781 + "<dev string:xf6>" + var_361a437d788f1ff4 + "<dev string:xfd>" + fullweaponname + "<dev string:x107>");
            }
          }

        }

        rarityint = int(raritystring);
        level.br_pickups.br_itemtype[var_14004b68ddacb781] = function_1823ff50bb28148d(itemtype);
        level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = function_1823ff50bb28148d(pickupsound);
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = rarityint;
        level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = var_14004b68ddacb781;

        if(!isDefined(level.br_pickups.var_692e058f97bcc055[rarityint])) {
          level.br_pickups.var_692e058f97bcc055[rarityint] = [];
        }

        level.br_pickups.var_692e058f97bcc055[rarityint][level.br_pickups.var_692e058f97bcc055[rarityint].size] = var_14004b68ddacb781;
        level.br_lootiteminfo[var_14004b68ddacb781] = spawnStruct();
        level.br_lootiteminfo[var_14004b68ddacb781].baseweapon = baseweaponname;
        level.br_lootiteminfo[var_14004b68ddacb781].fullweaponname = fullweaponname;
        level.br_lootiteminfo[var_14004b68ddacb781].fullweaponobj = fullweaponobj;

        if(rarityint != 10) {
          level.br_pickups.br_weapontoscriptable[fullweaponname] = var_14004b68ddacb781;
          level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = int(lootidname);
          level.br_pickups.var_b13dc7e63676bbe7[int(lootidname)] = var_14004b68ddacb781;
        }

        if(function_d9da779938ebcd86(row)) {
          level.br_pickups.var_9e78b5ee377070a9[fullweaponname] = var_14004b68ddacb781;
        }
      } else {
        equipname = tablelookupbyrow(level.brloottablename, row, 8);

        if(isDefined(equipname) && equipname.size > 0) {
          equipname = tolower(equipname);
          level.br_pickups.br_equipname[var_14004b68ddacb781] = equipname;
          level.br_pickups.br_equipnametoscriptable[equipname] = var_14004b68ddacb781;
        }

        var_54e2cc4157b862bd = tablelookupbyrow(level.brloottablename, row, 15);

        if(var_54e2cc4157b862bd != "") {
          switch (var_54e2cc4157b862bd) {
            case #"hash_31100fbc01bd387c":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname])) {
                level.equipment.table[equipname].defaultslot = "primary";
              }

              level.br_throwables[level.br_throwables.size] = var_14004b68ddacb781;
              break;
            case #"hash_311012bc01bd3d35":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname])) {
                level.equipment.table[equipname].defaultslot = "secondary";
              }

              level.br_usables[level.br_usables.size] = var_14004b68ddacb781;
              break;
            case #"hash_311011bc01bd3ba2":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname])) {
                level.equipment.table[equipname].defaultslot = "health";
              }

              break;
            case #"hash_31100cbc01bd33c3":
              if(isDefined(equipname) && equipname.size > 0 && isDefined(level.equipment.table[equipname])) {
                level.equipment.table[equipname].defaultslot = "super";
              }

              break;
            default:
              assertmsg("<dev string:x160>" + var_14004b68ddacb781 + "<dev string:x62>");
              break;
          }
        }

        lootreference = tablelookupbyrow(level.brloottablename, row, 18);

        if(isDefined(lootreference) && lootreference != "") {
          level.br_pickups.var_14bd11727c4b6629[var_14004b68ddacb781] = lootreference;
          level.br_pickups.var_838863c4848d4c26[lootreference] = var_14004b68ddacb781;
        }

        if(itemtype == "killstreak" || itemtype == "killstreak_nodrop") {
          brkillstreakreference = tablelookupbyrow(level.brloottablename, row, 18);
          level.br_pickups.br_killstreakreference[var_14004b68ddacb781] = brkillstreakreference;
          level.br_pickups.br_killstreaktoscriptable[brkillstreakreference] = var_14004b68ddacb781;
        } else if(itemtype == "super" || itemtype == "super_nodrop") {
          brsuperreference = tablelookupbyrow(level.brloottablename, row, 18);
          level.br_pickups.br_superreference[var_14004b68ddacb781] = brsuperreference;
        } else if(itemtype == "lethal" || itemtype == "lethal_nodrop") {
          level.br_pickups.var_1e6c5e03170cf425[level.br_pickups.var_1e6c5e03170cf425.size] = var_14004b68ddacb781;
        } else if(itemtype == "tactical" || itemtype == "tactical_nodrop") {
          level.br_pickups.var_eb7725a8a6f2c64c[level.br_pickups.var_eb7725a8a6f2c64c.size] = var_14004b68ddacb781;
        } else if(itemtype == "perk" || itemtype == "perk_nodrop") {
          level.br_pickups.br_perks[level.br_pickups.br_perks.size] = var_14004b68ddacb781;
        }

        var_51426ae160732e49 = int(tablelookupbyrow(level.brloottablename, row, 4));
        var_10a92702735eff08 = int(tablelookupbyrow(level.brloottablename, row, 27));

        if(itemtype == "ammo") {
          if(!isDefined(level.br_ammo_max)) {
            br_weapons::br_ammo_init();
          }

          level.br_ammo_max[var_14004b68ddacb781] = var_2ad07b9c3adc39e3;
        }

        level.br_pickups.stackable[var_14004b68ddacb781] = var_2ad07b9c3adc39e3 > 1;
        level.br_pickups.counts[var_14004b68ddacb781] = var_51426ae160732e49;
        level.br_pickups.var_4138f9ddc1cd22d[var_14004b68ddacb781] = var_10a92702735eff08;
        itemtype = tolower(itemtype);
        level.br_pickups.br_itemtype[var_14004b68ddacb781] = function_1823ff50bb28148d(itemtype);
        level.br_pickups.br_pickupsfx[var_14004b68ddacb781] = function_1823ff50bb28148d(tablelookupbyrow(level.brloottablename, row, 14));
        raritynum = tablelookupbyrow(level.brloottablename, row, 3);
        level.br_pickups.br_itemrarity[var_14004b68ddacb781] = int(raritynum);

        if(isDefined(lootidname) && lootidname != "") {
          level.br_pickups.var_7b2bff2d04ee1017[var_14004b68ddacb781] = int(lootidname);
          level.br_pickups.var_b13dc7e63676bbe7[int(lootidname)] = var_14004b68ddacb781;
        }

        if(itemtype == "breakable_tool") {
          dummyvalue = 1;
          level.var_f2b443c644970bd7[var_14004b68ddacb781] = dummyvalue;
        }
      }

      tags = tablelookupbyrow(level.brloottablename, row, 6);
      tags = strtok(tags, "&");
      level.br_pickups.var_c4b4b56c76765330[var_14004b68ddacb781] = utility::array_contains(tags, "noSpawn");
      continue;
    }

    if(key == "crate") {
      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      cratechance = int(tablelookupbyrow(level.brloottablename, row, 2));

      if(cratechance > 0) {
        if(isDefined(level.br_lootiteminfo[var_14004b68ddacb781]) && isDefined(level.br_lootiteminfo[var_14004b68ddacb781].baseweapon)) {
          for(i = 0; i < cratechance; i++) {
            level.br_pickups.br_crateguns[level.br_pickups.br_crateguns.size] = var_14004b68ddacb781;
            level.br_pickups.br_allguns[level.br_pickups.br_allguns.size] = var_14004b68ddacb781;
          }
        } else {
          for(i = 0; i < cratechance; i++) {
            level.br_pickups.br_crateitems[level.br_pickups.br_crateitems.size] = var_14004b68ddacb781;
          }
        }
      }

      continue;
    }

    if(key == "gulag") {
      var_14004b68ddacb781 = tablelookupbyrow(level.brloottablename, row, 1);
      pickupclass = tablelookupbyrow(level.brloottablename, row, 2);

      if(!isDefined(level.br_pickups.br_gulagpickups[pickupclass])) {
        level.br_pickups.br_gulagpickups[pickupclass] = [];
      }

      count = level.br_pickups.br_gulagpickups[pickupclass].size;
      level.br_pickups.br_gulagpickups[pickupclass][count] = var_14004b68ddacb781;
      continue;
    }

    if(!isDefined(level.br_pickups.var_11feb85e78e7cee8) && (key == "depends" || key == "inheritDepends")) {
      level.br_pickups.var_11feb85e78e7cee8 = row;
    }
  }
}

function function_f8b204e807cc62ed() {
  level.var_81369e82645391f0 = [];
  var_3c7f6558e5171cfc = getDvar(@ "hash_dd0e2df8833b28d8", "mp/automatism/weapon_class_groups_for_auto_grab.csv");
  var_3cfaae92e4bb0d04 = tablelookupgetnumrows(var_3c7f6558e5171cfc);

  for(row = 0; row < var_3cfaae92e4bb0d04; row++) {
    weaponclass = tablelookupbyrow(var_3c7f6558e5171cfc, row, 0);
    groupindex = int(tablelookupbyrow(var_3c7f6558e5171cfc, row, 1));
    level.var_81369e82645391f0[weaponclass] = groupindex;
  }
}

function function_e6cabc9f20dcbc23() {
  if(isDefined(level.br_standard_loadout)) {
    level.var_ea84a0518343879c["primary"] = function_78ad8eb4cc92f407(level.br_standard_loadout, "Primary");
    level.var_ea84a0518343879c["secondary"] = function_78ad8eb4cc92f407(level.br_standard_loadout, "Secondary");
  }
}

function function_23a8498a6613de14() {
  level.var_f67907afe56c4f82 = [];

  if(istrue(level.usegulag)) {
    assert(isDefined(level.gulagloadouts));
    var_f070698d508b0818 = [];
    var_23182e0fd5672080 = getDvar(@ "hash_d07965da1789dea1", "mp/automatism/initial_slot_after_gulag_base_weapons_table.csv");

    if(tableexists(var_23182e0fd5672080)) {
      rowscount = tablelookupgetnumrows(var_23182e0fd5672080);

      for(row = 0; row < rowscount; row++) {
        baseweaponname = tablelookupbyrow(var_23182e0fd5672080, row, 0);
        var_f070698d508b0818[row] = baseweaponname;
      }

      count = level.gulagloadouts.size;

      for(index = 0; index < count; index++) {
        var_bc095883aece1a82 = function_78ad8eb4cc92f407(level.gulagloadouts[index], "Primary");
        var_cc63cd9ec88314c2 = function_78ad8eb4cc92f407(level.gulagloadouts[index], "Secondary");
        function_5d9ef63de8747c32(var_bc095883aece1a82, var_f070698d508b0818);
        function_5d9ef63de8747c32(var_cc63cd9ec88314c2, var_f070698d508b0818);
      }
    }
  }
}

function function_d9da779938ebcd86(row) {
  var_8677e2501bd28313 = tablelookupbyrow(level.brloottablename, row, 10);

  if(!isDefined(var_8677e2501bd28313) || var_8677e2501bd28313 == "") {
    return false;
  }

  tags = tablelookupbyrow(level.brloottablename, row, 6);
  tags = strtok(tags, "&");
  gametype = getsubgametype();
  return !array_contains(tags, "no" + gametype);
}

function function_32a0394cf13c8b29() {
  var_bb4c023dc74082df = "lootvalueoverride:" + getDvar(@ "hash_7feb156ccfaf8ddf", "");
  bundle = getscriptbundle(function_40fd49171fad19d3(var_bb4c023dc74082df));

  if(!isDefined(bundle)) {
    return;
  }

  foreach(var_345386aa7c1afe54 in bundle.var_2eaf4feeef5cefc5) {
    ref = var_345386aa7c1afe54.itemref;

    if(isDefined(level.br_pickups.br_value[ref])) {
      level.br_pickups.br_value[ref] = int(var_345386aa7c1afe54.overridevalue);
    }
  }
}

function function_5d9ef63de8747c32(weaponobj, var_f070698d508b0818) {
  baseweaponname = weapon::getweaponrootname(weaponobj);
  count = var_f070698d508b0818.size;

  for(index = 0; index < count; index++) {
    if(var_f070698d508b0818[index] == baseweaponname && !function_2166628459c78e7a(weaponobj)) {
      level.var_f67907afe56c4f82[level.var_f67907afe56c4f82.size] = weaponobj;
      break;
    }
  }
}

function function_2166628459c78e7a(weaponobj) {
  hasweapon = 0;
  count = level.var_f67907afe56c4f82.size;

  for(index = 0; !hasweapon && index < count; index++) {
    hasweapon = issameweapon(level.var_f67907afe56c4f82[index], weaponobj);
  }

  return hasweapon;
}

function function_78ad8eb4cc92f407(loadout, slotstring) {
  maxattachments = 0;

  if(slotstring == "Primary") {
    maxattachments = 7;
  } else if(slotstring == "Secondary") {
    maxattachments = 7;
  } else {
    assertmsg("<dev string:x194>" + slotstring + "<dev string:x1a5>");
  }

  basestring = "loadout" + slotstring;
  weaponattachments = [];
  var_e7cc1946fb89afaa = [];
  var_6c2bfd3d88f9e18c = basestring + "Attachment";
  var_6d728bae3e54774a = "";

  for(attachmentindex = 0; attachmentindex < maxattachments; attachmentindex++) {
    if(attachmentindex != 0) {
      var_6d728bae3e54774a = var_6c2bfd3d88f9e18c + attachmentindex + 1;
    } else {
      var_6d728bae3e54774a = var_6c2bfd3d88f9e18c;
    }

    if(isDefined(loadout[var_6d728bae3e54774a])) {
      weaponattachments[attachmentindex] = loadout[var_6d728bae3e54774a];
      var_e7cc1946fb89afaa[attachmentindex] = 0;
    }
  }

  return weapon::buildweapon(loadout[basestring], weaponattachments, loadout[basestring + "Camo"], loadout[basestring + "Reticle"], loadout[basestring + "VariantID"], var_e7cc1946fb89afaa);
}

function overrideitemcount(scriptablename, itemcount) {
  if(isDefined(level.br_pickups.counts[scriptablename]) && isDefined(itemcount)) {
    level.br_pickups.counts[scriptablename] = itemcount;
  }
}

function function_d2d7b153b9d3889e(index, name, start, end, traceresults) {
  var_a16891a5162df351 = 2000;

  if(traceresults["<dev string:x1ce>"] < 1) {
    line(start, traceresults["<dev string:x1da>"], (1, 0, 0), 1, 0, var_a16891a5162df351);

    if(isDefined(traceresults["<dev string:x1e6>"])) {
      selectedentity = traceresults["<dev string:x1e6>"];
      println("<dev string:x1f0>" + index + "<dev string:x202>" + name + "<dev string:x208>" + traceresults["<dev string:x1ce>"] + "<dev string:x211>" + traceresults["<dev string:x1da>"] + "<dev string:x219>" + utility::default_to(selectedentity.name, "<dev string:x222>"));
    } else {
      println("<dev string:x1f0>" + index + "<dev string:x202>" + name + "<dev string:x208>" + traceresults["<dev string:x1ce>"] + "<dev string:x211>" + traceresults["<dev string:x1da>"]);
    }

    return;
  }

  println("<dev string:x1f0>" + index + "<dev string:x202>" + name + "<dev string:x22f>");
  line(start, end, (1, 1, 1), 1, 0, var_a16891a5162df351);
}

function getitemdropinfo(origin, angles, payload, groundentity) {
  assert(isDefined(origin));
  dropinfo = spawnStruct();
  dropinfo.origin = origin;

  if(isDefined(angles)) {
    dropinfo.angles = angles;
  } else {
    dropinfo.angles = (0, 0, 0);
  }

  if(isDefined(payload)) {
    dropinfo.payload = payload;
  } else {
    dropinfo.payload = 0;
  }

  dropinfo.groundentity = groundentity;
  return dropinfo;
}

function function_78ca4cfbcb159de2(baseorigin, dropdata, traceresults) {
  var_fafd64b272244139 = getlootscriptablearrayinradius(undefined, undefined, baseorigin, dropdata.dist + level.var_43c2a465029a4684);

  if(isDefined(var_fafd64b272244139) && var_fafd64b272244139.size > 0) {
    foreach(scriptable in var_fafd64b272244139) {
      if(!isDefined(scriptable.origin)) {
        continue;
      }

      if(distance2d(traceresults["position"], scriptable.origin) < level.var_43c2a465029a4684) {
        return true;
      }
    }
  }

  return false;
}

function function_7bf5ea7dd272db77(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9) {
  tracestart = baseorigin + (0, 0, 21);
  wallgrace = dropdata.dir * 18;
  traceend = dropdata.outorigin + wallgrace + (0, 0, 21 + level.var_42eb4fb7558dc1ec);
  traceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:x23b>", tracestart, traceend, traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"];
  } else {
    dropdata.outorigin = traceend;
  }

  dropdata.outorigin -= wallgrace;
  heightchecks = getdvarint(@ "hash_3ca29b429f678228", 1);

  for(check = 0; check < heightchecks; check++) {
    tracestart += (0, 0, 10 * check);
    hightraceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

    if(hightraceresults["fraction"] < traceresults["fraction"]) {
      traceresults["fraction"] = -1;
    }
  }

  return traceresults;
}

function function_3f0ce5cf3481f56c(dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, retries, var_daa047868cf7a01b, var_551904951118b7b9, var_43ee1b505fc4c4ed, var_93a7b81154b71c0e) {
  var_a9d5ad9414f5ecb7 = 9;
  slot_yaw = 360 / var_a9d5ad9414f5ecb7;

  if(!istrue(var_43ee1b505fc4c4ed) && istrue(var_93a7b81154b71c0e)) {
    slot_yaw = level.var_7f82d2e3f2ef4402;
  }

  initialring = dropdata.ring;
  initialslot = dropdata.slot;
  initialyaw = dropdata.yaw;
  initialdist = dropdata.dist;
  initialdir = dropdata.dir;
  var_f4a31528787ae6bd = dropdata.outangles;
  var_9bd3420d924c5c43 = dropdata.outorigin;

  for(attempts = 0; attempts < retries; attempts++) {
    dropstruct.dropidx++;
    dropdata.ring = int(dropstruct.dropidx / var_a9d5ad9414f5ecb7);
    dropdata.slot = dropstruct.dropidx - dropdata.ring * var_a9d5ad9414f5ecb7;
    dropdata.yaw = baseangles[1] + dropdata.slot * slot_yaw + dropdata.ring * 10 + randomfloatrange(-5, 5);
    dropdata.dist = 60 + dropdata.ring * 35 + randomfloatrange(-5, 5);
    dropdata.outangles = (0, dropdata.yaw, 0);
    dropdata.dir = anglesToForward(dropdata.outangles);
    dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;
    traceresults = function_7bf5ea7dd272db77(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9);
    var_93a7b81154b71c0e = function_78ca4cfbcb159de2(baseorigin, dropdata, traceresults);

    if(traceresults["fraction"] >= var_daa047868cf7a01b && !var_93a7b81154b71c0e) {
      return;
    }
  }

  dropdata.ring = initialring;
  dropdata.slot = initialslot;
  dropdata.yaw = initialyaw;
  distancescalar = var_93a7b81154b71c0e ? 3 : 1;
  dropdata.dist = initialdist / distancescalar;
  dropdata.dir = initialdir;
  dropdata.outangles = var_f4a31528787ae6bd;
  dropdata.outorigin = var_9bd3420d924c5c43;
}

function function_28cd87cdbae45940(dropstruct, dropdata, ignoreent, tracecontents, var_551904951118b7b9) {
  tracestart = dropdata.outorigin;
  traceend = dropdata.outorigin + (0, 0, 60);
  traceresults = trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:x241>", tracestart + (0, 1, 0), traceend + (0, 1, 0), traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"] + (0, 0, -6);
  } else {
    dropdata.outorigin = traceend;
  }

  return traceresults;
}

function function_bd56d40fa4e7a1e3(dropstruct, dropdata, ignoreent, tracecontents, groundfloat, var_29a915f667b07b0f, var_551904951118b7b9) {
  tracestart = dropdata.outorigin;
  traceheight = default_to(var_29a915f667b07b0f, getdvarfloat(@ "hash_b91d6bc7e0694ac", 2000));
  var_3a7f0173b03f5767 = -1 * traceheight;
  traceend = dropdata.outorigin + (0, 0, var_3a7f0173b03f5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreent, tracecontents);

  if(var_551904951118b7b9) {
    function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:x247>", tracestart, traceend, traceresults);
  }

  if(traceresults["fraction"] < 1) {
    dropdata.outorigin = traceresults["position"] + (0, 0, groundfloat);
    dropdata.groundentity = traceresults["entity"];

    if(isDefined(dropdata.groundentity) && (istrue(dropdata.groundentity.isdestroyed) || istrue(dropdata.groundentity.burningdown) || dropdata.groundentity scripts\cp_mp\vehicles\vehicle::function_794b5f886cced2d0())) {
      ignorelist = [dropdata.groundentity];

      if(isDefined(ignoreent)) {
        ignorelist[ignorelist.size] = ignoreent;
      }

      traceresults = scripts\engine\trace::ray_trace(dropdata.outorigin, traceend, ignorelist, tracecontents);

      if(var_551904951118b7b9) {
        function_d2d7b153b9d3889e(dropstruct.dropidx, "<dev string:x24d>", dropdata.outorigin, traceend, traceresults);
      }

      if(traceresults["fraction"] < 1) {
        dropdata.outorigin = traceresults["position"] + (0, 0, groundfloat);
        dropdata.groundentity = traceresults["entity"];
      } else {
        if(var_551904951118b7b9) {
          println("<dev string:x1f0>" + dropstruct.dropidx + "<dev string:x254>");
        }

        dropdata.outorigin = (0, 0, 0);
        dropdata.noground = 1;
      }
    }
  } else {
    if(var_551904951118b7b9) {
      println("<dev string:x1f0>" + dropstruct.dropidx + "<dev string:x254>");
    }

    dropdata.outorigin = (0, 0, 0);
    dropdata.noground = 1;
  }

  return traceresults;
}

function getitemdroporiginandangles(dropstruct, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, var_f71d4f78d508da69, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44, overrideorigin, var_29a915f667b07b0f, var_688e4da4cb16116d) {
  assert(!isDefined(ignoreent) || isent(ignoreent));
  var_a9d5ad9414f5ecb7 = 9;

  if(isDefined(dropstruct.var_fb6b5e268e9a52de) && dropstruct.var_fb6b5e268e9a52de > 0) {
    var_a9d5ad9414f5ecb7 = dropstruct.var_fb6b5e268e9a52de;
  }

  slot_yaw = 360 / var_a9d5ad9414f5ecb7;
  var_551904951118b7b9 = getdvarint(@ "hash_d7613094ea4ba91f", 0);
  var_ab9f50e5b2c2e07e = ter_op(isDefined(dropstruct.var_d1e7ececee01c6d5), dropstruct.var_d1e7ececee01c6d5, -5);
  var_ab7c62e5b29cc05c = ter_op(isDefined(dropstruct.var_d20ad6ecee27de2b), dropstruct.var_d20ad6ecee27de2b, 5);
  var_b57e08395cbe94d2 = 40;

  if(isDefined(ignoreent) && isent(ignoreent) && isPlayer(ignoreent) && player::isreallyalive(ignoreent)) {
    currentstance = ignoreent getstance();

    if(currentstance == "crouch") {
      var_b57e08395cbe94d2 = 20;
    } else if(currentstance == "prone") {
      var_b57e08395cbe94d2 = 10;
    }
  }

  dropdata = spawnStruct();
  dropdata.noground = 0;
  dropdata.payload = 0;
  dropdata.groundentity = undefined;

  if(!isDefined(baseangles)) {
    baseangles = (0, 0, 0);
  }

  groundfloat = 0;

  if(isDefined(var_6fe2ff802d5192d4)) {
    groundfloat = var_6fe2ff802d5192d4;
  }

  dropdata.ring = int(dropstruct.dropidx / var_a9d5ad9414f5ecb7);
  dropdata.slot = dropstruct.dropidx - dropdata.ring * var_a9d5ad9414f5ecb7;
  var_6ee1efe1b9856dde = 0;

  if(var_ab9f50e5b2c2e07e != var_ab7c62e5b29cc05c) {
    var_6ee1efe1b9856dde = randomfloatrange(var_ab9f50e5b2c2e07e, var_ab7c62e5b29cc05c);
  }

  dropdata.yaw = baseangles[1] + dropdata.slot * slot_yaw + dropdata.ring * 10 + var_6ee1efe1b9856dde;
  dropdata.dist = 60 + dropdata.ring * 35 + randomfloatrange(-5, 5);

  if(isDefined(var_8a600b6102da9f9b)) {
    dropdata.yaw = baseangles[1] + var_8a600b6102da9f9b;
  }

  if(isDefined(var_f71d4f78d508da69)) {
    dropdata.dist = var_f71d4f78d508da69;
  }

  dropdata.outangles = (0, dropdata.yaw, 0);
  dropdata.dir = anglesToForward(dropdata.outangles);
  dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;

  if(isDefined(overrideorigin)) {
    dropdata.outorigin = overrideorigin;
  }

  if(true) {
    if(var_551904951118b7b9) {
      println("<dev string:x1f0>" + dropstruct.dropidx + "<dev string:x263>" + baseorigin + "<dev string:x26e>" + dropdata.outorigin + "<dev string:x276>" + dropdata.dist);
    }

    tracecontents = trace::create_contents(0, 1, 1, 1, 1, 1, level.var_41ed77c6e0438829, 0, 1, 0, 1);
    traceresults = function_7bf5ea7dd272db77(dropstruct, dropdata, baseorigin, ignoreent, tracecontents, var_551904951118b7b9);
    var_43ee1b505fc4c4ed = traceresults["fraction"] < level.var_7452545fbedecdba;

    if(isDefined(traceresults) && level.var_40111092ff73b724 > 0 && !isDefined(var_8a600b6102da9f9b) && !isDefined(var_f71d4f78d508da69) && !isDefined(overrideorigin)) {
      var_93a7b81154b71c0e = 0;

      if(!isDefined(var_f71d4f78d508da69) && !isDefined(overrideorigin) && !istrue(var_688e4da4cb16116d)) {
        var_93a7b81154b71c0e = function_78ca4cfbcb159de2(baseorigin, dropdata, traceresults);
      }

      if(var_93a7b81154b71c0e || var_43ee1b505fc4c4ed) {
        function_3f0ce5cf3481f56c(dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, level.var_40111092ff73b724, level.var_7452545fbedecdba, var_551904951118b7b9, var_43ee1b505fc4c4ed, var_93a7b81154b71c0e);
      }
    }

    function_28cd87cdbae45940(dropstruct, dropdata, ignoreent, tracecontents, var_551904951118b7b9);
    function_bd56d40fa4e7a1e3(dropstruct, dropdata, ignoreent, tracecontents, groundfloat, var_29a915f667b07b0f, var_551904951118b7b9);
  } else {
    dropdata.outorigin += (0, 0, groundfloat);
  }

  if(1 && !dropdata.noground) {
    startorigin = baseorigin;

    if(!istrue(var_3ace5ac9c7d6fa44)) {
      startorigin += (0, 0, var_b57e08395cbe94d2);
    }

    dropdata.payload = calcscriptablepayloadgravityarc(startorigin, dropdata.outorigin);
  }

  if(var_551904951118b7b9) {
    println("<dev string:x1f0>" + dropstruct.dropidx + "<dev string:x283>" + dropdata.outorigin + "<dev string:x296>" + dropdata.outangles);
  }

  dropstruct.dropcount++;
  dropstruct.dropidx++;
  return getitemdropinfo(dropdata.outorigin, dropdata.outangles, dropdata.payload, dropdata.groundentity);
}

function function_73ffc9bcd6d1e62d(fromkiosk) {
  if(istrue(fromkiosk)) {
    level.br_pickups.yawoffsetoverride = br_armory_kiosk::getkioskyawoffsetoverride();
    level.br_pickups.distanceoverride = br_armory_kiosk::function_1a8066ccdb91c1d1();
    return;
  }

  level.br_pickups.yawoffsetoverride = undefined;
  level.br_pickups.distanceoverride = undefined;
}

function getfullweaponobjforscriptablepartname(scriptablename) {
  if(isDefined(scriptablename) && isDefined(level.br_lootiteminfo[scriptablename]) && isDefined(level.br_lootiteminfo[scriptablename].fullweaponobj)) {
    return level.br_lootiteminfo[scriptablename].fullweaponobj;
  }

  return undefined;
}

function getfullweaponobjforpickup(pickupent) {
  if(isDefined(pickupent) && isDefined(pickupent.scriptablename)) {
    return getfullweaponobjforscriptablepartname(pickupent.scriptablename);
  } else if(pickupent function_73cc0f04c4c5001d()) {
    scriptablename = scripts\mp\gametypes\br_pickups::lootgetscriptablename(pickupent);
    return getfullweaponobjforscriptablepartname(scriptablename);
  } else if(isDefined(pickupent.type)) {
    return getfullweaponobjforscriptablepartname(pickupent.type);
  }

  return undefined;
}

function getgulagpickupsforclass(pickupclass) {
  var_14004b68ddacb781 = ["none"];

  if(isDefined(pickupclass) && isDefined(level.br_pickups.br_gulagpickups[pickupclass])) {
    var_14004b68ddacb781 = level.br_pickups.br_gulagpickups[pickupclass];
  }

  return var_14004b68ddacb781;
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
  return instance.count >> 11 + 11 & 512 - 1;
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
    assert(var_dab81ead77442a10 < 512);
    count += (var_dab81ead77442a10 & 512 - 1) << 11 + 11;
  }

  instance.count = count;
}

function lootusedignore(instance) {
  scriptablename = lootgetscriptablename(instance);

  if(!isDefined(scriptablename)) {
    return false;
  }

  if(scriptablename == "dmz_uav_tower") {
    return true;
  }

  if(scriptablename == "brloot_scorpion_trophy") {
    return true;
  }

  if(istrue(br_gametypes::runbrgametypefunc("lootUsedIgnore", instance))) {
    return true;
  }

  return false;
}

function lootgetscriptablename(instance) {
  if(!isDefined(instance)) {
    return undefined;
  }

  if(!instance function_73cc0f04c4c5001d()) {
    return instance.type;
  }

  lootname = instance function_15c8c4841bfc1fd5();

  if(isDefined(lootname)) {
    return lootname;
  }

  return instance.type;
}

function function_23d6a60ccfa90b00(instance, player) {
  if(!isDefined(instance)) {
    return 0;
  }

  pickup = spawnStruct();
  pickup.scriptablename = lootgetscriptablename(instance);
  pickup.origin = instance.origin;
  pickup.count = loot_getitemcount(instance);
  pickup.countlefthand = loot_getitemcountlefthand(instance);
  pickup.instance = instance;
  pickup.customweaponname = instance.customweaponname;
  pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];
  assert(isDefined(pickup.count));

  if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename])) {
    pickup.count = level.br_pickups.counts[pickup.scriptablename];
  }

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = 1;

  if(!allowautouse(player, pickup, instance)) {
    return 0;
  }

  var_3fcf64bb4bafc05b = 0;
  pickupresult = player cantakepickup(pickup);

  if(pickupresult == 1) {
    var_3fcf64bb4bafc05b |= 1;

    if(isweaponpickup(pickup.scriptablename)) {
      pickupweapon = br_weapons::function_55c5d35c8c76a95b(pickup)[0];

      if(player br_weapons::function_744e28ebe63c0358(pickupweapon)) {
        var_3fcf64bb4bafc05b |= 2;
      }
    }
  }

  return var_3fcf64bb4bafc05b;
}

function function_e40eec61ee9d0889(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  result = lootused(instance, part, state, player, var_a5b2c541413aa895, usestring, 1);

  if(getdvarint(@ "hash_efe884b265ffb84f", 1) && isDefined(instance) && istrue(var_a5b2c541413aa895)) {
    player function_95f0eda7e462e30f(instance, result);
  }
}

function lootused(instance, part, state, player, var_a5b2c541413aa895, usestring, fromcallback, forcebackpack) {
  if(!isDefined(instance)) {
    return;
  }

  pickup = spawnStruct();
  pickup.scriptablename = lootgetscriptablename(instance);
  pickup.origin = instance.origin;
  pickup.count = loot_getitemcount(instance);
  pickup.countlefthand = loot_getitemcountlefthand(instance);
  pickup.countalt = function_3a5f7703319142dd(instance);
  pickup.instance = instance;
  pickup.customweaponname = instance.customweaponname;
  pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];
  assert(isDefined(pickup.count));

  if(!pickup.count && !function_5449da9d3d0358a4(pickup.scriptablename) && !isgasmask(pickup.scriptablename) && !ishelmet(pickup.scriptablename) && !function_cb8c6abfd1ce083a(pickup.scriptablename) && isDefined(level.br_pickups.counts[pickup.scriptablename])) {
    pickup.count = level.br_pickups.counts[pickup.scriptablename];
  }

  pickup.isweaponfromcrate = instance.isweaponfromcrate;
  pickup.isautouse = var_a5b2c541413aa895;
  pickup.pastteam = instance.pastteam;
  pickup.metadata = instance.metadata;
  return function_b5f5576a0017c089(pickup, state, player, var_a5b2c541413aa895, instance, fromcallback, forcebackpack);
}

function function_60234aa487445085(pickup, player, var_a5b2c541413aa895, instance) {
  var_483ad0cab6e25673 = isDefined(pickup.scriptablename) && function_f262c137ed78e6eb(pickup.scriptablename);
  var_becfb5931b2c6bd7 = isDefined(pickup.scriptablename) && pickup namespace_2d7f47b19ccdb41d::function_5facfbee97e1a98e();
  var_f0abce18fe9c334e = var_483ad0cab6e25673 || var_becfb5931b2c6bd7;
  pickupremains = player onusecompleted(pickup, var_f0abce18fe9c334e, var_a5b2c541413aa895, undefined, undefined, instance);

  if(isDefined(instance) && pickupremains) {
    loot_setitemcount(instance, pickup.count, pickup.countlefthand, pickup.countalt);
  }

  if(player br_public::isplayerinorgoingtogulag()) {
    if(isDefined(player.var_d919d1c70719e664)) {
      player.var_d919d1c70719e664 += 1;
    }

    if(isDefined(pickup.scriptablename) && pickup.scriptablename == "loot_key_gulag") {
      player.var_936612c9eeedd33b = 1;
      player.var_c51be970ba557af5 = 1;
    }

    arena = namespace_de6eb888abbe38e1::function_2f4344abdc200e43(player);

    if(isDefined(pickup.scriptablename) && pickup.scriptablename != "loot_key_gulag") {
      if(isDefined(arena) && isDefined(arena.lootpickedup) && isDefined(instance)) {
        arena.lootpickedup[arena.lootpickedup.size] = instance;
      }
    }
  }

  var_ed6d9e78de701fba = getdvarint(@ "hash_920a281ef3740251", 1);

  if(!isDefined(instance) || pickupremains && !var_ed6d9e78de701fba) {
    return true;
  }

  if(isplunder(instance.type)) {
    player function_696e4b1495ad2dd3(instance);
  }

  if(!var_483ad0cab6e25673 && !function_4ebfdbfa1b8e0339(pickup.scriptablename) && !istrue(instance.var_c001ccfc802f487)) {
    if(pickupremains && var_ed6d9e78de701fba) {
      dropstruct = function_7b9f3966a7a42003();
      dropinfo = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, undefined, pickup.overridedist, undefined, undefined, pickup.origin);
      spawnpickup(pickup.scriptablename, dropinfo, pickupremains, 1);
    }

    loothide(instance);
  }

  function_56dd1faa25a3414f(player, pickup, var_a5b2c541413aa895, 1);
  player setclientomnvar("ui_notify_show_minimal_hud", gettime());
  return true;
}

function function_dc5a935ab4958490(pickup) {
  if(isDefined(pickup.customweaponname)) {
    lootid = scripts\cp_mp\weapon::function_b0d37b9be0027733(pickup.customweaponname);
  } else {
    lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  }

  return lootid;
}

function getgasmasklootid(var_bb057f32440ac1b5) {
  if(!isDefined(level.var_534e97d34ef9fa29)) {
    level.var_534e97d34ef9fa29 = [];
  }

  gasmasklootid = loot::function_fae5e1d3de32d3f7(var_bb057f32440ac1b5);

  if(isDefined(gasmasklootid)) {
    level.var_534e97d34ef9fa29[level.var_534e97d34ef9fa29.size] = gasmasklootid;
  }

  return gasmasklootid;
}

function function_b29b252cdfa9a7d6(perks) {
  bit_width = 8;
  quantity = 0;
  var_99d72c999b9a85fa = 0;
  mask = int(pow(2, bit_width)) - 1;

  for(i = 0; i < 4 && i < perks.size; i++) {
    if(isDefined(perks[i])) {
      perk = perks[i];
    } else {
      key = "perk" + i + 1;
      perk = perks[key];
    }

    var_1855223a9b8caacb = i >= 2;
    id = scripts\mp\perks\perks::getperkid(perk);
    assertex(id <= mask, "<dev string:x29b>" + mask);
    shiftindex = ter_op(var_1855223a9b8caacb, i - 2, i);
    var_81dc643838b63c97 = (id &mask) << shiftindex * bit_width;

    if(var_1855223a9b8caacb) {
      var_99d72c999b9a85fa += var_81dc643838b63c97;
      continue;
    }

    quantity += var_81dc643838b63c97;
  }

  return [quantity, var_99d72c999b9a85fa];
}

function function_8f0bd51f5c6108b(pickup, player, var_a5b2c541413aa895, instance) {
  lootid = function_dc5a935ab4958490(pickup);
  player onpickuptakenintobackpack(pickup);
  player playpickupfeedback(pickup, var_a5b2c541413aa895);
  function_56dd1faa25a3414f(player, pickup, var_a5b2c541413aa895, 20);
  pickupremains = 0;

  if(isDefined(lootid)) {
    if(isweaponpickupitem(pickup)) {
      pickup.count = 1;
    }

    if(namespace_126f4192a2d090c4::function_43044da0ed44d79f(pickup.scriptablename)) {
      if(namespace_126f4192a2d090c4::function_bdd930eee0042052()) {
        backpackindex = player namespace_e50e624d9af51c8c::getavailabledmzbackpackindex();
        quantity = 1;
        var_99d72c999b9a85fa = 0;

        if(isDefined(pickup.instance.perks)) {
          [quantity, var_99d72c999b9a85fa] = function_b29b252cdfa9a7d6(pickup.instance.perks);
        }

        namespace_e50e624d9af51c8c::function_11f48ae5b87b4525(player, backpackindex, lootid, quantity, var_99d72c999b9a85fa);

        if(isDefined(pickup.instance.perks)) {
          custperks = arraycopy(pickup.instance.perks);
          player namespace_126f4192a2d090c4::function_222999aad19f5b52(backpackindex, custperks);
        }
      }
    } else {
      player namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickup);
    }

    if(isDefined(instance)) {
      loothide(instance);
    }

    return 1;
  }
}

function function_56dd1faa25a3414f(player, pickup, var_a5b2c541413aa895, results) {
  issuccess = results == 1 || results == 20 || results == 5 || results == 27;

  if(issuccess) {
    method = challenges::function_6d40f12a09494350(0, ae_utility::function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"loot"));
    method = challenges::function_6d40f12a09494350(method, ae_utility::function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"ground"));
    lootid = function_dc5a935ab4958490(pickup);
    quantity = pickup.count;
    itemneeded = challenges::function_d24138b32084fc3e(player, lootid, undefined, method, quantity);

    if(!istrue(itemneeded)) {
      function_2237800b816490b8(player, pickup);
    }

    if(!game_utility::isbrstylegametype()) {
      function_acddab6fa6e914a(player, pickup.origin);
    }

    player notify("looted_item", lootid, quantity, var_a5b2c541413aa895);
  }
}

function function_2237800b816490b8(player, pickup) {
  if(!isDefined(player) || !isDefined(pickup) || !isDefined(pickup.scriptablename)) {
    return;
  }

  scriptablename = pickup.scriptablename;

  if(isplunder(scriptablename) || isvaluable(scriptablename)) {
    cashvalue = 0;

    if(isDefined(player.plundercount)) {
      cashvalue = player.plundercount;
    }

    extracash = player namespace_771165fe61010ab2::function_e2f4f470c55123b8(undefined, 1);

    if(isDefined(extracash)) {
      cashvalue += extracash;
    }

    if(cashvalue > 1000) {
      if(istrue(namespace_b16531563568eaba::function_80478f2ef8c8882f(player)) && !overlord::function_50ebf0029301be3f(player, "dead_drop_nag")) {
        overlord::playevent("dead_drop_nag", [player]);
      }
    }
  }
}

function function_acddab6fa6e914a(player, origin) {
  function_afe5cda1a4ed9d11("looted_item", player, origin);
}

function function_2e6de0100e414a86(pickup) {
  if(br_public::isammo(pickup.scriptablename) && !getdvarint(@ "hash_9d140d98331435ed", 0)) {
    return 0;
  }

  if(isgametypeitem(pickup.scriptablename) && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("shouldAutoPickupEquippedGametypeItemOnly")) {
    return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("shouldAutoPickupEquippedGametypeItemOnly", pickup.scriptablename);
  }

  return getdvarint(@ "hash_15055cb805b43a20", 1);
}

function allowautouse(player, pickup, instance) {
  if(istrue(level.disableautolootpickup)) {
    return false;
  }

  if(function_2e6de0100e414a86(pickup) && !player function_e44c2d69db881894(pickup.scriptablename)) {
    return false;
  }

  if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) && !player function_7b738b973a0b7f94() && player function_e44c2d69db881894(pickup.scriptablename)) {
    return false;
  }

  if(br_weapons::function_b1dd9dcae2f63965() && player br_weapons::function_ac3ec31be7aad7a7(instance)) {
    return false;
  }

  if(br_public::isammo(pickup.scriptablename) && player namespace_e50e624d9af51c8c::function_9e76c59021bbf021(pickup.scriptablename) == 0) {
    return false;
  }

  return true;
}

function function_b5f5576a0017c089(pickup, state, player, var_a5b2c541413aa895, instance, fromcallback, forcebackpack, var_1e2e085b484205c3) {
  if(!isDefined(pickup)) {
    return 0;
  }

  if(istrue(player br_gametypes::runbrgametypefunc("playerSkipLootPickup", instance, var_a5b2c541413aa895)) || istrue(level.infilcinematicactive)) {
    return 0;
  }

  if(istrue(var_a5b2c541413aa895) && !allowautouse(player, pickup, instance)) {
    return 0;
  }

  if(br_dom_gulag::function_9005af34e01bf8fe() && player br_public::isplayerinorgoingtogulag()) {
    if(isDefined(pickup.instance) && isDefined(pickup.instance.classname) && pickup.instance.classname == "scriptable_br_plunder_box") {
      if(!isDefined(player.var_44172449614f0738)) {
        player.var_44172449614f0738 = 0;
      }

      player.var_44172449614f0738 += 1;
    }
  }

  if(!isDefined(instance) || instance getscriptableisloot() && !lootusedignore(instance)) {
    results = undefined;

    if(istrue(forcebackpack)) {
      results = 20;
    } else {
      results = player cantakepickup(pickup, getdvarint(@ "hash_8225b8d33c1565c6", 1) && !istrue(var_a5b2c541413aa895) && !istrue(var_1e2e085b484205c3));
    }

    if((results == 1 || results == 20) && utility::issharedfuncdefined("pmc_missions", "onPickupWeapon") && isweaponpickupitem(pickup)) {
      weapon = br_weapons::function_55c5d35c8c76a95b(pickup)[0];
      [[utility::getsharedfunc("pmc_missions", "onPickupWeapon")]](player, weapon, pickup.metadata);
    }

    if(quickprompt::function_7ba31cb6b21c346f()) {
      if(results == 1 || results == 20 || results == 5 || results == 27) {
        if(player calloutmarkerping_mp::function_c28d94289c4a6ecd(instance)) {
          player thread quickprompt::function_36edf91561322753(3);
        } else if(player calloutmarkerping_mp::function_4864c58ab9b1f07e(instance, 1)) {
          player thread quickprompt::function_36edf91561322753(3);
        }
      }
    }

    if(isgametypeitem(pickup.scriptablename) && var_a5b2c541413aa895 == 0 && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("canLootNotAutoUseGametypeItem")) {
      if(istrue(scripts\mp\gametypes\br_gametypes::runbrgametypefunc("canLootNotAutoUseGametypeItem", pickup.scriptablename))) {
        results = 1;
      }
    }

    if(results == 1) {
      return function_60234aa487445085(pickup, player, var_a5b2c541413aa895, instance);
    } else if(results == 20) {
      return function_8f0bd51f5c6108b(pickup, player, var_a5b2c541413aa895, instance);
    } else if(results == 5 || results == 27) {
      newweapon = br_weapons::function_55c5d35c8c76a95b(pickup)[0];
      fakepickup = spawnStruct();
      fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon(newweapon);
      fakepickup.origin = pickup.origin;
      fakepickup.count = weaponclipsize(newweapon);
      lootresult = 0;

      if(results == 5) {
        lootresult = function_60234aa487445085(fakepickup, player);
      } else {
        lootresult = function_8f0bd51f5c6108b(fakepickup, player);
      }

      if(isDefined(instance)) {
        loothide(instance);
      }

      return lootresult;
    } else {
      if(getdvarint(@ "hash_c031ba1736951fae", 1) && results != 28 && results != 2 && results != 10 && results != 9 && results != 13 && results != 33 && results != 35 && results != 11 && results != 16 && results != 8 && results != 36 && results != 7 && results != 37 && results != 39 && results != 42 && player namespace_de6eb888abbe38e1::function_c84e254980c7c8ed() && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename) && isDefined(instance) && !istrue(var_a5b2c541413aa895)) {
        tmpcontainer = instance;
        tmpcontainer.contents = [];
        tmpcontainer.containertype = 14;
        tmpcontainer.contents[0] = [];
        tmpcontainer.contents[0]["quantity"] = pickup.count;
        tmpcontainer.contents[0]["lootID"] = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);

        if(function_2d86ba79a58bb62(pickup.scriptablename)) {
          tmpcontainer.contents[0]["extraInfoEnt"] = undefined;
          tmpcontainer.contents[0]["extraInfoTeam"] = undefined;

          if(isDefined(pickup.instance.blacksite)) {
            tmpcontainer.contents[0]["extraInfoEnt"] = pickup.instance.blacksite;
          }

          if(isDefined(pickup.instance.originalteam)) {
            tmpcontainer.contents[0]["extraInfoTeam"] = pickup.instance.originalteam;
          }
        }

        loot::function_68ca06034b8aaccd(player, tmpcontainer);
        return 0;
      }

      var_8dde4ac0085463fc = 1;
      var_bb9e46e1d8130f2 = level.br_pickups.br_hasautopickup[pickup.scriptablename];

      if(isDefined(var_a5b2c541413aa895) && isDefined(var_bb9e46e1d8130f2)) {
        if(var_a5b2c541413aa895 && istrue(var_bb9e46e1d8130f2) && state == "visible") {
          var_8dde4ac0085463fc = 0;
        }
      }

      if(results == 17) {
        var_8dde4ac0085463fc = 0;
      }

      if(iscache(pickup.scriptablename)) {
        var_8dde4ac0085463fc = 0;
      }

      if(isrock(pickup.scriptablename)) {
        var_8dde4ac0085463fc = 0;
      }

      if(isgametypeitem(pickup.scriptablename)) {
        var_8dde4ac0085463fc = 0;
      }

      if(results == 41) {
        thread namespace_735f8af4d2aa34fb::function_5d0b1fa9645f3c89(pickup, player);
        var_8dde4ac0085463fc = 0;
      }

      if(var_8dde4ac0085463fc) {
        if(results == 3) {
          player playlocalsound("weap_ammo_full");
        } else {
          player playlocalsound("br_pickup_deny");
        }

        player showuseresultsfeedback(results);
      }
    }
  }

  return 0;
}

function function_2ae5e94bd6518ab5(loot, var_ecce4aadde6676e5) {
  scriptablename = lootgetscriptablename(loot);

  if(iscache(scriptablename)) {
    return var_ecce4aadde6676e5;
  }

  if(function_32125eba262380c7(scriptablename) || istablet(scriptablename) || function_7a345d3f5a65278c(scriptablename)) {
    return 0;
  }

  return 1;
}

function loothide(instance, part) {
  scriptablename = lootgetscriptablename(instance);

  if(!isDefined(part)) {
    part = instance.type;
  }

  if(isDefined(scriptablename) && isquesttablet(scriptablename)) {
    if(flags::gameflag("prematch_done")) {
      level notify("tablethide_kill_callout_" + instance.origin);
    }

    if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
      br_quest_util::onquesttablethide(instance);
    } else {
      namespace_c133516bfc1d803c::oncontracttablethide(instance);
    }
  }

  instance scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();

  if(instance getscriptableisreserved() && !istrue(instance.keepinmap)) {
    if(isDefined(instance.brpickupscriptableid)) {
      deregisterscriptableinstance(instance);
    }

    instance freescriptable();
    return;
  }

  if(!istrue(instance.donthide)) {
    instance setscriptablepartstate(part, "hidden");
  }
}

function br_forcegivecustompickupitem(player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased, options, autouse) {
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

  if(istrue(fromkiosk) && isDefined(player.br_kiosk)) {
    fakepickup.overridedist = distance2d(player.origin, player.br_kiosk.origin) / 2;
  }

  if(!fakepickup.count && isDefined(level.br_pickups.counts[fakepickup.scriptablename])) {
    fakepickup.count = level.br_pickups.counts[fakepickup.scriptablename];
  }

  if(isDefined(countoverride)) {
    fakepickup.count = countoverride;
  }

  if(isDefined(options)) {
    if(isDefined(options.perks)) {
      fakepickup.perks = arraycopy(options.perks);
    }
  }

  results = player cantakepickup(fakepickup, 1);

  if(results == 1) {
    lootid = loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);

    if(br_public::isarmorplate(fakepickup.scriptablename) && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(fakepickup.scriptablename)) {
      equipname = level.br_pickups.br_equipname[fakepickup.scriptablename];
      slot = level.equipment.table[equipname].defaultslot;
      var_9ffb530e039a041 = player scripts\mp\equipment::getequipmentslotammo(slot);

      if(!isDefined(var_9ffb530e039a041)) {
        var_9ffb530e039a041 = 0;
      }

      backpackpickup = spawnStruct();
      backpackpickup.scriptablename = scriptablename;
      backpackpickup.count = fakepickup.count - level.br_pickups.var_4138f9ddc1cd22d[scriptablename] - var_9ffb530e039a041;

      if(backpackpickup.count > 0) {
        player namespace_e50e624d9af51c8c::additemtobackpack(lootid, backpackpickup);
        fakepickup.count -= backpackpickup.count;
      }
    }

    player onusecompleted(fakepickup, var_43fb3d97abb79854, autouse, fromkiosk);
    return true;
  } else if(results == 20) {
    lootid = undefined;

    if(br_public::isammo(fakepickup.scriptablename)) {
      lootid = loot::getlootidfromref(fakepickup.scriptablename);
    } else {
      lootid = loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
    }

    if(isDefined(lootid)) {
      if(isweaponpickupitem(fakepickup) || function_4294e9b331377c31(fakepickup.scriptablename)) {
        fakepickup.count = 1;
      }

      player namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
      return true;
    }
  }

  return false;
}

function resetplayerinventorywithdelay(delayvalue, keeploadout) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  wait delayvalue;
  resetplayerinventory(keeploadout);
}

function resetplayerinventory(keeploadout, var_f7e8a863407717b3, playerkilled) {
  iskingslayer = game_utility::getsubgametype() == "kingslayer";
  self.br_inventory_slots = [];

  if(function_d75b73c443421047()) {
    keeploadout = 1;
    resetsuper(playerkilled);
  }

  if(!br_gametypes::isfeaturedisabled("armor")) {
    if(!istrue(var_f7e8a863407717b3)) {
      armor::breakarmor();
    }
  }

  if(!istrue(keeploadout)) {
    breakgasmaskbr();

    if(!level.allowsupers) {
      resetsuper(playerkilled);
    }

    if(isDefined(self.streakdata) && !iskingslayer) {
      killstreaks::removekillstreak(1);
    }

    br_weapons::stripweaponsfromplayer();
    equipment::takeequipment("primary");
    equipment::takeequipment("secondary");
    equipment::takeequipment("super");
    weapons::setlastdroppableweaponobj(makeweapon("iw9_me_fists_mp"));

    if(namespace_126f4192a2d090c4::function_c0d385a09d173a36()) {
      namespace_126f4192a2d090c4::function_19868614946c4df4();
    }

    if(br_public::hasselfrevivetoken()) {
      removeselfrevivetoken();
    }
  }
}

function resetsuper(playerkilled) {
  supers::clearsuper(undefined, undefined, playerkilled);
  equipment::takeequipment("super");
  self setclientomnvar("ui_perk_package_state", 0);
  thread scripts\mp\supers::function_93b5448ea8f6277b(0);
  namespace_b16531563568eaba::function_351fe4ac57ca37e5(self, "super");
}

function resetdefaultweaponammo(magcount) {
  weaponslist = self getweaponslistall();

  for(idx = 0; idx < weaponslist.size; idx++) {
    weapon = weaponslist[idx];
    stockammo = 0;

    if(weapon.inventorytype == "primary") {
      if(isDefined(magcount)) {
        var_d63c71101d308076 = weapon.clipsize;
        stockammo = var_d63c71101d308076 * (magcount - 1);
      } else if(level.magcount > 0) {
        var_d63c71101d308076 = weapon.clipsize;
        stockammo = var_d63c71101d308076 * (level.magcount - 1);
      } else {
        var_d63c71101d308076 = 0;
      }

      self setweaponammoclip(weapon, var_d63c71101d308076);
    }
  }
}

function initplayer(useloadout) {
  br_weapons::br_ammo_player_clear();
  resetplayerinventory(useloadout);
  level thread function_cf83a47b811bd132(self);
}

function function_cf83a47b811bd132(player) {
  if(!namespace_e50e624d9af51c8c::isbackpackinventoryenabled() || !getdvarint(@ "hash_48d4e35a894b5aff", 1)) {
    return;
  }

  player notify("watch_backpack_size");
  level endon("game_ended");
  player endon("disconnect");
  player endon("watch_backpack_size");

  if(!flags::gameflag("prematch_done")) {
    flags::gameflagwait("prematch_done");
  }

  while(true) {
    if(isDefined(player.attached_bag)) {
      var_39d303a2954e0791 = getbagtypeforplayer(player);

      if(!isDefined(player.var_9190265f4c5ca4c0) || player.var_9190265f4c5ca4c0 != var_39d303a2954e0791) {
        function_8933b487e22ee213(player, var_39d303a2954e0791);
      }
    }

    wait 1;
  }
}

function getbagtypeforplayer(player) {
  var_4755865f44ed3d7e = namespace_e50e624d9af51c8c::function_6fe7e7891d125c48(player);
  totalsize = namespace_e50e624d9af51c8c::getplayerbackpacksize(player);

  if(totalsize <= 0) {
    return "";
  }

  ratio = var_4755865f44ed3d7e / totalsize;
  bagtype = "";

  if(ratio == 1) {
    bagtype = "bgfull";
  } else if(ratio >= 0.5) {
    bagtype = "bghalf";
  }

  return bagtype;
}

function function_8933b487e22ee213(player, bagtype) {
  player function_1863f51c1339d80f(function_1823ff50bb28148d(bagtype));
  player.var_9190265f4c5ca4c0 = bagtype;
}

function spawndebugpickupfromdevgui(scriptablename, critical, quantity) {
  foreach(player in level.players) {
    if(!isbot(player) && isalive(player)) {
      spawnpos = player.origin + anglesToForward(player.angles) * 100 + (0, 0, 12);
      initialcount = 0;

      if(isDefined(level.br_pickups.counts[scriptablename])) {
        initialcount = level.br_pickups.counts[scriptablename];
      }

      if(isDefined(quantity)) {
        initialcount = int(quantity);
      }

      dropinfo = getitemdropinfo(spawnpos);
      perks = [];

      if(scriptablename == "brloot_perkpack_custom") {
        dropinfo.customperkpayload = [#"customperkpackage"];

        for(i = 0; i < 4; i++) {
          randperk = randomint(level.perkbundles.size);
          perk = getarraykey(level.perkbundles, randperk);
          perks[perks.size] = perk;
          dropinfo.customperkpayload[dropinfo.customperkpayload.size] = scripts\cp_mp\utility\loot::getlootidfromref(perk);
        }
      }

      item = spawnpickup(scriptablename, dropinfo, initialcount);

      if(scriptablename == "brloot_perkpack_custom") {
        item.perks = perks;
      }

      if(istrue(critical)) {
        item.criticalitem = 1;
        item.alwayscritical = 1;
      }

      if(isweaponcase(scriptablename)) {
        namespace_f3c34c81dcc60eda::function_3e7ee85cb0d3504c(item);
      }

      if(isquesttablet(scriptablename)) {
        namespace_c133516bfc1d803c::function_8a25384bacdd7b79(item, scriptablename);
      }

      if(isDefined(item)) {
        contents = trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
        ignorelist = [];
        caststart = item.origin + (0, 0, 50);
        castend = caststart + (0, 0, -200);
        traceresult = trace::ray_trace(caststart, castend, ignorelist, contents);

        if(isDefined(traceresult["entity"]) && isDefined(traceresult["entity"].targetname) && traceresult["entity"].targetname == "train_wz") {
          trainent = traceresult["entity"];
          localorigin = rotatevectorinverted(item.origin - trainent.origin, trainent.angles);
          localangles = combineangles(invertangles(trainent.angles), item.angles);
          item utility::function_6e506f39f121ea8a(trainent, localorigin, localangles);
        }
      }
    }
  }
}

function function_c87696a022a2c6fc(skipweapons) {
  size = level.br_pickups.br_value.size;
  rows = sqrt(size);
  spos = level.players[0].origin;
  curindex = 0;

  foreach(index, value in level.br_pickups.var_7b2bff2d04ee1017) {
    if(istrue(skipweapons) && isweaponpickup(index)) {
      continue;
    }

    curindex += 1;
    dropinfo = getitemdropinfo(spos + (20 * curindex % rows, 20 * int(curindex / rows), 0));
    item = spawnpickup(index, dropinfo, 1);
  }
}

function function_510f82785bd2c148() {
  allcaches = [];

  foreach(scriptablename, type in level.br_pickups.br_itemtype) {
    if(type == #"cache" && (scriptablename == "dmz_crate_wood" || issubstr(scriptablename, "br_loot"))) {
      allcaches[allcaches.size] = scriptablename;
    }
  }

  size = allcaches.size;
  rows = sqrt(size);
  spos = level.players[0].origin;
  curindex = 0;

  foreach(scriptable in allcaches) {
    curindex += 1;
    dropinfo = getitemdropinfo(spos + (60 * curindex % rows, 60 * int(curindex / rows), 0));
    item = spawnpickup(scriptable, dropinfo, 1);

    if(isDefined(item) && item getscriptablehaspart("body")) {
      item setscriptablepartstate("body", "closed_usable");
    }
  }
}

function function_b158d838449b637e(itemsstring) {
  dropinfo = getitemdropinfo(level.players[0].origin);
  cache = spawnpickup("br_loot_cache", dropinfo, 1);

  if(!isDefined(cache)) {
    return;
  }

  cache.contents = [];
  lootids = strtok(itemsstring, ",");

  foreach(id in lootids) {
    currentindex = cache.contents.size;
    cache.contents[currentindex] = [];
    cache.contents[currentindex]["lootID"] = int(id);
    cache.contents[currentindex]["quantity"] = 1;
    scriptablename = loot::getscriptablefromlootid(int(id));

    if(isDefined(scriptablename) && isweaponpickup(scriptablename)) {
      cache.contents[currentindex]["ref"] = scriptablename;
    }
  }

  if(cache getscriptablehaspart("body")) {
    cache setscriptablepartstate("body", "closed_usable");
  }
}

function function_e2d83df8b282b199(itemsstring) {
  dropinfo = getitemdropinfo(level.players[0].origin);
  cache = spawnpickup("br_loot_cache", dropinfo, 1);

  if(!isDefined(cache)) {
    return;
  }

  items = [];
  lootids = strtok(itemsstring, ",");
  index = items.size;
  items[index] = [];
  id = utility::array_random(lootids);
  items[index]["lootID"] = int(id);
  items[index]["quantity"] = 1;
  loot::function_40b46e7298657a93(cache, level.players, items);

  if(cache getscriptablehaspart("body")) {
    cache setscriptablepartstate("body", "closed_usable");
  }
}

function isweaponpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"weapon";
}

function isweaponpickupitem(item) {
  if(!isDefined(item)) {
    return false;
  }

  if(isDefined(item.scriptablename)) {
    return isweaponpickup(item.scriptablename);
  } else if(isDefined(item.weapon)) {
    return true;
  }

  return false;
}

function takearmorpickup(pickupent) {
  armorperkname = level.br_pickups.br_equipname[pickupent.scriptablename];
  armorbetter = armor::function_cd4a78b4a236ddc8(armorperkname);

  if(armorbetter) {
    tryequiparmor(pickupent);
  }

  level notify("picked_up_item_" + pickupent.scriptablename + "_" + self.team, self);
}

function function_4e335a6589199847(pickupent, var_a5b2c541413aa895, var_db943473454f6ea6, backpackequip, fromkiosk) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  var_43044da0ed44d79f = namespace_708f627020de59d3::function_43044da0ed44d79f(pickupent.scriptablename);
  pickupremains = 0;
  hasperkpack = isDefined(self.var_28c944f222f4814) && isDefined(self.var_28c944f222f4814.var_183ec729c8876d57);
  equippack = istrue(var_a5b2c541413aa895) || istrue(backpackequip) || !hasperkpack || !isDefined(var_db943473454f6ea6) && !isDefined(backpackequip) || istrue(fromkiosk);
  var_a0fef687a228ba07 = namespace_aead94004cf4c147::function_7e103028c464ab9a(pickupent.scriptablename) && namespace_aead94004cf4c147::canitemfitinbackpack(lootid, pickupent.count);
  var_a5ba66a3a80e70f7 = var_a0fef687a228ba07 && !equippack && namespace_aead94004cf4c147::function_7e103028c464ab9a(pickupent.scriptablename);
  stowexisting = istrue(fromkiosk) && var_a0fef687a228ba07 && hasperkpack;
  dropexisting = equippack && hasperkpack && !istrue(backpackequip) && !stowexisting;
  targetent = pickupent;
  var_aee3b96540ed46e1 = hasperkpack ? namespace_708f627020de59d3::function_43044da0ed44d79f(self.var_28c944f222f4814.var_183ec729c8876d57) : 0;
  perks = function_2f886a8000750771();

  if(istrue(backpackequip) && !isDefined(var_db943473454f6ea6) && isDefined(self.var_2fa5b49969def47)) {
    scriptablename = lootgetscriptablename(self.var_2fa5b49969def47);

    if(function_36de08ea672b354c(scriptablename)) {
      targetent = structcopy(pickupent);
      targetent.origin = self.var_2fa5b49969def47.origin;
      targetent.angles = self.var_2fa5b49969def47.angles;

      if(isDefined(self.var_2fa5b49969def47.perks)) {
        targetent.perks = self.var_2fa5b49969def47.perks;
      }
    }
  }

  if(equippack || var_a5ba66a3a80e70f7) {
    currentlootid = undefined;

    if(hasperkpack) {
      currentlootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(self.var_28c944f222f4814.var_183ec729c8876d57);
    }

    if(stowexisting) {
      index = namespace_aead94004cf4c147::getavailabledmzbackpackindex();

      if(isDefined(index)) {
        if(namespace_708f627020de59d3::function_43044da0ed44d79f(self.var_28c944f222f4814.var_183ec729c8876d57)) {
          namespace_708f627020de59d3::function_222999aad19f5b52(index, self.var_28c944f222f4814.perks);
        }

        namespace_aead94004cf4c147::function_a0ccc23064473a05(self, index, currentlootid, 1);
        namespace_708f627020de59d3::function_19868614946c4df4();
        hasperkpack = 0;
        currentlootid = undefined;
      } else if(hasperkpack) {
        dropexisting = 1;
      }
    }

    namespace_708f627020de59d3::function_c3023358dc648bf1(targetent, dropexisting, var_a5b2c541413aa895, var_db943473454f6ea6, backpackequip);

    if(isDefined(currentlootid) && istrue(backpackequip) && hasperkpack) {
      quantity = 1;
      var_99d72c999b9a85fa = 0;

      if(var_aee3b96540ed46e1 && isDefined(perks)) {
        [quantity, var_99d72c999b9a85fa] = function_b29b252cdfa9a7d6(perks);
      }

      namespace_aead94004cf4c147::function_3c3ee4c5700e0e32(self, var_db943473454f6ea6, currentlootid, quantity, 1, 6, var_99d72c999b9a85fa);
    } else if(istrue(backpackequip) && !hasperkpack) {
      quantity = 1;

      if(var_43044da0ed44d79f) {
        quantity = namespace_e50e624d9af51c8c::function_897b29adb37f06a7(var_db943473454f6ea6);
      }

      namespace_aead94004cf4c147::function_db1dd76061352e5b(var_db943473454f6ea6, quantity);
    }
  } else {
    pickupremains = 1;
  }

  return pickupremains;
}

function function_1df16a3922616cd8(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  pickupremains = 0;

  if(pickupissameasequipmentslot(equipname, slot)) {
    var_5324597edfaff57c = equipment::getequipmentslotammo(slot);

    if(var_5324597edfaff57c == 0 && pickupent.count > 0) {
      namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
      hb_sensor::function_30cd943d877dc29f(pickupent.count);
      equipment::setequipmentammo(equipname, 1);
    }

    if(isDefined(var_db943473454f6ea6)) {
      namespace_e50e624d9af51c8c::function_84772ebf836af5db(var_db943473454f6ea6, pickupent.count * -1);
      namespace_b16531563568eaba::function_351fe4ac57ca37e5(self, slot);
    }

    if(var_5324597edfaff57c > 0) {
      if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename)) {
        lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
        namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
      } else {
        pickupbattery = pickupent.count;
        currentbattery = hb_sensor::function_db61876aca4e4cd3();

        if(pickupbattery > currentbattery) {
          pickupremains = pickupent.count;
          hb_sensor::function_30cd943d877dc29f(pickupbattery);
        }
      }
    }
  } else if(!isDefined(self.equipment[slot]) || equipment::getequipmentslotammo(slot) == 0) {
    equipment::giveequipment(equipname, slot);
    hb_sensor::function_30cd943d877dc29f(pickupent.count);
    equipment::setequipmentammo(equipname, 1);

    if(isDefined(var_db943473454f6ea6)) {
      var_9145f7d1b47a57d4 = namespace_b16531563568eaba::function_f1c7356a808e9bd9(slot);
      namespace_e50e624d9af51c8c::function_b4e3d555d6d737bb(self, var_db943473454f6ea6, var_9145f7d1b47a57d4);
    } else {
      namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
    }
  } else if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename) && !isDefined(var_db943473454f6ea6) && function_82c2dc3d57d67f52()) {
    lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);

    if(namespace_e50e624d9af51c8c::canitemfitinbackpack(lootid, pickupent.count)) {
      var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      fakepickup = spawnStruct();
      fakepickup.scriptablename = var_feb782334dd23a66;
      fakepickup.count = pickupent.count;

      if(isDefined(pickupent.overridedist)) {
        fakepickup.overridedist = pickupent.overridedist;
      }

      namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
    } else {
      dropstruct = function_7b9f3966a7a42003();
      dropequipmentinslot(dropstruct, slot, fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined, pickupent);
    }

    namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
  } else {
    if(isDefined(var_db943473454f6ea6)) {
      namespace_e50e624d9af51c8c::function_84772ebf836af5db(var_db943473454f6ea6, pickupent.count * -1);
      namespace_b16531563568eaba::function_351fe4ac57ca37e5(self, slot);
    }

    if(!istrue(level.var_ad82058550e7696b)) {
      dropstruct = function_7b9f3966a7a42003();
      dropequipmentinslot(dropstruct, slot, fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined, pickupent);
    }

    equipment::giveequipment(equipname, slot);
    equipment::setequipmentammo(equipname, 1);
    hb_sensor::function_30cd943d877dc29f(pickupent.count);
    namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
  }

  return pickupremains;
}

function takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  slot = level.equipment.table[equipname].defaultslot;
  lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  pickupremains = 0;

  if(pickupissameasequipmentslot(equipname, slot)) {
    if(equipmentslothasroom(pickupent.scriptablename, slot)) {
      var_5324597edfaff57c = equipment::getequipmentslotammo(slot);
      var_b5cdf4d935e6ac13 = equipment::getequipmentmaxammo(equipname);

      if(var_5324597edfaff57c == 0 && pickupent.count > 0) {
        namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
      }

      if(var_5324597edfaff57c + pickupent.count > var_b5cdf4d935e6ac13) {
        var_97c23a1323acc7df = var_b5cdf4d935e6ac13 - var_5324597edfaff57c;
        equipment::setequipmentammo(equipname, var_b5cdf4d935e6ac13);
        pickupent.count -= var_97c23a1323acc7df;
        pickupremains = pickupent.count;
      } else {
        equipment::incrementequipmentslotammo(slot, pickupent.count);
      }

      if(namespace_e50e624d9af51c8c::isbackpackinventoryenabled() && equipname == "equip_throwing_knife" && !perk::_hasperk("specialty_equip_throwingKnife")) {
        throwing_knife_mp::throwing_knife_mp_ongive(equipname);
      }

      if(isDefined(var_db943473454f6ea6)) {
        namespace_e50e624d9af51c8c::function_84772ebf836af5db(var_db943473454f6ea6, -1 * (var_b5cdf4d935e6ac13 - var_5324597edfaff57c));
        pickupremains = 0;
      }

      if(pickupremains && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename) && !isDefined(var_db943473454f6ea6) && function_82c2dc3d57d67f52()) {
        lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
        namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
        pickupremains = 0;
      }
    } else if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename) && !istrue(backpackequip) && function_82c2dc3d57d67f52()) {
      lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
      pickupremains = 0;
    }
  } else if(!isDefined(self.equipment[slot]) || equipment::function_fe48baf929906883(slot) == 0) {
    var_b5cdf4d935e6ac13 = equipment::getequipmentmaxammo(equipname);
    equipment::giveequipment(equipname, slot);

    if(pickupent.count > var_b5cdf4d935e6ac13) {
      var_97c23a1323acc7df = var_b5cdf4d935e6ac13;
      equipment::setequipmentammo(equipname, var_b5cdf4d935e6ac13);
      pickupent.count -= var_97c23a1323acc7df;
      pickupremains = pickupent.count;
    } else {
      equipment::setequipmentammo(equipname, pickupent.count);
    }

    if(pickupremains && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename) && function_82c2dc3d57d67f52()) {
      lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
      pickupremains = 0;
    }

    if(isDefined(var_db943473454f6ea6)) {
      var_9145f7d1b47a57d4 = namespace_b16531563568eaba::function_f1c7356a808e9bd9(slot);
      namespace_e50e624d9af51c8c::function_b4e3d555d6d737bb(self, var_db943473454f6ea6, var_9145f7d1b47a57d4);
    } else {
      namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
    }
  } else if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename) && !isDefined(var_db943473454f6ea6) && function_82c2dc3d57d67f52()) {
    lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);

    if(namespace_e50e624d9af51c8c::canitemfitinbackpack(lootid, pickupent.count)) {
      var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      ammocount = equipment::getequipmentslotammo(slot);
      fakepickup = spawnStruct();
      fakepickup.scriptablename = var_feb782334dd23a66;
      fakepickup.count = ammocount;

      if(isDefined(pickupent.overridedist)) {
        fakepickup.overridedist = pickupent.overridedist;
      }

      namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
      equipment::giveequipment(equipname, slot);
      equipment::setequipmentammo(equipname, pickupent.count);
      pickupremains = 0;
    } else {
      dropstruct = function_7b9f3966a7a42003();
      dropequipmentinslot(dropstruct, slot, fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined, pickupent);
      equipment::giveequipment(equipname, slot);
      equipment::setequipmentammo(equipname, pickupent.count);
      pickupremains = 0;
    }

    namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
  } else {
    if(isDefined(var_db943473454f6ea6)) {
      if(pickupent.maxcount == 0) {
        pickupent.maxcount = level.br_pickups.var_4138f9ddc1cd22d[pickupent.scriptablename];
      }

      newamount = min(pickupent.maxcount, pickupent.count);
      namespace_e50e624d9af51c8c::function_84772ebf836af5db(var_db943473454f6ea6, -1 * newamount);
      namespace_b16531563568eaba::function_351fe4ac57ca37e5(self, slot);
    }

    if(!istrue(level.var_ad82058550e7696b)) {
      dropstruct = function_7b9f3966a7a42003();
      dropequipmentinslot(dropstruct, slot, fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined, pickupent);
    }

    equipment::giveequipment(equipname, slot);
    equipment::setequipmentammo(equipname, pickupent.count);
    namespace_b16531563568eaba::function_f5b2810055f85ead(self, slot, lootid);
  }

  return pickupremains;
}

function dropequipmentinslot(dropstruct, slot, fromkiosk, ammocountoverride, var_db943473454f6ea6, allowautopickup, itemtype, dropfeedback, pickup) {
  ammocount = equipment::function_fe48baf929906883(slot);

  if(slot == "super") {
    if(scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() && scripts\mp\supers::issuperready()) {
      ammocount = 1;
    } else if(scripts\mp\supers::isusingsuperweapon()) {
      ammocount = scripts\mp\supers::function_3889d69492a93008();
    }
  }

  if(isDefined(ammocountoverride)) {
    ammocount = ammocountoverride;
  }

  if(!isDefined(allowautopickup)) {
    allowautopickup = 1;
  }

  if(ammocount <= 0) {
    return;
  }

  var_e4a801494bedfff2 = self.equipment[slot];
  var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, var_e4a801494bedfff2);

  if(isDefined(var_feb782334dd23a66)) {
    function_73ffc9bcd6d1e62d(fromkiosk);
    var_3f21d3481e99b84b = 1;
    scriptablename = level.br_pickups.br_equipnametoscriptable[var_e4a801494bedfff2];

    if(isDefined(scriptablename) && istrue(level.br_pickups.var_c125a0ed111f1b8d[scriptablename])) {
      var_3f21d3481e99b84b = 0;
    }

    if(isDefined(var_db943473454f6ea6) && var_3f21d3481e99b84b) {
      lootid = loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      fakepickup = spawnStruct();
      fakepickup.scriptablename = namespace_e50e624d9af51c8c::function_91c1be871300a518(lootid);
      fakepickup.count = ammocount;
      namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup, undefined, undefined, fromkiosk);
      return;
    }

    var_285b7129b392cf3d = 0;
    lootid = loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
    scriptablename = namespace_e50e624d9af51c8c::function_91c1be871300a518(lootid);

    if(isDefined(itemtype)) {
      var_285b7129b392cf3d = quickdropaddtoexisting(itemtype, scriptablename, ammocount);
    }

    if(var_285b7129b392cf3d) {
      return;
    }

    overridedist = undefined;
    overrideorigin = undefined;

    if(isDefined(pickup)) {
      if(isDefined(pickup.distanceoverride)) {
        overridedist = pickup.distanceoverride;
      }

      if(isDefined(pickup.origin)) {
        overrideorigin = pickup.origin;
      }
    }

    baseorigin = self.origin;
    baseangles = self.angles;
    yawoffsetoverride = level.br_pickups.yawoffsetoverride;

    if(istrue(fromkiosk) && isDefined(self.br_kiosk)) {
      baseorigin = utility::default_to(self.br_kiosk.centerbottom, self.br_kiosk.origin);
      baseangles = self.br_kiosk.angles;
      yawoffsetoverride = undefined;

      if(isDefined(self.br_kiosk.linkedparent)) {
        baseorigin = self.br_kiosk.linkedparent.origin + rotatevector(baseorigin, self.br_kiosk.linkedparent.angles);
      }
    }

    dropinfo = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, yawoffsetoverride, overridedist, undefined, undefined, overrideorigin);

    if(issuperpickup(scriptablename)) {
      allowautopickup = getdvarint(@ "hash_8c7fd24cb9dc68f0", 1) || allowautopickup && isalive(self);
    }

    item = spawnpickup(var_feb782334dd23a66, dropinfo, ammocount, 1, undefined, allowautopickup);
    quickdropaddtocache(scriptablename, slot, item, dropinfo.origin, dropinfo.angles);
    function_2f4e0022c686dbe6(item);

    if(istrue(dropfeedback)) {
      quickdropplaySound(itemtype, dropinfo.origin, scriptablename, item);
    }

    var_a05e9a22f608680d = getcallback(self.equipment[slot], "onDropped");

    if(isDefined(var_a05e9a22f608680d)) {
      self thread[[var_a05e9a22f608680d]](self.equipment[slot], slot);
    }

    namespace_e50e624d9af51c8c::function_c6306ea9715dd8f1(self, slot);
  }
}

function pickupissameasequipmentslot(equipname, equipmentslot) {
  if(isDefined(self.equipment[equipmentslot]) && self.equipment[equipmentslot] == equipname) {
    return true;
  }

  return false;
}

function equipmentslothasroom(scriptablename, equipmentslot) {
  equip_ref = level.br_pickups.br_equipname[scriptablename];

  if(isDefined(equip_ref) && equipment::getequipmentslotammo(equipmentslot) < equipment::getequipmentmaxammo(equip_ref)) {
    return true;
  }

  return false;
}

function function_e52b0b5ab01dfa0c(lootname, var_257c3db6f4bfdd81) {
  lootid = loot::function_fae5e1d3de32d3f7(lootname);
  currentitemcount = namespace_e50e624d9af51c8c::gettotalitemcountinbag(lootid);
  itemstackcount = 0;
  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount) || maxcount == 0) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  if(maxcount > 0) {
    itemstackcount = floor(currentitemcount / maxcount);
  }

  if(itemstackcount >= var_257c3db6f4bfdd81) {
    return false;
  }

  return true;
}

function takerespawntokenpickup(pickupent) {
  if(!respawntokendisabled() && !br_public::hasrespawntoken()) {
    addrespawntoken();
    return true;
  }

  return false;
}

function addrespawntoken(skipsplash) {
  player = self;
  assert(!istrue(player.hasrespawntoken));
  player.hasrespawntoken = 1;
  player br_public::sethasrespawntokenextrainfo(1);

  if(!istrue(skipsplash)) {
    player thread hud_message::showsplash("br_respawn_token_pickup");
  }
}

function removerespawntoken() {
  player = self;
  assert(istrue(player.hasrespawntoken));
  player.hasrespawntoken = 0;
  player br_public::sethasrespawntokenextrainfo(0);
}

function function_68c46fe15ed38d9b(pickupent) {
  if(!br_public::function_8b2396647673be50() && istrue(level.usegulag)) {
    if(!br_public::function_15da77dc195bd80a()) {
      function_127474f04c3a06b5();
      return true;
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickupent.scriptablename)) {
      lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
      namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
      return true;
    }
  }

  return false;
}

function function_127474f04c3a06b5(skipsplash) {
  player = self;
  assert(!istrue(player.var_15da77dc195bd80a));
  player.var_15da77dc195bd80a = 1;
  player br_public::function_e58801acf7adcdc8(1);

  if(!istrue(skipsplash)) {
    player thread hud_message::showsplash("br_gulag_token_pickup");
  }
}

function function_17e127f2e3771058() {
  player = self;
  assert(istrue(player.var_15da77dc195bd80a));
  player.var_15da77dc195bd80a = 0;
  player br_public::function_e58801acf7adcdc8(0);
}

function takerevivepickup(pickupent, itemslotindex, backpackequip) {
  if(!br_public::hasselfrevivetoken() || br_public::hasselfrevivetoken() && !br_public::function_723bd1ab3bb16b2b(self, pickupent.scriptablename)) {
    revivelootid = scripts\cp_mp\utility\loot::getlootidfromref(pickupent.scriptablename);
    addselfrevivetoken(undefined, revivelootid, itemslotindex, backpackequip);
    return true;
  }

  return false;
}

function function_966d64f200872160(pickupent) {
  player = self;

  if(!isDefined(player.var_61c274a3bd736bed)) {
    player.var_61c274a3bd736bed = [];
  }

  player.var_61c274a3bd736bed[player.var_61c274a3bd736bed.size] = pickupent.scriptablename;
  return true;
}

function function_ebf82cde71707ec8(var_eb0a92127237346e) {
  player = self;
  itemname = removesubstr(var_eb0a92127237346e, "_voucher");
  var_7a704a1d0652ab82 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(itemname);
  lootitem(var_7a704a1d0652ab82, 1, undefined, 1, undefined, undefined, undefined, undefined, 0, undefined, 1);
}

function function_aaaa1b3dfe18885c(skipsplash, revivelootid, itemslotindex, backpackequip) {
  player = self;
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(revivelootid);

  if(player br_public::hasselfrevivetoken() && !br_public::function_723bd1ab3bb16b2b(player, scriptablename)) {
    if(istrue(backpackequip) && isDefined(itemslotindex)) {
      var_bf28fcd9dfeac57e = br_public::function_791e72676cd7b544(player);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_bf28fcd9dfeac57e);
      namespace_aead94004cf4c147::function_3c3ee4c5700e0e32(player, itemslotindex, lootid, 1, 65535, 3);
      player removeselfrevivetoken();
    } else {
      dropstruct = function_7b9f3966a7a42003();
      player dropbrselfrevivetoken(dropstruct);
    }
  } else if(istrue(backpackequip) && isDefined(itemslotindex)) {
    player namespace_aead94004cf4c147::function_db1dd76061352e5b(itemslotindex);
  }

  player.var_6c05b62d5521a0b2 = spawnStruct();
  player.var_6c05b62d5521a0b2.name = scriptablename;
  player.var_6c05b62d5521a0b2.type = br_public::function_56733d929b67a814(scriptablename);
  player.var_6c05b62d5521a0b2.perk = br_public::function_8e65095b82c19d04(scriptablename);
  player setclientomnvar("ui_br_self_revive_type", player.var_6c05b62d5521a0b2.type);

  if(isDefined(player.var_6c05b62d5521a0b2.perk)) {
    player scripts\mp\utility\perk::giveperk(player.var_6c05b62d5521a0b2.perk);
  }

  player br_public::sethasselfrevivetokenextrainfo(1);

  if(!istrue(skipsplash)) {
    player thread hud_message::showsplash("br_self_revive_token_pickup");
  }

  issolos = level.maxteamsize == 1;

  if(issolos && !player perk::_hasperk("specialty_pistoldeath")) {
    player perk::giveperk("specialty_pistoldeath");
  }
}

function addselfrevivetoken(skipsplash, revivelootid, itemslotindex, backpackequip) {
  if(!isDefined(revivelootid)) {
    revivelootid = 8548;
  }

  function_aaaa1b3dfe18885c(skipsplash, revivelootid, itemslotindex, backpackequip);
  namespace_b16531563568eaba::function_c0ae57d4dc3a8eef(self, revivelootid);
  level notify("picked_up_item_brloot_self_revive_" + self.team, self);
}

function removeselfrevivetoken() {
  player = self;

  if(player br_public::hasselfrevivetoken()) {
    currentperk = br_public::function_7285c46ee8b26043(player);

    if(isDefined(currentperk) && player scripts\mp\utility\perk::_hasperk(currentperk)) {
      player scripts\mp\utility\perk::removeperk(currentperk);
    }

    player br_public::sethasselfrevivetokenextrainfo(0);
    issolos = level.maxteamsize == 1;

    if(issolos && player perk::_hasperk("specialty_pistoldeath")) {
      player perk::removeperk("specialty_pistoldeath");
    }

    namespace_b16531563568eaba::function_a60428cda4724a7(self);
    player.var_6c05b62d5521a0b2 = undefined;
  }
}

function respawntokendisabled() {
  tokendisabled = !istrue(level.br_pickups.respawntokenenabled);
  var_1f53ada6cb3669b = istrue(level.br_pickups.respawntokenclosewithgulag) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
  resurgencedisabled = istrue(level.br_pickups.var_a181de0ed6a505d5) && isDefined(level.brgametype.respawnenable) && !istrue(level.brgametype.respawnenable);
  return getdvarint(@ "hash_4d250e4873e1753e", 0) || tokendisabled || var_1f53ada6cb3669b || resurgencedisabled;
}

function fillmaxarmorplate() {
  player = self;
  fakepickup = spawnStruct();
  fakepickup.scriptablename = "brloot_armor_plate";
  fakepickup.equipname = level.br_pickups.br_equipname[fakepickup.scriptablename];
  fakepickup.origin = self.origin;
  fakepickup.maxcount = equipment::getequipmentmaxammo(fakepickup.equipname);
  fakepickup.count = fakepickup.maxcount;
  fakepickup.stackable = level.br_pickups.stackable[fakepickup.scriptablename];
  player takeequipmentpickup(fakepickup);
}

function takeaccesscardpickup(pickupent) {
  if(br_public::hasaccesscard()) {
    dropstruct = function_7b9f3966a7a42003();
    yawoffsetoverride = undefined;
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, yawoffsetoverride, pickupent.overridedist, undefined, undefined, pickupent.origin);
    spawnpickup(self.accesscard, dropinfo, 1, 1);
  }

  addaccesscard(pickupent.scriptablename);
}

function addaccesscard(cardtype) {
  player = self;
  player.accesscard = cardtype;
  var_4dc292c559481471 = int(tablelookup("mp/braccess_card.csv", 1, cardtype, 0));
  player br_public::updatebrscoreboardstat("bunkerKeycardType", var_4dc292c559481471);
}

function removeaccesscard() {
  player = self;

  if(!getdvarint(@ "hash_8c6e1c43e3d41dd3", 0)) {
    assert(br_public::hasaccesscard());
  }

  player.accesscard = undefined;
  player br_public::updatebrscoreboardstat("bunkerKeycardType", 0);
}

function function_7cb3c8630787467e(item) {
  player = self;

  if(!isDefined(player.persistentitems)) {
    player.persistentitems = [];
  }

  if(istrue(player.persistentitems[item])) {
    script::demoforcesre("Trying to give persistent item player already has. Item: \"" + item + "\"");
    return;
  }

  player.persistentitems[item] = 1;
  omnvarvalue = player getclientomnvar("ui_persistent_item_status");
  itembit = player br_plunder::function_5efeff555d3c3ab4(item);
  omnvarvalue += 1 << itembit;
  player setclientomnvar("ui_persistent_item_status", omnvarvalue);
}

function function_b53322f9aca1b83b(item) {
  player = self;

  if(!isDefined(player.persistentitems) || !istrue(player.persistentitems[item])) {
    script::demoforcesre("Trying to take persistent item player doesn't have. Item: \"" + item + "\"");
    return;
  }

  player.persistentitems[item] = undefined;
  omnvarvalue = player getclientomnvar("ui_persistent_item_status");
  itembit = player br_plunder::function_5efeff555d3c3ab4(item);
  omnvarvalue -= 1 << itembit;
  player setclientomnvar("ui_persistent_item_status", omnvarvalue);
}

function function_e351a4b1c26ec991(item) {
  player = self;

  if(!isDefined(player.persistentitems)) {
    return false;
  }

  return istrue(player.persistentitems[item]);
}

function function_b379c8b0a6564107(pickupent) {
  lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  namespace_e50e624d9af51c8c::additemtobackpack(lootid, pickupent);
}

function takedogtag(pickupent) {}

function takexp(pickupent) {
  thread points::doscoreevent(#"dmz_loot_xp");
  thread hud_message::showsplash("dmz_loot_xp");
  damagefeedback::hudicontype("xp_pickup");
  pickupent.instance disablescriptableplayeruse(self);
}

function function_ed254d7be7ff977a(pickupent) {
  var_a89e936650684174 = 0;

  if(pickupent namespace_2d7f47b19ccdb41d::function_5facfbee97e1a98e()) {
    var_a89e936650684174 = pickupent namespace_2d7f47b19ccdb41d::function_699d3afb882fd365();
  }

  var_a88e9f0add4feeb3 = 0;

  if(pickupent namespace_2d7f47b19ccdb41d::function_668fa8d4516f7e15()) {
    var_a88e9f0add4feeb3 = pickupent namespace_2d7f47b19ccdb41d::function_bd7732605a7843b2(self);
  }

  shouldpickup = var_a89e936650684174 || var_a88e9f0add4feeb3;
  elementname = pickupent namespace_2d7f47b19ccdb41d::function_10949665efa60b20();

  if(isDefined(elementname) && istrue(shouldpickup)) {
    if(!pickupent namespace_2d7f47b19ccdb41d::function_d0daea8e27167bf7(self)) {
      return 33;
    }

    pickupent.scriptablename = elementname;
  }

  if(istrue(shouldpickup)) {
    return function_cbbf9bf3544dc456(pickupent);
  }

  pickupent.instance.count = 1;
  return 1;
}

function forcegivekillstreak(killstreakref, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6, backpackequip, pickup) {
  self notify("cancel_all_killstreak_deployments");

  if(istrue(droppurchased)) {
    dropstruct = function_7b9f3966a7a42003();

    if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      slotindex = self.br_kiosk function_4f4d537c794b2bf5();
      self.br_kiosk.dropstruct.dropidx = slotindex;
      dropstruct = self.br_kiosk.dropstruct;
    }

    function_aa702bcdeeb2b827(dropstruct, fromkiosk, droppurchased, killstreakref, pickup);
    return;
  }

  if(istrue(backpackequip) && isDefined(var_db943473454f6ea6)) {
    namespace_e50e624d9af51c8c::function_db1dd76061352e5b(var_db943473454f6ea6);
  }

  if(istrue(dropcurrent)) {
    dropstruct = function_7b9f3966a7a42003();

    if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      slotindex = self.br_kiosk function_4f4d537c794b2bf5();
      self.br_kiosk.dropstruct.dropidx = slotindex;
      dropstruct = self.br_kiosk.dropstruct;
    }

    dropbrkillstreak(dropstruct, fromkiosk, var_db943473454f6ea6, undefined, pickup);

    if(isDefined(var_db943473454f6ea6)) {
      namespace_b16531563568eaba::function_28550536ebafe216(self);
    }
  } else {
    killstreaks::removekillstreak(1);
  }

  killstreaks::awardkillstreak(killstreakref, "other", undefined, undefined, undefined, 1);
  lootid = loot::function_fae5e1d3de32d3f7(loot::function_b88cfb4893ceedac(killstreakref));
  namespace_b16531563568eaba::function_aa051314f7cdab4e(self, lootid);
}

function takekillstreakpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  killstreakref = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];
  assert(isDefined(killstreakref));
  forcegivekillstreak(killstreakref, 1, fromkiosk, 0, var_db943473454f6ea6, backpackequip, pickupent);
}

function hasanykillstreak() {
  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0) {
    return isDefined(self.streakdata.streaks[1]);
  }

  return false;
}

function haskillstreak(killstreakref) {
  return hasanykillstreak() && self.streakdata.streaks[1].streakname == killstreakref;
}

function iskillstreakavailable(killstreakref) {
  if(haskillstreak(killstreakref)) {
    streakitem = self.streakdata.streaks[1];
    return (streakitem.available == 1);
  }

  return false;
}

function function_381d14fb6e6aca9a(killstreakref) {
  setupinfo = killstreaks::getkillstreaksetupinfo(killstreakref);

  if(isDefined(setupinfo) && isDefined(setupinfo.var_b1469bcdaec75a9)) {
    self[[setupinfo.var_b1469bcdaec75a9]]();
  }
}

function forceusekillstreak(killstreakref) {
  if(hasanykillstreak()) {
    killstreaks::removekillstreak(1);
  }

  killstreaks::awardkillstreak(killstreakref, "other");
  streakitem = killstreaks::getkillstreakinslot(1);
  usesuccess = killstreaks::triggerkillstreak(streakitem, 1);

  if(!usesuccess) {
    killstreaks::removekillstreak(1);
  }

  return usesuccess;
}

function _givebrsuper(equipname, supername, supercount) {
  if(level.allowsupers || istrue(self.var_678855513f5076ca) && !supers::function_f95bcca44e8cba53(supername)) {
    perkpackage::perkpackage_giveoverridefieldupgrades(supername);
    supers::function_8c7b1312cf5986b(0);
    supercount = supers::getcurrentsuperpoints() >= supers::getsuperpointsneeded();
  } else {
    function_9ec0d84bc12b8d15(supername);
    self setclientomnvar("ui_perk_package_state", 3);
    self setclientomnvar("ui_perk_package_super1", supers::getsuperid(supername));
    thread scripts\mp\supers::function_93b5448ea8f6277b(1);
    thread scripts\mp\supers::handlesuperuistatechange(2);
  }

  if(isDefined(equipname)) {
    equipment::giveequipment(equipname, "super");
    equipment::setequipmentammo(equipname, supercount);
  }
}

function function_9ec0d84bc12b8d15(supername) {
  perkpackage_giveimmediate(supername);
  self.var_1066fbd86c88a6df = 1;
  thread function_390eaf44f2e0f0cc(supername);

  if(isDefined(self.super.staticdata.var_70b09ed29c10732f)) {
    self thread[[self.super.staticdata.var_70b09ed29c10732f]]();
  }
}

function function_390eaf44f2e0f0cc(supername) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_perk_package_state", 3);
  self setclientomnvar("ui_perk_package_super1", scripts\mp\supers::getsuperid(supername));
  thread scripts\mp\supers::function_93b5448ea8f6277b(1);
  thread scripts\mp\supers::handlesuperuistatechange(2);
}

function function_1615eaec0c470f4f(equipname, supername) {
  self.var_1066fbd86c88a6df = 1;
  self setclientomnvar("ui_perk_package_state", 3);
  self setclientomnvar("ui_perk_package_super1", supers::getsuperid(supername));
  thread scripts\mp\supers::function_93b5448ea8f6277b(1);
  thread scripts\mp\supers::handlesuperuistatechange(2);

  if(isDefined(equipname)) {
    equipment::setequipmentammo(equipname, 1);
  }
}

function function_fcde72dcbcec206b(fordrop) {
  superinfo = supers::getcurrentsuper();

  if(!isDefined(superinfo)) {
    return undefined;
  }

  if(isDefined(superinfo.staticdata.useweapon)) {
    return supers::function_3889d69492a93008();
  }

  if(isDefined(superinfo.staticdata.ref) && issharedfuncdefined(superinfo.staticdata.ref, "getAmmo", 0)) {
    return [[getsharedfunc(superinfo.staticdata.ref, "getAmmo")]]();
  }

  if(istrue(fordrop)) {
    return equipment::function_fe48baf929906883("super");
  }

  return equipment::getequipmentslotammo("super");
}

function function_add28651639056b9() {
  bulletsfired = supers::function_45c01cf6ebb2ba62();
  var_eec1b23802e9c80b = supers::getsuperpointsneeded();
  pointsreduced = supers::function_395a9cb3ebe25d55(self.super) * bulletsfired * var_eec1b23802e9c80b;
  supers::setsuperbasepoints(var_eec1b23802e9c80b - pointsreduced, undefined, 1);
}

function function_23ac735f86c58bf4() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("super_started");
  self endon("remove_super");
  wait 0.05;
  self setclientomnvar("ui_super_can_use", 1);
}

function takesuperpickup(pickupent, fromkiosk, var_db943473454f6ea6) {
  equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  supername = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];
  lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  var_d539af51a08b192d = 0;

  if(isDefined(self.super) && perkfunctions::function_66f0cbd5ff8458fe()) {
    var_d539af51a08b192d = supers::getcurrentsuperpoints() >= supers::getsuperpointsneeded();
  }

  if(isDefined(var_db943473454f6ea6)) {
    namespace_e50e624d9af51c8c::function_84772ebf836af5db(var_db943473454f6ea6, pickupent.count * -1);
    namespace_b16531563568eaba::function_351fe4ac57ca37e5(self, "super");
  }

  if(function_df3f5431c93ed5a1(undefined, pickupent.scriptablename) && scripts\mp\gametypes\br_gametype_truckwar::function_59566a4ce3c2c3e2()) {
    scripts\mp\gametypes\br_gametype_truckwar::function_60d5992f51286201();
  }

  if(isDefined(self.equipment["super"])) {
    if(scripts\mp\equipment::function_fe48baf929906883("super") > 0 || var_d539af51a08b192d || scripts\mp\supers::isusingsuperweapon()) {
      dropstruct = function_7b9f3966a7a42003();
      dropequipmentinslot(dropstruct, "super", fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined, pickupent);
    }
  }

  _givebrsuper(equipname, supername, pickupent.count);

  if(function_1be34022a4acce73(pickupent.scriptablename)) {
    supers::function_60e9ab8c0ad6a01c(pickupent.count, "all");
    function_add28651639056b9();
  }

  namespace_b16531563568eaba::function_f5b2810055f85ead(self, "super", lootid);

  if((level.allowsupers || perkfunctions::function_66f0cbd5ff8458fe()) && !(equipment::getequipmentslotammo("super") > 0)) {
    supers::givesuperpoints(supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
  }

  self notify("br_pickup_super");
}

function forcegivesuper(targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6) {
  if(istrue(level.var_d040719163e20394) && targetsupername == "none") {
    return;
  }

  if(targetsupername == "none" && game_utility::function_fa7bfcc1d68b7b73()) {
    return;
  }

  if(issharedfuncdefined(targetsupername, "forceGiveSuper")) {
    targetsupername = self[[getsharedfunc(targetsupername, "forceGiveSuper")]](targetsupername);
  }

  var_733d60a5f3a8c170 = undefined;

  foreach(scriptablename, supername in level.br_pickups.var_14bd11727c4b6629) {
    if(supername == targetsupername) {
      var_733d60a5f3a8c170 = scriptablename;
      break;
    }
  }

  if(!isDefined(var_733d60a5f3a8c170)) {
    println("<dev string:x2d2>" + utility::default_to(targetsupername, "<dev string:x222>") + "<dev string:x2f2>");
  }

  var_878c13a767e1d193 = undefined;
  supercount = 1;

  if(isDefined(var_733d60a5f3a8c170) && !game_utility::function_9cdaadfddeda4d7a()) {
    var_878c13a767e1d193 = level.br_pickups.br_equipname[var_733d60a5f3a8c170];
    assertex(isDefined(var_878c13a767e1d193), "<dev string:x32e>" + var_733d60a5f3a8c170 + "<dev string:x343>");

    if(istrue(droppurchased)) {
      dropbrequipment(fromkiosk, droppurchased, var_878c13a767e1d193);
      return;
    }

    assertex(isDefined(var_878c13a767e1d193), "<dev string:x32e>" + var_733d60a5f3a8c170 + "<dev string:x343>");

    if(istrue(droppurchased)) {
      dropstruct = function_7b9f3966a7a42003();

      if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
        slotindex = self.br_kiosk function_4f4d537c794b2bf5();
        self.br_kiosk.dropstruct.dropidx = slotindex;
        dropstruct = self.br_kiosk.dropstruct;
      }

      dropbrequipment(dropstruct, fromkiosk, droppurchased, var_878c13a767e1d193);
      return;
    }

    if(istrue(dropcurrent)) {
      if(isDefined(self.equipment["super"]) && equipment::getequipmentslotammo("super") > 0) {
        dropstruct = function_7b9f3966a7a42003();

        if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
          slotindex = self.br_kiosk function_4f4d537c794b2bf5();
          self.br_kiosk.dropstruct.dropidx = slotindex;
          dropstruct = self.br_kiosk.dropstruct;
        }

        dropequipmentinslot(dropstruct, "super", fromkiosk, undefined, var_db943473454f6ea6, undefined, undefined, undefined);
      }
    }
  }

  if(istrue(fromkiosk) && issharedfuncdefined(targetsupername, "getPurchasedCount")) {
    supercount = self[[getsharedfunc(targetsupername, "getPurchasedCount")]]();
  }

  _givebrsuper(var_878c13a767e1d193, targetsupername, supercount);

  if(function_1be34022a4acce73(var_733d60a5f3a8c170)) {
    supers::function_60e9ab8c0ad6a01c(supercount, "all");
    function_add28651639056b9();
  }
}

function takeperkpickup(scriptablename, fromkiosk, var_db943473454f6ea6, backpackequip) {
  perkref = level.br_pickups.var_14bd11727c4b6629[scriptablename];
  assert(isDefined(perkref));
  forcegiveperk(perkref, 1, fromkiosk, var_db943473454f6ea6, backpackequip);
  thread function_831b0b5a495499ef(perkref);
}

function forcegiveperk(perkref, dropcurrent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  if(istrue(backpackequip) && isDefined(var_db943473454f6ea6)) {
    namespace_e50e624d9af51c8c::function_db1dd76061352e5b(var_db943473454f6ea6);
  }

  if(istrue(dropcurrent)) {
    dropstruct = function_7b9f3966a7a42003();

    if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      slotindex = self.br_kiosk function_4f4d537c794b2bf5();
      self.br_kiosk.dropstruct.dropidx = slotindex;
      dropstruct = self.br_kiosk.dropstruct;
    }
  }

  perk::giveperk(perkref);
}

function on_player_death(params) {
  params.victim namespace_dfe80adf32f5c14a::function_4ab14e281240f204();
  params.victim namespace_dfe80adf32f5c14a::function_c7b1bf955226c91a();
}

function function_a26bbfa747602ee1(scriptablename) {
  itemref = level.br_pickups.var_14bd11727c4b6629[scriptablename];

  switch (itemref) {
    case #"hash_2c9395bfba7d8880":
    case #"hash_3155348f209a4ee3":
    case #"hash_57ebf8ef67187ec7":
    case #"hash_ac736f279bf91dc5":
      if(!istrue(level.var_b18569a63dc2a99f)) {
        namespace_dfe80adf32f5c14a::function_6fe662f22a144740();
        level scripts\common\callbacks::add("player_death", &on_player_death);
        level.var_b18569a63dc2a99f = 1;
      }

      thread namespace_dfe80adf32f5c14a::apply_powerup(itemref);
      break;
    case #"hash_560ea2939c546227":
      if(issharedfuncdefined("limbo", "limbo_become_mutant")) {
        self thread[[getsharedfunc("limbo", "limbo_become_mutant")]]("mutant_sneaker_br");
      }

      break;
  }
}

function function_5658dce20f11e8c4() {
  if(!isDefined(level.headgeardata)) {
    level waittill("headgear_init");
  }

  var_807c55ed4bcc246e = spawnStruct();
  var_807c55ed4bcc246e.var_4fe5d2ab2f7dbd0 = &gasmask::hasgasmask;
  var_807c55ed4bcc246e.var_8965dea27a03f00f = &gasmask::function_260708c89a11f0c3;
  var_807c55ed4bcc246e.var_10b068badc49b1ad = &function_b52a59a4c073153c;
  var_807c55ed4bcc246e.var_d2148115f2c3c399 = &gasmask::function_d036366985435d3;
  var_807c55ed4bcc246e.var_9b9af82c327f6a63 = &gasmask::function_385d397d3fab6715;
  var_807c55ed4bcc246e.var_8928676cf7288c90 = &gasmask::function_2bcab76045fdd1fa;
  var_807c55ed4bcc246e.var_f830d658f5f0af18 = &gasmask::init;
  var_807c55ed4bcc246e.breakfunc = &breakgasmaskbr;
  var_807c55ed4bcc246e.var_fe0fd9391666371 = &function_8e9b00a1d2b23d72;
  var_807c55ed4bcc246e.var_bb61027a51ec1e05 = &function_75520ea44545c906;
  var_807c55ed4bcc246e.var_a7d8d38f4018a344 = &function_d27ef4a025f725ff;
  var_807c55ed4bcc246e.var_4aeed0bec3628793 = &function_c2d0fcc8985b5209;
  var_807c55ed4bcc246e.var_2cb986fd5f1717f0 = &function_e25fbc6849d4c2fb;
  var_807c55ed4bcc246e.var_573fe16545e70f6a = &function_ace3bd9b1c5be1b5;
  br_headgear::registerheadgear("gas_mask", var_807c55ed4bcc246e);
}

function function_9cbd64a86452a4df(headgeartype, pickupent, fromkiosk, itemslotindex, backpackequip) {
  if(!br_headgear::function_27c9f3cd0731b4c0(headgeartype)) {
    return;
  }

  if(istrue(backpackequip) && isDefined(itemslotindex)) {
    namespace_e50e624d9af51c8c::function_db1dd76061352e5b(itemslotindex);
  }

  if(!isDefined(pickupent.count) || pickupent.count <= 0) {
    return;
  }

  if(br_headgear::function_48c7a8ee781fbf56(self)) {
    var_9b80a5cc3b03821b = br_headgear::function_5ecd6df2572a5899(self.headgeartype, self);
    var_93d8e637e6795a3d = br_headgear::function_5109f3947b0c7dfb(self.headgeartype, self);
    var_bcc562a93657d3c0 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_9b80a5cc3b03821b);
    var_b5eca7b860554273 = var_9b80a5cc3b03821b;
    var_f894ac8ba04fe76d = var_93d8e637e6795a3d;
    var_2365aeea4341a770 = var_bcc562a93657d3c0;
    var_dfd3db8653da1c23 = self.headgeartype == headgeartype && br_headgear::function_d036366985435d3(headgeartype, self, pickupent) || istrue(backpackequip);

    if(!var_dfd3db8653da1c23) {
      var_b5eca7b860554273 = pickupent.scriptablename;
      var_f894ac8ba04fe76d = pickupent.count;
      var_2365aeea4341a770 = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_b5eca7b860554273);
    }

    function_73ffc9bcd6d1e62d(fromkiosk);
    dodrop = !istrue(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(var_b5eca7b860554273));

    if(!istrue(dodrop)) {
      if(!istrue(backpackequip)) {
        index = namespace_e50e624d9af51c8c::getavailabledmzbackpackindex();

        if(isDefined(index)) {
          namespace_aead94004cf4c147::function_11f48ae5b87b4525(self, index, var_2365aeea4341a770, int(var_f894ac8ba04fe76d));
        } else {
          dodrop = 1;
        }
      } else {
        namespace_aead94004cf4c147::function_11f48ae5b87b4525(self, itemslotindex, var_2365aeea4341a770, int(var_f894ac8ba04fe76d));
      }
    }

    if(istrue(dodrop)) {
      dropstruct = function_7b9f3966a7a42003();
      overridedist = utility::ter_op(isDefined(pickupent.overridedist), pickupent.overridedist, level.br_pickups.distanceoverride);
      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, overridedist, undefined, undefined, pickupent.origin);
      var_aa825dbcbd2edbfd = spawnpickup(var_b5eca7b860554273, dropinfo, int(var_f894ac8ba04fe76d), 1);

      if(br_public::isplayeringulag()) {
        var_aa825dbcbd2edbfd.var_1b46a808091ea19c = 1;
      }
    }

    if(!var_dfd3db8653da1c23) {
      return;
    }

    br_headgear::function_46a4f41002ccc37d(self, self.headgeartype, "br_circle");
    namespace_b16531563568eaba::function_55dc9108a9301e59(self);
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
  namespace_b16531563568eaba::function_2dd07f0034a0fed1(self, lootid);
  br_headgear::function_a34e6737707000de(headgeartype, self, pickupent.count, pickupent.scriptablename);

  if(br_headgear::function_c210b50cd31a3bc2(headgeartype)) {
    br_headgear::function_3ee77b6233481af9(headgeartype, "br_circle");
  }

  var_b9f31e3efe413baf = 0;

  if(headgeartype == "gas_mask") {
    var_b9f31e3efe413baf = ter_op(pickupent.scriptablename == "brloot_equip_gasmask_durable", 2, 1);
  } else if(headgeartype == "helmet") {
    var_b9f31e3efe413baf = 3;
  }

  assertex(var_b9f31e3efe413baf != 0, "<dev string:x38a>");
  br_public::updatebrscoreboardstat("headGearType", var_b9f31e3efe413baf);
  level notify("picked_up_item_" + pickupent.scriptablename + "_" + self.team, self);
}

function function_b52a59a4c073153c() {
  if(!isDefined(self.var_e79884673ac9666e)) {
    self.var_e79884673ac9666e = !self function_6dc7592b72983dc0();

    if(getdvarint(@ "hash_bdc7d2a2f17bd58e", 0) == 1) {
      self.var_e79884673ac9666e = getdvarint(@ "hash_f221cc8f9519efe", 1);
    }
  }

  return istrue(self.var_e79884673ac9666e);
}

function takegasmask(pickupent, fromkiosk, itemslotindex, backpackequip) {
  function_9cbd64a86452a4df("gas_mask", pickupent, fromkiosk, itemslotindex, backpackequip);
}

function function_cdf7f2f6bd3207(request) {
  scripts\mp\gametypes\br_headgear::function_3ee77b6233481af9("gas_mask", request);
}

function function_8206bc54a1ed73cb(request) {
  scripts\mp\gametypes\br_headgear::function_9f52e7f6c7bae335("gas_mask", request);
}

function function_f213f06eba604bbd(player) {
  delaygesture = 0;
  delaygesture |= player isreloading();
  delaygesture |= player isthrowinggrenade();
  delaygesture |= player isdiving();
  delaygesture |= player issprintsliding();
  delaygesture |= player player::isplayerads();
  return delaygesture;
}

function canplaygasmaskgesturebr() {
  player = self;
  preventgesture = 0;
  preventgesture |= player isinfreefall();
  preventgesture |= player isskydiving();
  preventgesture |= player isparachuting();
  preventgesture |= player isbasejumpavailable();
  preventgesture |= player ismantling();
  return !preventgesture;
}

function equipgasmaskbr() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskhealth) || self.gasmaskhealth == 0) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_on_plr", self);
  self.gasmaskswapinprogress = 1;
  thread delayedattach(0.2);
  var_9f955950f47f8532 = self getgestureanimlength("iw9_vm_ges_gasmask_on");
  overlayfadetime = var_9f955950f47f8532 * 0.35;
  assert(0.2 < var_9f955950f47f8532);

  if(canplaygasmaskgesturebr()) {
    thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_on", var_9f955950f47f8532);
  }

  self setclientomnvar("ui_gas_mask", 2);
  thread function_4f2124298797aded(level.var_1170cfb92432a61d, overlayfadetime);
  wait var_9f955950f47f8532;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  self.gasmaskequipped = 1;
  white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("gasmask_male");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    if(!istrue(self.var_e79884673ac9666e)) {
      breakgasmaskbr();
    }
  }
}

function function_d27ef4a025f725ff() {
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  thread delayedattach(0.2);
  var_9f955950f47f8532 = self getgestureanimlength("iw9_vm_ges_gasmask_on");
  overlayfadetime = var_9f955950f47f8532 * 0.35;
  assert(0.2 < var_9f955950f47f8532);

  if(canplaygasmaskgesturebr()) {
    thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_on", var_9f955950f47f8532);
  }

  self setclientomnvar("ui_gas_mask", 2);
  thread function_4f2124298797aded(level.var_1170cfb92432a61d, overlayfadetime);
  wait var_9f955950f47f8532;
}

function function_c2d0fcc8985b5209() {
  self.gasmaskequipped = 1;
  white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("gasmask_male");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    if(!istrue(self.var_e79884673ac9666e)) {
      breakgasmaskbr();
    }
  }
}

function removegasmaskbr() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped) && !istrue(self.var_e79884673ac9666e)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_off_plr", self);
  fadeouttime = self getgestureanimlength("iw9_vm_ges_gasmask_off");
  overlayfadetime = fadeouttime * 0.35;
  thread delayeddetach(1.3);

  if(canplaygasmaskgesturebr()) {
    if(istrue(self.var_e79884673ac9666e)) {
      if(gasmask::function_27e68abe09612a13(self)) {
        thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", fadeouttime);
      } else {
        thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_break", fadeouttime);
      }
    } else {
      thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", fadeouttime);
    }
  }

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 1);
  thread function_4f2124298797aded(0, overlayfadetime);
  wait fadeouttime;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    if(!istrue(self.var_e79884673ac9666e)) {
      function_4d16b9c52efa3b8();
    }
  }
}

function function_e25fbc6849d4c2fb() {
  self playsoundtoplayer("br_gas_mask_off_plr", self);
  fadeouttime = self getgestureanimlength("iw9_vm_ges_gasmask_off");
  overlayfadetime = fadeouttime * 0.35;
  thread delayeddetach(1.3);

  if(canplaygasmaskgesturebr()) {
    if(istrue(self.var_e79884673ac9666e)) {
      if(gasmask::function_27e68abe09612a13(self)) {
        thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", fadeouttime);
      } else {
        thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_break", fadeouttime);
      }
    } else {
      thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", fadeouttime);
    }
  }

  self setclientomnvar("ui_gas_mask", 1);
  thread function_4f2124298797aded(0, overlayfadetime);
  wait fadeouttime;
}

function function_ace3bd9b1c5be1b5() {
  white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    if(!istrue(self.var_e79884673ac9666e)) {
      function_4d16b9c52efa3b8();
    }
  }
}

function breakgasmaskbr(attacker) {
  if(!isDefined(self.gasmaskhealth)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_break_plr", self);

  if(!istrue(self.var_e79884673ac9666e)) {
    thread delayeddetachbreak(0.6);
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("");
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);

  if(!istrue(self.var_e79884673ac9666e)) {
    function_4d16b9c52efa3b8();
    fadeouttime = self getgestureanimlength("iw9_vm_ges_gasmask_break");
    thread br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_break", fadeouttime);
    self.gasmaskswapinprogress = 1;
    self setclientomnvar("ui_gas_mask", 3);
    wait fadeouttime;
    self.gasmaskswapinprogress = 0;
    self notify("gas_mask_swap_complete");
    namespace_b16531563568eaba::function_55dc9108a9301e59(self);
    function_8e9b00a1d2b23d72();
  }
}

function function_4f2124298797aded(amount, time) {
  level endon("game_ended");
  self endon("disconnect");
  wait time;
  self setclientomnvar("ui_gas_mask_opacity_override", amount);
}

function delayedattach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
}

function delayeddetach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

function delayeddetachbreak(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0.1) {
    wait delaytime - 0.1;
  }

  playFXOnTag(utility::getfx("vfx_gas_mask_break"), self, "tag_weapon_left");
  wait 0.1;

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

function function_a1d897962a19d27e() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    var_353cc7fac6358799 = waittill_any_timeout_1(level.var_5312bc14bd5db377, "gasmask_buffer_reset");

    if(!isDefined(var_353cc7fac6358799) || var_353cc7fac6358799 == "timeout") {
      self.var_a18181d8bdaa0dab = 0;
      return;
    }
  }
}

function function_8e9b00a1d2b23d72() {
  player = self;

  if(!player namespace_e50e624d9af51c8c::isbackpackinventoryenabled()) {
    return;
  }

  var_d035435a9237f3d = function_b76f69ce63757cea("gas_mask_durable");

  if(!var_d035435a9237f3d) {
    function_b76f69ce63757cea("gas_mask");
  }
}

function canholdammobox(scriptablename) {
  if(!isDefined(self.br_ammo[scriptablename])) {
    return true;
  }

  return !br_weapons::br_ammo_type_player_full(self, scriptablename);
}

function isvest(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"armor" && issubstr(scriptablename, "vest");
}

function isgasmask(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gear" && issubstr(scriptablename, "gasmask");
}

function ishelmet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gear" && issubstr(scriptablename, "helmet");
}

function function_9a5d18fbdad686c2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"key" && issubstr(scriptablename, "loot_key_gulag");
}

function isnote(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"note";
}

function function_6b5f3fb6550ae6d5(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gear" && issubstr(scriptablename, "iodine_pills");
}

function function_4cf229c2265183a9(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"exfil" && issubstr(scriptablename, "exfil_marker");
}

function isspecialistbonus(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"specialist" && issubstr(scriptablename, "specialist_bonus");
}

function isplunder(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"plunder";
}

function function_34af0f77c1668dba(lootid) {
  return isDefined(lootid) && lootid == 8395;
}

function isquesttablet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"tablet";
}

function function_c7279e910cefd2a4(scriptablename) {
  if(isquesttablet(scriptablename)) {
    return issubstr(scriptablename, "elite_arrow");
  }

  return 0;
}

function isdogtag(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"dogtag";
}

function function_a5202e2fc8ecb076(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"extractable" && issubstr(scriptablename, "durable_loot");
}

function isweaponcase(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"weaponcase";
}

function function_f92615e29aff3602(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"hash_a49b77de0306ea57";
}

function function_e4b6260dbb04b43d(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"elite_arrow";
}

function function_9b77601837f66e32(lootid) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(isDefined(scriptablename)) {
    return function_e4b6260dbb04b43d(scriptablename);
  }

  return false;
}

function function_b605a733974c2ff5(lootid) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(isDefined(scriptablename)) {
    return function_43e6c697b2fdde6e(scriptablename);
  }

  return 0;
}

function isperkpointpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"perkpoint";
}

function istokenpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"token";
}

function function_f8f4cf026fb2b9f8(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "brloot_gulag_token";
}

function isrevivepickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"revive";
}

function iskillstreak(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"killstreak";
}

function isattachment(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"attachment";
}

function issuperpickup(scriptablename) {
  return !isnonequippable(scriptablename) && isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"super";
}

function function_7e548749e3b2fd89(scriptablename) {
  return scriptablename == "brloot_super_utilitybox";
}

function function_c7832df426918c4e(scriptablename) {
  return scriptablename == "brloot_super_hauntedbox";
}

function function_1be34022a4acce73(scriptablename) {
  if(!isDefined(scriptablename)) {
    return 0;
  }

  switch (scriptablename) {
    case #"hash_1e184faee1b35a2":
    case #"hash_dc76dae6923cd72":
    case #"hash_42f538a268e06c04":
    case #"hash_cc33d71013dc6a72":
      return 1;
    default:
      return 0;
  }
}

function function_1950b02c25bad779(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"perk";
}

function isplunderextract(scriptablename) {
  return scriptablename == "brloot_plunder_extract";
}

function function_4294e9b331377c31(scriptablename) {
  return scriptablename == "brloot_plate_carrier_high_capacity";
}

function isaccesscard(scriptablename) {
  return issubstr(scriptablename, "access_card");
}

function function_cb8c6abfd1ce083a(scriptablename) {
  return issubstr(scriptablename, "card_biometric_scan");
}

function isxp(scriptablename) {
  return issubstr(scriptablename, "brloot_xp");
}

function function_f262c137ed78e6eb(scriptablename) {
  return issubstr(scriptablename, "activity_starter");
}

function iskey(scriptablename) {
  return issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key");
}

function function_2d86ba79a58bb62(scriptablename) {
  return issubstr(scriptablename, "loot_multi_key");
}

function function_68f7f39db3bc7fa4(scriptablename) {
  return issubstr(scriptablename, "brloot_drone_part");
}

function isnonequippable(scriptablename) {
  return scriptablename == "br_loot_cache" || isquesttablet(scriptablename);
}

function isvaluable(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"valuable";
}

function ispersonal(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"personal";
}

function istablet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"tablet";
}

function function_32125eba262380c7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"mission";
}

function function_a38e261031751c09(scriptablename) {
  return isDefined(level.br_pickups.var_b8fad1cfd41d21da[scriptablename]) && level.br_pickups.var_b8fad1cfd41d21da[scriptablename] == 1;
}

function iscache(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"cache";
}

function function_b989edd9af4f42c7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"lethal";
}

function function_d7c5786a0c42ef6c(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"tactical";
}

function function_cb1e30930c35f2e2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"nvg";
}

function function_43e6c697b2fdde6e(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"disguise";
}

function isweaponpart(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"weaponpart";
}

function function_5449da9d3d0358a4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gascan";
}

function function_f96674ba1a1ec2b3(lootid) {
  if(!isDefined(lootid)) {
    return false;
  }

  scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptable)) {
    return false;
  }

  return function_5449da9d3d0358a4(scriptable);
}

function function_7a345d3f5a65278c(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"questsafe";
}

function function_3cad96c265936df7(scriptablename) {
  if(!isDefined(level.br_pickups.br_itemtype[scriptablename])) {
    return 0;
  }

  switch (scriptablename) {
    case #"hash_37befa6a4b547903":
      return 1;
    default:
      return 0;
  }
}

function isgametypeitem(scriptablename) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("isGametypeItem")) {
    return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("isGametypeItem", scriptablename);
  }

  return 0;
}

function isrock(scriptablename) {
  return scriptablename == "brloot_rock";
}

function function_e68e1669597a3f4d(scriptablename) {
  return scriptablename == "brloot_payment_hacker_phone";
}

function function_4f6e89c88bb9605(scriptablename) {
  return function_1823ff50bb28148d(scriptablename) == #"brloot_jup_payment_exe_phone";
}

function function_b77386f2a0293169(scriptablename) {
  return isvaluable(scriptablename) || isdogtag(scriptablename) || ispersonal(scriptablename) || function_32125eba262380c7(scriptablename);
}

function function_c51fec498a6283b5(scriptablename) {
  return scriptablename == "brloot_shopkeeper_code";
}

function function_d0bacee01bff927c(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "objective";
}

function function_fdf9de965b5e870b(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "autoconsume";
}

function function_df3f5431c93ed5a1(lootid, scriptablename) {
  if(!isDefined(scriptablename)) {
    scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  }

  if(!isDefined(scriptablename)) {
    return false;
  }

  return scriptablename == "brloot_offhand_advancedvehicledrop";
}

function function_e92b6e923f4264b5(scriptablename) {
  if(!isDefined(scriptablename)) {
    return false;
  }

  return scriptablename == "brloot_offhand_deconstation";
}

function function_d345eec68e01361f(lootid, scriptablename) {
  if(!isDefined(lootid) && !isDefined(scriptablename)) {
    return false;
  }

  if(!isDefined(scriptablename)) {
    scriptablename = loot::getscriptablefromlootid(lootid);
  }

  if(!isDefined(scriptablename)) {
    return false;
  }

  return scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid) || scripts\mp\gametypes\br_pickups::isgasmask(scriptablename) || scripts\mp\gametypes\br_pickups::ishelmet(scriptablename) || scripts\mp\gametypes\br_pickups::function_5449da9d3d0358a4(scriptablename) || scripts\mp\gametypes\br_pickups::function_1be34022a4acce73(scriptablename) || scripts\mp\gametypes\br_public::function_12d9a293931f0455(scriptablename) || function_c51fec498a6283b5(scriptablename) || scripts\mp\gametypes\br_pickups::function_43e6c697b2fdde6e(scriptablename) || scripts\mp\gametypes\br_pickups::function_cb8c6abfd1ce083a(scriptablename) || function_e92b6e923f4264b5(scriptablename);
}

function function_16a5ebe82e3f2286(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"breakable_tool";
}

function function_4d256360c9588433(contractref, player) {
  whitelist = tolower(getDvar(hashcat(@ "hash_6c7b8805d40e0639", contractref)));

  if(!isDefined(whitelist) || whitelist == "") {
    return true;
  }

  var_fc081bbe060bd007 = strtok(whitelist, " ");
  playername = tolower(player.name);

  if(utility::array_contains(var_fc081bbe060bd007, playername)) {
    return true;
  }

  return false;
}

function function_54dac56d15dd3d93(ref, lootid, quantity, var_8598d3d3bc3d9ceb) {
  if(!isDefined(ref) || !isDefined(lootid) || !isDefined(quantity)) {
    return 0;
  }

  fakepickup = spawnStruct();
  fakepickup.scriptablename = ref;
  fakepickup.count = quantity;
  result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(ref));

  if(result == 1) {
    function_37be6e543436f3b3(lootid, undefined, var_8598d3d3bc3d9ceb, quantity);
    br_weapons::br_ammo_give_type(self, ref, quantity, 1);
    return 1;
  }

  if(result == 20) {
    function_37be6e543436f3b3(lootid, undefined, var_8598d3d3bc3d9ceb, quantity);
    namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
    return 1;
  }

  showuseresultsfeedback(result);
  return 0;
}

function function_99ab09ba7022d107(pickup, isautouse) {
  lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  result = namespace_e50e624d9af51c8c::function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result)) {
    return 1;
  }

  if(istrue(isautouse)) {
    return 12;
  }

  return 4;
}

function function_cbbf9bf3544dc456(pickup, isautouse) {
  lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  result = namespace_e50e624d9af51c8c::function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result)) {
    return 20;
  }

  if(istrue(isautouse)) {
    return 12;
  }

  return 4;
}

function function_f8a3ff0a73fa0c1d(pickup, var_fb40d5954b4f6792) {
  var_4bd6d680451253cc = 0;

  if(pickup.count + self.br_ammo[pickup.scriptablename] <= level.var_e6ea72fc5e3fcd00[pickup.scriptablename]) {
    var_4bd6d680451253cc = 1;
  }

  var_2ca75f603de25b76 = br_weapons::function_d885e66811ee3a4d(pickup.scriptablename);

  if(var_fb40d5954b4f6792 && var_2ca75f603de25b76 && var_4bd6d680451253cc) {
    return 1;
  }

  lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  result = namespace_e50e624d9af51c8c::function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result) || var_2ca75f603de25b76 && self.br_ammo[pickup.scriptablename] < level.var_e6ea72fc5e3fcd00[pickup.scriptablename]) {
    return 20;
  }

  return 4;
}

function cantakepickup(pickup, var_8e04b10487b421ce) {
  if(br_gametypes::isbrgametypefuncdefined("canTakePickup")) {
    result = br_gametypes::runbrgametypefunc("canTakePickup", pickup);

    if(result > 0) {
      return result;
    }
  }

  if(self isskydiving()) {
    return 9;
  }

  if(br_public::isammo(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut) && !juggernaut::jugg_canuseweaponpickups()) {
      return 16;
    }

    if(level.var_7582dc4260722bf1 == 1) {
      if(self isreloading() && br_weapons::function_d885e66811ee3a4d(pickup.scriptablename)) {
        return 2;
      }
    }

    var_fb40d5954b4f6792 = canholdammobox(pickup.scriptablename);

    if(!level.var_cf32b38db66d1f3b && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_f8a3ff0a73fa0c1d(pickup, var_fb40d5954b4f6792);
    } else if(var_fb40d5954b4f6792) {
      return 1;
    } else {
      return 4;
    }
  }

  isautouse = istrue(pickup.isautouse);

  if(isweaponpickupitem(pickup)) {
    if(istrue(self.isjuggernaut) && !juggernaut::jugg_canuseweaponpickups()) {
      return 16;
    }

    if(level.var_bc1086a365d70b30 == 1) {
      if(istrue(self.insertingarmorplate)) {
        return 13;
      }
    }

    if(player_utility::isinvehicle()) {
      return 17;
    }

    newweapon = br_weapons::function_55c5d35c8c76a95b(pickup)[0];

    foreach(weap in self.primaryweapons) {
      if(issameweapon(weap, newweapon)) {
        fakepickup = spawnStruct();
        fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);

        if(isDefined(fakepickup.scriptablename)) {
          result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(pickup.scriptablename));

          if(result == 1) {
            return 5;
          } else if(result == 20) {
            return 27;
          }

          return 28;
        }

        return 28;
      }
    }

    if(namespace_aead94004cf4c147::function_efab78b72d131d76(self)) {
      var_9ac5e72784815708 = namespace_aead94004cf4c147::function_2985254128b1c262(self);

      if(issameweapon(var_9ac5e72784815708, newweapon)) {
        fakepickup = spawnStruct();
        fakepickup.scriptablename = br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);

        if(isDefined(fakepickup.scriptablename)) {
          result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(pickup.scriptablename));

          if(result == 1) {
            return 5;
          } else if(result == 20) {
            return 27;
          }

          return 28;
        } else {
          return 28;
        }
      }
    }

    if(!isDefined(pickup.lootid)) {
      pickup.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename) && namespace_e50e624d9af51c8c::function_3ab0a87eeaa203bf()) {
      result = namespace_aead94004cf4c147::function_e01d9736b2d100ac(pickup.lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    if(self function_b096b58fb3808d26()) {
      if(isautouse && !function_c8a5593cbb13f17c(pickup, newweapon)) {
        return 12;
      }
    }

    return 1;
  }

  if(function_fdf9de965b5e870b(pickup.scriptablename) && scripts\mp\utility\killstreak::isjuggernaut()) {
    return 16;
  }

  if(br_public::isequipment(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    equipname = level.br_pickups.br_equipname[pickup.scriptablename];
    slot = level.equipment.table[equipname].defaultslot;
    pickupcount = 1;

    if(isDefined(pickup.count)) {
      pickupcount = pickup.count;
    }

    if(isautouse && (slot == "primary" || slot == "secondary")) {
      if(isDefined(self.equipment[slot]) && pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(pickup.scriptablename, slot)) {
        if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
          var_5324597edfaff57c = equipment::getequipmentslotammo(slot);
          lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
          lootid = utility::ter_op(isDefined(lootid), lootid, 0);
          itemindex = namespace_e50e624d9af51c8c::function_106b52ed8f680043(lootid);

          if(!isDefined(itemindex) || isDefined(var_5324597edfaff57c) && var_5324597edfaff57c > 0) {
            return 1;
          }
        } else {
          return 1;
        }
      }

      if(!namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
        if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) && (!isDefined(self.equipment[slot]) || equipment::getequipmentslotammo(slot) == 0)) {
          return 1;
        }

        return 12;
      }
    }

    var_8faa94bee9bfd2c7 = !istrue(isautouse) || slot == "health";

    if(var_8faa94bee9bfd2c7 && (!isDefined(self.equipment[slot]) || equipment::getequipmentslotammo(slot) == 0)) {
      return 1;
    }

    if(pickupissameasequipmentslot(equipname, slot)) {
      if(equipmentslothasroom(pickup.scriptablename, slot)) {
        return 1;
      } else if(!istrue(isautouse)) {
        if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
          return function_cbbf9bf3544dc456(pickup, isautouse);
        } else {
          return 4;
        }
      }
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(!istrue(var_8e04b10487b421ce)) {
        return function_cbbf9bf3544dc456(pickup, isautouse);
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }

  if(isgametypeitem(pickup.scriptablename) && scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("gametypeItemIsAutoPickup")) {
    if(istrue(scripts\mp\gametypes\br_gametypes::runbrgametypefunc("gametypeItemIsAutoPickup", pickup.scriptablename, self))) {
      return 1;
    }
  }

  if(isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit) {
      return 11;
    }

    return 1;
  }

  if(function_1a4d30da7f8971fd(pickup.scriptablename)) {
    return 1;
  }

  if(isgasmask(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) && isautouse && gasmask::hasgasmask(self)) {
      return 12;
    }

    if(istrue(var_8e04b10487b421ce)) {
      return 1;
    }

    if(gasmask::hasgasmask(self) && pickup.count <= self.gasmaskhealth && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      fakepickup = spawnStruct();
      fakepickup.scriptablename = pickup.scriptablename;
      fakepickup.count = 1;
      return function_cbbf9bf3544dc456(fakepickup, isautouse);
    }

    return 1;
  }

  if(ishelmet(pickup.scriptablename)) {
    return 1;
  }

  if(function_6b5f3fb6550ae6d5(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }

    return 1;
  }

  if(isquesttablet(pickup.scriptablename)) {
    var_8e862883a5f5e641 = getdvarint(@ "hash_82bde055b11e6698", 0) != 0;

    if(!var_8e862883a5f5e641) {
      if(isDefined(pickup.instance)) {
        if(!isDefined(pickup.instance.task)) {
          namespace_c133516bfc1d803c::function_8a25384bacdd7b79(pickup.instance, pickup.instance.type);

          if(isDefined(pickup.instance.task) && isDefined(pickup.instance.task.safestructs)) {
            if(!istrue(pickup.instance.task.safestructs.size < 0)) {
              logstring("Safecracker ERROR: Tried to generate safe locations on pickup and generation failed");
            }

            assertex(istrue(pickup.instance.task.safestructs.size > 0), "<dev string:x39e>");
          }
        }
      }

      assertex(isDefined(pickup.instance.task), "<dev string:x3e1>" + pickup.scriptablename);
    }

    if(!var_8e862883a5f5e641 && !function_4d256360c9588433(pickup.instance.task.type.ref, self)) {
      return 33;
    }

    if(function_c7279e910cefd2a4(pickup.scriptablename)) {
      var_9c597e5015ff9e26 = getdvarint(@ "hash_441931632f11125e", 1);

      if(var_9c597e5015ff9e26) {
        var_195d33c54ec09e1d = getDvar(@ "hash_55d6af015c42ab58", "11200+11201+1001");
        featurebans = [];

        if(isDefined(var_195d33c54ec09e1d) && var_195d33c54ec09e1d.size) {
          featurebans = strtok(var_195d33c54ec09e1d, "+");
        }

        if(isDefined(featurebans)) {
          foreach(featureban in featurebans) {
            var_4e1f73945da1f162 = self function_928fe2f2298beac(int(featureban));

            if(isDefined(var_4e1f73945da1f162) && var_4e1f73945da1f162) {
              return 33;
            }
          }
        }
      }

      result = pickup.instance.task namespace_2d7f47b19ccdb41d::function_8f2a91a76e062b32(self);

      if(isstring(result)) {
        if(result == "too_many_teammates") {
          return 35;
        }
      }
    }

    if(pickup.scriptablename == "brloot_blueprintextract_tablet") {
      return 1;
    } else {
      alreadyhavequest = undefined;

      if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
        alreadyhavequest = utility::array_contains(level.questinfo.teamsonquests, self.team);
      } else {
        alreadyhavequest = namespace_c133516bfc1d803c::function_e98c0791b051398(self.team) || namespace_c133516bfc1d803c::function_7094c7010c5e3827(self.team);
      }

      if(alreadyhavequest) {
        if(istrue(self.canhackcontracts)) {
          return 41;
        }

        return 10;
      } else {
        return 1;
      }
    }
  }

  if(isperkpointpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    return 1;
  }

  if(istokenpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(pickup.scriptablename == "brloot_redeploy_token") {
      if(br_public::hasrespawntoken()) {
        if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
          return function_cbbf9bf3544dc456(pickup);
        } else {
          return 8;
        }
      } else {
        return 1;
      }
    }

    if(function_f8f4cf026fb2b9f8(pickup.scriptablename)) {
      if(isDefined(level.gulag) && (br_public::function_15da77dc195bd80a() || br_gulag::checkgulagusecount())) {
        if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
          return function_cbbf9bf3544dc456(pickup);
        } else {
          return 36;
        }
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(isrevivepickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(pickup.scriptablename == "brloot_self_revive" || pickup.scriptablename == "brloot_battlerage_self_revive") {
      if(br_public::hasselfrevivetoken() && br_public::function_723bd1ab3bb16b2b(self, pickup.scriptablename)) {
        if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
          return function_cbbf9bf3544dc456(pickup, isautouse);
        } else if(istrue(isautouse)) {
          return 12;
        } else {
          return 14;
        }
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(iskillstreak(pickup.scriptablename)) {
    killstreakref = level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename];

    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(istrue(level.var_793b39fdc6d2b17a) && weapon::iskillstreakweapon(self getcurrentweapon())) {
      return 7;
    }

    if(istrue(var_8e04b10487b421ce) && !getdvarint(@ "hash_752eeed3ddcbd04b", 0)) {
      if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename) && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename]) {
        return function_cbbf9bf3544dc456(pickup, isautouse);
      } else {
        return 1;
      }
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename) && namespace_e50e624d9af51c8c::function_d674d32c2d3ba5ed(self)) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && isDefined(self.streakdata.streaks[1]) && self.streakdata.streaks[1].streakname == level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename]) {
      return 7;
    } else if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) && isautouse && isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size != 0) {
      return 12;
    } else {
      return 1;
    }
  }

  if(issuperpickup(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    } else if(function_df3f5431c93ed5a1(undefined, pickup.scriptablename) && !scripts\mp\gametypes\br_gametype_truckwar::function_81124b7b16101f8b()) {
      return 39;
    }

    currentsuper = scripts\mp\supers::getcurrentsuperref();

    if(!supers::issuperinuse() && !supers::function_565913010c84ffca() && !self isthrowinggrenade()) {
      equipammo = equipment::getequipmentslotammo("super");

      if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) && isautouse && isDefined(equipammo) && equipammo != 0) {
        return 12;
      } else if(!isDefined(equipammo) || equipammo == 0 || !namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
        if(getdvarint(@ "hash_fb6fdaa2e155eb88", 0) && isDefined(currentsuper) && level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename] == currentsuper) {
          return 39;
        } else {
          return 1;
        }
      }
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(istrue(var_8e04b10487b421ce)) {
        if(isDefined(currentsuper) && isDefined(level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename]) && level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename] == currentsuper) {
          result = function_cbbf9bf3544dc456(pickup);

          if(result == 4 && !supers::issuperinuse() && !supers::function_565913010c84ffca()) {
            return 29;
          } else {
            return result;
          }
        } else if(supers::issuperinuse() || supers::function_565913010c84ffca()) {
          result = function_cbbf9bf3544dc456(pickup);

          if(result == 4 && !supers::issuperinuse()) {
            return 29;
          } else {
            return result;
          }
        } else if(self isthrowinggrenade()) {
          result = function_cbbf9bf3544dc456(pickup);

          if(result != 20) {
            result = 2;
          }

          return result;
        } else {
          return 1;
        }
      } else if(namespace_e50e624d9af51c8c::function_5e7049647595ab97() || supers::issuperinuse() && !supers::function_565913010c84ffca()) {
        result = function_cbbf9bf3544dc456(pickup);

        if(result == 4 && !supers::issuperinuse()) {
          return 29;
        } else {
          return result;
        }
      }
    }

    return 4;
  }

  if(function_1950b02c25bad779(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(issubstr(pickup.scriptablename, "tac_sprint_boots") && array_contains_key(self.perks, "specialty_tac_sprint_boots")) {
      return 42;
    }

    if(namespace_e50e624d9af51c8c::isbackpackinventoryenabled() && !getdvarint(@ "hash_ff7a56b91e81bd5d")) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    } else {
      return 1;
    }
  }

  if(br_public::isarmor(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(armor::function_cd4a78b4a236ddc8(level.br_pickups.br_equipname[pickup.scriptablename])) {
      return 1;
    } else {
      return 6;
    }
  }

  if(function_4294e9b331377c31(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(_hasperk("specialty_pc_high_capacity")) {
      if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
        return function_cbbf9bf3544dc456(pickup);
      } else {
        return 15;
      }
    }

    return 1;
  }

  if(function_a5202e2fc8ecb076(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(!isDefined(pickup.count)) {
        pickup.count = 1;
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isaccesscard(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(function_cb8c6abfd1ce083a(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isattachment(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }
  }

  if(isxp(pickup.scriptablename)) {
    return 1;
  }

  if(function_f262c137ed78e6eb(pickup.scriptablename)) {
    return 1;
  }

  if(iskey(pickup.scriptablename)) {
    if(function_9a5d18fbdad686c2(pickup.scriptablename)) {
      if(istrue(self.var_43b2a82936a5e974)) {
        return 23;
      } else {
        return 1;
      }
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      lootid = loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      index = namespace_e50e624d9af51c8c::function_e05897f5d860188e(lootid, pickup.count, 0);

      if(isDefined(index)) {
        keystruct = namespace_e50e624d9af51c8c::function_6738846da50730f1(index);

        if(isDefined(keystruct) && isDefined(keystruct[1]) && keystruct[1] > 2) {
          return 23;
        }
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(function_f92615e29aff3602(pickup.scriptablename)) {
    if(isDefined(pickup.instance.team) && self.team == pickup.instance.team) {
      return 1;
    } else {
      return 4;
    }
  }

  if(function_e4b6260dbb04b43d(pickup.scriptablename)) {
    if(pickup namespace_2d7f47b19ccdb41d::function_bd7732605a7843b2(self)) {
      return function_ed254d7be7ff977a(pickup);
    }
  }

  if(isspecialistbonus(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(br_public::hasspecialistbonus()) {
      return 18;
    }

    return 1;
  }

  if(pickup.scriptablename == "brloot_ammo_grenade") {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    var_f2b2c8de93ebf806 = equipment::getequipmentslotammo("primary");
    var_e93897bc10c40746 = equipment::getequipmentslotammo("secondary");

    if(isDefined(var_f2b2c8de93ebf806) && var_f2b2c8de93ebf806 < 2 || isDefined(var_e93897bc10c40746) && var_e93897bc10c40746 < 2) {
      return 1;
    } else {
      return 3;
    }
  }

  if(pickup.scriptablename == "Pillage_Cache") {
    return 1;
  }

  if(isvaluable(pickup.scriptablename) || ispersonal(pickup.scriptablename) || function_cb1e30930c35f2e2(pickup.scriptablename) || function_5449da9d3d0358a4(pickup.scriptablename) || isnote(pickup.scriptablename) || function_32125eba262380c7(pickup.scriptablename) || function_16a5ebe82e3f2286(pickup.scriptablename) || function_43e6c697b2fdde6e(pickup.scriptablename) || isweaponpart(pickup.scriptablename)) {
    if(isDefined(level.var_d8db1602c8bf473e[pickup.scriptablename])) {
      result = [[level.var_d8db1602c8bf473e[pickup.scriptablename]]](pickup, self);

      if(isDefined(result)) {
        return result;
      }
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isweaponcase(pickup.scriptablename)) {
    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isdogtag(pickup.scriptablename)) {
    dmz_dog_tag::function_b5d4fcc3fab92696(pickup);

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename)) {
      [victimindex, _] = dmz_dog_tag::getdogtagvictimandkiller(pickup.count);

      if(dmz_dog_tag::function_d9f5c5090de1241b(self, pickup.count)) {
        if(level.dogtaginfo[victimindex].player != self) {
          if(isDefined(level.var_547167a7517600fb)) {
            [[level.var_547167a7517600fb.var_770c1af7032592a5]](self, level.dogtaginfo[victimindex].player);
            return 1;
          }

          br_gametype_dmz::showdmzsplash("dmz_recover_dog_tag", [self], undefined);
        } else if(isDefined(level.var_547167a7517600fb)) {
          [[level.var_547167a7517600fb.var_5b72b9e0891944ae]](self);
          return 1;
        }

        if(isDefined(level.dogtaginfo[victimindex].player)) {
          dmz_dog_tag::function_8e643d6706defeea(level.dogtaginfo[victimindex].player, pickup.count);
        }

        return 1;
      } else if(isDefined(level.var_547167a7517600fb)) {
        [[level.var_547167a7517600fb.var_87206cfbd04971fa]](self, level.dogtaginfo[victimindex].player);
        return 1;
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(function_4cf229c2265183a9(pickup.scriptablename)) {
    if(isDefined(level.secondaryvictory)) {
      if([[level.secondaryvictory.var_f1a47f3d1492db51]]()) {
        return 1;
      } else {
        return 2;
      }
    }
  }

  if(function_4ebfdbfa1b8e0339(pickup.scriptablename)) {
    return 1;
  }

  if(function_b1e944a2b3e15e9d(pickup.scriptablename)) {
    var_f437251b800feb88 = namespace_e50e624d9af51c8c::function_102abd6883c5f9bf(self) != loot::function_fae5e1d3de32d3f7(pickup.scriptablename);

    if(var_f437251b800feb88) {
      return 1;
    }

    return function_cbbf9bf3544dc456(pickup);
  }

  if(br_public::function_4aa12e0ed3f6b745(pickup.scriptablename)) {
    platelevel = br_public::function_692c3df266580df6(pickup.scriptablename);

    if(self.platecarrierlevel < platelevel || isDefined(self.var_4045f099f3da4bd) && pickup.scriptablename != self.var_4045f099f3da4bd) {
      return 1;
    }

    return function_cbbf9bf3544dc456(pickup);
  }

  if(function_36de08ea672b354c(pickup.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(istrue(var_8e04b10487b421ce)) {
      return 1;
    }

    if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(pickup.scriptablename) && namespace_126f4192a2d090c4::function_bdd930eee0042052()) {
      result = function_cbbf9bf3544dc456(pickup);

      if(result == 4) {
        return 29;
      } else {
        return result;
      }
    }

    return 1;
  }

  if(function_9e686ab118ac7725(pickup.scriptablename)) {
    return 1;
  }

  if(function_5aa2768ce2289fe7(pickup.scriptablename)) {
    if(isDefined(pickup.instance.player) && pickup.instance.player == self) {
      return 1;
    } else {
      return 37;
    }
  }

  if(function_d0bacee01bff927c(pickup.scriptablename) || function_9e686ab118ac7725(pickup.scriptablename)) {
    return 1;
  }

  if(function_fdf9de965b5e870b(pickup.scriptablename)) {
    return 1;
  }

  return 2;
}

function isdroppablepickup(pickupname) {
  if(scripts\mp\weapons::isfistweapon(pickupname) || weapon::isgunlessweapon(pickupname) || weapon::ismeleeoverrideweapon(pickupname)) {
    return false;
  }

  return true;
}

function spawnpickup(pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt) {
  if(!isDefined(dropinfo)) {
    println("<dev string:x423>" + pickupname + "<dev string:x446>");
    return;
  }

  if(dropinfo.origin == (0, 0, 0)) {
    println("<dev string:x423>" + pickupname + "<dev string:x48e>");
    return;
  }

  assert(isDefined(dropinfo.origin));
  assert(isDefined(dropinfo.angles));
  assert(isDefined(dropinfo.payload));
  var_ef809b0ee883bcc7 = 0;
  assert(isDefined(pickupname));
  var_9f8ea678e633f1b3 = level.br_pickups.var_ea924219fe414fa2[pickupname];

  if(isDefined(var_9f8ea678e633f1b3)) {
    pickupname = level.br_pickups.br_equipnametoscriptable[var_9f8ea678e633f1b3.lootname];

    if(!var_9f8ea678e633f1b3.var_dce7021a199f618f) {
      count = 1;
    }
  }

  var_c9c301a888170672 = undefined;

  if(isDefined(weaponobj)) {
    fullweapon = getcompleteweaponname(weaponobj);

    if(isDefined(level.br_pickups.var_9e78b5ee377070a9) && isDefined(level.br_pickups.var_9e78b5ee377070a9[fullweapon])) {
      var_c9c301a888170672 = level.br_pickups.var_9e78b5ee377070a9[fullweapon];
    }
  }

  if(!isDefined(var_c9c301a888170672)) {
    if(level.var_7420ddc23aa7b431 != 1) {
      if(isDefined(level.br_pickups.br_weapontoscriptable[pickupname])) {
        var_c9c301a888170672 = level.br_pickups.br_weapontoscriptable[pickupname];
      } else if(utility::array_contains(level.br_pickups.br_weapontoscriptable, pickupname)) {
        var_c9c301a888170672 = pickupname;
      }
    }

    if(!isDefined(var_c9c301a888170672)) {
      if(br_weapons::isvalidcustomweapon(weaponobj)) {
        weaponclasstoken = weapon::getweaponclasstoken(weaponobj.basename);

        if(!isDefined(weaponclasstoken)) {
          println("<dev string:x4d2>" + weaponobj.basename);
          return;
        }

        if(weaponclasstoken != "me" && weaponclasstoken != "pi" && weaponclasstoken != "sh" && weaponclasstoken != "sm" && weaponclasstoken != "ar" && weaponclasstoken != "lm" && weaponclasstoken != "dm" && weaponclasstoken != "sn" && weaponclasstoken != "la" && weaponclasstoken != "kn" && weaponclasstoken != "br") {
          println("<dev string:x4d2>" + weaponobj.basename);
          return;
        }

        var_ef809b0ee883bcc7 = 1;
        var_c9c301a888170672 = "brloot_weapon_generic_" + weaponclasstoken;
      } else if(isdroppablepickup(pickupname)) {
        var_c9c301a888170672 = pickupname;
      }
    }
  }

  if(!isDefined(var_c9c301a888170672)) {
    assertex(!isdroppablepickup(pickupname), "<dev string:x4f8>" + pickupname);
    return;
  }

  statesuffix = "";

  if(issubstr(var_c9c301a888170672, "me_riotshield") || br_weapons::isvalidcustomweapon(weaponobj) && weapon_utility::isriotshield(weaponobj)) {
    dropinfo.angles = (dropinfo.angles[0] - 90, dropinfo.angles[1], dropinfo.angles[2]);

    if(var_c9c301a888170672 == "brloot_weapon_generic_me") {
      statesuffix = "_riot_shield";
    }
  }

  if(issubstr(var_c9c301a888170672, "la_juliet")) {
    dropinfo.angles = (dropinfo.angles[0] - 4.2, dropinfo.angles[1], dropinfo.angles[2] - 90);
    dropinfo.origin = (dropinfo.origin[0], dropinfo.origin[1], dropinfo.origin[2] + 8.5);
  }

  translationoffset = level.br_pickups.translationoffset[var_c9c301a888170672];
  rotationoffset = level.br_pickups.rotationoffset[var_c9c301a888170672];

  if(isDefined(translationoffset)) {
    dropinfo.origin = coordtransform(translationoffset, dropinfo.origin, dropinfo.angles);
  }

  if(isDefined(rotationoffset)) {
    dropinfo.angles = rotationoffset + dropinfo.angles;
  }

  clearspaceforscriptableinstance();

  if(var_ef809b0ee883bcc7) {
    item = spawncustomweaponscriptable(var_c9c301a888170672, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, weaponobj);

    if(isDefined(item)) {
      item.customweaponname = getcompleteweaponname(weaponobj);
    }
  } else if(namespace_708f627020de59d3::function_43044da0ed44d79f(var_c9c301a888170672)) {
    while(dropinfo.customperkpayload.size < 5) {
      dropinfo.customperkpayload[dropinfo.customperkpayload.size] = 0;
    }

    item = spawnscriptable(var_c9c301a888170672, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, dropinfo.customperkpayload);
  } else if(isDefined(dropinfo.teamselect)) {
    item = spawnscriptable(var_c9c301a888170672, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, dropinfo.teamselect);
  } else {
    item = spawnscriptable(var_c9c301a888170672, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload);
  }

  if(!isDefined(item)) {
    return;
  }

  if(isDefined(dropinfo.groundentity)) {
    localorigin = rotatevectorinverted(dropinfo.origin - dropinfo.groundentity.origin, dropinfo.groundentity.angles);
    localangles = combineangles(invertangles(dropinfo.groundentity.angles), dropinfo.angles);
    item utility::function_6e506f39f121ea8a(dropinfo.groundentity, localorigin, localangles);
  }

  registerscriptableinstance(item);

  if(isDefined(count)) {
    loot_setitemcount(item, count, countlefthand, countalt);
  } else {
    loot_setitemcount(item, 0);
  }

  if(!isDefined(allowautopickup)) {
    allowautopickup = 1;
  }

  if(!istrue(level.br_pickups.br_hasautopickup[var_c9c301a888170672])) {
    allowautopickup = 1;
  }

  if(!getdvarint(@ "hash_61e10de0f675e9ad")) {
    scriptablepartname = item.type;

    if(istrue(showtrail)) {
      if(allowautopickup) {
        item setscriptablepartstate(scriptablepartname, "dropped" + statesuffix);
      } else {
        assert(istrue(level.br_pickups.br_hasautopickup[var_c9c301a888170672]));
        state = "droppedNoAuto";

        if(!item getscriptableparthasstate(scriptablepartname, state + statesuffix) && getdvarint(@ "hash_8d10ede0f25e6d2e", 0)) {
          state = "dropped";
        }

        item setscriptablepartstate(scriptablepartname, state + statesuffix);
      }
    } else if(!allowautopickup) {
      assert(istrue(level.br_pickups.br_hasautopickup[var_c9c301a888170672]));
      state = "noAuto";

      if(!item getscriptableparthasstate(scriptablepartname, state + statesuffix) && getdvarint(@ "hash_8d10ede0f25e6d2e", 0)) {
        state = "dropped";
      }

      item setscriptablepartstate(scriptablepartname, state + statesuffix);
    }
  }

  if(isent(self) && isPlayer(self)) {
    item.var_1eef5048f92c4951 = self;
    function_bc7c01a944172176(item, var_c9c301a888170672);
  }

  createcallback = level.br_pickups.createcallbacks[var_c9c301a888170672];

  if(isDefined(createcallback)) {
    item[[createcallback]]();
  }

  item scripts\common\callbacks::callback("br_pickup_created", dropinfo);

  if(level.var_a3443d8ebdaf7c00) {
    foreach(player in level.players) {
      br_dev::devgivemaxammo(player);
    }
  }

  return item;
}

function function_bc7c01a944172176(instance, scriptablename) {
  if(!isDefined(instance) || !isDefined(scriptablename) || !isDefined(self.var_f1cb96c63166b481) || self.var_f1cb96c63166b481.size <= 0) {
    return;
  }

  founditemindex = array_find(self.var_f1cb96c63166b481, scriptablename);

  if(!isDefined(founditemindex)) {
    return;
  }

  self.var_f1cb96c63166b481[founditemindex] = undefined;
  instance.criticalitem = 1;
  instance.alwayscritical = 1;
}

function registerpickupcreatedcallback(var_c9c301a888170672, callback, var_1bdbdddb5bbf06c5) {
  if(!isDefined(var_1bdbdddb5bbf06c5)) {
    var_1bdbdddb5bbf06c5 = 0;
  }

  level.br_pickups.createcallbacks[var_c9c301a888170672] = callback;

  if(istrue(var_1bdbdddb5bbf06c5)) {
    items = getlootscriptablearray(var_c9c301a888170672);

    foreach(item in items) {
      item[[callback]]();
    }
  }
}

function function_c3e1679f348a5e40(callback) {
  level.br_pickups.var_7c25f4fb48db3dd4 = utility::array_add(level.br_pickups.var_7c25f4fb48db3dd4, callback);
}

function showuseresultsfeedback(results) {
  switch (results) {
    case 28:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    case 3:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyammonoroom);
      return;
    case 4:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
      return;
    case 6:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmornotbetter);
      return;
    case 7:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveks);
      return;
    case 8:
      hud_message::showerrormessage(level.br_pickups.var_17109b21f99ad76d);
      return;
    case 36:
      hud_message::showerrormessage(level.br_pickups.var_540408f173ba9a3f);
      return;
    case 14:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaverevive);
      return;
    case 9:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyparachuting);
      return;
    case 10:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhavequest);
      return;
    case 13:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyweaponpickupap);
      return;
    case 15:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveplatepouch);
      return;
    case 16:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
      return;
    case 18:
      hud_message::showerrormessage(level.br_pickups.br_pickupalreadyhavespecialistbonus);
      return;
    case 19:
      hud_message::showerrormessage(level.br_pickups.var_b4a939303c824805);
      return;
    case 23:
      hud_message::showerrormessage(level.br_pickups.var_5fdcd05c466e7520);
      return;
    case 2:
      break;
    case 25:
      hud_message::showerrormessage(level.br_pickups.var_7141c6c2372c0a82);
      break;
    case 26:
      hud_message::showerrormessage(level.br_pickups.var_8bffca3828fd297e);
      break;
    case 31:
      hud_message::showerrormessage(level.br_pickups.var_ec7422f11a61c100);
      break;
    case 32:
      hud_message::showerrormessage(level.br_pickups.var_7bd397b2e9d8a434);
      break;
    case 33:
      hud_message::showerrormessage(level.br_pickups.var_58fe23c2a80f28ed);
      break;
    case 34:
      hud_message::showerrormessage(level.br_pickups.var_d8a2816e3697c70c);
      break;
    case 35:
      hud_message::showerrormessage(level.br_pickups.var_6944f496399a2a4);
      break;
    case 11:
      hud_message::showerrormessage(level.br_pickups.br_pickupdenyplunderpickup);
      break;
    case 37:
      hud_message::showerrormessage(level.br_pickups.var_fde0e27b3a09bf3);
      break;
    case 39:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.var_61251ef22efa8d15);
      break;
    case 42:
      hud_message::showerrormessage(level.br_pickups.var_8c26c75f89041ddb);
      break;
  }
}

function _removecashstateforplayer(player, waittime) {
  assert(isPlayer(player));
  assert(isfloat(waittime));
  player notify("reset_cash_wait");
  player endon("reset_cash_wait");
  wait waittime;
  player.br_cash_count = undefined;
  player.br_cash_time = undefined;
}

function getcashsoundaliasforplayer(player, var_3466c10973e9c476) {
  pickup_sfx = "br_pickup_cash";
  var_41426f97882c68fb = 5000;
  var_d8c56288c4b1c484 = var_41426f97882c68fb / 1000;
  now = gettime();
  var_65dc993df2721909 = getmatchrulesdata("brData", "plunderModelType") == "gold";

  if(isPlayer(player)) {
    if(!isDefined(player.br_cash_count)) {
      player.br_cash_count = 0;
    }

    if(!isDefined(player.br_cash_time)) {
      player.br_cash_time = now;
    }

    cashdelta = now - player.br_cash_time;
    player.br_cash_time = now;

    if(cashdelta < var_41426f97882c68fb) {
      player.br_cash_count += 1;
    }

    player thread _removecashstateforplayer(player, var_d8c56288c4b1c484);
    assert(isDefined(player.br_cash_count));
    currencytype = "cash";

    if(var_65dc993df2721909) {
      currencytype = "gold";
    }

    switch (var_3466c10973e9c476) {
      case #"hash_192a14ffd18243fb":
      case #"hash_192a15ffd182458e":
      case #"hash_b64903f6ab579d1c":
      default:
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_" + currencytype + "_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_" + currencytype + "_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_" + currencytype + "_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_" + currencytype + "_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_" + currencytype + "_05";
            break;
        }

        break;
      case #"hash_192a16ffd1824721":
      case #"hash_8f5e151d9e4dfc51":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_" + currencytype + "_med_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_" + currencytype + "_med_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_" + currencytype + "_med_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_" + currencytype + "_med_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_" + currencytype + "_med_05";
            break;
        }

        break;
      case #"hash_364c01bf1db279e8":
      case #"hash_364c04bf1db27ea1":
      case #"hash_8f5e121d9e4df798":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_" + currencytype + "_lrg_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_" + currencytype + "_lrg_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_" + currencytype + "_lrg_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_" + currencytype + "_lrg_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_" + currencytype + "_lrg_05";
            break;
        }

        break;
      case #"hash_266af6147dbd8916":
        switch (player.br_cash_count) {
          case 0:
          case 1:
            pickup_sfx = "br_pickup_" + currencytype + "_vlrg_01";
            break;
          case 2:
            pickup_sfx = "br_pickup_" + currencytype + "_vlrg_02";
            break;
          case 3:
            pickup_sfx = "br_pickup_" + currencytype + "_vlrg_03";
            break;
          case 4:
            pickup_sfx = "br_pickup_" + currencytype + "_vlrg_04";
            break;
          case 5:
          default:
            pickup_sfx = "br_pickup_" + currencytype + "_vlrg_05";
            break;
        }

        break;
    }
  }

  return pickup_sfx;
}

function onusecompleted(pickupent, var_43fb3d97abb79854, var_a5b2c541413aa895, fromkiosk, var_db943473454f6ea6, instance, backpackequip, delayfeedback, weaponstowed) {
  level endon("game_ended");
  self endon("disconnect");
  pickupremains = 0;

  if(!isDefined(pickupent.count)) {
    pickupent.count = 0;
  }

  if(issharedfuncdefined(pickupent.scriptablename, "onUseCompleted")) {
    self[[getsharedfunc(pickupent.scriptablename, "onUseCompleted")]](pickupent);
  }

  level notify("pickedupweapon_kill_callout_" + pickupent.scriptablename + pickupent.origin);
  br_gametypes::runbrgametypefunc("onPickupItemUsed", pickupent);

  if(isplunder(pickupent.scriptablename)) {
    self notify("self_pickedupitem_" + "plunder");
  } else if(isweaponpickupitem(pickupent)) {
    if(self function_b096b58fb3808d26()) {
      self.var_e7f6950ddc75ef66 = gettime();
    }

    self notify("self_pickedupitem_" + "weapon", pickupent.scriptablename);
  } else {
    self notify("self_pickedupitem_" + pickupent.scriptablename);
  }

  self notify("br_pickup_scriptable");

  if(isweaponpickupitem(pickupent)) {
    br_weapons::takeweaponpickup(pickupent, var_db943473454f6ea6, weaponstowed, backpackequip);
    challenges::onpickupitem("weapon");
    var_87b8ba9a18c47387 = isDefined(pickupent.scriptablename) && pickupent.scriptablename == "brloot_weapon_lm_dblmg_lege";

    if(var_87b8ba9a18c47387) {
      manageminigunpickup();
    }
  } else if(br_public::isammo(pickupent.scriptablename)) {
    pickupremains = br_weapons::takeammopickup(pickupent);
    namespace_e50e624d9af51c8c::function_5baaa0ce73d6fe84(self, pickupent.scriptablename);
  } else if(br_public::isarmorplate(pickupent.scriptablename)) {
    if(!istrue(fromkiosk) && perk::_hasperk("specialty_fast_armor")) {
      pickupremains = perkfunctions::function_de6e36b06bd630c4(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
    } else {
      pickupremains = takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
    }

    namespace_3169ff42d7051988::function_1976438a8865ac27("br_ftue_armor");
    thread armor::function_ef6d8b8c2ed89e8a(pickupent.count);
  } else if(br_public::function_4aa12e0ed3f6b745(pickupent.scriptablename)) {
    if(istrue(backpackequip) && isDefined(var_db943473454f6ea6)) {
      namespace_e50e624d9af51c8c::function_db1dd76061352e5b(var_db943473454f6ea6);
    }

    if(function_990be1aa4ad3c9d4()) {
      if(istrue(backpackequip) && isDefined(var_db943473454f6ea6)) {
        var_a9e3e0fc7f984716 = function_479558ebb71377bc();
        lootid = loot::function_fae5e1d3de32d3f7(var_a9e3e0fc7f984716);
        fakepickup = spawnStruct();
        fakepickup.scriptablename = loot::getscriptablefromlootid(lootid);
        fakepickup.count = 1;
        namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
      } else {
        dropstruct = function_7b9f3966a7a42003();
        function_c15a28fc6247ad60(dropstruct, 1);
        namespace_b16531563568eaba::function_ea96b27797c7e268(self);
      }
    }

    platelevel = function_e98a5a4e0e001ac3(self, pickupent.scriptablename);

    if(pickupent.scriptablename == "brloot_plate_carrier_high_capacity" && !istrue(self.var_e75b458675200e42)) {
      fillmaxarmorplate();
      self.var_e75b458675200e42 = 1;
    }
  } else if(br_public::isequipment(pickupent.scriptablename)) {
    pickupremains = takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(br_public::isarmor(pickupent.scriptablename)) {
    takearmorpickup(pickupent);
  } else if(pickupent.scriptablename == "Pillage_Cache" && isDefined(level.givetagsfromcache)) {
    self[[level.givetagsfromcache]]();
  } else if(isplunder(pickupent.scriptablename)) {
    br_plunder::takeplunderpickup(pickupent);
    challenges::onpickupitem("plunder");
  } else if(function_1a4d30da7f8971fd(pickupent.scriptablename)) {
    function_966d64f200872160(pickupent);
  } else if(istokenpickup(pickupent.scriptablename)) {
    if(issubstr(pickupent.scriptablename, "redeploy_token")) {
      takerespawntokenpickup(pickupent);
    }

    if(issubstr(pickupent.scriptablename, "gulag_token")) {
      function_68c46fe15ed38d9b(pickupent);
    }
  } else if(isrevivepickup(pickupent.scriptablename)) {
    takerevivepickup(pickupent, var_db943473454f6ea6, backpackequip);
  } else if(iskillstreak(pickupent.scriptablename)) {
    takekillstreakpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(issuperpickup(pickupent.scriptablename)) {
    takesuperpickup(pickupent, fromkiosk, var_db943473454f6ea6);
  } else if(function_1950b02c25bad779(pickupent.scriptablename)) {
    takeperkpickup(pickupent.scriptablename, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(isgasmask(pickupent.scriptablename)) {
    function_9cbd64a86452a4df("gas_mask", pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(ishelmet(pickupent.scriptablename)) {
    function_9cbd64a86452a4df("helmet", pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  } else if(isquesttablet(pickupent.scriptablename)) {
    if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
      br_quest_util::takequesttablet(pickupent.instance);
    } else {
      namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(pickupent.instance);
    }
  } else if(pickupent.scriptablename == "brloot_ammo_grenade") {
    takegenericgrenadepickup(pickupent);
  } else if(function_a5202e2fc8ecb076(pickupent.scriptablename)) {
    function_b379c8b0a6564107(pickupent);
  } else if(isaccesscard(pickupent.scriptablename)) {
    takeaccesscardpickup(pickupent);
  } else if(isDefined(pickupent.scriptablename) && pickupent.scriptablename == "loot_key_mrap") {
    if(isDefined(self.vehicle)) {
      ref = self.vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

      if(isDefined(ref) && ref == "veh9_mil_lnd_mrap" && is_equal(self.vehicle.owner, self)) {
        if(self.vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_72f871bf74995298()) {
          self.vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_474237292e64417e();
          namespace_aead94004cf4c147::function_e900e7e66383ad97(self, var_db943473454f6ea6, 0);
        } else {
          scripts\mp\hud_message::showerrormessage("MP/MRAP_ALREADY_UNLOCKED");
        }

        scripts\mp\pmc_missions::function_7fc83d63a85c14d(self);
      } else {
        scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_MRAP_KEY");
      }
    } else {
      scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_MRAP_KEY");
    }
  } else if(iskey(pickupent.scriptablename)) {
    if(function_9a5d18fbdad686c2(pickupent.scriptablename)) {
      if(namespace_d36e6800233f4f97::function_cfe304859f30e747("gulagKeyAcquired")) {
        namespace_d36e6800233f4f97::function_3cceb052d780fef1("gulagKeyAcquired");
      }

      return 0;
    } else {
      return 1;
    }
  } else if(function_f92615e29aff3602(pickupent.scriptablename)) {} else if(function_e4b6260dbb04b43d(pickupent.scriptablename)) {
    function_ed254d7be7ff977a(pickupent);
  } else if(isxp(pickupent.scriptablename)) {
    takexp(pickupent);
    return 1;
  } else if(function_f262c137ed78e6eb(pickupent.scriptablename)) {
    if(istrue(self.canhackcontracts)) {
      thread namespace_210d6dd43cfaf195::function_a232d3c610006843(pickupent, self);
    } else {
      thread activity_manager::function_57ac6111c7db410f(pickupent, self);
    }
  } else if(function_4ebfdbfa1b8e0339(pickupent.scriptablename)) {
    thread overseer::function_4cc3562c55625e70(instance);
  } else if(function_4cf229c2265183a9(pickupent.scriptablename)) {
    if(isDefined(level.secondaryvictory)) {
      self thread[[level.secondaryvictory.var_3a91667e613d19c1]]();
    }
  } else if(function_6b5f3fb6550ae6d5(pickupent.scriptablename)) {
    thread iodine_pills::function_7430b01f931d7e4e(undefined, pickupent);
  } else if(function_5449da9d3d0358a4(pickupent.scriptablename)) {
    var_62cc4a0ecde06ecf = pickupent.scriptablename == "brloot_gascan_palfa";
    error = scripts\cp_mp\vehicles\vehicle_interact::function_557da58e3ad8a579(pickupent, var_62cc4a0ecde06ecf);

    if(isDefined(error)) {
      scripts\mp\hud_message::showerrormessage(error);
    } else {
      namespace_aead94004cf4c147::function_e900e7e66383ad97(self, var_db943473454f6ea6, pickupent.count);

      if(istrue(delayfeedback)) {
        playpickupfeedback(pickupent, var_a5b2c541413aa895);
      }

      playsoundatpos(self.origin + (0, 0, 30), "eqp_gas_can_use");

      if(var_62cc4a0ecde06ecf) {
        namespace_39beb6d4ea2b65f4::function_354bd1ba3062243d();
      }
    }
  } else if(function_b1e944a2b3e15e9d(pickupent.scriptablename)) {
    var_db02edbac967fb02 = namespace_e50e624d9af51c8c::function_3188d9c94b3d56c2(pickupent.scriptablename);
    var_31dafc6ba15dfbc9 = namespace_e50e624d9af51c8c::getplayerbackpacksize(self);
    lootid = loot::function_fae5e1d3de32d3f7(pickupent.scriptablename);
    var_f6af44bb087c3da5 = namespace_e50e624d9af51c8c::function_102abd6883c5f9bf(self);

    if(var_f6af44bb087c3da5 != 0) {
      dropstruct = function_7b9f3966a7a42003();
      scriptablename = loot::getscriptablefromlootid(var_f6af44bb087c3da5);
      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, pickupent.overridedist, undefined, undefined, pickupent.origin);
      item = spawnpickup(scriptablename, dropinfo, 1, 1, undefined, 0);
    }

    namespace_b16531563568eaba::function_5b7dc44bb66553a6(self);
    namespace_b16531563568eaba::function_92d947129ea5ba6e(self, lootid);
    namespace_e50e624d9af51c8c::function_d28f52da6ede0191(self, var_db02edbac967fb02, undefined, lootid);

    if(istrue(backpackequip) && isDefined(var_db943473454f6ea6)) {
      namespace_e50e624d9af51c8c::function_db1dd76061352e5b(var_db943473454f6ea6);
    }

    namespace_e50e624d9af51c8c::function_6491bd812bb47efb(self, var_db02edbac967fb02, pickupent.scriptablename);
  } else if(function_36de08ea672b354c(pickupent.scriptablename)) {
    thread function_4e335a6589199847(pickupent, var_a5b2c541413aa895, var_db943473454f6ea6, backpackequip, fromkiosk);
  } else if(isdogtag(pickupent.scriptablename) && game_utility::getsubgametype() != "dmz" && isDefined(level.var_547167a7517600fb)) {} else if(function_9e686ab118ac7725(pickupent.scriptablename) && utility::issharedfuncdefined("exgm_force_recon", "reveal_intel")) {
    utility::function_f3bb4f4911a1beb2("exgm_force_recon", "reveal_intel", pickupent);
  } else if(function_5aa2768ce2289fe7(pickupent.scriptablename)) {
    scripts\mp\gametypes\br::onscavengerbagpickup(pickupent.instance);
    pickupremains = 0;
  } else if(isgametypeitem(pickupent.scriptablename) && istrue(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onGametypeItemPickup"))) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onGametypeItemPickup", pickupent, self);
  } else if(function_d0bacee01bff927c(pickupent.scriptablename) && isDefined(level.var_14cc24a75e8cd64d)) {
    self[[level.var_14cc24a75e8cd64d]](pickupent);
  } else if(function_fdf9de965b5e870b(pickupent.scriptablename)) {
    thread function_a26bbfa747602ee1(pickupent.scriptablename);
    pickupremains = 0;
  } else {
    amount = 1;

    if(isDefined(pickupent.count)) {
      amount = pickupent.count;
    }

    trypickupitem(pickupent.scriptablename, amount);
  }

  if(isDefined(pickupent) && isDefined(pickupent.scriptablename)) {
    equipname = level.br_pickups.br_equipname[pickupent.scriptablename];

    if(isDefined(equipname) && issharedfuncdefined(equipname, "onScriptablePickedUp")) {
      self[[getsharedfunc(equipname, "onScriptablePickedUp")]](pickupent);
    }
  }

  amount = 1;

  if(isDefined(pickupent.count)) {
    amount = pickupent.count;
  }

  if(isDefined(pickupent.instance) && isDefined(pickupent.instance.uniquelootitemid)) {
    processuniquelootitem(pickupent.instance.uniquelootitemid, self);
  }

  function_b96bd81b0107ad4c(pickupent);
  br_analytics::branalytics_lootpickup(self, pickupent.scriptablename, amount);
  namespace_3169ff42d7051988::function_1976438a8865ac27("br_ftue_inventory");

  if(!istrue(var_43fb3d97abb79854) && !istrue(delayfeedback)) {
    if(pickupremains) {
      pickupent.count -= pickupremains;
    }

    playpickupfeedback(pickupent, var_a5b2c541413aa895);
  }

  return pickupremains;
}

function onpickuptakenintobackpack(pickup) {
  if(isdogtag(pickup.scriptablename)) {
    dmz_dog_tag::function_b5d4fcc3fab92696(pickup);

    if(isDefined(level.var_9a3c2481a4cd4b46)) {
      [[level.var_9a3c2481a4cd4b46]](self, pickup.count);
    }

    if(dmz_dog_tag::function_1129ba5718d33025(self, pickup.count)) {
      thread dmz_dog_tag::function_ea29bccf97cb1b9a(self, pickup.count);
    }

    dmz_dog_tag::function_b5fbe3cb4ed955f4(self, pickup.count);
  }

  if(isDefined(level.var_5635125e56693c8) && isDefined(level.var_5635125e56693c8[pickup.scriptablename])) {
    [[level.var_5635125e56693c8[pickup.scriptablename]]](pickup, self);
  }

  if(function_2d86ba79a58bb62(pickup.scriptablename)) {
    blacksite = undefined;
    originalteam = undefined;

    if(isDefined(pickup.instance)) {
      blacksite = pickup.instance.blacksite;
      originalteam = pickup.instance.originalteam;
    } else {
      blacksite = pickup.blacksite;
      originalteam = pickup.originalteam;
    }

    if(isDefined(blacksite)) {
      self.blacksite = blacksite;
      teamplayers = player_utility::getteamarray(self.team, 0);
      namespace_c62d39d6e6afb119::function_7bc622d2fe4b2017(blacksite, 0, teamplayers, originalteam, self.team);

      if(istrue(level.var_68f5630f7b06743a) && isDefined(level.var_b6148c58d443fe52)) {
        self thread[[level.var_b6148c58d443fe52]](pickup);
      }
    }
  }

  if(function_68f7f39db3bc7fa4(pickup.scriptablename)) {
    if(issharedfuncdefined("br_puzzle_drone_repair", "setDronePartFound")) {
      level thread[[getsharedfunc("br_puzzle_drone_repair", "setDronePartFound")]](pickup, self);
    }
  }

  if(isaccesscard(pickup.scriptablename)) {
    if(issharedfuncdefined("br_bunkers", "onBunkerKeycardPickup")) {
      level thread[[getsharedfunc("br_bunkers", "onBunkerKeycardPickup")]](self);
    }
  }

  function_b96bd81b0107ad4c(pickup);
  br_gametypes::runbrgametypefunc("onPickupTakenIntoBackpack", pickup);
  level notify("backpack_item", self, pickup);
}

function function_b96bd81b0107ad4c(pickup) {
  if(istrue(pickup.alwayscritical) || isDefined(pickup.instance) && istrue(pickup.instance.alwayscritical)) {
    if(!isDefined(self.var_f1cb96c63166b481)) {
      self.var_f1cb96c63166b481 = [];
    }

    self.var_f1cb96c63166b481[self.var_f1cb96c63166b481.size] = pickup.scriptablename;
  }
}

function function_734b7a21be53f605() {
  self setclientomnvar("ui_loot_splash_item_id", 0);
  self setclientomnvar("ui_loot_splash_item_quantity", 0);
}

function updatelootsplash(pickupent) {
  self notify("updateLootSplash");
  self endon("disconnect");
  lootid = 0;
  quantity = 0;

  if(isweaponpickup(pickupent.scriptablename)) {
    if(isDefined(pickupent.customweaponname)) {
      lootid = weapon::function_b0d37b9be0027733(pickupent.customweaponname);
    } else {
      weaponobj = getfullweaponobjforpickup(pickupent);
      lootid = weapon::getweaponlootid(weaponobj);
    }
  } else {
    lootid = level.br_pickups.var_7b2bff2d04ee1017[pickupent.scriptablename];

    if(!isDefined(lootid)) {
      lootid = 0;
    }

    shouldshowquantity = isDefined(pickupent.stackable) && pickupent.stackable > 0 || isplunder(pickupent.scriptablename) || ispickupstackable(pickupent.scriptablename) || function_e68e1669597a3f4d(pickupent.scriptablename) || function_4f6e89c88bb9605(pickupent.scriptablename);

    if(shouldshowquantity && isDefined(pickupent.count)) {
      quantity = pickupent.count;
    }
  }

  waitframe();

  if(isDefined(lootid)) {
    self setclientomnvar("ui_loot_splash_item_id", lootid);
    self setclientomnvar("ui_loot_splash_item_quantity", quantity);
  } else {
    logstring("ui_loot_splash_item_id LootID: undefinedpickupEnt: " + pickupent.scriptablename);
  }

  self endon("updateLootSplash");
  wait 0.05;
  function_734b7a21be53f605();
}

function function_37be6e543436f3b3(lootid, origin, var_8598d3d3bc3d9ceb, quantity) {
  pickup = spawnStruct();
  pickup.scriptablename = loot::getscriptablefromlootid(lootid);
  pickup.origin = origin;
  pickup.count = quantity;

  if(isDefined(var_8598d3d3bc3d9ceb)) {
    pickup.var_8598d3d3bc3d9ceb = var_8598d3d3bc3d9ceb;
  }

  playpickupfeedback(pickup);
}

function playpickupfeedback(pickupent, var_a5b2c541413aa895) {
  pickup_sfx = "br_pickup_generic";
  var_a0bea370d6a72ceb = undefined;
  var_97fa758a2336c7c4 = undefined;

  if(isDefined(pickupent.scriptablename)) {
    if(isplunder(pickupent.scriptablename)) {
      pickup_sfx = getcashsoundaliasforplayer(self, pickupent.scriptablename);
    } else if(function_e68e1669597a3f4d(pickupent.scriptablename)) {
      pickup_sfx = namespace_210d6dd43cfaf195::function_5d4530ebfa3da544(self);
    } else if(isDefined(level.br_pickups.br_pickupsfx[pickupent.scriptablename]) && level.br_pickups.br_pickupsfx[pickupent.scriptablename] != function_1823ff50bb28148d("") && !(getdvarint(@ "scr_br_skiplegendarypickupsound", 0) != 0 && level.br_pickups.br_pickupsfx[pickupent.scriptablename] == function_1823ff50bb28148d("br_legendary_loot_pickup"))) {
      if(level.br_pickups.br_pickupsfx[pickupent.scriptablename] == function_1823ff50bb28148d("br_legendary_loot_pickup")) {
        var_a0bea370d6a72ceb = level.br_pickups.br_pickupsfx[pickupent.scriptablename];

        if(isweaponpickupitem(pickupent)) {
          pickup_sfx = "br_pickup_weap";
        } else {
          pickup_sfx = "br_pickup_generic";
        }
      } else if(level.br_pickups.br_pickupsfx[pickupent.scriptablename] == function_1823ff50bb28148d("uin_dmz_valuable_loot_pickup")) {
        var_97fa758a2336c7c4 = level.br_pickups.br_pickupsfx[pickupent.scriptablename];

        if(isweaponpickupitem(pickupent)) {
          pickup_sfx = "br_pickup_weap";
        } else {
          pickup_sfx = "br_pickup_generic";
        }
      } else {
        pickup_sfx = level.br_pickups.br_pickupsfx[pickupent.scriptablename];
      }
    } else if(isweaponpickupitem(pickupent)) {
      pickup_sfx = "br_pickup_weap";
    } else {
      pickup_sfx = "br_pickup_generic";
    }

    if(isDefined(level.br_pickups.br_itemrow[pickupent.scriptablename]) && (istrue(level.br_pickups.var_a5e4b146866d7fd[pickupent.scriptablename]) || isweaponpickup(pickupent.scriptablename) && getdvarint(@ "hash_68583a19a03dfdbc", 0))) {
      self setclientomnvar("ui_br_loot_index_picked_up", level.br_pickups.br_itemrow[pickupent.scriptablename]);
    }
  }

  origin_plr = self getvieworigin();
  origin_pickup = undefined;

  if(isvector(pickupent.origin)) {
    origin_pickup = pickupent.origin;
  } else if(isstruct(pickupent)) {
    container = utility::default_to(pickupent.container, self.var_2fa5b49969def47);

    if(isDefined(container)) {
      origin_pickup = container.origin;
      origin_pickup = (origin_pickup[0], origin_pickup[1], origin_plr[2] - 20);
    }
  }

  if(!isvector(origin_pickup)) {
    assertmsg("<dev string:x519>");
    origin_pickup = origin_plr + anglesToForward(self getplayerangles()) * 36 + (0, 0, -20);
  }

  assertex(isvector(origin_pickup), "<dev string:x519>");
  origin_delta = origin_pickup - origin_plr;
  origin_offset = origin_delta * 0.666;
  grab_origin = origin_plr + origin_offset;

  if(isDefined(self) && player_utility::_isalive() && !function_6dc7c10050a0622b(self)) {
    if(isDefined(var_a0bea370d6a72ceb)) {
      self playlocalsound(var_a0bea370d6a72ceb);
    } else if(isDefined(var_97fa758a2336c7c4)) {
      self playlocalsound(var_97fa758a2336c7c4);
    }

    if(utility::issharedfuncdefined("player", "isReallyAlive")) {
      if([[utility::getsharedfunc("player", "isReallyAlive")]](self)) {
        self playsoundonmovingent(pickup_sfx);
      }
    }
  }

  if(!istrue(pickupent.var_c03c4ef51659ba4c)) {
    thread updatelootsplash(pickupent);
  }

  if(!istrue(var_a5b2c541413aa895) && !istrue(pickupent.var_8598d3d3bc3d9ceb)) {
    thread playerplaypickupanim(pickupent);
  }
}

function playerplaypickupanim(pickupent) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(pickupent) || !br_public::playercanplaynotcriticalgesture()) {
    return;
  }

  function_f4361ea8ce0fbca4();
  br_public::playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
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

function function_7b9f3966a7a42003(var_fb6b5e268e9a52de, var_d1e7ececee01c6d5, var_d20ad6ecee27de2b) {
  dropstruct = spawnStruct();
  dropstruct.dropcount = 0;
  dropstruct.dropidx = 0;
  dropstruct.var_fb6b5e268e9a52de = var_fb6b5e268e9a52de;
  dropstruct.var_d1e7ececee01c6d5 = var_d1e7ececee01c6d5;
  dropstruct.var_d20ad6ecee27de2b = var_d20ad6ecee27de2b;
  return dropstruct;
}

function droponplayerdeath(attacker) {
  victim = self;

  if(getdvarint(@ "hash_18c54f044520ba50", 0)) {
    if(isbot(victim)) {
      return;
    }
  }

  if(getdvarint(@ "hash_307fc239dc43be41", 0)) {
    return;
  }

  if(game_utility::isteamreviveenabled()) {
    self.var_57c207fde9b78089 = 1;
  }

  if(istrue(br_gametypes::runbrgametypefunc("dropOnPlayerDeath"))) {
    return;
  }

  if(!scripts\mp\gametypes\br_gulag::function_aa3a537ec349120d()) {
    return;
  }

  dropstruct = function_7b9f3966a7a42003();

  if(isDefined(level.adddroponplayerdeath)) {
    self[[level.adddroponplayerdeath]](dropstruct, attacker);
  }

  if(killstreak::isjuggernaut()) {
    br_jugg_common::droponplayerdeath(dropstruct);
  }

  if(isDefined(level.var_547167a7517600fb) && isDefined(level.var_547167a7517600fb.var_e393bf4026d0c393)) {
    [[level.var_547167a7517600fb.var_e393bf4026d0c393]](self, attacker);
  }

  if(function_d3204a974cec837b()) {
    self.var_ba19d6a40e652dd6 = namespace_e50e624d9af51c8c::getplayerbackpacksize(self);
    var_f6af44bb087c3da5 = namespace_e50e624d9af51c8c::function_102abd6883c5f9bf(self);

    if(var_f6af44bb087c3da5 != 0) {
      self.var_cd82e790e825db2 = var_f6af44bb087c3da5;
    }

    if(istrue(level.var_813b4b2211fbaf1d)) {
      namespace_e50e624d9af51c8c::function_c6b3799b231916bb(self, dropstruct);

      if(!istrue(level.var_d034183abf2e274d)) {
        namespace_e50e624d9af51c8c::clearbackpack();
        namespace_e50e624d9af51c8c::function_954372d604277278(self);
      }
    } else if(loot::function_8306d72ea2e8889c()) {
      if(!istrue(level.var_a1aab37ec3423e39)) {
        namespace_e50e624d9af51c8c::function_8121cbee12383790(self, dropstruct);
      }

      if(istrue(level.var_51225d738094457d)) {
        namespace_e50e624d9af51c8c::function_ae287e5eb2024104(self, dropstruct);
      }

      if(!istrue(level.var_d034183abf2e274d)) {
        namespace_e50e624d9af51c8c::clearbackpack();
        namespace_e50e624d9af51c8c::function_954372d604277278(self);
      }

      if(istrue(level.var_51225d738094457d)) {
        foreach(weapon in self.equippedweapons) {
          if(shoulddropbrprimary(weapon, self)) {
            newweapondrop = dropbrweapon(weapon, dropstruct);

            if(isDefined(newweapondrop)) {
              self.var_3480393dc131952a = newweapondrop;
              break;
            }
          }
        }
      }
    }

    if(istrue(level.var_749783dc3aa20c72)) {
      if(getdvarint(@ "hash_f924e428ae42dc96")) {
        dropbrammoboxes(dropstruct);
      } else {
        self.ammoondeath = self.br_ammo;
      }
    } else {
      dropbrammoboxes(dropstruct);
    }

    if(!istrue(level.var_51225d738094457d)) {
      dropbrequipment(dropstruct);

      if(!istrue(level.var_4ca052423b9bb316)) {
        dropbrsuper(dropstruct);
      }

      br_plunder::playerdropplunderondeath(dropstruct, attacker);
      dropbrprimaryweapons(dropstruct, level.var_73dc8cb1481e4a36);
      dropbrhealthpack(dropstruct);
    }

    if(!istrue(level.var_813b4b2211fbaf1d) && !istrue(level.var_73dc8cb1481e4a36)) {
      thread function_e374e6d9eaaa4dc5(dropstruct);
      dropbrkillstreak(dropstruct);
      dropdogtag(dropstruct);
      dropbrselfrevivetoken(dropstruct);
    } else if(br_headgear::function_48c7a8ee781fbf56(self)) {
      br_headgear::function_72935b93ba0bbe17(self.headgeartype, self);
      namespace_b16531563568eaba::function_55dc9108a9301e59(self);
    }

    if(function_990be1aa4ad3c9d4()) {
      function_c15a28fc6247ad60(dropstruct);
    }

    dropbrmissiontablet(dropstruct);
    dropaccesscard(dropstruct);

    if(istrue(getdvarint(@ "hash_c2ad3174d4c811df", getsubgametype() != "plunder"))) {
      function_b8faa69b95fe55be(dropstruct);
    }

    if(function_80dd3f82ffe825f()) {
      arena = namespace_de6eb888abbe38e1::function_2f4344abdc200e43(self);

      if(isDefined(arena)) {
        thread function_55463a3679678e2f(dropstruct, arena);
      }
    }

    self notify("canSpawnAsSpectator");
    return;
  }

  if(function_80dd3f82ffe825f()) {
    arena = namespace_de6eb888abbe38e1::function_2f4344abdc200e43(self);

    if(isDefined(arena)) {
      thread function_55463a3679678e2f(dropstruct, arena);
    }
  }

  namespace_e50e624d9af51c8c::function_2c226f050114f4b2(dropstruct, self);

  if(function_990be1aa4ad3c9d4()) {
    function_c15a28fc6247ad60(dropstruct);
  }

  if(!istrue(level.var_d034183abf2e274d)) {
    namespace_e50e624d9af51c8c::clearbackpack();
  }

  if(!istrue(level.skipweapondropondeath)) {
    dropbrprimaryweapons(dropstruct);
  }

  thread dropbrgasmask(dropstruct);
  dropdogtag(dropstruct);

  if(istrue(level.var_749783dc3aa20c72)) {
    if(getdvarint(@ "hash_f924e428ae42dc96")) {
      dropbrammoboxes(dropstruct);
    } else {
      self.ammoondeath = self.br_ammo;
    }
  } else {
    dropbrammoboxes(dropstruct);
  }

  dropbrhealthpack(dropstruct);

  if(!istrue(level.skipequipmentdropondeath)) {
    dropbrequipment(dropstruct);
  }

  br_plunder::playerdropplunderondeath(dropstruct, attacker);

  if(game_utility::getsubgametype() != "kingslayer") {
    dropbrkillstreak(dropstruct);
  }

  dropbrsuper(dropstruct);
  dropbrmissiontablet(dropstruct);
  dropaccesscard(dropstruct);

  if(istrue(getdvarint(@ "hash_c2ad3174d4c811df", getsubgametype() != "plunder"))) {
    if(isDefined(self.var_28c944f222f4814) && isDefined(self.var_28c944f222f4814.var_183ec729c8876d57)) {
      if(getdvarint(hashcat(@ "hash_167acc1b809b3fca", self.var_28c944f222f4814.var_183ec729c8876d57), 0) == 0) {
        function_b8faa69b95fe55be(dropstruct);
      }
    }
  }

  self notify("canSpawnAsSpectator");
}

function function_d3204a974cec837b() {
  player = self;

  if((istrue(player.jailed) || istrue(player.gulagarena)) && namespace_d36e6800233f4f97::function_1980065ce4dc067b()) {
    return false;
  }

  if(istrue(level.var_51225d738094457d) || istrue(level.var_aa5679ebf3504e13)) {
    return true;
  }

  return false;
}

function function_479558ebb71377bc() {
  if(!isDefined(self.platecarrierlevel) || self.platecarrierlevel <= 1) {
    return undefined;
  }

  if(isDefined(self.var_4045f099f3da4bd)) {
    return self.var_4045f099f3da4bd;
  }

  return "brloot_plate_carrier_" + self.platecarrierlevel;
}

function function_c15a28fc6247ad60(dropstruct, alivedrop) {
  if(!isDefined(self.platecarrierlevel)) {
    return;
  }

  if(self.platecarrierlevel <= 1) {
    return;
  }

  dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  item = undefined;
  pickupname = function_479558ebb71377bc();
  item = spawnpickup(pickupname, dropinfo, 1, 1, undefined, 0);

  if(istrue(alivedrop)) {
    return;
  }

  if(istrue(level.var_595938569c3fe806)) {
    self setplayerdata(level.var_5d69837cf4db0407, "dmzPlateCarrierLevel", 1);
  }

  if(isDefined(item)) {
    function_2f4e0022c686dbe6(item);

    if(function_4294e9b331377c31(item.type)) {
      scripts\mp\perks\perkfunctions::function_6af20073381a18d3();
      self.var_e75b458675200e42 = undefined;
    }
  }

  if(istrue(level.var_595938569c3fe806)) {
    self.platecarrierlevel = 1;
  } else {
    self.platecarrierlevel = 2;
  }

  self.maxarmorhealth = scripts\cp_mp\armor::function_829e435158d419cf() * 50;
  armor::setarmorhealth(0, 1);
}

function dropbrammoboxes(dropstruct) {
  if(!isDefined(self.br_ammo)) {
    return;
  }

  foreach(ammotype in level.br_ammo_types) {
    if(self.br_ammo[ammotype] > 0 && isDefined(level.br_pickups.br_itemrow[ammotype])) {
      scriptablename = ammotype;
      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      allowautopickup = isalive(self) || getdvarint(@ "hash_671a6a4aaed8033e", 1);
      spawnpickup(scriptablename, dropinfo, self.br_ammo[ammotype], 1, undefined, allowautopickup);
    }
  }
}

function dropbrprimaryweapons(dropstruct, var_73dc8cb1481e4a36) {
  foreach(weapon in self.equippedweapons) {
    if(istrue(var_73dc8cb1481e4a36) && !issameweapon(weapon, self.lastweaponobj) && (weapon.basename == self.primaryweaponobj.basename || weapon.basename == self.secondaryweaponobj.basename)) {
      continue;
    }

    if(shoulddropbrprimary(weapon, self)) {
      newweapondrop = dropbrweapon(weapon, dropstruct);
      function_2f4e0022c686dbe6(newweapondrop);

      if(!isDefined(newweapondrop)) {
        dropstruct.dropidx--;
      }
    }
  }

  if(istrue(level.var_f478c1f94caa7e9) && !istrue(level.var_a3499c286ac570e4)) {
    if(namespace_e50e624d9af51c8c::function_efab78b72d131d76(self)) {
      weapon = namespace_e50e624d9af51c8c::function_2985254128b1c262(self);
      newweapondrop = dropbrweapon(weapon, dropstruct);

      if(isDefined(newweapondrop)) {
        function_2f4e0022c686dbe6(newweapondrop);
      }

      namespace_e50e624d9af51c8c::function_954372d604277278(self);
    }
  }
}

function dropbrweapon(weapon, dropstruct, overrideorigin) {
  weaponobj = undefined;
  ammoclipcount = 1;
  var_6838da24a7b27a10 = 0;
  var_1cb8c0a6d750cf77 = 0;

  if(isDefined(weapon)) {
    if(isweapon(weapon)) {
      weaponobj = weapon;
      ammoclipcount = self getweaponammoclip(weaponobj);
      var_6838da24a7b27a10 = self getweaponammoclip(weaponobj, "left");

      if(weaponobj.hasalternate) {
        var_6890a4ce965bba99 = weaponobj getaltweapon();

        if(br_weapons::br_ammo_type_for_weapon(var_6890a4ce965bba99) != br_weapons::br_ammo_type_for_weapon(weaponobj)) {
          var_1cb8c0a6d750cf77 = self getweaponammoclip(var_6890a4ce965bba99);
        }
      }

      if(br_weapons::isexcludedweapon(weaponobj)) {
        var_6838da24a7b27a10 = self getweaponammostock(weaponobj);
      }
    } else if(isstring(weapon)) {
      weaponobj = getfullweaponobjfromscriptablename(weapon);

      if(isDefined(weaponobj)) {
        ammoclipcount = weaponobj.clipsize;
      } else if(isDefined(level.br_ammo_clipsize[weapon])) {
        ammoclipcount = level.br_ammo_clipsize[weapon];
      }
    }
  }

  if(!isDefined(weaponobj)) {
    print("<dev string:x544>");

    return;
  }

  dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, overrideorigin);
  pastteam = undefined;
  weaponindex = br_weapons::function_2ab3bda08c595a32(self, weaponobj);

  if(isDefined(weaponindex)) {
    pastteam = br_weapons::function_86a5c7670325346b(self, weaponindex);
  }

  newweaponref = br_weapons::weaponspawn(weaponobj, self, dropinfo, 0, 1);

  if(isDefined(newweaponref)) {
    newweaponref.pastteam = pastteam;
    ammotype = br_weapons::br_ammo_type_for_weapon(weaponobj);
    newweaponref.ammotype = ammotype;

    if(getdvarint(@ "hash_752eeed3ddcbd04b", 0) == 0 && br_weapons::function_ad972c1d0f29841c(self, weaponobj) && self.br_ammo[ammotype] > 0) {
      var_660523cff419f0b = getdvarint(@ "hash_3c4edd0a748e4053", 1);
      dropstruct.dropidx = 1;
      var_9edc776840baff95 = undefined;

      if(isDefined(overrideorigin)) {
        var_9edc776840baff95 = self.origin + rotatevector(overrideorigin - self.origin, (0, 45, 0));
      }

      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, var_9edc776840baff95);
      newweaponref.var_ac26ec91048ac2e3 = spawnpickup(ammotype, dropinfo, self.br_ammo[ammotype], 1, undefined, var_660523cff419f0b);
      br_weapons::br_ammo_take_type(self, ammotype, self.br_ammo[ammotype]);
    }

    loot_setitemcount(newweaponref, ammoclipcount, var_6838da24a7b27a10, var_1cb8c0a6d750cf77);
  }

  return newweaponref;
}

function function_80dd3f82ffe825f() {
  player = self;

  if(player br_public::isplayerinorgoingtogulag()) {
    if(namespace_d36e6800233f4f97::function_cfe304859f30e747("gulagCanPlayerDropKey")) {
      if(player namespace_d36e6800233f4f97::function_3cceb052d780fef1("gulagCanPlayerDropKey")) {
        return true;
      }
    }
  }

  return false;
}

function function_55463a3679678e2f(dropstruct, arena) {
  player = self;
  scriptable = level.br_pickups.var_838863c4848d4c26["loot_key_gulag"];
  dropinfo = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
  item = spawnpickup(scriptable, dropinfo, 1, 1, undefined, 0);

  if(isPlayer(player)) {
    player function_2f4e0022c686dbe6(item);
  }

  arena.var_6d4e3b180776136f[arena.var_6d4e3b180776136f.size] = item;
  playsoundatpos(player.origin, "flag_spawned");

  foreach(p in arena.arenaplayers) {
    p thread hud_message::showsplash("br_twotwo_gulag_key_dropped");
  }

  wait 0.5;

  if(!isDefined(item)) {
    return;
  }

  namespace_de6eb888abbe38e1::function_9f7b9a86a5328f0b(arena, item.origin);
}

function function_a10adec57ad9e3a4(dropstruct, arena, killer) {
  agent = self;

  if(!isDefined(agent)) {
    return;
  }

  scriptable = level.br_pickups.var_838863c4848d4c26["loot_key_spectator_gulag"];
  dropinfo = getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent, undefined, 25);
  item = spawnpickup(scriptable, dropinfo, 1, 1, undefined, 0);
  item.criticalitem = 1;
  item.var_c001ccfc802f487 = 1;
  arena.secondchancekey = item;
  playsoundatpos(agent.origin, "flag_spawned");
  catwalkplayers = utility::array_remove_array(arena.jailedplayers, arena.arenaplayers);

  foreach(player in catwalkplayers) {
    player thread hud_message::showsplash("gulagbreak_got_key");
  }
}

function getfullweaponobjfromscriptablename(var_4b71202f07149879) {
  weaponname = undefined;

  if(!isDefined(level.br_lootiteminfo) && !isDefined(level.br_lootiteminfo[var_4b71202f07149879])) {
    return;
  }

  return level.br_lootiteminfo[var_4b71202f07149879].fullweaponobj;
}

function shoulddropbrprimary(weapon, player) {
  basename = weapon::getweaponrootname(weapon.basename);

  if(basename == "iw9_me_fists" || basename == "iw9_knifestab" || basename == "iw8_gunless" || basename == "iw9_me_diveknife" || basename == "iw9_swimfists" || basename == "iw9_me_climbfists" || basename == "iw9_pi_stimpistol") {
    return false;
  }

  if(basename == "ks_use_crate_mp") {
    return false;
  }

  if(!isweapon(weapon)) {
    return false;
  }

  if(weapon.inventorytype != "primary") {
    return false;
  }

  if(player br_extract_quest::extract_ismissionweapon(weapon)) {
    return false;
  }

  if(class::function_da27e3343b019fde() && scripts\cp_mp\weapon::isbackuppistol(weapon)) {
    return false;
  }

  return true;
}

function dropbrequipment(dropstruct, fromkiosk, droppurchased, equipmentref, var_f24fbd36a9751174) {
  var_11f2059012065537 = istrue(droppurchased) && isDefined(equipmentref);

  if(var_11f2059012065537) {
    var_1a37fa6c580bb395 = utility::array_find(level.br_pickups.br_equipname, equipmentref);

    if(isDefined(var_1a37fa6c580bb395)) {
      function_73ffc9bcd6d1e62d(fromkiosk);
      baseorigin = self.origin;
      baseangles = self.angles;
      yawoffsetoverride = level.br_pickups.yawoffsetoverride;
      distanceoverride = level.br_pickups.distanceoverride;

      if(istrue(fromkiosk) && isDefined(self.br_kiosk)) {
        baseorigin = self.br_kiosk.origin;
        baseangles = self.br_kiosk.angles;
        distanceoverride = undefined;
        yawoffsetoverride = undefined;
      }

      dropamount = 1;

      if(isDefined(var_f24fbd36a9751174)) {
        dropamount = var_f24fbd36a9751174;
      }

      dropinfo = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, yawoffsetoverride, distanceoverride);
      item = spawnpickup(var_1a37fa6c580bb395, dropinfo, dropamount, 1, undefined, isalive(self));
      function_2f4e0022c686dbe6(item);
    }

    return;
  }

  primaryequipment = self.equipment["primary"];

  if(isDefined(primaryequipment)) {
    if(primaryequipment == "equip_hb_sensor") {
      ammocount = hb_sensor::function_db61876aca4e4cd3();
    } else {
      ammocount = equipment::function_fe48baf929906883("primary");
    }

    if(ammocount > 0) {
      var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, self.equipment["primary"]);

      if(isDefined(var_feb782334dd23a66)) {
        dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
        allowautopickup = isalive(self) || getdvarint(@ "scr_br_allow_auto_pickup_dropped_lethal_gadgets", 1);
        item = spawnpickup(var_feb782334dd23a66, dropinfo, ammocount, 1, undefined, allowautopickup);
        function_2f4e0022c686dbe6(item);
      }
    }
  }

  secondaryequipment = self.equipment["secondary"];

  if(isDefined(secondaryequipment) && !isDefined(self.var_e5520effcbe8bd30)) {
    if(secondaryequipment == "equip_hb_sensor") {
      ammocount = hb_sensor::function_db61876aca4e4cd3();
    } else {
      ammocount = equipment::function_fe48baf929906883("secondary");
    }

    if(ammocount > 0) {
      var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, self.equipment["secondary"]);

      if(isDefined(var_feb782334dd23a66)) {
        dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
        allowautopickup = isalive(self) || getdvarint(@ "scr_br_allow_auto_pickup_dropped_tactical_gadgets", 1);
        item = spawnpickup(var_feb782334dd23a66, dropinfo, ammocount, 1, undefined, allowautopickup);
        function_2f4e0022c686dbe6(item);
      }
    }
  }
}

function dropbrsuper(dropstruct, fromkiosk, droppurchased, superref) {
  var_85efdd4e2c86f214 = istrue(droppurchased) && isDefined(superref);

  if(var_85efdd4e2c86f214) {
    var_1a37fa6c580bb395 = utility::array_find(level.br_pickups.br_equipname, superref);

    if(isDefined(var_1a37fa6c580bb395)) {
      function_73ffc9bcd6d1e62d(fromkiosk);
      [droporigin, dropangles, droppayload] = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
      item = spawnpickup(var_1a37fa6c580bb395, droporigin, dropangles, 1, 1, droppayload);
      function_2f4e0022c686dbe6(item);
    }

    return;
  }

  if(isDefined(self.equipment["super"])) {
    ammocount = function_fcde72dcbcec206b(1);

    if(isDefined(ammocount) && ammocount > 0) {
      superref = supers::getcurrentsuperref();

      if(isDefined(superref) && superref == "super_fulton") {
        if(!istrue(level.allowfultondropondeath)) {
          return;
        }
      }

      dropequipmentinslot(dropstruct, "super", fromkiosk, ammocount);
    }
  }
}

function dropbrmissiontablet(dropstruct) {
  if(isDefined(self.extractquest_missionitem) && isDefined(self.extractquest_unlockablelootid)) {
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    pickup = spawnpickup(self.extractquest_missionitem, dropinfo, 1, 1, undefined, isalive(self));
    function_2f4e0022c686dbe6(pickup);
    pickup br_blueprint_extract_spawn::blueprintextract_setunlockablelootid(self.extractquest_unlockablelootid);
  }
}

function dropbrhealthpack(dropstruct) {
  itemcount = 0;
  itemname = undefined;

  if(!isDefined(level.br_pickups)) {
    return;
  }

  if(br_public::isplayeringulag()) {
    return;
  }

  if(isDefined(self.equipment["health"])) {
    itemname = level.br_pickups.br_equipnametoscriptable[self.equipment["health"]];
    itemcount = equipment::getequipmentslotammo("health");
  } else if(istrue(level.droparmorondeath)) {
    itemname = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
    itemcount = level.armordropamount;
  }

  if(istrue(level.var_611672c472b8c9a9) && istrue(level.droparmorondeath) && istrue(level.armordropamount)) {
    itemcount = level.var_611672c472b8c9a9;
  }

  if(istrue(level.armordropamount) && itemcount < level.armordropamount) {
    itemcount = level.armordropamount;

    if(!isDefined(itemname)) {
      itemname = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
    }
  }

  if(itemcount > 0 && isDefined(itemname)) {
    allowautopickup = getdvarint(@ "scr_br_allow_auto_pickup_dropped_armor", 1) || isalive(self);

    if(itemcount > level.br_pickups.maxcounts[itemname]) {
      itemcount -= level.br_pickups.maxcounts[itemname];
      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      item = spawnpickup(itemname, dropinfo, level.br_pickups.maxcounts[itemname], 1, undefined, isalive(self));
    }

    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(itemname, dropinfo, itemcount, 1, undefined, allowautopickup);
    function_2f4e0022c686dbe6(item);
  }
}

function dropbrgasmask(dropstruct, dontspawnitem, delaydrop) {
  thread function_e374e6d9eaaa4dc5(dropstruct, dontspawnitem, delaydrop);
}

function function_e374e6d9eaaa4dc5(dropstruct, dontspawnitem, delaydrop) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.headgeartype)) {
    return;
  }

  headgeartype = self.headgeartype;

  if(!br_headgear::function_27c9f3cd0731b4c0(headgeartype)) {
    return;
  }

  if(br_headgear::hasheadgear(headgeartype, self)) {
    if(istrue(delaydrop) && br_headgear::function_c210b50cd31a3bc2(headgeartype)) {
      br_headgear::function_9f52e7f6c7bae335(headgeartype, "br_circle");

      if(headgeartype == "gas_mask") {
        wait 0.6;
      }

      if(!br_headgear::hasheadgear(headgeartype, self)) {
        return;
      }
    }

    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    allowautopickup = isalive(self) || getdvarint(@ "hash_4508c701f27f5496", 1);
    var_aa825dbcbd2edbfd = undefined;
    var_d13c72f4128a8c16 = br_headgear::function_5109f3947b0c7dfb(headgeartype, self);

    if(!istrue(dontspawnitem) && var_d13c72f4128a8c16 > 0) {
      var_fcb952f595aa03ed = br_headgear::function_5ecd6df2572a5899(headgeartype, self);
      var_aa825dbcbd2edbfd = spawnpickup(var_fcb952f595aa03ed, dropinfo, int(var_d13c72f4128a8c16), 1, undefined, allowautopickup);
    }

    br_headgear::function_72935b93ba0bbe17(headgeartype, self);

    if(isDefined(var_aa825dbcbd2edbfd)) {
      function_2f4e0022c686dbe6(var_aa825dbcbd2edbfd);
    }

    namespace_b16531563568eaba::function_55dc9108a9301e59(self);

    if(!istrue(dontspawnitem)) {
      br_headgear::function_b606f6e492722fdb(headgeartype, self);
    }
  }

  br_public::updatebrscoreboardstat("headGearType", 0);
}

function function_aa702bcdeeb2b827(dropstruct, fromkiosk, droppurchased, purchasedkillstreak, pickup) {
  var_aa702bcdeeb2b827 = istrue(droppurchased) && isDefined(purchasedkillstreak);

  if(var_aa702bcdeeb2b827) {
    function_73ffc9bcd6d1e62d(fromkiosk);
    distanceoverride = level.br_pickups.distanceoverride;
    overrideorigin = undefined;

    if(isDefined(pickup)) {
      if(isDefined(pickup.overridedist)) {
        distanceoverride = pickup.overridedist;
      }

      if(isDefined(pickup.origin)) {
        overrideorigin = pickup.origin;
      }
    }

    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, distanceoverride, undefined, undefined, overrideorigin);
    spawnpickup(level.br_pickups.var_838863c4848d4c26[purchasedkillstreak], dropinfo);
    return;
  }

  dropbrkillstreak(dropstruct, fromkiosk);
}

function dropbrkillstreak(dropstruct, fromkiosk, var_db943473454f6ea6, dropfeedback, pickup) {
  if(hasanykillstreak()) {
    function_73ffc9bcd6d1e62d(fromkiosk);
    scriptable = level.br_pickups.var_838863c4848d4c26[self.streakdata.streaks[1].streakname];

    if(isDefined(var_db943473454f6ea6)) {
      lootid = loot::function_fae5e1d3de32d3f7(scriptable);
      namespace_e50e624d9af51c8c::function_3c3ee4c5700e0e32(self, var_db943473454f6ea6, lootid, 1, 65535, 0);
    } else {
      distanceoverride = level.br_pickups.distanceoverride;
      overrideorigin = undefined;

      if(isDefined(pickup)) {
        if(isDefined(pickup.overridedist)) {
          distanceoverride = pickup.overridedist;
        }

        if(isDefined(pickup.origin)) {
          overrideorigin = pickup.origin;
        }
      }

      baseorigin = self.origin;
      baseangles = self.angles;
      yawoffsetoverride = level.br_pickups.yawoffsetoverride;

      if(istrue(fromkiosk) && isDefined(self.br_kiosk)) {
        distanceoverride = undefined;
        overrideorigin = undefined;
        yawoffsetoverride = undefined;
        baseorigin = self.br_kiosk.origin;
        baseangles = self.br_kiosk.angles;

        if(isDefined(self.br_kiosk.centerbottom)) {
          baseorigin = self.br_kiosk.centerbottom;
        }

        if(isDefined(self.br_kiosk.linkedparent)) {
          baseorigin = self.br_kiosk.linkedparent.origin + rotatevector(baseorigin, self.br_kiosk.linkedparent.angles);
        }
      }

      dropinfo = getitemdroporiginandangles(dropstruct, baseorigin, baseangles, self, yawoffsetoverride, distanceoverride, undefined, undefined, overrideorigin);
      allowautopickup = isalive(self) || getdvarint(@ "hash_75376790b7cf7e23", 1);
      item = spawnpickup(scriptable, dropinfo, 1, 1, undefined, allowautopickup);
      function_2f4e0022c686dbe6(item);
      killstreaks::removekillstreak(1);

      if(istrue(dropfeedback)) {
        quickdropplaySound(3, dropinfo.origin, scriptable, item);
      }
    }

    return;
  }

  if(isDefined(var_db943473454f6ea6)) {
    namespace_e50e624d9af51c8c::function_ad05407157b7d86d(self, var_db943473454f6ea6);
  }
}

function dropaccesscard(dropstruct) {
  if(br_public::hasaccesscard()) {
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(self.accesscard, dropinfo, undefined, undefined, undefined, isalive(self));
    function_2f4e0022c686dbe6(item);
    removeaccesscard();
  }
}

function dropbrselfrevivetoken(dropstruct) {
  if(br_public::hasselfrevivetoken()) {
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(br_public::function_791e72676cd7b544(self), dropinfo, 1, 1);
    function_2f4e0022c686dbe6(item);
    removeselfrevivetoken();
  }
}

function dropbrcustompickupitem(scriptablename, countoverride, fromkiosk, droppurchased) {
  var_7feba4ec6c35d82d = istrue(droppurchased) && isDefined(scriptablename);

  if(var_7feba4ec6c35d82d) {
    function_73ffc9bcd6d1e62d(fromkiosk);
    dropstruct = function_7b9f3966a7a42003();

    if(istrue(fromkiosk) && isDefined(self.br_kiosk) && isDefined(self.br_kiosk.dropstruct)) {
      slotindex = self.br_kiosk function_4f4d537c794b2bf5();
      self.br_kiosk.dropstruct.dropidx = slotindex;
      dropstruct = self.br_kiosk.dropstruct;
      countoverride = utility::default_to(countoverride, 1);
      var_285b7129b392cf3d = self.br_kiosk quickdropaddtoexisting(undefined, scriptablename, countoverride);

      if(!var_285b7129b392cf3d) {
        dropinfo = getitemdroporiginandangles(dropstruct, utility::default_to(self.br_kiosk.centerbottom, self.br_kiosk.origin), self.br_kiosk.angles, self);
        item = spawnpickup(scriptablename, dropinfo, countoverride, 1, undefined, 0);
        self.br_kiosk quickdropaddtocache(scriptablename, undefined, item, dropinfo.origin, dropinfo.angles);
      }

      return;
    }

    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    item = spawnpickup(scriptablename, dropinfo, countoverride);
    function_2f4e0022c686dbe6(item);
  }
}

function function_b8faa69b95fe55be(dropstruct) {
  if(isDefined(self.var_28c944f222f4814) && isDefined(self.var_28c944f222f4814.var_183ec729c8876d57)) {
    item = namespace_126f4192a2d090c4::function_3af23b0bfaf91dbd(dropstruct);
  }
}

function dropdogtag(dropstruct) {
  if(dmz_dog_tag::hasdogtag(self)) {
    quantity = dmz_dog_tag::function_57711583c5d26490(self);

    if(isDefined(quantity)) {
      [itemcount, itemcountlefthand, var_dab81ead77442a10] = dmz_dog_tag::function_379463a84adb07b4(quantity);
      dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      var_5983083928ce568c = dmz_dog_tag::function_59771b0cc100410a(self);
      spawneddogtag = spawnpickup(var_5983083928ce568c, dropinfo, itemcount, 0, undefined, 0, itemcountlefthand, var_dab81ead77442a10);

      if(isDefined(spawneddogtag)) {
        dmz_dog_tag::function_bc03aa369196f2bf(self, 0);
        self.dogtag = spawneddogtag;
        function_2f4e0022c686dbe6(spawneddogtag);
      }

      if(isDefined(level.var_547167a7517600fb) && isDefined(level.var_547167a7517600fb.var_a5354afeb0d5dfcc)) {
        [[level.var_547167a7517600fb.var_a5354afeb0d5dfcc]](self);
      }
    }
  }
}

function function_5ebf3e99b419d949(dropstruct) {
  if(getdvarint(@ "scr_br_elite_broken_arrow", 0) == 0) {
    return;
  }

  [itemindex, lootid] = namespace_2d7f47b19ccdb41d::function_c1a30db229b1311d(self, 0);

  while(isDefined(itemindex)) {
    function_b41950c9b54b12e0(dropstruct, itemindex, lootid);
    [itemindex, lootid] = namespace_2d7f47b19ccdb41d::function_c1a30db229b1311d(self, itemindex + 1);
  }
}

function function_b41950c9b54b12e0(dropstruct, itemindex, lootid) {
  backpackname = namespace_e50e624d9af51c8c::function_91c1be871300a518(lootid);

  if(isDefined(namespace_2d7f47b19ccdb41d::function_96a1620d901981d1(backpackname, 0))) {
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    namespace_2d7f47b19ccdb41d::function_3a7809be256adadb(dropinfo, self);
    spawnedelement = spawnpickup(backpackname, dropinfo, 1, 0, undefined, 0);
    namespace_2d7f47b19ccdb41d::function_a5130b39363778b7(self, spawnedelement, itemindex);
  }
}

function function_2f4e0022c686dbe6(item) {
  if(!player::isreallyalive(self) && isDefined(item)) {
    self.var_d2dbb2fa012e6d9c[self.var_d2dbb2fa012e6d9c.size] = item;
  }
}

function ispickupstackable(scriptablename) {
  return istrue(level.br_pickups.stackable[scriptablename]);
}

function isitemslotopen() {
  for(i = 0; i < 8; i++) {
    if(!isDefined(self.br_inventory_slots[i])) {
      return true;
    }
  }

  return false;
}

function isitemfull(item, pickupcount) {
  return pickupcount + item.count > item.maxcount;
}

function canstackpickup(scriptablename, pickupcount) {
  foreach(item in self.br_inventory_slots) {
    if(isDefined(item.scriptablename) && item.scriptablename == scriptablename) {
      if(!isitemfull(item, pickupcount)) {
        return true;
      }
    }
  }

  return false;
}

function canslotitem(scriptablename, pickupcount) {
  if(ispickupstackable(scriptablename)) {
    if(canstackpickup(scriptablename, pickupcount)) {
      return true;
    }
  }

  return isitemslotopen();
}

function getfirstopenslot() {
  for(i = 0; i < 8; i++) {
    if(!isDefined(self.br_inventory_slots[i])) {
      return i;
    }
  }

  return -1;
}

function pickupitemintoinventory(pickup) {
  if(ispickupstackable(pickup.scriptablename)) {
    if(canstackpickup(pickup.scriptablename, pickup.count)) {
      foreach(item in self.br_inventory_slots) {
        if(isDefined(item.scriptablename) && item.scriptablename == pickup.scriptablename) {
          if(!isitemfull(item, pickup.count)) {
            item.count += pickup.count;
            item.count = int(min(item.count, pickup.maxcount));
            return;
          }
        }
      }
    }
  }

  firstopenslot = getfirstopenslot();

  if(firstopenslot == -1) {
    return;
  }

  self.br_inventory_slots[firstopenslot] = pickup;
}

function dropitemfrominventory(slot) {
  if(isDefined(self.br_inventory_slots[slot])) {
    item = self.br_inventory_slots[slot];
    dropinfo = getitemdropinfo(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
    pickupent = spawnpickup(item.scriptablename, dropinfo, item.count);
    utility::function_f3bb4f4911a1beb2(item.scriptablename, "dropped", pickupent, self, dropinfo.origin);

    if(isDefined(item.armorhealth)) {
      pickupent.armorhealth = item.armorhealth;
    } else if(isDefined(item.helmethealth)) {
      pickupent.helmethealth = item.helmethealth;
    } else if(isDefined(item.gasmaskhealth)) {
      pickupent.gasmaskhealth = item.gasmaskhealth;
    }

    br_analytics::branalytics_lootdrop(self, item.scriptablename);
    br_public::removeitemfrominventory(slot);
  }
}

function takegenericgrenadepickup(pickupent) {
  ammocount = equipment::getequipmentslotammo("primary");

  if(isDefined(ammocount) && ammocount < 2) {
    equipment::incrementequipmentslotammo("primary");
  }

  ammocount = equipment::getequipmentslotammo("secondary");

  if(isDefined(ammocount) && ammocount < 2) {
    equipment::incrementequipmentslotammo("secondary");
  }
}

function trypickupitemfroment(pickupent) {
  if(canslotitem(pickupent.scriptablename, pickupent.count)) {
    pickupitemintoinventory(pickupent);
    return;
  }

  self iprintlnbold("No room in inventory");
  self playlocalsound("br_pickup_deny");
}

function trypickupitem(scriptablename, count) {
  if(!isDefined(scriptablename) || !isDefined(level.br_pickups.maxcounts[scriptablename]) || !isDefined(level.br_pickups.stackable[scriptablename])) {
    return;
  }

  pickup = spawnStruct();
  pickup.scriptablename = scriptablename;
  pickup.count = count;
  pickup.maxcount = level.br_pickups.maxcounts[scriptablename];
  pickup.stackable = level.br_pickups.stackable[scriptablename];
  pickup.itemtype = level.br_pickups.br_itemtype[scriptablename];

  if(canslotitem(pickup.scriptablename, pickup.count)) {
    pickupitemintoinventory(pickup);
    return;
  }

  self iprintlnbold("No room in inventory");
  self playlocalsound("br_pickup_deny");
}

function droparmor(itemtype, itemhealth) {
  dropinfo = getitemdropinfo(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
  pickupent = spawnpickup(itemtype, dropinfo);
  pickupent.count = 1;
  pickupent.helmethealth = 0;
  pickupent.armorhealth = 0;
  pickupent.gasmaskhealth = 0;

  if(issubstr(itemtype, "helmet")) {
    pickupent.helmethealth = itemhealth;

    if(itemtype == "brloot_armor_helmet_3") {
      perk::removeperk("specialty_stun_resistance");
    }
  }

  br_analytics::branalytics_lootdrop(self, itemtype);
}

function trydroparmorfornewarmor(scriptablename) {
  if(br_public::ishelmet(scriptablename)) {
    if(isDefined(self.br_helmetlevel)) {
      itemtype = armor::helmetitemtypeforlevel(self.br_helmetlevel);

      if(isDefined(itemtype)) {
        droparmor(itemtype, self.br_helmethealth);
      }
    }
  }
}

function tryequiparmor(item, slot) {
  if(isDefined(slot)) {
    self.br_inventory_slots[slot] = undefined;
  }

  trydroparmorfornewarmor(item.scriptablename);

  if(item.scriptablename == "brloot_armor_helmet_1") {
    armor::takehelmet(item, 1);
    return;
  }

  if(item.scriptablename == "brloot_armor_helmet_2") {
    armor::takehelmet(item, 2);
    return;
  }

  if(item.scriptablename == "brloot_armor_helmet_3") {
    armor::takehelmet(item, 3);
  }
}

function initpickupusability() {
  interactive::interactive_addusedcallback(&brpickupsusecallback, "br_pickups");
}

function brpickupsusecallback(entity, player) {
  results = player cantakepickup(entity);
  player showuseresultsfeedback(results);

  if(results != 1) {
    return;
  }

  player onusecompleted(entity);
  deregisterscriptableinstance(entity);

  if(entity isscriptable()) {
    entity freescriptable();
    return;
  }

  entity delete();
}

function handleexplosivepickup(equipname, slot) {
  dropstruct = function_7b9f3966a7a42003();

  if(namespace_e50e624d9af51c8c::function_7e103028c464ab9a(loot::function_b88cfb4893ceedac(equipname))) {
    var_feb782334dd23a66 = utility::array_find(level.br_pickups.br_equipname, equipname);
    lootid = loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
    result = namespace_e50e624d9af51c8c::function_e01d9736b2d100ac(lootid, 1);

    if(istrue(result) && !pickupissameasequipmentslot(equipname, slot) && equipment::getequipmentslotammo(slot) > 0) {
      fakepickup = spawnStruct();
      fakepickup.scriptablename = var_feb782334dd23a66;
      fakepickup.count = 1;
      playpickupfeedback(fakepickup);
      namespace_e50e624d9af51c8c::additemtobackpack(lootid, fakepickup);
    } else {
      if(isDefined(self.equipment[slot]) && equipment::getequipmentslotammo(slot) > 0) {
        dropequipmentinslot(dropstruct, slot);
      }

      equipment::giveequipment(equipname, slot);
      equipment::setequipmentammo(equipname, 1);
    }

    return;
  }

  if(isDefined(self.equipment[slot]) && equipment::getequipmentslotammo(slot) > 0) {
    dropequipmentinslot(dropstruct, slot);
  }

  equipment::giveequipment(equipname, slot);
  equipment::setequipmentammo(equipname, 1);
}

function superslotcleanup(owner) {
  if(game_utility::isbrstylegametype() && !level.allowsupers && !perkfunctions::function_66f0cbd5ff8458fe()) {
    owner equipment::takeequipment("super");
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
  self.var_d7a794d94a3269c6 = undefined;
  self.headgeartype = undefined;
  namespace_7c996eebd51b5b1f::removescubagasmaskfromplayer(self);
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
  self setclientomnvar("ui_gas_mask_opacity_override", 0);

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
    return;
  }

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
    return;
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
    return;
  }

  self function_555e2d32e2756625("");
}

function function_874048c58e96731() {
  br_forcegivecustompickupitem(self, "<dev string:x5c4>", 1, 3);

  foreach(ammotype, ammomax in level.br_ammo_max) {
    self.br_ammo[ammotype] = ammomax;
    br_weapons::br_ammo_player_hud_update_ammotype(ammotype);
  }

  br_weapons::br_ammo_update_weapons(self);
  br_plunder::playerplunderpickup(500);
  br_forcegivecustompickupitem(self, "<dev string:x5da>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x5f2>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x618>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x62e>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x64e>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x667>", 1);
  br_forcegivecustompickupitem(self, "<dev string:x689>", 1);
}

function function_849640d4a4d5ae98() {
  br_forcegivecustompickupitem(self, "<dev string:x5c4>", 1, 3);

  foreach(ammotype, ammomax in level.br_ammo_max) {
    self.br_ammo[ammotype] = ammomax;
    br_weapons::br_ammo_player_hud_update_ammotype(ammotype);
  }

  br_weapons::br_ammo_update_weapons(self);
  br_plunder::playerplunderpickup(500);
}

function getquickdroparmorcount(dropall) {
  var_16d3878433169434 = "brloot_armor_plate";
  equipname = level.br_pickups.br_equipname[var_16d3878433169434];
  equipslot = level.equipment.table[equipname].defaultslot;

  if(isDefined(self.equipment[equipslot])) {
    currentammo = equipment::getequipmentslotammo(equipslot);

    if(currentammo > 0) {
      if(istrue(dropall)) {
        return currentammo;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

function getquickdropammocount(ammotype, dropall) {
  ammoamount = self.br_ammo[ammotype];
  clipsize = level.br_ammo_clipsize[ammotype];

  if(!isDefined(ammoamount) || !isDefined(clipsize)) {
    return 0;
  }

  if(istrue(dropall)) {
    return int(ammoamount);
  }

  return int(min(clipsize, ammoamount));
}

function getquickdropplundercount(dropall) {
  plunderdropsomeamount = getmatchrulesdata("brData", "plunderDropSomeAmount");

  if(istrue(dropall)) {
    return int(min(self.plundercount, 2048 - 1));
  }

  return int(min(self.plundercount, plunderdropsomeamount));
}

function getquickdropweapon(itemindex) {
  dropweaponobj = function_13ecf3644442a3e7(self, itemindex);
  assert(isDefined(dropweaponobj));
  assert(!isnullweapon(dropweaponobj));
  assert(dropweaponobj != makeweapon("<dev string:x6a6>"));
  weaponname = getcompleteweaponname(dropweaponobj);
  return weaponname;
}

function function_13ecf3644442a3e7(player, itemindex) {
  if(itemindex == 2) {
    return namespace_e50e624d9af51c8c::function_2985254128b1c262(player);
  }

  weaponlist = player.equippedweapons;
  var_be28c7bbf8bd3f10 = itemindex == 0;

  foreach(weapon in weaponlist) {
    if(weapon::isunderwaterweapon(weapon)) {
      continue;
    }

    if(weapon::isclimbweapon(weapon)) {
      continue;
    }

    if(weapon::isgunlessweapon(weapon)) {
      continue;
    }

    if(weapon.inventorytype != "primary") {
      continue;
    }

    if(weapon::ismeleeoverrideweapon(weapon)) {
      continue;
    }

    if(var_be28c7bbf8bd3f10) {
      return weapon;
    }

    var_be28c7bbf8bd3f10 = 1;
  }
}

function quickdropremovearmorfrominventory(itemslotindex, itemcount) {
  var_16d3878433169434 = "brloot_armor_plate";
  equipname = level.br_pickups.br_equipname[var_16d3878433169434];
  equipslot = level.equipment.table[equipname].defaultslot;
  equipment::decrementequipmentslotammo(equipslot, itemcount);

  if(istrue(self.insertingarmorplate)) {
    ref = equipment::getcurrentequipment(equipslot);
    currammo = equipment::getequipmentammo(ref);

    if(currammo < 1) {
      self notify("try_armor_cancel", "all_armor_plates_dropped");
    }
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

    if(class::function_da27e3343b019fde() && scripts\cp_mp\weapon::isbackuppistol(weapon)) {
      continue;
    }

    if(weapon != fistsweapon && weapon != var_ec22a950f210e39 && !weapon::ismeleeoverrideweapon(weapon) && !weapon::isunderwaterweapon(weapon) && !weapon::isclimbweapon(weapon)) {
      if(!self isalternatemode(weapon)) {
        var_102d661b1caa8bc1 = weapon;
      } else {
        foreach(altweapon in primaryweapons) {
          if(altweapon.basename == weapon.basename && altweapon.inventorytype == "altmode") {
            var_102d661b1caa8bc1 = altweapon;
            break;
          }
        }
      }

      break;
    }
  }

  if(!weapon_utility::isriotshield(var_ec22a950f210e39)) {
    ammostock = self getweaponammostock(var_ec22a950f210e39);
    weaponammotype = br_weapons::br_ammo_type_for_weapon(var_ec22a950f210e39);

    if(isDefined(weaponammotype)) {
      self.br_ammo[weaponammotype] = min(ammostock, level.var_e6ea72fc5e3fcd00[weaponammotype]);
      self.br_ammo[weaponammotype] = utility::get_int_or_0(self.br_ammo[weaponammotype]);
    }
  }

  if(weapon::isminigunweapon(var_ec22a950f210e39)) {
    self notify("dropped_minigun");
  }

  if(getdvarint(@ "hash_218b826f84233424", 0)) {
    function_5ef33bffaeda4fa9(var_ec22a950f210e39, 0);
  }

  weaponindex = br_weapons::function_2ab3bda08c595a32(self, var_ec22a950f210e39);

  if(isDefined(weaponindex)) {
    br_weapons::function_ae30366a2d519a57(self, weaponindex, undefined);
  }

  inventory_utility::_takeweapon(var_ec22a950f210e39);
  br_public::function_64fa4c213439177f();

  if(!self hasweapon(fistsweapon)) {
    self giveweapon(fistsweapon);
  }

  br_weapons::br_ammo_update_weapons(self);
  self switchtoweaponimmediate(var_102d661b1caa8bc1);
}

function quickdropweapon(player, itemtype, itemindex, itemcount, dropall, dontspawnitem, overridedist, overrideorigin, regulardrop) {
  var_ec22a950f210e39 = function_13ecf3644442a3e7(player, itemindex);

  if(!isDefined(var_ec22a950f210e39) || weapon::isunderwaterweapon(var_ec22a950f210e39) || weapon::isclimbweapon(var_ec22a950f210e39) || weapon::function_1e9278ba699927f7(var_ec22a950f210e39)) {
    return;
  }

  itemcount = 0;
  itemcountlefthand = 0;
  var_dab81ead77442a10 = 0;
  weaponobj = undefined;

  if(!isDefined(var_ec22a950f210e39) || isnullweapon(var_ec22a950f210e39) || var_ec22a950f210e39 == makeweapon("iw9_me_fists_mp") || self isskydiving() || class::function_da27e3343b019fde() && scripts\cp_mp\weapon::isbackuppistol(var_ec22a950f210e39)) {
    return 0;
  } else {
    if(itemindex == 2) {
      itemcount = ter_op(isDefined(player.weaponslotclip), player.weaponslotclip, player getweaponammoclip(var_ec22a950f210e39));
      itemcountlefthand = ter_op(isDefined(player.var_ad7897ecdbcb63), player.var_ad7897ecdbcb63, player getweaponammoclip(var_ec22a950f210e39, "left"));

      if(var_ec22a950f210e39.hasalternate) {
        var_6890a4ce965bba99 = var_ec22a950f210e39 getaltweapon();

        if(isDefined(player.var_86b32aff94b5714e)) {
          var_dab81ead77442a10 = player.var_86b32aff94b5714e;
        } else if(br_weapons::br_ammo_type_for_weapon(var_6890a4ce965bba99) != br_weapons::br_ammo_type_for_weapon(var_ec22a950f210e39)) {
          var_dab81ead77442a10 = player getweaponammoclip(var_6890a4ce965bba99);
        }
      }
    } else {
      itemcount = player getweaponammoclip(var_ec22a950f210e39);
      itemcountlefthand = player getweaponammoclip(var_ec22a950f210e39, "left");

      if(var_ec22a950f210e39.hasalternate) {
        var_6890a4ce965bba99 = var_ec22a950f210e39 getaltweapon();
        weaponammotype = default_to(br_weapons::br_ammo_type_for_weapon(var_ec22a950f210e39), "");
        var_b1159194f163f02a = default_to(br_weapons::br_ammo_type_for_weapon(var_6890a4ce965bba99), "");

        if(weaponammotype != var_b1159194f163f02a) {
          var_dab81ead77442a10 = player getweaponammoclip(var_6890a4ce965bba99);
        }
      }

      if(br_weapons::isexcludedweapon(var_ec22a950f210e39)) {
        itemcountlefthand = player getweaponammostock(var_ec22a950f210e39);
      }
    }

    weaponobj = var_ec22a950f210e39;
  }

  weaponmetadata = undefined;

  if(namespace_b16531563568eaba::function_e0fc1230452cf4e7()) {
    if(itemindex == 2) {
      weaponmetadata = namespace_b16531563568eaba::function_74031e3249a6f69e(player, 2);
    } else {
      weaponmetadata = namespace_b16531563568eaba::function_74031e3249a6f69e(player, itemindex);
    }
  }

  weaponindex = br_weapons::function_2ab3bda08c595a32(player, weaponobj);
  pastteam = undefined;

  if(isDefined(weaponindex)) {
    pastteam = br_weapons::function_86a5c7670325346b(player, weaponindex);
  }

  quickdropweapon = getquickdropweapon(itemindex);

  if(itemindex == 2) {
    namespace_e50e624d9af51c8c::function_954372d604277278(player);
  } else {
    function_d655f2006cfe7789(var_ec22a950f210e39);
    namespace_b16531563568eaba::function_bfedeb20f8b77f3f(player, itemindex, istrue(regulardrop));
  }

  if(istrue(dontspawnitem)) {
    return 1;
  }

  item = quickdropnewitem(itemtype, quickdropweapon, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj, weaponmetadata, overridedist, overrideorigin);

  if(isDefined(item)) {
    scripts\mp\pmc_missions::function_d882e5d473c9b258(player, item, var_ec22a950f210e39);
    item.pastteam = pastteam;

    if(getdvarint(@ "hash_52f4a8ccedf61788", 1) == 1) {
      if(isaxeweapon(weaponobj) && item.count == 0) {
        if(isDefined(player.var_b4657c497095e74b)) {
          player.var_b4657c497095e74b deletescriptableinstance();
        }

        player.var_b4657c497095e74b = item;
      }
    }
  }

  assert(isDefined(player.tookweaponfrom));

  if(isDefined(item)) {
    if(isDefined(player.tookweaponfrom[quickdropweapon])) {
      item.owner = player.tookweaponfrom[quickdropweapon];
      player.tookweaponfrom[quickdropweapon] = undefined;
    } else {
      item.owner = player;
    }

    item.objweapon = weaponobj;
  }

  thread namespace_6b49ddb858f34366::function_adcb155953291ec7(itemindex == 0, 0);
  return 1;
}

function function_8aab3cda02f81c09(player, itemtype, dropall, dontspawnitem, overridecount) {
  if(getdvarint(@ "hash_9e0e52e9b74f15eb", 0)) {
    return false;
  }

  itemcount = getquickdropplundercount(dropall);

  if(isDefined(overridecount)) {
    itemcount = overridecount;
  }

  if(itemcount == 0) {
    return false;
  }

  player br_plunder::playerplunderdrop(itemcount);
  var_8e5dd667f5bf1e1e = br_plunder::getplundernamebyamount(itemcount);

  if(istrue(dontspawnitem)) {
    return true;
  }

  quickdropnewitem(itemtype, var_8e5dd667f5bf1e1e, itemcount);
  return true;
}

function function_f5082b4fc43ef59b(scriptablename) {
  if(!isDefined(level.var_f2b443c644970bd7) || level.var_f2b443c644970bd7.size <= 0 || !isDefined(scriptablename)) {
    return true;
  }

  return !utility::array_contains_key(level.var_f2b443c644970bd7, scriptablename);
}

function function_6f62cb4fc113349c(player, itemtype, itemindex, dropall, dontspawnitem) {
  [lootid, quantity] = namespace_e50e624d9af51c8c::function_6738846da50730f1(itemindex);

  if(lootid == 0) {
    return;
  }

  itemcount = undefined;
  itemcountlefthand = undefined;
  var_dab81ead77442a10 = undefined;
  ref = loot::function_793e8a72cedb8ef3(lootid);
  isdogtag = dmz_dog_tag::function_3c17a26ce6a4668(lootid);
  var_36de08ea672b354c = namespace_126f4192a2d090c4::function_43044da0ed44d79f(ref);

  if(utility::issharedfuncdefined(lootid, "canQuickDrop")) {
    if(!utility::function_f3bb4f4911a1beb2(lootid, "canQuickDrop", player)) {
      return;
    }
  }

  if(function_282d89f7705a2d63(ref)) {
    function_bfc82c27ed3d9308(lootid, quantity, ref, itemindex);
  }

  if(isdogtag) {
    [itemcount, itemcountlefthand, var_dab81ead77442a10] = dmz_dog_tag::function_379463a84adb07b4(quantity);
  } else if(dropall || function_d345eec68e01361f(lootid)) {
    itemcount = quantity;
  } else if(br_public::isammo(ref)) {
    itemcount = int(min(quantity, level.br_pickups.counts[ref]));
  } else {
    itemcount = 1;
  }

  if(var_36de08ea672b354c && !istrue(dontspawnitem)) {
    slot = function_4f4d537c794b2bf5();
    thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    namespace_126f4192a2d090c4::function_3af23b0bfaf91dbd(dropstruct, undefined, undefined, itemindex);
    dontspawnitem = 1;
  } else if(function_df3f5431c93ed5a1(lootid)) {
    return 0;
  } else if(function_e4b6260dbb04b43d(ref)) {
    slot = function_4f4d537c794b2bf5();
    thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    elementid = namespace_2d7f47b19ccdb41d::function_96a1620d901981d1(lootid, 5);
    elemname = namespace_2d7f47b19ccdb41d::function_6844602f3120e900(elementid, 0);
    dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined);
    namespace_2d7f47b19ccdb41d::function_3a7809be256adadb(dropinfo, self);
    element = spawnpickup(elemname, dropinfo, itemcount, 1, undefined, 0);
    namespace_2d7f47b19ccdb41d::function_a5130b39363778b7(self, element, itemindex);
    dontspawnitem = 1;
  } else if(function_2d86ba79a58bb62(ref)) {
    slot = function_4f4d537c794b2bf5();
    thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    player namespace_c62d39d6e6afb119::function_f9ff7c89b3792ccc(dropstruct, player.blacksite);
    dontspawnitem = 1;
  } else if(function_68f7f39db3bc7fa4(ref)) {
    if(issharedfuncdefined("br_puzzle_drone_repair", "onDronePartDropped")) {
      dronepart = loot::getscriptablefromlootid(lootid);
      level thread[[getsharedfunc("br_puzzle_drone_repair", "onDronePartDropped")]](dronepart, player);
    }
  }

  ref = loot::function_793e8a72cedb8ef3(lootid);
  scriptable = undefined;

  if(br_public::isammo(ref)) {
    scriptable = ref;
  } else {
    scriptable = loot::getscriptablefromlootid(lootid);
  }

  if(istrue(dropall) && isDefined(scriptable) && scriptable == "brloot_gascan") {
    [error, newcount] = scripts\cp_mp\vehicles\vehicle_interact::function_cf96fb01f9473d0d(itemcount);

    if(isDefined(error)) {
      scripts\mp\hud_message::showerrormessage(error);
      return;
    }

    namespace_aead94004cf4c147::function_e900e7e66383ad97(self, itemindex, newcount);
    playsoundatpos(self.origin + (0, 0, 30), "eqp_gas_can_siphon");
    return;
  }

  player namespace_aead94004cf4c147::function_db1dd76061352e5b(itemindex, ter_op(isdogtag || var_36de08ea672b354c, quantity, itemcount));

  if(istrue(dontspawnitem)) {
    return;
  }

  if(isDefined(scriptable)) {
    quickdropnewitem(itemtype, scriptable, itemcount, itemcountlefthand, var_dab81ead77442a10);
  }
}

function function_b130392812b25580(player, itemindex, itemtype, dropall, dontspawnitem) {
  itemcount = player equipment::function_fe48baf929906883(equipment::function_4967838290cb31b9(itemindex));

  if(!isDefined(itemcount) || itemcount == 0) {
    return false;
  }

  slot = equipment::function_4967838290cb31b9(itemindex);
  ref = equipment::getcurrentequipment(slot);

  if(istrue(player.var_640464235432d2b6) && scripts\mp\equipment::isequipmentlethal(ref)) {
    return false;
  }

  if(issharedfuncdefined(ref, "getAmmo")) {
    itemcount = player[[getsharedfunc(ref, "getAmmo")]]();
    dropall = 1;
  }

  if(!dropall) {
    itemcount = 1;
  }

  equipment::decrementequipmentslotammo(slot, itemcount);

  if(!istrue(dontspawnitem)) {
    dropslot = function_4f4d537c794b2bf5();
    player thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = dropslot;
    player dropequipmentinslot(dropstruct, slot, 0, itemcount, undefined, 0, itemtype, 1);
  }

  if(ref == "equip_armorplate") {
    player armor::function_50deea7508dbf174();
  }

  if(isDefined(ref) && ref == "equip_throwing_knife" && player equipment::getequipmentslotammo(slot) == 0 && player perk::_hasperk("specialty_equip_throwingKnife")) {
    player throwing_knife_mp::throwing_knife_mp_ontake();
  }

  return true;
}

function function_1503d0b5b4c9d010(player, dropall, dontspawnitem) {
  itemcount = 1;

  if(!player hasanykillstreak()) {
    return false;
  }

  if(!istrue(dontspawnitem)) {
    slot = function_4f4d537c794b2bf5();
    player thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    player dropbrkillstreak(dropstruct, 0, undefined, 1);
  }

  killstreaks::removekillstreak(1);
  return true;
}

function quickdropgasmaskitem(player, dontspawnitem) {
  return function_3ff5a9fd0fa06974(player, dontspawnitem);
}

function function_3ff5a9fd0fa06974(player, dontspawnitem) {
  slot = function_4f4d537c794b2bf5();
  player thread function_1e450adba8ddc914();
  dropstruct = function_7b9f3966a7a42003();
  dropstruct.dropidx = slot;
  player thread function_e374e6d9eaaa4dc5(dropstruct, dontspawnitem, 1);
  return true;
}

function function_8f803ea058a13cbd(player, dontspawnitem) {
  if(!istrue(dontspawnitem)) {
    slot = function_4f4d537c794b2bf5();
    player thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    player dropbrselfrevivetoken(dropstruct);
  } else {
    player removeselfrevivetoken();
  }

  return true;
}

function function_b15e36b7bc247ddb(player, dropall, dontspawnitem) {
  itemcount = player function_fcde72dcbcec206b(1);
  equipref = self.equipment["super"];

  if(isDefined(self.equipment["super"]) && player perkfunctions::function_66f0cbd5ff8458fe() && supers::issuperready()) {
    itemcount = 1;
  }

  if(!isDefined(itemcount) || itemcount == 0) {
    return 0;
  }

  if(!dropall) {
    itemcount = 1;
  }

  if(!istrue(dontspawnitem)) {
    if(isDefined(equipref) && scripts\mp\supers\vehicle_drop::function_852ea8e204596ed0(equipref)) {
      return 0;
    }

    slot = function_4f4d537c794b2bf5();
    player thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    player dropequipmentinslot(dropstruct, "super", 0, itemcount, undefined, 0, 4, 1);
  }

  if(supers::issuperinuse()) {
    supers::superusefinished();
  }

  player resetsuper();
  self.equipment["super"] = undefined;
}

function quickdropammo(player, itemindex, itemtype, dropall, dontspawnitem) {
  ammotype = br_weapons::function_5a80dba504420037(itemindex);
  ammocount = br_weapons::function_1352197e2482f1cf(player, ammotype);

  if(!isDefined(ammocount) || ammocount == 0) {
    return false;
  }

  if(isDefined(player.var_55562bd5eb6065e5)) {
    activeweapon = player scripts\mp\gametypes\br_weapons::function_27ef2c36eb95d796();

    if(scripts\mp\gametypes\br::function_f32857a938336f2b(player, activeweapon)) {
      return false;
    }
  }

  if(!dropall) {
    ammocount = int(min(ammocount, br_weapons::function_2bf8eaf550fbe399(ammotype)));
  }

  br_weapons::br_ammo_take_type(player, ammotype, ammocount);

  if(!istrue(dontspawnitem)) {
    quickdropnewitem(itemtype, ammotype, ammocount);
  }

  return true;
}

function function_9e2cddc7551c1be4(player, dontspawnitem) {
  if(!istrue(dontspawnitem)) {
    slot = function_4f4d537c794b2bf5();
    player thread function_1e450adba8ddc914();
    dropstruct = function_7b9f3966a7a42003();
    dropstruct.dropidx = slot;
    function_b8faa69b95fe55be(dropstruct);
    dontspawnitem = 1;
  }
}

function function_f95a2789ce5b15ff(itemtype, itemindex, dropall, dontspawnitem) {
  var_af23c9496d97c4e3 = itemtype == 0 || itemtype == 10 || itemtype == 5;

  if(isDefined(self.var_e5520effcbe8bd30) && !var_af23c9496d97c4e3) {
    return;
  }

  switch (itemtype) {
    case 0:
      function_8aab3cda02f81c09(self, itemtype, dropall, dontspawnitem);
      break;
    case 1:
      quickdropweapon(self, itemtype, itemindex, undefined, dropall, dontspawnitem, undefined, undefined, 1);
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
      function_b15e36b7bc247ddb(self, 1, dontspawnitem);
      break;
    case 6:
      if(!istrue(self.var_ca27f3fd3dad0c1f)) {
        function_3ff5a9fd0fa06974(self, dontspawnitem);
      }

      break;
    case 7:
      function_8f803ea058a13cbd(self, dontspawnitem);
      break;
    case 5:
      quickdropammo(self, itemindex, itemtype, dropall, dontspawnitem);
      break;
    case 12:
      break;
    case 13:
      function_9e2cddc7551c1be4(self, dontspawnitem);
      break;
    default:
      assertmsg("<dev string:x6b9>" + itemtype);
      return;
  }
}

function quickdropcleanupcache() {
  var_1ca69ee8605fc45d = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  self endon("death");
  level endon("game_ended");
  wait var_1ca69ee8605fc45d;
  self.quickdropcache = undefined;
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

  if(isplunder(scriptablename)) {
    self.quickdropcache["cash"] = newitem;
  } else {
    self.quickdropcache[scriptablename] = newitem;
  }

  thread quickdropcleanupcache();
}

function quickdropcachematchesplayer(cacheitem) {
  distance_threshold = 60;
  var_9867768cea965153 = squared(distance_threshold);
  angle_threshold = 45;
  distsquared = distancesquared(self.origin, cacheitem.playerorigin);

  if(distsquared > var_9867768cea965153) {
    return false;
  }

  anglediff = abs(self.angles[1] - cacheitem.playeryaw);

  if(anglediff > angle_threshold) {
    return false;
  }

  return true;
}

function quickdropfinditemincache(scriptablename) {
  if(!isDefined(scriptablename)) {
    return;
  }

  if(!isDefined(self.quickdropcache)) {
    return;
  }

  cacheindex = scriptablename;

  if(isplunder(scriptablename)) {
    cacheindex = "cash";
  }

  if(!isDefined(self.quickdropcache[cacheindex])) {
    return;
  }

  if(!isDefined(self.quickdropcache[cacheindex].ent)) {
    self.quickdropcache[cacheindex] = undefined;
    return;
  }

  if(distancesquared(self.quickdropcache[cacheindex].droporigin, self.origin) > 20000) {
    return;
  }

  return self.quickdropcache[cacheindex];
}

function quickdropcachefindslot() {
  if(!isDefined(self.quickdropcache)) {
    return 0;
  }

  slotstaken = [];

  foreach(cacheitem in self.quickdropcache) {
    if(isDefined(cacheitem.ent)) {
      if(!quickdropcachematchesplayer(cacheitem)) {
        continue;
      }

      slotstaken[cacheitem.slot] = 1;
    }
  }

  slotindex = undefined;
  var_dde65f6afbec7591 = 0;
  ringindex = 0;
  var_5b256c2c2dd532e3 = [0, 8, 1];

  while(true) {
    slotindex = ringindex * 9 + var_5b256c2c2dd532e3[var_dde65f6afbec7591];

    if(!istrue(slotstaken[slotindex])) {
      break;
    }

    var_dde65f6afbec7591++;

    if(var_dde65f6afbec7591 >= var_5b256c2c2dd532e3.size) {
      var_dde65f6afbec7591 = 0;
      ringindex++;
    }
  }

  return slotindex;
}

function function_4f4d537c794b2bf5() {
  if(!isDefined(level.var_2dc1d82da1dbfeab)) {
    level.var_2dc1d82da1dbfeab = [0, 8, 1, 7, 2, 9, 17, 10, 16, 18, 26, 19, 25];
  }

  if(!isDefined(self.var_1ac656ba9c98b8db)) {
    self.var_1ac656ba9c98b8db = 0;
  } else {
    self.var_1ac656ba9c98b8db++;
  }

  return level.var_2dc1d82da1dbfeab[self.var_1ac656ba9c98b8db % level.var_2dc1d82da1dbfeab.size];
}

function function_1e450adba8ddc914() {
  self endon("disconnect");

  if(isDefined(self) && isDefined(self.var_1ac656ba9c98b8db) && self.var_1ac656ba9c98b8db == 0) {
    startorigin = self.origin;
    startangles = self.angles;

    while(isDefined(self) && distancesquared(startorigin, self.origin) < 100 && anglesdelta(startangles, self.angles) < 10) {
      wait 1;
    }

    if(isDefined(self)) {
      self.var_1ac656ba9c98b8db = undefined;
      self notify("reset_slots");
    }
  }
}

function function_1ce1a3739db60bfb(scriptablename) {
  if(isplunder(scriptablename)) {
    return "br_inventory_drop_plunder_med";
  } else if(br_public::isammo(scriptablename)) {
    return "br_inventory_drop_ammo";
  } else if(scriptablename == "brloot_offhand_throwingknife" || scriptablename == "brloot_offhand_shuriken") {
    return "iw9_br_inventory_drop_knife";
  } else if(scriptablename == "brloot_gascan") {
    return "iw9_br_inventory_drop_gas_can";
  } else if(br_public::isequipmentlethal(scriptablename)) {
    return "iw9_br_inventory_drop_lethal";
  } else if(br_public::isequipmenttactical(scriptablename)) {
    return "iw9_br_inventory_drop_tactical";
  } else if(br_public::isarmorplate(scriptablename)) {
    return "br_inventory_drop_armor";
  } else if(isstartstr(scriptablename, "iw")) {
    return "br_inventory_drop_weap";
  } else if(isstartstr(scriptablename, "loot_key")) {
    return "br_inventory_drop_key";
  }

  return "br_inventory_drop_generic";
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
    case 6:
    case 7:
    case 10:
      aliasname = function_1ce1a3739db60bfb(scriptablename);
      break;
    default:
      assertmsg("<dev string:x6db>" + itemtype);
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
  basename = utility::default_to(weaponobj.basename, "");
  material = utility::default_to(weaponobj.material, "");

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
  trace = trace::ray_trace(origin, downward, self, undefined, 1);
  surfacetype = trace["surfacetype"];
  waittillframeend();
  weapons::function_e7dbbe9220d5e27b(surfacetype);
}

function quickdropaddtoexisting(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj) {
  if(!function_f5082b4fc43ef59b(scriptablename)) {
    return false;
  }

  cacheitem = quickdropfinditemincache(scriptablename);

  if(isDefined(cacheitem)) {
    oldent = cacheitem.ent;
    oldorigin = cacheitem.droporigin;
    oldangles = cacheitem.dropangles;
    oldcount = loot_getitemcount(oldent);
    var_74b23b8eea29a555 = loot_getitemcountlefthand(oldent);
    var_4ff1e9f60bcf8fe8 = function_3a5f7703319142dd(oldent);
    var_7b6c183185edff64 = istrue(cacheitem.ent.var_6216e086379def7d);
    var_623f993e8a5ac105 = lootgetscriptablename(cacheitem.ent);

    if(!ispickupstackable(scriptablename) && !issubstr(var_623f993e8a5ac105, "_cash")) {
      return false;
    }

    newcount = oldcount + itemcount;

    if(newcount >= 2048) {
      return false;
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
    dropinfo = getitemdropinfo(oldorigin, oldangles, droppayload, oldent.linkedparent);
    cacheindex = scriptablename;

    if(isplunder(scriptablename)) {
      cacheindex = "cash";
      var_3466c10973e9c476 = br_plunder::getplundernamebyamount(newcount);

      if(var_3466c10973e9c476 != scriptablename) {
        scriptablename = var_3466c10973e9c476;
      }
    }

    newent = spawnpickup(scriptablename, dropinfo, newcount, 1, weaponobj, 0, var_9e57dc7afe8604c8, var_a69b5a02ffae97ff);

    if(isent(self) && isPlayer(self)) {
      br_analytics::branalytics_lootdrop(self, scriptablename, undefined, itemcount);
    }

    if(isDefined(weaponobj)) {
      level.onweapondropcreated callback_group::callback_trigger(newent, self, weaponobj);
    }

    soundname = scriptablename;

    if(isplunder(scriptablename)) {
      soundname = br_plunder::getplundernamebyamount(newcount);

      if(var_7b6c183185edff64) {
        newent.var_6216e086379def7d = 1;
      }
    }

    if(isDefined(itemtype)) {
      quickdropplaySound(itemtype, oldorigin, soundname, newent);
    }

    self.quickdropcache[cacheindex].ent = newent;
    thread quickdropcleanupcache();
    deregisterscriptableinstance(oldent);

    if(isent(oldent)) {
      oldent delete();
    } else {
      oldent freescriptable();
    }

    return true;
  }

  return false;
}

function quickdropnewitem(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj, weaponmetadata, overridedist, overrideorigin) {
  var_285b7129b392cf3d = quickdropaddtoexisting(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj);

  if(var_285b7129b392cf3d) {
    return;
  }

  slot = function_4f4d537c794b2bf5();
  thread function_1e450adba8ddc914();
  dropstruct = function_7b9f3966a7a42003();
  dropstruct.dropidx = slot;
  dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, overridedist, undefined, undefined, overrideorigin);
  newent = undefined;
  ismissionweapon = br_extract_quest::extract_ismissionweapon(weaponobj);

  if(!ismissionweapon) {
    newent = spawnpickup(scriptablename, dropinfo, itemcount, 1, weaponobj, 0, itemcountlefthand, var_dab81ead77442a10);
    utility::function_f3bb4f4911a1beb2(scriptablename, "dropped", newent, self, dropinfo.origin);
    scripts\cp_mp\talking_gun::function_aba04688789ce643(newent, weaponobj);
    quickdropaddtocache(scriptablename, slot, newent, dropinfo.origin, dropinfo.angles);
    br_analytics::branalytics_lootdrop(self, scriptablename, undefined, itemcount);

    if(isDefined(weaponobj)) {
      level.onweapondropcreated callback_group::callback_trigger(newent, self, weaponobj);

      if(br_weapons::function_b1dd9dcae2f63965()) {
        br_weapons::function_8e7e1da48d7746e5(self, newent);
      }

      if(istrue(level.var_34906263684780b7) && getdvarint(@ "hash_752eeed3ddcbd04b", 0) == 0) {
        ammotype = br_weapons::br_ammo_type_for_weapon(weaponobj);

        if(isDefined(ammotype) && br_weapons::function_ad972c1d0f29841c(self, weaponobj) && self.br_ammo[ammotype] > 0) {
          var_660523cff419f0b = getdvarint(@ "hash_3c4edd0a748e4053", 1);
          dirvec = dropinfo.origin - self.origin;
          upvec = anglestoup(dropinfo.angles);
          var_5a060c381dce3622 = vectorcross(vectorNormalize(dirvec), upvec);
          var_5a060c381dce3622 = rotatepointaroundvector(upvec, var_5a060c381dce3622, getdvarint(@ "hash_51cb230bbd599b71", 20));
          var_9edc776840baff95 = dropinfo.origin + var_5a060c381dce3622 * getdvarint(@ "hash_16e74796df75b8d0", 20);
          ammodropstruct = function_7b9f3966a7a42003();
          dropinfo = getitemdroporiginandangles(ammodropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, var_9edc776840baff95);
          ammopickup = spawnpickup(ammotype, dropinfo, self.br_ammo[ammotype], 1, undefined, var_660523cff419f0b);
          br_weapons::br_ammo_take_type(self, ammotype, self.br_ammo[ammotype]);
        }
      }
    }

    if(isDefined(weaponmetadata)) {
      newent.metadata = weaponmetadata;
    }
  }

  if(isplunder(scriptablename)) {
    newent.var_6216e086379def7d = 1;
    newent.lastowner = self;
    scriptablename = br_plunder::getplundernamebyamount(itemcount);
  }

  if(function_68f7f39db3bc7fa4(scriptablename)) {
    if(issharedfuncdefined("br_puzzle_drone_repair", "onDronePartDropped")) {
      level thread[[getsharedfunc("br_puzzle_drone_repair", "onDronePartDropped")]](scriptablename, self);
    }
  }

  calloutmarkerping::function_1062f2af5c7d843e(scriptablename, weaponobj);
  quickdropplaySound(itemtype, dropinfo.origin, scriptablename, newent, weaponobj);
  return newent;
}

function function_696e4b1495ad2dd3(instance) {
  if(!isDefined(self) || !isDefined(instance.lastowner) || self == instance.lastowner || self.team != instance.lastowner.team) {
    return;
  }

  if(!isDefined(self.var_7d3ea67ce4fc9efa)) {
    self.var_7d3ea67ce4fc9efa = 0;
  }

  if(!isDefined(instance.lastowner.var_7d3ea67ce4fc9efa)) {
    instance.lastowner.var_7d3ea67ce4fc9efa = 0;
  }

  self.var_7d3ea67ce4fc9efa += instance.count;
  instance.lastowner.var_7d3ea67ce4fc9efa = max(instance.lastowner.var_7d3ea67ce4fc9efa - instance.count, 0);
}

function quickdropitem(itemtype, itemindex, dontspawnitem) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  function_f95a2789ce5b15ff(itemtype, itemindex, 0, dontspawnitem);
}

function quickdropall(itemtype, itemindex, dontspawnitem) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  function_f95a2789ce5b15ff(itemtype, itemindex, 1, dontspawnitem);
}

function function_f7e756154ec35632(itemtype, itemindex) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_baa2def287f02cc9 = self.var_2fa5b49969def47.contents[0]["lootID"];
  var_ee01cb619969c19 = self.var_2fa5b49969def47.contents[0]["quantity"];
  var_bbde9e028d7e5cba = loot::getscriptablefromlootid(var_baa2def287f02cc9);
  dropall = 0;
  dontspawnitem = 0;

  if(isDefined(self.var_2fa5b49969def47.itemtype) && isDefined(self.var_2fa5b49969def47.itemindex) && self.var_2fa5b49969def47.itemtype == itemtype && self.var_2fa5b49969def47.itemindex == itemindex) {
    return;
  }

  switch (itemtype) {
    case 10:
      slotopen = isDefined(namespace_e50e624d9af51c8c::getavailabledmzbackpackindex());

      if(istrue(slotopen)) {
        fakepickup = spawnStruct();
        fakepickup.scriptablename = var_bbde9e028d7e5cba;
        fakepickup.count = var_ee01cb619969c19;
        fakepickup.origin = self.var_2fa5b49969def47.origin;

        if(function_2d86ba79a58bb62(var_bbde9e028d7e5cba)) {
          if(isDefined(self.var_2fa5b49969def47.contents[0]["extraInfoEnt"])) {
            fakepickup.blacksite = self.var_2fa5b49969def47.contents[0]["extraInfoEnt"];
            teamplayers = player_utility::getteamarray(self.team, 0);
            originalteam = self.team;

            if(isDefined(self.var_2fa5b49969def47.contents[0]["extraInfoTeam"])) {
              originalteam = self.var_2fa5b49969def47.contents[0]["extraInfoTeam"];
            }

            namespace_c62d39d6e6afb119::function_7bc622d2fe4b2017(fakepickup.blacksite, 0, teamplayers, originalteam, self.team);
          }
        } else if(function_e4b6260dbb04b43d(var_bbde9e028d7e5cba)) {
          fakepickup.elementref = self.var_2fa5b49969def47.elementref;
        }

        namespace_e50e624d9af51c8c::additemtobackpack(var_baa2def287f02cc9, fakepickup, undefined, 1);
        self.var_2fa5b49969def47.contents[0]["lootID"] = 0;
        self.var_2fa5b49969def47.contents[0]["quantity"] = 0;
        loot::function_446c7ad7bcc70992(self, self.var_2fa5b49969def47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self.var_2fa5b49969def47 notify("closed");
        loothide(self.var_2fa5b49969def47);
      }

      break;
    case 2:
      itemcount = equipment::getequipmentslotammo(equipment::function_4967838290cb31b9(itemindex));
      slotopen = !isDefined(itemcount) || itemcount == 0;

      if(slotopen) {
        slot = equipment::function_4967838290cb31b9(itemindex);
        itemref = loot::function_793e8a72cedb8ef3(var_baa2def287f02cc9);
        equipmax = equipment::getequipmentmaxammo(itemref);
        equipmax = utility::default_to(equipmax, 1);
        var_75e244e5f45c894d = var_ee01cb619969c19;

        if(equipmax < var_ee01cb619969c19) {
          var_75e244e5f45c894d = equipmax;
          dropstruct = function_7b9f3966a7a42003();
          dropinfo = getitemdroporiginandangles(dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, self.var_2fa5b49969def47.origin);
          item = spawnpickup(var_bbde9e028d7e5cba, dropinfo, var_ee01cb619969c19 - equipmax, 1, undefined, 0);
        }

        self.var_2fa5b49969def47.contents[0]["lootID"] = 0;
        self.var_2fa5b49969def47.contents[0]["quantity"] = 0;
        loot::function_446c7ad7bcc70992(self, self.var_2fa5b49969def47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self.var_2fa5b49969def47 notify("closed");
        loothide(self.var_2fa5b49969def47);
        equipment::giveequipment(itemref, slot);
        equipment::setequipmentammo(itemref, var_75e244e5f45c894d);
      }

      break;
    case 4:
      itemcount = equipment::getequipmentslotammo("super");
      slotopen = !isDefined(itemcount) || itemcount == 0;

      if(slotopen) {
        equipname = level.br_pickups.br_equipname[var_bbde9e028d7e5cba];
        supername = level.br_pickups.var_14bd11727c4b6629[var_bbde9e028d7e5cba];
        self.var_2fa5b49969def47.contents[0]["lootID"] = 0;
        self.var_2fa5b49969def47.contents[0]["quantity"] = 0;
        loot::function_446c7ad7bcc70992(self, self.var_2fa5b49969def47, 0, 0, 0);
        self setclientomnvar("loot_container_open", 0);
        self.var_2fa5b49969def47 notify("closed");
        loothide(self.var_2fa5b49969def47);
        _givebrsuper(equipname, supername, var_ee01cb619969c19);
      }

      break;
    default:
      break;
  }
}

function equipbackpackitem(itemslotindex) {
  level endon("game_ended");
  [lootid, quantity] = namespace_e50e624d9af51c8c::function_6738846da50730f1(itemslotindex);
  itemref = loot::function_793e8a72cedb8ef3(lootid);

  if(function_282d89f7705a2d63(itemref)) {
    function_27443a5346bc8120(lootid, quantity, itemref, itemslotindex);
    return;
  }

  if(!isDefined(itemref) || isDefined(itemref) && !br_public::isammo(itemref)) {
    self.var_e0c39101bfc15d2[itemslotindex] = 1;
    equipitem(lootid, quantity, itemslotindex, undefined, 1);
    self.var_e0c39101bfc15d2[itemslotindex] = undefined;
  }
}

function function_27443a5346bc8120(lootid, quantity, itemref, itemslotindex) {
  if(itemref == "brloot_nvg") {
    function_60ea3b868e7a009b();
    return;
  }

  if(itemref == "brloot_disguise") {
    if(!disguise::function_d3b190ee881c5ca7()) {
      disguise::function_67d03e329e13f612(itemref);
      return;
    }

    scripts\mp\equipment\disguise::function_3ede6b66136c0f93();
  }
}

function function_60ea3b868e7a009b() {
  ison = self isnightvisionon();

  if(ison) {
    self nightvisionviewoff();
  } else {
    self nightvisionviewon();
  }

  thread scripts\mp\equipment\nvg::nvg_monitor();
}

function function_bfc82c27ed3d9308(lootid, quantity, itemref, itemslotindex) {
  if(itemref == "brloot_nvg") {
    var_c0cdb299fadbabc3 = namespace_aead94004cf4c147::gettotalitemcountinbag(lootid);

    if(var_c0cdb299fadbabc3 <= 1) {
      if(self isnightvisionon()) {
        self nightvisionviewoff();
      }
    }

    thread function_5ddb83e059ee76c9(lootid);
    return;
  }

  if(itemref == "brloot_disguise") {
    if(scripts\mp\equipment\disguise::function_d3b190ee881c5ca7()) {
      if(scripts\mp\equipment\disguise::function_65a78266ead29817()) {
        thread function_2ea494708e46229b(lootid);
        return;
      }

      scripts\mp\equipment\disguise::function_3ede6b66136c0f93();
    }
  }
}

function function_2ea494708e46229b(lootid) {
  self notify("watch_disguise_backpack");
  level endon("game_ended");
  self endon("watch_disguise_backpack");
  self endon("disconnect");

  while(scripts\mp\equipment\disguise::function_65a78266ead29817()) {
    waitframe();
  }

  var_5773c32ec9b66a48 = namespace_aead94004cf4c147::function_d63a7299c6203bf9(lootid);

  if(var_5773c32ec9b66a48) {
    return;
  }

  scripts\mp\equipment\disguise::function_3ede6b66136c0f93();
}

function function_5ddb83e059ee76c9(lootid) {
  self notify("watch_nvg_backpack");
  level endon("game_ended");
  self endon("watch_nvg_backpack");
  self endon("disconnect");
  self endon("night_vision_off");
  wait 1;
  hasnvg = namespace_aead94004cf4c147::function_d63a7299c6203bf9(lootid);

  if(hasnvg) {
    return;
  }

  self nightvisionviewoff();
}

function function_282d89f7705a2d63(itemref) {
  if(!isDefined(itemref)) {
    return 0;
  }

  switch (itemref) {
    case #"hash_5fd271e568cc2313":
    case #"hash_c6fbab1b754d4731":
      return 1;
    default:
      return 0;
  }
}

function function_f1a38d2ba0bbcb08(player, itemslotindex, sellall) {
  if(isDefined(player.plundercount) && player.plundercount >= level.br_plunder.plunderlimit) {
    player hud_message::showerrormessage(level.br_pickups.br_pickupdenyplunderpickup);
    return;
  }

  [lootid, quantity] = namespace_e50e624d9af51c8c::function_6738846da50730f1(itemslotindex);
  itemref = loot::getscriptablefromlootid(lootid);
  type = loot::function_282cf83c9eeda744(lootid);
  var_9fb3b576439ee3d = 1;

  if((istrue(sellall) || !function_f5082b4fc43ef59b(itemref)) && !dmz_dog_tag::function_3c17a26ce6a4668(lootid)) {
    var_9fb3b576439ee3d = quantity;
  }

  if(isDefined(itemref) && (isvaluable(itemref) || isdogtag(itemref) || ispersonal(itemref) || function_32125eba262380c7(itemref) && utility::array_contains_key(level.br_pickups.br_value, itemref) && level.br_pickups.br_value[itemref] > 0)) {
    cashvalue = var_9fb3b576439ee3d * level.br_pickups.br_value[itemref];

    if(isDefined(player.plundercount) && cashvalue + player.plundercount > level.br_plunder.plunderlimit) {
      var_2c86af91e7e20602 = cashvalue + player.plundercount - level.br_plunder.plunderlimit;
      cashvalue = level.br_plunder.plunderlimit - player.plundercount;

      if(var_2c86af91e7e20602 > 0) {
        var_8e5dd667f5bf1e1e = br_plunder::getplundernamebyamount(var_2c86af91e7e20602);
        dropstruct = function_7b9f3966a7a42003();
        overridedist = undefined;

        if(isDefined(player.br_kiosk)) {
          overridedist = distance2d(player.origin, player.br_kiosk.origin) / 2;
        }

        dropinfo = getitemdroporiginandangles(dropstruct, player.origin, player.angles, player, undefined, overridedist);
        spawnpickup(var_8e5dd667f5bf1e1e, dropinfo, var_2c86af91e7e20602, 1);
      }
    }

    player br_plunder::playerplunderpickup(cashvalue);
    player br_plunder::function_5a2284274d70f7d(2, cashvalue);
    var_74806f0c4caa7e55 = var_9fb3b576439ee3d;

    if(isdogtag(itemref)) {
      var_74806f0c4caa7e55 = quantity;
    }

    if(isvaluable(itemref)) {
      pmc_missions::onitemsold(player, itemref);
      scripts\mp\gametypes\br_analytics::function_7dcf65411dc17f09(itemref, level.br_pickups.br_value[itemref], var_9fb3b576439ee3d, cashvalue, player);
    }

    player namespace_e50e624d9af51c8c::function_db1dd76061352e5b(itemslotindex, var_74806f0c4caa7e55);
    player challenges::function_ea50038423fc4cfc(type, itemref, lootid, var_9fb3b576439ee3d, cashvalue);
    utility::function_f3bb4f4911a1beb2(lootid, "onItemSold", player, lootid, type, var_9fb3b576439ee3d, cashvalue);
  }
}

function function_64f0398b29cf7c3e(player) {
  var_1d4db10d5290694a = player namespace_e50e624d9af51c8c::snapshotbackpack();

  foreach(item in var_1d4db10d5290694a) {
    if(!isDefined(item.objweapon) && isDefined(item.index)) {
      function_f1a38d2ba0bbcb08(player, item.index, 1);
    }
  }
}

function equipweapon(weaponobj, quantity, itemslotindex, countalt, backpackequip, weaponstowed, metadata, overridedist, overrideorigin, pastteam, var_8beae58a219e6d44) {
  var_bada25504e8844d7 = spawnStruct();
  scriptablename = undefined;

  if(isDefined(weaponobj)) {
    fullweapon = getcompleteweaponname(weaponobj);

    if(isDefined(level.br_pickups.var_9e78b5ee377070a9) && isDefined(level.br_pickups.var_9e78b5ee377070a9[fullweapon])) {
      scriptablename = level.br_pickups.var_9e78b5ee377070a9[fullweapon];
    }
  }

  var_bada25504e8844d7.scriptablename = utility::default_to(scriptablename, "brloot_weapon_generic_pi");
  var_bada25504e8844d7.origin = utility::ter_op(isDefined(overrideorigin), overrideorigin, self.origin);
  var_bada25504e8844d7.count = quantity;
  var_bada25504e8844d7.weapon = weaponobj;
  var_bada25504e8844d7.countlefthand = var_8beae58a219e6d44;
  var_bada25504e8844d7.countalt = countalt;
  var_bada25504e8844d7.metadata = metadata;
  var_bada25504e8844d7.overridedist = overridedist;
  var_bada25504e8844d7.pastteam = pastteam;
  var_bada25504e8844d7.var_c03c4ef51659ba4c = istrue(backpackequip);
  onusecompleted(var_bada25504e8844d7, undefined, 1, 0, itemslotindex, undefined, backpackequip, 0, weaponstowed);
  return true;
}

function function_b76f69ce63757cea(lootref) {
  player = self;

  if(!game_utility::isbrstylegametype() || !getdvarint(@ "hash_1f9797aa5675c82a", 1)) {
    return false;
  }

  lootid = loot::getlootidfromref(lootref);
  var_ec3be9f70c7f5ae9 = player namespace_e50e624d9af51c8c::function_5915bdbc5f6302b6([lootid]);

  if(isDefined(var_ec3be9f70c7f5ae9) && var_ec3be9f70c7f5ae9.size > 0) {
    player equipbackpackitem(var_ec3be9f70c7f5ae9[0]);
    return true;
  }

  if(istrue(level.br_pickups.var_5bbd561a9aa69746) && array_contains(level.br_pickups.br_killstreakreference, lootref)) {
    var_a6e8fa1d30b077f9 = player namespace_e50e624d9af51c8c::function_a1ef7227cd878384();

    if(isDefined(var_a6e8fa1d30b077f9) && var_a6e8fa1d30b077f9.size > 0) {
      player equipbackpackitem(var_a6e8fa1d30b077f9[0]);
      return true;
    }
  }

  return false;
}

function equipitem(lootid, quantity, itemslotindex, countalt, backpackequip, weaponstowed, overridedist, overrideorigin) {
  scriptablename = loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptablename)) {
    return;
  }

  if(issuperpickup(scriptablename)) {
    if(supers::issuperinuse() || supers::function_565913010c84ffca()) {
      currentsuper = supers::getcurrentsuper();
      var_9cb951de1a571d32 = isDefined(currentsuper) && isDefined(currentsuper.staticdata) && isDefined(currentsuper.staticdata.ref);
      ref = "";

      if(var_9cb951de1a571d32) {
        ref = currentsuper.staticdata.ref;
      }

      if(ref != "super_stimpistol" && ref != "super_oxygen_mask") {
        if(utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPERS_UNAVAILABLE_EQUIP");
        }

        return;
      } else {
        supers::switchandtakesuperuseweapon();
      }
    }

    if(isDefined(self.equipment["super"])) {
      var_57b0241752598e4a = utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);

      if(var_57b0241752598e4a == scriptablename) {
        if(equipment::getequipmentammo(self.equipment["super"]) != 0) {
          hud_message::showerrormessage(level.br_pickups.var_a1a6a7680c4ff1eb);
          return undefined;
        }
      }
    }
  }

  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = utility::ter_op(isDefined(overrideorigin), overrideorigin, self.origin);
  var_bada25504e8844d7.count = quantity;
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];

  if(isDefined(countalt)) {
    var_bada25504e8844d7.countalt = countalt;
  }

  var_bada25504e8844d7.countlefthand = 0;
  var_bada25504e8844d7.var_c03c4ef51659ba4c = istrue(backpackequip);

  if(isDefined(overridedist)) {
    var_bada25504e8844d7.overridedist = overridedist;
  }

  if(iskillstreak(scriptablename) || issuperpickup(scriptablename) && !function_1be34022a4acce73(scriptablename)) {
    var_bada25504e8844d7.count = 1;
  }

  var_171e5792f47d0b3f = undefined;

  if(function_5449da9d3d0358a4(scriptablename)) {
    var_171e5792f47d0b3f = 1;
  }

  return onusecompleted(var_bada25504e8844d7, undefined, 1, 0, itemslotindex, undefined, backpackequip, var_171e5792f47d0b3f, weaponstowed);
}

function lootitem(lootid, quantity, weaponref, var_8598d3d3bc3d9ceb, forcebackpack, var_c03c4ef51659ba4c, overridedist, overrideorigin, autopickup, var_4a08890fd43d6bc7, var_1e2e085b484205c3) {
  scriptablename = weaponref;

  if(!isDefined(weaponref)) {
    scriptablename = loot::getscriptablefromlootid(lootid);
  }

  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = utility::ter_op(isDefined(overrideorigin), overrideorigin, self.origin);
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];

  if(isweaponpickupitem(var_bada25504e8844d7) && namespace_e50e624d9af51c8c::function_7e103028c464ab9a(scriptablename)) {
    [ammo, ammoleft, var_35ead47ed0d7507e] = br_gametype_dmz::getdefaultweaponammo(level.br_lootiteminfo[scriptablename].fullweaponobj, 1);
    var_bada25504e8844d7.count = ammo;
    var_bada25504e8844d7.countlefthand = ammoleft;
    var_bada25504e8844d7.countalt = var_35ead47ed0d7507e;
    var_bada25504e8844d7.var_4a08890fd43d6bc7 = var_4a08890fd43d6bc7;
  } else {
    var_bada25504e8844d7.count = quantity;
    var_bada25504e8844d7.countlefthand = 0;
    var_bada25504e8844d7.countalt = 0;
  }

  if(isDefined(var_8598d3d3bc3d9ceb)) {
    var_bada25504e8844d7.var_8598d3d3bc3d9ceb = var_8598d3d3bc3d9ceb;
  }

  if(isDefined(var_c03c4ef51659ba4c)) {
    var_bada25504e8844d7.var_c03c4ef51659ba4c = var_c03c4ef51659ba4c;
  }

  if(isDefined(overridedist)) {
    var_bada25504e8844d7.overridedist = overridedist;
  }

  return function_b5f5576a0017c089(var_bada25504e8844d7, "visible", self, autopickup, undefined, undefined, forcebackpack, var_1e2e085b484205c3);
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(br_gametypes::isfeaturedisabled("loot")) {
    return;
  }

  circleradiussquared = dangercircleradius * dangercircleradius;
  damagetick = scripts\mp\gametypes\br_circle::function_b5597479d3e5b628();
  level.br_pickups.droppedgasmasks = utility::array_removeundefined(level.br_pickups.droppedgasmasks);

  for(index = level.br_pickups.droppedgasmasks.size - 1; index >= 0; index--) {
    gasmask = level.br_pickups.droppedgasmasks[index];

    if(istrue(gasmask.var_1b46a808091ea19c)) {
      continue;
    }

    if(istrue(gasmask.inairpocket)) {
      continue;
    }

    if(br_circle_util::function_d30c8f0e5abea93b(gasmask.origin, 0)) {
      if(gasmask getscriptablepartstate("damage_fx") == "active") {
        gasmask setscriptablepartstate("damage_fx", "inactive");
      }

      continue;
    }

    if(distance2dsquared(gasmask.origin, dangercircleorigin) > circleradiussquared || br_circle_util::function_d30c8f0e5abea93b(gasmask.origin, 1)) {
      curhealth = gasmask.count;

      if(level.br_circle.circleindex <= level.var_aa1aaed4a9b80d4b) {
        damagetick *= float(level.var_152d5a9c5ac5cdad);
        newhealth = int(curhealth - damagetick);
      } else {
        newhealth = int(curhealth - damagetick);
      }

      if(newhealth <= 0) {
        gasmask setscriptablepartstate(gasmask.type, "death");
        gasmask deletescriptableinstanceaftertime(1, 1);
        level thread deregistergasmaskscriptableatframeend(index);
        continue;
      }

      if(gasmask gasmask::didgasmaskpipschange(curhealth, newhealth)) {
        gasmask setscriptablepartstate("damage_fx", "active");
      }

      loot_setitemcount(gasmask, newhealth);
    }
  }
}

function function_1a1709943670772a() {
  if(br_gametypes::isfeaturedisabled("loot")) {
    return;
  }

  damagetick = scripts\mp\gametypes\br_circle::function_b5597479d3e5b628();
  level.br_pickups.droppedgasmasks = utility::array_removeundefined(level.br_pickups.droppedgasmasks);

  for(index = level.br_pickups.droppedgasmasks.size - 1; index >= 0; index--) {
    gasmask = level.br_pickups.droppedgasmasks[index];

    if(istrue(gasmask.var_1b46a808091ea19c)) {
      continue;
    }

    if(istrue(gasmask.inairpocket)) {
      continue;
    }

    if(br_circle_util::function_d30c8f0e5abea93b(gasmask.origin, 0)) {
      if(gasmask getscriptablepartstate("damage_fx") == "active") {
        gasmask setscriptablepartstate("damage_fx", "inactive");
      }

      continue;
    }

    if(!br_circle_util::ispointinmulticircledanger(gasmask.origin) || br_circle_util::function_d30c8f0e5abea93b(gasmask.origin, 1)) {
      curhealth = gasmask.count;

      if(level.br_circle.circleindex <= level.var_aa1aaed4a9b80d4b) {
        damagetick *= float(level.var_152d5a9c5ac5cdad);
        newhealth = int(curhealth - damagetick);
      } else {
        newhealth = int(curhealth - damagetick);
      }

      if(newhealth <= 0) {
        gasmask setscriptablepartstate(gasmask.type, "death");
        gasmask deletescriptableinstanceaftertime(1, 1);
        level thread deregistergasmaskscriptableatframeend(index);
        continue;
      }

      if(gasmask gasmask::didgasmaskpipschange(curhealth, newhealth)) {
        gasmask setscriptablepartstate("damage_fx", "active");
      }

      loot_setitemcount(gasmask, newhealth);
    }
  }
}

function gasmask_onpickupcreated() {
  level.br_pickups.droppedgasmasks[level.br_pickups.droppedgasmasks.size] = self;
}

function deregistergasmaskscriptableatframeend(index) {
  waittillframeend();

  if(isDefined(level.br_pickups.droppedgasmasks)) {
    level.br_pickups.droppedgasmasks[index] = undefined;
  }
}

function initscriptablemanagement() {
  leveldata = level.br_pickups;
  assertex(isDefined(leveldata), "<dev string:x6fd>");
  assertex(!isDefined(leveldata.scriptables), "<dev string:x746>");
  leveldata.scriptables = [];
  leveldata.scriptablesstartid = 0;
  leveldata.scriptablescurid = 0;
  leveldata.scriptablesmax = getdvarint(@ "scr_br_pickupscriptablesmax", 750);
  leveldata.scriptablescleanupbatchsize = getdvarint(@ "hash_1e71982a0a539739", 10);
  assertex(leveldata.scriptablescleanupbatchsize < leveldata.scriptablesmax, "<dev string:x779>");

  setdevdvarifuninitialized(@ "scr_br_pickupscriptablesmax", leveldata.scriptablesmax);
  setdevdvarifuninitialized(@ "hash_1e71982a0a539739", leveldata.scriptablescleanupbatchsize);

  utility::create_func_ref("deregisterScriptable", &function_7b67823458cd14);
}

function registerscriptableinstance(instance) {
  assertex(isDefined(level.br_pickups), "<dev string:x7bf>");
  assertex(isDefined(level.br_pickups.scriptables), "<dev string:x80a>");
  assertex(!isDefined(instance.brpickupscriptableid), "<dev string:x850>");
  id = level.br_pickups.scriptablescurid;
  instance.brpickupscriptableid = id;
  level.br_pickups.scriptables[id] = instance;
  level.br_pickups.scriptablescurid++;
}

function deregisterscriptableinstance(instance) {
  assertex(isDefined(level.br_pickups), "<dev string:x896>");
  assertex(isDefined(level.br_pickups.scriptables), "<dev string:x8e3>");
  assertex(isDefined(instance.brpickupscriptableid), "<dev string:x92b>");
  level.br_pickups.scriptables[instance.brpickupscriptableid] = undefined;
  instance.brpickupscriptableid = undefined;
}

function function_7b67823458cd14() {
  if(function_f483aacd19d70a1(self)) {
    deregisterscriptableinstance(self);
  }
}

function clearspaceforscriptableinstance() {
  leveldata = level.br_pickups;
  assertex(isDefined(leveldata), "<dev string:x96f>");
  assertex(isDefined(leveldata.scriptables), "<dev string:x9bf>");
  assertex(leveldata.scriptables.size <= leveldata.scriptablesmax, "<dev string:xa0a>");

  if(leveldata.scriptables.size < leveldata.scriptablesmax) {
    return;
  }

  function_ff5569044925c628();
  var_406118f36ab85942 = 0;

  for(i = leveldata.scriptablesstartid; i < leveldata.scriptablescurid; i++) {
    if(var_406118f36ab85942 == leveldata.scriptablescleanupbatchsize) {
      break;
    }

    instance = leveldata.scriptables[i];

    if(isDefined(instance)) {
      if(istrue(instance.criticalitem)) {
        continue;
      }

      foreach(removecallback in level.br_pickups.var_7c25f4fb48db3dd4) {
        instance[[removecallback]]();
      }

      leveldata.scriptables[i] = undefined;

      if(isDefined(instance)) {
        if(isDefined(instance.removecallback)) {
          instance[[instance.removecallback]]();
        } else if(isent(instance)) {
          instance delete();
        } else {
          instance freescriptable();
        }
      }

      var_406118f36ab85942++;
    } else {
      leveldata.scriptables[i] = undefined;
    }

    leveldata.scriptablesstartid++;
  }
}

function function_f483aacd19d70a1(instance) {
  return isDefined(instance) && isDefined(instance.brpickupscriptableid);
}

function deletescriptableinstance(var_1f99273bfef8cf44) {
  if(istrue(self.criticalitem) && !istrue(var_1f99273bfef8cf44)) {
    return;
  }

  if(isDefined(self.brpickupscriptableid)) {
    deregisterscriptableinstance(self);
  }

  if(isent(self)) {
    self delete();
    return;
  }

  loothide(self);
}

function deletescriptableinstanceaftertime(delaytime, var_1f99273bfef8cf44) {
  thread deletescriptableinstanceaftertime_proc(delaytime, var_1f99273bfef8cf44);
}

function deletescriptableinstanceaftertime_proc(delaytime, var_1f99273bfef8cf44) {
  self endon("death");
  wait delaytime;

  if(isDefined(self)) {
    deletescriptableinstance(var_1f99273bfef8cf44);
  }
}

function registeruniquelootcallback(var_7d740d4524ce32a9, callback) {
  while(!isDefined(level.br_pickups)) {
    waitframe();
  }

  level.br_pickups.uniquelootcallbacks["uniqueLootItem_" + var_7d740d4524ce32a9] = callback;
}

function processuniquelootitem(uniquelootitemid, player) {
  if(isDefined([[level.br_pickups.uniquelootcallbacks[uniquelootitemid]]](player))) {
    return;
  }

  assertmsg("<dev string:xa37>");
}

function manageminigunpickup() {
  thread watchaddminigunrestrictions();
  thread watchremoveminigunrestrictions();
  thread watchminigunweapon();
}

function applyminigunrestrictions() {
  self.playerstreakspeedscale = juggernaut::jugg_getmovespeedscalar();
  weapons::updatemovespeedscale();
  val::group_set("fakeJugg", 0);

  if(!istrue(level.disablemount)) {
    val::set("fakeJugg", "mount_top", 0);
    val::set("fakeJugg", "mount_side", 0);
  }
}

function removeminigunrestrictions() {
  self.playerstreakspeedscale = undefined;
  weapons::updatemovespeedscale();
  val::group_reset("fakeJugg");
}

function watchaddminigunrestrictions() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");

  while(true) {
    self waittill("switched_to_minigun");
    applyminigunrestrictions();
  }
}

function watchremoveminigunrestrictions() {
  self endon("death_or_disconnect");
  self endon("juggernaut_start");
  level endon("game_ended");

  while(true) {
    result = utility::waittill_any_return_no_endon_death_2("switched_from_minigun", "dropped_minigun");

    if(isDefined(result)) {
      removeminigunrestrictions();

      if(result == "dropped_minigun") {
        break;
      }
    }
  }
}

function watchminigunweapon() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");
  var_811a4cb44c776b67 = 0;

  while(true) {
    if(!weapon::isminigunweapon(self getcurrentweapon())) {
      if(istrue(var_811a4cb44c776b67)) {
        var_811a4cb44c776b67 = 0;
        self notify("switched_from_minigun");
      }
    } else if(!istrue(var_811a4cb44c776b67)) {
      var_811a4cb44c776b67 = 1;
      self notify("switched_to_minigun");
    }

    waitframe();
  }
}

function doesstreakinfomatchequippedstreak(streakinfo) {
  if(!isDefined(streakinfo)) {
    return false;
  }

  if(!isDefined(self.streakdata)) {
    return false;
  }

  if(!isDefined(self.streakdata.streaks) || !isDefined(self.streakdata.streaks[1])) {
    return false;
  }

  streakdata = self.streakdata.streaks[1];

  if(!isDefined(streakinfo.streakname) || !isDefined(streakdata.streakname) || streakinfo.streakname != streakdata.streakname) {
    return false;
  }

  if(!isDefined(streakinfo.id) || !isDefined(streakdata.uniqueid) || streakinfo.id != streakdata.uniqueid) {
    return false;
  }

  return true;
}

function function_e44c2d69db881894(lootname) {
  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount) || maxcount == 0) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  if(!isDefined(maxcount)) {
    script::demoforcesre("[IW9-672783]: maxCount undefined with lootName: " + lootname);
  }

  lootid = loot::function_fae5e1d3de32d3f7(lootname);

  if(maxcount > 0 && isDefined(lootid)) {
    for(i = 0; i < namespace_e50e624d9af51c8c::getplayerbackpacksize(self); i++) {
      currentlootid = namespace_e50e624d9af51c8c::getlootidatbackpackindex(i);

      if(currentlootid == lootid) {
        slotquantity = namespace_e50e624d9af51c8c::function_897b29adb37f06a7(i);

        if(slotquantity < maxcount) {
          return 1;
        }
      }
    }
  }

  if(br_public::isammo(lootname)) {
    if(!getdvarint(@ "hash_752eeed3ddcbd04b", 0)) {
      var_509d86412c9d7426 = self getweaponslistprimaries();

      foreach(weap in var_509d86412c9d7426) {
        ammotypecomparison = br_weapons::br_ammo_type_for_weapon(weap);

        if(isDefined(ammotypecomparison) && lootname == ammotypecomparison) {
          if(getdvarint(@ "hash_b5db5ff4b3f9e052", 0)) {
            return 1;
          }

          var_8ee7478bb4789b1a = self.br_ammo[lootname] < level.var_e6ea72fc5e3fcd00[lootname];

          if(getdvarint(@ "hash_d116b9023292a13e", 1)) {
            return (!namespace_aead94004cf4c147::function_49a39674c4a064e3(lootname) || var_8ee7478bb4789b1a);
          }

          return var_8ee7478bb4789b1a;
        }
      }

      if(namespace_e50e624d9af51c8c::function_efab78b72d131d76(self)) {
        var_9ac5e72784815708 = namespace_e50e624d9af51c8c::function_2985254128b1c262(self);
        ammotype = br_weapons::br_ammo_type_for_weapon(var_9ac5e72784815708);

        if(isDefined(ammotype) && ammotype == lootname) {
          if(getdvarint(@ "hash_b5db5ff4b3f9e052", 0)) {
            return 1;
          }

          var_8ee7478bb4789b1a = self.br_ammo[lootname] < level.var_e6ea72fc5e3fcd00[lootname];

          if(getdvarint(@ "hash_d116b9023292a13e", 1)) {
            return (!namespace_aead94004cf4c147::function_49a39674c4a064e3(lootname) || var_8ee7478bb4789b1a);
          }

          return var_8ee7478bb4789b1a;
        }
      }

      return 0;
    } else {
      return 1;
    }
  }

  if(isplunder(lootname)) {
    return 1;
  }

  if(function_5aa2768ce2289fe7(lootname)) {
    return 1;
  }

  if(isweaponpickup(lootname) && self function_b096b58fb3808d26()) {
    return 1;
  }

  if(function_1950b02c25bad779(lootname)) {
    return 1;
  }

  if(br_public::isarmorplate(lootname)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;

    if(!isDefined(self.equipment[slot])) {
      return 1;
    }

    if(equipmentslothasroom(lootname, slot)) {
      return 1;
    }

    if(getdvarint(@ "hash_26fdfbd6bcbe5f42", 1) && namespace_e50e624d9af51c8c::isbackpackinventoryenabled()) {
      if(level.var_66a7a8b388d5de9e != -1) {
        if(function_e52b0b5ab01dfa0c(lootname, level.var_66a7a8b388d5de9e)) {
          return 1;
        }
      } else {
        return 1;
      }
    }

    if(lootname == "br_armor_plate" && perk::_hasperk("specialty_fast_armor")) {
      if(isDefined(self.armorhealth) && self.armorhealth <= self.maxarmorhealth - self.maxhealth) {
        return 1;
      }
    }

    return 0;
  }

  if(isgametypeitem(lootname) && istrue(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("gametypeItemIsAutoPickup"))) {
    return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("gametypeItemIsAutoPickup", lootname, self);
  }

  if(function_b989edd9af4f42c7(lootname) && !getdvarint(@ "hash_752eeed3ddcbd04b", 0)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;
    return (pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(lootname, slot));
  }

  if(function_d7c5786a0c42ef6c(lootname) && !getdvarint(@ "hash_752eeed3ddcbd04b", 0)) {
    equipname = level.br_pickups.br_equipname[lootname];
    slot = level.equipment.table[equipname].defaultslot;
    return (pickupissameasequipmentslot(equipname, slot) && equipmentslothasroom(lootname, slot));
  }

  if(function_d0bacee01bff927c(lootname)) {
    return 1;
  }

  if(getdvarint(@ "hash_752eeed3ddcbd04b", 0)) {
    var_bb9e46e1d8130f2 = 0;

    if(function_b989edd9af4f42c7(lootname)) {
      var_bb9e46e1d8130f2 = self function_6b75060e643e52e9() == 1;
    } else if(function_d7c5786a0c42ef6c(lootname)) {
      var_bb9e46e1d8130f2 = self function_c0a39abe7ec43ad8() == 1;
    } else if(iskillstreak(lootname)) {
      var_bb9e46e1d8130f2 = self function_3aa858d217fb4a1a() == 1;
    } else if(issuperpickup(lootname)) {
      var_bb9e46e1d8130f2 = self function_fa1da77265660058() == 1;
    } else if(isrevivepickup(lootname)) {
      var_bb9e46e1d8130f2 = self function_3feb119f85f6cd82() == 1;
    } else if(isgasmask(lootname)) {
      var_bb9e46e1d8130f2 = self function_50b964d023c440e8() == 1;
    }

    return var_bb9e46e1d8130f2;
  }

  return 0;
}

function function_4ebfdbfa1b8e0339(lootname) {
  return lootname == "brloot_dead_agent_radio";
}

function function_b1e944a2b3e15e9d(lootname) {
  return isDefined(lootname) && !issubstr(lootname, "brloot_backpack_player") && lootname != "brloot_backpack" && issubstr(lootname, "brloot_backpack");
}

function function_36de08ea672b354c(lootname) {
  return issubstr(lootname, "brloot_perkpack");
}

function function_9e686ab118ac7725(lootname) {
  return issubstr(lootname, "jup_exgm_force_recon_");
}

function function_5aa2768ce2289fe7(lootname) {
  return lootname == "brloot_scavenger_bag";
}

function function_6ff4fee4f07a3392() {
  self endon("disconnect");
  logstring("br_watch_mobile_cheat_pickups finished setup.");

  while(true) {
    self waittill("luinotifyserver", message, var_2150015540242e9e);

    if(message == "mobile_debug_give_killstreak") {
      killstreakref = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          killstreakref = "toma_strike";
          break;
        case 1:
          killstreakref = "precision_airstrike";
          break;
        case 2:
          killstreakref = "uav";
          break;
        case 3:
          killstreakref = "manual_turret";
          break;
        case 4:
          killstreakref = "scrambler_drone_guard";
          break;
        case 5:
          killstreakref = "directional_uav";
          break;
        case 6:
          killstreakref = "assault_drone";
          break;
        case 7:
          killstreakref = "airdrop";
          break;
        case 8:
          killstreakref = "fuel_airstrike";
          break;
        case 9:
          killstreakref = "hover_jet";
          break;
        case 10:
          killstreakref = "airdrop_escort";
          break;
        case 11:
          killstreakref = "auto_drone";
          break;
        case 12:
          killstreakref = "chopper_gunner";
          break;
        case 13:
          killstreakref = "airdrop_multiple";
          break;
        case 14:
          killstreakref = "gunship";
          break;
        case 15:
          killstreakref = "juggernaut";
          break;
        case 16:
          killstreakref = "cruise_predator";
          break;
        case 17:
          killstreakref = "sentry_gun";
          break;
        case 18:
          killstreakref = "pac_sentry";
          break;
      }

      if(isDefined(killstreakref)) {
        forcegivekillstreak(killstreakref, 1, 0);
      }

      continue;
    }

    if(message == "mobile_debug_give_fieldupgrade") {
      var_d782e69ca6374ba6 = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          var_d782e69ca6374ba6 = "super_tac_cover";
          break;
        case 1:
          var_d782e69ca6374ba6 = "super_trophy";
          break;
        case 2:
          var_d782e69ca6374ba6 = "super_deadsilence";
          break;
        case 3:
          var_d782e69ca6374ba6 = "super_support_box";
          break;
        case 4:
          var_d782e69ca6374ba6 = "super_ammo_drop";
          break;
        case 5:
          var_d782e69ca6374ba6 = "super_armor_drop";
          break;
        case 6:
          var_d782e69ca6374ba6 = "super_battlerage";
          break;
      }

      if(isDefined(var_d782e69ca6374ba6)) {
        forcegivesuper(var_d782e69ca6374ba6, 1, 0);
      }

      continue;
    }

    if(message == "mobile_debug_give_equipment") {
      equipmentref = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          equipmentref = "brloot_offhand_frag";
          break;
        case 1:
          equipmentref = "brloot_offhand_atmine";
          break;
        case 2:
          equipmentref = "brloot_offhand_claymore";
          break;
        case 3:
          equipmentref = "brloot_offhand_molotov";
          break;
        case 4:
          equipmentref = "brloot_offhand_semtex";
          break;
        case 5:
          equipmentref = "brloot_offhand_thermite";
          break;
        case 6:
          equipmentref = "brloot_offhand_throwingknife";
          break;
        case 7:
          equipmentref = "brloot_offhand_throwingknife_fire";
          break;
        case 10:
          equipmentref = "brloot_health_adrenaline";
          break;
        case 11:
          equipmentref = "brloot_offhand_concussion";
          break;
        case 12:
          equipmentref = "brloot_offhand_decoy";
          break;
        case 13:
          equipmentref = "brloot_offhand_flash";
          break;
        case 14:
          equipmentref = "brloot_offhand_gas";
          break;
        case 15:
          equipmentref = "brloot_offhand_heartbeatsensor";
          break;
        case 16:
          equipmentref = "brloot_offhand_smoke";
          break;
        case 17:
          equipmentref = "brloot_offhand_snapshot";
          break;
        case 20:
          equipmentref = "brloot_armor_plate";
          break;
        case 21:
          equipmentref = "brloot_offhand_binoculars";
          break;
        case 22:
          equipmentref = "brloot_offhand_bunkerbuster";
          break;
        case 23:
          equipmentref = "brloot_offhand_shockstick";
          break;
        case 24:
          equipmentref = "brloot_offhand_c4";
          break;
        case 25:
          equipmentref = "brloot_offhand_butterfly_mine";
          break;
      }

      if(isDefined(equipmentref)) {
        br_forcegivecustompickupitem(self, equipmentref, 1);
      }

      continue;
    }

    if(message == "mobile_debug_give_br_items") {
      itemref = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          itemref = "brloot_equip_gasmask";
          break;
        case 1:
          itemref = "brloot_equip_gasmask_durable";
          break;
        case 2:
          itemref = "brloot_self_revive";
          break;
      }

      if(isDefined(itemref)) {
        br_forcegivecustompickupitem(self, itemref, 1);
      }
    }
  }
}

function function_c8a5593cbb13f17c(pickup, weaponobj) {
  if(isplayerads() || getdvarint(@ "hash_9fc90311ef111afd", 0) && player::isincombat()) {
    return 0;
  }

  var_fe4cd9dc9393409d = getdvarint(@ "hash_ef63562e5f3b14d0", 0);
  currenttime = gettime();
  var_c8a5593cbb13f17c = !isDefined(self.var_e7f6950ddc75ef66) || currenttime - self.var_e7f6950ddc75ef66 > var_fe4cd9dc9393409d;

  if(var_c8a5593cbb13f17c && self function_113c9c35caf6f029()) {
    var_c8a5593cbb13f17c = function_2b4b373533156a88(pickup, weaponobj);
  }

  if(var_c8a5593cbb13f17c && self function_2ebb84ec61fcfaaf()) {
    var_c8a5593cbb13f17c = !function_aaffa8afa2d9c195(weaponobj);
  }

  if(var_c8a5593cbb13f17c) {
    if(self function_c3a5505bc8f25a14()) {
      primaryweaponscount = self.primaryweapons.size;
      var_d05470192f5f4895 = 2 > primaryweaponscount;

      for(i = 0; !var_d05470192f5f4895 && i < self.primaryweapons.size; i++) {
        if(isnullweapon(self.primaryweapons[i]) || scripts\mp\weapons::isfistweapon(self.primaryweapons[i]) || !function_af4aefc234671c2f(i) && function_aaffa8afa2d9c195(self.primaryweapons[i])) {
          primaryweaponscount--;
          var_d05470192f5f4895 = 2 > primaryweaponscount;
        }
      }

      var_c8a5593cbb13f17c = var_d05470192f5f4895;
    } else if(self function_362521bcb3a1ba25()) {
      if(!isDefined(level.var_81369e82645391f0)) {
        function_f8b204e807cc62ed();
      }

      var_a6fb744f02d4ffb8 = level.var_81369e82645391f0[weaponclass(weaponobj.basename)];
      var_439466f5277ef2d9 = self function_337e400ead27b7bd(var_a6fb744f02d4ffb8);
      var_c8a5593cbb13f17c = 0;

      for(i = 0; i < self.primaryweapons.size; i++) {
        primaryweaponobj = self.primaryweapons[i];

        if(!isnullweapon(primaryweaponobj)) {
          if(scripts\mp\weapons::isfistweapon(primaryweaponobj)) {
            var_c8a5593cbb13f17c = 1;
            continue;
          }

          var_83106f206ae5a450 = level.var_81369e82645391f0[weaponclass(primaryweaponobj.basename)];

          if(var_a6fb744f02d4ffb8 == var_83106f206ae5a450) {
            var_c8a5593cbb13f17c = 0;
            break;
          }

          if(function_af4aefc234671c2f(i)) {
            continue;
          }

          weaponclasspriority = self function_337e400ead27b7bd(var_83106f206ae5a450);

          if(weaponclasspriority < var_439466f5277ef2d9) {
            var_c8a5593cbb13f17c = 1;
          }
        }
      }
    }
  }

  if(self function_5329138a845b7aa6()) {
    baseweaponname = weapon::getweaponrootname(weaponobj);
    var_862e2d88178bc2c8 = 0;

    for(i = 0; !var_862e2d88178bc2c8 && i < self.primaryweapons.size; i++) {
      var_e9094c47c8dbe268 = weapon::getweaponrootname(self.primaryweapons[i]);

      if(var_e9094c47c8dbe268 == baseweaponname) {
        playerweaponrarity = getweaponpickuprarity(self.primaryweapons[i]);
        var_167e430a395b12ba = level.br_pickups.br_itemrarity[pickup.scriptablename];
        var_862e2d88178bc2c8 = playerweaponrarity < var_167e430a395b12ba;
      }
    }

    var_c8a5593cbb13f17c = var_862e2d88178bc2c8;
  }

  return var_c8a5593cbb13f17c;
}

function function_2b4b373533156a88(pickup, weapon) {
  ammotype = br_weapons::br_ammo_type_for_weapon(weapon);

  if(isDefined(ammotype)) {
    var_f68fc94bc895254 = br_weapons::function_88d62a65ff69eac(self, ammotype);
    return (var_f68fc94bc895254 > 0 || pickup.count > 0 || pickup.countlefthand > 0);
  }

  return true;
}

function function_aaffa8afa2d9c195(weapon) {
  var_aaffa8afa2d9c195 = 0;

  if(isDefined(level.br_standard_loadout)) {
    if(!isDefined(level.var_ea84a0518343879c)) {
      function_e6cabc9f20dcbc23();
    }

    foreach(var_5c6fa156c22e63e3 in level.var_ea84a0518343879c) {
      var_aaffa8afa2d9c195 = issameweapon(weapon, var_5c6fa156c22e63e3);

      if(var_aaffa8afa2d9c195) {
        break;
      }
    }
  }

  if(!var_aaffa8afa2d9c195 && isDefined(self.gulag)) {
    if(!isDefined(level.var_f67907afe56c4f82)) {
      function_23a8498a6613de14();
    }

    var_aaffa8afa2d9c195 = function_2166628459c78e7a(weapon);
  }

  return var_aaffa8afa2d9c195;
}

function getweaponpickuprarity(weaponobj) {
  weaponrarity = 0;
  weaponfullname = getcompleteweaponname(weaponobj);

  if(isDefined(level.br_pickups.br_weapontoscriptable[weaponfullname])) {
    var_c9c301a888170672 = level.br_pickups.br_weapontoscriptable[weaponfullname];
    weaponrarity = level.br_pickups.br_itemrarity[var_c9c301a888170672];
  } else if(br_weapons::isvalidcustomweapon(weaponobj)) {
    weaponrarity = 10;
  }

  return weaponrarity;
}

function function_abd2865600352fcd() {
  self.weaponslotblocked = [];

  for(i = 0; i < 2; i++) {
    self.weaponslotblocked[i] = 0;
  }
}

function function_af4aefc234671c2f(slotindex) {
  slotblocked = 0;

  if(getdvarint(@ "hash_218b826f84233424", 0)) {
    if(!isDefined(self.weaponslotblocked)) {
      function_abd2865600352fcd();
    }

    slotblocked = slotindex < 2 && self.weaponslotblocked[slotindex];
  }

  return slotblocked;
}

function function_5ef33bffaeda4fa9(weaponobj, blocked) {
  if(!isDefined(self.weaponslotblocked)) {
    function_abd2865600352fcd();
  }

  weaponcount = min(2, self.primaryweapons.size);

  for(i = 0; i < weaponcount; i++) {
    if(issameweapon(self.primaryweapons[i], weaponobj)) {
      self.weaponslotblocked[i] = blocked;
      break;
    }
  }
}

function function_e98a5a4e0e001ac3(player, scriptablename, var_f9beeb3ed076a7a1) {
  platelevel = br_public::function_692c3df266580df6(scriptablename);

  if(istrue(level.var_595938569c3fe806)) {
    player setplayerdata(level.var_5d69837cf4db0407, "dmzPlateCarrierLevel", platelevel);
  }

  if(istrue(level.var_7f3aafcf56c9ce14)) {
    function_6523c0535fdb1f1f(player, scriptablename);
    var_f24fbd36a9751174 = player function_f792ec0c5b3b6d45(scriptablename);

    if(isDefined(var_f24fbd36a9751174) && var_f24fbd36a9751174 > 0) {
      dropstruct = function_7b9f3966a7a42003();
      player scripts\mp\gametypes\br_pickups::dropbrequipment(dropstruct, 0, 1, "equip_armorplate", var_f24fbd36a9751174);
    }

    player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(0);
  }

  if(isDefined(scriptablename)) {
    namespace_b16531563568eaba::function_bd01c77ab46f790(player, loot::function_fae5e1d3de32d3f7(scriptablename));
  }

  player.var_4045f099f3da4bd = scriptablename;

  if(!istrue(var_f9beeb3ed076a7a1)) {
    player.platecarrierlevel = platelevel;
    player.maxarmorhealth = player scripts\cp_mp\armor::function_829e435158d419cf() * 50;
    player notify("try_armor_cancel", "plate_carrier");

    if(!getdvarint(@ "hash_43b4bf9a8ba6c500", 1)) {
      armor::setarmorhealth(player.maxarmorhealth);
    } else {
      armor::setarmorhealth(player.armorhealth);
      var_364d691b501cd27f = player armor::function_20b8437058079297();

      if(getdvarint(@ "hash_e1ef460ef24e76e6", 0) && var_364d691b501cd27f < player scripts\cp_mp\armor::function_829e435158d419cf() && !istrue(player.var_c7fd13c53dbdc4f6)) {
        player armor::function_9c6e9a6643b6c9a6(player scripts\cp_mp\armor::function_829e435158d419cf() - var_364d691b501cd27f);
      }
    }
  }

  return platelevel;
}

function function_6523c0535fdb1f1f(player, scriptablename) {
  newperkname = function_77702c2321292aa3(scriptablename);
  currentperkname = function_77702c2321292aa3(player.var_4045f099f3da4bd);

  if(isDefined(currentperkname) && perk::_hasperk(currentperkname)) {
    player perk::removeperk(currentperkname);
  }

  if(isDefined(newperkname)) {
    player perk::giveperk(newperkname);
  }
}

function function_77702c2321292aa3(scriptablename) {
  if(!isDefined(scriptablename)) {
    return undefined;
  }

  perkname = undefined;

  if(issubstr(scriptablename, "comms")) {
    perkname = "specialty_pc_comms";
  } else if(issubstr(scriptablename, "medic")) {
    perkname = "specialty_pc_medic";
  } else if(issubstr(scriptablename, "stealth")) {
    perkname = "specialty_pc_stealth";
  } else if(issubstr(scriptablename, "tempered")) {
    perkname = "specialty_pc_tempered";
  } else if(issubstr(scriptablename, "high_capacity")) {
    perkname = "specialty_pc_high_capacity";
  } else if(issubstr(scriptablename, "cqc")) {
    perkname = "specialty_pc_close_quarter";
  }

  return perkname;
}

function function_a0877dfcb342653a(player) {
  if(istrue(level.var_595938569c3fe806)) {
    player setplayerdata(level.var_5d69837cf4db0407, "dmzPlateCarrierLevel", 1);
  }
}

function function_f792ec0c5b3b6d45(scriptablename) {
  var_364d691b501cd27f = 0;

  foreach(weapon in self.equippedweapons) {
    basename = scripts\cp_mp\weapon::getweaponrootname(weapon.basename);

    if(basename == "armorplate") {
      var_364d691b501cd27f = self getweaponammoclip(weapon);
    }
  }

  var_a81adeb0e1f89320 = function_70edce5f0482fde7();

  if(isDefined(scriptablename)) {
    if(scriptablename == "brloot_plate_carrier_high_capacity") {
      var_a81adeb0e1f89320 = 8;
    }
  }

  var_f24fbd36a9751174 = undefined;

  if(var_364d691b501cd27f > var_a81adeb0e1f89320) {
    var_f24fbd36a9751174 = var_364d691b501cd27f - var_a81adeb0e1f89320;
  }

  return var_f24fbd36a9751174;
}

function function_89383ba5ee5f2b5f(var_14004b68ddacb781, var_46e6d47e89ce730c) {
  camo = var_46e6d47e89ce730c;

  if(isDefined(var_14004b68ddacb781) && getDvar(@ "hash_3a44953d213dd7dd") != "") {
    camo = function_497b1f448007400e(var_14004b68ddacb781);
  }

  return camo;
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

function function_990be1aa4ad3c9d4() {
  var_4ae930e26ecee422 = scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587();
  var_7fbb956846df343e = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(var_7fbb956846df343e && !var_4ae930e26ecee422) {
    var_7483fc2cde6bc9f8 = self.platecarrierlevel == 2;
    var_2780dc47382969c4 = self.var_4045f099f3da4bd == "brloot_plate_carrier_3";

    if(var_7483fc2cde6bc9f8 || var_2780dc47382969c4) {
      return false;
    }

    return true;
  }

  if(isDefined(self.platecarrierlevel) && getdvarint(@ "hash_62882304cc93ba77", 0) == 1 && self.platecarrierlevel == 2 || self.platecarrierlevel == 3 && getdvarint(@ "scr_br_drop_three_carrier", 1) == 1 && !var_4ae930e26ecee422) {
    return true;
  }

  return false;
}

function function_9035374e6d5f69db() {
  if(!isDefined(self.var_4045f099f3da4bd)) {
    return true;
  }

  if(!isDefined(self.platecarrierlevel) || self.platecarrierlevel <= 1) {
    return true;
  }

  return self.var_4045f099f3da4bd == "brloot_plate_carrier_2" || self.var_4045f099f3da4bd == "brloot_plate_carrier_3";
}

function function_82c2dc3d57d67f52() {
  return getdvarint(@ "hash_8d79947a6199a378", 0);
}

function function_e8fc4167d33ed55d(perk) {
  giveperk(perk);
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(perk);
  assert(isDefined(lootid), "<dev string:xa71>" + perk + "<dev string:xa83>");

  if(!isDefined(lootid)) {
    return;
  }

  view_origin = self getvieworigin();
  scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, 0);
}

function function_831b0b5a495499ef(perk) {
  self notify("watch_lifetime_" + perk);
  self endon("watch_lifetime_" + perk);
  self endon("death_or_disconnect");

  while(true) {
    self waittill("giveLoadout");
    perk::giveperk(perk);
  }
}

function function_d53595847895c537() {
  while(true) {
    wait 60;
    function_ff5569044925c628();
  }
}

# /