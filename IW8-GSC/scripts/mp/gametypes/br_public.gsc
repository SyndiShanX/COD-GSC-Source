/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_public.gsc
***********************************************/

function iswaitingtoentergulag(var_0) {
  return istrue(var_0.entergulagwait);
}

function update_current_solution(var_0) {
  return istrue(var_0.set_relic_steelballs_perks);
}

function use_csm(var_0) {
  return istrue(var_0.respawningfromtoken);
}

function isplayeringulag() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0.jailed) || istrue(var_0.gulagarena));
}

function updateinstantclassswapallowedinternal() {
  var_0 = self;
  return isDefined(var_0) && (istrue(var_0.jailed) || istrue(var_0.gulagarena) || istrue(var_0.gulag));
}

function ref_1443C() {
  var_0 = self;
  return isDefined(var_0) && istrue(var_0.ref_14439);
}

function isplayerwaitingrebirthrespawn() {
  var_0 = self;
  return isDefined(var_0) && isDefined(var_0.ref_12CA1) && var_0.ref_12CA1 > 0;
}

function unlockscriptabledoors() {
  var_0 = self;
  return (istrue(var_0.delay_enter_combat_after_investigating_grenade) && !isalive(var_0) || ref_125F3(var_0)) && !istrue(var_0.gulag);
}

function ref_125F3() {
  return istrue(self.iszombie);
}

function ref_125EC() {
  return istrue(self.unset_relic_gun_game) || istrue(self.scn_infil_tango_npc_2_sfx);
}

function watchhealend() {
  self endon("heal_end");
  self endon("death_or_disconnect");
  self endon("br_armor_plate_done");
  level endon("game_ended");
  GscBinSkip4(0x35);
}

function heal_removeonplayernotifies() {
  self notifyonplayercommand("try_heal_cancel", "+weapnext");
  self notifyonplayercommand("try_heal_cancel", "+attack");
  self notifyonplayercommand("try_heal_cancel", "+breath_sprint");
  scripts\engine\utility::ref_143A5("death", "try_heal_cancel");
  healend();
}

function heal_removeondamage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
      continue;
    }

    healend();
  }
}

function healend() {
  self notifyonplayercommandremove("try_heal_cancel", "+weapnext");
  self notifyonplayercommandremove("try_heal_cancel", "+attack");
  self notifyonplayercommandremove("try_heal_cancel", "+breath_sprint");
  self notify("heal_end");
}

function removeitemfrominventory(var_0) {
  self.br_inventory_slots[var_0] = undefined;
}

function ishelmet(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "armor" && issubstr(var_0, "helmet");
}

function isarmor(var_0) {
  return ishelmet(var_0);
}

function isarmorplate(var_0) {
  return var_0 == "brloot_armor_plate";
}

function ishealitem(var_0) {
  return var_0 == "brloot_health_bandages" || var_0 == "brloot_health_firstaid" || var_0 == "brloot_health_adrenaline";
}

function isequipment(var_0) {
  return isarmorplate(var_0) || ishealitem(var_0) || isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "lethal" || level.br_pickups.br_itemtype[var_0] == "tactical");
}

function isammo(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "ammo";
}

function ref_12518() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]() || istrue(self.tracking_max_health)) {
    return false;
  }

  var_0 = self getcurrentweapon();

  if(nullweapon(var_0)) {
    return false;
  }

  return true;
}

function ref_12616(var_0, var_1) {
  self endon("death_or_disconnect");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);
  wait var_1;

  if(self hasweapon(var_2)) {
    self takeweapon(var_2);
    return;
  }
}

function hasrespawntoken() {
  var_0 = self;
  return istrue(var_0.hasrespawntoken);
}

function hasgulagtoken() {
  var_0 = self;
  return istrue(var_0.hasgulagtoken);
}

function shouldgetnewspawnpoint() {
  var_0 = self;
  return istrue(var_0.shouldgetnewspawnpoint);
}

function should_use_velo_forward() {
  var_0 = self;
  return istrue(var_0.should_use_velo_forward);
}

function shouldlink() {
  var_0 = self;
  return istrue(var_0.should_enter_combat_after_checking_decoy_grenade);
}

function should_damage_pavelow_boss(var_0) {
  var_1 = self;

  if(!isDefined(var_0) || !isDefined(var_1.armorylights)) {
    return isDefined(var_1.armorylights);
  }

  return var_0 == var_1.armorylights;
}

function isusinginfilselection() {
  if(istrue(level.infilcanusemap)) {
    switch (level.infilselectionmethod) {
      case "exclusion":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function handleinfilspawnselectstart() {
  var_0 = level.infilselectionmethod;
  var_1 = getinfilspawnselectstartfunc(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  return level[[var_1]]();
}

function handleinfilspawnselectend() {
  var_0 = level.infilselectionmethod;
  var_1 = getinfilspawnselectendfunc(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  return level[[var_1]]();
}

function getinfilspawnselectstartfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers)) {
    return undefined;
  }

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1.spawnselectstartfunc;
}

function getinfilspawnselectendfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers)) {
    return undefined;
  }

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1.spawnselectendfunc;
}

