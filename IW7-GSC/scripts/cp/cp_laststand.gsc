/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_laststand.gsc
***************************************/

callback_defaultplayerlaststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  default_playerlaststand(param_09);
}

default_playerlaststand(param_00) {
  var_01 = gameshouldend(self);
  if(var_01 && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }

  if(player_in_laststand(self)) {
    forcebleedout(param_00);
    return;
  }

  dropintolaststand(param_00, var_01);
}

forcebleedout(param_00) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self setorigin(param_00.origin);
  }

  self.bleedoutspawnentityoverride = param_00;
  self notify("force_bleed_out");
}

dropintolaststand(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand", scripts\cp\utility::getvalidtakeweapon());
  var_02 = scripts\cp\utility::has_zombie_perk("perk_machine_revive");
  enter_gamemodespecificaction();
  enter_globaldefaultaction();
  level.laststandnumber++;
  enter_laststand();
  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && haveselfrevive()) {
    if(scripts\cp\utility::is_consumable_active("self_revive") || scripts\engine\utility::istrue(level.the_hoff_revive)) {
      waitinlaststand(param_00, param_01, var_02);
    } else {
      waitinspectator(param_00, param_01);
    }
  } else if(debugafterlifearcadeenabled()) {
    waitinspectator(param_00, param_01);
  } else if(maydolaststand(param_01, param_00)) {
    var_03 = waitinlaststand(param_00, param_01);
    if(!var_03) {
      waitinspectator(param_00, param_01);
    }
  } else {
    waitinspectator(param_00, param_01);
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
  var_00 = ["iw7_gunless_zm"];
  if(isDefined(level.additional_laststand_weapon_exclusion)) {
    var_00 = scripts\engine\utility::array_combine(var_00, level.additional_laststand_weapon_exclusion);
  }

  if(isDefined(self.former_mule_weapon)) {
    var_00[var_00.size] = self.former_mule_weapon;
  }

  var_01 = [];
  foreach(var_03 in self getweaponslistprimaries()) {
    if(!scripts\cp\utility::isstrstart(var_03, "alt_")) {
      var_01[var_01.size] = var_03;
    }
  }

  self.lost_and_found_primary_count = var_01;
  scripts\cp\utility::store_weapons_status(var_00, 1);
  self.lastweapon = enter_globaldefaultaction_getcurrentweapon(var_00, 1);
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

  var_00 = undefined;
  if(isDefined(self.lastweapon) && !scripts\engine\utility::exist_in_array_MAYBE(self.copy_fullweaponlist, self.lastweapon)) {
    self.copy_fullweaponlist = scripts\engine\utility::array_add(self.copy_fullweaponlist, self.lastweapon);
  }

  foreach(var_02 in self.copy_fullweaponlist) {
    if(scripts\cp\cp_weapon::has_attachment(var_02, "doubletap")) {
      var_03 = strtok(var_02, "+");
      var_00 = var_03[0];
      for(var_04 = 1; var_04 < var_03.size; var_04++) {
        if(issubstr(var_03[var_04], "doubletap")) {
          continue;
        }

        var_00 = var_00 + "+" + var_03[var_04];
      }

      if(scripts\engine\utility::array_contains(self.copy_fullweaponlist, var_02)) {
        self.copy_fullweaponlist = scripts\engine\utility::array_remove(self.copy_fullweaponlist, var_02);
        self.copy_fullweaponlist[self.copy_fullweaponlist.size] = var_00;
      }

      if(issubstr(self.copy_weapon_current, var_03[0])) {
        self.copy_weapon_current = var_00;
      }

      var_05 = getarraykeys(self.copy_weapon_ammo_clip);
      var_06 = getarraykeys(self.copy_weapon_ammo_stock);
      foreach(var_08 in var_05) {
        if(issubstr(var_08, var_03[0])) {
          if(var_00 != var_08) {
            self.copy_weapon_ammo_clip[var_00] = self.copy_weapon_ammo_clip[var_08];
            self.copy_weapon_ammo_clip[var_08] = undefined;
          }
        }
      }

      foreach(var_0B in var_06) {
        if(issubstr(var_0B, var_03[0])) {
          if(var_00 != var_0B) {
            self.copy_weapon_ammo_stock[var_00] = self.copy_weapon_ammo_stock[var_0B];
            self.copy_weapon_ammo_stock[var_0B] = undefined;
          }
        }
      }

      if(issubstr(self.lastweapon, var_03[0])) {
        self.lastweapon = var_00;
      }

      if(issubstr(self.pre_laststand_weapon, var_03[0])) {
        self.pre_laststand_weapon = var_00;
      }
    }
  }
}

