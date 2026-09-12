/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\crafting_system.gsc
***********************************************/

function init_craftingsystem(var_0) {
  readcraftingmaterialstable();
  var_1 = getdvarint("scr_start_points_override", 0);

  if(var_1 != 0) {
    level.starting_currency = var_1;
  } else {
    level.starting_currency = 0;
  }

  level.currentlycrafteditem = spawnStruct();
  level.currentlycrafteditem.crafteditem = "";
  level.currentlycrafteditem.crafteditemmodel = "";
  level.currentlycrafteditem.crafteditempowerreference = "";
  level.currentlycrafteditem.material1 = 0;
  level.currentlycrafteditem.material2 = 0;
  level.currentlycrafteditem.material3 = 0;
  level.currentlycrafteditem.material4 = 0;
  level._effect["airdrop_crate_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["airdrop_crate_impact_smoke_poof"] = loadfx("vfx/iw8_mp/killstreak/vfx_smk_signal_poof_carepackage");
  init();
  level.care_package_interaction = &register_care_package_interaction;
}

function getcraftingmaterialmax(var_0, var_1) {
  var_2 = 10;

  switch (var_0) {
    case "metal":
      var_2 = 66000;
      break;
    case "wood":
      var_2 = 66000;
      break;
    case "explosive":
      var_2 = 66000;
      break;
    case "wire":
      var_2 = 66000;
      break;
    case "battery":
      var_2 = 66000;
      break;
    case "emradiation":
      var_2 = 66000;
      break;
    case "circuitboard":
      var_2 = 66000;
      break;
    case "colordye":
      var_2 = 66000;
      break;
    case "sentry":
      var_2 = 66000;
      break;
    case "drone":
      var_2 = 66000;
      break;
  }

  if(var_1.perk_data["increased_materials_wallet"]) {
    var_2 *= 2;
  }

  return var_2;
}

function readcraftingmaterialstable() {
  var_0 = "cp/cp_munitiontable.csv";
  level.crafting_table_data = [];

  for(var_1 = 1; var_1 <= 17; var_1++) {
    var_2 = table_look_up(var_0, var_1, 1);
    level.crafting_table_data[var_2] = spawnStruct();
    level.crafting_table_data[var_2].crafteditemindex = var_1;
    level.crafting_table_data[var_2].crafteditem = var_2;
    level.crafting_table_data[var_2].crafteditemmodel = table_look_up(var_0, var_1, 2);
    level.crafting_table_data[var_2].crafteditempowerreference = table_look_up(var_0, var_1, 3);
    level.crafting_table_data[var_2].icon = table_look_up(var_0, var_1, 4);
    level.crafting_table_data[var_2].stringref = table_look_up(var_0, var_1, 5);
    level.crafting_table_data[var_2].crafteditemtype = table_look_up(var_0, var_1, 6);
    level.crafting_table_data[var_2].blueprintref = table_look_up(var_0, var_1, 7);
    level.crafting_table_data[var_2].metal = int(table_look_up(var_0, var_1, 8));
    level.crafting_table_data[var_2].wood = int(table_look_up(var_0, var_1, 9));
    level.crafting_table_data[var_2].explosive = int(table_look_up(var_0, var_1, 10));
    level.crafting_table_data[var_2].wire = int(table_look_up(var_0, var_1, 11));
    level.crafting_table_data[var_2].battery = int(table_look_up(var_0, var_1, 12));
    level.crafting_table_data[var_2].emradiation = int(table_look_up(var_0, var_1, 13));
    level.crafting_table_data[var_2].circuitboard = int(table_look_up(var_0, var_1, 14));
    level.crafting_table_data[var_2].colordye = int(table_look_up(var_0, var_1, 15));
    level.crafting_table_data[var_2].sentry = int(table_look_up(var_0, var_1, 16));
    level.crafting_table_data[var_2].drone = int(table_look_up(var_0, var_1, 17));
  }
}

function table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

function throwcrate(var_0) {
  self endon("disconnect");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("ges_plyr_gesture005")) {
    waitframe();
  }

  var_1 = "";

  switch (var_0.weapon_name) {
    case "iw8_ammo_marker_cp":
      var_1 = "ammo_crate";
      break;
    case "iw8_armor_marker_cp":
      var_1 = "armor";
      break;
    case "iw8_adrenaline_marker_cp":
      var_1 = "adrenaline";
      break;
    case "iw8_health_marker_cp":
      var_1 = "health_pack";
      var_1 = "grenade_crate";
      break;
  }

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, var_1, var_0, var_0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

function throwammocrate(var_0) {
  self endon("disconnect");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("ges_plyr_gesture005")) {
    waitframe();
  }

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, "support_box", var_0, var_0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

function getitemslot(var_0) {
  foreach(var_2 in level.crafting_table_data) {
    if(var_0 == var_2.blueprintref) {
      return var_2.crafteditemtype;
    }
  }
}

function remove_crafted_item_from_slot(var_0, var_1) {}

function isspecialcrafteditem(var_0) {
  if(var_0 == "Sentry Turret" || var_0 == "Night Vision Goggles") {
    return 1;
  }

  return 0;
}

function givecrafteditemthruluinotify(var_0) {
  self endon("disconnect");
  var_1 = tablelookup("cp/cp_munitiontable.csv", 0, var_0, 1);
  var_2 = level.crafting_table_data[var_1].crafteditemtype;
  var_3 = level.crafting_table_data[var_1].crafteditempowerreference;
  var_4 = scripts\cp\cp_powers::what_power_is_in_slot("primary");

  if(isDefined(var_4)) {
    if(self.powers[var_4].charges >= self.powers[var_4].maxcharges && var_3 == var_4) {
      return;
    }
  }

  if(isspecialcrafteditem(var_1)) {
    if(var_1 == "Sentry Turret") {
      thread scripts\cp\cp_weapon_autosentry::test_crafted_sentry(self);
    }

    if(var_1 == "Night Vision Goggles") {
      spendcraftedmaterials(level.crafting_table_data[var_1]);
      thread scripts\cp\equipment\nvg::runnvg();
    }
  }

  switch (var_2) {
    case "up_dpad":
      self.crafteditemstruct.bdpadup = 1;
      self.crafteditemstruct.dpadup = level.crafting_table_data[var_1];
      break;
    case "down_dpad":
      self.crafteditemstruct.bdpaddown = 1;
      self.crafteditemstruct.dpaddown = level.crafting_table_data[var_1];
      break;
    case "left_dpad":
      self.crafteditemstruct.bdpadleft = 1;
      self.crafteditemstruct.dpadleft = level.crafting_table_data[var_1];
      break;
    case "right_dpad":
      self.crafteditemstruct.bdpadright = 1;
      self.crafteditemstruct.dpadright = level.crafting_table_data[var_1];
      break;
  }

  if(var_2 == "primary" || var_2 == "secondary") {
    var_5 = undefined;

    if(self.perk_data["additional_crafting_items"]) {
      var_5 = 1;
    }

    spendcraftedmaterials(level.crafting_table_data[var_1]);
    scripts\cp\cp_powers::givepower(var_3, var_2, undefined, undefined, var_5, 0, 1);
  }

  if(var_2 == "direct") {
    spendcraftedmaterials(level.crafting_table_data[var_1]);

    if(var_1 == "Armor") {
      scripts\cp\cp_armor::givearmor(self, 100);
    }

    if(var_1 == "Health Pack") {
      give_health_pack(self, 50);
      return;
    }

    return;
  }
}

function giveitembasedoncraftingstruct(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "respawn":
      if(scripts\cp\utility::turn_off_sniper_laser()) {
        if(!scripts\cp\cp_laststand::buystationsusepaddingdistribution() && (!isDefined(level.players_in_respawn_queue) || level.players_in_respawn_queue.size == 0)) {
          scripts\cp\utility::hint_prompt("revive_teammates_fail", 1, 2);
          break;
        } else {
          scriptable_autouse_funcs();
          thread ref_12C8C(level);
          var_2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("respawn_flare", self);
          scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_2);
          self notify("munitions_used", "respawn");
          break;
        }
      }

      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(level.players_in_respawn_queue.size == 0) {
        self iprintln(" NO Players to respawn!! ");
      } else {
        level.respawn_in_progress = 1;
        scriptable_autouse_funcs();
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(self.origin, level.players_in_respawn_queue, self);
        var_2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("respawn_flare", self);
        scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_2);
        self notify("munitions_used", "respawn");

        foreach(var_4 in level.players) {
          var_4 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn", undefined, self);
        }

        level.respawn_in_progress = undefined;
        LOC_00000160:
      }

      LOC_00000160:
        break;
    case "apache":
    case "chopper_gunner":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(scripts\cp\cp_weapon::ref_124AD(self)) {
        scripts\cp\cp_weapon::minigamefinishcount(self);
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
      break;
    case "ammo_crate":
      var_6 = giveammocrate();

      if(!istrue(var_6)) {
        return 0;
      }

      break;
    case "ac130":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(isDefined(level.ac130_activate_function)) {
        self notify("attempt_use_gunship");
        var_6 = self[[level.ac130_activate_function]]();

        if(!istrue(var_6)) {
          return 0;
        }
      }

      break;
    case "precision_airstrike":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\airstrike::tryuseairstrike("precision_airstrike");
      break;
    case "juggernaut":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);
      break;
    case "drone_strike":
    case "cruise_missile":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      var_7 = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(istrue(var_7)) {
        break;
      } else {
        return 0;
      }
    case "scout_drone":
      if(scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\helper_drone::tryusehelperdrone("radar_drone_recon");
      break;
    case "riot_shield":
      var_0 = 0;
      self notify("one_watcher_for_removing_deployables");
      giveriotshield();
      break;
    case "grenade_launcher":
      var_0 = 0;
      self notify("one_watcher_for_removing_deployables");
      givegrenadelauncher();
      break;
    case "armor":
      var_6 = givearmorcrate();

      if(!istrue(var_6)) {
        return 0;
      }

      break;
    case "adrenaline":
      var_6 = giveadrenalinecrate();

      if(!istrue(var_6)) {
        return 0;
      }

      break;
    case "health_pack":
    case "grenade_crate":
      var_6 = givehealthcrate();

      if(!istrue(var_6)) {
        return 0;
      }

      break;
    case "manual_turret":
      if(!istrue(self.bgivensentry)) {
        scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");
      }

      break;
    case "sentry_turret":
    case "sentry":
      if(!istrue(self.bgivensentry)) {
        scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("sentry_gun");
      }

      break;
    case "uav":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      return scripts\cp_mp\killstreaks\uav::tryuseuav("uav");
    case "deployable_cover":
      var_6 = give_deployable_cover();

      if(!istrue(var_6)) {
        return 0;
      }

      break;
    case "cluster_strike":
    case "toma_strike":
      if(istrue(level.ref_11E8C) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\toma_strike::tryusetomastrike();
      break;
    case "nvg":
      thread scripts\cp\equipment\nvg::runnvg();
      break;
    case "trophysystem":
      self giveandfireoffhand("trophy_mp");
      break;
    case "white_phos":
      scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct("white_phosphorus");
      break;
  }

  if(var_0) {
    thread watcherforremovingdeployable();
  }

  return 1;
}

