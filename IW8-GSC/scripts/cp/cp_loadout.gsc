/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_loadout.gsc
***********************************************/

function init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.move_speed_scale = &updatemovespeedscale;
  level.registerplayercharfunc = &registerplayercharacter;
  init_core_mp_perks();

  if(!isDefined(level.loadoutsgroup)) {
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();
  }

  scripts\cp\coop_super::init_super();

  if(!isDefined(level.classmap)) {
    level.classmap = [];
  }

  level.classmap["class0"] = 0;
  level.classmap["class1"] = 1;
  level.classmap["class2"] = 2;
  level.classmap["custom1"] = 0;
  level.classmap["custom2"] = 1;
  level.classmap["custom3"] = 2;
  level.classmap["custom4"] = 3;
  level.classmap["custom5"] = 4;
  level.classmap["custom6"] = 5;
  level.classmap["custom7"] = 6;
  level.classmap["custom8"] = 7;
  level.classmap["custom9"] = 8;
  level.classmap["custom10"] = 9;
  level.classmap["axis_recipe1"] = 0;
  level.classmap["axis_recipe2"] = 1;
  level.classmap["axis_recipe3"] = 2;
  level.classmap["axis_recipe4"] = 3;
  level.classmap["axis_recipe5"] = 4;
  level.classmap["axis_recipe6"] = 5;
  level.classmap["allies_recipe1"] = 0;
  level.classmap["allies_recipe2"] = 1;
  level.classmap["allies_recipe3"] = 2;
  level.classmap["allies_recipe4"] = 3;
  level.classmap["allies_recipe5"] = 4;
  level.classmap["allies_recipe6"] = 5;
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.classmap["default1"] = 0;
  level.classmap["default2"] = 1;
  level.classmap["default3"] = 2;
  level.classmap["default4"] = 3;
  level.classmap["default5"] = 4;
  level.classmap["default6"] = 5;
  level.classmap["default7"] = 6;
  level.classmap["default8"] = 7;
  level.classmap["default9"] = 8;
  level.classmap["default10"] = 9;
  level.classmap["default11"] = 10;
  level.classmap["juggernaut"] = 0;
  level.defaultclass = "CLASS_ASSAULT";

  if(getdvarint("scr_test_loadouts", 0)) {
    level.classtablename = "mp/classtable_test.csv";
    return;
  }

  level.classtablename = "mp/classtable.csv";
}

function getplayerbodymodel() {
  var_0 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  return var_0[0];
}

function return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!istrue(var_0.weaponkitinitialized)) {
    var_0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var_0.weapon_build_models[var_1])) {
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  }

  return var_2;
}

function delayreturningperks(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  wait 1;

  if(istrue(var_0.keep_perks)) {
    if(isDefined(var_0.zombies_perks)) {
      var_1 = getarraykeys(var_0.zombies_perks);

      foreach(var_3 in var_1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_3]) && isDefined(level.coop_perk_callbacks[var_3].set)) {
          var_0[[level.coop_perk_callbacks[var_3].set]]();
        }
      }
    }

    var_0.keep_perks = undefined;
    return;
  }
}

function release_character_number(var_0) {
  var_1 = var_0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_1) && var_1 != 5) {
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_1);
    return;
  }
}

function get_player_character_num() {
  if(isDefined(self.player_character_num)) {
    return self.player_character_num;
  }

  var_1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var_1;
  return var_1;
}

function updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1;
    var_0 += self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale)) {
      var_0 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var_0 = self.siege_speedscale;
    }

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod)) {
      var_0 += var_1.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var_0 += self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var_0 += self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var_0 += self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_0 += self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_0 += self.weaponpassivespeedonkillmod;
    }

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar);
}

function getplayerspeedbyweapon(var_0) {
  var_1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    var_1 = 0.9;
  } else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var_2)) {
      var_1 = level.superweapons[createheadicon(var_2)].movespeed;
    } else {
      var_3 = weaponinventorytype(var_2);

      if(var_3 != "primary" && var_3 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var_2 = self.saved_lastweapon;
        } else {
          var_2 = undefined;
        }
      }

      if(!isDefined(var_2) || !self hasweapon(var_2)) {
        var_1 = getweaponspeedslowest();
      } else {
        var_1 = getweaponspeed(var_2);
      }
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

function getweaponspeed(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = level.weaponmapdata[var_1].speed;
  return var_2;
}

