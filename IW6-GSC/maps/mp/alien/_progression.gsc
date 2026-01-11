/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_progression.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\alien\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_persistence;

MAX_CURRENCY = 6000;
ACTION_SLOT_MAX_FREQUENCY = 0.2;

main() {
  maps\mp\alien\_perks::init_perks();

  maps\mp\alien\_combat_resources::init_combat_resources();
}

player_setup() {
  self SetActionSlot(1, "");
  self SetActionSlot(2, "");
  self SetActionSlot(3, "");
  self SetActionSlot(4, "");

  self NotifyOnPlayerCommand("action_slot_1", "+actionslot 1");
  self NotifyOnPlayerCommand("action_slot_2", "+actionslot 2");
  self NotifyOnPlayerCommand("action_slot_3", "+actionslot 3");
  self NotifyOnPlayerCommand("action_slot_4", "+actionslot 4");
  self NotifyOnPlayerCommand("action_slot_1", "+actionslot 5");
  self NotifyOnPlayerCommand("action_slot_2", "+actionslot 6");
  self NotifyOnPlayerCommand("action_slot_3", "+actionslot 7");
  self NotifyOnPlayerCommand("action_use", "+attack");
  self NotifyOnPlayerCommand("action_use", "+attack_akimbo_accessible");
  self NotifyOnPlayerCommand("change_weapon", "weapnext");

  self thread player_watcher();
}

player_watcher() {
  if(can_use_munition()) {
    self thread player_action_slot(level.alien_combat_resources["munition"][self get_selected_dpad_up()], ::get_dpad_up_level, "action_slot_1");
    self thread player_action_slot(level.alien_combat_resources["support"][self get_selected_dpad_down()], ::get_dpad_down_level, "action_slot_2");
  }
  if(can_use_ability()) {
    self thread player_action_slot(level.alien_combat_resources["defense"][self get_selected_dpad_left()], ::get_dpad_left_level, "action_slot_3");
    self thread player_action_slot(level.alien_combat_resources["offense"][self get_selected_dpad_right()], ::get_dpad_right_level, "action_slot_4");
  }
  self thread player_watch_upgrade();

  if(!is_chaos_mode()) {
    self thread player_watch_currency_transfer();
  }
}

can_use_munition() {
  if(is_chaos_mode()) {
    return false;
  }

  if(self maps\mp\alien\_prestige::prestige_getNoDeployables() == 1.0) {
    return false;
  }

  return true;
}

can_use_ability() {
  if(self maps\mp\alien\_prestige::prestige_getNoAbilities() == 1.0) {
    return false;
  }

  return true;
}

player_watch_upgrade() {
  self thread player_watch_dpad_upgrade(level.alien_combat_resources["munition"][self get_selected_dpad_up()]);
  self thread player_watch_dpad_upgrade(level.alien_combat_resources["support"][self get_selected_dpad_down()]);
  self thread player_watch_dpad_upgrade(level.alien_combat_resources["defense"][self get_selected_dpad_left()]);
  self thread player_watch_dpad_upgrade(level.alien_combat_resources["offense"][self get_selected_dpad_right()]);

  self thread player_watch_perk_upgrade(level.alien_perks["perk_0"][self get_selected_perk_0()], "perk_0");
  self thread player_watch_perk_upgrade(level.alien_perks["perk_1"][self get_selected_perk_1()], "perk_1");
}

player_watch_dpad_upgrade(resource) {
  self player_watch_upgrade_internal(resource, resource.type);
}

player_watch_perk_upgrade(resource, slot) {
  self thread player_watch_upgrade_internal(resource, slot);
  self thread player_handle_perk_upgrades(resource, slot);
}

