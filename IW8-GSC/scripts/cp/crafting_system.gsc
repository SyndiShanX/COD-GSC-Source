/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\crafting_system.gsc
***********************************************/

function init_craftingsystem(var0) {
  readcraftingmaterialstable();
  var1 = getdvarint("scr_start_points_override", 0);

  if(var1 != 0) {
    level.starting_currency = var1;
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

function getcraftingmaterialmax(var0, var1) {
  var2 = 10;

  switch (var0) {
    case "metal":
      var2 = 66000;
      break;
    case "wood":
      var2 = 66000;
      break;
    case "explosive":
      var2 = 66000;
      break;
    case "wire":
      var2 = 66000;
      break;
    case "battery":
      var2 = 66000;
      break;
    case "emradiation":
      var2 = 66000;
      break;
    case "circuitboard":
      var2 = 66000;
      break;
    case "colordye":
      var2 = 66000;
      break;
    case "sentry":
      var2 = 66000;
      break;
    case "drone":
      var2 = 66000;
      break;
  }

  if(var1.perk_data["increased_materials_wallet"]) {
    var2 *= 2;
  }

  return var2;
}

function readcraftingmaterialstable() {
  var0 = "cp/cp_munitiontable.csv";
  level.crafting_table_data = [];

  for(var1 = 1; var1 <= 17; var1++) {
    var2 = table_look_up(var0, var1, 1);
    level.crafting_table_data[var2] = spawnStruct();
    level.crafting_table_data[var2].crafteditemindex = var1;
    level.crafting_table_data[var2].crafteditem = var2;
    level.crafting_table_data[var2].crafteditemmodel = table_look_up(var0, var1, 2);
    level.crafting_table_data[var2].crafteditempowerreference = table_look_up(var0, var1, 3);
    level.crafting_table_data[var2].icon = table_look_up(var0, var1, 4);
    level.crafting_table_data[var2].stringref = table_look_up(var0, var1, 5);
    level.crafting_table_data[var2].crafteditemtype = table_look_up(var0, var1, 6);
    level.crafting_table_data[var2].blueprintref = table_look_up(var0, var1, 7);
    level.crafting_table_data[var2].metal = int(table_look_up(var0, var1, 8));
    level.crafting_table_data[var2].wood = int(table_look_up(var0, var1, 9));
    level.crafting_table_data[var2].explosive = int(table_look_up(var0, var1, 10));
    level.crafting_table_data[var2].wire = int(table_look_up(var0, var1, 11));
    level.crafting_table_data[var2].battery = int(table_look_up(var0, var1, 12));
    level.crafting_table_data[var2].emradiation = int(table_look_up(var0, var1, 13));
    level.crafting_table_data[var2].circuitboard = int(table_look_up(var0, var1, 14));
    level.crafting_table_data[var2].colordye = int(table_look_up(var0, var1, 15));
    level.crafting_table_data[var2].sentry = int(table_look_up(var0, var1, 16));
    level.crafting_table_data[var2].drone = int(table_look_up(var0, var1, 17));
  }
}

function table_look_up(var0, var1, var2) {
  return tablelookup(var0, 0, var1, var2);
}

function throwcrate(var0) {
  self endon("disconnect");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("ges_plyr_gesture005")) {
    waitframe();
  }

  var1 = "";

  switch (var0.weapon_name) {
    case "iw8_ammo_marker_cp":
      var1 = "ammo_crate";
      break;
    case "iw8_armor_marker_cp":
      var1 = "armor";
      break;
    case "iw8_adrenaline_marker_cp":
      var1 = "adrenaline";
      break;
    case "iw8_health_marker_cp":
      var1 = "health_pack";
      var1 = "grenade_crate";
      break;
  }

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, var1, var0, var0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

function throwammocrate(var0) {
  self endon("disconnect");
  scripts\cp\cp_powers::power_disablepower();

  while(self isgestureplaying("ges_plyr_gesture005")) {
    waitframe();
  }

  scripts\cp\cp_deployablebox::begindeployableviamarker(undefined, "support_box", var0, var0.weapon_name);
  scripts\cp\cp_powers::power_enablepower();
}

function getitemslot(var0) {
  foreach(var2 in level.crafting_table_data) {
    if(var0 == var2.blueprintref) {
      return var2.crafteditemtype;
    }
  }
}

function remove_crafted_item_from_slot(var0, var1) {}

function isspecialcrafteditem(var0) {
  if(var0 == "Sentry Turret" || var0 == "Night Vision Goggles") {
    return 1;
  }

  return 0;
}

function givecrafteditemthruluinotify(var0) {
  self endon("disconnect");
  var1 = tablelookup("cp/cp_munitiontable.csv", 0, var0, 1);
  var2 = level.crafting_table_data[var1].crafteditemtype;
  var3 = level.crafting_table_data[var1].crafteditempowerreference;
  var4 = scripts\cp\cp_powers::what_power_is_in_slot("primary");

  if(isDefined(var4)) {
    if(self.powers[var4].charges >= self.powers[var4].maxcharges && var3 == var4) {
      return;
    }
  }

  if(isspecialcrafteditem(var1)) {
    if(var1 == "Sentry Turret") {
      thread scripts\cp\cp_weapon_autosentry::test_crafted_sentry(self);
    }

    if(var1 == "Night Vision Goggles") {
      spendcraftedmaterials(level.crafting_table_data[var1]);
      thread scripts\cp\equipment\nvg::runnvg();
    }
  }

  switch (var2) {
    case "up_dpad":
      self.crafteditemstruct.bdpadup = 1;
      self.crafteditemstruct.dpadup = level.crafting_table_data[var1];
      break;
    case "down_dpad":
      self.crafteditemstruct.bdpaddown = 1;
      self.crafteditemstruct.dpaddown = level.crafting_table_data[var1];
      break;
    case "left_dpad":
      self.crafteditemstruct.bdpadleft = 1;
      self.crafteditemstruct.dpadleft = level.crafting_table_data[var1];
      break;
    case "right_dpad":
      self.crafteditemstruct.bdpadright = 1;
      self.crafteditemstruct.dpadright = level.crafting_table_data[var1];
      break;
  }

  if(var2 == "primary" || var2 == "secondary") {
    var5 = undefined;

    if(self.perk_data["additional_crafting_items"]) {
      var5 = 1;
    }

    spendcraftedmaterials(level.crafting_table_data[var1]);
    scripts\cp\cp_powers::givepower(var3, var2, undefined, undefined, var5, 0, 1);
  }

  if(var2 == "direct") {
    spendcraftedmaterials(level.crafting_table_data[var1]);

    if(var1 == "Armor") {
      scripts\cp\cp_armor::givearmor(self, 100);
    }

    if(var1 == "Health Pack") {
      give_health_pack(self, 50);
      return;
    }

    return;
  }
}

function giveitembasedoncraftingstruct(var0) {
  var1 = 1;

  switch (var0) {
    case "respawn":
      if(scripts\cp\utility::turn_off_sniper_laser()) {
        if(!scripts\cp\cp_laststand::buystationsusepaddingdistribution() && (!isDefined(level.players_in_respawn_queue) || level.players_in_respawn_queue.size == 0)) {
          scripts\cp\utility::hint_prompt("revive_teammates_fail", 1, 2);
          break;
        } else {
          scriptable_autouse_funcs();
          thread ref_12c8c(level);
          var2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("respawn_flare", self);
          scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var2);
          self notify("munitions_used", "respawn");
          break;
        }
      }

      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(level.players_in_respawn_queue.size == 0) {
        self iprintln(" NO Players to respawn!! ");
      } else {
        level.respawn_in_progress = 1;
        scriptable_autouse_funcs();
        scripts\cp\respawn\cp_ac130_respawn::start_ac130_respawn_sequence(self.origin, level.players_in_respawn_queue, self);
        var2 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("respawn_flare", self);
        scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var2);
        self notify("munitions_used", "respawn");

        foreach(var4 in level.players) {
          var4 thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn", undefined, self);
        }

        level.respawn_in_progress = undefined;
        LOC_00000160:
      }

      LOC_00000160:
        break;
    case "apache":
    case "chopper_gunner":
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(scripts\cp\cp_weapon::ref_124ad(self)) {
        scripts\cp\cp_weapon::minigamefinishcount(self);
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
      break;
    case "ammo_crate":
      var6 = giveammocrate();

      if(!istrue(var6)) {
        return 0;
      }

      break;
    case "ac130":
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(isDefined(level.ac130_activate_function)) {
        self notify("attempt_use_gunship");
        var6 = self[[level.ac130_activate_function]]();

        if(!istrue(var6)) {
          return 0;
        }
      }

      break;
    case "precision_airstrike":
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
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
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      var7 = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(istrue(var7)) {
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
      var0 = 0;
      self notify("one_watcher_for_removing_deployables");
      giveriotshield();
      break;
    case "grenade_launcher":
      var0 = 0;
      self notify("one_watcher_for_removing_deployables");
      givegrenadelauncher();
      break;
    case "armor":
      var6 = givearmorcrate();

      if(!istrue(var6)) {
        return 0;
      }

      break;
    case "adrenaline":
      var6 = giveadrenalinecrate();

      if(!istrue(var6)) {
        return 0;
      }

      break;
    case "health_pack":
    case "grenade_crate":
      var6 = givehealthcrate();

      if(!istrue(var6)) {
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
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      return scripts\cp_mp\killstreaks\uav::tryuseuav("uav");
    case "deployable_cover":
      var6 = give_deployable_cover();

      if(!istrue(var6)) {
        return 0;
      }

      break;
    case "cluster_strike":
    case "toma_strike":
      if(istrue(level.ref_11e8c) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
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

  if(var0) {
    thread watcherforremovingdeployable();
  }

  return 1;
}

function give_grenade(var0, var1) {
  var2 = scripts\cp\cp_loadout::get_num_of_charges_for_power(self);
  thread scripts\cp\cp_powers::givepower(var0, var1, undefined, undefined, undefined, undefined, 1, var2);
}

function can_purchase_item(var0) {
  var1 = scripts\cp\cp_persistence::get_player_currency();

  if(var1 >= var0) {
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
      var0 = scripts\cp\utility::getweapontoswitchbackto();
      self switchtoweapon(var0);
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

function scorerequiresbanking(var0) {
  self endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  self giveandfireoffhand(var0);
  var1 = scripts\engine\utility::ref_143ae("offhand_fired", "weapon_fired", "offhand_end");

  if(var1 == "offhand_end") {
    return undefined;
  }

  return 1;
}

function scriptable_autouse_funcs() {
  self.tispawnposition = self.origin;
  self giveandfireoffhand("flare_mp");
}

function ref_12c8b(var0) {
  var0 hide();

  if(!isDefined(self.tispawnposition)) {
    return false;
  }

  if(scripts\cp\utility::touchingbadtrigger()) {
    return false;
  }

  var1 = self.tispawnposition + (0, 0, 16);
  var2 = self.tispawnposition - (0, 0, 2048);
  var3 = [];
  GscBinSkip0(0x2e, 0, self);
}

function ref_14316(var0) {
  self endon("death");
  wait var0;
  thread tacinsert_destroy(1);
}

function tacinsert_destroy(var0) {
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

  if(istrue(var0)) {
    self setscriptablepartstate("destroy", "active", 0);
    self setscriptablepartstate("visibility", "hide", 0);
  }

  thread tacinsert_delayeddelete();
}

function tacinsert_delayeddelete() {
  wait 1;
  self delete();
}

function ref_12c8c(var0) {
  level endon("game_ended");
  var1 = "cp_super_revive_used";
  var2 = [];

  foreach(var4 in level.players) {
    if(istrue(var4.inlaststand) && !istrue(var4.clear_prev_goal)) {
      var4 scripts\cp\cp_laststand::instant_revive(var4);
      scripts\cp\cp_armor::givearmor(var4, 100, 1);
    } else if(istrue(var4.clear_prev_goal) || isDefined(var4.last_stand_state) && istrue(var4.last_stand_state == "bleed_out")) {
      var2 = var4;
    }

    var4 thread scripts\cp\cp_hud_message::showsplash(var1, undefined, var0);
  }

  if(var2.size > 0) {
    wait 5;

    foreach(var4 in var2) {
      if(isDefined(var4) && isPlayer(var4)) {
        var4 notify("revive_success");
        scripts\cp\cp_armor::givearmor(var4, 100, 1);
      }
    }

    return;
  }
}

function giveriotshield() {
  self.riot_shield_damage = 1000;
  self.last_weapon = self getcurrentweapon();

  if(!istrue(self.has_riot_shield)) {
    var0 = "iw8_me_riotshield_mp";
    var1 = getcompleteweaponname(var0);
    scripts\cp\utility::_giveweapon(var1);
    scripts\cp\cp_weapons::switchtoweaponreliable(var1);
    self.has_riot_shield = 1;
    thread remove_at_shield_death(var0, 0);
  }

  self notify("munitions_used", "riot_shield");
}

function remove_at_shield_death(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var2 = undefined;
  var3 = self getweaponslist("primary");

  foreach(var5 in var3) {
    if(var5.basename == var0) {
      var2 = var5;
      break;
    }
  }

  if(isDefined(var2)) {
    while(self.riot_shield_damage > var1) {
      waitframe();
    }

    self.riot_shield_broken = 1;

    if(isDefined(self.riotshieldmodel)) {
      scripts\cp\utility::riotshield_detach(1);
    } else if(isDefined(self.riotshieldmodelstowed)) {
      scripts\cp\utility::riotshield_detach(0);
    }

    wait 1;
    self takeweapon(var2);
    self switchtoweapon(self.last_weapon);
    self.has_riot_shield = undefined;
    self.riot_shield_broken = undefined;
    return;
  }
}

function givegrenadelauncher() {
  self.last_weapon = self getcurrentweapon();
  jumpiffalse(istrue(self.has_gl)) LOC_00000061;
  var0 = self.equippedweapons;

  foreach(var2 in var0) {
    if(var2.basename == "iw8_la_mike32_mp") {
      var3 = weaponclipsize(var2);
      self setweaponammoclip(var2, var3);
    }
  }

  goto LOC_000000b7;
}

function remove_at_ammo_count(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_removed");
  var2 = undefined;
  var3 = self getweaponslist("primary");

  foreach(var5 in var3) {
    if(var5.basename == var0) {
      var2 = var5;
      break;
    }
  }

  if(isDefined(var2)) {
    for(;;) {
      var7 = self getammocount(var2);

      if(var7 <= var1) {
        break;
      }

      waitframe();
    }

    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
    self takeweapon(var2);
    var8 = scripts\cp\utility::getweapontoswitchbackto();
    var9 = thread scripts\cp\cp_weapons::switchtoweaponreliable(var8, 0);
    self.has_gl = undefined;
    self notify("weapon_removed");
    return;
  }
}

function give_deployable_cover() {
  if(self isthrowinggrenade()) {
    return;
  }

  var0 = "tac_cover_mp";
  self.ref_12879 = self getcurrentweapon();
  self giveweapon(var0);
  self switchtoweapon(var0);
  self notifyonplayercommand("equip_deploy_end", "+weapnext");
  self notifyonplayercommand("equip_deploy_end", "+weapprev");
  self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
  }

  scripts\common\utility::allow_melee(0);
  var1 = fire_deployable_cover();

  if(istrue(var1)) {
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
  scripts\cp\powers\cp_tactical_cover::ref_139f3();
}

function fire_deployable_cover() {
  self endon("equip_deploy_end");
  self endon("last_stand");
  self endon("death_or_disconnect");
  var0 = scripts\cp\cp_weapon::waittill_grenade_fire();

  if(isDefined(var0.weapon_name) && var0.weapon_name == "tac_cover_mp") {
    var1 = scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired_super();

    if(istrue(var1)) {
      thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(var0);
      scripts\common\utility::allow_melee(1);

      foreach(var3 in level.players) {
        var3 thread scripts\cp\cp_hud_message::showsplash("cp_used_deployable_cover", undefined, self);
      }

      self notify("munitions_used", "deployable_cover");
      return 1;
    }
  }

  self notify("deploy_cover_failed");
  return undefined;
}

function give_health_pack(var0, var1) {
  var0 endon("disconnect");
  var0 endon("death");
  var0 forceplaygestureviewmodel("ges_equip_nanoshot");
  wait var0 getgestureanimlength("ges_equip_nanoshot");
  thread playfxonplayer();
  var0.health = int(min(var0.health + var1, var0.maxhealth));

  if(getdvarint("enable_segmented_health_regen", 0) == 1) {
    scripts\cp\utility::set_current_health_regen_segment(var0, scripts\cp\utility::find_new_health_regen_segment_ceiling(var0));
    return;
  }
}

function playfxonplayer() {
  var0 = spawnfxforclient(level._effect["health_pack_activated"], self gettagorigin("tag_eye"), self);
  triggerfx(var0);
  scripts\engine\utility::waittill_notify_or_timeout("disconnect", self getgestureanimlength("ges_equip_nanoshot") + 2);
  var0 delete();
}

function spendcraftedmaterials(var0) {
  var1 = self getplayerdata("cp", "playerMaterialsList", "metal");
  var2 = self getplayerdata("cp", "playerMaterialsList", "wood");
  var3 = self getplayerdata("cp", "playerMaterialsList", "explosive");
  var4 = self getplayerdata("cp", "playerMaterialsList", "wire");
  var5 = self getplayerdata("cp", "playerMaterialsList", "battery");
  var6 = self getplayerdata("cp", "playerMaterialsList", "emradiation");
  var7 = self getplayerdata("cp", "playerMaterialsList", "circuitboard");
  var8 = self getplayerdata("cp", "playerMaterialsList", "colordye");
  var9 = self getplayerdata("cp", "playerMaterialsList", "sentry");
  var10 = self getplayerdata("cp", "playerMaterialsList", "drone");
  var11 = decrease_material_amount(var1, var0.metal);
  var12 = decrease_material_amount(var2, var0.wood);
  var13 = decrease_material_amount(var3, var0.explosive);
  var14 = decrease_material_amount(var4, var0.wire);
  var15 = decrease_material_amount(var5, var0.battery);
  var16 = decrease_material_amount(var6, var0.emradiation);
  var17 = decrease_material_amount(var7, var0.circuitboard);
  var18 = decrease_material_amount(var8, var0.colordye);
  var19 = decrease_material_amount(var9, var0.sentry, 1);
  var20 = decrease_material_amount(var10, var0.drone, 1);
  self setplayerdata("cp", "playerMaterialsList", "metal", var11);
  self setplayerdata("cp", "playerMaterialsList", "wood", var12);
  self setplayerdata("cp", "playerMaterialsList", "explosive", var13);
  self setplayerdata("cp", "playerMaterialsList", "wire", var14);
  self setplayerdata("cp", "playerMaterialsList", "battery", var15);
  self setplayerdata("cp", "playerMaterialsList", "emradiation", var16);
  self setplayerdata("cp", "playerMaterialsList", "circuitboard", var17);
  self setplayerdata("cp", "playerMaterialsList", "colordye", var18);
  self setplayerdata("cp", "playerMaterialsList", "sentry", var19);
  self setplayerdata("cp", "playerMaterialsList", "drone", var20);
  self.personalcraftingmaterialslist["metal"] = var11;
  self.personalcraftingmaterialslist["wood"] = var12;
  self.personalcraftingmaterialslist["explosive"] = var13;
  self.personalcraftingmaterialslist["wire"] = var14;
  self.personalcraftingmaterialslist["battery"] = var15;
  self.personalcraftingmaterialslist["emradiation"] = var16;
  self.personalcraftingmaterialslist["circuitboard"] = var17;
  self.personalcraftingmaterialslist["colordye"] = var18;
  self.personalcraftingmaterialslist["sentry"] = var19;
  self.personalcraftingmaterialslist["drone"] = var20;
}

function getuniquematerialscost(var0) {
  if(level.crafting_table_data[var0].wood > 0) {
    return level.crafting_table_data[var0].wood;
  }

  if(level.crafting_table_data[var0].explosive > 0) {
    return level.crafting_table_data[var0].explosive;
  }

  if(level.crafting_table_data[var0].wire > 0) {
    return level.crafting_table_data[var0].wire;
  }

  if(level.crafting_table_data[var0].battery > 0) {
    return level.crafting_table_data[var0].battery;
  }

  if(level.crafting_table_data[var0].emradiation > 0) {
    return level.crafting_table_data[var0].emradiation;
  }

  if(level.crafting_table_data[var0].circuitboard > 0) {
    return level.crafting_table_data[var0].circuitboard;
  }

  if(level.crafting_table_data[var0].colordye > 0) {
    return level.crafting_table_data[var0].colordye;
  }

  if(level.crafting_table_data[var0].sentry > 0) {
    return level.crafting_table_data[var0].sentry;
  }

  if(level.crafting_table_data[var0].drone > 0) {
    return level.crafting_table_data[var0].drone;
  }
}

function decrease_material_amount(var0, var1, var2) {
  if(var1 > 1 && !isDefined(var2)) {
    var1 -= self.perk_data["cheap_crafting_recipe"];
  }

  var3 = var0 - var1;
  return var3;
}

function init() {
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
  initkillstreak();
  initheli();
  initcratedata();
}

function drop_marker_after_time() {
  var0 = 30;

  while(var0 >= 0) {
    iprintln(" Dropping a Crate with changed loadout in ^1" + var0);
    var0--;
    wait 1;
  }

  var1 = level.players[0];
  var2 = var1.origin + (0, 0, 666);
  var3 = var1.angles;
  airdropvisualmarkeractivate(var1.origin);
  thread dropkillstreakcratefromscriptedheli(var1, var1.team, "random", var2, var1.angles, var1.origin);
}

function initkillstreak() {}

function initheli() {
  level.littlebirds = [];
  level.heliconfigs = [];
  var0 = "airdrop";
  var1 = spawnStruct();
  var1.canbedamaged = 1;
  var1.maxhealth = 500;
  var1.hitstokill = 3;
  var1.vodestroyed = "dronedrop_destroyed";
  var1.callout = "callout_destroyed_airdrop";
  var1.enginevfxtag = "tag_engine_left";
  level.heliconfigs[var0] = var1;
}

function initcratedata() {
  var0 = spawnStruct();
  var0.configs = [];
  var0.crates = [];
  var0.usablecrates = [];
  level.cratedata = var0;
  level.mpplayerallowcrateuse = &scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");
  initcratedropdata();
  thread watchallcrateusability();
}

function getleveldata(var0) {
  var1 = level.cratedata.configs[var0];

  if(!isDefined(var1)) {
    var1 = getemptyleveldata();
    level.cratedata.configs[var0] = var1;
  }

  return var1;
}

function getemptyleveldata() {
  var0 = spawnStruct();
  var0.friendlymodel = "military_carepackage_01_friendly";
  var0.enemymodel = "military_carepackage_01_enemy";
  var0.dummymodel = "military_carepackage_01_dummy";
  var0.mountmantlemodel = getdefaultmountmantlemodel();
  var0.objweapon = isundefinedweapon();
  var0.timeout = 90;
  var0.headiconoffset = 0;
  var0.minimapicon = "icon_minimap_drone_package_friendly";
  var0.usetag = "tag_use";
  var0.userange = 128;
  var0.usefov = 360;
  var0.usepriority = -10000;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 1;
  var0.navobstaclebounds = (30, 10, 64);
  var0.navobstacleupdatedistsqr = 64;
  var0.dangerzoneheight = 1000;
  var0.dangerzoneradius = 200;
  var0.activatecallback = undefined;
  var0.deactivatecallback = undefined;
  var0.capturecallback = undefined;
  var0.rerollcallback = undefined;
  var0.destroycallback = undefined;
  var0.destroyoncapture = 1;
  var0.onecaptureperplayer = 0;
  var0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var0.capturevisualscallback = getdefaultcapturevisualscallback();
  var0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var0.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var0.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  var0.headicon = "icon_ks_box_of_guns";
  var0.supportsreroll = 0;
  var0.supportsownercapture = 1;
  var0.supportsothercapture = 1;
  return var0;
}

function createcrate(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = getleveldata(var2);
  var9 = spawn("script_model", var3);
  var9.angles = var4;

  if(var9 scripts\cp\utility::touchingbadtrigger()) {
    var9 delete();
    var0 notify("change_loadout_timer");
    return undefined;
  }

  var9.owner = var0;
  var9.team = var1;
  var9.objweapon = var8.objweapon;
  var9.cratetype = var2;
  var9.useobject = undefined;
  var9.navobstacle = undefined;
  var9.headiconid = undefined;
  var9.minimapid = undefined;
  var9.dangerzoneid = undefined;
  var9.navobstacleid = undefined;
  var9.destination = var5;
  var9.headiconactive = 0;
  var9.minimapiconactive = 0;
  var9.physicsactivated = 0;
  var9.isdestroyed = 0;
  var9.data = var7;
  var9.headicon = var8.headicon;
  var9.minimapicon = var8.minimapicon;
  var9.capturestring = var8.capturestring;
  var9.rerollstring = var8.rerollstring;
  var9.supportsreroll = var8.supportsreroll;
  var9 setModel(var8.dummymodel);
  var9 setnodeploy(1);
  var9 setCanDamage(0);
  var9 makeunusable();
  var10 = spawn("script_model", var3);
  var10.angles = var4;
  var10.crate = var9;
  var10 setModel(var8.friendlymodel);
  var10 linkTo(var9);
  var9.friendlymodel = var10;
  var11 = undefined;

  if(isDefined(var8.enemymodel)) {
    if(level.teambased) {}

    var11 = spawn("script_model", var3);
    var11.angles = var4;
    var11.cratedata = var9;
    var11 setModel(var8.enemymodel);
    var11 linkTo(var9);
  }

  var9.enemymodel = var11;

  if(isDefined(var9.enemymodel)) {
    thread watchvisibility();
  }

  var12 = undefined;
  var12 = spawn("script_model", var3 + (0, 0, 300));
  var12 setscriptmoverkillcam("explosive");

  if(isDefined(self.scenenode)) {
    if(var6) {
      thread looselinkTo(var12, var9);
    } else {
      var12 linkTo(var9);
    }
  }

  var9.killcament = var12;
  addtolists(var9);
  thread watchcratedestroyearly();

  if(var6) {
    activatecratephysics(var9, &activatecratefirsttime, "activateCrate");
  }

  return var9;
}

function activatecratefirsttime() {
  activatecrate(1);
}

function activatecrate(var0) {
  self notify("activateCrate");
  deactivatecratephysics();

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  createmountmantlemodel();

  if(istrue(var0)) {
    createminimapicon();
  }

  outline_crate_in_hud();

  if(isDefined(level.nuclear_crate_interaction)) {
    self.crate_interaction = [[level.nuclear_crate_interaction]](self);
  }

  level.nuclear_crate = self.crate_interaction;
  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.activatecallback)) {
    self thread[[var1.activatecallback]](var0);
    return;
  }
}

function deactivatecrate(var0) {
  if(!istrue(var0)) {
    activatecratephysics(&activatecrate, "activateCrate");
  }

  _destroynavobstacle();
  destroymountmantlemodel();

  if(istrue(var0)) {
    destroyminimapicon();
  }

  _destroyheadicon();
  makecrateunusable();
  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.deactivatecallback)) {
    self thread[[var1.deactivatecallback]](var0);
    return;
  }
}

function capturecrate(var0) {
  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.capturecallback)) {
    self thread[[var1.capturecallback]](var0);
  }

  if(var1.destroyoncapture) {
    var2 = 0;

    if(isDefined(var1.capturevisualscallback)) {
      self thread[[var1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var1.capturevisualscallback]](self.enemymodel);
      }

      var2 = var1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var2);
    return;
  }
}