function cleanac130struct(var_0) {
  if(isDefined(var_0.playerslot1)) {
    if(isDefined(var_0.playerslot1.head)) {
      var_0.playerslot1.head delete();
    }

    if(isDefined(var_0.playerslot1.helmet)) {
      var_0.playerslot1.helmet delete();
    }

    var_0.playerslot1 delete();
  }

  if(isDefined(var_0.playerslot2)) {
    if(isDefined(var_0.playerslot2.head)) {
      var_0.playerslot2.head delete();
    }

    var_0.playerslot2 delete();
  }

  if(isDefined(var_0.playerslot3)) {
    var_0.playerslot3 delete();
  }

  if(isDefined(var_0.playerslot4)) {
    var_0.playerslot4 delete();
  }

  if(isDefined(var_0.aidoorchief)) {
    var_0.aidoorchief delete();
  }

  if(isDefined(var_0.cameraent)) {
    var_0.cameraent delete();
  }

  if(isDefined(var_0.gas_trigger)) {
    var_0.gas_trigger delete();
  }

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_2 in var_0.playerpositionents) {
      var_2 delete();
    }
  }

  if(isDefined(var_0.helicratedelete)) {
    var_0.helicratedelete delete();
  }

  if(isDefined(var_0.staticc130) && istrue(var_0.staticc130.cleanme)) {
    var_0.staticc130 delete();
  }

  if(isDefined(var_0.movingc130) && istrue(var_0.movingc130.cleanme)) {
    if(isDefined(var_0.movingc130.innards) && istrue(var_0.movingc130.innards.cleanme)) {
      var_0.movingc130.innards delete();
    }

    var_0.movingc130 delete();
    return;
  }
}

function turn_on_nearby_model_screen() {
  return level.stop_wave == 0;
}

function tv_station_intro_already_played() {
  return level.stop_wave == 1;
}

function usefailcapacitymsg() {
  return level.stop_wave == 2;
}

function remove_old_wheelsons(var_0) {
  var_1 = 1;

  if(isDefined(var_0.infilanimindex)) {
    var_1 = var_0.infilanimindex;
  }

  if(tv_station_intro_already_played()) {
    if(istrue(var_0.stop_counter_beep_sfx_on_bomb_vests)) {
      var_2 = "cam_orbit_br_chopper_solo";
      return var_2;
    }

    var_2 = "cam_orbit_br_chopper_squad_player" + var_2;
    return var_2;
  }

  if(usefailcapacitymsg()) {
    if(istrue(var_2.stop_counter_beep_sfx_on_bomb_vests)) {
      var_2 = "cam_orbit_br_skilo_solo";
      return var_2;
    }

    var_2 = "cam_orbit_br_skilo_squad_player" + var_2;
    return var_2;
  }

  var_2 = "cam_orbit_br_ac130_player" + var_2;
  return var_2;
}

function orbitcam(var_0) {
  self endon("death");

  if(isDefined(level.infil_vignette_anim_type) && level.infil_vignette_anim_type == "script_model") {
    self.angles = var_0.angles;
    self playerlinkTo(var_0, "");
    self playerhide();
  }

  if(isDefined(level.ref_142D1)) {
    scripts\mp\utility\player::_visionsetnaked(level.ref_142D1, 0);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
  }

  self setplayerangles(var_0.angles);
  var_1 = remove_old_wheelsons(self);
  self cameraset(var_1);
}

function ref_1264D() {
  var_0 = self;
  var_0 method_87a9();
}

function updatebrscoreboardstat(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  switch (var_0) {
    case "reviveCount":
      var_6 = [0, 8, 0];
      var_3 = var_6[0];
      var_4 = var_6[1];
      var_5 = var_6[2];
      var_6 = undefined;
      break;
    case "objTime":
      var_7 = [0, 12, 0];
      var_3 = var_7[0];
      var_4 = var_7[1];
      var_5 = var_7[2];
      var_7 = undefined;
      break;
    case "tomahDamage":
      var_8 = [0, 16, 0];
      var_3 = var_8[0];
      var_4 = var_8[1];
      var_5 = var_8[2];
      var_8 = undefined;
      break;
    case "respawnInSeconds":
      var_9 = [0, 7, 1];
      var_3 = var_9[0];
      var_4 = var_9[1];
      var_5 = var_9[2];
      var_9 = undefined;
      break;
    case "isInInfilPlane":
      var_10 = [7, 1, 1];
      var_3 = var_10[0];
      var_4 = var_10[1];
      var_5 = var_10[2];
      var_10 = undefined;
      break;
    case "armorHealthRatio":
      var_11 = [0, 8, 2];
      var_3 = var_11[0];
      var_4 = var_11[1];
      var_5 = var_11[2];
      var_11 = undefined;
      break;
    case "missionsCompleted":
      var_12 = [8, 4, 2];
      var_3 = var_12[0];
      var_4 = var_12[1];
      var_5 = var_12[2];
      var_12 = undefined;
      break;
    case "bunkerKeycardType":
      var_13 = [12, 4, 2];
      var_3 = var_13[0];
      var_4 = var_13[1];
      var_5 = var_13[2];
      var_13 = undefined;
      break;
    case "damageDealt":
      var_14 = [0, 16, 3];
      var_3 = var_14[0];
      var_4 = var_14[1];
      var_5 = var_14[2];
      var_14 = undefined;
      break;
    case "isBeingRevived":
    case "isDowned":
    case "activeSpectators":
    case "jumpMasterState":
    case "isRespawning":
    case "cleanups":
    case "playersDowned":
      return;
    default:
      return;
  }

  packstatintoextrainfo(var_2, var_1, var_3, var_4, var_5);
}

function packstatintoextrainfo(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = [var_4.extrascore0, var_4.extrascore1, var_4.extrascore2, var_4.extrascore3];
  var_6 = int(pow(2, var_2)) - 1;
  var_7 = (var_0 &var_6) << var_1;
  var_8 = ~(var_6 << var_1);
  var_9 = var_5[var_3];
  var_10 = var_9 &var_8;
  var_11 = var_10 + var_7;

  switch (var_3) {
    case 0:
      var_4.extrascore0 = var_11;
      break;
    case 1:
      var_4.extrascore1 = var_11;
      break;
    case 2:
      var_4.extrascore2 = var_11;
      break;
    case 3:
      var_4.extrascore3 = var_11;
      break;
    default:
      break;
  }
}

