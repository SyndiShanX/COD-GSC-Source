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
  var0 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  return var0[0];
}

function return_wbk_version_of_weapon(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");

  if(!istrue(var0.weaponkitinitialized)) {
    var0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var0.weapon_build_models[var1])) {
    return asmdevgetallstates(var0.weapon_build_models[var1]);
  }

  return var2;
}

function delayreturningperks(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  wait 1;

  if(istrue(var0.keep_perks)) {
    if(isDefined(var0.zombies_perks)) {
      var1 = getarraykeys(var0.zombies_perks);

      foreach(var3 in var1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var3]) && isDefined(level.coop_perk_callbacks[var3].set)) {
          var0[[level.coop_perk_callbacks[var3].set]]();
        }
      }
    }

    var0.keep_perks = undefined;
    return;
  }
}

function release_character_number(var0) {
  var1 = var0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var1) && var1 != 5) {
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var1);
    return;
  }
}

function get_player_character_num() {
  if(isDefined(self.player_character_num)) {
    return self.player_character_num;
  }

  var1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var1;
  return var1;
}

function updatemovespeedscale() {
  var0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var0 = 1;
    var0 += self.playerstreakspeedscale;
  } else {
    var0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale)) {
      var0 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var0 = self.siege_speedscale;
    }

    var1 = self.chill_data;

    if(isDefined(var1) && isDefined(var1.speedmod)) {
      var0 += var1.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var0 += self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var0 += self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var0 += self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var0 += self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var0 += self.weaponpassivespeedonkillmod;
    }

    var0 = min(1.5, var0);
  }

  self.weaponspeed = var0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  self setmovespeedscale(var0 * self.movespeedscaler * self.combatspeedscalar);
}

function getplayerspeedbyweapon(var0) {
  var1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on") {
    return 1;
  }

  if(!self.weaponlist.size) {
    var1 = 0.9;
  } else {
    var2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var2)) {
      var1 = level.superweapons[createheadicon(var2)].movespeed;
    } else {
      var3 = weaponinventorytype(var2);

      if(var3 != "primary" && var3 != "altmode") {
        if(isDefined(self.saved_lastweapon)) {
          var2 = self.saved_lastweapon;
        } else {
          var2 = undefined;
        }
      }

      if(!isDefined(var2) || !self hasweapon(var2)) {
        var1 = getweaponspeedslowest();
      } else {
        var1 = getweaponspeed(var2);
      }
    }
  }

  var1 = clampweaponspeed(var1);
  return var1;
}

function getweaponspeed(var0) {
  var1 = scripts\cp\utility::getbaseweaponname(var0);
  var2 = level.weaponmapdata[var1].speed;
  return var2;
}

function getweaponspeedslowest() {
  var0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var2 in self.weaponlist) {
      var3 = getweaponspeed(var2);

      if(var3 == 0) {
        continue;
      }

      if(var3 < var0) {
        var0 = var3;
      }
    }
  } else {
    var0 = 0.9;
  }

  var0 = clampweaponspeed(var0);
  return var0;
}

function clampweaponspeed(var0) {
  return clamp(var0, 0, 1);
}

function getweaponheaviestvalue() {
  var0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var2 in self.weaponlist) {
      var3 = getweaponweight(var2);

      if(var3 == 0) {
        continue;
      }

      if(var3 < var0) {
        var0 = var3;
      }
    }
  } else {
    var0 = 8;
  }

  var0 = clampweaponweightvalue(var0);
  return var0;
}

function getweaponweight(var0) {
  var1 = undefined;
  var2 = scripts\cp\utility::getbaseweaponname(var0);
  var1 = float(tablelookup("mp/statstable.csv", 4, var2, 8));

  if(!isDefined(var1) || var1 < 1) {
    var1 = float(tablelookup(level.game_mode_statstable, 4, var2, 8));
  }

  if(!isDefined(var1) || var1 < 1) {
    var1 = 10;
  }

  return var1;
}

function clampweaponweightvalue(var0) {
  return clamp(var0, 0, 11);
}