function destroycrate(var0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(!isDefined(var0) && isDefined(self.scenenode)) {
    self.destroyonactivate = 1;
    return;
  }

  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.destroycallback)) {
    self thread[[var1.destroycallback]](var0);
  }

  var2 = 0;

  if(!istrue(var0)) {
    if(self.physicsactivated) {
      if(isDefined(var1.destroyvisualscallback)) {
        self thread[[var1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel)) {
          self thread[[var1.destroyvisualscallback]](self.enemymodel);
        }

        var2 = var1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var1.capturevisualscallback)) {
      self thread[[var1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var1.capturevisualscallback]](self.enemymodel);
      }

      var2 = var1.capturevisualsdeletiondelay;
    }
  }

  thread deletecrate(var2);
}

function deletecrate(var0) {
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

  wait var0;

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
  var0 = getleveldata(self.cratetype);

  if(isDefined(var0.timeout)) {}

  watchcratedestroyearlyinternal();
  thread destroycrate();
}

function watchcratedestroyearlyinternal(var0) {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(var0)) {
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var0);
    return;
  }

  if(isDefined(self.owner)) {
    self.owner waittill("change_loadout_timer");
    return;
  }

  level waittill("collected_core");
}

function initcratedropdata() {
  var0 = spawnStruct();
  var0.helis = [];
  var1 = getEnt("airstrikeheight", "targetname");

  if(isDefined(var1)) {
    var0.heliheight = var1.origin[2];
  } else {
    var0.heliheight = 850;
  }

  var0.heliheightoffset = 128;
  level.cratedropdata = var0;
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
    self.heli scripts\engine\utility::ref_143a5("death", "goal");

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
      self.heli scripts\engine\utility::ref_143a5("death", "goal");
      return;
    }

    return;
  }
}