function getweaponspeedslowest() {
  var_0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponspeed(var_2);

      if(var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 0.9;
  }

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

function clampweaponspeed(var_0) {
  return clamp(var_0, 0, 1);
}

function getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 8;
  }

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

function getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_1 = float(tablelookup("mp/statstable.csv", 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = float(tablelookup(level.game_mode_statstable, 4, var_2, 8));
  }

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = 10;
  }

  return var_1;
}

function clampweaponweightvalue(var_0) {
  return clamp(var_0, 0, 11);
}

function wait_and_force_weapon_switch(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;

  if(!self hasweapon(var_0)) {
    var_0 = self getweaponslistprimaries()[0];
  }

  self setspawnweapon(var_0);
}

function init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.perksetfuncs["specialty_momentum"] = &setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = &unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = &setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = &unsetfreefall;
  level.perksetfuncs["specialty_lightweight"] = &setlightweight;
  level.perkunsetfuncs["specialty_lightweight"] = &unsetlightweight;
}

function setmomentum() {
  thread runmomentum();
}

function runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

function graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();
  var_0 = 0;

  while(var_0 < 0.08) {
    self.movespeedscaler += 0.01;
    updatemovespeedscale();
    wait 0.4375;
    var_0 += 0.01;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

function momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

function momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

function momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

function unsetmomentum() {
  self notify("momentum_unset");
}

function setfreefall() {}

function unsetfreefall() {}

function setlightweight() {
  self.movespeedscaler = lightweightscalar();
  self[[level.move_speed_scale]]();
}

function unsetlightweight() {
  self.movespeedscaler = 1;
  self[[level.move_speed_scale]]();
}

function lightweightscalar() {
  return 1.12;
}

function set_player_perks() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    var_0 = 4;
    var_1 = 0;
    var_2 = 0;
    var_2 = var_0;

    if(isDefined(level.player_suit)) {
      self setsuit(level.player_suit);
    } else {
      self setsuit("iw8_suit_cp");
    }

    self.suit = "iw8_suit_cp";
    self allowdoublejump(0);
    self allowslide(var_2 &var_0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);

  if(!scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    if(isDefined(level.power_modifycooldownrate)) {
      self[[level.power_modifycooldownrate]](0);
    }
  }

  scripts\cp\utility::giveperk("specialty_throwback");
  self setscriptablepartstate("CompassIcon", "defaultIcon");
  self notify("set_player_perks");
}

function registerplayercharacter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17.body_model = var_2;
  var_17.view_model = var_3;
  var_17.head_model = var_4;
  var_17.hair_model = var_5;
  var_17.vo_prefix = var_6;
  var_17.vo_suffix = var_7;
  var_17.pap_gesture = var_8;
  var_17.revive_gesture = var_9;
  var_17.photo_index = var_10;
  var_17.fate_card_weapon = var_11;
  var_17.intro_music = var_12;
  var_17.intro_gesture = var_13;
  var_17.melee_weapon = asmdevgetallstates(var_14);
  var_17.starting_weapon = asmdevgetallstates(var_16);
  var_17.post_setup_func = var_15;
  level.player_character_info[var_0] = var_17;

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  if(var_1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var_0;
    return;
  }
}

function loadout_updateclasscustom(var_0, var_1) {
  var_2 = var_1;
  self.class_num = var_2;
  var_0.loadoutprimary = cac_getweapon(var_2, 0);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutprimaryattachments[var_3] = cac_getweaponattachment(var_2, 0, var_3);
    var_0.loadoutprimaryattachmentids[var_3] = force_interrupt_current_combat_action(var_2, 0, var_3);
  }

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0.loadoutprimarystickers[var_4] = cac_getweaponsticker(var_2, 0, var_4);
  }

  var_0.loadoutsecondary = cac_getweapon(var_2, 1);

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0.loadoutsecondaryattachments[var_3] = cac_getweaponattachment(var_2, 1, var_3);
    var_0.loadoutsecondaryattachmentids[var_3] = force_interrupt_current_combat_action(var_2, 1, var_3);
  }

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
  var_0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_2, 1);
  var_0.loadoutsecondaryvariantid = cac_getweaponvariantid(var_2, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0.loadoutsecondarystickers[var_4] = cac_getweaponsticker(var_2, 1, var_4);
  }

  var_0.loadoutequipmentprimary = cac_getequipmentprimary(var_2);
  var_0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_2);
  var_0.loadoutequipmentsecondary = cac_getequipmentsecondary(var_2);
  var_0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_2);
  var_0.loadoutgesture = cac_getgesture();
  var_0.loadoutexecution = cac_getexecution();
  var_0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var_0.loadoutaccessorydata = cac_getaccessorydata();
  var_0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();
  validateloadout(var_0);
  return var_0;
}