function give_grenade(var_0, var_1) {
  var_2 = scripts\cp\cp_loadout::get_num_of_charges_for_power(self);
  thread scripts\cp\cp_powers::givepower(var_0, var_1, undefined, undefined, undefined, undefined, 1, var_2);
}

function can_purchase_item(var_0) {
  var_1 = scripts\cp\cp_persistence::get_player_currency();

  if(var_1 >= var_0) {
    return true;
  }

  return false;
}

function watcherforremovingdeployable() {
  self notify("one_watcher_for_removing_deployables");
  self endon("one_watcher_for_removing_deployables");

  for(;;) {
    self waittill("remove_any_active_items");

    if(isDefined(self.last_weapon)) {
      var_0 = scripts\cp\utility::getweapontoswitchbackto();
      self switchtoweapon(var_0);
      self.last_weapon = undefined;
      scripts\cp\utility::clearlowermessage("crate_prompt");
    }
  }
}

function givearmorcrate() {
  return scorerequiresbanking("iw8_armor_marker_cp");
}

function giveadrenalinecrate() {
  return scorerequiresbanking("iw8_adrenaline_marker_cp");
}

function givehealthcrate() {
  return scorerequiresbanking("iw8_health_marker_cp");
}

function giveammocrate() {
  return scorerequiresbanking("iw8_ammo_marker_cp");
}

function scorerequiresbanking(var_0) {
  self endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  self giveandfireoffhand(var_0);
  var_1 = scripts\engine\utility::ref_143AE("offhand_fired", "weapon_fired", "offhand_end");

  if(var_1 == "offhand_end") {
    return undefined;
  }

  return 1;
}

function scriptable_autouse_funcs() {
  self.tispawnposition = self.origin;
  self giveandfireoffhand("flare_mp");
}

function ref_12C8B(var_0) {
  var_0 hide();

  if(!isDefined(self.tispawnposition)) {
    return false;
  }

  if(scripts\cp\utility::touchingbadtrigger()) {
    return false;
  }

  var_1 = self.tispawnposition + (0, 0, 16);
  var_2 = self.tispawnposition - (0, 0, 2048);
  var_3 = [];
  GscBinSkip0(0x2e, 0, self);
}

function ref_14316(var_0) {
  self endon("death");
  wait var_0;
  thread tacinsert_destroy(1);
}

function tacinsert_destroy(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self makeunusable();

  if(isDefined(self.set_backup_location)) {
    self.set_backup_location delete();
  }

  self notify("death");
  self setscriptablepartstate("smoke", "neutral", 0);

  if(istrue(var_0)) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread tacinsert_delayeddelete();
}

function tacinsert_delayeddelete() {
  wait 1;
  self delete();
}

function ref_12C8C(var_0) {
  level endon("game_ended");
  var_1 = "cp_super_revive_used";
  var_2 = [];

  foreach(var_4 in level.players) {
    if(istrue(var_4.inlaststand) && !istrue(var_4.clear_prev_goal)) {
      var_4 scripts\cp\cp_laststand::instant_revive(var_4);
      scripts\cp\cp_armor::givearmor(var_4, 100, 1);
    } else if(istrue(var_4.clear_prev_goal) || isDefined(var_4.last_stand_state) && istrue(var_4.last_stand_state == "bleed_out")) {
      var_2 = var_4;
    }

    var_4 thread scripts\cp\cp_hud_message::showsplash(var_1, undefined, var_0);
  }

  if(var_2.size > 0) {
    wait 5;

    foreach(var_4 in var_2) {
      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 notify("revive_success");
        scripts\cp\cp_armor::givearmor(var_4, 100, 1);
      }
    }

    return;
  }
}

function giveriotshield() {
  self.riot_shield_damage = 1000;
  self.last_weapon = self getcurrentweapon();

  if(!istrue(self.has_riot_shield)) {
    var_0 = "iw8_me_riotshield_mp";
    var_1 = getcompleteweaponname(var_0);
    scripts\cp\utility::_giveweapon(var_1);
    scripts\cp\cp_weapons::switchtoweaponreliable(var_1);
    self.has_riot_shield = 1;
    thread remove_at_shield_death(var_0, 0);
  }

  self notify("munitions_used", "riot_shield");
}

