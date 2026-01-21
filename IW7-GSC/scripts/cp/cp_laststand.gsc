/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\cp_laststand.gsc
*********************************************/

callback_defaultplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  default_playerlaststand(var_9);
}

default_playerlaststand(var_0) {
  var_1 = gameshouldend(self);
  if(var_1 && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }

  if(player_in_laststand(self)) {
    forcebleedout(var_0);
    return;
  }

  dropintolaststand(var_0, var_1);
}

forcebleedout(var_0) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self setorigin(var_0.origin);
  }

  self.bleedoutspawnentityoverride = var_0;
  self notify("force_bleed_out");
}

dropintolaststand(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand", scripts\cp\utility::getvalidtakeweapon());
  var_2 = scripts\cp\utility::has_zombie_perk("perk_machine_revive");
  enter_gamemodespecificaction();
  enter_globaldefaultaction();
  level.laststandnumber++;
  enter_laststand();
  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && haveselfrevive()) {
    if(scripts\cp\utility::is_consumable_active("self_revive") || scripts\engine\utility::istrue(level.the_hoff_revive)) {
      waitinlaststand(var_0, var_1, var_2);
    } else {
      waitinspectator(var_0, var_1);
    }
  } else if(debugafterlifearcadeenabled()) {
    waitinspectator(var_0, var_1);
  } else if(maydolaststand(var_1, var_0)) {
    var_3 = waitinlaststand(var_0, var_1);
    if(!var_3) {
      waitinspectator(var_0, var_1);
    }
  } else {
    waitinspectator(var_0, var_1);
  }

  self notify("revive");
  level notify("revive_success", self);
  exit_laststand();
  exit_globaldefaultaction();
  exit_gamemodespecificaction();
}

enter_laststand() {
  self.inlaststand = 1;
  self.health = 1;
  scripts\engine\utility::allow_usability(0);
  self notify("healthRegeneration");
}

exit_laststand() {
  self laststandrevive();
  self setstance("stand");
  self.inlaststand = 0;
  self.health = gethealthcap();
  scripts\cp\utility::force_usability_enabled();
}

gethealthcap() {
  return int(self.maxhealth);
}

enter_globaldefaultaction() {
  scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_enter_laststand");
  var_0 = ["iw7_gunless_zm"];
  if(isDefined(level.additional_laststand_weapon_exclusion)) {
    var_0 = scripts\engine\utility::array_combine(var_0, level.additional_laststand_weapon_exclusion);
  }

  if(isDefined(self.former_mule_weapon)) {
    var_0[var_0.size] = self.former_mule_weapon;
  }

  var_1 = [];
  foreach(var_3 in self getweaponslistprimaries()) {
    if(!scripts\cp\utility::isstrstart(var_3, "alt_")) {
      var_1[var_1.size] = var_3;
    }
  }

  self.lost_and_found_primary_count = var_1;
  scripts\cp\utility::store_weapons_status(var_0, 1);
  self.lastweapon = enter_globaldefaultaction_getcurrentweapon(var_0, 1);
  self.bleedoutspawnentityoverride = undefined;
  self.saved_last_stand_pistol = self.last_stand_pistol;
  self.pre_laststand_weapon = self getweaponslistprimaries()[1];
  self.pre_laststand_weapon_stock = self getweaponammostock(self.pre_laststand_weapon);
  self.pre_laststand_weapon_ammo_clip = self getweaponammoclip(self.pre_laststand_weapon);
  self.being_revived = 0;
  check_for_invalid_attachments();
  thread only_use_weapon();
  scripts\cp\cp_persistence::take_player_currency(get_currency_penalty_amount(self), 1, "laststand");
  scripts\cp\cp_persistence::eog_player_update_stat("downs", 1);
  scripts\cp\cp_persistence::increment_player_career_downs(self);
  scripts\cp\cp_analytics::inc_downed_counts();
  scripts\cp\cp_challenge::update_challenge("no_laststand");
  self stopgestureviewmodel();
}