function wait_and_force_weapon_switch(var0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;

  if(!self hasweapon(var0)) {
    var0 = self getweaponslistprimaries()[0];
  }

  self setspawnweapon(var0);
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
  var0 = 0;

  while(var0 < 0.08) {
    self.movespeedscaler += 0.01;
    updatemovespeedscale();
    wait 0.4375;
    var0 += 0.01;
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
    var0 = 4;
    var1 = 0;
    var2 = 0;
    var2 = var0;

    if(isDefined(level.player_suit)) {
      self setsuit(level.player_suit);
    } else {
      self setsuit("iw8_suit_cp");
    }

    self.suit = "iw8_suit_cp";
    self allowdoublejump(0);
    self allowslide(var2 &var0);
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

function registerplayercharacter(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16) {
  var17 = spawnStruct();
  var17.body_model = var2;
  var17.view_model = var3;
  var17.head_model = var4;
  var17.hair_model = var5;
  var17.vo_prefix = var6;
  var17.vo_suffix = var7;
  var17.pap_gesture = var8;
  var17.revive_gesture = var9;
  var17.photo_index = var10;
  var17.fate_card_weapon = var11;
  var17.intro_music = var12;
  var17.intro_gesture = var13;
  var17.melee_weapon = asmdevgetallstates(var14);
  var17.starting_weapon = asmdevgetallstates(var16);
  var17.post_setup_func = var15;
  level.player_character_info[var0] = var17;

  if(!isDefined(level.available_player_characters)) {
    level.available_player_characters = [];
  }

  if(var1 == "yes") {
    level.available_player_characters[level.available_player_characters.size] = var0;
    return;
  }
}

function loadout_updateclasscustom(var0, var1) {
  var2 = var1;
  self.class_num = var2;
  var0.loadoutprimary = cac_getweapon(var2, 0);

  for(var3 = 0; var3 < 5; var3++) {
    var0.loadoutprimaryattachments[var3] = cac_getweaponattachment(var2, 0, var3);
    var0.loadoutprimaryattachmentids[var3] = force_interrupt_current_combat_action(var2, 0, var3);
  }

  var0.loadoutprimarycamo = cac_getweaponcamo(var2, 0);
  var0.loadoutprimaryreticle = cac_getweaponreticle(var2, 0);
  var0.loadoutprimarylootitemid = cac_getweaponlootitemid(var2, 0);
  var0.loadoutprimaryvariantid = cac_getweaponvariantid(var2, 0);
  var0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var2, 0);

  for(var4 = 0; var4 < 4; var4++) {
    var0.loadoutprimarystickers[var4] = cac_getweaponsticker(var2, 0, var4);
  }

  var0.loadoutsecondary = cac_getweapon(var2, 1);

  for(var3 = 0; var3 < 5; var3++) {
    var0.loadoutsecondaryattachments[var3] = cac_getweaponattachment(var2, 1, var3);
    var0.loadoutsecondaryattachmentids[var3] = force_interrupt_current_combat_action(var2, 1, var3);
  }

  var0.loadoutsecondarycamo = cac_getweaponcamo(var2, 1);
  var0.loadoutsecondaryreticle = cac_getweaponreticle(var2, 1);
  var0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var2, 1);
  var0.loadoutsecondaryvariantid = cac_getweaponvariantid(var2, 1);
  var0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var2, 1);

  for(var4 = 0; var4 < 4; var4++) {
    var0.loadoutsecondarystickers[var4] = cac_getweaponsticker(var2, 1, var4);
  }

  var0.loadoutequipmentprimary = cac_getequipmentprimary(var2);
  var0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var2);
  var0.loadoutequipmentsecondary = cac_getequipmentsecondary(var2);
  var0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var2);
  var0.loadoutgesture = cac_getgesture();
  var0.loadoutexecution = cac_getexecution();
  var0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var0.loadoutaccessorydata = cac_getaccessorydata();
  var0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();
  validateloadout(var0);
  return var0;
}

function getclassindex(var0) {
  return level.classmap[var0];
}