function remove_at_shield_death(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = undefined;
  var_3 = self getweaponslist("primary");

  foreach(var_5 in var_3) {
    if(var_5.basename == var_0) {
      var_2 = var_5;
      break;
    }
  }

  if(isDefined(var_2)) {
    while(self.riot_shield_damage > var_1) {
      waitframe();
    }

    self.riot_shield_broken = 1;

    if(isDefined(self.riotshieldmodel)) {
      scripts\cp\utility::riotshield_detach(1);
    } else if(isDefined(self.riotshieldmodelstowed)) {
      scripts\cp\utility::riotshield_detach(0);
    }

    wait 1;
    self takeweapon(var_2);
    self switchtoweapon(self.last_weapon);
    self.has_riot_shield = undefined;
    self.riot_shield_broken = undefined;
    return;
  }
}

function givegrenadelauncher() {
  self.last_weapon = self getcurrentweapon();
  jumpiffalse(istrue(self.has_gl)) LOC_00000061;
  var_0 = self.equippedweapons;

  foreach(var_2 in var_0) {
    if(var_2.basename == "iw8_la_mike32_mp") {
      var_3 = weaponclipsize(var_2);
      self setweaponammoclip(var_2, var_3);
    }
  }

  goto LOC_000000b7;
}

function remove_at_ammo_count(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_removed");
  var_2 = undefined;
  var_3 = self getweaponslist("primary");

  foreach(var_5 in var_3) {
    if(var_5.basename == var_0) {
      var_2 = var_5;
      break;
    }
  }

  if(isDefined(var_2)) {
    for(;;) {
      var_7 = self getammocount(var_2);

      if(var_7 <= var_1) {
        break;
      }

      waitframe();
    }

    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
    self takeweapon(var_2);
    var_8 = scripts\cp\utility::getweapontoswitchbackto();
    var_9 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var_8, 0);
    self.has_gl = undefined;
    self notify("weapon_removed");
    return;
  }
}

function give_deployable_cover() {
  if(self isthrowinggrenade()) {
    return;
  }

  var_0 = "tac_cover_mp";
  self.ref_12879 = self getcurrentweapon();
  self giveweapon(var_0);
  self switchtoweapon(var_0);
  self notifyonplayercommand("equip_deploy_end", "+weapnext");
  self notifyonplayercommand("equip_deploy_end", "+weapprev");
  self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
  }

  scripts\common\utility::allow_melee(0);
  var_1 = fire_deployable_cover();

  if(istrue(var_1)) {
    return 1;
  } else {
    scripts\common\utility::allow_melee(1);
  }

  return undefined;
}

function laststandoutlineid() {
  self endon("death_or_disconnect");
  self endon("deployable_cover");
  self endon("munitions_used");
  self endon("tac_cover_spawned");
  self waittill("equip_deploy_end");
  waitframe();
  scripts\common\utility::allow_melee(1);
  scripts\cp\powers\cp_tactical_cover::ref_139F3();
}

function fire_deployable_cover() {
  self endon("equip_deploy_end");
  self endon("last_stand");
  self endon("death_or_disconnect");
  var_0 = scripts\cp\cp_weapon::waittill_grenade_fire();

  if(isDefined(var_0.weapon_name) && var_0.weapon_name == "tac_cover_mp") {
    var_1 = scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired_super();

    if(istrue(var_1)) {
      thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(var_0);
      scripts\common\utility::allow_melee(1);

      foreach(var_3 in level.players) {
        var_3 thread scripts\cp\cp_hud_message::showsplash("cp_used_deployable_cover", undefined, self);
      }

      self notify("munitions_used", "deployable_cover");
      return 1;
    }
  }

  self notify("deploy_cover_failed");
  return undefined;
}

function give_health_pack(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 forceplaygestureviewmodel("ges_equip_nanoshot");
  wait var_0 getgestureanimlength("ges_equip_nanoshot");
  thread playfxonplayer();
  var_0.health = int(min(var_0.health + var_1, var_0.maxhealth));

  if(getdvarint("enable_segmented_health_regen", 0) == 1) {
    scripts\cp\utility::set_current_health_regen_segment(var_0, scripts\cp\utility::find_new_health_regen_segment_ceiling(var_0));
    return;
  }
}