enter_globaldefaultaction_getcurrentweapon(param_00, param_01) {
  var_02 = scripts\cp\utility::getvalidtakeweapon(param_00);
  if(isDefined(self.pre_arcade_game_weapon)) {
    var_02 = self.pre_arcade_game_weapon;
  }

  var_03 = 0;
  if(var_02 == "none") {
    var_03 = 1;
  } else if(scripts\engine\utility::array_contains(param_00, var_02)) {
    var_03 = 1;
  } else if(scripts\engine\utility::array_contains(param_00, getweaponbasename(var_02))) {
    var_03 = 1;
  } else if(scripts\engine\utility::istrue(param_01) && scripts\cp\utility::is_melee_weapon(var_02, 1)) {
    var_03 = 1;
  }

  if(scripts\cp\utility::is_primary_melee_weapon(var_02)) {
    var_03 = 0;
  }

  if(var_03) {
    return choose_last_weapon(param_00, param_01, 1);
  }

  return var_02;
}

choose_last_weapon(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < self.copy_fullweaponlist.size; var_03++) {
    if(self.copy_fullweaponlist[var_03] == "none") {
      continue;
    } else if(scripts\engine\utility::array_contains(param_00, self.copy_fullweaponlist[var_03])) {
      continue;
    } else if(scripts\engine\utility::array_contains(param_00, getweaponbasename(self.copy_fullweaponlist[var_03]))) {
      continue;
    } else if(scripts\engine\utility::istrue(param_01) && scripts\cp\utility::is_melee_weapon(self.copy_fullweaponlist[var_03], param_02)) {
      continue;
    } else {
      return self.copy_fullweaponlist[var_03];
    }
  }
}

exit_globaldefaultaction() {
  self.haveinvulnerabilityavailable = 1;
  self.damageshieldexpiretime = gettime() + 3000;
  var_00 = [];
  scripts\cp\utility::restore_weapons_status(var_00);
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

waitinlaststand(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  if(self_revive_activated()) {
    return self_revive(self);
  }

  var_03 = 35;
  if(scripts\cp\utility::is_consumable_active("coagulant")) {
    var_03 = 60;
    scripts\cp\utility::notify_used_consumable("coagulant");
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_revive") && !isDefined(level.the_hoff_revive)) {
      wait(5);
      return 1;
    }
  } else {
    param_02 = undefined;
  }

  if(!param_01) {
    thread playdeathsoundinlaststand(var_03);
    if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      take_laststand(self, 1);
      if(scripts\engine\utility::istrue(level.the_hoff_revive)) {
        set_last_stand_timer(self, 35);
      } else {
        set_last_stand_timer(self, 5);
      }
    } else if(!scripts\engine\utility::flag_exist("meph_fight") || scripts\engine\utility::flag_exist("meph_fight") && !scripts\engine\utility::flag("meph_fight")) {
      set_last_stand_timer(self, var_03);
    } else {
      var_03 = undefined;
    }
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && !isDefined(level.the_hoff_revive)) {
    return wait_for_self_revive(param_00, param_01);
  }

  return wait_to_be_revived(self, self.origin, undefined, undefined, 1, get_normal_revive_time(), (0.33, 0.75, 0.24), var_03, 0, param_01, 1, param_02);
}