function validateloadout(var0) {
  var1 = scripts\cp\utility::weaponnumbermap(var0.loadoutprimary);
  var2 = 0;

  if(!isDefined(var1)) {
    var2 = 1;
  } else if(vehicle_checktrailvfx(var0.loadoutprimary)) {
    var2 = 1;
  }

  if(attachmentisrestricted(var0.loadoutprimary)) {
    var2 = 1;
    var3 = 1;
  }

  if(var2) {
    var0.loadoutprimary = "iw8_ar_mike4";
    var0.loadoutprimaryattachments = [];
    var0.loadoutprimarycamo = "none";
    var0.loadoutprimaryreticle = "none";
    var0.loadoutprimaryvariantid = -1;
    var0.loadoutprimaryattachmentids = [];
    var0.loadoutprimarycosmeticattachment = "none";
    var0.loadoutprimarystickers[0] = "none";
    var0.loadoutprimarystickers[1] = "none";
    var0.loadoutprimarystickers[2] = "none";
    var0.loadoutprimarystickers[3] = "none";
  } else {
    if(vehicle_collision(var0.loadoutprimary, var0.loadoutprimaryvariantid)) {
      var0.loadoutprimaryvariantid = -1;
    }

    for(var4 = 0; var4 < var0.loadoutprimaryattachments.size; var4++) {
      var5 = var0.loadoutprimaryattachments[var4];
      var6 = var0.loadoutprimaryattachmentids[var4];

      if(turrets_shields(var0.loadoutprimary, var5, var6)) {
        var0.loadoutprimaryattachmentids[var4] = 0;
      }

      if(var5 != "none" && (perkisrestricted(var5, var0.loadoutprimary) || !vandalize(var0.loadoutprimary, var5))) {
        var0.loadoutprimaryattachments[var4] = "none";
        var7 = 1;
      }
    }
  }

  var1 = scripts\cp\utility::weaponnumbermap(var0.loadoutsecondary);
  var2 = 0;

  if(!isDefined(var1)) {
    var2 = 1;
  } else if(vehicle_checktrailvfx(var0.loadoutsecondary)) {
    var2 = 1;
  }

  if(attachmentisrestricted(var0.loadoutsecondary)) {
    var2 = 1;
    var3 = 1;
  }

  if(var2) {
    var0.loadoutsecondary = "iw8_pi_mike1911";
    var0.loadoutsecondaryattachments = [];
    var0.loadoutsecondarycamo = "none";
    var0.loadoutsecondaryreticle = "none";
    var0.loadoutsecondaryvariantid = -1;
    var0.loadoutsecondaryattachmentids = [];
    var0.loadoutsecondarycosmeticattachment = "none";
    var0.loadoutsecondarystickers[0] = "none";
    var0.loadoutsecondarystickers[1] = "none";
    var0.loadoutsecondarystickers[2] = "none";
    var0.loadoutsecondarystickers[3] = "none";
  } else {
    if(vehicle_collision(var0.loadoutsecondary, var0.loadoutsecondaryvariantid)) {
      var0.loadoutsecondaryvariantid = -1;
    }

    for(var4 = 0; var4 < var0.loadoutsecondaryattachments.size; var4++) {
      var5 = var0.loadoutsecondaryattachments[var4];
      var6 = var0.loadoutsecondaryattachmentids[var4];

      if(turrets_shields(var0.loadoutsecondary, var5, var6)) {
        var0.loadoutsecondaryattachmentids[var4] = 0;
      }

      if(var5 != "none" && (perkisrestricted(var5, var0.loadoutsecondary) || !vandalize(var0.loadoutsecondary, var5))) {
        var0.loadoutsecondaryattachments[var4] = "none";
        var7 = 1;
      }
    }
  }

  return var0;
}

function vandalize(var0, var1) {
  var2 = getdvarint("scr_checkValidAttachmentUnlock", 0) == 1;

  if(var2) {
    return carrier_cleanup(var0, var1);
  }

  return 1;
}

function carrier_cleanup(var0, var1) {
  var2 = level.weaponattachments[var0];
  return isDefined(var2) && isDefined(var2[var1]);
}

function vehicle_checktrailvfx(var0) {
  return isDefined(level.weaponmapdata[var0]) && istrue(level.weaponmapdata[var0].ref_13efc);
}

function vehicle_collision(var0, var1) {
  if(!isDefined(var1) || var1 <= 0) {
    return false;
  }

  var2 = var0 + "|" + var1;
  return isDefined(level.weaponlootmapdata[var2]) && istrue(level.weaponlootmapdata[var2].update_focus_fire_objective);
}

function turrets_shields(var0, var1, var2) {
  if(!isDefined(var2) || var2 == 0 || var1 == "none") {
    return false;
  }

  var3 = 0;

  for(var4 = 1;; var4++) {
    var5 = var0 + "|" + var4;

    if(!isDefined(level.weaponlootmapdata[var5])) {
      break;
    }

    if(!level.weaponlootmapdata[var5].update_focus_fire_objective) {
      if(isDefined(level.weaponlootmapdata[var5].attachcustomtoidmap)) {
        foreach(var7 in level.weaponlootmapdata[var5].attachcustomtoidmap) {
          if(var2 == var7 && var1 == var8) {
            var3 = 1;
            break;
          }
        }
      }

      if(var3) {
        break;
      }
    }
  }

  return !var3;
}