function docratedropfrommanualheli() {
  var0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  thread activatecratephysics(var0, &activatecratefirsttime);
}

function dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6) {
  var7 = getcratedropcaststart(var3, 1);
  var8 = var4 * (0, 1, 0);

  if(!isDefined(var5)) {
    var5 = getcratedropdestination(var7, getcratedropcastend(var7, 1));

    if(!isDefined(var5)) {
      return undefined;
    }
  }

  var9 = spawn("script_model", var7);
  var9.angles = var8;
  var9 setModel("tag_origin");
  var9.owner = var0;
  var9.team = var1;
  var9.hasowner = isDefined(var0);
  var10 = createheli(var0, var1, var7, var8);
  var10.scenenode = var10;
  var10 setscriptablepartstate("visibility", "hide", 0);
  var10.animname = "care_package_heli";
  var9.heli = var10;
  var9.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var9.latestendtime = var9.heliendtime;
  var11 = createcrate(var0, var1, var2, var7, var8, var5, 0, var6);
  var11.angles = var8;
  var11.scenenode = var9;
  var11.friendlymodel setscriptablepartstate("visibility", "hide", 0);

  if(isDefined(var11.enemymodel)) {
    var11.enemymodel setscriptablepartstate("visibility", "hide", 0);
  }

  var11.animname = "care_package";
  var11 scripts\common\anim::setanimtree();
  var12 = level.scr_anim["care_package"]["care_package_drop"];
  var13 = getanimlength(var12) * 1000;
  var14 = getnotetracktimes(var12, "carepackage_drop")[0] * var13;
  var15 = getnotetracktimes(var12, "carepackage_trail_end")[0] * var13;
  var9.crate = var11;
  var9.cratedroptime = gettime() + var14;
  var9.cratestoptrailtime = gettime() + var15;
  var9.crateendtime = gettime() + var13;
  var9.latestendtime = scripts\engine\utility::ter_op(var9.crateendtime > var9.latestendtime, var9.crateendtime, var9.latestendtime);
  var16 = spawn("script_model", var7);
  var16.angles = var8;
  var16.scenenode = var9;
  var16 setModel("infil_parachute");
  var16 hide();
  var16.animname = "care_package_chute";
  var16 scripts\common\anim::setanimtree();
  var9.chute = var16;
  var9.chuteendtime = gettime() + getanimlength(level.scr_anim["care_package_chute"]["care_package_drop"]) * 1000;
  var9.latestendtime = scripts\engine\utility::ter_op(var9.chuteendtime > var9.latestendtime, var9.chuteendtime, var9.latestendtime);
  thread watchdropcratefromscriptedheli();
  return var9;
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
  var0 = undefined;

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

    if(!isDefined(var0)) {
      var0 = 1;
    } else if(var0) {
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

      var0 = 0;
    } else {
      var1 = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);
      var2 = gettime() > self.cratedroptime;
      var3 = gettime() > self.cratestoptrailtime;

      if(isDefined(self.heli)) {
        var4 = gettime() > self.heliendtime;

        if(var1 || var4) {
          destroyheli(self.heli);
        }
      }

      if(isDefined(self.crate)) {
        var4 = gettime() > self.crateendtime;

        if(var4) {
          thread docratedropfromscriptedheli();
        } else if(var2) {
          if(var3) {
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

          if(var1) {
            thread destroycrate();
          }
        } else if(var1) {
          thread destroycrate();
        } else if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
          thread docratedropfromscriptedheli();
        }
      }

      if(isDefined(self.chute)) {
        var4 = gettime() > self.chuteendtime;

        if(var4) {
          thread destroychute();
        } else if(!var2 && !isDefined(self.crate)) {
          thread destroychute();
        }
      }
    }

    waitframe();
  }
}

