/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_laststand.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\alien\_utility;
#include maps\mp\_utility;

CONST_AFTER_REVIVE_DAMAGE_SHIELD_TIME = 3000;
CONST_SELF_REVIVE_WAIT = 5;
CONST_BLEED_OUT_TIME = 35;
CONST_SPECTATOR_REVIVE_TIME = 6000;
CONST_NORMAL_REVIVE_TIME = 5000;
CONST_REVIVE_PENALTY = 2000;
CONST_REVIVE_TIME_CAP = 10000;
CONST_CURRENCY_PENALTY = 500;
CONST_INITIAL_LASTSTANDS = 1;

CONST_FAST_REVIVE_UPGRADE_SCALAR = 1.20;

CONST_BLACK_VISION_SET = "black_bw";
CONST_B_AND_W_VISION_SET = "cheat_bw";
CONST_BLEED_OUT_DOGTAG_MODEL = "prop_dogtags_friend_iw6";
CONST_BLEED_OUT_DOGTAG_MODEL_ANIM = "mp_dogtag_spin";

UI_REVIVING = 3;
UI_DOWNEDPLAYER = 4;

DROP_TO_GROUND_UP_DIST = 32;
DROP_TO_GROUND_DOWN_DIST = -64;

Callback_PlayerLastStandAlien(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, bleedOutSpawnEntity) {
  blackBox_lastStand(attacker, iDamage);

  if(maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_chaos_laststand::chaos_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity);
  else
    regularExtinction_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity);
}

regularExtinction_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity) {
  gameShouldEnd = gameShouldEnd(self);

  if(gameShouldEnd)
    level thread maps\mp\gametypes\aliens::AlienEndGame("axis", maps\mp\alien\_hud::get_end_game_string_index("kia"));

  if(self.inLastStand)
    forceBleedOut(bleedOutSpawnEntity);
  else
    dropIntoLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity, gameShouldEnd);
}

forceBleedOut(bleedOutSpawnEntity) {
  Assert(is_killed_by_kill_trigger(bleedOutSpawnEntity));

  if(isPlayingSolo())
    self setOrigin(bleedOutSpawnEntity.origin);

  self.bleedOutSpawnEntityOverride = bleedOutSpawnEntity;

  self notify("force_bleed_out");
}

dropIntoLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity, gameShouldEnd) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("last_stand");

  enter_GamemodeSpecificAction();

  enter_laststand();

  if(mayDoLastStandAlien(self, gameShouldEnd, bleedOutSpawnEntity)) {
    revived = waitInLastStand(bleedOutSpawnEntity, gameShouldEnd);

    if(!revived)
      waitInSpecator(bleedOutSpawnEntity, gameShouldEnd);
  } else {
    waitInSpecator(bleedOutSpawnEntity, gameShouldEnd);
  }

  self notify("revive");

  exit_laststand();

  exit_GamemodeSpecificAction();
}

enter_laststand() {
  self.inLastStand = true;
  self.lastStand = true;
  self.ignoreme = true;
  self.health = 1;
  self _disableUsability();
}

exit_laststand() {
  self LastStandRevive();
  self setStance("stand");

  self.inLastStand = false;
  self.lastStand = undefined;
  self.ignoreme = false;
  self.health = maps\mp\gametypes\aliens::getHealthCap();
  self _enableUsability();
}

enter_GamemodeSpecificAction_GetCurrentWeapon(exclusion_list) {
  lastWeapon = self GetCurrentWeapon();

  if(lastWeapon == "none") {
    return self.copy_fullweaponlist[0];
  }

  foreach(excluded_weapon in exclusion_list) {
    if(lastWeapon == excluded_weapon) {
      return self.copy_fullweaponlist[0];
    }
  }

  return lastWeapon;
}