function updatebrextradata(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  var_4 = 0;

  switch (var_0) {
    case "selectedKillstreakId":
      var_5 = [0, 4];
      var_3 = var_5[0];
      var_4 = var_5[1];
      var_5 = undefined;
      break;
    case "armorPlateCount":
      var_6 = [4, 4];
      var_3 = var_6[0];
      var_4 = var_6[1];
      var_6 = undefined;
      break;
    default:
      return;
  }

  packdataintoextrainfo(var_2, var_1, var_3, var_4);
}

function packdataintoextrainfo(var_0, var_1, var_2) {
  var_1 = 20 + var_1;

  if(var_1 + var_2 > 31) {
    return;
  }

  var_3 = int(pow(2, var_2)) - 1;
  var_4 = (var_0 &var_3) << var_1;
  var_5 = ~(var_3 << var_1);
  var_6 = self.game_extrainfo;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self.game_extrainfo = var_8;
}

function ref_1319E(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 512;
    return;
  }

  self.game_extrainfo &= ~512;
}

function ref_1319C(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 1024;
    return;
  }

  self.game_extrainfo &= ~1024;
}

function ref_131A6(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 2048;
    return;
  }

  self.game_extrainfo &= ~2048;
}

function ref_131A4(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 8192;
    return;
  }

  self.game_extrainfo &= ~8192;
}

function updatelootleadersonfixedinterval(var_0) {
  return isDefined(var_0.game_extrainfo) && var_0.game_extrainfo & 8192;
}

function ref_1315C(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 16384;
    return;
  }

  self.game_extrainfo &= ~16384;
}

function ref_1315B(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 32768;
    return;
  }

  self.game_extrainfo &= ~32768;
}

function incrementplayersdownedstat() {
  var_0 = self;

  if(!isDefined(var_0.br_playersdowned)) {
    var_0.br_playersdowned = 0;
  }

  var_0.br_playersdowned++;
  updatebrscoreboardstat(var_0, "playersDowned", var_0.br_playersdowned);
  var_0 scripts\mp\utility\stats::incpersstat("downs", 1);
}

function sethasgasmaskextrainfo(var_0) {
  if(var_0 == 1) {
    self.game_extrainfo |= 65536;
    self.game_extrainfo &= ~131072;
    return;
  }

  if(var_0 == 2) {
    self.game_extrainfo &= ~65536;
    self.game_extrainfo |= 131072;
    return;
  }

  self.game_extrainfo &= ~65536;
  self.game_extrainfo &= ~131072;
}

function sethasplatepouchextrainfo(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 262144;
    return;
  }

  self.game_extrainfo &= ~262144;
}

function setcanusegulagextrainfo(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 524288;
    return;
  }

  self.game_extrainfo &= ~524288;
}

function updatedragonsbreath() {
  var_0 = self;
  return istrue(var_0.tutorial_usingparachute) && var_0.game_extrainfo & 64;
}

function dmztutdropcash(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level.teamdata[var_1]["players"]) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7 != var_2) {
      dmztut_endgamewithreward(var_0, var_7, var_3, var_4, var_5);
    }
  }
}

function dmztut_luicallback(var_0, var_1, var_2, var_3, var_4, var_5) {
  brleaderdialog(var_0, var_2, level.teamdata[var_1]["players"], var_5, var_3, var_4);
}

function brleaderdialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_7 = level.players;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_7[var_8];
    thread dmztut_endgamewithreward(var_0, var_9, var_1, var_3, var_4, var_5, var_6);
  }
}

function ref_11C7D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(istrue(var_1) && isplayeringulag()) {
    return true;
  }

  if(istrue(self.ref_12742)) {
    return true;
  }

  if(tutorial_playSound()) {
    if(istrue(self.ref_12749)) {
      return true;
    }

    if(var_0 == "deploy_squad_leader" || var_0 == "prematch_enter") {
      return true;
    }

    if((var_0 == "circle_closing" || var_0 == "first_circle") && !istrue(level.ref_126D5)) {
      return true;
    }
  }

  var_2 = level.maxteamsize == 1;

  if(var_2) {
    switch (var_0) {
      case "deploy_squad_leader":
        return true;
    }
  }

  return false;
}

function disableannouncer(var_0) {
  var_1 = var_0.defaultoperatorteam;

  if(isai(var_0)) {
    var_1 = var_0.botoperatorteam;
  }

  if(validtousesticker() || tutorial_playSound()) {
    var_1 = "allies";
  }

  if(!isPlayer(var_0)) {
    var_1 = "axis";
  }

  return var_1;
}

function dmztut_endgamewithreward(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_1)) {
    return;
  }

  if(!isalive(var_1) && !istrue(var_3)) {
    return;
  }

  if(var_1 issplitscreenplayer() && !var_1 issplitscreenplayerprimary()) {
    return;
  }

  if(ref_11C7D(var_1, var_0, var_2)) {
    return;
  }

  if(validtousesticker() || tutorial_playSound()) {
    if(var_0 == "mission_scav_accept" || var_0 == "mission_obj_next_nptarget") {
      return;
    }
  }

  if(isDefined(var_6)) {
    var_7 = var_6;
  } else {
    jumpiffalse(var_2 scripts\cp_mp\utility\game_utility::ref_140A8()) LOC_00000091;
    var_7 = "bchr";
    goto LOC_000000a8;
  }

  LOC_000000a8:
    var_9 = "dx_bra_" + var_7 + "_" + game["dialog"][var_2];

  if(istrue(level.vehicle_collision_getleveldata)) {
    var_10 = "dx_brm_" + var_7 + "_" + game["dialog"][var_2];

    if(soundexists(var_10)) {
      var_9 = var_10;
    }
  } else if(isDefined(level.overridevoice)) {
    var_11 = "dx_bra_" + level.overridevoice + "_" + game["dialog"][var_2];

    if(soundexists(var_11)) {
      var_9 = var_11;
    }
  }

  if(isDefined(game["dialogForAllTeams"]) && istrue(game["dialogForAllTeams"][var_2])) {
    var_9 = game["dialog"][var_2];
  }

  if(isDefined(var_9)) {
    var_9 = tolower(var_9);
    var_12 = lookupsoundlength(var_9, 1) / 1000;

    if(isDefined(var_6)) {
      wait var_6;
    }

    var_3 queuedialogforplayer(var_9, var_2, var_12);
    return;
  }
}