check_for_invalid_attachments() {
  if(!isDefined(self.copy_fullweaponlist)) {
    return;
  }

  if(scripts\cp\utility::is_consumable_active("just_a_flesh_wound")) {
    return;
  }

  var_0 = undefined;
  if(isDefined(self.lastweapon) && !scripts\engine\utility::exist_in_array_MAYBE(self.copy_fullweaponlist, self.lastweapon)) {
    self.copy_fullweaponlist = scripts\engine\utility::array_add(self.copy_fullweaponlist, self.lastweapon);
  }

  foreach(var_2 in self.copy_fullweaponlist) {
    if(scripts\cp\cp_weapon::has_attachment(var_2, "doubletap")) {
      var_3 = strtok(var_2, "+");
      var_0 = var_3[0];
      for(var_4 = 1; var_4 < var_3.size; var_4++) {
        if(issubstr(var_3[var_4], "doubletap")) {
          continue;
        }

        var_0 = var_0 + "+" + var_3[var_4];
      }

      if(scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_2)) {
        self.copy_fullweaponlist = scripts\engine\utility::array_remove(self.copy_fullweaponlist, var_2);
        self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_0;
      }

      if(issubstr(self.copy_weapon_current, var_3[0])) {
        self.copy_weapon_current = var_0;
      }

      var_5 = getarraykeys(self.copy_weapon_ammo_clip);
      var_6 = getarraykeys(self.copy_weapon_ammo_stock);
      foreach(var_8 in var_5) {
        if(issubstr(var_8, var_3[0])) {
          if(var_0 != var_8) {
            self.copy_weapon_ammo_clip[var_0] = self.copy_weapon_ammo_clip[var_8];
            self.copy_weapon_ammo_clip[var_8] = undefined;
          }
        }
      }

      foreach(var_11 in var_6) {
        if(issubstr(var_11, var_3[0])) {
          if(var_0 != var_11) {
            self.copy_weapon_ammo_stock[var_0] = self.copy_weapon_ammo_stock[var_11];
            self.copy_weapon_ammo_stock[var_11] = undefined;
          }
        }
      }

      if(issubstr(self.lastweapon, var_3[0])) {
        self.lastweapon = var_0;
      }

      if(issubstr(self.pre_laststand_weapon, var_3[0])) {
        self.pre_laststand_weapon = var_0;
      }
    }
  }
}

enter_globaldefaultaction_getcurrentweapon(var_0, var_1) {
  var_2 = scripts\cp\utility::getvalidtakeweapon(var_0);
  if(isDefined(self.pre_arcade_game_weapon)) {
    var_2 = self.pre_arcade_game_weapon;
  }

  var_3 = 0;
  if(var_2 == "none") {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, getweaponbasename(var_2))) {
    var_3 = 1;
  } else if(scripts\engine\utility::istrue(var_1) && scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    var_3 = 1;
  }

  if(scripts\cp\utility::is_primary_melee_weapon(var_2)) {
    var_3 = 0;
  }

  if(var_3) {
    return choose_last_weapon(var_0, var_1, 1);
  }

  return var_2;
}

choose_last_weapon(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < self.copy_fullweaponlist.size; var_3++) {
    if(self.copy_fullweaponlist[var_3] == "none") {
      continue;
    } else if(scripts\engine\utility::array_contains(var_0, self.copy_fullweaponlist[var_3])) {
      continue;
    } else if(scripts\engine\utility::array_contains(var_0, getweaponbasename(self.copy_fullweaponlist[var_3]))) {
      continue;
    } else if(scripts\engine\utility::istrue(var_1) && scripts\cp\utility::is_melee_weapon(self.copy_fullweaponlist[var_3], var_2)) {
      continue;
    } else {
      return self.copy_fullweaponlist[var_3];
    }
  }
}

exit_globaldefaultaction() {
  self.haveinvulnerabilityavailable = 1;
  self.damageshieldexpiretime = gettime() + 3000;
  var_0 = [];
  scripts\cp\utility::restore_weapons_status(var_0);
  if(isDefined(self.pre_laststand_weapon_stock)) {
    self setweaponammostock(self.pre_laststand_weapon, self.pre_laststand_weapon_stock);
  }

  if(isDefined(self.pre_laststand_weapon_ammo_clip)) {
    self setweaponammoclip(self.pre_laststand_weapon, self.pre_laststand_weapon_ammo_clip);
  }

  if(is_valid_spawn_weapon(self.lastweapon)) {
    self setspawnweapon(self.lastweapon, 1);
  }

  give_fists_if_no_real_weapon(self);
  self.bleedoutspawnentityoverride = undefined;
  self.pre_arcade_game_weapon = undefined;
  self.pre_arcade_game_weapon_clip = undefined;
  self.pre_arcade_game_weapon_stock = undefined;
  self.former_mule_weapon = undefined;
  scripts\cp\cp_analytics::inc_revived_counts();
  scripts\cp\cp_damage::set_kill_trigger_event_processed(self, 0);
  updatemovespeedscale();
  self setclientomnvarbit("player_damaged", 2, 0);
}

enter_gamemodespecificaction() {
  if(isDefined(level.laststand_enter_gamemodespecificaction)) {
    [[level.laststand_enter_gamemodespecificaction]](self);
  }

  if(isDefined(level.laststand_enter_levelspecificaction)) {
    [[level.laststand_enter_levelspecificaction]](self);
  }
}

exit_gamemodespecificaction() {
  if(isDefined(level.laststand_exit_gamemodespecificaction)) {
    [[level.laststand_exit_gamemodespecificaction]](self);
  }
}