enter_GamemodeSpecificAction() {
  level thread maps\mp\alien\_music_and_dialog::playVOForDowned(self);
  maps\mp\alien\_gamescore::update_team_encounter_performance(maps\mp\alien\_gamescore::get_team_score_component_name(), "num_players_enter_laststand");

  weapons_excluded = ["alienbomb_mp",
    "killstreak_remote_uav_mp",
    "mortar_detonator_mp",
    "switchblade_laptop_mp",
    "aliendeployable_crate_marker_mp",
    "iw6_alienminigun_mp",
    "iw6_alienminigun1_mp",
    "iw6_alienminigun2_mp",
    "iw6_alienminigun3_mp",
    "iw6_alienminigun4_mp",
    "iw6_alienmk32_mp",
    "iw6_alienmk321_mp",
    "iw6_alienmk322_mp",
    "iw6_alienmk323_mp",
    "iw6_alienmk324_mp",
    "alienflare_mp",
    "aliensemtex_mp",
    "alienclaymore_mp",
    "alientrophy_mp",
    "alienbetty_mp",
    "alienthrowingknife_mp",
    "iw6_alienmaaws_mp",
    "alienmortar_shell_mp",
    "iw6_aliendlc21_mp",
    "iw6_aliendlc22_mp",
    "iw6_aliendlc31_mp",
    "iw6_aliendlc32_mp",
    "iw6_aliendlc33_mp",
    "iw6_aliendlc43_mp",
    "aliencortex_mp"
  ];

  self store_weapons_status(weapons_excluded);
  self.lastWeapon = enter_GamemodeSpecificAction_GetCurrentWeapon(weapons_excluded);
  self.bleedOutSpawnEntityOverride = undefined;
  self.laststand_pistol = self GetWeaponsListPrimaries()[0];
  self.being_revived = false;
  self thread only_use_weapon();
  self maps\mp\alien\_persistence::take_player_currency(CONST_CURRENCY_PENALTY, true);
  self maps\mp\alien\_persistence::eog_player_update_stat("downs", 1);
  self maps\mp\alien\_alien_matchdata::inc_downed_counts();

  maps\mp\alien\_challenge::update_challenge("no_laststand");

  self setClientOmnvar("ui_alien_player_in_laststand", true);

  self maps\mp\alien\_hud::update_hud_laststand_count();
}

exit_GamemodeSpecificAction() {
  self thread maps\mp\alien\_music_and_dialog::ext_last_stand_sfx();
  self.haveInvulnerabilityAvailable = true;
  self.damageShieldExpireTime = getTime() + CONST_AFTER_REVIVE_DAMAGE_SHIELD_TIME;
  self VisionSetNakedForPlayer("", 0);
  self maps\mp\alien\_utility::restore_client_fog(0);
  self maps\mp\alien\_progression::restore_all_perks();

  if(alien_mode_has("nogame")) {
    self.laststand_ammo = WeaponMaxAmmo(self.laststand_pistol);
    self.laststand_clip_ammo = WeaponClipSize(self.laststand_pistol);
  }

  self SetWeaponAmmoStock(self.laststand_pistol, self.laststand_ammo);
  self SetWeaponAmmoClip(self.laststand_pistol, self.laststand_clip_ammo);

  inclusion_list = ["alienflare_mp",
    "aliensemtex_mp",
    "alienclaymore_mp",
    "alientrophy_mp",
    "alienbetty_mp",
    "alienthrowingknife_mp",
    "alienmortar_shell_mp",
    "iw6_aliendlc21_mp",
    "iw6_aliendlc22_mp",
    "iw6_aliendlc31_mp",
    "iw6_aliendlc32_mp",
    "iw6_aliendlc43_mp",
    "iw6_aliendlc33_mp"
  ];

  self restore_weapons_status(inclusion_list);

  self setClientOmnvar("ui_alien_player_in_laststand", false);
  self.laststand_ammo = undefined;
  self.bleedOutSpawnEntityOverride = undefined;
  self maps\mp\alien\_alien_matchdata::inc_revived_counts();
  self SetSpawnWeapon(self.lastWeapon);
  maps\mp\alien\_death::set_kill_trigger_event_processed(self, false);

  if(is_chaos_mode())
    maps\mp\alien\_chaos_laststand::chaos_exit_GamemodeSpecificAction(self);
}