function playfxonplayer() {
  var_0 = spawnfxforclient(level._effect["health_pack_activated"], self gettagorigin("tag_eye"), self);
  triggerfx(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("disconnect", self getgestureanimlength("ges_equip_nanoshot") + 2);
  var_0 delete();
}

function spendcraftedmaterials(var_0) {
  var_1 = self getplayerdata("cp", "playerMaterialsList", "metal");
  var_2 = self getplayerdata("cp", "playerMaterialsList", "wood");
  var_3 = self getplayerdata("cp", "playerMaterialsList", "explosive");
  var_4 = self getplayerdata("cp", "playerMaterialsList", "wire");
  var_5 = self getplayerdata("cp", "playerMaterialsList", "battery");
  var_6 = self getplayerdata("cp", "playerMaterialsList", "emradiation");
  var_7 = self getplayerdata("cp", "playerMaterialsList", "circuitboard");
  var_8 = self getplayerdata("cp", "playerMaterialsList", "colordye");
  var_9 = self getplayerdata("cp", "playerMaterialsList", "sentry");
  var_10 = self getplayerdata("cp", "playerMaterialsList", "drone");
  var_11 = decrease_material_amount(var_1, var_0.metal);
  var_12 = decrease_material_amount(var_2, var_0.wood);
  var_13 = decrease_material_amount(var_3, var_0.explosive);
  var_14 = decrease_material_amount(var_4, var_0.wire);
  var_15 = decrease_material_amount(var_5, var_0.battery);
  var_16 = decrease_material_amount(var_6, var_0.emradiation);
  var_17 = decrease_material_amount(var_7, var_0.circuitboard);
  var_18 = decrease_material_amount(var_8, var_0.colordye);
  var_19 = decrease_material_amount(var_9, var_0.sentry, 1);
  var_20 = decrease_material_amount(var_10, var_0.drone, 1);
  self setplayerdata("cp", "playerMaterialsList", "metal", var_11);
  self setplayerdata("cp", "playerMaterialsList", "wood", var_12);
  self setplayerdata("cp", "playerMaterialsList", "explosive", var_13);
  self setplayerdata("cp", "playerMaterialsList", "wire", var_14);
  self setplayerdata("cp", "playerMaterialsList", "battery", var_15);
  self setplayerdata("cp", "playerMaterialsList", "emradiation", var_16);
  self setplayerdata("cp", "playerMaterialsList", "circuitboard", var_17);
  self setplayerdata("cp", "playerMaterialsList", "colordye", var_18);
  self setplayerdata("cp", "playerMaterialsList", "sentry", var_19);
  self setplayerdata("cp", "playerMaterialsList", "drone", var_20);
  self.personalcraftingmaterialslist["metal"] = var_11;
  self.personalcraftingmaterialslist["wood"] = var_12;
  self.personalcraftingmaterialslist["explosive"] = var_13;
  self.personalcraftingmaterialslist["wire"] = var_14;
  self.personalcraftingmaterialslist["battery"] = var_15;
  self.personalcraftingmaterialslist["emradiation"] = var_16;
  self.personalcraftingmaterialslist["circuitboard"] = var_17;
  self.personalcraftingmaterialslist["colordye"] = var_18;
  self.personalcraftingmaterialslist["sentry"] = var_19;
  self.personalcraftingmaterialslist["drone"] = var_20;
}

function getuniquematerialscost(var_0) {
  if(level.crafting_table_data[var_0].wood > 0) {
    return level.crafting_table_data[var_0].wood;
  }

  if(level.crafting_table_data[var_0].explosive > 0) {
    return level.crafting_table_data[var_0].explosive;
  }

  if(level.crafting_table_data[var_0].wire > 0) {
    return level.crafting_table_data[var_0].wire;
  }

  if(level.crafting_table_data[var_0].battery > 0) {
    return level.crafting_table_data[var_0].battery;
  }

  if(level.crafting_table_data[var_0].emradiation > 0) {
    return level.crafting_table_data[var_0].emradiation;
  }

  if(level.crafting_table_data[var_0].circuitboard > 0) {
    return level.crafting_table_data[var_0].circuitboard;
  }

  if(level.crafting_table_data[var_0].colordye > 0) {
    return level.crafting_table_data[var_0].colordye;
  }

  if(level.crafting_table_data[var_0].sentry > 0) {
    return level.crafting_table_data[var_0].sentry;
  }

  if(level.crafting_table_data[var_0].drone > 0) {
    return level.crafting_table_data[var_0].drone;
  }
}

function decrease_material_amount(var_0, var_1, var_2) {
  if(var_1 > 1 && !isDefined(var_2)) {
    var_1 -= self.perk_data["cheap_crafting_recipe"];
  }

  var_3 = var_0 - var_1;
  return var_3;
}

function init() {
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
  initkillstreak();
  initheli();
  initcratedata();
}

function drop_marker_after_time() {
  var_0 = 30;

  while(var_0 >= 0) {
    iprintln(" Dropping a Crate with changed loadout in ^1" + var_0);
    var_0--;
    wait 1;
  }

  var_1 = level.players[0];
  var_2 = var_1.origin + (0, 0, 666);
  var_3 = var_1.angles;
  airdropvisualmarkeractivate(var_1.origin);
  thread dropkillstreakcratefromscriptedheli(var_1, var_1.team, "random", var_2, var_1.angles, var_1.origin);
}

function initkillstreak() {}

function initheli() {
  level.littlebirds = [];
  level.heliconfigs = [];
  var_0 = "airdrop";
  var_1 = spawnStruct();
  var_1.canbedamaged = 1;
  var_1.maxhealth = 500;
  var_1.hitstokill = 3;
  var_1.vodestroyed = "dronedrop_destroyed";
  var_1.callout = "callout_destroyed_airdrop";
  var_1.enginevfxtag = "tag_engine_left";
  level.heliconfigs[var_0] = var_1;
}

function initcratedata() {
  var_0 = spawnStruct();
  var_0.configs = [];
  var_0.crates = [];
  var_0.usablecrates = [];
  level.cratedata = var_0;
  level.mpplayerallowcrateuse = &scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");
  initcratedropdata();
  thread watchallcrateusability();
}

function getleveldata(var_0) {
  var_1 = level.cratedata.configs[var_0];

  if(!isDefined(var_1)) {
    var_1 = getemptyleveldata();
    level.cratedata.configs[var_0] = var_1;
  }

  return var_1;
}

function getemptyleveldata() {
  var_0 = spawnStruct();
  var_0.friendlymodel = "military_carepackage_01_friendly";
  var_0.enemymodel = "military_carepackage_01_enemy";
  var_0.dummymodel = "military_carepackage_01_dummy";
  var_0.mountmantlemodel = getdefaultmountmantlemodel();
  var_0.objweapon = isundefinedweapon();
  var_0.timeout = 90;
  var_0.headiconoffset = 0;
  var_0.minimapicon = "icon_minimap_drone_package_friendly";
  var_0.usetag = "tag_use";
  var_0.userange = 128;
  var_0.usefov = 360;
  var_0.usepriority = -10000;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 1;
  var_0.navobstaclebounds = (30, 10, 64);
  var_0.navobstacleupdatedistsqr = 64;
  var_0.dangerzoneheight = 1000;
  var_0.dangerzoneradius = 200;
  var_0.activatecallback = undefined;
  var_0.deactivatecallback = undefined;
  var_0.capturecallback = undefined;
  var_0.rerollcallback = undefined;
  var_0.destroycallback = undefined;
  var_0.destroyoncapture = 1;
  var_0.onecaptureperplayer = 0;
  var_0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var_0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var_0.capturevisualscallback = getdefaultcapturevisualscallback();
  var_0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var_0.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var_0.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  var_0.headicon = "icon_ks_box_of_guns";
  var_0.supportsreroll = 0;
  var_0.supportsownercapture = 1;
  var_0.supportsothercapture = 1;
  return var_0;
}

function createcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = getleveldata(var_2);
  var_9 = spawn("script_model", var_3);
  var_9.angles = var_4;

  if(var_9 scripts\cp\utility::touchingbadtrigger()) {
    var_9 delete();
    var_0 notify("change_loadout_timer");
    return undefined;
  }

  var_9.owner = var_0;
  var_9.team = var_1;
  var_9.objweapon = var_8.objweapon;
  var_9.cratetype = var_2;
  var_9.useobject = undefined;
  var_9.navobstacle = undefined;
  var_9.headiconid = undefined;
  var_9.minimapid = undefined;
  var_9.dangerzoneid = undefined;
  var_9.navobstacleid = undefined;
  var_9.destination = var_5;
  var_9.headiconactive = 0;
  var_9.minimapiconactive = 0;
  var_9.physicsactivated = 0;
  var_9.isdestroyed = 0;
  var_9.data = var_7;
  var_9.headicon = var_8.headicon;
  var_9.minimapicon = var_8.minimapicon;
  var_9.capturestring = var_8.capturestring;
  var_9.rerollstring = var_8.rerollstring;
  var_9.supportsreroll = var_8.supportsreroll;
  var_9 setModel(var_8.dummymodel);
  var_9 setnodeploy(1);
  var_9 setCanDamage(0);
  var_9 makeunusable();
  var_10 = spawn("script_model", var_3);
  var_10.angles = var_4;
  var_10.crate = var_9;
  var_10 setModel(var_8.friendlymodel);
  var_10 linkTo(var_9);
  var_9.friendlymodel = var_10;
  var_11 = undefined;

  if(isDefined(var_8.enemymodel)) {
    if(level.teambased) {}

    var_11 = spawn("script_model", var_3);
    var_11.angles = var_4;
    var_11.cratedata = var_9;
    var_11 setModel(var_8.enemymodel);
    var_11 linkTo(var_9);
  }

  var_9.enemymodel = var_11;

  if(isDefined(var_9.enemymodel)) {
    thread watchvisibility();
  }

  var_12 = undefined;
  var_12 = spawn("script_model", var_3 + (0, 0, 300));
  var_12 setscriptmoverkillcam("explosive");

  if(isDefined(self.scenenode)) {
    if(var_6) {
      thread looselinkTo(var_12, var_9);
    } else {
      var_12 linkTo(var_9);
    }
  }

  var_9.killcament = var_12;
  addtolists(var_9);
  thread watchcratedestroyearly();

  if(var_6) {
    activatecratephysics(var_9, &activatecratefirsttime, "activateCrate");
  }

  return var_9;
}

function activatecratefirsttime() {
  activatecrate(1);
}

function activatecrate(var_0) {
  self notify("activateCrate");
  deactivatecratephysics();

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  createmountmantlemodel();

  if(istrue(var_0)) {
    createminimapicon();
  }

  outline_crate_in_hud();

  if(isDefined(level.nuclear_crate_interaction)) {
    self.crate_interaction = [[level.nuclear_crate_interaction]](self);
  }

  level.nuclear_crate = self.crate_interaction;
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.activatecallback)) {
    self thread[[var_1.activatecallback]](var_0);
    return;
  }
}

function deactivatecrate(var_0) {
  if(!istrue(var_0)) {
    activatecratephysics(&activatecrate, "activateCrate");
  }

  _destroynavobstacle();
  destroymountmantlemodel();

  if(istrue(var_0)) {
    destroyminimapicon();
  }

  _destroyheadicon();
  makecrateunusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.deactivatecallback)) {
    self thread[[var_1.deactivatecallback]](var_0);
    return;
  }
}

function capturecrate(var_0) {
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.capturecallback)) {
    self thread[[var_1.capturecallback]](var_0);
  }

  if(var_1.destroyoncapture) {
    var_2 = 0;

    if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var_1.capturevisualscallback]](self.enemymodel);
      }

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
    return;
  }
}

function destroycrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(!isDefined(var_0) && isDefined(self.scenenode)) {
    self.destroyonactivate = 1;
    return;
  }

  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.destroycallback)) {
    self thread[[var_1.destroycallback]](var_0);
  }

  var_2 = 0;

  if(!istrue(var_0)) {
    if(self.physicsactivated) {
      if(isDefined(var_1.destroyvisualscallback)) {
        self thread[[var_1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel)) {
          self thread[[var_1.destroyvisualscallback]](self.enemymodel);
        }

        var_2 = var_1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var_1.capturevisualscallback]](self.enemymodel);
      }

      var_2 = var_1.capturevisualsdeletiondelay;
    }
  }

  thread deletecrate(var_2);
}

function deletecrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(isDefined(self.owner)) {
    self.owner notify("change_loadout_timer");
  }

  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.crate = undefined;
    self.scenenode = undefined;
  }

  removefromlists(self getentitynumber());
  self setCanDamage(0);
  self setnonstick(1);
  self hide();
  makecrateunusable();

  if(isDefined(self.useobject)) {
    self.useobject delete();
  }

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();

  if(self.physicsactivated) {
    self physicsstopserver();
    self physics_unregisterforcollisioncallback();
  }

  self.unresolved_collision_func = undefined;
  destroyminimapicon();
  _destroyheadicon();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  wait var_0;

  if(isDefined(self.friendlymodel)) {
    self.friendlymodel delete();
  }

  if(isDefined(self.enemymodel)) {
    self.enemymodel delete();
  }

  self delete();
}

function watchcratedestroyearly() {
  self endon("death");
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.timeout)) {}

  watchcratedestroyearlyinternal();
  thread destroycrate();
}

function watchcratedestroyearlyinternal(var_0) {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(var_0)) {
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    return;
  }

  if(isDefined(self.owner)) {
    self.owner waittill("change_loadout_timer");
    return;
  }

  level waittill("collected_core");
}

function initcratedropdata() {
  var_0 = spawnStruct();
  var_0.helis = [];
  var_1 = getEnt("airstrikeheight", "targetname");

  if(isDefined(var_1)) {
    var_0.heliheight = var_1.origin[2];
  } else {
    var_0.heliheight = 850;
  }

  var_0.heliheightoffset = 128;
  level.cratedropdata = var_0;
  initscriptedhelidropdata();
}

function initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("");

function initscriptedhelidropanims() {
  level.scr_animtree["care_package"] = #animtree;
  level.scr_anim["care_package"]["care_package_drop"] = $mp_carepackage_ckpg_flyin;
  level.scr_animname["care_package"]["care_package_drop"] = "mp_carepackage_ckpg_flyin";
  level.scr_animtree["care_package_chute"] = #animtree;
  level.scr_anim["care_package_chute"]["care_package_drop"] = % mp_carepackage_parachute_flyin;
  level.scr_animname["care_package_chute"]["care_package_drop"] = "mp_carepackage_parachute_flyin";
  initscriptedhelidropvehicleanims();
}

function initscriptedhelidropvehicleanims() {
  level.scr_animtree["care_package_heli"] = #animtree;
  level.scr_anim["care_package_heli"]["care_package_drop"] = $mp_carepackage_lbravo_flyin;
}

function watchdropcratefrommanualheliinternal() {
  if(self.hasowner) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  self.heli setvehgoalpos(self.dropposition, 1);
  self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 2);

  if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
    thread docratedropfrommanualheli();
    return;
  }

  self.heli setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self.heli.origin, self.dropposition) > 5184) {
    self.heli scripts\engine\utility::ref_143A5("death", "goal");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed)) {
      thread docratedropfrommanualheli();
    }

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      self.heli vehicle_setspeed(50, 30);
      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli scripts\engine\utility::ref_143A5("death", "goal");
      return;
    }

    return;
  }
}

function docratedropfrommanualheli() {
  var_0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  thread activatecratephysics(var_0, &activatecratefirsttime);
}

function dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getcratedropcaststart(var_3, 1);
  var_8 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = getcratedropdestination(var_7, getcratedropcastend(var_7, 1));

    if(!isDefined(var_5)) {
      return undefined;
    }
  }

  var_9 = spawn("script_model", var_7);
  var_9.angles = var_8;
  var_9 setModel("tag_origin");
  var_9.owner = var_0;
  var_9.team = var_1;
  var_9.hasowner = isDefined(var_0);
  var_10 = createheli(var_0, var_1, var_7, var_8);
  var_10.scenenode = var_10;
  var_10 setscriptablepartstate("visibility", "hide", 0);
  var_10.animname = "care_package_heli";
  var_9.heli = var_10;
  var_9.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var_9.latestendtime = var_9.heliendtime;
  var_11 = createcrate(var_0, var_1, var_2, var_7, var_8, var_5, 0, var_6);
  var_11.angles = var_8;
  var_11.scenenode = var_9;
  var_11.friendlymodel setscriptablepartstate("visibility", "hide", 0);

  if(isDefined(var_11.enemymodel)) {
    var_11.enemymodel setscriptablepartstate("visibility", "hide", 0);
  }

  var_11.animname = "care_package";
  var_11 scripts\common\anim::setanimtree();
  var_12 = level.scr_anim["care_package"]["care_package_drop"];
  var_13 = getanimlength(var_12) * 1000;
  var_14 = getnotetracktimes(var_12, "carepackage_drop")[0] * var_13;
  var_15 = getnotetracktimes(var_12, "carepackage_trail_end")[0] * var_13;
  var_9.crate = var_11;
  var_9.cratedroptime = gettime() + var_14;
  var_9.cratestoptrailtime = gettime() + var_15;
  var_9.crateendtime = gettime() + var_13;
  var_9.latestendtime = scripts\engine\utility::ter_op(var_9.crateendtime > var_9.latestendtime, var_9.crateendtime, var_9.latestendtime);
  var_16 = spawn("script_model", var_7);
  var_16.angles = var_8;
  var_16.scenenode = var_9;
  var_16 setModel("infil_parachute");
  var_16 hide();
  var_16.animname = "care_package_chute";
  var_16 scripts\common\anim::setanimtree();
  var_9.chute = var_16;
  var_9.chuteendtime = gettime() + getanimlength(level.scr_anim["care_package_chute"]["care_package_drop"]) * 1000;
  var_9.latestendtime = scripts\engine\utility::ter_op(var_9.chuteendtime > var_9.latestendtime, var_9.chuteendtime, var_9.latestendtime);
  thread watchdropcratefromscriptedheli();
  return var_9;
}

function watchdropcratefromscriptedheli() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.heli, "care_package_drop");
  scripts\common\anim::anim_first_frame_solo(self.crate, "care_package_drop");
  scripts\common\anim::anim_first_frame_solo(self.chute, "care_package_drop");
  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli)) {
    thread destroyheli();
  }

  if(isDefined(self.crate)) {
    thread destroycrate();
  }

  if(isDefined(self.chute)) {
    thread destroychute();
  }

  self delete();
}

function watchdropcratefromscriptedheliinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team) {
              self.ownerjoinedteam = 1;
            }
          }
        } else {
          self.ownerdisconnected = 1;
        }
      }
    }

    if(!isDefined(var_0)) {
      var_0 = 1;
    } else if(var_0) {
      if(isDefined(self.heli)) {
        self.heli setscriptablepartstate("visibility", "show", 0);
        self.heli setscriptablepartstate("lights", "active", 1);
        thread scripts\common\anim::anim_single_solo(self.heli, "care_package_drop");
      }

      if(isDefined(self.crate)) {
        self.crate.friendlymodel setscriptablepartstate("visibility", "show", 0);

        if(isDefined(self.crate.enemymodel)) {
          self.crate.enemymodel setscriptablepartstate("visibility", "show", 0);
        }

        thread scripts\common\anim::anim_single_solo(self.crate, "care_package_drop");
      }

      if(isDefined(self.chute)) {
        self.chute show();
        thread scripts\common\anim::anim_single_solo(self.chute, "care_package_drop");
      }

      var_0 = 0;
    } else {
      var_1 = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);
      var_2 = gettime() > self.cratedroptime;
      var_3 = gettime() > self.cratestoptrailtime;

      if(isDefined(self.heli)) {
        var_4 = gettime() > self.heliendtime;

        if(var_1 || var_4) {
          destroyheli(self.heli);
        }
      }

      if(isDefined(self.crate)) {
        var_4 = gettime() > self.crateendtime;

        if(var_4) {
          thread docratedropfromscriptedheli();
        } else if(var_2) {
          if(var_3) {
            self.crate.friendlymodel setscriptablepartstate("trail", "neutral", 1);

            if(isDefined(self.crate.enemymodel)) {
              self.crate.enemymodel setscriptablepartstate("trail", "neutral", 1);
            }
          } else {
            self.crate.friendlymodel setscriptablepartstate("trail", "active", 1);

            if(isDefined(self.crate.enemymodel)) {
              self.crate.enemymodel setscriptablepartstate("trail", "active", 1);
            }
          }

          if(var_1) {
            thread destroycrate();
          }
        } else if(var_1) {
          thread destroycrate();
        } else if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
          thread docratedropfromscriptedheli();
        }
      }

      if(isDefined(self.chute)) {
        var_4 = gettime() > self.chuteendtime;

        if(var_4) {
          thread destroychute();
        } else if(!var_2 && !isDefined(self.crate)) {
          thread destroychute();
        }
      }
    }

    waitframe();
  }
}

function docratedropfromscriptedheli() {
  var_0 = self.crate;
  self.crate.scenenode = undefined;
  self.crate = undefined;
  var_0 stopanimScripted();
  activatecratephysics(var_0, &activatecratefirsttime, "activate");
}

function destroychute() {
  if(isDefined(self.scenenode)) {
    self.scenenode.chute = undefined;
  }

  self delete();
}

function getcratedropcaststart(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1)) {
    var_2 = var_0 * (1, 1, 1) + (0, 0, getscriptedhelidropheight());
  } else {
    var_2 = var_0 + (0, 0, 25);
  }

  return var_2;
}

function getcratedropcastend(var_0, var_1) {
  return var_0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var_1), 8000, 8000));
}

function getcratedropdestination(var_0, var_1) {
  var_2 = undefined;
  var_3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var_4 = scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
  var_5 = physics_raycast(var_0, var_1, var_3, var_4, 0, "physicsquery_closest", 1);

  if(isDefined(var_5) && var_5.size > 0) {
    var_2 = var_5[0]["position"];
  }

  return var_2;
}

function createheli(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = spawnhelicopter(var_0, var_2, var_3, "veh_airdrop_mp", "veh8_mil_air_lbravo_mp");
  } else {
    var_4 = spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "veh_airdrop_mp", "veh8_mil_air_lbravo_mp");
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  if(isDefined(var_1)) {
    var_4 setvehicleteam(var_1);
  }

  var_5 = level.heliconfigs["airdrop"];
  var_4.owner = var_0;
  var_4.team = var_1;
  var_4.health = var_5.maxhealth;
  var_4.helitype = "airdrop";
  var_4 scripts\cp\utility::killstreak_make_vehicle("veh_airdrop_mp", var_5.scorepopup, var_5.vodestroyed, undefined, var_5.callout);
  var_4 scripts\cp\utility::killstreak_set_death_callback("veh_airdrop_mp", &destroyhelicallback);
  var_4 setCanDamage(0);
  thread watchhelidestroyearly();
  return var_4;
}

function watchhelidestroyearly() {
  self endon("death");
  watchhelidestroyearlyinternal();
  thread destroyheli();
}

function watchhelidestroyearlyinternal() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  level waittill("forever");
}

function destroyheli() {
  thread deleteheli(0);
}

function deleteheli(var_0) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait var_0;
  self delete();
}

function destroyhelicallback(var_0) {
  destroyheli();
}

function getscriptedhelidropheight() {
  return level.cratedropdata.heliheight + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function addhelidroppingcratetolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.helis[var_1] = var_0;
}

function removehelidroppingcratefromlist(var_0) {
  level.cratedropdata.helis[var_0] = undefined;
}

function makecrateusable() {
  var_0 = getleveldata(self.cratetype);
  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var_0.supportsownercapture && var_0.supportsothercapture) {
    thread watchcrateuse(1);
    var_1 = self.useobject;

    if(!isDefined(var_1)) {
      var_1 = spawn("script_model", self gettagorigin(var_0.usetag));
      var_1 setModel("tag_origin");
      var_1 linkTo(self);
      var_1 makeunusable();
      self.useobject = var_1;
    }

    thread watchcrateuse(2, var_1);
    return;
  }

  if(var_0.supportsownercapture) {
    thread watchcrateuse(1);
    return;
  }

  thread watchcrateuse(2);
}

function watchcrateuse(var_0, var_1) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  if(var_0 == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  var_2 = getleveldata(self.cratetype);
  var_3 = gettriggerobject(var_1);
  var_3.usetype = var_0;
  var_3 setCursorHint("HINT_NOICON");
  var_3 sethintonobstruction("show");
  var_3 sethinttag(var_2.usetag);
  var_3 sethintdisplayrange(var_2.userange);
  var_3 sethintdisplayfov(var_2.usefov);
  var_3 setuserange(var_2.userange);
  var_3 setusefov(var_2.usefov);
  var_3 setusepriority(var_2.usepriority);
  var_3 setuseholdduration("duration_none");

  if(var_3.usetype == 1 && self.supportsreroll) {
    var_3 setHintString(self.rerollstring);
  } else {
    var_3 setHintString(self.capturestring);
  }

  var_3.userate = 1;
  var_3.curprogress = 0;
  var_3.usetime = scripts\engine\utility::ter_op(var_0 == 1, var_2.ownerusetime, var_2.otherusetime);
  var_3.inuse = 0;
  var_3.playerusing = undefined;

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(canstartusingcrate(var_4, var_1)) {
      startusingcrate(var_4, var_1);
      var_3.playerusing = var_4;
      var_5 = watchcrateuseinternal(var_4, var_1);

      if(isDefined(var_4)) {
        stopusingcrate(var_4, var_1);
      }

      var_3.playerusing = undefined;

      if(istrue(var_5)) {
        if(var_2.onecaptureperplayer) {
          if(!isDefined(self.playerscaptured)) {
            self.playerscaptured = [];
          }

          self.playerscaptured[var_4 getentitynumber()] = var_4;
        }

        thread capturecrate(var_4);
      }
    }
  }
}

function watchcrateuseinternal(var_0, var_1) {
  var_0 endon("death");
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype != 1) {
    var_0 endon("disconnect");
    var_0 endon("joined_team");
    var_0 endon("joined_spectators");
  }

  var_2.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);

  while(cankeepusingcrate(var_0, var_1) && var_0 useButtonPressed()) {
    var_2.curprogress += level.framedurationseconds * var_2.userate;

    if(var_2.curprogress >= var_2.usetime) {
      return true;
    }

    waitframe();
  }

  return false;
}

function makecrateunusable() {
  self notify("makeCrateUnusable");
  level.cratedata.usablecrates[self getentitynumber()] = undefined;
  self.isusable = 0;

  if(isDefined(self.playerusing)) {
    stopusingcrate(self.playerusing);
  }

  self.playerusing = undefined;
  self makeunusable();

  if(isDefined(self.useobject)) {
    if(isDefined(self.useobject.playerusing)) {
      stopusingcrate(self.useobject.playerusing, self.useobject);
    }

    self.useobject makeunusable();
    return;
  }
}

function startusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);
}

function stopusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);
}