function getclassindex(var_0) {
  return level.classmap[var_0];
}

function validateloadout(var_0) {
  var_1 = scripts\cp\utility::weaponnumbermap(var_0.loadoutprimary);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(vehicle_checktrailvfx(var_0.loadoutprimary)) {
    var_2 = 1;
  }

  if(attachmentisrestricted(var_0.loadoutprimary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0.loadoutprimary = "iw8_ar_mike4";
    var_0.loadoutprimaryattachments = [];
    var_0.loadoutprimarycamo = "none";
    var_0.loadoutprimaryreticle = "none";
    var_0.loadoutprimaryvariantid = -1;
    var_0.loadoutprimaryattachmentids = [];
    var_0.loadoutprimarycosmeticattachment = "none";
    var_0.loadoutprimarystickers[0] = "none";
    var_0.loadoutprimarystickers[1] = "none";
    var_0.loadoutprimarystickers[2] = "none";
    var_0.loadoutprimarystickers[3] = "none";
  } else {
    if(vehicle_collision(var_0.loadoutprimary, var_0.loadoutprimaryvariantid)) {
      var_0.loadoutprimaryvariantid = -1;
    }

    for(var_4 = 0; var_4 < var_0.loadoutprimaryattachments.size; var_4++) {
      var_5 = var_0.loadoutprimaryattachments[var_4];
      var_6 = var_0.loadoutprimaryattachmentids[var_4];

      if(turrets_shields(var_0.loadoutprimary, var_5, var_6)) {
        var_0.loadoutprimaryattachmentids[var_4] = 0;
      }

      if(var_5 != "none" && (perkisrestricted(var_5, var_0.loadoutprimary) || !vandalize(var_0.loadoutprimary, var_5))) {
        var_0.loadoutprimaryattachments[var_4] = "none";
        var_7 = 1;
      }
    }
  }

  var_1 = scripts\cp\utility::weaponnumbermap(var_0.loadoutsecondary);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(vehicle_checktrailvfx(var_0.loadoutsecondary)) {
    var_2 = 1;
  }

  if(attachmentisrestricted(var_0.loadoutsecondary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_0.loadoutsecondary = "iw8_pi_mike1911";
    var_0.loadoutsecondaryattachments = [];
    var_0.loadoutsecondarycamo = "none";
    var_0.loadoutsecondaryreticle = "none";
    var_0.loadoutsecondaryvariantid = -1;
    var_0.loadoutsecondaryattachmentids = [];
    var_0.loadoutsecondarycosmeticattachment = "none";
    var_0.loadoutsecondarystickers[0] = "none";
    var_0.loadoutsecondarystickers[1] = "none";
    var_0.loadoutsecondarystickers[2] = "none";
    var_0.loadoutsecondarystickers[3] = "none";
  } else {
    if(vehicle_collision(var_0.loadoutsecondary, var_0.loadoutsecondaryvariantid)) {
      var_0.loadoutsecondaryvariantid = -1;
    }

    for(var_4 = 0; var_4 < var_0.loadoutsecondaryattachments.size; var_4++) {
      var_5 = var_0.loadoutsecondaryattachments[var_4];
      var_6 = var_0.loadoutsecondaryattachmentids[var_4];

      if(turrets_shields(var_0.loadoutsecondary, var_5, var_6)) {
        var_0.loadoutsecondaryattachmentids[var_4] = 0;
      }

      if(var_5 != "none" && (perkisrestricted(var_5, var_0.loadoutsecondary) || !vandalize(var_0.loadoutsecondary, var_5))) {
        var_0.loadoutsecondaryattachments[var_4] = "none";
        var_7 = 1;
      }
    }
  }

  return var_0;
}

function vandalize(var_0, var_1) {
  var_2 = getdvarint("scr_checkValidAttachmentUnlock", 0) == 1;

  if(var_2) {
    return carrier_cleanup(var_0, var_1);
  }

  return 1;
}

function carrier_cleanup(var_0, var_1) {
  var_2 = level.weaponattachments[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

function vehicle_checktrailvfx(var_0) {
  return isDefined(level.weaponmapdata[var_0]) && istrue(level.weaponmapdata[var_0].ref_13efc);
}

function vehicle_collision(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    return false;
  }

  var_2 = var_0 + "|" + var_1;
  return isDefined(level.weaponlootmapdata[var_2]) && istrue(level.weaponlootmapdata[var_2].update_focus_fire_objective);
}

function turrets_shields(var_0, var_1, var_2) {
  if(!isDefined(var_2) || var_2 == 0 || var_1 == "none") {
    return false;
  }

  var_3 = 0;

  for(var_4 = 1;; var_4++) {
    var_5 = var_0 + "|" + var_4;

    if(!isDefined(level.weaponlootmapdata[var_5])) {
      break;
    }

    if(!level.weaponlootmapdata[var_5].update_focus_fire_objective) {
      if(isDefined(level.weaponlootmapdata[var_5].attachcustomtoidmap)) {
        foreach(var_7 in level.weaponlootmapdata[var_5].attachcustomtoidmap) {
          if(var_2 == var_7 && var_1 == var_8) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }
  }

  return !var_3;
}

function loadout_updateclassdefault(var_0, var_1) {
  self.class_num = var_1;
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_1, 0);

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_0.loadoutprimaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 0, var_2);
  }

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_1, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_1, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_1, 1);

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_0.loadoutsecondaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 1, var_2);
  }

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_1, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_1, 1);
  var_0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_1);
  var_0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_1);
  var_0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_1);
  var_0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_1);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_1);
  var_0.loadoutexecution = cac_getexecution();
  var_0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var_0.loadoutaccessorydata = cac_getaccessorydata();
  var_0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();

  if(getdvarint("scr_superForceLightTank", 0)) {
    var_0.loadoutsuper = "super_bradley";
  }

  return var_0;
}