function docratedropfromscriptedheli() {
  var0 = self.crate;
  self.crate.scenenode = undefined;
  self.crate = undefined;
  var0 stopanimScripted();
  activatecratephysics(var0, &activatecratefirsttime, "activate");
}

function destroychute() {
  if(isDefined(self.scenenode)) {
    self.scenenode.chute = undefined;
  }

  self delete();
}

function getcratedropcaststart(var0, var1) {
  var2 = undefined;

  if(istrue(var1)) {
    var2 = var0 * (1, 1, 1) + (0, 0, getscriptedhelidropheight());
  } else {
    var2 = var0 + (0, 0, 25);
  }

  return var2;
}

function getcratedropcastend(var0, var1) {
  return var0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var1), 8000, 8000));
}

function getcratedropdestination(var0, var1) {
  var2 = undefined;
  var3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var4 = scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
  var5 = physics_raycast(var0, var1, var3, var4, 0, "physicsquery_closest", 1);

  if(isDefined(var5) && var5.size > 0) {
    var2 = var5[0]["position"];
  }

  return var2;
}

function createheli(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(var0) && isPlayer(var0)) {
    var4 = spawnhelicopter(var0, var2, var3, "veh_airdrop_mp", "veh8_mil_air_lbravo_mp");
  } else {
    var4 = spawnhelicopter(level.players[randomint(level.players.size)], var2, var3, "veh_airdrop_mp", "veh8_mil_air_lbravo_mp");
  }

  if(!isDefined(var4)) {
    return undefined;
  }

  if(isDefined(var1)) {
    var4 setvehicleteam(var1);
  }

  var5 = level.heliconfigs["airdrop"];
  var4.owner = var0;
  var4.team = var1;
  var4.health = var5.maxhealth;
  var4.helitype = "airdrop";
  var4 scripts\cp\utility::killstreak_make_vehicle("veh_airdrop_mp", var5.scorepopup, var5.vodestroyed, undefined, var5.callout);
  var4 scripts\cp\utility::killstreak_set_death_callback("veh_airdrop_mp", &destroyhelicallback);
  var4 setCanDamage(0);
  thread watchhelidestroyearly();
  return var4;
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