function canstartusingcrate(var_0, var_1, var_2) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0 isonladder()) {
    return 0;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()])) {
    return 0;
  }

  if(!self.isusable) {
    return 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    return canstartusingcratetriggerobject(var_0, var_1);
  }

  return 1;
}

function canstartusingcratetriggerobject(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(isDefined(var_2.playerusing) && var_2.playerusing != var_0) {
    return false;
  }

  if(var_2.usetype == 1 && (!isDefined(self.owner) || var_0 != self.owner)) {
    return false;
  }

  return true;
}

function cankeepusingcrate(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function watchallcrateusability() {
  for(;;) {
    foreach(var_1 in level.cratedata.usablecrates) {
      var_1 makeusable();

      if(isDefined(var_1.useobject)) {
        var_1.useobject makeusable();
      }

      foreach(var_3 in level.players) {
        var_1 enableplayeruse(var_3);

        if(isDefined(var_1.useobject)) {
          var_1.useobject enableplayeruse(var_3);
        }

        if(!canstartusingcrate(var_1, var_3, var_1.useobject, 0)) {
          var_1 disableplayeruse(var_3);

          if(isDefined(var_1.useobject)) {
            var_1.useobject disableplayeruse(var_3);
          }

          continue;
        }

        if(!canstartusingcratetriggerobject(var_1, var_3, undefined)) {
          var_1 disableplayeruse(var_3);
        }

        if(isDefined(var_1.useobject)) {
          if(!canstartusingcratetriggerobject(var_1, var_3, var_1.useobject)) {
            var_1 disableplayeruse(var_3);
          }
        }
      }
    }

    wait 0.1;
  }
}

function gettriggerobject(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, self);
}

function activatecratephysics(var_0, var_1) {
  stophandlingmovingplatforms();
  self.physicsactivated = 1;
  self.unresolved_collision_func = &crateunresolvedcollisioncallback;
  self unlink();
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_2 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_2, (0, 0, -1));
  self physics_registerforcollisioncallback();
  self.dangerzoneid = createdangerzone();
  thread watchcrateimpact();
  thread watchcratesettle(var_0, var_1);
}

function deactivatecratephysics() {
  handlemovingplatforms();

  if(!self.physicsactivated) {
    return;
  }

  self.physicsactivated = 0;
  self notify("deactivateCratePhysics");
  self.unresolved_collision_func = undefined;
  self physicsstopserver();
  self physics_unregisterforcollisioncallback();
  destroydangerzone();
}

function watchcrateimpact() {
  self endon("death");
  self endon("deactivateCratePhysics");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_6 > 500) {
      playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_4, var_5);
    }
  }
}

function watchcratesettle(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  watchcratesettleinternal();

  if(scripts\cp\utility::touchingbadtrigger()) {
    thread destroycrate();
  }

  if(isDefined(var_0)) {
    self thread[[var_0]]();
    return;
  }
}

function watchcratesettleinternal() {
  self endon("deactivateCratePhysics");
  wait 1;
  var_0 = getleveldata(self.cratetype);
  var_1 = gettime() + 10000;

  while(gettime() < var_1) {
    var_2 = self physics_getbodyid(0);
    var_3 = physics_getbodylinvel(var_2);

    if(lengthsquared(var_3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function createdangerzone() {
  destroydangerzone();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;
  self.dangerzoneid = var_1;
  return var_1;
}

function spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  self.dangerzoneid = var_4;
  return var_4;
}

function destroydangerzone() {
  var_0 = self.dangerzoneid;
  self.dangerzoneid = undefined;
}

function _createnavobstacle() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  var_0 = getleveldata(self.cratetype);
  var_1 = createnavobstaclebybounds(self.origin, var_0.navobstaclebounds, self.angles);
  self.navobstacleid = var_1;
  GscBinSkip4(0x35, var_1, self.origin, var_0.navobstacleupdatedistsqr);
}

function _watchnavobstacle(var_0, var_1, var_2) {
  self endon("death");

  while(distancesquared(var_1, self.origin) < var_2) {
    wait 0.5;
  }

  thread _createnavobstacle();
}

function _destroynavobstacle() {
  self notify("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  self.navobstacleid = undefined;
}

function createmountmantlemodel() {
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel)) {
      self.mountmantlemodel delete();
    }

    var_1 = spawn("script_model", self.origin);
    var_1 dontinterpolate();
    var_1.angles = self.angles;
    var_1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var_1 linkTo(self);
    self.mountmantlemodel = var_1;
    return;
  }
}

function destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel)) {
    self.mountmantlemodel delete();
  }

  self.mountmantlemodel = undefined;
}

function crateunresolvedcollisioncallback(var_0) {
  var_0 dodamage(1000, var_0.origin, self.owner, self, "MOD_CRUSH", self.objweapon);
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(isPlayer(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    childthread scripts\cp\cp_movers::unresolved_collision_nearest_node(var_0, undefined, self);
    return;
  }
}

function _createheadicon() {
  if(isDefined(self.headiconid)) {
    setheadiconimage(self.headiconid);
  }

  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {} else if(isDefined(self.owner)) {}
  }

  self.headiconid = var_1;
  self.headiconactive = 1;

  foreach(var_3 in level.players) {
    if(var_3 == self.owner) {
      self hudoutlineenableforclient(var_3, "outlinefill_nodepth_green");
      continue;
    }

    self hudoutlineenableforclient(var_3, "outlinefill_nodepth_red");
  }

  return var_1;
}

function outline_crate_in_hud() {
  foreach(var_1 in level.players) {
    self hudoutlineenableforclient(var_1, "outlinefill_nodepth_green");
  }
}

function _destroyheadicon() {
  if(isDefined(self.boxiconid)) {
    thread scripts\cp\utility::ent_deleteheadicon(self, self.boxiconid);
  }

  if(isDefined(self.headiconid)) {
    setheadiconimage(self.headiconid);
  }

  self hudoutlinedisable();
  self.headiconid = undefined;
  self.headiconactive = 0;
}

function createminimapicon() {
  destroyminimapicon();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.minimapicon)) {}

  self.minimapid = var_1;
  self.minimapiconactive = 1;
  return var_1;
}

function destroyminimapicon() {
  if(isDefined(self.minimapid)) {
    scripts\cp\cp_objectives::returnminimapid(self.minimapid);
  }

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

function handlemovingplatforms() {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
  var_0 = spawnStruct();
  var_0.deathoverridecallback = &onmovingplatformdeath;
  scripts\cp\cp_movers::handle_moving_platforms(var_0);
}

function stophandlingmovingplatforms() {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
}

function onmovingplatformdeath(var_0) {
  self endon("death");
  waitframe();
  deactivatecrate();
}

function watchvisibility() {
  self endon("death");

  foreach(var_1 in level.players) {
    updatevisibilityforplayer(var_1);
  }

  waitframe();
  GscBinSkip4(0x35);
}

function watchvisibilityinternal() {
  for(;;) {
    level waittill("joined_team", var_0);
    updatevisibilityforplayer(var_0);
  }
}

function updatevisibilityforplayer(var_0) {
  self.friendlymodel hidefromplayer(var_0);
  self.enemymodel hidefromplayer(var_0);

  if(var_0.team == "spectator") {
    self.friendlymodel showtoplayer(var_0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var_0.team == self.team) {
      self.friendlymodel showtoplayer(var_0);
      return;
    }

    self.enemymodel showtoplayer(var_0);
    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var_0 == self.owner) {
      self.friendlymodel showtoplayer(var_0);
      return;
    }

    self.enemymodel showtoplayer(var_0);
    return;
  }
}

function looselinkTo(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self.physicsactivated)) {
    self.origin = var_0.origin + var_1;
    waitframe();
  }

  self linkTo(var_0);
}

function addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

function removefromlists(var_0) {
  if(!isDefined(level.cratedata)) {
    return;
  }

  level.cratedata.crates[var_0] = undefined;
}

