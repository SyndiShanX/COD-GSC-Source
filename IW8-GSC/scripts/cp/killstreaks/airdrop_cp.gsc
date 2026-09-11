/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\airdrop_cp.gsc
*************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleInit", &airdrop_airdropmultipleinit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerScoreInfo", &airdrop_registerscoreinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerActionSet", &airdrop_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "updateUIProgress", &airdrop_updateuiprogress);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "allowActionSet", &airdrop_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "unresolvedCollisionNearestNode", &airdrop_unresolvedcollisionnearestnode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "showErrorMessage", &airdrop_showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "awardKillstreak", &airdrop_awardkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "showKillstreakSplash", &airdrop_showkillstreaksplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "getTargetMarker", &airdrop_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "airdropMultipleDropCrates", &airdrop_airdropmultipledropcrates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerCrateForCleanup", &airdrop_registercrateforcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeWeaponFromCrate", &airdrop_makeweaponfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemFromCrate", &airdrop_makeitemfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "outlineDisable", &airdrop_outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "br_forceGiveWeapon", &airdrop_br_forcegiveweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "captureLootCacheCallback", &airdrop_capturelootcachecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "isKillstreakBlockedForBots", &airdrop_iskillstreakblockedforbots);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "botIsKillstreakSupported", &airdrop_botiskillstreaksupported);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "getGameModeSpecificCrateData", &airdrop_getgamemodespecificcratedata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "specialCase_canUseCrate", &br_challenges);
  level.crate_random_weapons = ["brloot_weapon_ak47", "brloot_weapon_as50", "brloot_weapon_aug", "brloot_weapon_dp12", "brloot_weapon_famas", "brloot_weapon_g21", "brloot_weapon_hk121", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_m4", "brloot_weapon_m870", "brloot_weapon_marlin", "brloot_weapon_mcx", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90", "brloot_weapon_pkm", "brloot_weapon_python", "brloot_weapon_p320"];
}

function initcpcratedata() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("cp");
  var0.capturestring = &"MP/BR_CRATE";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -10000;
  var0.timeout = undefined;
  var0.activatecallback = &cpcrateactivatecallback;
  var0.capturecallback = &cpcratecapturecallback;
}

function getcpcratedatabytype(var0) {
  var1 = spawnStruct();
  var1.type = var0;
  return var1;
}

function cpcrateactivatecallback(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function cpcratecapturecallback(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "makeItemsFromCrate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "makeItemsFromCrate")]](var0);
  }

  var0[[level.custom_giveloadout]](0);
}

function initcparmsraceemptycrate() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("cp_armsrace_crate");
  var0.capturestring = "";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -10000;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.hasnointeraction = 1;
  var0.activatecallback = undefined;
  var0.capturecallback = undefined;
  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 0;
}

function teleport_reference_silo() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("cp_resources_crate");
  var0.capturestring = &"MP/BR_CRATE";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = "hud_icon_head_killstreak_carepackage";
  var0.usepriority = -10000;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.activatecallback = &cploadoutcrateactivatecallback;
  var0.capturecallback = &indanger;
  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 1;
}

function indanger(var0) {
  if(istrue(var0.inlaststand)) {
    return;
  }

  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  self.playersused[self.playersused.size] = var0;
  var0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();
  scripts\cp\cp_armor::givearmor(var0, 100, 1);
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(weapontype(var3) == "projectile") {
      if(var3.basename == "iw8_la_mike32_mp") {
        if(var0.gl_proj_override == "thermite") {
          continue;
        }
      }

      var4 = weaponclipsize(var3);
      var0 givemaxammo(var3);
    }
  }

  foreach(var7 in var0.powers) {
    if(var7.charges < var7.maxcharges) {
      var8 = 0;
    }
  }

  thread scripts\cp\cp_grenade_crate::refill_grenades(var0);
  var0 playlocalsound("weap_ammo_pickup");
  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var11 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var11, self);
        }
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    return;
  }
}

function initcploadoutcratedata() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("cp_loadout");
  var0.capturestring = &"COOP_GAME_PLAY/CHANGE_LOADOUT";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -10000;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.activatecallback = &cploadoutcrateactivatecallback;
  var0.capturecallback = &cploadoutcratecapturecallback;
  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 1;
}

function toggle_ambient_vehicles_on_module() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("operation_crates");
  var0.capturestring = &"MP/ESC_CACHE_USE_HINT";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = "hud_icon_head_killstreak_carepackage";
  var0.usepriority = -10000;
  var0.timeout = 90;
  var0.friendlyuseonly = 1;
  var0.activatecallback = &infectbonusscore;
  var0.capturecallback = &infectbonussuperonspawn;
  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 0;
  var0.setplayerbeingrevivedextrainfo = 55;
  var0.heliheightoffset = 12000;
}