function endgamevo(var_0, var_1) {
  game["dialog"][var_0] = var_1;

  if(!isDefined(game["dialogForAllTeams"])) {
    game["dialogForAllTeams"] = [];
  }

  game["dialogForAllTeams"][var_0] = 1;
}

function uniquelootitemid() {
  return isDefined(level.script) && level.script == "mp_bm_tut";
}

function validtousesticker() {
  var_0 = getDvar("wz_tutorial_map", "mp_br_tut2");
  return isDefined(level.script) && (level.script == var_0 || level.script == "mp_lc_br_tut");
}

function tutorial_playSound() {
  return isDefined(level.script) && level.script == "mp_br_quarry";
}

function uniquelootcallbacks() {
  return isDefined(level.script) && level.script == "mp_br_money";
}

function turret_headicon() {
  return validtousesticker() || uniquelootitemid() || tutorial_playSound() || uniquelootcallbacks();
}

function ref_12570() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = var_2.basename;

    if(weaponclass(var_2) == "pistol" && var_3 != "iw8_fists_mp" && var_3 != "iw8_me_riotshield_mp" && var_3 != "iw8_knifestab_mp" && var_3 != "iw8_throwingknife_fire_melee_mp" && var_3 != "iw8_throwingknife_electric_melee_mp" && var_3 != "iw8_throwingknife_drill_melee_mp") {
      return var_2;
    }
  }
}

function ref_126ED() {
  if(istrue(self.ref_12875)) {
    self waittill("playerPrestreamComplete");
    return;
  }
}

function getinfilspawnoffset() {
  if(istrue(level.infilcanusemap)) {
    return getdvarfloat("scr_map_selection_height_offset", 2000);
  }

  return getdvarfloat("scr_br_dropSpawnOffsetMinZ", 12000);
}

function ref_126B8(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = getinfilspawnoffset();
  }

  var_2 = getdvarint("scr_br_streamDistFromGround", 4500);

  if(var_2 >= 0) {
    var_3 = var_1 - var_2;
    var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_0 = scripts\engine\utility::drop_to_ground(var_0, 0, -1 * var_3, undefined, var_4);
  }

  return var_0;
}

function ref_126B9(var_0, var_1, var_2, var_3, var_4) {
  thread ref_126BA(var_0, var_1, var_2, var_3, var_4);
}

function ref_126BA(var_0, var_1, var_2, var_3, var_4) {
  self notify("playerPrestreamLocationWait");
  self endon("playerPrestreamLocationWait");
  self endon("disconnect");
  var_5 = !self calloutmarkerping_getEnt();

  if(!isDefined(var_1)) {
    var_1 = relic_nuketimer_gettimeformission();
  }

  var_6 = gettime() + var_1;
  self.ref_12875 = 1;

  if(!self ispredictedstreamposready()) {
    self clearpredictedstreampos();
  }

  var_7 = gettime();

  if(var_5) {
    while(!istrue(self.pers["streamSyncComplete"]) && gettime() < var_6) {
      waitframe();
    }
  }

  self predictstreampos(var_0, 1);

  if(istrue(var_2)) {
    self loadcustomizationplayerview(self);
  }

  if(var_5) {
    waitframe();

    while((!self ispredictedstreamposready() || istrue(var_2) && !self hasloadedcustomizationplayerview(self)) && gettime() < var_6) {
      waitframe();
    }

    if(istrue(var_3)) {
      var_9 = gettime() + getdvarint("scr_br_stream_hint_extra_time", 5000);

      while(gettime() < var_9) {
        waitframe();
      }
    }

    if(isDefined(var_4)) {
      var_10 = getdvarint("keep_alive_update_time", 2000);
      var_6 = gettime() + var_4;
      var_11 = 0;

      while(gettime() < var_6) {
        if(gettime() > var_11) {
          self predictstreampos(var_0, 1);
          var_11 = gettime() + var_10;
        }

        waitframe();
      }
    }
  }

  self.ref_12875 = undefined;
  self notify("playerPrestreamComplete");
}

function relic_nuketimer_gettimeformission() {
  return getdvarint("scr_br_stream_hint_timeout", 9000);
}

function ref_1252B() {
  self notify("playerPrestreamLocationWait");
  self clearpredictedstreampos();
}

function ref_1264C() {
  self cancelmantle();

  if(self isskydiving()) {
    self skydive_interrupt();
  }

  if(istrue(self.inlaststand)) {
    scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", self);
  }

  if(isDefined(self.burninginfo)) {
    scripts\mp\equipment\molotov::molotov_clear_burning();
  }

  if(istrue(self.usingascender)) {
    scripts\cp_mp\auto_ascender::canseesafecircleui();
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    var_0 = spawnStruct();
    var_0.allowairexit = 1;
    var_0.onprematchfadedone2 = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(self.vehicle, undefined, self, var_0, 1);
  }

  if(isDefined(self.remoteuav)) {
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();
  }

  if(isDefined(self.currentturret)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);
  }

  if(isDefined(self.usingremote)) {
    var_1 = vehicle_getarray();

    foreach(var_3 in var_1) {
      if(isDefined(var_3.owner) && var_3.owner == self) {
        if(isDefined(var_3.helperdronetype)) {
          var_3 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(1);
        }
      }
    }
  }

  scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
}

function playerloadoutsaveselected(var_0) {
  var_1 = undefined;
  var_1 = scripts\mp\class::preloadandqueueclass(var_0);
  return var_1;
}