waitinspectator(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  wait(0.5);
  self notify("death");
  scripts\engine\utility::waitframe();
  record_bleedout(param_00);
  if(isDefined(self.bleedoutspawnentityoverride)) {
    param_00 = self.bleedoutspawnentityoverride;
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(param_00)) {
    var_02 = scripts\engine\utility::drop_to_ground(param_00.origin, 32, -64) + (0, 0, 5);
    var_03 = param_00.angles;
  } else {
    var_02 = self.origin;
    var_03 = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;
  foreach(var_05 in level.players) {
    if(var_05 == self) {
      continue;
    }

    var_06 = var_05 scripts\cp\cp_persistence::get_player_currency();
    var_07 = int(var_06 * 0.1);
    var_05 scripts\cp\cp_persistence::take_player_currency(var_07, 1, "bleedoutPenalty");
  }

  var_09 = wait_to_be_revived(self, var_02, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, param_01, 0);
  show_all_revive_icons(self);
  self.spectating = undefined;
  scripts\cp\utility::updatesessionstate("playing");
  self.forcespawnorigin = var_02;
  self.forcespawnangles = var_03;
  if(isDefined(level.prespawnfromspectaorfunc)) {
    [[level.prespawnfromspectaorfunc]](self);
  }

  scripts\cp\cp_globallogic::spawnplayer();
}

record_bleedout(param_00) {
  scripts\cp\cp_persistence::eog_player_update_stat("deaths", 1);
  scripts\cp\cp_challenge::update_challenge("no_bleedout");
  if(!is_killed_by_kill_trigger(param_00)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
  }
}

wait_for_self_revive(param_00, param_01) {
  if(param_01) {
    level waittill("forever");
    clear_last_stand_timer(self);
    return 0;
  }

  if(is_killed_by_kill_trigger(param_00)) {
    self setorigin(param_00.origin);
  } else {
    wait(5);
  }

  clear_last_stand_timer(self);
  return 1;
}

wait_to_be_revived(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = makereviveentity(param_00, param_01, param_02, param_03, param_04);
  if(param_08) {
    thread enter_spectate(param_00, param_01, var_0C);
  }

  if(param_09) {
    level waittill("forever");
    return 0;
  }

  var_0D = var_0C;
  if(param_08) {
    var_0D = makereviveiconentity(param_00, var_0C);
  }

  if(param_0A) {
    var_0D makereviveicon(var_0D, param_00, param_06, param_07);
  }

  param_00.reviveent = var_0C;
  param_00.reviveiconent = var_0D;
  if(isDefined(level.wait_to_be_revived_func)) {
    var_0E = [[level.wait_to_be_revived_func]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    if(isDefined(var_0E)) {
      return var_0E;
    }
  }

  if(param_0A) {
    var_0C thread laststandwaittillrevivebyteammate(param_00, param_05);
  }

  if(isDefined(param_07)) {
    var_0E = var_0C scripts\cp\utility::waittill_any_ents_or_timeout_return(param_07, var_0C, "revive_success", param_00, "force_bleed_out", param_00, "revive_success", param_00, "challenge_complete_revive");
  } else {
    var_0E = var_0D scripts\cp\utility::waittill_any_ents_return(var_0D, "revive_success", param_01, "challenge_complete_revive");
  }

  if(var_0E == "timeout" && is_being_revived(param_00)) {
    var_0E = var_0C scripts\engine\utility::waittill_any_return("revive_success", "revive_fail");
  }

  if(var_0E == "revive_success" || var_0E == "challenge_complete_revive") {
    return 1;
  }

  return 0;
}

laststandwaittillrevivebyteammate(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self makeusable();
    self waittill("trigger", var_02);
    self makeunusable();
    if(!var_02 isonground()) {
      continue;
    }

    if(var_02 ismeleeing()) {
      continue;
    }

    if(!isplayer(var_02) && !scripts\engine\utility::istrue(var_02.can_revive)) {
      continue;
    }

    var_03 = getrevivetimescaler(var_02, param_00);
    var_04 = int(param_01 / var_03);
    var_05 = get_revive_result(param_00, var_02, self.origin, var_04);
    if(var_05) {
      if(isDefined(var_02.vo_prefix)) {
        if(param_00.vo_prefix == "p4_" && soundexists(var_02.vo_prefix + "respawn_laststand_valleygirl")) {
          var_02 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_valleygirl", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else if(param_00.vo_prefix == "p1_" && soundexists(var_02.vo_prefix + "respawn_laststand_aj")) {
          var_02 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_aj", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else if(level.script == "cp_town") {
          if(var_02.vo_prefix == "p1_") {
            param_00 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand_sally", "town_comment_vo");
          }
        } else {
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        }
      }

      if(param_00 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
        param_00 scripts\cp\utility::notify_used_consumable("faster_revive_upgrade");
      }

      var_02 playlocalsound("revive_teammate");
      record_revive_success(var_02, param_00);
      var_02 notify("revive_teammate", param_00);
      if(isplayer(var_02) && scripts\engine\utility::istrue(var_02.can_give_revive_xp)) {
        var_02.can_give_revive_xp = 0;
        var_02 scripts\cp\cp_persistence::give_player_xp(int(250), 1);
      }

      break;
    } else {
      self notify("revive_fail");
      continue;
    }
  }

  clear_last_stand_timer(param_00);
  self notify("revive_success");
}

getrevivetimescaler(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.can_revive)) {
    return 2;
  }

  var_02 = param_00 scripts\cp\perks\perk_utility::perk_getrevivetimescalar();
  if(param_01 scripts\cp\utility::is_consumable_active("faster_revive_upgrade")) {
    var_02 = var_02 * 2;
  }

  return var_02;
}