function deleteheli(var0) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait var0;
  self delete();
}

function destroyhelicallback(var0) {
  destroyheli();
}

function getscriptedhelidropheight() {
  return level.cratedropdata.heliheight + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function addhelidroppingcratetolist(var0) {
  var1 = var0 getentitynumber();
  level.cratedropdata.helis[var1] = var0;
}

function removehelidroppingcratefromlist(var0) {
  level.cratedropdata.helis[var0] = undefined;
}

function makecrateusable() {
  var0 = getleveldata(self.cratetype);
  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var0.supportsownercapture && var0.supportsothercapture) {
    thread watchcrateuse(1);
    var1 = self.useobject;

    if(!isDefined(var1)) {
      var1 = spawn("script_model", self gettagorigin(var0.usetag));
      var1 setModel("tag_origin");
      var1 linkTo(self);
      var1 makeunusable();
      self.useobject = var1;
    }

    thread watchcrateuse(2, var1);
    return;
  }

  if(var0.supportsownercapture) {
    thread watchcrateuse(1);
    return;
  }

  thread watchcrateuse(2);
}

function watchcrateuse(var0, var1) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(var1)) {
    var1 endon("death");
  }

  if(var0 == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  var2 = getleveldata(self.cratetype);
  var3 = gettriggerobject(var1);
  var3.usetype = var0;
  var3 setCursorHint("HINT_NOICON");
  var3 sethintonobstruction("show");
  var3 sethinttag(var2.usetag);
  var3 sethintdisplayrange(var2.userange);
  var3 sethintdisplayfov(var2.usefov);
  var3 setuserange(var2.userange);
  var3 setusefov(var2.usefov);
  var3 setusepriority(var2.usepriority);
  var3 setuseholdduration("duration_none");

  if(var3.usetype == 1 && self.supportsreroll) {
    var3 setHintString(self.rerollstring);
  } else {
    var3 setHintString(self.capturestring);
  }

  var3.userate = 1;
  var3.curprogress = 0;
  var3.usetime = scripts\engine\utility::ter_op(var0 == 1, var2.ownerusetime, var2.otherusetime);
  var3.inuse = 0;
  var3.playerusing = undefined;

  for(;;) {
    var3 waittill("trigger", var4);

    if(canstartusingcrate(var4, var1)) {
      startusingcrate(var4, var1);
      var3.playerusing = var4;
      var5 = watchcrateuseinternal(var4, var1);

      if(isDefined(var4)) {
        stopusingcrate(var4, var1);
      }

      var3.playerusing = undefined;

      if(istrue(var5)) {
        if(var2.onecaptureperplayer) {
          if(!isDefined(self.playerscaptured)) {
            self.playerscaptured = [];
          }

          self.playerscaptured[var4 getentitynumber()] = var4;
        }

        thread capturecrate(var4);
      }
    }
  }
}