function forcedisablelaststand() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}

function hasarmor() {
  return isDefined(self.br_armorhealth) && self.br_armorhealth > 0;
}

function hashelmet() {
  return isDefined(self.br_helmetlevel);
}

function damagearmor(var_0, var_1) {
  if(!hasarmor()) {
    return var_0;
  }

  var_2 = int(min(self.br_armorhealth, var_0));
  var_3 = var_0 - var_2;
  var_4 = self.br_armorhealth / self.br_maxarmorhealth;
  self.br_armorhealth -= var_2;
  scripts\cp\vehicles\vehicle_compass_cp::ref_12000(var_2);
  self.br_armorhealth = max(0, self.br_armorhealth);
  var_5 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    if(!istrue(var_1)) {
      if(self.br_armorhealth == 0 && var_2 > 0) {
        self playsoundtoplayer("hit_marker_3d_armor_break", self);

        if(scripts\mp\utility\perk::_hasperk("specialty_br_reinforced")) {
          self setscriptablepartstate("armor_break", "reinforced_armor_break", 0);
        } else {
          self setscriptablepartstate("armor_break", "armor_break", 0);
        }
      }
    }

    self setclientomnvar("ui_br_armor_damage", var_5);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    var_6 = spawnStruct();
    var_6.is_spawner_position_valid = var_2;
    var_6.isaccesscard = var_3;
    var_6.stack_patch_waittill_stack = var_1;
    runbrgametypefuncwrapper("onPlayerArmorDamaged", var_6);
  }

  return var_3;
}

function ishelmetpopenabled() {
  if(getdvarint("scr_br_helmet_pop", 1)) {
    return true;
  }

  return false;
}

function breakhelmet() {
  self.br_helmetlevel = undefined;
}

function damagehelmet(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !ishelmetpopenabled()) {
    var_1 = 0;
  }

  var_3 = 1;

  switch (self.br_helmetlevel) {
    case 1:
      var_3 = 0.85;
      break;
    case 2:
      var_3 = 0.7;
      break;
    case 3:
      var_3 = 0.7;
      break;
    default:
      break;
  }

  if(var_1) {
    breakhelmet();

    if(isDefined(level.ref_1203E)) {
      [[level.ref_1203E]](self, var_2);
    }
  }

  return var_3;
}

function ref_1285E(var_0) {
  setglobalsoundcontext("lobby_fade", "on", 3);

  if(!isDefined(level.ref_133B4)) {
    level.ref_133B4 = 1;
  }

  thread stop_priming_gesture();

  if(level.matchcountdowntime > 13) {
    var_1 = level.matchcountdowntime - 13;
    wait var_1;
    var_2 = scripts\mp\utility\teams::getteamdata(var_0, "players");

    if(istrue(level.vehicle_collision_getleveldata)) {
      setmusicstate("event01_lobby_outro");
    } else {
      var_3 = game["music"]["br_lobby_outro"].size;

      foreach(var_5 in var_2) {
        if(isDefined(var_5)) {
          var_6 = randomint(var_3);
          var_5 setplayermusicstate(game["music"]["br_lobby_outro"][var_6]);
          var_5 setsoundsubmix("mp_br_lobby_fade", 8);
        }
      }
    }

    wait level.matchcountdowntime;

    if(!istrue(level.br_infil_music_played)) {
      foreach(var_5 in var_2) {
        if(isDefined(var_5)) {
          var_5 setplayermusicstate("");
        }
      }
    }

    var_10 = istrue(level.br_infils_disabled);

    if(var_10) {
      foreach(var_5 in var_2) {
        if(isDefined(var_5)) {
          var_5 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        }
      }

      return;
    }

    return;
  }
}

function stop_priming_gesture() {
  if(istrue(level.br_infil_music_called)) {
    return;
  }

  if(getdvarint("scr_br_c130_intro_s2", 0) == 1) {
    return;
  }

  level.br_infil_music_called = 1;

  if(tv_station_intro_already_played()) {
    var_0 = level.matchcountdowntime + 1 + 3.5 - 1;

    if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
      var_0 = level.matchcountdowntime - 0.05;
    }

    wait var_0;
  } else if(usefailcapacitymsg()) {
    scripts\mp\utility\sound::besttime("br_infil_skilo");
    var_0 = level.matchcountdowntime + 1 + 3.5;
    wait var_0;
  } else {
    var_0 = level.matchcountdowntime + 1 + 3.5;
    wait var_0;
  }

  waittillframeend();
  level.br_infil_music_played = 1;

  foreach(var_2 in level.players) {
    var_3 = game["music"]["br_infil_intro"].size;
    var_4 = randomint(var_3);
    var_5 = game["music"]["br_infil_intro"][var_4];
    var_2 setplayermusicstate(var_5);
  }

  wait 24;
  level.br_infil_music_played = undefined;
  level.br_infil_music_called = undefined;
}

function ref_12854(var_0) {
  if(validtousesticker()) {
    return;
  }

  if(level.matchcountdowntime > 3) {
    var_1 = level.matchcountdowntime - 3;
    wait var_1;
    dmztut_luicallback("prematch_end", var_0);
    return;
  }
}

function loadoutcustomfiresalediscount(var_0) {
  if(!getdvarint("scr_prematch_disable_executions", 1)) {
    return;
  }

  if(istrue(level.ref_12856)) {
    return;
  }

  level.ref_12856 = 1;
  var_1 = getdvarint("scr_prematch_disable_execution_buffer", 2);
  var_2 = level.players;
  var_3 = ["execution_attack", "execution_victim"];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 scripts\common\utility::allow_array(var_3, 0);
  }

  wait var_0 + var_1;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5) || var_5 scripts\common\utility::can_execute()) {
      continue;
    }

    var_5 scripts\common\utility::allow_array(var_3, 1);
  }

  level.ref_12856 = undefined;
}