func_B529(param_00, param_01) {
  instant_revive(param_01);
  record_revive_success(param_00, param_01);
}

record_revive_success(param_00, param_01) {
  if(isplayer(param_00)) {
    param_00 scripts\cp\cp_merits::processmerit("mt_reviver");
    param_00 scripts\cp\cp_persistence::increment_player_career_revives(param_00);
    param_00 scripts\cp\cp_merits::processmerit("mt_revives");
    param_00 scripts\cp\cp_persistence::eog_player_update_stat("revives", 1);
    param_01 thread scripts\cp\cp_hud_message::showsplash("revived", undefined, param_00);
    if(isDefined(level.revive_success_analytics_func)) {
      [
        [level.revive_success_analytics_func]
      ](param_00);
    }
  }
}

makereviveentity(param_00, param_01, param_02, param_03, param_04) {
  var_05 = (0, 0, 20);
  param_01 = scripts\engine\utility::drop_to_ground(param_01 + var_05, 32, -64);
  var_06 = spawn("script_model", param_01);
  var_06 setcursorhint("HINT_NOICON");
  var_06 sethintstring( & "PLATFORM_REVIVE");
  var_06.triggerportableradarping = param_00;
  var_06.inuse = 0;
  var_06.var_336 = "revive_trigger";
  if(isDefined(param_02)) {
    var_06 setModel(param_02);
  }

  if(isDefined(param_03)) {
    var_06 scriptmodelplayanim(param_03);
  }

  if(param_04) {
    var_06 linkto(param_00, "tag_origin", var_05, (0, 0, 0));
  }

  var_06 thread cleanupreviveent(param_00);
  return var_06;
}

makereviveiconentity(param_00, param_01) {
  var_02 = (0, 0, 30);
  var_03 = spawn("script_model", param_01.origin + var_02);
  var_03 thread cleanupreviveent(param_00);
  return var_03;
}

maydolaststand(param_00, param_01) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_maydolaststand(param_00, param_01);
  }

  return coop_maydolaststand(param_01);
}

solo_maydolaststand(param_00, param_01) {
  if(param_00 && is_killed_by_kill_trigger(param_01)) {
    return 0;
  }

  return 1;
}

coop_maydolaststand(param_00) {
  if(is_killed_by_kill_trigger(param_00)) {
    return 0;
  }

  return 1;
}

only_use_weapon() {
  if(scripts\engine\utility::istrue(self.iscarrying)) {
    wait(0.5);
  }

  var_00 = get_last_stand_pistol();
  if(self hasweapon(var_00)) {
    self takeweapon(var_00);
  }

  scripts\cp\utility::_giveweapon(var_00, scripts\cp\utility::get_weapon_variant_id(self, var_00), 0, 1);
  var_01 = ["iw7_knife_zm", "iw7_knife_zm_hoff", "iw7_knife_zm_jock", "iw7_knife_zm_vgirl", "iw7_knife_zm_rapper", "iw7_knife_zm_nerd", "iw7_knife_zm_wyler", "iw7_knife_zm_schoolgirl", "iw7_knife_zm_scientist", "iw7_knife_zm_soldier", "iw7_knife_zm_rebel", "iw7_knife_zm_elvira", "iw7_knife_zm_crowbar", "iw7_knife_zm_cleaver", "iw7_knife_zm_chola", "iw7_knife_zm_raver", "iw7_knife_zm_grunge", "iw7_knife_zm_hiphop", "iw7_knife_zm_kevinsmith", "iw7_knife_zm_disco"];
  var_02 = can_use_pistol_during_last_stand(self);
  if(var_02) {
    var_01[var_01.size] = var_00;
  }

  _takeweaponsexceptlist(var_01);
  var_03 = get_number_of_last_stand_clips();
  if(var_02) {
    var_04 = self getrunningforwardpainanim(var_00);
    var_05 = weaponclipsize(var_00);
    self setweaponammostock(var_00, var_05 * var_03);
    self setweaponammoclip(var_00, var_05);
    self switchtoweaponimmediate(var_00);
  }
}

get_number_of_last_stand_clips() {
  return 2;
}

get_last_stand_pistol() {
  if(isDefined(self.last_stand_pistol)) {
    return self.last_stand_pistol;
  }

  var_00 = self.default_starting_pistol;
  var_01 = self getweaponslistprimaries()[0];
  if(scripts\cp\utility::getbaseweaponname(var_00) == scripts\cp\utility::getbaseweaponname(var_01)) {
    return var_01;
  }

  return var_00;
}