function watchcrateuseinternal(var0, var1) {
  var0 endon("death");
  var2 = gettriggerobject(var1);

  if(var2.usetype != 1) {
    var0 endon("disconnect");
    var0 endon("joined_team");
    var0 endon("joined_spectators");
  }

  var2.userate = scripts\engine\utility::ter_op(isDefined(var0.objectivescaler), var0.objectivescaler, 1);

  while(cankeepusingcrate(var0, var1) && var0 useButtonPressed()) {
    var2.curprogress += level.framedurationseconds * var2.userate;

    if(var2.curprogress >= var2.usetime) {
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

function startusingcrate(var0, var1) {
  var2 = gettriggerobject(var1);
  var3 = getleveldata(self.cratetype);
}

function stopusingcrate(var0, var1) {
  var2 = gettriggerobject(var1);
  var3 = getleveldata(self.cratetype);
}

function canstartusingcrate(var0, var1, var2) {
  if(!var0 scripts\common\utility::is_crate_use_allowed()) {
    return 0;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var0 isonladder()) {
    return 0;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var0 getentitynumber()])) {
    return 0;
  }

  if(!self.isusable) {
    return 0;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    return canstartusingcratetriggerobject(var0, var1);
  }

  return 1;
}

function canstartusingcratetriggerobject(var0, var1) {
  var2 = gettriggerobject(var1);

  if(isDefined(var2.playerusing) && var2.playerusing != var0) {
    return false;
  }

  if(var2.usetype == 1 && (!isDefined(self.owner) || var0 != self.owner)) {
    return false;
  }

  return true;
}

function cankeepusingcrate(var0, var1) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var0 meleeButtonPressed()) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function watchallcrateusability() {
  for(;;) {
    foreach(var1 in level.cratedata.usablecrates) {
      var1 makeusable();

      if(isDefined(var1.useobject)) {
        var1.useobject makeusable();
      }

      foreach(var3 in level.players) {
        var1 enableplayeruse(var3);

        if(isDefined(var1.useobject)) {
          var1.useobject enableplayeruse(var3);
        }

        if(!canstartusingcrate(var1, var3, var1.useobject, 0)) {
          var1 disableplayeruse(var3);

          if(isDefined(var1.useobject)) {
            var1.useobject disableplayeruse(var3);
          }

          continue;
        }

        if(!canstartusingcratetriggerobject(var1, var3, undefined)) {
          var1 disableplayeruse(var3);
        }

        if(isDefined(var1.useobject)) {
          if(!canstartusingcratetriggerobject(var1, var3, var1.useobject)) {
            var1 disableplayeruse(var3);
          }
        }
      }
    }

    wait 0.1;
  }
}