function calculateeventstarttime() {
  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 0) {
    return;
  }

  var_0 = 5;
  var_1 = level.matchcountdowntime - var_0;

  if(var_1 > 0) {
    wait var_1;
  }

  foreach(var_3 in level.players) {
    var_3.plotarmor = 1;
  }

  thread loadoutcustomfiresalediscount(level);
}

function delay_then_run_wave_override() {
  var_0 = self;
  damagearmor(var_0, 150, 1);
}

function defend_wave_1() {
  if(!isfeatureenabledwrapper("allowLateJoiners")) {
    level endon("game_ended");
    var_0 = getdvarint("scr_br_nojip_delay", 30);
    wait var_0;
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
    return;
  }
}

function ref_12A1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\trace::ray_trace(var_0 + (var_1, var_2, var_3), var_0 + (var_1, var_2, var_4), var_6, var_5);
  return var_7;
}

function reset_button_init(var_0, var_1) {
  if(!isDefined(level.cratedata) || !isDefined(level.cratedata.crates)) {
    return;
  }

  var_2 = var_1 * var_1;
  var_3 = [];

  foreach(var_5 in level.cratedata.crates) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_6 = distance2dsquared(var_5.origin, var_0);

    if(var_6 < var_2) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function semtex_used() {
  var_0 = 4000;

  if(isDefined(level.br_level) && isDefined(level.br_level.spawn_exfil_enemies)) {
    var_0 = level.br_level.spawn_exfil_enemies;
  }

  return var_0;
}

function send_all_ai_to_players() {
  var_0 = -1200;

  if(isDefined(level.br_level) && isDefined(level.br_level.ref_11A5B)) {
    var_0 = level.br_level.ref_11A5B;
  }

  return var_0;
}

function modifyplayer_damage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = modifyscenenode(var_0, var_1, var_2, var_3, var_4);
  return var_5["position"];
}

function modifytriggerlocation(var_0, var_1, var_2, var_3, var_4) {
  var_5 = modifyscenenode(var_0, var_1, var_2, var_3, var_4);
  return var_5;
}

function modifyscenenode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = send_all_ai_to_players();
  var_6 = semtex_used();
  var_7 = 2500;
  var_8 = -19000 + var_5;
  var_9 = 15;

  if(!isDefined(var_1)) {
    var_1 = getdvarint("scr_br_trace_up", var_7);
  }

  if(!isDefined(var_2)) {
    var_2 = getdvarint("scr_br_trace_down", var_8);
  }

  var_10 = getdvarint("scr_br_trace_low", var_5);
  var_11 = getdvarint("scr_br_trace_high", var_6);
  var_12 = undefined;

  if(isDefined(var_3)) {
    var_12 = var_3;
  } else {
    var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  }

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  var_13 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  if(isDefined(var_13.instancesbyref["little_bird"])) {
    var_4 = scripts\engine\utility::array_combine(var_4, var_13.instancesbyref["little_bird"]);
  }

  if(isDefined(var_13.instancesbyref["little_bird_mg"])) {
    var_4 = scripts\engine\utility::array_combine(var_4, var_13.instancesbyref["little_bird_mg"]);
  }

  var_14 = reset_button_init(var_0, 100);

  if(isDefined(var_14) && var_14.size > 0) {
    var_4 = scripts\engine\utility::array_combine(var_4, var_14);
  }

  if(getdvarint("scr_br_trace_ignore_balloons", 1) > 0) {
    var_15 = getnearbyskyhookballoons2d(var_0, 100);

    if(var_15.size > 0) {
      var_4 = scripts\engine\utility::array_combine(var_4, var_15);
    }
  }

  var_16 = ref_12A1C(var_0, 0, 0, var_1, var_2, var_12, var_4);

  if(ref_13C32(var_16, var_10)) {
    return var_16;
  }

  var_16 = ref_12A1C(var_0, var_9, 0, var_1, var_2, var_12, var_4);

  if(ref_13C32(var_16, var_10)) {
    return var_16;
  }

  var_16 = ref_12A1C(var_0, 0, var_9, var_1, var_2, var_12, var_4);

  if(ref_13C32(var_16, var_10)) {
    return var_16;
  }

  var_16 = ref_12A1C(var_0, -1 * var_9, 0, var_1, var_2, var_12, var_4);

  if(ref_13C32(var_16, var_10)) {
    return var_16;
  }

  var_16 = ref_12A1C(var_0, 0, -1 * var_9, var_1, var_2, var_12, var_4);

  if(ref_13C32(var_16, var_10)) {
    return var_16;
  }

  var_16 = [];
  var_16["position"] = (var_0[0], var_0[1], var_11);
  var_16["fraction"] = 0;
  return var_16;
}

function ref_13C32(var_0, var_1) {
  return var_0["fraction"] != 1 && var_0["position"][2] > var_1;
}

function getnearbyskyhookballoons2d(var_0, var_1) {
  var_2 = [];

  if(isDefined(level.ref_13400)) {
    var_3 = var_1 * var_1;

    foreach(var_5 in level.ref_13400.areas_remaining) {
      if(isDefined(var_5.chopperexfil_sfx_before_sh070)) {
        var_6 = distance2dsquared(var_0, var_5.chopperexfil_sfx_before_sh070.origin);

        if(var_6 < var_3) {
          var_2 = var_5.chopperexfil_sfx_before_sh070;
        }
      }
    }
  }

  return var_2;
}

function timeoutonabandonedcallback() {
  if(!getdvarint("scr_br_lightweightGameObject", 1)) {
    return;
  }

  if(self.triggertype == "proximity" && !self.usetime) {
    self.touchlist = [];
    self.touchlist["neutral"] = [];
    self.touchlist["none"] = [];
    self.assisttouchlist = undefined;
    return;
  }
}