can_use_pistol_during_last_stand(param_00) {
  if(isDefined(level.can_use_pistol_during_laststand_func)) {
    return [[level.can_use_pistol_during_laststand_func]](param_00);
  }

  return 1;
}

cleanupreviveent(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect", "revive");
  self delete();
}

remove_from_owner_revive_icon_list(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  param_01.revive_icons = scripts\engine\utility::array_remove(param_01.revive_icons, param_00);
}

default_player_init_laststand() {
  init_revive_icon_list(self);
}

func_9730(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(5);
  var_01 = get_last_stand_count();
}

give_laststand(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_02 = param_00 get_last_stand_count() + param_01;
  set_last_stand_count(param_00, var_02);
}

take_laststand(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_02 = param_00 get_last_stand_count() - param_01;
  set_last_stand_count(param_00, max(var_02, 0));
}

gameshouldend(param_00) {
  if(param_00 self_revive_activated()) {
    return 0;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && param_00 scripts\cp\utility::has_zombie_perk("perk_machine_revive") || scripts\engine\utility::istrue(level.the_hoff_revive)) {
    return 0;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return solo_gameshouldend(param_00);
  }

  return coop_gameshouldend(param_00);
}

solo_gameshouldend(param_00) {
  if(player_in_laststand(param_00)) {
    return 0;
  }

  return param_00 get_last_stand_count() == 0;
}

coop_gameshouldend(param_00) {
  return everyone_else_all_in_laststand(param_00);
}

everyone_else_all_in_laststand(param_00) {
  foreach(var_02 in level.players) {
    if(var_02 == param_00) {
      continue;
    }

    if(!player_in_laststand(var_02)) {
      return 0;
    }
  }

  return 1;
}

get_revive_result(param_00, param_01, param_02, param_03) {
  var_04 = createuseent(param_02);
  var_04 thread cleanupreviveent(param_00);
  var_05 = revive_use_hold_think(param_00, param_01, var_04, param_03);
  return var_05;
}

createuseent(param_00) {
  var_01 = spawn("script_origin", param_00);
  var_01.curprogress = 0;
  var_01.usetime = 0;
  var_01.userate = 8000;
  var_01.inuse = 0;
  return var_01;
}

playdeathsoundinlaststand(param_00) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  scripts\cp\utility::playdeathsound();
  wait(param_00 / 3);
  scripts\cp\utility::playdeathsound();
  wait(param_00 / 3);
  thread scripts\cp\cp_vo::try_to_play_vo("laststand_bleedout", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  scripts\cp\utility::playdeathsound();
}

enter_spectate(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  level endon("game_ended");
  if(isDefined(param_00.carryicon)) {
    param_00.carryicon destroy();
  }

  param_00.has_building_upgrade = 0;
  enter_camera_zoomout();
  camera_zoomout(param_00, param_01, param_02);
  exit_camera_zoomout();
}

camera_zoomout(param_00, param_01, param_02) {
  param_02 endon("revive_success");
  var_03 = (0, 0, 30);
  var_04 = (0, 0, 100);
  var_05 = (0, 0, 400);
  var_06 = 2;
  var_07 = 0.6;
  var_08 = 0.6;
  var_09 = param_01 + var_03;
  var_0A = bulletTrace(var_09, var_09 + var_04, 0, param_00);
  var_0B = var_0A["position"];
  var_0A = bulletTrace(var_0B, var_0B + var_05, 0, param_00);
  var_0C = var_0A["position"];
  var_0D = spawn("script_model", var_0B);
  var_0D setModel("tag_origin");
  var_0D.angles = vectortoangles((0, 0, -1));
  var_0D thread cleanupreviveent(param_00);
  param_00 cameralinkto(var_0D, "tag_origin");
  var_0D moveto(var_0C, var_06, var_07, var_08);
  var_0D waittill("movedone");
  var_0D delete();
  param_00 enter_bleed_out(param_00);
}