player_watch_upgrade_internal(resource, type) {
  self endon("disconnect");
  level endon("game_ended");

  notifyname = type + "_try_upgrade";
  while(true) {
    self waittillmatch("luinotifyserver", notifyname);
    rank = self get_upgrade_level(type);

    if((rank + 1 < resource.upgrades.size) && self try_take_player_points(resource.upgrades[rank + 1].point_cost)) {
      rank += 1;
      self set_upgrade_level(type, rank);
      self notify("upgrade_" + type);

      self thread update_resource_stats("upgrade", resource.ref, 1);

      maps\mp\alien\_alien_matchdata::record_perk_upgrade(resource.ref);

      cyclenum = -1;
      if(isDefined(level.current_cycle_num)) {
        cyclenum = level.current_cycle_num;
      }

      playername = "unknown";
      if(isDefined(self.name)) {
        playername = self.name;
      }

      hivename = "unknown";
      if(isDefined(level.current_hive_name)) {
        hivename = level.current_hive_name;
      }

      if(GetDvarInt("alien_bbprint_debug") > 0) {
        IPrintLnBold("^8bbprint: aliencombatresourceupgraded \n" +
          " cyclenum=" + cyclenum +
          " hivename=" + hivename +
          " resource=" + resource.ref +
          " resourcelevel=" + rank +
          " ownername=" + playername);
      }

      bbprint("aliencombatresourceupgraded",
        "cyclenum %i hivename %s resource %s resourcelevel %s ownername %s ",
        cyclenum,
        hivename,
        resource.ref,
        rank,
        playername);

    }
  }
}

get_perk_ref_at_upgrade_level(perk_type, perk_ref, upgrade_level) {
  return (level.alien_perks[perk_type][perk_ref].upgrades[upgrade_level].ref);
}

player_handle_perk_upgrades(resource, type) {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("upgrade_" + type);
    rank = self get_upgrade_level(type);
    assert(rank > 0);
    unset_perk(get_perk_ref_at_upgrade_level(type, resource.ref, rank - 1));
    set_perk(get_perk_ref_at_upgrade_level(type, resource.ref, rank));

    secondaryPerk = get_selected_perk_0_secondary();
    if(type == "perk_0" && secondaryPerk != "perk_none") {
      secondaryResource = level.alien_perks["perk_0"][secondaryPerk];
      unset_perk(get_perk_ref_at_upgrade_level(type, secondaryResource.ref, rank - 1));
      set_perk(get_perk_ref_at_upgrade_level(type, secondaryResource.ref, rank));
    }
  }
}

restore_all_perks() {
  perK_0_ref = self get_selected_perk_0();
  perk_0_level = self get_perk_0_level();
  set_perk(get_perk_ref_at_upgrade_level("perk_0", perK_0_ref, perk_0_level));

  secondaryPerk = get_selected_perk_0_secondary();
  if(secondaryPerk != "perk_none") {
    secondaryResource = level.alien_perks["perk_0"][secondaryPerk];
    set_perk(get_perk_ref_at_upgrade_level("perk_0", secondaryResource.ref, perk_0_level));
  }
}

player_cancel() {
  self player_cancel_internal();

  self EnableWeapons();

  self.alien_used_resource = undefined;
}

player_cancel_internal() {
  self endon("player_action_slot_restart");
  self endon("fired_ability_gun");

  self waittill_any("change_weapon", "action_slot_1", "action_slot_2", "action_slot_3", "action_slot_4", "last_stand", "dpad_cancel");
  if(self is_holding_deployable() && !self.is_holding_crate_marker) {
    if(!isDefined(self.playerLinkedToChopper) || !self.playerLinkedToChopper) {
      self.deployable = false;
      self notify("cancel_deployable_via_marker");
      if(!self HasWeapon("mortar_detonator_mp") && !self HasWeapon("switchblade_laptop_mp")) {
        self notify("player_action_slot_restart");
      }
    }
  }
  resource = self.alien_used_resource;
  rank = self.alien_used_resource_rank;
  self[[resource.callbacks.CancelUse]](resource, rank);

  self notify("player_action_slot_restart");
}

player_watch_use() {
  self endon("cancel_watch");
  self waittill("action_use");
  return true;
}

player_watch_riotshield_use(resource, rank) {
  self endon("cancel_watch");
  self _disableUsability();
  self thread reenable_usability(3.1);
  self waittill_any_timeout(3, "action_use", "riotshield_block", "riotshield_melee");

  if(self player_has_enough_currency(Ceil(resource.upgrades[rank].cost))) {
    return true;
  } else {
    self[[resource.callbacks.CancelUse]](resource, rank);
    self notify("action_finish_used");
    self notify("player_action_slot_restart");
    return false;
  }
}

player_watch_equalizer_use(resource, rank) {
  self endon("cancel_watch");
  self waittill_any_timeout(3, "action_use");
  if(self player_has_enough_currency(Ceil(resource.upgrades[rank].cost))) {
    return true;
  } else {
    self[[resource.callbacks.CancelUse]](resource, rank);
    self notify("action_finish_used");
    self notify("player_action_slot_restart");
    return false;
  }
}