waitinlaststand(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  if(self_revive_activated()) {
    return self_revive(self);
  }

  var_3 = 35;
  if(scripts\cp\utility::is_consumable_active("coagulant")) {
    var_3 = 60;
    scripts\cp\utility::notify_used_consumable("coagulant");
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_revive") && !isDefined(level.the_hoff_revive)) {
      wait(5);
      return 1;
    }
  } else {
    var_2 = undefined;
  }

  if(!var_1) {
    thread playdeathsoundinlaststand(var_3);
    if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      take_laststand(self, 1);
      if(scripts\engine\utility::istrue(level.the_hoff_revive)) {
        set_last_stand_timer(self, 35);
      } else {
        set_last_stand_timer(self, 5);
      }
    } else if(!scripts\engine\utility::flag_exist("meph_fight") || scripts\engine\utility::flag_exist("meph_fight") && !scripts\engine\utility::flag("meph_fight")) {
      set_last_stand_timer(self, var_3);
    } else {
      var_3 = undefined;
    }
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && !isDefined(level.the_hoff_revive)) {
    return wait_for_self_revive(var_0, var_1);
  }

  return wait_to_be_revived(self, self.origin, undefined, undefined, 1, get_normal_revive_time(), (0.33, 0.75, 0.24), var_3, 0, var_1, 1, var_2);
}

waitinspectator(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait(0.5);
  self notify("death");
  scripts\engine\utility::waitframe();
  record_bleedout(var_0);
  if(isDefined(self.bleedoutspawnentityoverride)) {
    var_0 = self.bleedoutspawnentityoverride;
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(var_0)) {
    var_2 = scripts\engine\utility::drop_to_ground(var_0.origin, 32, -64) + (0, 0, 5);
    var_3 = var_0.angles;
  } else {
    var_2 = self.origin;
    var_3 = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;
  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }

    var_6 = var_5 scripts\cp\cp_persistence::get_player_currency();
    var_7 = int(var_6 * 0.1);
    var_5 scripts\cp\cp_persistence::take_player_currency(var_7, 1, "bleedoutPenalty");
  }

  var_9 = wait_to_be_revived(self, var_2, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, var_1, 0);
  show_all_revive_icons(self);
  self.spectating = undefined;
  scripts\cp\utility::updatesessionstate("playing");
  self.forcespawnorigin = var_2;
  self.forcespawnangles = var_3;
  if(isDefined(level.prespawnfromspectaorfunc)) {
    [[level.prespawnfromspectaorfunc]](self);
  }

  scripts\cp\cp_globallogic::spawnplayer();
}

record_bleedout(var_0) {
  scripts\cp\cp_persistence::eog_player_update_stat("deaths", 1);
  scripts\cp\cp_challenge::update_challenge("no_bleedout");
  if(!is_killed_by_kill_trigger(var_0)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
  }
}

wait_for_self_revive(var_0, var_1) {
  if(var_1) {
    level waittill("forever");
    clear_last_stand_timer(self);
    return 0;
  }

  if(is_killed_by_kill_trigger(var_0)) {
    self setorigin(var_0.origin);
  } else {
    wait(5);
  }

  clear_last_stand_timer(self);
  return 1;
}