enter_bleed_out(param_00) {
  hide_all_revive_icons(param_00);
  if(isDefined(level.player_bleed_out_func)) {
    param_00[[level.player_bleed_out_func]](param_00);
    return;
  }

  param_00 scripts\cp\cp_globallogic::enterspectator();
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

revive_use_hold_think(param_00, param_01, param_02, param_03) {
  if(isDefined(param_01.vo_prefix)) {
    if(param_00.vo_prefix == "p1_" && soundexists(param_01.vo_prefix + "reviving_valleygirl")) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("reviving_valleygirl", "zmb_comment_vo");
    } else if(param_00.vo_prefix == "p1_" && soundexists(param_01.vo_prefix + "reviving_sally")) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("reviving_sally", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("reviving", "zmb_comment_vo");
    }
  }

  enter_revive_use_hold_think(param_00, param_01, param_02, param_03);
  if(!isDefined(level.the_hoff) || isDefined(level.the_hoff) && param_01 != level.the_hoff) {
    play_revive_gesture(param_01, param_00);
  }

  thread wait_for_exit_revive_use_hold_think(param_00, param_01, param_02, param_01 scripts\cp\utility::getvalidtakeweapon());
  param_00.reviver = param_01;
  var_04 = 0;
  var_05 = 0;
  enable_on_world_progress_bar_for_other_players(param_00, param_01);
  if(isplayer(param_01)) {
    param_00 notify("reviving");
  }

  while(should_revive_continue(param_01)) {
    if(var_04 >= param_03) {
      var_05 = 1;
      break;
    }

    var_06 = var_04 / param_03;
    update_players_revive_progress_bar(param_00, param_01, var_06);
    var_04 = var_04 + 50;
    scripts\engine\utility::waitframe();
  }

  disable_on_world_progress_bar_for_other_players(param_00, param_01);
  param_02 notify("use_hold_think_complete");
  param_02 waittill("exit_use_hold_think_complete");
  return var_05;
}

play_revive_gesture(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.hasentanglerequipped)) {
    return;
  }

  param_00 giveweapon("iw7_gunless_zm");
  param_00 switchtoweapon("iw7_gunless_zm");
  param_00 allowmelee(0);
  param_00 getraidspawnpoint();
  param_00 forceplaygestureviewmodel(get_revive_gesture(param_00), param_01);
}

stop_revive_gesture(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.hasentanglerequipped)) {
    return;
  }

  param_00 takeweapon("iw7_gunless_zm");
  param_00 enableweaponswitch();
  param_00 switchtoweapon(param_01);
  param_00 allowmelee(1);
  param_00 stopgestureviewmodel(get_revive_gesture(param_00));
}

get_revive_gesture(param_00) {
  if(isDefined(param_00.revive_gesture)) {
    return param_00.revive_gesture;
  }

  return "ges_zombies_revive_nerd";
}

update_players_revive_progress_bar(param_00, param_01, param_02) {
  foreach(var_04 in level.players) {
    if(var_04 == param_00 || var_04 == param_01) {
      var_04 setclientomnvar("ui_securing_progress", param_02);
      continue;
    }

    var_04 setclientomnvar("zm_revive_bar_" + param_00.revive_progress_bar_id + "_progress", param_02);
  }
}

enter_revive_use_hold_think(param_00, param_01, param_02, param_03) {
  param_00 setclientomnvar("ui_securing", 4);
  param_01 setclientomnvar("ui_securing", 3);
  param_00.being_revived = 1;
  if(isplayer(param_01)) {
    param_01 playerlinkto(param_02);
    param_01 playerlinkedoffsetenable();
    param_01 scripts\cp\powers\coop_powers::power_disablepower();
    param_01 thread play_rescue_anim(param_01);
  }

  param_01.isreviving = 1;
}

wait_for_exit_revive_use_hold_think(param_00, param_01, param_02, param_03) {
  scripts\engine\utility::waittill_any_ents(param_02, "use_hold_think_complete", param_00, "disconnect", param_00, "revive_success", param_00, "force_bleed_out", param_01, "challenge_complete", param_00, "death");
  if(scripts\cp\utility::isreallyalive(param_00)) {
    param_00.being_revived = 0;
    param_00 setclientomnvar("ui_securing", 0);
  }

  param_01.isreviving = 0;
  if(isplayer(param_01)) {
    param_01 stop_revive_gesture(param_01, param_03);
    param_01 setclientomnvar("ui_securing", 0);
    param_01 scripts\cp\powers\coop_powers::power_enablepower();
    param_01 unlink();
    param_01 notify("stop_revive");
  }

  param_02 notify("exit_use_hold_think_complete");
}

play_rescue_anim(param_00) {
  param_00 endon("disconnect");
  param_00 endon("stop_playing_revive_anim");
  param_00 playanimscriptevent("power_active_cp", "gesture015");
}