function ref_1266C(var_0, var_1) {
  var_2 = self calloutmarkerping_entityzoffset("br_archived_flags");

  if(istrue(var_1)) {
    var_2 |= var_0;
  } else {
    var_2 &= ~var_0;
  }

  self setclientomnvar("br_archived_flags", var_2);
}

function ref_125CF(var_0) {
  ref_1266C(1, var_0);
}

function round_enemy_stuck_logic(var_0, var_1) {
  if(scripts\mp\menus::ref_13733()) {
    if(!isDefined(var_1) && scripts\mp\menus::brking_updateteamscore()) {
      return [];
    }

    return level.squaddata[var_0][var_1].players;
  }

  return level.teamdata[var_0]["players"];
}

function rotationrefsbyseatandweapon(var_0, var_1) {
  if(scripts\mp\menus::ref_13733()) {
    var_2 = [];

    foreach(var_4 in level.squaddata[var_0][var_1].players) {
      if(isalive(var_4)) {
        var_2 = var_4;
      }
    }

    return var_2;
  }

  return level.teamdata[var_4]["alivePlayers"];
}

function rotationids(var_0, var_1) {
  if(scripts\mp\menus::ref_13733()) {
    var_2 = 0;

    foreach(var_4 in level.squaddata[var_0][var_1].players) {
      if(isalive(var_4)) {
        var_2++;
      }
    }

    return var_2;
  }

  return level.teamdata[var_4]["aliveCount"];
}

function round_enemies_fallback_logic(var_0) {
  if(scripts\mp\menus::ref_13733()) {
    return getarraykeys(level.squaddata[var_0]);
  }

  return [0];
}

function replace_sat_piece_on_deathordisconnect() {
  if(scripts\mp\menus::ref_13733()) {
    return level.maxsquadsize;
  }

  return level.maxteamsize;
}

function ref_131C3(var_0, var_1, var_2, var_3) {
  if(scripts\mp\menus::ref_13733()) {
    if(!isDefined(level.squaddata[var_0][var_1].difficultytabledata)) {
      level.squaddata[var_0][var_1].difficultytabledata = [];
    }

    level.squaddata[var_0][var_1].difficultytabledata[var_2] = var_3;
    return;
  }

  level.teamdata[var_0][var_2] = var_3;
}

function round_at_max(var_0, var_1, var_2) {
  if(scripts\mp\menus::ref_13733()) {
    if(!isDefined(level.squaddata[var_0][var_1].difficultytabledata) || !isDefined(level.squaddata[var_0][var_1].difficultytabledata[var_2])) {
      return;
    }

    return level.squaddata[var_0][var_1].difficultytabledata[var_2];
  }

  return level.teamdata[var_0][var_2];
}

function ref_1276A(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\menus::ref_13733()) {
    var_5 = round_enemy_stuck_logic(var_2.team, var_2.squadindex);

    foreach(var_7 in var_5) {
      if(!isDefined(var_3) || var_7 != var_3) {
        self playsoundtoplayer(var_0, var_7, var_4);
      }
    }

    return;
  }

  self playsoundtoteam(var_0, var_1, var_3, var_4);
}

function updatesquadmemberlaststandreviveprogress(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_1[0], var_1[1], 0);
  var_5 = (var_2[0], var_2[1], 0);
  var_6 = vectorNormalize(var_3 - var_4);
  var_7 = vectorNormalize(var_5 - var_4);
  var_8 = vectordot(var_6, var_7);
  return var_8 > 0;
}

function woods_two_death_func(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0] - var_2[0];
  var_5 = var_0[1] - var_2[1];
  var_6 = var_1[0] - var_2[0];
  var_7 = var_1[1] - var_2[1];
  var_8 = float(var_3);
  var_9 = var_6 - var_4;
  var_10 = var_7 - var_5;
  var_11 = var_9 * var_9 + var_10 * var_10;
  var_12 = var_4 * var_7 - var_6 * var_5;
  var_13 = var_8 * var_8 * var_11 - var_12 * var_12;

  if(var_13 < 0) {
    return;
  }

  if(var_13 == 0) {
    var_14 = var_12 * var_10 / var_11 + var_2[0];
    var_15 = -1 * var_12 * var_9 / var_11 + var_2[1];
    return (var_14, var_15, 0);
  }

  var_16 = sqrt(var_15);
  var_17 = var_14 * var_12;
  var_18 = scripts\engine\utility::sign(var_12) * var_11 * var_16;
  var_19 = (var_17 + var_18) / var_13 + var_4[0];
  var_20 = (var_17 - var_18) / var_13 + var_4[0];
  var_21 = -1 * var_14 * var_11;
  var_22 = abs(var_12) * var_16;
  var_23 = (var_21 + var_22) / var_13 + var_4[1];
  var_24 = (var_21 - var_22) / var_13 + var_4[1];
  return [(var_19, var_23, 0), (var_20, var_24, 0)];
}

function registersuperextraweapon(var_0, var_1, var_2) {
  var_3 = woods_two_death_func(var_0, var_1, var_2.origin, var_2.radius);

  if(!isDefined(var_3)) {
    return;
  }

  if(!isarray(var_3)) {
    if(updatesquadmemberlaststandreviveprogress(var_3, var_0, var_1)) {
      return var_3;
    }

    return;
  }

  var_4 = updatesquadmemberlaststandreviveprogress(var_3[0], var_0, var_1);
  var_5 = updatesquadmemberlaststandreviveprogress(var_3[1], var_0, var_1);

  if(!var_4 && !var_5) {
    return;
  }

  if(var_4 && !var_5) {
    return var_3[0];
  }

  if(var_5 && !var_4) {
    return var_3[1];
  }

  var_6 = distance2dsquared(var_0, var_3[0]);
  var_7 = distance2dsquared(var_0, var_3[1]);

  if(var_6 < var_7) {
    return var_3[0];
  }

  return var_3[1];
}