function gettriggerobject(var0) {
  return scripts\engine\utility::ter_op(isDefined(var0), var0, self);
}

function activatecratephysics(var0, var1) {
  stophandlingmovingplatforms();
  self.physicsactivated = 1;
  self.unresolved_collision_func = &crateunresolvedcollisioncallback;
  self unlink();
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var2 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var2, (0, 0, -1));
  self physics_registerforcollisioncallback();
  self.dangerzoneid = createdangerzone();
  thread watchcrateimpact();
  thread watchcratesettle(var0, var1);
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
    self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);

    if(var6 > 500) {
      playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var4, var5);
    }
  }
}

function watchcratesettle(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    self endon(var1);
  }

  watchcratesettleinternal();

  if(scripts\cp\utility::touchingbadtrigger()) {
    thread destroycrate();
  }

  if(isDefined(var0)) {
    self thread[[var0]]();
    return;
  }
}

function watchcratesettleinternal() {
  self endon("deactivateCratePhysics");
  wait 1;
  var0 = getleveldata(self.cratetype);
  var1 = gettime() + 10000;

  while(gettime() < var1) {
    var2 = self physics_getbodyid(0);
    var3 = physics_getbodylinvel(var2);

    if(lengthsquared(var3) <= 0.5) {
      break;
    }

    waitframe();
  }
}

function createdangerzone() {
  destroydangerzone();
  var0 = getleveldata(self.cratetype);
  var1 = undefined;
  self.dangerzoneid = var1;
  return var1;
}

function spawnuniversaldangerzone(var0, var1, var2, var3) {
  var4 = undefined;
  self.dangerzoneid = var4;
  return var4;
}

function destroydangerzone() {
  var0 = self.dangerzoneid;
  self.dangerzoneid = undefined;
}

function _createnavobstacle() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  var0 = getleveldata(self.cratetype);
  var1 = createnavobstaclebybounds(self.origin, var0.navobstaclebounds, self.angles);
  self.navobstacleid = var1;
  GscBinSkip4(0x35, var1, self.origin, var0.navobstacleupdatedistsqr);
}

function _watchnavobstacle(var0, var1, var2) {
  self endon("death");

  while(distancesquared(var1, self.origin) < var2) {
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
  var0 = getleveldata(self.cratetype);

  if(isDefined(var0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel)) {
      self.mountmantlemodel delete();
    }

    var1 = spawn("script_model", self.origin);
    var1 dontinterpolate();
    var1.angles = self.angles;
    var1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var1 linkTo(self);
    self.mountmantlemodel = var1;
    return;
  }
}

function destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel)) {
    self.mountmantlemodel delete();
  }

  self.mountmantlemodel = undefined;
}

function crateunresolvedcollisioncallback(var0) {
  var0 dodamage(1000, var0.origin, self.owner, self, "MOD_CRUSH", self.objweapon);
  self endon("death");
  var0 endon("death");
  var0 endon("disconnect");

  if(isPlayer(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    childthread scripts\cp\cp_movers::unresolved_collision_nearest_node(var0, undefined, self);
    return;
  }
}

function _createheadicon() {
  if(isDefined(self.headiconid)) {
    setheadiconimage(self.headiconid);
  }

  var0 = getleveldata(self.cratetype);
  var1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {} else if(isDefined(self.owner)) {}
  }

  self.headiconid = var1;
  self.headiconactive = 1;

  foreach(var3 in level.players) {
    if(var3 == self.owner) {
      self hudoutlineenableforclient(var3, "outlinefill_nodepth_green");
      continue;
    }

    self hudoutlineenableforclient(var3, "outlinefill_nodepth_red");
  }

  return var1;
}

function outline_crate_in_hud() {
  foreach(var1 in level.players) {
    self hudoutlineenableforclient(var1, "outlinefill_nodepth_green");
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
  var0 = getleveldata(self.cratetype);
  var1 = undefined;

  if(isDefined(self.minimapicon)) {}

  self.minimapid = var1;
  self.minimapiconactive = 1;
  return var1;
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
  var0 = spawnStruct();
  var0.deathoverridecallback = &onmovingplatformdeath;
  scripts\cp\cp_movers::handle_moving_platforms(var0);
}

function stophandlingmovingplatforms() {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
}

function onmovingplatformdeath(var0) {
  self endon("death");
  waitframe();
  deactivatecrate();
}

function watchvisibility() {
  self endon("death");

  foreach(var1 in level.players) {
    updatevisibilityforplayer(var1);
  }

  waitframe();
  GscBinSkip4(0x35);
}

function watchvisibilityinternal() {
  for(;;) {
    level waittill("joined_team", var0);
    updatevisibilityforplayer(var0);
  }
}

function updatevisibilityforplayer(var0) {
  self.friendlymodel hidefromplayer(var0);
  self.enemymodel hidefromplayer(var0);

  if(var0.team == "spectator") {
    self.friendlymodel showtoplayer(var0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var0.team == self.team) {
      self.friendlymodel showtoplayer(var0);
      return;
    }

    self.enemymodel showtoplayer(var0);
    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var0 == self.owner) {
      self.friendlymodel showtoplayer(var0);
      return;
    }

    self.enemymodel showtoplayer(var0);
    return;
  }
}

function looselinkTo(var0, var1, var2) {
  self endon("death");
  var0 endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self.physicsactivated)) {
    self.origin = var0.origin + var1;
    waitframe();
  }

  self linkTo(var0);
}

function addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

function removefromlists(var0) {
  if(!isDefined(level.cratedata)) {
    return;
  }

  level.cratedata.crates[var0] = undefined;
}

function getdefaultcapturevisualscallback() {
  return &defaultcapturevisualscallback;
}

#using_animtree("scriptables");

function getdefaultcapturevisualsdeletiondelay() {
  var0 = 1;
  return var0 + getanimlength(%mp_military_carepackage_straps_falling);
}

#using_animtree("");