waitInLastStand(bleedOutSpawnEntity, gameShouldEnd) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if(self maps\mp\alien\_debug::shouldSelfRevive())
    return debug_self_revive();

  if(!gameShouldEnd) {
    self visionFadeToBlack(CONST_BLEED_OUT_TIME);
    self thread playDeathSoundInLastStand(CONST_BLEED_OUT_TIME);

    if(isPlayingSolo()) {
      take_lastStand(self, 1);
      self setClientOmnvar("ui_laststand_end_milliseconds", gettime() + (CONST_SELF_REVIVE_WAIT * 1000));
      register_laststand_ammo();
    } else {
      self setClientOmnvar("ui_laststand_end_milliseconds", gettime() + (CONST_BLEED_OUT_TIME * 1000));
    }
  }

  if(isPlayingSolo())
    return (wait_for_self_revive(bleedOutSpawnEntity, gameShouldEnd));
  else
    return (wait_to_be_revived(self, self.origin, undefined, undefined, true, CONST_NORMAL_REVIVE_TIME, (0.33, 0.75, 0.24), CONST_BLEED_OUT_TIME, false, gameShouldEnd));
}

waitInSpecator(bleedOutSpawnEntity, gameShouldEnd) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("death");

  register_laststand_ammo();

  waitframe();

  level.alienBBData["times_died"]++;
  self maps\mp\alien\_persistence::eog_player_update_stat("deaths", 1);

  if(isDefined(self.bleedOutSpawnEntityOverride)) {
    bleedOutSpawnEntity = self.bleedOutSpawnEntityOverride;
    self.bleedOutSpawnEntityOverride = undefined;
  }

  if(is_killed_by_kill_trigger(bleedOutSpawnEntity)) {
    spawnLoc = drop_to_ground(bleedOutSpawnEntity.origin, DROP_TO_GROUND_UP_DIST, DROP_TO_GROUND_DOWN_DIST);
    spawnAngle = bleedOutSpawnEntity.angles;
  } else {
    maps\mp\alien\_gamescore::update_team_encounter_performance(maps\mp\alien\_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    maps\mp\alien\_alien_matchdata::inc_bleedout_counts();

    spawnLoc = self.origin;
    spawnAngle = self.angles;
  }

  maps\mp\alien\_challenge::update_challenge("no_bleedout");
  self setClientOmnvar("ui_laststand_end_milliseconds", 0);

  result = wait_to_be_revived(self, spawnLoc, CONST_BLEED_OUT_DOGTAG_MODEL, CONST_BLEED_OUT_DOGTAG_MODEL_ANIM, false, CONST_SPECTATOR_REVIVE_TIME, (1.0, 0, 0), undefined, true, gameShouldEnd);
  assert(result == true);

  self updateSessionState("playing");

  self.forceSpawnOrigin = spawnLoc;
  self.forceSpawnAngles = spawnAngle;

  if(isDefined(self.forceTeleportOrigin))
    self.forceSpawnOrigin = self.forceTeleportOrigin;
  if(isDefined(self.forceTeleportAngles))
    self.forceSpawnAngles = self.forceTeleportAngles;

  self maps\mp\gametypes\_playerlogic::spawnPlayer(true);
}

wait_for_self_revive(bleedOutSpawnEntity, gameShouldEnd) {
  if(gameShouldEnd) {
    level waittill("forever");
    self setClientOmnvar("ui_laststand_end_milliseconds", 0);
    return false;
  }

  if(is_killed_by_kill_trigger(bleedOutSpawnEntity))
    self setOrigin(bleedOutSpawnEntity.origin);
  else
    wait CONST_SELF_REVIVE_WAIT;

  self setClientOmnvar("ui_laststand_end_milliseconds", 0);
  return true;
}