wait_to_be_revived(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = makereviveentity(var_0, var_1, var_2, var_3, var_4);
  if(var_8) {
    thread enter_spectate(var_0, var_1, var_12);
  }

  if(var_9) {
    level waittill("forever");
    return 0;
  }

  var_13 = var_12;
  if(var_8) {
    var_13 = makereviveiconentity(var_0, var_12);
  }

  if(var_10) {
    var_13 makereviveicon(var_13, var_0, var_6, var_7);
  }

  var_0.reviveent = var_12;
  var_0.reviveiconent = var_13;
  if(isDefined(level.wait_to_be_revived_func)) {
    var_14 = [[level.wait_to_be_revived_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    if(isDefined(var_14)) {
      return var_14;
    }
  }

  if(var_10) {
    var_12 thread laststandwaittillrevivebyteammate(var_0, var_5);
  }

  if(isDefined(var_7)) {
    var_14 = var_12 scripts\cp\utility::waittill_any_ents_or_timeout_return(var_7, var_12, "revive_success", var_0, "force_bleed_out", var_0, "revive_success", var_0, "challenge_complete_revive");
  } else {
    var_14 = var_13 scripts\cp\utility::waittill_any_ents_return(var_13, "revive_success", var_1, "challenge_complete_revive");
  }

  if(var_14 == "timeout" && is_being_revived(var_0)) {
    var_14 = var_12 scripts\engine\utility::waittill_any_return("revive_success", "revive_fail");
  }

  if(var_14 == "revive_success" || var_14 == "challenge_complete_revive") {
    return 1;
  }

  return 0;
}

laststandwaittillrevivebyteammate(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self makeusable();
    self waittill("trigger", var_2);
    self makeunusable();
    if(!var_2 isonground()) {
      continue;
    }

    if(var_2 ismeleeing()) {
      continue;
    }

    if(!isplayer(var_2) && !scripts\engine\utility::istrue(var_2.can_revive)) {
      continue;
    }

    var_3 = getrevivetimescaler(var_2, var_0);
    var_4 = int(var_1 / var_3);
    var_5 = get_revive_result(var_0, var_2, self.origin, var_4);
    if(var_5) {
      if(isDefined(var_2.vo_prefix)) {
        if(var_0.vo_prefix == "p4_" && soundexists(var_2.vo_prefix + "respawn_laststand_valleygirl")) {
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_valleygirl", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else if(var_0.vo_prefix == "p1_" && soundexists(var_2.vo_prefix + "respawn_laststand_aj")) {
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_aj", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else if(level.script == "cp_town") {
          if(var_2.vo_prefix == "p1_") {
            var_0 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_sally", "town_comment_vo");
          }
        } else {
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        }
      }

      if(var_0 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
        var_0 scripts\cp\utility::notify_used_consumable("faster_revive_upgrade");
      }

      var_2 playlocalsound("revive_teammate");
      record_revive_success(var_2, var_0);
      var_2 notify("revive_teammate", var_0);
      if(isplayer(var_2) && scripts\engine\utility::istrue(var_2.can_give_revive_xp)) {
        var_2.can_give_revive_xp = 0;
        var_2 scripts\cp\cp_persistence::give_player_xp(int(250), 1);
      }

      break;
    } else {
      self notify("revive_fail");
      continue;
    }
  }

  clear_last_stand_timer(var_0);
  self notify("revive_success");
}

getrevivetimescaler(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.can_revive)) {
    return 2;
  }

  var_2 = var_0 scripts\cp\perks\perk_utility::perk_getrevivetimescalar();
  if(var_1 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
    var_2 = var_2 * 2;
  }

  return var_2;
}

func_B529(var_0, var_1) {
  instant_revive(var_1);
  record_revive_success(var_0, var_1);
}

record_revive_success(var_0, var_1) {
  if(isplayer(var_0)) {
    var_0 scripts\cp\cp_merits::processmerit("mt_reviver");
    var_0 scripts\cp\cp_persistence::increment_player_career_revives(var_0);
    var_0 scripts\cp\cp_merits::processmerit("mt_revives");
    var_0 scripts\cp\cp_persistence::eog_player_update_stat("revives", 1);
    var_1 thread scripts\cp\cp_hud_message::showsplash("revived", undefined, var_0);
    if(isDefined(level.revive_success_analytics_func)) {
      [[level.revive_success_analytics_func]](var_0);
    }
  }
}

makereviveentity(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 20);
  var_1 = scripts\engine\utility::drop_to_ground(var_1 + var_5, 32, -64);
  var_6 = spawn("script_model", var_1);
  var_6 setcursorhint("HINT_NOICON");
  var_6 sethintstring(&"PLATFORM_REVIVE");
  var_6.owner = var_0;
  var_6.inuse = 0;
  var_6.var_336 = "revive_trigger";
  if(isDefined(var_2)) {
    var_6 setModel(var_2);
  }

  if(isDefined(var_3)) {
    var_6 scriptmodelplayanim(var_3);
  }

  if(var_4) {
    var_6 linkto(var_0, "tag_origin", var_5, (0, 0, 0));
  }

  var_6 thread cleanupreviveent(var_0);
  return var_6;
}

makereviveiconentity(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_3 = spawn("script_model", var_1.origin + var_2);
  var_3 thread cleanupreviveent(var_0);
  return var_3;
}

maydolaststand(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_maydolaststand(var_0, var_1);
  }

  return coop_maydolaststand(var_1);
}

solo_maydolaststand(var_0, var_1) {
  if(var_0 && is_killed_by_kill_trigger(var_1)) {
    return 0;
  }

  return 1;
}

coop_maydolaststand(var_0) {
  if(is_killed_by_kill_trigger(var_0)) {
    return 0;
  }

  return 1;
}