player_watch_use_manned_turret() {
  self endon("cancel_watch");

  while(1) {
    self waittill("action_use");
    if(isDefined(self.carriedSentry)) {
      if(is_true(self.carriedSentry.canbeplaced)) {
        return true;
      }
    }
  }
}

player_watch_use_ims() {
  self endon("disconnect");
  self endon("cancel_watch");

  self waittill("IMS_placed");

  return true;
}

player_watch_use_sentry() {
  self endon("disconnect");
  self endon("cancel_watch");
  assertex(isDefined(self.current_sentry), "Sentry ent not set on owner holding it");

  for(;;) {
    self waittill("action_use");

    if(isDefined(self.current_sentry)) {
      canBePlaced = self maps\mp\alien\_autosentry_alien::can_place_sentry(self.current_sentry);
      if(canBePlaced) {
        return true;
      }
    }

    wait(0.05);
  }
}

player_use(resource, rank) {
  self endon("player_action_slot_restart");
  self endon("disconnect");
  level endon("game_ended");

  self thread player_cancel();

  self[[resource.callbacks.TryUse]](resource, rank);

  if(self[[resource.callbacks.CanUse]](resource)) {
    if(!show_alternate_spend_hint(resource)) {
      self thread maps\mp\alien\_hud::createSpendHintHUD(resource, rank);
    } else {
      self thread maps\mp\alien\_hud::createSpendHintHUD(resource, rank, &"ALIENS_PATCH_CANCEL_USE");
    }

    usage = wait_for_use(resource, rank);
    if(!isDefined(usage) || !usage) {
      return;
    }

    if(!self player_has_enough_currency(Ceil(resource.upgrades[rank].cost))) {
      self notify("dpad_cancel");
      return;
    }

    self PlayLocalSound("alien_killstreak_equip");
    self thread[[resource.callbacks.Use]](resource, rank);

    self thread update_resource_stats("purchase", resource.ref, 1);

    self take_player_currency(Ceil(resource.upgrades[rank].cost), false, "ability");

    self.alien_used_resource = undefined;

    cyclenum = -1;
    if(isDefined(level.current_cycle_num)) {
      cyclenum = level.current_cycle_num;
    }

    playername = "unknown";
    if(isDefined(self.name)) {
      playername = self.name;
    }

    hivename = "unknown";
    if(isDefined(level.current_hive_name)) {
      hivename = level.current_hive_name;
    }

    if(GetDvarInt("alien_bbprint_debug") > 0) {
      IPrintLnBold("^8bbprint: aliencombatresourceused \n" +
        " cyclenum=" + cyclenum +
        " hivename=" + hivename +
        " resource=" + resource.ref +
        " resourcelevel=" + rank +
        " ownername=" + playername);
    }

    bbprint("aliencombatresourceused",
      "cyclenum %i hivename %s resource %s resourcelevel %s ownername %s ",
      cyclenum,
      hivename,
      resource.ref,
      rank,
      playername);

    self notify("action_finish_used");
    self notify("player_action_slot_restart");
  }
}

show_alternate_spend_hint(resource) {
  if(level_uses_MAAWS() && IsSubStr(resource.ref, "predator")) {
    return true;
  }

  return (IsSubStr(resource.ref, "turret") || isSubStr(resource.ref, "_ims"));
}

wait_for_use(resource, rank) {
  switch (resource.ref) {
    case "dpad_sentry":
      return player_watch_use_sentry();

    case "dpad_minigun_turret":
    case "dpad_gl_sentry":
      return player_watch_use_manned_turret();

    case "dpad_ims":
      return player_watch_use_ims();

    case "dpad_team_ammo_reg":
    case "dpad_team_armor":
    case "dpad_team_boost":
    case "dpad_team_adrenaline":
    case "dpad_team_explosives":
    case "dpad_team_randombox":
    case "dpad_team_ammo_stun":
    case "dpad_team_ammo_explo":
    case "dpad_team_ammo_ap":
    case "dpad_team_ammo_in":
    case "dpad_placeholder_ammo_2":
      return player_watch_box_thrown();

    case "dpad_riotshield":
      return player_watch_riotshield_use(resource, rank);

    case "dpad_war_machine":
    case "dpad_death_machine":
      return player_watch_equalizer_use(resource, rank);

    case "dpad_predator":

      if(level_uses_MAAWS()) {
        return player_watch_equalizer_use(resource, rank);
      }

    default:
      return player_watch_use();
  }
}