wait_to_be_revived(downedPlayer, spawnLoc, entityModel, entityModelAnim, linkToOwner, reviveTime, iconColor, timeLimit, shouldSpectate, gameShouldEnd, isChaosMode) {
  register_laststand_ammo();

  reviveEnt = makeReviveEntity(downedPlayer, spawnLoc, entityModel, entityModelAnim, linkToOwner);
  reviveEnt thread cleanUpReviveEnt(downedPlayer);

  if(is_true(isChaosMode))
    self _disableWeapon();

  if(shouldSpectate)
    self thread enter_spectate(downedPlayer, spawnLoc, reviveEnt);

  if(gameShouldEnd) {
    level waittill("forever");

    return false;
  } else {
    reviveIconEnt = reviveEnt;

    if(shouldSpectate)
      reviveIconEnt = makeReviveIconEntity(downedPlayer, reviveEnt);

    reviveIconEnt maps\mp\alien\_hud::makeReviveIcon(downedPlayer, iconColor, timeLimit);

    downedPlayer.reviveEnt = reviveEnt;
    downedPlayer.reviveIconEnt = reviveIconEnt;

    reviveEnt thread lastStandWaittillLifeReceived(downedPlayer, reviveTime);

    if(isDefined(timeLimit))
      result = reviveEnt waittill_any_ents_or_timeout_return(timeLimit, reviveEnt, "revive_success", downedPlayer, "force_bleed_out", downedPlayer, "revive_success");
    else if(!isDefined(timelimit) && is_true(isChaosMode))
      result = reviveEnt waittill_any_ents_return(reviveEnt, "revive_success", downedPlayer, "force_bleed_out", downedPlayer, "revive_success");
    else
      result = reviveEnt waittill_any_return("revive_success");

    if(result == "timeout" && is_being_revived(downedPlayer))
      result = reviveEnt waittill_any_return("revive_success", "revive_fail");

    if(result == "revive_success") {
      if(is_true(isChaosMode))
        self _enableWeapon();
      return true;
    } else
      return false;
  }
}

lastStandWaittillLifeReceived(downedPlayer, reviveTime) {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self MakeUsable();
    self waittill("trigger", reviver);
    self makeUnUsable();

    if(!isplayer(reviver) || !(reviver isOnGround())) {
      continue;
    }
    reviveTimeScaler = reviver maps\mp\alien\_perk_utility::perk_GetReviveTimeScalar();

    if(downedPlayer maps\mp\alien\_persistence::is_upgrade_enabled("faster_revive_upgrade"))
      reviveTimeScaler = reviveTimeScaler * CONST_FAST_REVIVE_UPGRADE_SCALAR;

    reviveTimeScaled = int(reviveTime / reviveTimeScaler);
    revive_success = get_revive_result(downedPlayer, reviver, self.origin, reviveTimeScaled);

    if(revive_success) {
      record_revive_success(reviver, downedPlayer);
      break;
    } else {
      self notify("revive_fail");
      continue;
    }
  }
  downedPlayer setClientOmnvar("ui_laststand_end_milliseconds", 0);
  self notify("revive_success");
}

medic_revive(reviver, downedPlayer) {
  instant_revive(downedPlayer);
  record_revive_success(reviver, downedPlayer);
}

record_revive_success(reviver, downedPlayer) {
  level thread maps\mp\alien\_music_and_dialog::playVOForRevived(reviver);

  reviver maps\mp\alien\_persistence::set_player_revives();
  reviver maps\mp\alien\_persistence::eog_player_update_stat("revives", 1);
  downedPlayer thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("revived", reviver);
}

makeReviveEntity(downedPlayer, spawnLoc, entityModel, entityModelAnim, linkToOwner) {
  REVIVE_ENT_VERTICAL_OFFSET = (0, 0, 20);

  spawnLoc = drop_to_ground(spawnLoc + REVIVE_ENT_VERTICAL_OFFSET, DROP_TO_GROUND_UP_DIST, DROP_TO_GROUND_DOWN_DIST);
  reviveEnt = spawn("script_model", spawnLoc);
  reviveEnt setCursorHint("HINT_NOICON");
  reviveEnt setHintString(&"PLATFORM_REVIVE");
  reviveEnt.owner = downedPlayer;
  reviveEnt.inUse = false;
  reviveEnt.targetname = "revive_trigger";

  if(isDefined(entityModel))
    reviveEnt setModel(entityModel);

  if(isDefined(entityModelAnim))
    reviveEnt ScriptModelPlayAnim(entityModelAnim);

  if(linkToOwner)
    reviveEnt linkTo(downedPlayer, "tag_origin", REVIVE_ENT_VERTICAL_OFFSET, (0, 0, 0));

  return reviveEnt;
}