only_use_weapon() {
  if(scripts\engine\utility::istrue(self.iscarrying)) {
    wait(0.5);
  }

  var_0 = get_last_stand_pistol();
  if(self hasweapon(var_0)) {
    self takeweapon(var_0);
  }

  scripts\cp\utility::_giveweapon(var_0, scripts\cp\utility::get_weapon_variant_id(self, var_0), 0, 1);
  var_1 = ["iw7_knife_zm", "iw7_knife_zm_hoff", "iw7_knife_zm_jock", "iw7_knife_zm_vgirl", "iw7_knife_zm_rapper", "iw7_knife_zm_nerd", "iw7_knife_zm_wyler", "iw7_knife_zm_schoolgirl", "iw7_knife_zm_scientist", "iw7_knife_zm_soldier", "iw7_knife_zm_rebel", "iw7_knife_zm_elvira", "iw7_knife_zm_crowbar", "iw7_knife_zm_cleaver", "iw7_knife_zm_chola", "iw7_knife_zm_raver", "iw7_knife_zm_grunge", "iw7_knife_zm_hiphop", "iw7_knife_zm_kevinsmith", "iw7_knife_zm_disco"];
  var_2 = can_use_pistol_during_last_stand(self);
  if(var_2) {
    var_1[var_1.size] = var_0;
  }

  _takeweaponsexceptlist(var_1);
  var_3 = get_number_of_last_stand_clips();
  if(var_2) {
    var_4 = self getrunningforwardpainanim(var_0);
    var_5 = weaponclipsize(var_0);
    self setweaponammostock(var_0, var_5 * var_3);
    self setweaponammoclip(var_0, var_5);
    self switchtoweaponimmediate(var_0);
  }
}

get_number_of_last_stand_clips() {
  return 2;
}

get_last_stand_pistol() {
  if(isDefined(self.last_stand_pistol)) {
    return self.last_stand_pistol;
  }

  var_0 = self.default_starting_pistol;
  var_1 = self getweaponslistprimaries()[0];
  if(scripts\cp\utility::getbaseweaponname(var_0) == scripts\cp\utility::getbaseweaponname(var_1)) {
    return var_1;
  }

  return var_0;
}

can_use_pistol_during_last_stand(var_0) {
  if(isDefined(level.can_use_pistol_during_laststand_func)) {
    return [[level.can_use_pistol_during_laststand_func]](var_0);
  }

  return 1;
}

cleanupreviveent(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("death", "disconnect", "revive");
  self delete();
}

remove_from_owner_revive_icon_list(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_1.revive_icons = scripts\engine\utility::array_remove(var_1.revive_icons, var_0);
}

default_player_init_laststand() {
  init_revive_icon_list(self);
}

func_9730(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(5);
  var_1 = get_last_stand_count();
}

give_laststand(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = var_0 get_last_stand_count() + var_1;
  set_last_stand_count(var_0, var_2);
}

take_laststand(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = var_0 get_last_stand_count() - var_1;
  set_last_stand_count(var_0, max(var_2, 0));
}

gameshouldend(var_0) {
  if(var_0 self_revive_activated()) {
    return 0;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0 scripts\cp\utility::has_zombie_perk("perk_machine_revive") || scripts\engine\utility::istrue(level.the_hoff_revive)) {
    return 0;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_gameshouldend(var_0);
  }

  return coop_gameshouldend(var_0);
}

solo_gameshouldend(var_0) {
  if(player_in_laststand(var_0)) {
    return 0;
  }

  return var_0 get_last_stand_count() == 0;
}

coop_gameshouldend(var_0) {
  return everyone_else_all_in_laststand(var_0);
}

everyone_else_all_in_laststand(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(!player_in_laststand(var_2)) {
      return 0;
    }
  }

  return 1;
}

get_revive_result(var_0, var_1, var_2, var_3) {
  var_4 = createuseent(var_2);
  var_4 thread cleanupreviveent(var_0);
  var_5 = revive_use_hold_think(var_0, var_1, var_4, var_3);
  return var_5;
}

createuseent(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1.curprogress = 0;
  var_1.usetime = 0;
  var_1.userate = 8000;
  var_1.inuse = 0;
  return var_1;
}

playdeathsoundinlaststand(var_0) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  scripts\cp\utility::playdeathsound();
  wait(var_0 / 3);
  scripts\cp\utility::playdeathsound();
  wait(var_0 / 3);
  thread scripts\cp\cp_vo::try_to_play_vo("laststand_bleedout", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  scripts\cp\utility::playdeathsound();
}

enter_spectate(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");
  if(isDefined(var_0.carryicon)) {
    var_0.carryicon destroy();
  }

  var_0.has_building_upgrade = 0;
  enter_camera_zoomout();
  camera_zoomout(var_0, var_1, var_2);
  exit_camera_zoomout();
}