function loadout_updateclassdefault(var0, var1) {
  self.class_num = var1;
  var0.loadoutprimary = table_getweapon(level.classtablename, var1, 0);

  for(var2 = 0; var2 < 5; var2++) {
    var0.loadoutprimaryattachments[var2] = table_getweaponattachment(level.classtablename, var1, 0, var2);
  }

  var0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var1, 0);
  var0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var1, 0);
  var0.loadoutsecondary = table_getweapon(level.classtablename, var1, 1);

  for(var2 = 0; var2 < 5; var2++) {
    var0.loadoutsecondaryattachments[var2] = table_getweaponattachment(level.classtablename, var1, 1, var2);
  }

  var0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var1, 1);
  var0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var1, 1);
  var0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var1);
  var0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var1);
  var0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var1);
  var0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var1);
  var0.loadoutgesture = table_getgesture(level.classtablename, var1);
  var0.loadoutexecution = cac_getexecution();
  var0.loadoutaccessoryweapon = cac_getaccessoryweapon();
  var0.loadoutaccessorydata = cac_getaccessorydata();
  var0.loadoutaccessorylogic = force_interrupt_all_current_combat_actions();

  if(getdvarint("scr_superForceLightTank", 0)) {
    var0.loadoutsuper = "super_bradley";
  }

  return var0;
}

function cac_getgesture() {
  var0 = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    var1 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var1, "gesture");
  } else {
    var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");
  }

  return scripts\cp_mp\gestures::getgesturedata(var0);
}

function cac_getaccessoryweapon() {
  var0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessoryweaponbyindex(var0);
}

function cac_getaccessorydata() {
  var0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorydatabyindex(var0);
}

function force_interrupt_all_current_combat_actions() {
  var0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::register_respawn_functions(var0);
}

function cac_getexecution() {
  return "neck_stab";
}

function cac_getweaponsticker(var0, var1, var2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "sticker", var2);
}

function loadout_getclassstruct() {
  var0 = spawnStruct();
  var0.loadoutarchetype = "none";
  var0.loadoutprimary = "none";
  var0.loadoutprimaryattachments = [];
  var0.loadoutprimaryattachmentids = [];

  for(var1 = 0; var1 < 5; var1++) {
    var0.loadoutprimaryattachments[var1] = "none";
    var0.loadoutprimaryattachmentids[var1] = 0;
  }

  var0.loadoutprimarycamo = "none";
  var0.loadoutprimaryreticle = "none";
  var0.loadoutprimarylootitemid = 0;
  var0.loadoutprimaryvariantid = -1;
  var0.loadoutprimarycosmeticattachment = "none";
  var0.loadoutprimaryweaponstickers = [];

  for(var2 = 0; var2 < 4; var2++) {
    var0.loadoutprimarystickers[var2] = "none";
  }

  var0.loadoutsecondary = "none";
  var0.loadoutsecondaryattachments = [];
  var0.loadoutsecondaryattachmentids = [];

  for(var1 = 0; var1 < 5; var1++) {
    var0.loadoutsecondaryattachments[var1] = "none";
    var0.loadoutsecondaryattachmentids[var1] = 0;
  }

  var0.loadoutsecondarycamo = "none";
  var0.loadoutsecondaryreticle = "none";
  var0.loadoutsecondarylootitemid = 0;
  var0.loadoutsecondaryvariantid = -1;
  var0.loadoutsecondarycosmeticattachment = "none";
  var0.loadoutsecondaryweaponstickers = [];

  for(var2 = 0; var2 < 4; var2++) {
    var0.loadoutsecondaryweaponstickers[var2] = "none";
  }

  var0.loadoutmeleeslot = "none";
  var0.loadoutperksfromgamemode = 0;
  var0.loadoutperks = [];
  var0.loadoutstandardperks = [];
  var0.loadoutextraperks = [];
  var0.loadoutrigtrait = "specialty_null";
  var0.loadoutequipmentprimary = "none";
  var0.loadoutextraequipmentprimary = 0;
  var0.loadoutequipmentsecondary = "none";
  var0.loadoutextraequipmentsecondary = 0;
  var0.loadoutsuper = "none";
  var0.loadoutfieldupgrade1 = "none";
  var0.loadoutfieldupgrade2 = "none";
  var0.loadoutgesture = "none";
  var0.loadoutaccessorydata = "none";
  var0.loadoutaccessoryweapon = "none";
  var0.loadoutexecution = "none";
  var0.loadoutstreaksfilled = 0;
  var0.loadoutstreaktype = "streaktype_assault";
  var0.loadoutkillstreak1 = "none";
  var0.loadoutkillstreak2 = "none";
  var0.loadoutkillstreak3 = "none";
  return var0;
}