should_revive_continue(param_00) {
  if(scripts\engine\utility::istrue(param_00.can_revive)) {
    return 1;
  }

  return !level.gameended && scripts\cp\utility::isreallyalive(param_00) && param_00 usebuttonpressed() && !player_in_laststand(param_00);
}

_takeweaponsexceptlist(param_00) {
  var_01 = self getweaponslistall();
  foreach(var_03 in var_01) {
    if(scripts\engine\utility::array_contains(param_00, var_03)) {
      continue;
    } else if(!scripts\cp\utility::isstrstart(var_03, "alt_")) {
      self takeweapon(var_03);
    }
  }
}

is_killed_by_kill_trigger(param_00) {
  return isDefined(param_00);
}

set_last_stand_count(param_00, param_01) {
  param_01 = int(param_01);
  param_00 setplayerdata("cp", "alienSession", "last_stand_count", param_01);
}

set_last_stand_timer(param_00, param_01) {
  param_00 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + param_01 * 1000);
}

clear_last_stand_timer(param_00) {
  param_00 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
}

instant_revive(param_00) {
  param_00 notify("revive_success");
  if(isDefined(param_00.reviveent)) {
    param_00.reviveent notify("revive_success");
  }

  if(is_being_revived(param_00)) {
    disable_on_world_progress_bar_for_other_players(param_00, param_00.reviver);
  }

  clear_last_stand_timer(param_00);
}

set_revive_time(param_00, param_01) {
  if(isDefined(param_00)) {
    level.normal_revive_time = param_00;
  }

  if(isDefined(param_01)) {
    level.spectator_revive_time = param_01;
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

get_currency_penalty_amount(param_00) {
  if(isDefined(level.laststand_currency_penalty_amount_func)) {
    return [[level.laststand_currency_penalty_amount_func]](param_00);
  }

  return 500;
}

makereviveicon(param_00, param_01, param_02, param_03) {
  setup_revive_icon_ent(param_00);
  param_00.current_revive_icon_color = param_02;
  param_00 thread reviveiconentcleanup(param_00);
  var_04 = undefined;
  foreach(var_06 in level.players) {
    if(var_06 == param_01) {
      continue;
    }

    var_04 = show_revive_icon_to_player(param_00, var_06);
    add_to_revive_icon_ent_icon_list(param_00, var_04);
  }

  if(isDefined(param_03)) {
    param_00 thread revive_icon_color_management(param_03);
  }

  return var_04;
}

show_revive_icon_to_player(param_00, param_01) {
  var_02 = newclienthudelem(param_01);
  var_02 setshader("waypoint_alien_revive", 8, 8);
  var_02 setwaypoint(1, 1);
  var_02 settargetent(param_00);
  var_02.alpha = get_revive_icon_initial_alpha(param_01);
  var_02.color = param_00.current_revive_icon_color;
  add_to_player_revive_icon_list(param_01, var_02);
  var_02 thread reviveiconcleanup(param_00, param_01);
  return var_02;
}

reviveiconentcleanup(param_00) {
  param_00 waittill("death");
  remove_from_revive_icon_entity_list(param_00);
}

reviveiconcleanup(param_00, param_01) {
  scripts\cp\utility::waittill_any_ents_return(param_00, "death", param_01, "disconnect");
  remove_from_owner_revive_icon_list(self, param_01);
  if(isDefined(self)) {
    self destroy();
  }
}

revive_icon_color_management(param_00) {
  self endon("death");
  level endon("game_ended");
  wait(param_00 / 3);
  set_revive_icon_color(self, (1, 0.941, 0));
  wait(param_00 / 3);
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
}

set_revive_icon_color(param_00, param_01) {
  param_00.current_revive_icon_color = param_01;
  param_00.revive_icons = scripts\engine\utility::array_removeundefined(param_00.revive_icons);
  foreach(var_03 in param_00.revive_icons) {
    var_03.color = param_01;
  }
}

init_laststand() {
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  level thread revive_icon_player_connect_monitor();
}

add_to_revive_icon_entity_list(param_00) {
  level.revive_icon_entities[level.revive_icon_entities.size] = param_00;
}

remove_from_revive_icon_entity_list(param_00) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, param_00);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

revive_icon_player_connect_monitor() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    foreach(var_02 in level.revive_icon_entities) {
      show_revive_icon_to_player(var_02, var_00);
    }

    foreach(var_05 in level.players_being_revived) {
      if(isDefined(var_05)) {
        var_00 setclientomnvar("zm_revive_bar_" + var_05.revive_progress_bar_id + "_target", var_05);
      }
    }
  }
}

