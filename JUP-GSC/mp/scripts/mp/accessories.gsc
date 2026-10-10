/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\accessories.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#namespace accessories;

function init() {}

function getaccessoryweaponbyindex(index) {
  return "none";
}

function getaccessorydatabyindex(index) {
  return "none";
}

function getaccessorylogicbyindex(index) {
  return "none";
}

function giveplayeraccessory(accessorydata, accessoryweapon, accessorylogic) {
  assertex(accessoryweapon != "<dev string:x1c>", "<dev string:x24>");
  clearplayeraccessory();
  specificweapon = getoperatorspecificaccessoryweapon(accessoryweapon);

  if(!isDefined(specificweapon)) {
    return;
  }

  self.accessorydata = accessorydata;
  self.accessorylogic = accessorylogic;
  hidewm = shouldoperatorhideaccessoryworldmodel();

  if(isDefined(accessorylogic)) {
    switch (accessorylogic) {
      case #"hash_2c7f2b69647205f7":
        break;
      case #"hash_6f1f5949a7b7be07":
        initthermometerwatch();
        break;
      case #"hash_dd93145493d0c039":
        scripts\cp_mp\gestures::startholowatchvfx();
        break;
      default:
        break;
    }
  }
}

function shouldoperatorhideaccessoryworldmodel() {
  customization = scripts\mp\teams::getcustomization();
  operatorskin = customization["body"];
  return scripts\cp_mp\operator::function_9745c4739bb8fdc0(operatorskin);
}

function getoperatorspecificaccessoryweapon(accessoryweapon) {
  return accessoryweapon;
}

function testaccessoryvfx() {
  scripts\cp_mp\gestures::startbluntwatchvfx();
}

function clearplayeraccessory() {
  self clearaccessory();
}

function initthermometerwatch() {
  if(!isDefined(self.thermometerwatch)) {
    self.thermometerwatch = 1;
    temp = getmapbaselinetempurature();
    self setclientomnvar("ui_pet_watch_state", temp);
  }
}

function getmapbaselinetempurature() {
  switch (level.mapname) {
    case #"hash_4843ffb36223231f":
      return 74;
    case #"hash_a8b272dba33a4aed":
      return 81;
    case #"hash_ff009e5fab42b778":
      return 80;
    case #"hash_66ce5cdcd3b547f3":
      return 40;
    case #"hash_62c07791a2eda185":
      return 36;
    case #"hash_fcab5810ee4c6dc2":
      return 95;
    case #"hash_a3aa6afd955c54d":
      return 49;
    case #"hash_8cd7282b2d63b917":
      return 30;
    case #"hash_1ab428ea9c0ee9e5":
      return 35;
    case #"hash_d8bbcfc499e70e6f":
      return 55;
    case #"hash_f09747c9feb47eb1":
      return 65;
    case #"hash_688334408379d4fb":
      return 50;
    case #"hash_d32ec8c7ac2ec13b":
      return 42;
    case #"hash_d83171ba75f8b8fe":
      return 92;
    case #"hash_be52fbd3b8746bc":
      return 82;
    case #"hash_dd0468a72c625fe3":
      return 100;
    case #"hash_4e0fb54d08118adb":
      return 80;
    case #"hash_51f2bb9a988ac56a":
      return 54;
    case #"hash_2497489a808b61ea":
      return 64;
    case #"hash_a8186a9f8bd241d6":
      return 68;
    case #"hash_9ac87f2d76f8d0c4":
      return 68;
    case #"hash_924020a8aae08bb":
      return 72;
    case #"hash_d369b0ca801c4b63":
      return 88;
    case #"hash_5b6f1fc9b0507707":
      return 90;
    case #"hash_9de262a7132ec180":
      return 72;
    case #"hash_70853c6968d5f645":
      return 79;
    case #"hash_4f9adc0aeff5dff":
      return 65;
    case #"hash_89cd8aae588a4328":
      return 38;
    case #"hash_c985d28b0fa19f27":
      return 68;
    case #"hash_e844346f82c5819d":
      return 96;
    case #"hash_7a28db3c5928c489":
      return 57;
    case #"hash_32eaa112f8caa7e4":
      return 60;
    case #"hash_50de71be6e7469ff":
      return 78;
    case #"hash_663342870491b482":
      return 12;
    case #"hash_ad24534a70732639":
      return 79;
    case #"hash_143ad8976cca3ba":
      return 80;
    case #"hash_da5afa8cc78bb147":
      return 55;
    case #"hash_d39c51733bbe5712":
      return 81;
    default:
      return 68;
  }
}