camera_zoomout(var_0, var_1, var_2) {
  var_2 endon("revive_success");
  var_3 = (0, 0, 30);
  var_4 = (0, 0, 100);
  var_5 = (0, 0, 400);
  var_6 = 2;
  var_7 = 0.6;
  var_8 = 0.6;
  var_9 = var_1 + var_3;
  var_10 = bulletTrace(var_9, var_9 + var_4, 0, var_0);
  var_11 = var_10["position"];
  var_10 = bulletTrace(var_11, var_11 + var_5, 0, var_0);
  var_12 = var_10["position"];
  var_13 = spawn("script_model", var_11);
  var_13 setModel("tag_origin");
  var_13.angles = vectortoangles((0, 0, -1));
  var_13 thread cleanupreviveent(var_0);
  var_0 cameralinkto(var_13, "tag_origin");
  var_13 moveto(var_12, var_6, var_7, var_8);
  var_13 waittill("movedone");
  var_13 delete();
  var_0 enter_bleed_out(var_0);
}

enter_bleed_out(var_0) {
  hide_all_revive_icons(var_0);
  if(isDefined(level.player_bleed_out_func)) {
    var_0[[level.player_bleed_out_func]](var_0);
    return;
  }

  var_0 scripts\cp\cp_globallogic::enterspectator();
}

enter_camera_zoomout() {
  self getweaponrankxpmultiplier();
  self freezecontrols(1);
  self.zoom_out_camera = 1;
}

exit_camera_zoomout() {
  self cameraunlink();
  self freezecontrols(0);
  self.zoom_out_camera = undefined;
}

revive_use_hold_think(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.vo_prefix)) {
    if(var_0.vo_prefix == "p1_" && soundexists(var_1.vo_prefix + "reviving_valleygirl")) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("reviving_valleygirl", "zmb_comment_vo");
    } else if(var_0.vo_prefix == "p1_" && soundexists(var_1.vo_prefix + "reviving_sally")) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("reviving_sally", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("reviving", "zmb_comment_vo");
    }
  }

  enter_revive_use_hold_think(var_0, var_1, var_2, var_3);
  if(!isDefined(level.the_hoff) || isDefined(level.the_hoff) && var_1 != level.the_hoff) {
    play_revive_gesture(var_1, var_0);
  }

  thread wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_1 scripts\cp\utility::getvalidtakeweapon());
  var_0.reviver = var_1;
  var_4 = 0;
  var_5 = 0;
  enable_on_world_progress_bar_for_other_players(var_0, var_1);
  if(isplayer(var_1)) {
    var_0 notify("reviving");
  }

  while(should_revive_continue(var_1)) {
    if(var_4 >= var_3) {
      var_5 = 1;
      break;
    }

    var_6 = var_4 / var_3;
    update_players_revive_progress_bar(var_0, var_1, var_6);
    var_4 = var_4 + 50;
    scripts\engine\utility::waitframe();
  }

  disable_on_world_progress_bar_for_other_players(var_0, var_1);
  var_2 notify("use_hold_think_complete");
  var_2 waittill("exit_use_hold_think_complete");
  return var_5;
}

play_revive_gesture(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.hasentanglerequipped)) {
    return;
  }

  var_0 giveweapon("iw7_gunless_zm");
  var_0 switchtoweapon("iw7_gunless_zm");
  var_0 allowmelee(0);
  var_0 getraidspawnpoint();
  var_0 forceplaygestureviewmodel(get_revive_gesture(var_0), var_1);
}

stop_revive_gesture(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.hasentanglerequipped)) {
    return;
  }

  var_0 takeweapon("iw7_gunless_zm");
  var_0 enableweaponswitch();
  var_0 switchtoweapon(var_1);
  var_0 allowmelee(1);
  var_0 stopgestureviewmodel(get_revive_gesture(var_0));
}

get_revive_gesture(var_0) {
  if(isDefined(var_0.revive_gesture)) {
    return var_0.revive_gesture;
  }

  return "ges_zombies_revive_nerd";
}

update_players_revive_progress_bar(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      var_4 setclientomnvar("ui_securing_progress", var_2);
      continue;
    }

    var_4 setclientomnvar("zm_revive_bar_" + var_0.revive_progress_bar_id + "_progress", var_2);
  }
}

enter_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_securing", 4);
  var_1 setclientomnvar("ui_securing", 3);
  var_0.being_revived = 1;
  if(isplayer(var_1)) {
    var_1 playerlinkto(var_2);
    var_1 playerlinkedoffsetenable();
    var_1 scripts\cp\powers\coop_powers::power_disablepower();
    var_1 thread play_rescue_anim(var_1);
  }

  var_1.isreviving = 1;
}

wait_for_exit_revive_use_hold_think(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::waittill_any_ents(var_2, "use_hold_think_complete", var_0, "disconnect", var_0, "revive_success", var_0, "force_bleed_out", var_1, "challenge_complete", var_0, "death");
  if(scripts\cp\utility::isreallyalive(var_0)) {
    var_0.being_revived = 0;
    var_0 setclientomnvar("ui_securing", 0);
  }

  var_1.isreviving = 0;
  if(isplayer(var_1)) {
    var_1 stop_revive_gesture(var_1, var_3);
    var_1 setclientomnvar("ui_securing", 0);
    var_1 scripts\cp\powers\coop_powers::power_enablepower();
    var_1 unlink();
    var_1 notify("stop_revive");
  }

  var_2 notify("exit_use_hold_think_complete");
}