function safehouse_struct(var_0, var_1, var_2) {
  var_3 = var_1[0] - var_0[0];
  var_4 = var_1[1] - var_0[1];
  var_5 = var_1[2] - var_0[2];

  if(var_3 != 0) {
    var_6 = (var_2[0] - var_0[0]) / var_3;
  } else {
    var_6 = (var_3[1] - var_1[1]) / var_5;
  }

  var_7 = var_1[2] + var_6 * var_6;
  return var_7;
}

function updaterectangularzone(var_0, var_1) {
  var_2 = var_1.origin[2];
  var_3 = var_2 + var_1.height;
  return var_0[2] >= var_2 && var_0[2] <= var_3;
}

function registertabletinit(var_0, var_1, var_2) {
  var_3 = woods_two_death_func(var_0, var_1, var_2.origin, var_2.radius);

  if(!isDefined(var_3)) {
    return;
  }

  if(!isarray(var_3)) {
    if(updatesquadmemberlaststandreviveprogress(var_3, var_0, var_1)) {
      var_4 = safehouse_struct(var_0, var_1, var_3);
      var_3 = (var_3[0], var_3[1], var_4);

      if(updaterectangularzone(var_3, var_2)) {
        return var_3;
      }

      return;
    }

    return;
  }

  var_5 = updatesquadmemberlaststandreviveprogress(var_4[0], var_1, var_2);
  var_6 = updatesquadmemberlaststandreviveprogress(var_4[1], var_1, var_2);

  if(!var_5 && !var_6) {
    return;
  }

  if(var_5 && !var_6) {
    var_4 = safehouse_struct(var_1, var_2, var_4[0]);
    var_4 = (var_4[0][0], var_4[0][1], var_4);

    if(updaterectangularzone(var_4[0], var_3)) {
      return var_4[0];
    }

    return;
  }

  if(var_4 && !var_6) {
    var_4 = safehouse_struct(var_2, var_3, var_5[1]);
    var_5 = (var_5[1][0], var_5[1][1], var_4);

    if(updaterectangularzone(var_5[1], var_4)) {
      return var_5[1];
    }

    return;
  }

  var_4 = safehouse_struct(var_3, var_4, var_6[0]);
  var_6 = (var_6[0][0], var_6[0][1], var_4);
  var_7 = updaterectangularzone(var_6[0], var_5);
  var_4 = safehouse_struct(var_3, var_4, var_6[1]);
  var_6 = (var_6[1][0], var_6[1][1], var_4);
  var_8 = updaterectangularzone(var_6[1], var_5);

  if(!var_7 && !var_8) {
    return;
  }

  if(var_7 && !var_8) {
    return var_6[0];
  }

  if(var_8 && !var_7) {
    return var_6[1];
  }

  var_9 = distance2dsquared(var_3, var_6[0]);
  var_10 = distance2dsquared(var_3, var_6[1]);

  if(var_9 < var_10) {
    return var_6[0];
  }

  return var_6[1];
}

function ref_12A18(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = registersuperextraweapon(var_0, var_1, var_5);

    if(isDefined(var_6)) {
      var_3 = var_6;
    }
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_11 = distance2dsquared(var_0, var_6);

    if(!isDefined(var_8) || var_11 < var_9) {
      var_8 = var_6;
      var_9 = var_11;
    }
  }

  return var_8;
}

function ref_12A19(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = registertabletinit(var_0, var_1, var_5);

    if(isDefined(var_6)) {
      var_3 = var_6;
    }
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_11 = distancesquared(var_0, var_6);

    if(!isDefined(var_8) || var_11 < var_9) {
      var_8 = var_6;
      var_9 = var_11;
    }
  }

  return var_8;
}

function nuke_vault_suicidebombers() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function shouldusegoldbarassets() {
  return getdvarint("scr_br_plunder_use_gold_bar_assets", 0) != 0;
}

function runbrgametypefuncwrapper(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_12E05)) {
    return [[level.disable_super_in_turret.ref_12E05]](var_0, var_1, var_2);
  }
}

function isbrgametypefuncdefinedwrapper(var_0) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.tutorial_showtext)) {
    return [[level.disable_super_in_turret.tutorial_showtext]](var_0);
  }

  return 0;
}

function isfeatureenabledwrapper(var_0) {
  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.unset_relic_aggressive_melee_params)) {
    return [[level.disable_super_in_turret.unset_relic_aggressive_melee_params]](var_0);
  }

  return 0;
}

function gunship_spawnvfx() {
  level endon("game_ended");

  if(level.gametype == "br") {
    wait 0.1;

    if(!isDefined(level.debugforcesre2)) {
      level.debugforcesre2 = "br_fx";
    }

    self setscriptablepartstate(level.debugforcesre2, "clouds");
    return;
  }

  var_0 = level._effect["vfx_snatch_ac130_clouds"];

  if(!isDefined(var_0)) {
    return;
  }

  wait 0.1;
  playFXOnTag(var_0, self, "tag_body");
}

function makepathstruct(var_0) {
  var_1 = var_0.r;
  var_2 = var_0.randomangle;
  var_3 = var_0.endangleoffset;
  var_4 = var_0.centerpt;
  var_5 = (var_2 + var_3) % 360;
  var_6 = (var_1 * cos(var_2), var_1 * sin(var_2), scripts\cp_mp\parachute::getc130height()) + var_4;
  var_7 = (var_1 * cos(var_5), var_1 * sin(var_5), scripts\cp_mp\parachute::getc130height()) + var_4;
  var_8 = vectorNormalize(var_7 - var_6);
  var_7 += var_8 * var_1;
  var_6 -= var_8 * var_1 * 2;
  var_9 = spawnStruct();
  var_9.startpt = var_6;
  var_9.endpt = var_7;
  var_9.angle = vectortoangles(var_8);
  return var_9;
}

function calctrailpoint() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}