function give_weapons_from_loadout(var0, var1) {
  var2 = spawnStruct();
  var3 = spawnStruct();
  var4 = cac_getloadoutselectedidx(var0);

  if(isDefined(var1)) {
    var3 = loadout_updateclassdefault(var2, var1);
  } else {
    var3 = loadout_updateclasscustom(var2, var4);
  }

  self.intro_drive_along_path = var4;
  self.classstruct = var3;
  cargo_truck_mg_deletenextframe(var0, var3);
  var5 = get_num_of_charges_for_power(var0, "primary");
  var6 = get_grenade_from_struct(var3.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var6)) {
    var6 = "none";
  }

  var7 = get_num_of_charges_for_power(var0, "secondary");
  var8 = get_grenade_from_struct(var3.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var8)) {
    var8 = "none";
  }

  var9 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(!istrue(self.getc130knownsafeheight)) {
    var0 scripts\cp\cp_munitions::reset_munitions(self, var9);
    var0 scripts\cp\cp_munitions::cargo_truck_mg_enterend();
  }

  var0 thread scripts\cp\cp_powers::givepower(var6, "primary", undefined, undefined, undefined, undefined, 1, var5);
  var0 thread scripts\cp\cp_powers::givepower(var8, "secondary", undefined, undefined, undefined, undefined, 1, var7);
}