function getdefaultcapturevisualscallback() {
  return &defaultcapturevisualscallback;
}

#using_animtree("scriptables");

function getdefaultcapturevisualsdeletiondelay() {
  var_0 = 1;
  return var_0 + getanimlength(%mp_military_carepackage_straps_falling);
}

#using_animtree("");

function defaultcapturevisualscallback(var_0) {
  var_0 setscriptablepartstate("anims", "capture", 0);
  var_0 setscriptablepartstate("capture", "start", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(getanimlength(%mp_military_carepackage_straps_falling));
  var_0 setscriptablepartstate("capture", "end", 0);
}

function getdefaultdestroyvisualsdeletiondelay() {
  return false;
}

function getdefaultdestroyvisualscallback() {
  return &defaultdestroyvisualscallback;
}

function defaultdestroyvisualscallback(var_0) {}

function getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

function getcratedatabytype(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.supportsreroll = var_1;
  return var_2;
}

function dropkillstreakcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_7 = getcratedatabytype(var_2, 0);
  var_8 = dropcratefromscriptedheli(var_0, var_1, var_6, var_3, var_4, var_5, var_7);

  if(!isDefined(var_8)) {
    return undefined;
  } else if(!isDefined(var_8.crate)) {
    return undefined;
  }

  return var_8.crate;
}

function fauxvehiclecount() {
  return level.fauxvehiclecount;
}

function incrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0)) {
    level.fauxvehiclecount++;
    return;
  }

  level.fauxvehiclecount += var_0;
}

function decrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0)) {
    level.fauxvehiclecount--;
  } else {
    level.fauxvehiclecount -= var_0;
  }

  if(level.fauxvehiclecount < 0) {
    level.fauxvehiclecount = 0;
    return;
  }
}

function airdropvisualmarkeractivate(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_1 += (0, 0, 1);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("offhand_wm_grenade_smoke");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("script_model", var_1);
  var_3 setModel("ks_crate_marker_mp");
  var_3 setscriptablepartstate("smoke", "on", 0);
  thread delete_model_and_fx_on_crate_drop(var_2, var_3);
}

function delete_model_and_fx_on_crate_drop(var_0, var_1) {
  scripts\engine\utility::ref_143A5("change_loadout_timer", "stop_marker");
  var_0 delete();
  var_1 delete();
}

function register_care_package_interaction() {
  scripts\cp\cp_interaction::register_interaction("care_package_interaction", "null", undefined, &care_package_hint, &care_package_activate, 0, 0, undefined);
}

function care_package_hint(var_0, var_1) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

function care_package_activate(var_0, var_1) {
  var_1 endon("disconnect");
  var_1[[var_0.give_loadout_func]]();
  thread deletecrate(var_0.box);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

function is_player_care_package_owner(var_0, var_1) {
  if(var_1 == var_0.box.owner) {
    return 1;
  }

  return 0;
}

function care_package_createinteraction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "interaction";
  var_1.script_noteworthy = "care_package_interaction";
  var_1.requires_power = 0;
  var_1.box = var_0;
  var_1.spend_type = "null";
  var_1.cost = 0;
  var_1.give_loadout_func = &give_updated_loadout;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0.interaction = var_1;
  return var_0;
}

function give_updated_loadout(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 takeweapon(var_3);
  }

  var_5 = spawnStruct();
  var_6 = var_0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var_7 = scripts\cp\cp_loadout::loadout_updateclasscustom(var_5, var_6);
  give_and_switch_to_loadout_weapons(var_0, var_7);
  var_8 = 1;
  var_9 = scripts\cp\cp_loadout::get_grenade_from_struct(var_7.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_9)) {
    var_9 = "power_frag";
  }

  var_10 = scripts\cp\cp_loadout::get_grenade_from_struct(var_7.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var_10)) {
    var_10 = "power_flash";
  }

  var_11 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var_0 scripts\cp\cp_munitions::reset_munitions(var_0, var_11);
  var_0 thread scripts\cp\cp_powers::givepower(var_9, "primary", undefined, undefined, undefined, undefined, 1, var_8);
  var_0 thread scripts\cp\cp_powers::givepower(var_10, "secondary", undefined, undefined, undefined, undefined, 1, var_8);
}

function give_and_switch_to_loadout_weapons(var_0, var_1) {
  var_1.loadoutprimaryobject = var_0 scripts\cp\cp_loadout::give_primary_weapon(var_0, var_1);
  var_1.loadoutsecondaryobject = var_0 scripts\cp\cp_loadout::give_secondary_weapon(var_0, var_1);
  var_0.starting_weapon = var_1.loadoutprimaryobject;
  var_0.default_starting_pistol = var_1.loadoutsecondaryobject;
  var_2 = weaponclipsize(var_1.loadoutprimaryobject);
  var_3 = weaponmaxammo(var_1.loadoutprimaryobject);
  var_0 giveweapon(var_1.loadoutprimaryobject);
  var_0 setweaponammoclip(var_1.loadoutprimaryobject, var_2);
  var_0 setweaponammostock(var_1.loadoutprimaryobject, var_3);
  var_0 switchtoweaponimmediate(var_1.loadoutprimaryobject);
  var_2 = weaponclipsize(var_1.loadoutsecondaryobject);
  var_3 = weaponmaxammo(var_1.loadoutsecondaryobject);
  var_0 giveweapon(var_1.loadoutsecondaryobject);
  var_0 setweaponammoclip(var_1.loadoutsecondaryobject, var_2);
  var_0 setweaponammostock(var_1.loadoutsecondaryobject, var_3);
  var_0 switchtoweaponimmediate(var_1.loadoutsecondaryobject);
}

function airdrop_trigger_watcher() {
  level notify("airdrop_trigger_watcher");
  level endon("airdrop_trigger_watcher");
  level.airdrop_requests = 0;

  for(;;) {
    level waittill("change_loadout_requested", var_0, var_1, var_2);

    if(is_player_allowed_to_airdrop(var_0)) {
      if(should_allow_airdrop()) {
        var_0.loadout_in_progress = 1;
        airdrop_new_loadout_near_player(var_0);
      } else {
        var_0 iprintln("^1 The Airspace is too Crowded. Please request after some time.");
      }

      continue;
    }

    var_0 iprintln("^1 The player isn't allowed to airdrop at this time because there is a care package currently assigned");
  }
}

function is_player_allowed_to_airdrop(var_0) {
  if(istrue(var_0.loadout_in_progress)) {
    return false;
  }

  return true;
}

function airdrop_new_loadout_near_player(var_0, var_1) {
  var_2 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = var_0.origin;
  }

  var_3 = (var_2[0], var_2[1], 1000);
  var_4 = vectortoangles(var_2);

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    thread dropkillstreakcratefromscriptedheli(var_0, "allies", "random", var_3, var_4, var_2);
    return;
  }

  thread dropkillstreakcratefromscriptedheli(var_0, var_0.team, "random", var_3, var_4, var_2);
}

function should_allow_airdrop() {
  var_0 = allow_airdrop_internal();

  if(istrue(var_0)) {
    return true;
  }

  return false;
}

function allow_airdrop_internal() {
  var_0 = 0;

  if(!isDefined(level.airdrop_requests)) {
    level.airdrop_requests = 0;
  }

  if(level.airdrop_requests > 4) {
    return false;
  }

  increment_airdrop_requests();
  return true;
}

function increment_airdrop_requests() {
  level.airdrop_requests++;
  iprintln("^1 Airdrop Requests Increased! - ^4" + level.airdrop_requests);
}

function decrement_airdrop_requests() {
  level.airdrop_requests--;
  iprintln("^1 Airdrop Requests Increased! - ^4" + level.airdrop_requests);
}

function support_box_spawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_1;
  var_0.mpstreaksysteminfo = var_2;
  var_0.mpstreaksysteminfo.attackerisinflictor = gettime();
  return var_0;
}