function cac_getgesture() {
  var_0 = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    var_1 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_1, "gesture");
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");
  }

  return scripts\cp_mp\gestures::getgesturedata(var_0);
}

function cac_getaccessoryweapon() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessoryweaponbyindex(var_0);
}

function cac_getaccessorydata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorydatabyindex(var_0);
}

function force_interrupt_all_current_combat_actions() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::register_respawn_functions(var_0);
}

function cac_getexecution() {
  return "neck_stab";
}

function cac_getweaponsticker(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "sticker", var_2);
}

function loadout_getclassstruct() {
  var_0 = spawnStruct();
  var_0.loadoutarchetype = "none";
  var_0.loadoutprimary = "none";
  var_0.loadoutprimaryattachments = [];
  var_0.loadoutprimaryattachmentids = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0.loadoutprimaryattachments[var_1] = "none";
    var_0.loadoutprimaryattachmentids[var_1] = 0;
  }

  var_0.loadoutprimarycamo = "none";
  var_0.loadoutprimaryreticle = "none";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "none";
  var_0.loadoutprimaryweaponstickers = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0.loadoutprimarystickers[var_2] = "none";
  }

  var_0.loadoutsecondary = "none";
  var_0.loadoutsecondaryattachments = [];
  var_0.loadoutsecondaryattachmentids = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0.loadoutsecondaryattachments[var_1] = "none";
    var_0.loadoutsecondaryattachmentids[var_1] = 0;
  }

  var_0.loadoutsecondarycamo = "none";
  var_0.loadoutsecondaryreticle = "none";
  var_0.loadoutsecondarylootitemid = 0;
  var_0.loadoutsecondaryvariantid = -1;
  var_0.loadoutsecondarycosmeticattachment = "none";
  var_0.loadoutsecondaryweaponstickers = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0.loadoutsecondaryweaponstickers[var_2] = "none";
  }

  var_0.loadoutmeleeslot = "none";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "specialty_null";
  var_0.loadoutequipmentprimary = "none";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "none";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutfieldupgrade1 = "none";
  var_0.loadoutfieldupgrade2 = "none";
  var_0.loadoutgesture = "none";
  var_0.loadoutaccessorydata = "none";
  var_0.loadoutaccessoryweapon = "none";
  var_0.loadoutexecution = "none";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "streaktype_assault";
  var_0.loadoutkillstreak1 = "none";
  var_0.loadoutkillstreak2 = "none";
  var_0.loadoutkillstreak3 = "none";
  return var_0;
}