function get_num_of_charges_for_power(var0, var1) {
  if(isDefined(level.get_num_of_charges_for_power)) {
    return [[level.get_num_of_charges_for_power]](var0);
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var2 = cac_getloadoutperk(undefined, 2);

    if(var2 == "specialty_extra_shrapnel") {
      scripts\cp\utility::giveperk("specialty_extra_deadly");
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && var1 == "primary") {
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

function scout_drone(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = cac_getloadoutselectedidx(var0);

  if(isDefined(var2)) {
    var5 = loadout_updateclassdefault(var3, var2);
  } else {
    var5 = loadout_updateclasscustom(var4, var5);
  }

  var6 = get_num_of_charges_for_power(var1, "primary");
  var7 = get_grenade_from_struct(var5.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var7)) {
    var7 = "none";
  }

  var8 = get_num_of_charges_for_power(var1, "secondary");
  var9 = get_grenade_from_struct(var5.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var9)) {
    var9 = "none";
  }

  if(!isDefined(var2)) {
    var1 thread scripts\cp\cp_powers::givepower(var7, "primary", undefined, undefined, undefined, undefined, 1, var6);
    var1 thread scripts\cp\cp_powers::givepower(var9, "secondary", undefined, undefined, undefined, undefined, 1, var8);
    return;
  }

  if(var2 == 0) {
    var1 thread scripts\cp\cp_powers::givepower(var7, "primary", undefined, undefined, undefined, undefined, 1, var6);
    return;
  }

  if(var2 == 1) {
    var1 thread scripts\cp\cp_powers::givepower(var9, "secondary", undefined, undefined, undefined, undefined, 1, var8);
    return;
  }
}

function scoreeventnoweaponxp(var0) {
  var1 = spawnStruct();
  var2 = cac_getloadoutselectedidx(var0);
  var3 = loadout_updateclasscustom(var1, var2);
  var3.loadoutprimaryobject = give_primary_weapon(var0, var0, var3);
  var4 = weaponclipsize(var1.loadoutprimaryobject);
  var5 = weaponmaxammo(var1.loadoutprimaryobject);
  var0 giveweapon(var1.loadoutprimaryobject);
  var0 setweaponammoclip(var1.loadoutprimaryobject, var4);
  var0 setweaponammostock(var1.loadoutprimaryobject, var5);
  var0 switchtoweapon(var1.loadoutprimaryobject);
}

function script_struct_autotarget(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = cac_getloadoutselectedidx(var0);
  var5 = loadout_updateclasscustom(var3, var4);
  var5.loadoutprimaryobject = give_primary_weapon(var0, var0, var5);
  var0 giveweapon(var3.loadoutprimaryobject);
  var0 setweaponammoclip(var3.loadoutprimaryobject, var1);
  var0 setweaponammostock(var3.loadoutprimaryobject, var2);
  var0 switchtoweapon(var3.loadoutprimaryobject);
}

function scoreleadchanged(var0, var1) {
  var1 = spawnStruct();
  var2 = cac_getloadoutselectedidx(var0);
  var3 = loadout_updateclasscustom(var1, var2);
  var3.loadoutsecondaryobject = give_secondary_weapon(var0, var0, var3);
  var4 = weaponclipsize(var3.loadoutsecondaryobject);
  var5 = weaponmaxammo(var3.loadoutsecondaryobject);
  var0 giveweapon(var3.loadoutsecondaryobject);
  var0 setweaponammoclip(var3.loadoutsecondaryobject, var4);
  var0 setweaponammostock(var3.loadoutsecondaryobject, var5);
  var0 switchtoweaponimmediate(var3.loadoutsecondaryobject);
}

function scriptable_damaged_funcs(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = cac_getloadoutselectedidx(var0);
  var5 = loadout_updateclasscustom(var3, var4);
  var5.loadoutsecondaryobject = give_secondary_weapon(var0, var0, var5);
  var0 giveweapon(var3.loadoutsecondaryobject);
  var0 setweaponammoclip(var3.loadoutsecondaryobject, var1);
  var0 setweaponammostock(var3.loadoutsecondaryobject, var2);
  var0 switchtoweapon(var3.loadoutsecondaryobject);
}

function change_loadout_watcher(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var1, var2);

    if(var1 == "class_select" || var1 == "class_edit" || var1 == "class_menu_closed") {
      if(is_player_carrying_special_item()) {
        self notify("switched_from_core");
      }

      if(var1 == "class_select") {
        if(var2 >= 100) {
          var3 = var2 - 100;
        } else {
          var3 = undefined;
        }

        if(scripts\cp\cp_laststand::player_in_laststand(self)) {
          self notify("loadout_menu_closed");
        } else {
          self.getc130knownsafeheight = 1;
          self.juggernautoutsidegoalradius = var3;

          if(scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout") && scripts\engine\utility::ent_flag("player_spawned_with_loadout")) {
            self[[level.custom_giveloadout]](0, undefined, var3, 1);
          } else {
            self[[level.custom_giveloadout]](0, undefined, var3);
          }
        }

        thread logevent_spawnviateamrevive(self, 5);
      }

      if(var2 == "class_menu_closed") {
        self notify("loadout_menu_closed");

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          thread flip_target();
        }
      }

      continue;
    }

    if(var2 == "update_super") {
      scripts\cp\coop_super::give_player_super();
      continue;
    }

    if(var2 == "munitions_updated") {
      var4 = self getplayerdata("cp", "inventorySlots", "totalSlots");
      scripts\cp\cp_munitions::reset_munitions(self, var4);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        ref_139d7();
        thread flip_target();
      }

      continue;
    }

    if(var2 == "weapon_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      if(self getweaponslistprimaries().size > 1) {
        var5 = scripts\cp\utility::getvalidtakeweapon();
        self takeweapon(var5);
      }

      if(self.ref_120b7 == 0) {
        scoreeventnoweaponxp(self);
      } else if(self.ref_120b7 == 1) {
        scoreleadchanged(self);
      }

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_collect_generic");
      continue;
    }

    if(var2 == "attachment_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      var5 = scripts\cp\utility::getvalidtakeweapon();
      var6 = self getweaponammoclip(var5);
      var7 = self getweaponammostock(var5);
      self takeweapon(var5);

      if(self.ref_120b7 == 0) {
        script_struct_autotarget(self, var6, var7);
      } else if(self.ref_120b7 == 1) {
        scriptable_damaged_funcs(self, var6, var7);
      }

      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "ping_attachments_generic");
      continue;
    }

    if(var2 == "tactical_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 1, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_collect_generic");
      continue;
    }

    if(var2 == "lethal_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_collect_generic");
      continue;
    }

    if(var2 == "shrapnel_perk_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      scout_drone(self, 0, undefined);
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_collect_generic");
      continue;
    }

    if(var2 == "ammo_purchased" && scripts\cp\utility::turn_off_sniper_laser()) {
      var5 = scripts\cp\utility::getvalidtakeweapon();
      ref_139d7();

      if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
        var1 waittill("revive_success");
        waitframe();
      }

      self givemaxammo(var5);
      self setweaponammoclip(var5, weaponclipsize(var5));
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "reload", undefined, 0.2);
    }
  }
}