play_rescue_anim(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_playing_revive_anim");
  var_0 playanimscriptevent("power_active_cp", "gesture015");
}

should_revive_continue(var_0) {
  if(scripts\engine\utility::istrue(var_0.can_revive)) {
    return 1;
  }

  return !level.gameended && scripts\cp\utility::isreallyalive(var_0) && var_0 usebuttonpressed() && !player_in_laststand(var_0);
}

_takeweaponsexceptlist(var_0) {
  var_1 = self getweaponslistall();
  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(var_0, var_3)) {
      continue;
    } else if(!scripts\cp\utility::isstrstart(var_3, "alt_")) {
      self takeweapon(var_3);
    }
  }
}

is_killed_by_kill_trigger(var_0) {
  return isDefined(var_0);
}

set_last_stand_count(var_0, var_1) {
  var_1 = int(var_1);
  var_0 setplayerdata("cp", "alienSession", "last_stand_count", var_1);
}

set_last_stand_timer(var_0, var_1) {
  var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + var_1 * 1000);
}

clear_last_stand_timer(var_0) {
  var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
}

instant_revive(var_0) {
  var_0 notify("revive_success");
  if(isDefined(var_0.reviveent)) {
    var_0.reviveent notify("revive_success");
  }

  if(is_being_revived(var_0)) {
    disable_on_world_progress_bar_for_other_players(var_0, var_0.reviver);
  }

  clear_last_stand_timer(var_0);
}

set_revive_time(var_0, var_1) {
  if(isDefined(var_0)) {
    level.normal_revive_time = var_0;
  }

  if(isDefined(var_1)) {
    level.spectator_revive_time = var_1;
  }
}

get_normal_revive_time() {
  if(isDefined(level.normal_revive_time)) {
    return level.normal_revive_time;
  }

  return 5000;
}

get_spectator_revive_time() {
  if(isDefined(level.spectator_revive_time)) {
    return level.spectator_revive_time;
  }

  return 6000;
}

updatemovespeedscale() {
  self[[level.move_speed_scale]]();
}

get_currency_penalty_amount(var_0) {
  if(isDefined(level.laststand_currency_penalty_amount_func)) {
    return [[level.laststand_currency_penalty_amount_func]](var_0);
  }

  return 500;
}

makereviveicon(var_0, var_1, var_2, var_3) {
  setup_revive_icon_ent(var_0);
  var_0.current_revive_icon_color = var_2;
  var_0 thread reviveiconentcleanup(var_0);
  var_4 = undefined;
  foreach(var_6 in level.players) {
    if(var_6 == var_1) {
      continue;
    }

    var_4 = show_revive_icon_to_player(var_0, var_6);
    add_to_revive_icon_ent_icon_list(var_0, var_4);
  }

  if(isDefined(var_3)) {
    var_0 thread revive_icon_color_management(var_3);
  }

  return var_4;
}

show_revive_icon_to_player(var_0, var_1) {
  var_2 = newclienthudelem(var_1);
  var_2 setshader("waypoint_alien_revive", 8, 8);
  var_2 setwaypoint(1, 1);
  var_2 settargetent(var_0);
  var_2.alpha = get_revive_icon_initial_alpha(var_1);
  var_2.color = var_0.current_revive_icon_color;
  add_to_player_revive_icon_list(var_1, var_2);
  var_2 thread reviveiconcleanup(var_0, var_1);
  return var_2;
}

reviveiconentcleanup(var_0) {
  var_0 waittill("death");
  remove_from_revive_icon_entity_list(var_0);
}

reviveiconcleanup(var_0, var_1) {
  scripts\cp\utility::waittill_any_ents_return(var_0, "death", var_1, "disconnect");
  remove_from_owner_revive_icon_list(self, var_1);
  if(isDefined(self)) {
    self destroy();
  }
}

revive_icon_color_management(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0 / 3);
  set_revive_icon_color(self, (1, 0.941, 0));
  wait(var_0 / 3);
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
}

set_revive_icon_color(var_0, var_1) {
  var_0.current_revive_icon_color = var_1;
  var_0.revive_icons = scripts\engine\utility::array_removeundefined(var_0.revive_icons);
  foreach(var_3 in var_0.revive_icons) {
    var_3.color = var_1;
  }
}

init_laststand() {
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  level thread revive_icon_player_connect_monitor();
}

add_to_revive_icon_entity_list(var_0) {
  level.revive_icon_entities[level.revive_icon_entities.size] = var_0;
}