function give_weapons_from_loadout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_4 = cac_getloadoutselectedidx(var_0);

  if(isDefined(var_1)) {
    var_3 = loadout_updateclassdefault(var_2, var_1);
  } else {
    var_3 = loadout_updateclasscustom(var_2, var_4);
  }

  self.intro_drive_along_path = var_4;
  self.classstruct = var_3;
  cargo_truck_mg_deletenextframe(var_0, var_3);
  var_5 = get_num_of_charges_for_power(var_0, "primary");
  var_6 = get_grenade_from_struct(var_3.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_6)) {
    var_6 = "none";
  }

  var_7 = get_num_of_charges_for_power(var_0, "secondary");
  var_8 = get_grenade_from_struct(var_3.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_8)) {
    var_8 = "none";
  }

  var_9 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(!istrue(self.getc130knownsafeheight)) {
    var_0 scripts\cp\cp_munitions::reset_munitions(self, var_9);
    var_0 scripts\cp\cp_munitions::cargo_truck_mg_enterend();
  }

  var_0 thread scripts\cp\cp_powers::givepower(var_6, "primary", undefined, undefined, undefined, undefined, 1, var_5);
  var_0 thread scripts\cp\cp_powers::givepower(var_8, "secondary", undefined, undefined, undefined, undefined, 1, var_7);
}

function get_num_of_charges_for_power(var_0, var_1) {
  if(isDefined(level.get_num_of_charges_for_power)) {
    return [[level.get_num_of_charges_for_power]](var_0);
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_2 = cac_getloadoutperk(undefined, 2);

    if(var_2 == "specialty_extra_shrapnel") {
      scripts\cp\utility::giveperk("specialty_extra_deadly");
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && var_1 == "primary") {
    return 2;
  }

  if(isDefined(self.perk_data["offhand_count"])) {
    return self.perk_data["offhand_count"];
  }

  return 1;
}

function get_default_num_equipment_charges() {
  return true;
}

function scout_drone(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = cac_getloadoutselectedidx(var_0);

  if(isDefined(var_2)) {
    var_5 = loadout_updateclassdefault(var_3, var_2);
  } else {
    var_5 = loadout_updateclasscustom(var_4, var_5);
  }

  var_6 = get_num_of_charges_for_power(var_1, "primary");
  var_7 = get_grenade_from_struct(var_5.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_7)) {
    var_7 = "none";
  }

  var_8 = get_num_of_charges_for_power(var_1, "secondary");
  var_9 = get_grenade_from_struct(var_5.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_9)) {
    var_9 = "none";
  }

  if(!isDefined(var_2)) {
    var_1 thread scripts\cp\cp_powers::givepower(var_7, "primary", undefined, undefined, undefined, undefined, 1, var_6);
    var_1 thread scripts\cp\cp_powers::givepower(var_9, "secondary", undefined, undefined, undefined, undefined, 1, var_8);
    return;
  }

  if(var_2 == 0) {
    var_1 thread scripts\cp\cp_powers::givepower(var_7, "primary", undefined, undefined, undefined, undefined, 1, var_6);
    return;
  }

  if(var_2 == 1) {
    var_1 thread scripts\cp\cp_powers::givepower(var_9, "secondary", undefined, undefined, undefined, undefined, 1, var_8);
    return;
  }
}

function scoreeventnoweaponxp(var_0) {
  var_1 = spawnStruct();
  var_2 = cac_getloadoutselectedidx(var_0);
  var_3 = loadout_updateclasscustom(var_1, var_2);
  var_3.loadoutprimaryobject = give_primary_weapon(var_0, var_0, var_3);
  var_4 = weaponclipsize(var_1.loadoutprimaryobject);
  var_5 = weaponmaxammo(var_1.loadoutprimaryobject);
  var_0 giveweapon(var_1.loadoutprimaryobject);
  var_0 setweaponammoclip(var_1.loadoutprimaryobject, var_4);
  var_0 setweaponammostock(var_1.loadoutprimaryobject, var_5);
  var_0 switchtoweapon(var_1.loadoutprimaryobject);
}

function script_struct_autotarget(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = cac_getloadoutselectedidx(var_0);
  var_5 = loadout_updateclasscustom(var_3, var_4);
  var_5.loadoutprimaryobject = give_primary_weapon(var_0, var_0, var_5);
  var_0 giveweapon(var_3.loadoutprimaryobject);
  var_0 setweaponammoclip(var_3.loadoutprimaryobject, var_1);
  var_0 setweaponammostock(var_3.loadoutprimaryobject, var_2);
  var_0 switchtoweapon(var_3.loadoutprimaryobject);
}