function logevent_spawnviateamrevive(var0, var1) {
  wait 1.5;

  if(level.set_relics.size > 0) {
    var0 setclientomnvar("ui_match_start_countdown", var1);
    wait var1;
    var0 setclientomnvar("ui_match_start_countdown", -1);
    return;
  }
}

function flip_target() {
  self clearsoundsubmix("cp_store_duck", 1);
}

function ref_139d7() {
  var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "currencyWaveMode");
  scripts\cp\cp_persistence::set_player_currency(var0);
}

function get_grenade_from_struct(var0) {
  switch (var0) {
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

function cac_getloadoutperk(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", var1);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "loadoutPerks", var1);
}

function cac_getloadoutextraperk(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "extraPerks", var1);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "extraPerks", var1);
}

function cac_getweapon(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "weapon");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "weapon");
}

function cac_getweaponattachment(var0, var1, var2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "attachmentSetup", var2, "attachment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "attachmentSetup", var2, "attachment");
}

function force_interrupt_current_combat_action(var0, var1, var2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "attachmentSetup", var2, "variantID");
}

function cac_getweaponlootitemid(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "lootItemID");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "lootItemID");
}

function cac_getweaponvariantid(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "variantID");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "variantID");
}

function cac_getweaponcamo(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "camo");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "camo");
}

function cac_getweaponreticle(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "reticle");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "reticle");
}

function cac_getweaponcosmeticattachment(var0, var1) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", var1, "cosmeticAttachment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "cosmeticAttachment");
}

function cac_checkoverkillperk(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", 0);
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "loadoutPerks", 0);
}

function cac_getequipmentprimary(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 0, "equipment");
}

function cac_getextraequipmentprimary(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 0, "extraCharge");
}

function cac_getequipmentsecondary(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 1, "equipment");
}

function cac_getextraequipmentsecondary(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge");
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 1, "extraCharge");
}

function cargo_truck_mg_deletenextframe(var0, var1) {
  if(var1.loadoutprimary == "none") {
    var1.loadoutprimaryfullname = "none";
    var1.loadoutprimaryobject = undefined;
  } else {
    var1.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var1.loadoutprimary, var1.loadoutprimaryattachments, var1.loadoutprimarycamo, var1.loadoutprimaryreticle, var1.loadoutprimaryvariantid, var1.loadoutprimaryattachmentids, var1.loadoutprimarycosmeticattachment, var1.loadoutprimarystickers, istrue(var1.loadouthasnvg));
    var1.loadoutprimaryobject = scriptable_door_get_in_radius(var0, var1.loadoutprimaryobject);
    var1.loadoutprimaryfullname = createheadicon(var1.loadoutprimaryobject);
  }

  if(var1.loadoutsecondary == "none") {
    var1.loadoutsecondaryfullname = "none";
    var1.loadoutsecondaryobject = undefined;
  } else {
    var1.loadoutsecondaryobject = scripts\cp\cp_weapon::buildweapon(var1.loadoutsecondary, var1.loadoutsecondaryattachments, var1.loadoutsecondarycamo, var1.loadoutsecondaryreticle, var1.loadoutsecondaryvariantid, var1.loadoutsecondaryattachmentids, var1.loadoutsecondarycosmeticattachment, var1.loadoutsecondarystickers, istrue(var1.loadouthasnvg));
    var1.loadoutsecondaryobject = scriptable_door_get_in_radius(var0, var1.loadoutsecondaryobject);
    var1.loadoutsecondaryfullname = createheadicon(var1.loadoutsecondaryobject);
  }

  var0.starting_weapon = var1.loadoutprimaryobject;
  var0.primaryweaponobj = var0.starting_weapon;
  var0.default_starting_pistol = var1.loadoutsecondaryobject;
  var0.secondaryweaponobj = var0.default_starting_pistol;
}

function give_primary_weapon(var0, var1) {
  return scripts\cp\cp_weapon::buildweapon(var1.loadoutprimary, var1.loadoutprimaryattachments);
}

function give_secondary_weapon(var0, var1) {
  return scripts\cp\cp_weapon::buildweapon(var1.loadoutsecondary, var1.loadoutsecondaryattachments);
}