function defaultcapturevisualscallback(var0) {
  var0 setscriptablepartstate("anims", "capture", 0);
  var0 setscriptablepartstate("capture", "start", 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(getanimlength(%mp_military_carepackage_straps_falling));
  var0 setscriptablepartstate("capture", "end", 0);
}

function getdefaultdestroyvisualsdeletiondelay() {
  return false;
}

function getdefaultdestroyvisualscallback() {
  return &defaultdestroyvisualscallback;
}

function defaultdestroyvisualscallback(var0) {}

function getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

function getcratedatabytype(var0, var1) {
  var2 = spawnStruct();
  var2.streakname = var0;
  var2.supportsreroll = var1;
  return var2;
}

function dropkillstreakcratefromscriptedheli(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var7 = getcratedatabytype(var2, 0);
  var8 = dropcratefromscriptedheli(var0, var1, var6, var3, var4, var5, var7);

  if(!isDefined(var8)) {
    return undefined;
  } else if(!isDefined(var8.crate)) {
    return undefined;
  }

  return var8.crate;
}

function fauxvehiclecount() {
  return level.fauxvehiclecount;
}

function incrementfauxvehiclecount(var0) {
  if(!isDefined(var0)) {
    level.fauxvehiclecount++;
    return;
  }

  level.fauxvehiclecount += var0;
}

function decrementfauxvehiclecount(var0) {
  if(!isDefined(var0)) {
    level.fauxvehiclecount--;
  } else {
    level.fauxvehiclecount -= var0;
  }

  if(level.fauxvehiclecount < 0) {
    level.fauxvehiclecount = 0;
    return;
  }
}

function airdropvisualmarkeractivate(var0) {
  var1 = scripts\engine\utility::drop_to_ground(var0, 50, -200, (0, 0, 1));
  var1 += (0, 0, 1);
  var2 = spawn("script_model", var1);
  var2 setModel("offhand_wm_grenade_smoke");
  var2.angles = (0, 90, 90);
  var3 = spawn("script_model", var1);
  var3 setModel("ks_crate_marker_mp");
  var3 setscriptablepartstate("smoke", "on", 0);
  thread delete_model_and_fx_on_crate_drop(var2, var3);
}

function delete_model_and_fx_on_crate_drop(var0, var1) {
  scripts\engine\utility::ref_143a5("change_loadout_timer", "stop_marker");
  var0 delete();
  var1 delete();
}

function register_care_package_interaction() {
  scripts\cp\cp_interaction::register_interaction("care_package_interaction", "null", undefined, &care_package_hint, &care_package_activate, 0, 0, undefined);
}

function care_package_hint(var0, var1) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

function care_package_activate(var0, var1) {
  var1 endon("disconnect");
  var1[[var0.give_loadout_func]]();
  thread deletecrate(var0.box);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
}

function is_player_care_package_owner(var0, var1) {
  if(var1 == var0.box.owner) {
    return 1;
  }

  return 0;
}

function care_package_createinteraction(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.targetname = "interaction";
  var1.script_noteworthy = "care_package_interaction";
  var1.requires_power = 0;
  var1.box = var0;
  var1.spend_type = "null";
  var1.cost = 0;
  var1.give_loadout_func = &give_updated_loadout;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var1);
  var0.interaction = var1;
  return var0;
}

function give_updated_loadout(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    var0 takeweapon(var3);
  }

  var5 = spawnStruct();
  var6 = var0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var7 = scripts\cp\cp_loadout::loadout_updateclasscustom(var5, var6);
  give_and_switch_to_loadout_weapons(var0, var7);
  var8 = 1;
  var9 = scripts\cp\cp_loadout::get_grenade_from_struct(var7.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var9)) {
    var9 = "power_frag";
  }

  var10 = scripts\cp\cp_loadout::get_grenade_from_struct(var7.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, var10)) {
    var10 = "power_flash";
  }

  var11 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var0 scripts\cp\cp_munitions::reset_munitions(var0, var11);
  var0 thread scripts\cp\cp_powers::givepower(var9, "primary", undefined, undefined, undefined, undefined, 1, var8);
  var0 thread scripts\cp\cp_powers::givepower(var10, "secondary", undefined, undefined, undefined, undefined, 1, var8);
}

function give_and_switch_to_loadout_weapons(var0, var1) {
  var1.loadoutprimaryobject = var0 scripts\cp\cp_loadout::give_primary_weapon(var0, var1);
  var1.loadoutsecondaryobject = var0 scripts\cp\cp_loadout::give_secondary_weapon(var0, var1);
  var0.starting_weapon = var1.loadoutprimaryobject;
  var0.default_starting_pistol = var1.loadoutsecondaryobject;
  var2 = weaponclipsize(var1.loadoutprimaryobject);
  var3 = weaponmaxammo(var1.loadoutprimaryobject);
  var0 giveweapon(var1.loadoutprimaryobject);
  var0 setweaponammoclip(var1.loadoutprimaryobject, var2);
  var0 setweaponammostock(var1.loadoutprimaryobject, var3);
  var0 switchtoweaponimmediate(var1.loadoutprimaryobject);
  var2 = weaponclipsize(var1.loadoutsecondaryobject);
  var3 = weaponmaxammo(var1.loadoutsecondaryobject);
  var0 giveweapon(var1.loadoutsecondaryobject);
  var0 setweaponammoclip(var1.loadoutsecondaryobject, var2);
  var0 setweaponammostock(var1.loadoutsecondaryobject, var3);
  var0 switchtoweaponimmediate(var1.loadoutsecondaryobject);
}

function airdrop_trigger_watcher() {
  level notify("airdrop_trigger_watcher");
  level endon("airdrop_trigger_watcher");
  level.airdrop_requests = 0;

  for(;;) {
    level waittill("change_loadout_requested", var0, var1, var2);

    if(is_player_allowed_to_airdrop(var0)) {
      if(should_allow_airdrop()) {
        var0.loadout_in_progress = 1;
        airdrop_new_loadout_near_player(var0);
      } else {
        var0 iprintln("^1 The Airspace is too Crowded. Please request after some time.");
      }

      continue;
    }

    var0 iprintln("^1 The player isn't allowed to airdrop at this time because there is a care package currently assigned");
  }
}

function is_player_allowed_to_airdrop(var0) {
  if(istrue(var0.loadout_in_progress)) {
    return false;
  }

  return true;
}

function airdrop_new_loadout_near_player(var0, var1) {
  var2 = (0, 0, 0);

  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = var0.origin;
  }

  var3 = (var2[0], var2[1], 1000);
  var4 = vectortoangles(var2);

  if(!isDefined(var0) || !isPlayer(var0)) {
    thread dropkillstreakcratefromscriptedheli(var0, "allies", "random", var3, var4, var2);
    return;
  }

  thread dropkillstreakcratefromscriptedheli(var0, var0.team, "random", var3, var4, var2);
}

function should_allow_airdrop() {
  var0 = allow_airdrop_internal();

  if(istrue(var0)) {
    return true;
  }

  return false;
}

function allow_airdrop_internal() {
  var0 = 0;

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

function support_box_spawn(var0, var1) {
  var2 = spawnStruct();
  var2.streakname = var1;
  var0.mpstreaksysteminfo = var2;
  var0.mpstreaksysteminfo.attackerisinflictor = gettime();
  return var0;
}