function scoreleadchanged(var_0, var_1) {
  var_1 = spawnStruct();
  var_2 = cac_getloadoutselectedidx(var_0);
  var_3 = loadout_updateclasscustom(var_1, var_2);
  var_3.loadoutsecondaryobject = give_secondary_weapon(var_0, var_0, var_3);
  var_4 = weaponclipsize(var_3.loadoutsecondaryobject);
  var_5 = weaponmaxammo(var_3.loadoutsecondaryobject);
  var_0 giveweapon(var_3.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_3.loadoutsecondaryobject, var_4);
  var_0 setweaponammostock(var_3.loadoutsecondaryobject, var_5);
  var_0 switchtoweaponimmediate(var_3.loadoutsecondaryobject);
}

function scriptable_damaged_funcs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = cac_getloadoutselectedidx(var_0);
  var_5 = loadout_updateclasscustom(var_3, var_4);
  var_5.loadoutsecondaryobject = give_secondary_weapon(var_0, var_0, var_5);
  var_0 giveweapon(var_3.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_3.loadoutsecondaryobject, var_1);
  var_0 setweaponammostock(var_3.loadoutsecondaryobject, var_2);
  var_0 switchtoweapon(var_3.loadoutsecondaryobject);
}

function change_loadout_watcher(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "class_select" || var_1 == "class_edit" || var_1 == "class_menu_closed") {
      if(is_player_carrying_special_item()) {
        self notify("switched_from_core");
      }

      if(var_1 == "class_select") {
        if(var_2 >= 100) {
          var_3 = var_2 - 100;
        } else {
          var_3 = undefined;
        }

        if(scripts\cp\cp_laststand::player_in_laststand(self)) {
          self notify("loadout_menu_closed");
        } else {
          self.getc130knownsafeheight = 1;
          self.juggernautoutsidegoalradius = var_3;

          if(scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout") && scripts\engine\utility::ent_flag("player_spawned_with_loadout")) {
            self[[level.custom_giveloadout]](0, undefined, var_3, 1);
          } else {
            self[[level.custom_giveloadout]](0, undefined, var_3);
          }
        }

        thread logevent_spawnviateamrevive(self, 5);
      }

      if(var_2 == "class_menu_closed") {
        self notify("loadout_menu_closed");

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          thread flip_target();
        }
      }

      continue;
    }

    if(var_2 == "update_super") {
      scripts\cp\coop_super::give_player_super();
      continue;
    }

    if(var_2 == "munitions_updated") {
      var_4 = self getplayerdata("cp", "inventorySlots", "totalSlots");
      scripts\cp\cp_munitions::reset_munitions(self, var_4);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        ref_139d7();
        thread flip_target();
      }

      continue;
    }

    if(var_2 == "weapon_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      if(self getweaponslistprimaries().size > 1) {
        var_5 = scripts\cp\utility::getvalidtakeweapon();
        self takeweapon(var_5);
      }

      if(self.ref_120b7 == 0) {
        scoreeventnoweaponxp(self);
      } else if(self.ref_120b7 == 1) {
        scoreleadchanged(self);
      }

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_collect_generic");
      continue;
    }

    if(var_2 == "attachment_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      var_5 = scripts\cp\utility::getvalidtakeweapon();
      var_6 = self getweaponammoclip(var_5);
      var_7 = self getweaponammostock(var_5);
      self takeweapon(var_5);

      if(self.ref_120b7 == 0) {
        script_struct_autotarget(self, var_6, var_7);
      } else if(self.ref_120b7 == 1) {
        scriptable_damaged_funcs(self, var_6, var_7);
      }

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "ping_attachments_generic");
      continue;
    }

    if(var_2 == "tactical_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 1, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_collect_generic");
      continue;
    }

    if(var_2 == "lethal_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_collect_generic");
      continue;
    }

    if(var_2 == "shrapnel_perk_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_collect_generic");
      continue;
    }

    if(var_2 == "ammo_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      var_5 = scripts\cp\utility::getvalidtakeweapon();
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        var_1 waittill("revive_success");
        waitframe();
      }

      self givemaxammo(var_5);
      self setweaponammoclip(var_5, weaponclipsize(var_5));
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "reload", undefined, 0.2);
    }
  }
}

function logevent_spawnviateamrevive(var_0, var_1) {
  wait 1.5;

  if(level.set_relics.size > 0) {
    var_0 setclientomnvar("ui_match_start_countdown", var_1);
    wait var_1;
    var_0 setclientomnvar("ui_match_start_countdown", -1);
    return;
  }
}

function flip_target() {
  self clearsoundsubmix("cp_store_duck", 1);
}