function teleport_room_doors() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("cp_rooftop_crate");
  var0.capturestring = &"CP_DWN_TWN_OBJECTIVES/TAKE_ROOFTOP_CRATE";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = "hud_icon_head_killstreak_carepackage";
  var0.usepriority = -10000;
  var0.timeout = 99999;
  var0.friendlyuseonly = 1;
  var0.activatecallback = &cploadoutcrateactivatecallback;
  var0.capturecallback = &infectbonussuperontacinsert;
  var0.destroyoncapture = 1;
  var0.onecaptureperplayer = 0;
}

function infectbonusscore(var0) {
  thread scripts\cp_mp\killstreaks\airdrop::infilweaponraise();

  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
    return;
  }
}

function infectbonussuperontacinsert(var0) {
  [[level.ref_12d8c]](var0);
}

function infectbonussuperonspawn(var0) {
  if(istrue(var0.inlaststand)) {
    return;
  }

  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  self.playersused[self.playersused.size] = var0;

  if(isDefined(self.intro_techos_deposit_backseats)) {
    self thread[[self.intro_techos_deposit_backseats]](var0);
    return;
  }

  if(!istrue(level.little_bird_mg_cp_onexitvehicle)) {
    var0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();
  }

  scripts\cp\cp_armor::givearmor(var0, 100, 1);
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(weapontype(var3) == "projectile") {
      if(var3.basename == "iw8_la_mike32_mp") {
        if(var0.gl_proj_override == "thermite") {
          continue;
        }
      }

      var4 = weaponclipsize(var3);
      var0 givemaxammo(var3);
    }
  }

  foreach(var7 in var0.powers) {
    if(var7.charges < var7.maxcharges) {
      var8 = 0;
    }
  }

  thread scripts\cp\cp_grenade_crate::refill_grenades(var0);
  var0 playlocalsound("weap_ammo_pickup");
  var10 = ["precision_airstrike", "juggernaut", "cruise_missile", "cluster_strike"];

  if(isDefined(self.ref_129f9)) {
    var10 = self.ref_129f9;
  }

  var11 = scripts\engine\utility::random(var10);
  var12 = undefined;
  var13 = var0 getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var13 < 4) {
    var12 = var13;
  } else {
    var12 = var0.dpad_selection_index - 1;
  }

  var14 = scripts\cp\loot_system::get_empty_munition_slot(var0);

  if(isDefined(var14)) {
    var12 = var14;
  } else {
    var0 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return;
  }

  if(var11 == "sentry_turret") {
    var0 scripts\cp\loot_system::try_give_munition_to_slot(var11, var12, "sentry_turret");
  } else {
    var0 scripts\cp\loot_system::try_give_munition_to_slot(var11, var12);
  }

  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var16 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var16, self);
        }
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    return;
  }
}

function cploadoutcrateactivatecallback(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function cploadoutcratecapturecallback(var0) {
  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  self.playersused[self.playersused.size] = var0;

  if(!scripts\cp\cp_endgame::gamealreadyended()) {
    var0 setclientomnvar("ui_options_menu", 2);
  }

  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var2 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var2, self);
        }
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    return;
  }
}

