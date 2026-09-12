/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\train_utility.gsc
***************************************************/

function init() {
  scripts\engine\scriptable::ref_12F5B("military_ammo_restock", &brtruck_initpostmain);
  level.ammorestocklocs = [];
  var_0 = "ammo_restock_location";

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    var_0 = "ammo_restock_location_ch3";
  }

  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "targetname");

    if(!istrue(level.useammorestocklocs) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_3.script_noteworthy) && var_3.script_noteworthy != level.localeid) {
      foreach(var_6 in var_4) {
        if(var_6.classname == "script_model") {
          var_6 delete();
          continue;
        }

        var_6 delete();
      }

      var_3 delete();
      continue;
    }

    var_3.timeplayerused = [];
    level.ammorestocklocs[level.ammorestocklocs.size] = var_3;
  }

  if(isDefined(level.localeid) && level.localeid == "locale_6") {
    brtruck_initexternalfeatures();
    return;
  }
}

function brtruck_initpostmain(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(debug_start_silo_elevator(var_3)) {
      if(scripts\mp\flags::gameflag("prematch_done") && getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war") {
        var_0 disablescriptableplayeruse(var_3);
        return;
      }

      thread brtruck_initfeatures(var_0, var_3, 5);
      return;
    }

    thread brtruck_initfeatures(var_0, var_3, 0.1);
    return;
  }

  if(ammorestock_playeruse(var_3, var_0.entity)) {
    thread brtruck_initfeatures(var_0, var_3, 5);
    return;
  }

  thread brtruck_initfeatures(var_0, var_3, 0.1);
}

function brtruck_initfeatures(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_0 disablescriptableplayeruse(var_1);
  wait var_2;
  var_0 enablescriptableplayeruse(var_1);
}

function ammorestock_playeruse(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_2 = var_0.primaryweapons;
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!scripts\mp\utility\weapon::ismeleeonly(var_5) && !scripts\mp\utility\weapon::issuperweapon(var_5) && !scripts\mp\utility\weapon::iskillstreakweapon(var_5) && !scripts\mp\utility\weapon::isgamemodeweapon(var_5) && !scripts\mp\utility\weapon::issinglehitweapon(var_5)) {
      var_3 = var_5;
    }
  }

  var_2 = var_3;
  var_7 = 0;

  foreach(var_9 in var_2) {
    if(weaponmaxammo(var_9) == var_0 getweaponammostock(var_9)) {
      var_7++;
    }
  }

  if(var_7 == var_2.size) {
    var_0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  var_11 = [];

  foreach(var_13, var_5 in var_2) {
    var_11 = var_0 getammotype(var_5);
  }

  var_14 = 0;

  foreach(var_13, var_16 in var_11) {
    if(isDefined(var_11[var_13 + 1])) {
      if(var_11[var_13] == var_11[var_13 + 1]) {
        var_14 = 1;
        continue;
      }

      var_14 = 0;
    }
  }

  var_17 = 0;

  if(var_14) {
    foreach(var_5 in var_2) {
      var_17 += weaponmaxammo(var_5);
    }
  }

  foreach(var_9 in var_2) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var_9, 2);
      continue;
    }

    var_21 = scripts\mp\weapons::getammooverride(var_9);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_9)) {
      var_22 = var_0 getweaponammostock(var_9);
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 2));
      var_0 setweaponammostock(var_9, var_23);

      if(weaponclipsize(var_9) != var_0 getweaponammoclip(var_9)) {
        var_0 setweaponammoclip(var_9, 0, "left");
        var_0 setweaponammoclip(var_9, 0, "right");
      }

      continue;
    }

    var_24 = var_0 getweaponammoclip(var_9);
    var_22 = var_0 getweaponammostock(var_9);

    if(scripts\mp\utility\weapon::issinglehitweapon(var_9)) {
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 1));
    } else if(var_14) {
      var_23 = int(min(var_17, var_22 + var_21 * 2));
    } else {
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 2));
    }

    if(var_9.basename == "iw8_lm_dblmg_mp") {
      var_0 setweaponammoclip(var_9, var_24 + var_21);
    } else {
      var_0 setweaponammostock(var_9, var_23);
    }
  }

  var_0 scripts\mp\damagefeedback::hudicontype("br_ammo");
  var_0 playlocalsound("iw8_support_box_use");
  return true;
}

function debug_start_silo_elevator(var_0) {
  var_1 = 0;
  var_2 = [];
  var_3 = var_0 getweaponslistprimaries();

  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var_3) || var_3.size == 0) {
      var_4 = var_0 getcurrentweapon();
      var_5 = var_0 getcurrentweaponclipammo();
      var_6 = weaponclipsize(var_4);

      if(var_5 < var_6) {
        var_0 setweaponammoclip(var_4, var_6);
        var_0 scripts\mp\damagefeedback::hudicontype("br_ammo");
        var_0 playlocalsound("iw8_support_box_use");
        return true;
      }
    }
  }

  foreach(var_8 in var_3) {
    var_9 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_8);

    if(var_8.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_8.underbarrel) == "ubshtgn") {
      var_10 = weaponclipsize(var_8);
      var_11 = int(var_10);
      var_0 setweaponammoclip(var_8, var_11);
      continue;
    } else if(scripts\mp\utility\weapon::update_health_on_spawn(var_8)) {
      var_0 setweaponammoclip(var_8, var_8.clipsize);
      continue;
    } else if(!isDefined(var_9)) {
      continue;
    }

    var_12 = 1;

    if(var_2.size >= 1) {
      foreach(var_14 in var_2) {
        if(var_9 == var_14) {
          var_12 = 0;
        }
      }
    }

    if(var_12) {
      var_2 = var_9;
      var_0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var_8, 2);
      var_1 = 1;
    }
  }

  if(!var_1) {
    var_0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  var_0 scripts\mp\damagefeedback::hudicontype("br_ammo");
  var_0 playlocalsound("iw8_support_box_use");
  return true;
}

function br_ammorestock_playerupdatestructures() {
  foreach(var_1 in level.ammorestocklocs) {
    var_2 = getEntArray(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      if(var_4.classname == "script_model") {
        if(istrue(self.iszombie)) {
          var_4 disablescriptableplayeruse(self);
          continue;
        }

        var_4 enablescriptableplayeruse(self);
      }
    }
  }
}

function brtruck_initexternalfeatures() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, (15946, -71, -469));
}