function ref_139d7() {
  var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "currencyWaveMode");
  scripts\cp\cp_persistence::set_player_currency(var_0);
}

function get_grenade_from_struct(var_0) {
  switch (var_0) {
    case "equip_semtex":
      return "power_semtex";
    case "equip_smoke":
      return "power_smokeGrenade";
    case "equip_frag":
      return "power_frag";
    case "equip_molotov":
      return "power_molotov";
    case "equip_claymore":
      return "power_claymore";
    case "equip_gas_grenade":
      return "equip_gas_grenade";
    case "equip_throwing_knife":
      return "power_throwingKnife";
    case "equip_throwing_knife_fire":
      return "power_throwingKnife_fire";
    case "equip_throwing_knife_electric":
      return "power_throwingKnife_electric";
    case "equip_throwing_knife_drill":
      return "power_throwingKnife_drill";
    case "equip_c4":
      return "power_c4";
    case "equip_hb_sensor":
      return "equip_hb_sensor";
    case "equip_thermite":
      return "power_thermite";
    case "equip_at_mine":
      return "power_atMine";
    case "equip_flash":
      return "power_flash";
    case "equip_concussion":
      return "power_concussionGrenade";
    case "equip_trophy":
      return "power_trophy";
    case "equip_snapshot_grenade":
      return "power_snapshotGrenade";
    case "equip_adrenaline":
      return "equip_adrenaline";
    case "equip_decoy":
      return "equip_decoy";
    default:
      return "none";
  }
}

function cac_getloadoutselectedidx() {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "cpLoadoutSel");
}

function cac_getloadoutperk(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", var_1);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", var_1);
}

function cac_getloadoutextraperk(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "extraPerks", var_1);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "extraPerks", var_1);
}

function cac_getweapon(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "weapon");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "weapon");
}

function cac_getweaponattachment(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
}

function force_interrupt_current_combat_action(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "variantID");
}

function cac_getweaponlootitemid(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "lootItemID");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "lootItemID");
}

function cac_getweaponvariantid(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "variantID");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "variantID");
}

function cac_getweaponcamo(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "camo");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "camo");
}

function cac_getweaponreticle(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "reticle");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "reticle");
}

function cac_getweaponcosmeticattachment(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var_1, "cosmeticAttachment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "cosmeticAttachment");
}

function cac_checkoverkillperk(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", 0);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", 0);
}

function cac_getequipmentprimary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "equipment");
}

function cac_getextraequipmentprimary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "extraCharge");
}

function cac_getequipmentsecondary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "equipment");
}

function cac_getextraequipmentsecondary(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "extraCharge");
}

function cargo_truck_mg_deletenextframe(var_0, var_1) {
  if(var_1.loadoutprimary == "none") {
    var_1.loadoutprimaryfullname = "none";
    var_1.loadoutprimaryobject = undefined;
  } else {
    var_1.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var_1.loadoutprimary, var_1.loadoutprimaryattachments, var_1.loadoutprimarycamo, var_1.loadoutprimaryreticle, var_1.loadoutprimaryvariantid, var_1.loadoutprimaryattachmentids, var_1.loadoutprimarycosmeticattachment, var_1.loadoutprimarystickers, istrue(var_1.loadouthasnvg));
    var_1.loadoutprimaryobject = scriptable_door_get_in_radius(var_0, var_1.loadoutprimaryobject);
    var_1.loadoutprimaryfullname = createheadicon(var_1.loadoutprimaryobject);
  }

  if(var_1.loadoutsecondary == "none") {
    var_1.loadoutsecondaryfullname = "none";
    var_1.loadoutsecondaryobject = undefined;
  } else {
    var_1.loadoutsecondaryobject = scripts\cp\cp_weapon::buildweapon(var_1.loadoutsecondary, var_1.loadoutsecondaryattachments, var_1.loadoutsecondarycamo, var_1.loadoutsecondaryreticle, var_1.loadoutsecondaryvariantid, var_1.loadoutsecondaryattachmentids, var_1.loadoutsecondarycosmeticattachment, var_1.loadoutsecondarystickers, istrue(var_1.loadouthasnvg));
    var_1.loadoutsecondaryobject = scriptable_door_get_in_radius(var_0, var_1.loadoutsecondaryobject);
    var_1.loadoutsecondaryfullname = createheadicon(var_1.loadoutsecondaryobject);
  }

  var_0.starting_weapon = var_1.loadoutprimaryobject;
  var_0.primaryweaponobj = var_0.starting_weapon;
  var_0.default_starting_pistol = var_1.loadoutsecondaryobject;
  var_0.secondaryweaponobj = var_0.default_starting_pistol;
}