makeReviveIconEntity(downedPlayer, reviveEnt) {
  VERTICAL_OFFSET_ABOVE_REVIVE_ENT = (0, 0, 30);
  reviveIconEnt = spawn("script_model", reviveEnt.origin + VERTICAL_OFFSET_ABOVE_REVIVE_ENT);
  reviveIconEnt thread cleanUpReviveEnt(downedPlayer);

  return reviveIconEnt;
}

mayDoLastStandAlien(player, gameShouldEnd, bleedOutSpawnEntity) {
  if(alien_mode_has("nogame"))
    return true;

  if(isPlayingSolo())
    return solo_mayDoLastStand(gameShouldEnd, bleedOutSpawnEntity);
  else
    return coop_mayDoLastStand(bleedOutSpawnEntity);
}

solo_mayDoLastStand(gameShouldEnd, bleedOutSpawnEntity) {
  if(gameShouldEnd && is_killed_by_kill_trigger(bleedOutSpawnEntity))
    return false;

  return true;
}

coop_mayDoLastStand(bleedOutSpawnEntity) {
  if(is_killed_by_kill_trigger(bleedOutSpawnEntity))
    return false;

  return true;
}

only_use_weapon(weapon) {
  if(isDefined(self.isCarrying) && self.isCarrying) {
    wait(.5);
  }

  pistol = self GetWeaponsListPrimaries()[0];

  save_weapon_list = ["alienflare_mp",
    "aliensemtex_mp",
    "alienclaymore_mp",
    "alientrophy_mp",
    "alienbetty_mp",
    "iw6_aliendlc43_mp",
    "alienthrowingknife_mp",
    "alienmortar_shell_mp",
    "iw6_aliendlc21_mp",
    "iw6_aliendlc22_mp",
    "iw6_aliendlc31_mp",
    "iw6_aliendlc32_mp",
    "iw6_aliendlc33_mp"
  ];

  can_use_pistol = can_use_pistol_during_last_stand(self);

  if(can_use_pistol)
    save_weapon_list[save_weapon_list.size] = pistol;

  self _takeWeaponsExceptList(save_weapon_list);

  if(can_use_pistol) {
    pistol_ammo = self GetAmmoCount(pistol);
    pistol_clip_size = WeaponClipSize(pistol);

    if(pistol_ammo < pistol_clip_size) {
      self SetWeaponAmmoClip(pistol, pistol_clip_size);
    }
    self SwitchToWeapon(pistol);
  }
}

can_use_pistol_during_last_stand(player) {
  if(is_chaos_mode() && player get_last_stand_count() == 0)
    return false;

  return true;
}

cleanUpReviveEnt(owner) {
  self endon("death");

  owner waittill_any("death", "disconnect", "revive");
  self delete();
}

player_init_laststand() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_chaos_laststand::chaos_player_init_laststand();
  else
    regularExtinction_player_init_laststand();
}

regularExtinction_player_init_laststand() {
  if(isPlayingSolo() && !IsSplitScreen()) {
    set_last_stand_count(self, CONST_INITIAL_LASTSTANDS);
    self thread init_selfrevive_icon(CONST_INITIAL_LASTSTANDS);
  }
}

init_selfrevive_icon(initial_lastStand_count) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 5.0;

  selfrevive_count = self get_last_stand_count();
  assert(selfrevive_count == initial_lastStand_count);

  self SetClientOmnvar("ui_alien_selfrevive", selfrevive_count);
}