function airdrop_airdropmultipleinit() {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

function airdrop_registerscoreinfo() {}

function airdrop_registeractionset() {
  var0 = getdvarint("scr_airDrop_use_weapon", 1);

  if(var0) {
    scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers"]);
    return;
  }

  scripts\mp\playeractions::registeractionset("crateUse", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

function airdrop_updateuiprogress(var0, var1) {
  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave()) {
    updateuiprogress(var0, var1);
    return;
  }
}

function updateuiprogress(var0, var1) {
  if(!isDefined(level.hostmigrationtimer)) {
    if(isDefined(var0.interactteam) && var0.interactteam == "none") {
      self setclientomnvar("ui_objective_state", 0);
      return;
    }

    var2 = undefined;

    if(isDefined(var0.objidnum)) {
      var2 = var0.objidnum;
    }

    var3 = 0;

    if(isDefined(var0.teamprogress) && isDefined(var0.claimteam)) {
      if(var0.teamprogress[var0.claimteam] > var0.usetime) {
        var0.teamprogress[var0.claimteam] = var0.usetime;
      }

      var3 = var0.teamprogress[var0.claimteam] / var0.usetime;
    } else {
      if(var0.curprogress > var0.usetime) {
        var0.curprogress = var0.usetime;
      }

      var3 = var0.curprogress / var0.usetime;

      if(var0.usetime <= 1000) {
        var3 = min(var3 + 0.05, 1);
      } else {
        var3 = min(var3 + 0.01, 1);
      }
    }

    if(isDefined(var0.id)) {
      var4 = 0;

      switch (var0.id) {
        case "care_package":
          var4 = 1;
          break;
        case "intel":
          var4 = 2;
          break;
        case "support_box":
          var4 = 3;
          break;
        case "deployable_weapon_crate":
          var4 = 4;
          break;
        case "use":
          var4 = 8;
          break;
      }

      updateuisecuring(var3, var1, var4, var0, var0.usetime);
      return;
    }

    return;
  }
}

function isrevivetrigger() {
  if(isDefined(self.id) && self.id == "laststand_reviver") {
    return true;
  }

  return false;
}

function existinarray(var0, var1) {
  if(var1.size > 0) {
    foreach(var3 in var1) {
      if(var3 == var0) {
        return true;
      }
    }
  }

  return false;
}

function updateuisecuring(var0, var1, var2, var3, var4) {
  var5 = undefined;

  if(var1) {
    if(!isDefined(var3.usedby)) {
      var3.usedby = [];
    }

    if(!isDefined(self.migrationcapturereset)) {
      thread migrationcapturereset(var3);
    }

    if(!existinarray(self, var3.usedby)) {
      var3.usedby[var3.usedby.size] = self;
    }

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", var2);
      self.ui_securing = 1;

      if(isDefined(var3.trigger) && isrevivetrigger(var3.trigger)) {
        if(isDefined(var3.trigger.owner)) {
          var3.trigger.owner setclientomnvar("ui_reviver_id", self getentitynumber());
          var3.trigger.owner setclientomnvar("ui_securing", 6);
        }
      }
    }
  } else {
    if(isDefined(var3.usedby) && existinarray(self, var3.usedby)) {
      var3.usedby = scripts\engine\utility::array_remove(var3.usedby, self);
    }

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;

    if(isDefined(var3.trigger) && isrevivetrigger(var3.trigger)) {
      if(isDefined(var3.trigger.owner)) {
        var3.trigger.owner setclientomnvar("ui_reviver_id", -1);
        var3.trigger.owner setclientomnvar("ui_securing", 0);
      }
    }

    var0 = 0.01;

    if(isDefined(var3.objidnum)) {
      var5 = var3.objidnum;
    }
  }

  if(var4 == 500) {
    var0 = min(var0 + 0.15, 1);
  }

  if(var0 != 0) {
    self setclientomnvar("ui_securing_progress", var0);

    if(isDefined(var3.trigger) && isrevivetrigger(var3.trigger)) {
      if(isDefined(var3.trigger.owner)) {
        var3.trigger.owner setclientomnvar("ui_securing_progress", var0);
      }
    }

    if(isDefined(var3.objidnum)) {
      scripts\mp\objidpoolmanager::objective_set_progress(var3.objidnum, var0);
      return;
    }

    return;
  }
}

function migrationcapturereset(var0) {
  var0.migrationcapturereset = 1;
  level waittill("host_migration_begin");

  if(!isDefined(var0) || !isDefined(self)) {
    return;
  }

  var0 setclientomnvar("ui_securing", 0);
  var0 setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

function airdrop_allowactionset(var0, var1) {
  scripts\mp\playeractions::allowactionset(var0, var1);
}

function airdrop_unresolvedcollisionnearestnode(var0, var1, var2) {
  childthread scripts\cp\cp_movers::unresolved_collision_nearest_node(var0, var1, var2);
}

function airdrop_showerrormessage(var0) {}

function airdrop_awardkillstreak(var0, var1, var2) {}

function airdrop_showkillstreaksplash(var0, var1, var2) {}

function airdrop_gettargetmarker(var0) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var0);
}

function airdrop_airdropmultipledropcrates(var0, var1, var2, var3, var4) {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var0, var1, var2, var3, var4);
}

function airdrop_registercrateforcleanup(var0) {}

function airdrop_makeweaponfromcrate() {}

function airdrop_makeitemfromcrate() {}

function airdrop_outlinedisable(var0, var1) {
  scripts\cp\cp_outline_utility::outlinedisable(var0, var1);
}

function airdrop_br_forcegiveweapon(var0, var1, var2) {}

function airdrop_capturelootcachecallback() {}

function airdrop_iskillstreakblockedforbots(var0) {}

function airdrop_botiskillstreaksupported(var0) {}

function airdrop_getgamemodespecificcratedata() {
  initcpcratedata();
  initcploadoutcratedata();
  toggle_ambient_vehicles_on_module();
  initcparmsraceemptycrate();
  teleport_reference_silo();
  teleport_room_doors();
}

function br_challenges() {
  if(!isPlayer(self)) {
    return false;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    return false;
  }

  return true;
}

function makeitemsfromcrate(var0) {
  var1 = self.data;

  if(var1.type == "weapon") {
    var2 = randomintrange(2, 4);
    var3 = 6 - var2;
    return;
  }

  if(var1.type == "attachment") {
    var2 = randomintrange(1, 2);
    var3 = 6 - var2;
    return;
  }
}

function createdropweapon(var0, var1, var2, var3, var4) {}

function managedroppedents() {
  if(!isDefined(level.droppedweapons)) {
    level.droppedweapons = [];
  }

  if(level.droppedweapons.size > 63) {
    var0 = [];

    for(var1 = 0; var1 < level.droppedweapons.size; var1++) {
      if(var1 < 16) {
        if(isDefined(level.droppedweapons[var1])) {
          if(isDefined(level.droppedweapons[var1].pickupent)) {
            level.droppedweapons[var1].pickupent delete();
          }

          level.droppedweapons[var1] delete();
        }

        continue;
      }

      var0 = level.droppedweapons[var1];
    }

    level.droppedweapons = var0;
    return;
  }
}