player_watch_box_thrown() {
  self endon("cancel_watch");
  while(true) {
    self waittill("grenade_fire", item_thrown, weapon_name);

    if(weapon_name == "aliendeployable_crate_marker_mp") {
      return true;
    }
  }
}

player_action_slot_internal(resource, get_rank_func, waittillname) {
  self endon("player_action_slot_block");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill(waittillname);

    if(is_true(self.player_action_disabled)) {
      continue;
    }

    if(self UseButtonPressed()) {
      continue;
    }
    if(self IsOnLadder()) {
      continue;
    }
    if(self has_special_weapon()) {
      self setLowerMessage("cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HAS_SPECIALWEAPON", 3);
      continue;
    }

    if(is_true(self.picking_up_item)) {
      continue;
    }
    if(self IsUsingTurret()) {
      continue;
    }

    if(is_true(self.hasprogressbar)) {
      continue;
    }

    if(is_true(self.isCarrying)) {
      continue;
    }

    if(isDefined(self.throwingGrenade)) {
      continue;
    }

    if(flag_exist("escape_conditions_met") && flag("escape_conditions_met")) {
      continue;
    }
    rank = self[[get_rank_func]]();

    if(!self player_has_enough_currency(Ceil(resource.upgrades[rank].cost))) {
      continue;
    }
    self _DisableUsability();
    self thread reenable_usability();

    if(!isDefined(self.alien_used_resource)) {
      if(self[[resource.callbacks.CanPurchase]](resource, rank)) {
        self.alien_used_resource = resource;
        self.alien_used_resource_rank = rank;
        self thread player_use(resource, rank);
        self notify("player_action_slot_block");
      }
    }
  }
}

reenable_usability(wait_time) {
  self endon("disconnect");
  if(!isDefined(wait_time)) {
    wait_time = 1;
  }

  wait(wait_time);
  self _enableUsability();
}

player_action_slot(resource, get_dpad_level_func, dpad_notify_name) {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self thread player_action_slot_internal(resource, get_dpad_level_func, dpad_notify_name);
    self waittill("player_action_slot_restart");
    wait ACTION_SLOT_MAX_FREQUENCY;
  }
}

player_watch_currency_transfer() {
  self endon("disconnect");
  level endon("game_ended");

  wait 0.05;

  if(isPlayingSolo()) {
    return;
  }
  currency_rank = 0;

  while(1) {
    if(self is_drop_button_pressed()) {
      hold_time = 2;
      while(self is_drop_button_pressed() && hold_time >= 0) {
        wait 0.05;
        hold_time -= 0.05;
      }

      if(hold_time > 0) {
        wait 0.05;
        continue;
      }

      assertex(isDefined(level.deployable_currency_ranks[currency_rank]), "Rank out of bound");
      if(self player_has_enough_currency(level.deployable_currency_ranks[currency_rank])) {
        self deploy_currency(currency_rank);
        level notify("currency_dropped", self);
      }

      while(self is_drop_button_pressed()) {
        wait 0.05;
      }
    }
    wait 0.5;
  }
}

is_drop_button_pressed() {
  if(!isDefined(self) || !isalive(self)) {
    return false;
  }

  if(isDefined(self.laststand) && self.laststand) {
    return false;
  }

  pressed_button_1 = self AdsButtonPressed();
  pressed_button_2 = self JumpButtonPressed();

  return pressed_button_1 && pressed_button_2;
}

deploy_currency(currency_rank) {
  self endon("disconnect");
  self notify("deploying_currency");

  assertex(isDefined(level.deployable_currency_ranks[currency_rank]), "Rank out of bound");

  self take_player_currency(level.deployable_currency_ranks[currency_rank], true);

  boxType = "deployable_currency";

  self.team_currency_rank = currency_rank;
  maxUses = level.boxSettings[boxType].maxUses;
  level.boxSettings[boxType].maxUses = 1;
  box = maps\mp\alien\_deployablebox::createBoxForPlayer(boxType, self.origin, self);
  level.boxSettings[boxType].maxUses = maxUses;
  box.upgrade_rank = currency_rank;
  box playSoundToPlayer(level.boxSettings[boxType].deployedSfx, self);

  self thread currency_box_think(box);
}

currency_box_think(box) {
  self endon("disconnect");
  box endon("death");

  wait 0.05;
  box thread maps\mp\alien\_deployablebox::box_setActive(true);

  self waittill("deploying_currency");
  if(isDefined(box)) {
    box maps\mp\alien\_deployablebox::box_leave();
  }
}