remove_from_revive_icon_entity_list(var_0) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, var_0);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

revive_icon_player_connect_monitor() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    foreach(var_2 in level.revive_icon_entities) {
      show_revive_icon_to_player(var_2, var_0);
    }

    foreach(var_5 in level.players_being_revived) {
      if(isDefined(var_5)) {
        var_0 setclientomnvar("zm_revive_bar_" + var_5.revive_progress_bar_id + "_target", var_5);
      }
    }
  }
}

setup_revive_icon_ent(var_0) {
  var_0.revive_icons = [];
  add_to_revive_icon_entity_list(var_0);
}

add_to_revive_icon_ent_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

init_revive_icon_list(var_0) {
  var_0.revive_icons = [];
}

add_to_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons[var_0.revive_icons.size] = var_1;
}

remove_from_player_revive_icon_list(var_0, var_1) {
  var_0.revive_icons = scripts\engine\utility::array_remove(var_0.revive_icons, var_1);
}

get_revive_icon_initial_alpha(var_0) {
  if(isDefined(level.var_E49D)) {
    return [[level.var_E49D]](var_0);
  }

  return 1;
}

show_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons) {
    var_2.alpha = 1;
  }
}

hide_all_revive_icons(var_0) {
  foreach(var_2 in var_0.revive_icons) {
    var_2.alpha = 0;
  }
}

enable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = add_to_players_being_revived(var_0);
  var_3 = "zm_revive_bar_" + var_2 + "_target";
  foreach(var_5 in level.players) {
    if(var_5 == var_0 || var_5 == var_1) {
      continue;
    }

    var_5 setclientomnvar(var_3, var_0);
  }
}

disable_on_world_progress_bar_for_other_players(var_0, var_1) {
  var_2 = "zm_revive_bar_" + var_0.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(var_0);
  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      continue;
    }

    var_4 setclientomnvar(var_2, undefined);
  }
}

self_revive_activated() {
  return isDefined(self.self_revive) && self.self_revive > 0;
}

add_to_players_being_revived(var_0) {
  var_1 = 0;
  while(var_1 < 2) {
    if(!isDefined(level.players_being_revived[var_1])) {
      level.players_being_revived[var_1] = var_0;
      var_2 = var_1 + 1;
      var_0.revive_progress_bar_id = var_2;
      return var_2;
    }

    var_2++;
  }
}

remove_from_players_being_revived(var_0) {
  for(var_1 = 0; var_1 < 2; var_1++) {
    if(isDefined(level.players_being_revived[var_1]) && level.players_being_revived[var_1] == var_0) {
      level.players_being_revived[var_1] = undefined;
      var_0.revive_progress_bar_id = undefined;
      return;
    }
  }
}

debugafterlifearcadeenabled() {
  return 0;
}

haveselfrevive() {
  return scripts\engine\utility::istrue(self.have_self_revive);
}

get_last_stand_count() {
  return self getplayerdata("cp", "alienSession", "last_stand_count");
}

is_being_revived(var_0) {
  return scripts\engine\utility::istrue(var_0.being_revived);
}

player_in_laststand(var_0) {
  return var_0.inlaststand;
}

enable_self_revive(var_0) {
  if(!isDefined(var_0.self_revive)) {
    var_0.self_revive = 0;
  }

  var_0.self_revive++;
}

disable_self_revive(var_0) {
  var_0.self_revive--;
}

self_revive(var_0) {
  var_0 scripts\engine\utility::waittill_any_timeout(3, "revive_success");
  return 1;
}

give_fists_if_no_real_weapon(var_0) {
  if(has_no_real_weapon(var_0)) {
    var_1 = get_fists_weapon(var_0);
    if(var_1 != "iw7_fists_zm" && var_0 hasweapon("iw7_fists_zm")) {
      var_0 takeweapon("iw7_fists_zm");
    }

    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    if(is_valid_spawn_weapon(var_1)) {
      self setspawnweapon(var_1, 1);
    }
  }
}

get_fists_weapon(var_0) {
  if(isDefined(level.get_fists_weapon_func)) {
    return [[level.get_fists_weapon_func]](var_0);
  }

  return "iw7_fists_zm";
}

is_valid_spawn_weapon(var_0) {
  if(isDefined(level.is_valid_spawn_weapon_func)) {
    return [[level.is_valid_spawn_weapon_func]](var_0);
  }

  return 1;
}

has_no_real_weapon(var_0) {
  var_1 = var_0 getweaponslistall();
  foreach(var_3 in var_1) {
    if(var_3 == "super_default_zm") {
      continue;
    }

    if(issubstr(var_3, "knife")) {
      continue;
    }

    if(var_3 == "iw7_fists_zm") {
      continue;
    }

    return 0;
  }

  return 1;
}