setup_revive_icon_ent(param_00) {
  param_00.revive_icons = [];
  add_to_revive_icon_entity_list(param_00);
}

add_to_revive_icon_ent_icon_list(param_00, param_01) {
  param_00.revive_icons[param_00.revive_icons.size] = param_01;
}

init_revive_icon_list(param_00) {
  param_00.revive_icons = [];
}

add_to_player_revive_icon_list(param_00, param_01) {
  param_00.revive_icons[param_00.revive_icons.size] = param_01;
}

remove_from_player_revive_icon_list(param_00, param_01) {
  param_00.revive_icons = scripts\engine\utility::array_remove(param_00.revive_icons, param_01);
}

get_revive_icon_initial_alpha(param_00) {
  if(isDefined(level.var_E49D)) {
    return [[level.var_E49D]](param_00);
  }

  return 1;
}

show_all_revive_icons(param_00) {
  foreach(var_02 in param_00.revive_icons) {
    var_02.alpha = 1;
  }
}

hide_all_revive_icons(param_00) {
  foreach(var_02 in param_00.revive_icons) {
    var_02.alpha = 0;
  }
}

enable_on_world_progress_bar_for_other_players(param_00, param_01) {
  var_02 = add_to_players_being_revived(param_00);
  var_03 = "zm_revive_bar_" + var_02 + "_target";
  foreach(var_05 in level.players) {
    if(var_05 == param_00 || var_05 == param_01) {
      continue;
    }

    var_05 setclientomnvar(var_03, param_00);
  }
}

disable_on_world_progress_bar_for_other_players(param_00, param_01) {
  var_02 = "zm_revive_bar_" + param_00.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(param_00);
  foreach(var_04 in level.players) {
    if(var_04 == param_00 || var_04 == param_01) {
      continue;
    }

    var_04 setclientomnvar(var_02, undefined);
  }
}

self_revive_activated() {
  return isDefined(self.self_revive) && self.self_revive > 0;
}

add_to_players_being_revived(param_00) {
  var_01 = 0;
  while(var_01 < 2) {
    if(!isDefined(level.players_being_revived[var_01])) {
      level.players_being_revived[var_01] = param_00;
      var_02 = var_01 + 1;
      param_00.revive_progress_bar_id = var_02;
      return var_02;
    }

    var_02++;
  }
}

remove_from_players_being_revived(param_00) {
  for(var_01 = 0; var_01 < 2; var_01++) {
    if(isDefined(level.players_being_revived[var_01]) && level.players_being_revived[var_01] == param_00) {
      level.players_being_revived[var_01] = undefined;
      param_00.revive_progress_bar_id = undefined;
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

is_being_revived(param_00) {
  return scripts\engine\utility::istrue(param_00.being_revived);
}

player_in_laststand(param_00) {
  return param_00.inlaststand;
}

enable_self_revive(param_00) {
  if(!isDefined(param_00.self_revive)) {
    param_00.self_revive = 0;
  }

  param_00.self_revive++;
}

disable_self_revive(param_00) {
  param_00.self_revive--;
}

self_revive(param_00) {
  param_00 scripts\engine\utility::waittill_any_timeout_1(3, "revive_success");
  return 1;
}

give_fists_if_no_real_weapon(param_00) {
  if(has_no_real_weapon(param_00)) {
    var_01 = get_fists_weapon(param_00);
    if(var_01 != "iw7_fists_zm" && param_00 hasweapon("iw7_fists_zm")) {
      param_00 takeweapon("iw7_fists_zm");
    }

    self giveweapon(var_01);
    self switchtoweaponimmediate(var_01);
    if(is_valid_spawn_weapon(var_01)) {
      self setspawnweapon(var_01, 1);
    }
  }
}

get_fists_weapon(param_00) {
  if(isDefined(level.get_fists_weapon_func)) {
    return [[level.get_fists_weapon_func]](param_00);
  }

  return "iw7_fists_zm";
}

is_valid_spawn_weapon(param_00) {
  if(isDefined(level.is_valid_spawn_weapon_func)) {
    return [[level.is_valid_spawn_weapon_func]](param_00);
  }

  return 1;
}

has_no_real_weapon(param_00) {
  var_01 = param_00 getweaponslistall();
  foreach(var_03 in var_01) {
    if(var_03 == "super_default_zm") {
      continue;
    }

    if(issubstr(var_03, "knife")) {
      continue;
    }

    if(var_03 == "iw7_fists_zm") {
      continue;
    }

    return 0;
  }

  return 1;
}