function give_primary_weapon(var_0, var_1) {
  return scripts\cp\cp_weapon::buildweapon(var_1.loadoutprimary, var_1.loadoutprimaryattachments);
}

function give_secondary_weapon(var_0, var_1) {
  return scripts\cp\cp_weapon::buildweapon(var_1.loadoutsecondary, var_1.loadoutsecondaryattachments);
}

function scriptable_door_get_in_radius(var_0, var_1) {
  var_2 = var_1 getaltweapon();

  if(var_2.basename != "none") {
    var_3 = weaponclass(var_2);

    if(var_3 == "spread") {
      var_0 setweaponammoclip(var_2, weaponclipsize(var_2));
    }
  }

  return var_1;
}

function table_getarchetype(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutArchetype", var_1 + 1);
}

function table_getloadoutname(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutName", var_1 + 1);
}

function table_getweapon(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimary", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondary", var_1 + 1);
}

function table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "none";

  if(var_2 == 0) {
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryAttachment" + var_3 + 1, var_1 + 1);
  } else {
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryAttachment" + var_3 + 1, var_1 + 1);
  }

  if(var_4 == "" || var_4 == "none") {
    return "none";
  }

  return var_4;
}

function table_getweaponcamo(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);
}

function table_getweaponreticle(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);
}

function table_getperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutPerk" + var_2 + 1, var_1 + 1);
}

function table_getextraperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutExtraPerk" + var_2 + 1, var_1 + 1);
}

function table_getequipmentprimary(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutEquipmentPrimary", var_1 + 1);
}

function table_getextraequipmentprimary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraEquipmentPrimary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getequipmentsecondary(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutEquipmentSecondary", var_1 + 1);
}

function table_getextraequipmentsecondary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraEquipmentSecondary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getsuper(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutSuper", var_1 + 1);
}

function table_getspecialist(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutSpecialist", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getgesture(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutGesture", var_1 + 1);
}

function table_getaccessory(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutAccessory", var_1 + 1);
}

function table_getexecution(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutExecution", var_1 + 1);
}

function table_getkillstreak(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutStreak" + var_2, var_1 + 1);
}

function ref_139e5(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutRole", var_1 + 1);
}

function getclasschoice(var_0) {
  var_0++;
  var_1 = undefined;

  if(var_0 > 100) {
    var_2 = var_0 - 100;
    var_1 = "default" + var_2;
  } else {
    var_1 = "custom" + var_0;
  }

  return var_1;
}

function is_player_carrying_special_item() {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    return 1;
  }

  if(scripts\cp\cp_weapon::ref_124ad(self)) {
    return 1;
  }

  return 0;
}

function drop_special_item() {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(istrue(self.binc130)) {
      return;
    }

    if(isDefined(self.play_disguise_vo)) {
      level.nuclear_core_carrier = undefined;

      if(isDefined(level.outofboundstriggers) && level.outofboundstriggers.size > 0) {
        if(istrue(self.oob)) {
          self notify("location_tracker");
          level.ref_11edf.origin = getEnt("nuclear_core_crashed", "targetname").origin;
          level.ref_11edf.angles = getEnt("nuclear_core_crashed", "targetname").angles;
        }
      }

      if(isDefined(self.headicon)) {
        thread scripts\cp\utility::ent_deleteheadicon(self, self.headicon);
      }

      var_0 = self.origin;

      if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
        var_0 = level.ref_11edf.origin;
      }

      level.nuclear_core = scripts\cp\respawn\cp_respawn::ref_11aa1(var_0 + (0, 0, 64));

      if(isDefined(self.primaryweaponobj)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

        if(isDefined(self.primaryweaponclipammo)) {
          self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
          self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
        }
      }

      if(isDefined(self.secondaryweaponobj)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

        if(isDefined(self.secondaryweaponclipammo)) {
          self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
          self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
          return;
        }

        return;
      }

      return;
    }

    if(!istrue(self.c4_placed_bc)) {
      level.nuclear_core_carrier = undefined;
      self.c4_placed_bc = undefined;
      thread scripts\cp\respawn\cp_respawn::dropnukeweapon("last_stand", self.previousweaponbeforenukein747);
      return;
    }

    return;
  }

  if(scripts\cp\cp_weapon::ref_124ad(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    return;
  }
}