give_lastStand(player, num) {
  if(!isDefined(num))
    num = 1;

  new_last_stand_count = (player get_last_stand_count()) + num;
  set_last_stand_count(player, new_last_stand_count);
}

take_lastStand(player, num) {
  if(!isDefined(num))
    num = 1;

  new_last_stand_count = (player get_last_stand_count()) - num;
  set_last_stand_count(player, max(new_last_stand_count, 0));
}

gameShouldEnd(player_just_down) {
  if(maps\mp\alien\_debug::self_revive_activated())
    return false;

  if(alien_mode_has("nogame"))
    return false;

  if(isPlayingSolo())
    return solo_gameShouldEnd(player_just_down);
  else
    return coop_gameShouldEnd(player_just_down);
}

solo_gameShouldEnd(player_just_down) {
  if(player_just_down.inLastStand)
    return false;

  return (player_just_down get_last_stand_count() == 0);
}

coop_gameShouldEnd(player_just_down) {
  return everyone_else_all_in_lastStand(player_just_down);
}

everyone_else_all_in_lastStand(player_just_down) {
  foreach(player in level.players) {
    if(player == player_just_down) {
      continue;
    }
    if(!player_in_laststand(player))
      return false;
  }
  return true;
}

get_revive_result(downed_player, reviver, pos, use_time) {
  reviver.isCapturingCrate = true;

  use_ent = createUseEnt(pos);
  use_ent thread cleanUpReviveEnt(downed_player);
  result = revive_use_hold_think(downed_player, reviver, use_ent, use_time);

  reviver.isCapturingCrate = false;

  return result;
}

createUseEnt(pos) {
  useEnt = spawn("script_origin", pos);
  useEnt.curProgress = 0;
  useEnt.useTime = 0;
  useEnt.useRate = 8000;
  useEnt.inUse = false;

  return useEnt;
}

playDeathSoundInLastStand(bleedOutTime) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  self playDeathSound();

  wait bleedOutTime / 3;
  self playDeathSound();

  wait bleedOutTime / 3;
  self playDeathSound();
}

visionFadeToBlack(transitionTime) {
  ASSET_SPECIFIC_TRANSITION_TIME_SCALER = 2.4;
  self VisionSetNakedForPlayer(CONST_BLACK_VISION_SET, transitionTime * ASSET_SPECIFIC_TRANSITION_TIME_SCALER);
  self maps\mp\alien\_utility::restore_client_fog(0);
}

enter_spectate(downedPlayer, spawnLoc, reviveEnt) {
  downedPlayer endon("disconnect");
  level endon("game_ended");

  enter_camera_zoomout();

  camera_zoomout(downedPlayer, spawnLoc, reviveEnt);

  exit_camera_zoomout();
}

camera_zoomout(downedPlayer, spawnLoc, reviveEnt) {
  reviveEnt endon("revive_success");

  VERTICAL_PADDING = (0, 0, 30);
  START_VERTICAL_OFFSET = (0, 0, 100);
  FLY_UP_VERTICAL_OFFSET = (0, 0, 400);
  CAMERA_ZOOM_OUT_TIME = 2.0;
  CAMERA_ACCE_TIME = 0.6;
  CAMERA_DECE_TIME = 0.6;

  startPos = spawnLoc + VERTICAL_PADDING;
  trace = bulletTrace(startPos, startPos + START_VERTICAL_OFFSET, false, downedPlayer);
  camera_fly_start_pos = trace["position"];
  trace = bulletTrace(camera_fly_start_pos, camera_fly_start_pos + FLY_UP_VERTICAL_OFFSET, false, downedPlayer);
  camera_fly_end_pos = trace["position"];

  mover = spawn("script_model", camera_fly_start_pos);
  mover setModel("tag_origin");
  mover.angles = VectorToAngles((0, 0, -1));
  mover thread cleanUpReviveEnt(downedPlayer);

  downedPlayer CameraLinkTo(mover, "tag_origin");

  mover moveTo(camera_fly_end_pos, CAMERA_ZOOM_OUT_TIME, CAMERA_ACCE_TIME, CAMERA_DECE_TIME);
  mover waittill("movedone");
  mover delete();

  downedPlayer maps\mp\gametypes\_playerlogic::respawn_asSpectator();
}

