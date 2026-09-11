/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\train_utility.gsc
***************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("military_ammo_restock", &brtruck_initpostmain);
  level.ammorestocklocs = [];
  var0 = "ammo_restock_location";

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    var0 = "ammo_restock_location_ch3";
  }

  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var4 = getEntArray(var3.target, "targetname");

    if(!istrue(level.useammorestocklocs) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var3.script_noteworthy) && var3.script_noteworthy != level.localeid) {
      foreach(var6 in var4) {
        if(var6.classname == "script_model") {
          var6 delete();
          continue;
        }

        var6 delete();
      }

      var3 delete();
      continue;
    }

    var3.timeplayerused = [];
    level.ammorestocklocs[level.ammorestocklocs.size] = var3;
  }

  if(isDefined(level.localeid) && level.localeid == "locale_6") {
    brtruck_initexternalfeatures();
    return;
  }
}

function brtruck_initpostmain(var0, var1, var2, var3, var4) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(debug_start_silo_elevator(var3)) {
      if(scripts\mp\flags::gameflag("prematch_done") && getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war") {
        var0 disablescriptableplayeruse(var3);
        return;
      }

      thread brtruck_initfeatures(var0, var3, 5);
      return;
    }

    thread brtruck_initfeatures(var0, var3, 0.1);
    return;
  }

  if(ammorestock_playeruse(var3, var0.entity)) {
    thread brtruck_initfeatures(var0, var3, 5);
    return;
  }

  thread brtruck_initfeatures(var0, var3, 0.1);
}

function brtruck_initfeatures(var0, var1, var2) {
  var1 endon("disconnect");
  var0 disablescriptableplayeruse(var1);
  wait var2;
  var0 enablescriptableplayeruse(var1);
}

function ammorestock_playeruse(var0, var1) {
  var0 endon("death_or_disconnect");
  var2 = var0.primaryweapons;
  var3 = [];

  foreach(var5 in var2) {
    if(!scripts\mp\utility\weapon::ismeleeonly(var5) && !scripts\mp\utility\weapon::issuperweapon(var5) && !scripts\mp\utility\weapon::iskillstreakweapon(var5) && !scripts\mp\utility\weapon::isgamemodeweapon(var5) && !scripts\mp\utility\weapon::issinglehitweapon(var5)) {
      var3 = var5;
    }
  }

  var2 = var3;
  var7 = 0;

  foreach(var9 in var2) {
    if(weaponmaxammo(var9) == var0 getweaponammostock(var9)) {
      var7++;
    }
  }

  if(var7 == var2.size) {
    var0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  var11 = [];

  foreach(var13, var5 in var2) {
    var11 = var0 getammotype(var5);
  }

  var14 = 0;

  foreach(var13, var16 in var11) {
    if(isDefined(var11[var13 + 1])) {
      if(var11[var13] == var11[var13 + 1]) {
        var14 = 1;
        continue;
      }

      var14 = 0;
    }
  }

  var17 = 0;

  if(var14) {
    foreach(var5 in var2) {
      var17 += weaponmaxammo(var5);
    }
  }

  foreach(var9 in var2) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var9, 2);
      continue;
    }

    var21 = scripts\mp\weapons::getammooverride(var9);

    if(scripts\mp\utility\weapon::turnexfiltoside(var9)) {
      var22 = var0 getweaponammostock(var9);
      var23 = int(min(weaponmaxammo(var9), var22 + var21 * 2));
      var0 setweaponammostock(var9, var23);

      if(weaponclipsize(var9) != var0 getweaponammoclip(var9)) {
        var0 setweaponammoclip(var9, 0, "left");
        var0 setweaponammoclip(var9, 0, "right");
      }

      continue;
    }

    var24 = var0 getweaponammoclip(var9);
    var22 = var0 getweaponammostock(var9);

    if(scripts\mp\utility\weapon::issinglehitweapon(var9)) {
      var23 = int(min(weaponmaxammo(var9), var22 + var21 * 1));
    } else if(var14) {
      var23 = int(min(var17, var22 + var21 * 2));
    } else {
      var23 = int(min(weaponmaxammo(var9), var22 + var21 * 2));
    }

    if(var9.basename == "iw8_lm_dblmg_mp") {
      var0 setweaponammoclip(var9, var24 + var21);
    } else {
      var0 setweaponammostock(var9, var23);
    }
  }

  var0 scripts\mp\damagefeedback::hudicontype("br_ammo");
  var0 playlocalsound("iw8_support_box_use");
  return true;
}

function debug_start_silo_elevator(var0) {
  var1 = 0;
  var2 = [];
  var3 = var0 getweaponslistprimaries();

  if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var3) || var3.size == 0) {
      var4 = var0 getcurrentweapon();
      var5 = var0 getcurrentweaponclipammo();
      var6 = weaponclipsize(var4);

      if(var5 < var6) {
        var0 setweaponammoclip(var4, var6);
        var0 scripts\mp\damagefeedback::hudicontype("br_ammo");
        var0 playlocalsound("iw8_support_box_use");
        return true;
      }
    }
  }

  foreach(var8 in var3) {
    var9 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var8);

    if(var8.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var8.underbarrel) == "ubshtgn") {
      var10 = weaponclipsize(var8);
      var11 = int(var10);
      var0 setweaponammoclip(var8, var11);
      continue;
    } else if(scripts\mp\utility\weapon::update_health_on_spawn(var8)) {
      var0 setweaponammoclip(var8, var8.clipsize);
      continue;
    } else if(!isDefined(var9)) {
      continue;
    }

    var12 = 1;

    if(var2.size >= 1) {
      foreach(var14 in var2) {
        if(var9 == var14) {
          var12 = 0;
        }
      }
    }

    if(var12) {
      var2 = var9;
      var0 scripts\mp\gametypes\br_weapons::delay_delete_alerted_icon(var8, 2);
      var1 = 1;
    }
  }

  if(!var1) {
    var0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return false;
  }

  var0 scripts\mp\damagefeedback::hudicontype("br_ammo");
  var0 playlocalsound("iw8_support_box_use");
  return true;
}

function br_ammorestock_playerupdatestructures() {
  foreach(var1 in level.ammorestocklocs) {
    var2 = getEntArray(var1.target, "targetname");

    foreach(var4 in var2) {
      if(var4.classname == "script_model") {
        if(istrue(self.iszombie)) {
          var4 disablescriptableplayeruse(self);
          continue;
        }

        var4 enablescriptableplayeruse(self);
      }
    }
  }
}

function brtruck_initexternalfeatures() {
  var0 = [];
  GscBinSkip0(0x2e, 0, (15946, -71, -469));
}