function scriptable_door_get_in_radius(var0, var1) {
  var2 = var1 getaltweapon();

  if(var2.basename != "none") {
    var3 = weaponclass(var2);

    if(var3 == "spread") {
      var0 setweaponammoclip(var2, weaponclipsize(var2));
    }
  }

  return var1;
}

function table_getarchetype(var0, var1) {
  return tablelookup(var0, 0, "loadoutArchetype", var1 + 1);
}

function table_getloadoutname(var0, var1) {
  return tablelookup(var0, 0, "loadoutName", var1 + 1);
}

function table_getweapon(var0, var1, var2) {
  if(var2 == 0) {
    return tablelookup(var0, 0, "loadoutPrimary", var1 + 1);
  }

  return tablelookup(var0, 0, "loadoutSecondary", var1 + 1);
}

function table_getweaponattachment(var0, var1, var2, var3) {
  var4 = "none";

  if(var2 == 0) {
    var4 = tablelookup(var0, 0, "loadoutPrimaryAttachment" + var3 + 1, var1 + 1);
  } else {
    var4 = tablelookup(var0, 0, "loadoutSecondaryAttachment" + var3 + 1, var1 + 1);
  }

  if(var4 == "" || var4 == "none") {
    return "none";
  }

  return var4;
}

function table_getweaponcamo(var0, var1, var2) {
  if(var2 == 0) {
    return tablelookup(var0, 0, "loadoutPrimaryCamo", var1 + 1);
  }

  return tablelookup(var0, 0, "loadoutSecondaryCamo", var1 + 1);
}

function table_getweaponreticle(var0, var1, var2) {
  if(var2 == 0) {
    return tablelookup(var0, 0, "loadoutPrimaryReticle", var1 + 1);
  }

  return tablelookup(var0, 0, "loadoutSecondaryReticle", var1 + 1);
}

function table_getperk(var0, var1, var2) {
  return tablelookup(var0, 0, "loadoutPerk" + var2 + 1, var1 + 1);
}

function table_getextraperk(var0, var1, var2) {
  return tablelookup(var0, 0, "loadoutExtraPerk" + var2 + 1, var1 + 1);
}

function table_getequipmentprimary(var0, var1) {
  return tablelookup(var0, 0, "loadoutEquipmentPrimary", var1 + 1);
}

function table_getextraequipmentprimary(var0, var1) {
  var2 = tablelookup(var0, 0, "loadoutExtraEquipmentPrimary", var1 + 1);
  return isDefined(var2) && var2 == "TRUE";
}

function table_getequipmentsecondary(var0, var1) {
  return tablelookup(var0, 0, "loadoutEquipmentSecondary", var1 + 1);
}

function table_getextraequipmentsecondary(var0, var1) {
  var2 = tablelookup(var0, 0, "loadoutExtraEquipmentSecondary", var1 + 1);
  return isDefined(var2) && var2 == "TRUE";
}

function table_getsuper(var0, var1) {
  return tablelookup(var0, 0, "loadoutSuper", var1 + 1);
}

function table_getspecialist(var0, var1) {
  var2 = tablelookup(var0, 0, "loadoutSpecialist", var1 + 1);
  return isDefined(var2) && var2 == "TRUE";
}

function table_getgesture(var0, var1) {
  return tablelookup(var0, 0, "loadoutGesture", var1 + 1);
}

function table_getaccessory(var0, var1) {
  return tablelookup(var0, 0, "loadoutAccessory", var1 + 1);
}

function table_getexecution(var0, var1) {
  return tablelookup(var0, 0, "loadoutExecution", var1 + 1);
}

function table_getkillstreak(var0, var1, var2) {
  return tablelookup(var0, 0, "loadoutStreak" + var2, var1 + 1);
}

function ref_139e5(var0, var1) {
  return tablelookup(var0, 0, "loadoutRole", var1 + 1);
}

function getclasschoice(var0) {
  var0++;
  var1 = undefined;

  if(var0 > 100) {
    var2 = var0 - 100;
    var1 = "default" + var2;
  } else {
    var1 = "custom" + var0;
  }

  return var1;
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

      var0 = self.origin;

      if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
        var0 = level.ref_11edf.origin;
      }

      level.nuclear_core = scripts\cp\respawn\cp_respawn::ref_11aa1(var0 + (0, 0, 64));

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