enter_camera_zoomout() {
  self PlayerHide();
  self FreezeControls(true);
  self VisionSetNakedForPlayer(CONST_B_AND_W_VISION_SET, 0);
  self maps\mp\alien\_utility::restore_client_fog(0);
}

exit_camera_zoomout() {
  self CameraUnlink();
  self FreezeControls(false);
}

revive_use_hold_think(downed_player, reviver, use_ent, use_time) {
  enter_revive_use_hold_think(downed_player, reviver, use_ent, use_time);
  thread wait_for_exit_revive_use_hold_think(downed_player, reviver, use_ent);

  current_progress = 0;
  result = false;

  while(should_revive_continue(reviver)) {
    if(current_progress >= use_time) {
      result = true;
      break;
    }
    downed_player SetClientOmnvar("ui_securing_progress", current_progress / use_time);
    reviver SetClientOmnvar("ui_securing_progress", current_progress / use_time);
    current_progress += 50;
    waitframe();
  }

  use_ent notify("use_hold_think_complete");
  use_ent waittill("exit_use_hold_think_complete");
  return result;
}

enter_revive_use_hold_think(downed_player, reviver, use_ent, use_time) {
  downed_player SetClientOmnvar("ui_securing", UI_DOWNEDPLAYER);
  reviver SetClientOmnvar("ui_securing", UI_REVIVING);

  downed_player.being_revived = true;

  reviver playerLinkTo(use_ent);
  reviver PlayerLinkedOffsetEnable();

  reviver disable_weapon_timeout((use_time + 0.05), "revive_weapon_management");
  reviver.isReviving = true;
}

wait_for_exit_revive_use_hold_think(downed_player, reviver, use_ent) {
  waittill_any_ents(use_ent, "use_hold_think_complete", downed_player, "disconnect", downed_player, "revive_success", downed_player, "force_bleed_out");

  if(isReallyAlive(downed_player)) {
    downed_player.being_revived = false;
    downed_player SetClientOmnvar("ui_securing", 0);
  }

  reviver Unlink();

  reviver enable_weapon_wrapper("revive_weapon_management");
  reviver SetClientOmnvar("ui_securing", 0);
  reviver.isReviving = false;

  use_ent notify("exit_use_hold_think_complete");
}

should_revive_continue(reviver) {
  return (!level.gameEnded && isReallyAlive(reviver) && reviver useButtonPressed() && !reviver.inLastStand);
}

register_laststand_ammo() {
  self.laststand_ammo = self GetWeaponAmmoStock(self.laststand_pistol);
  self.laststand_clip_ammo = self GetWeaponAmmoClip(self.laststand_pistol);
}

_takeWeaponsExceptList(saveWeaponList) {
  weaponsList = self GetWeaponsListAll();

  foreach(weapon in weaponsList) {
    if(array_contains(saveWeaponList, weapon)) {
      continue;
    } else {
      self takeWeapon(weapon);
    }
  }
}

