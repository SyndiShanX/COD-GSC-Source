/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armor.gsc
***********************************************/

#using scripts\cp_mp\armor;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\equipment\armor_plate;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\perk;
#namespace br_armor;

function main() {
  setdvarifuninitialized(@ "hash_6f491f10c40cf0a9", -1);

  level.onhelmetsniped = &onhelmetsniped;
}

function initarmor() {
  self.br_armorhealth = 0;
  self.br_maxarmorhealth = function_f5fad893f2305590();
  self setclientomnvar("ui_armor_percent", 0);
  scripts\mp\equipment\armor_plate::br_armor_plate_amount_equipped_set(0);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&brdpadcallback);
}

function function_f5fad893f2305590() {
  if(istrue(level.var_75c3b6e138fd717c)) {
    return 200;
  }

  return 150;
}

function brdpadcallback(notification, slotindex) {
  if(isDefined(notification) && notification == "try_use_heal_slot") {
    var_57d8f859dc2dd35d = slotindex;
  }
}

function getoldarmorent(var_b66c691c7efb8a01) {
  pickup = spawnStruct();
  pickup.count = 1;
  pickup.maxcount = 1;
  pickup.stackable = 1;

  if(scripts\mp\gametypes\br_public::ishelmet(var_b66c691c7efb8a01.scriptablename)) {} else if(scripts\mp\gametypes\br_pickups::isgasmask(var_b66c691c7efb8a01.scriptablename)) {
    pickup.gasmaskhealth = self.gasmaskhealth;
  } else {
    pickup.armorhealth = self.br_armorhealth;
  }

  return pickup;
}

function helmetitemtypeforlevel(helmetlevel) {
  switch (helmetlevel) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

function givestartingarmor(var_25d647af59249079) {
  if(isDefined(var_25d647af59249079)) {
    var_9a5097fe8a19dcfd = var_25d647af59249079;
  } else {
    var_9a5097fe8a19dcfd = 100;
  }

  if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
    var_9a5097fe8a19dcfd = function_f5fad893f2305590();
  }

  var_4fb4b206a997692d = getdvarint(@ "hash_6f491f10c40cf0a9", -1);

  if(var_4fb4b206a997692d >= 0) {
    var_9a5097fe8a19dcfd = var_4fb4b206a997692d;
  }

  givearmorvalue(var_9a5097fe8a19dcfd);
}

function givearmorvalue(value) {
  if(!isDefined(value) || value < 0) {
    return;
  }

  self.br_armorhealth = value;
  self.br_maxarmorhealth = function_f5fad893f2305590();
  armorpercent = self.br_armorhealth / self.br_maxarmorhealth;
  self setclientomnvar("ui_armor_percent", armorpercent);
  scripts\mp\equipment\armor_plate::br_armor_plate_amount_equipped_set(self.br_armorhealth);
}

function takehelmet(helmetitem, helmetlevel) {
  self.br_helmetlevel = helmetlevel;
  row = level.br_pickups.br_itemrow[helmetitem.scriptablename];

  if(self.br_helmetlevel == 3) {
    scripts\mp\utility\perk::giveperk("specialty_stun_resistance");
  }
}

function breakarmor() {
  scripts\cp_mp\armor::damagearmor(self.br_armorhealth, 1);
}

function isarmorbetterthanequipped(armorname) {
  helmetlevel = 0;

  if(armorname == "equip_helmet_1") {
    helmetlevel = 1;
  } else if(armorname == "equip_helmet_2") {
    helmetlevel = 2;
  } else if(armorname == "equip_helmet_3") {
    helmetlevel = 3;
  }

  if(helmetlevel > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < helmetlevel) {
      return true;
    }
  }

  return false;
}

function popoffhelmet(impactdir, playerangles, playerorigin) {
  level endon("game_ended");
  helmettag = self gettagorigin("j_helmet");

  if(!isDefined(helmettag)) {
    helmettag = playerorigin + (0, 0, 80);
  }

  helmet = spawn("script_model", self gettagorigin("j_helmet"));
  helmet setModel("loot_helmet");
  helmet.angles = playerangles;
  up = anglestoup(playerangles);
  forward = impactdir;
  vel = vectorNormalize(forward + up) * 2500;
  helmet physicslaunchserver(helmet.origin, vel);
  helmetitem = "brloot_armor_helmet_" + self.br_helmetlevel;
  var_29511a1c049e1067 = 15;
  var_f246e6dc812fbcfe = 0.1;
  var_29511a1c049e1067 *= 1 / var_f246e6dc812fbcfe;
  previousorigin = helmet.origin;

  for(i = 0; i < var_29511a1c049e1067; i++) {
    wait var_f246e6dc812fbcfe;
    compareorigin = previousorigin - helmet.origin;

    if(compareorigin[0] < 2 && compareorigin[1] < 2 && compareorigin[2] < 2 && compareorigin[0] > -2 && compareorigin[1] > -2 && compareorigin[2] > -2) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(helmet.origin, helmet.angles);
      helmet delete();
      pickupent = scripts\mp\gametypes\br_pickups::spawnpickup(helmetitem, dropinfo);
      pickupent.count = 1;
      return;
    }

    previousorigin = helmet.origin;
  }

  helmet delete();
}

function onhelmetsniped(victim, impactdir) {
  if(isDefined(victim)) {
    victim thread popoffhelmet(impactdir, victim.angles, victim.origin);
  }
}

function function_bcb1d5fb674fa3a0() {
  if(isDefined(self.armorhealth)) {
    armorpercent = self.armorhealth / function_f5fad893f2305590();
    scripts\mp\codcasterclientmatchdata::function_f8b808cd6473e6cc(18, armorpercent);
  }
}