blackBox_lastStand(attacker, iDamage) {
  level.alienBBData["times_downed"]++;

  attacker_is_agent = IsAgent(attacker);

  if(attacker_is_agent) {
    attacker_alive_time = (gettime() - attacker.birthtime) / 1000;

    attacker_agent_type = "unknown agent";
    if(isDefined(attacker.agent_type)) {
      attacker_agent_type = attacker.agent_type;
      if(isDefined(attacker.alien_type))
        attacker_agent_type = attacker.alien_type;
    }
  } else {
    attacker_alive_time = 0;

    if(isplayer(attacker))
      attacker_agent_type = "player";
    else
      attacker_agent_type = "nonagent";
  }

  attackerx = 0.0;
  attackery = 0.0;
  attackerz = 0.0;
  if(isDefined(attacker) && IsAgent(attacker)) {
    attackerx = attacker.origin[0];
    attackery = attacker.origin[1];
    attackerz = attacker.origin[2];
  }

  victimname = "";
  if(isDefined(self.name))
    victimname = self.name;

  cyclenum = -1;
  if(isDefined(level.current_cycle_num))
    cyclenum = level.current_cycle_num;

  hivename = "unknown";
  if(isDefined(level.current_hive_name))
    hivename = level.current_hive_name;

  if(GetDvarInt("alien_bbprint_debug") > 0) {
    attackerorigin = (attackerx, attackery, attackerz);

    IPrintLnBold("^8bbprint: alienplayerlaststand \n" +
      " cyclenum=" + cyclenum +
      " hivename=" + hivename +
      " attackerisagent=" + attacker_is_agent +
      " attackeragenttype=" + attacker_agent_type +
      " attackeralivetime=" + attacker_alive_time +
      " attackerx,y,z=" + attackerorigin +
      " victimx,y,z=" + self.origin +
      " victimname=" + victimname +
      " damage=" + iDamage);
  }

  bbprint("alienplayerlaststand",
    "cyclenum %i hivename %s attackerisagent %i attackeragenttype %s attackeralivetime %f attackerx %f attackery %f attackerz %f victimx %f victimy %f victimz %f victimname %s damage %i",
    cyclenum,
    hivename,
    attacker_is_agent,
    attacker_agent_type,
    attacker_alive_time,
    attackerx,
    attackery,
    attackerz,
    self.origin[0],
    self.origin[1],
    self.origin[2],
    victimname,
    iDamage);
}

waittill_any_ents_or_timeout_return(timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(timeout));
  assert(isDefined(ent1));
  assert(isDefined(string1));

  self endon("death");

  ent = spawnStruct();

  ent1 childthread waittill_string(string1, ent);

  if((isDefined(ent2)) && (isDefined(string2)))
    ent2 childthread waittill_string(string2, ent);

  if((isDefined(ent3)) && (isDefined(string3)))
    ent3 childthread waittill_string(string3, ent);

  if((isDefined(ent4)) && (isDefined(string4)))
    ent4 childthread waittill_string(string4, ent);

  if((isDefined(ent5)) && (isDefined(string5)))
    ent5 childthread waittill_string(string5, ent);

  if((isDefined(ent6)) && (isDefined(string6)))
    ent6 childthread waittill_string(string6, ent);

  if((isDefined(ent7)) && (isDefined(string7)))
    ent7 childthread waittill_string(string7, ent);

  ent childthread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_ents_return(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  self endon("death");

  ent = spawnStruct();

  ent1 childthread waittill_string(string1, ent);

  if((isDefined(ent2)) && (isDefined(string2)))
    ent2 childthread waittill_string(string2, ent);

  if((isDefined(ent3)) && (isDefined(string3)))
    ent3 childthread waittill_string(string3, ent);

  if((isDefined(ent4)) && (isDefined(string4)))
    ent4 childthread waittill_string(string4, ent);

  if((isDefined(ent5)) && (isDefined(string5)))
    ent5 childthread waittill_string(string5, ent);

  if((isDefined(ent6)) && (isDefined(string6)))
    ent6 childthread waittill_string(string6, ent);

  if((isDefined(ent7)) && (isDefined(string7)))
    ent7 childthread waittill_string(string7, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

is_killed_by_kill_trigger(bleedOutSpawnEntity) {
  return isDefined(bleedOutSpawnEntity);
}

set_last_stand_count(player, num) {
  num = int(num);
  player setcoopplayerdata("alienSession", "last_stand_count", num);
  player SetClientOmnvar("ui_alien_selfrevive", num);
}

get_last_stand_count() {
  return self getcoopplayerdata("alienSession", "last_stand_count");
}
is_being_revived(player) {
  return player.being_revived;
}
player_in_laststand(player) {
  return player.inLastStand;
}
instant_revive(player) {
  player notify("revive_success");
}

debug_self_revive() {
  register_laststand_ammo();
  wait(3);
  return true;
}
# /