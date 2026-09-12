/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_infils.gsc
***********************************************/

function main() {
  level.brlatespawnplayer = &latespawnplayer;
  level.stop_wave = ref_1300f();
  setdvarifuninitialized("br_infil_anim_enable_third_camera", 1);
  setdvarifuninitialized("br_infil_play_jump_anims", 1);
  setdvarifuninitialized("br_infil_bot_jumpmaster", 0);
  level.infilselectionmethod = "";
  level.infilcanusemap = 0;

  if(istrue(getdvarint("br_spawnSelectionInfil", 0))) {
    level.infilselectionmethod = getDvar("scr_br_infilselectionmethod", "exclusion");
    level.infilcanusemap = 1;
    level.get_bomb_interaction_ent_cut_hint = getdvarint("scr_br_canSoloJump", 1);
  }

  if(istrue(level.br_infils_disabled) && scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    thread laser_vfx_think(level, undefined);
  }

  initspawnexclusionpois();
  initinfillocationselectionhandlers();
}

function ref_1300f() {
  var_0 = 2;
  var_1 = getdvarint("scr_br_infilType", var_0);

  if(var_1 == 1) {
    if(level.mapname != "mp_don4" && level.mapname != "mp_don4_pm" && level.mapname != "mp_br_mechanics" && !scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent()) {
      var_1 = 2;
    }
  } else if(var_1 == 2) {
    if(level.mapname == "mp_don4" || scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent()) {
      var_1 = 1;
    } else if(level.mapname != "mp_wz_island" && level.mapname != "mp_br_mechanics") {
      var_1 = 0;
    }
  }

  return var_1;
}

function remove_munition_on_use() {
  var_0 = undefined;
  var_1 = undefined;

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    var_0 = 0;
    var_1 = 0;
  } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    var_0 = 0.45;
    var_1 = 0.6;
  } else {
    var_0 = 3.45;
    var_1 = 0.6;
  }

  return [var_0, var_1];
}

function setplayerprematchallows() {
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  self allowmelee(0);
  self disableoffhandweapons();
  level.freefallstartcb = &freefallstartfunc;
}

function freefallstartfunc() {
  self allowmelee(1);
  self enableoffhandweapons();
  thread scripts\cp_mp\parachute::ref_126cb();
}

function stop_player_trigger_monitor() {
  self endon("disconnect");

  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

function ref_1435f(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    neurotoxin_damage_loop(var_5);
    var_5 setmlgdamagedone();

    if(!istrue(level.br_infils_disabled)) {
      var_5 scripts\mp\gametypes\br::ref_1254d();
    }

    if(!isalive(var_5) && !istrue(var_5.waitingtospawnamortize)) {
      if(isDefined(var_1)) {
        var_5.forcespawnorigin = var_1;
      }

      stop_player_trigger_monitor(var_5);
    } else {
      var_5.br_infilstarted = 1;

      if(isDefined(var_1)) {
        var_5 setOrigin(var_1);
      }
    }

    if(!isDefined(var_5)) {
      continue;
    }

    if(isDefined(var_2)) {
      var_5 playerlinkTo(var_2);
    }

    if(istrue(var_5.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var_5, "waitAndForceSpawnAllPlayers");
    }

    var_5 notify("beginC130");
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("squadLeader")) {
    if(level.teambased) {
      foreach(var_8 in level.teamnamelist) {
        var_9 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_8);

        for(var_10 = 0; var_10 < var_9.size; var_10++) {
          var_11 = var_9[var_10];
          var_12 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_8, var_11);
          var_13 = ref_1322c(var_12);

          if(isDefined(var_13)) {
            ref_12b12(var_13);
            thread ref_14494(var_13, var_8);
          }

          scripts\mp\gametypes\br::ref_1401e(var_8, var_11);
        }
      }
    } else {
      var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

      foreach(var_5 in var_3) {
        if(isDefined(var_5)) {
          ref_12b12(var_5);
        }
      }
    }
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  level.snatchspawnalltoc130done = 1;
}

function neurotoxin_damage_loop() {
  var_0 = self;
  var_0 skydive_setdeploymentstatus(0);
  var_0 skydive_setbasejumpingstatus(0);

  if(isDefined(var_0.play_disguise_vo)) {
    var_0.play_disguise_vo = 5;
  }

  var_0 scripts\cp_mp\parachute::ref_121ca();
}

function ref_12b12(var_0) {
  if(!istrue(var_0.vehicle_occupancy_monitorcontrols)) {
    var_0.vehicle_occupancy_monitorcontrols = 1;
    var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 2);
    var_0 notifyonplayercommand("halo_jump_c130", "+gostand");
    var_0 notifyonplayercommand("br_break_squad", "+breath_sprint");
    return;
  }
}

function ref_14494(var_0, var_1) {
  scripts\engine\utility::ref_143a5("death", "disconnect");
  var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1);
  var_3 = ref_1322c(var_2);

  if(isDefined(var_3)) {
    ref_12b12(var_3);
    thread ref_14494(var_3, var_0);
    return;
  }
}

function performfailsafeinfil() {
  var_0 = (0, 0, 3000);

  if(isDefined(level.prematchspawnorigins) && level.prematchspawnorigins.size > 0) {
    var_1 = scripts\engine\utility::random(level.prematchspawnorigins);
    var_0 = var_1.origin;
  }

  var_2 = (0, randomintrange(0, 360), 0);
  self setOrigin(var_0, 1);
  self setplayerangles(var_2);
  wait 0.2;
  thread scripts\cp_mp\parachute::startfreefall(0, 1);
}

function latespawnplayer() {
  self endon("disconnect");
  var_0 = self;
  var_1 = scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid();

  if(getDvar("scr_br_lateSpawnFallback") != "" || var_1) {
    ref_11fcc();
  } else if(!isalive(var_0)) {
    if(!istrue(level.debugnextpropindex)) {
      var_2 = isbot(var_0) && scripts\mp\gametypes\br_public::tutorial_playSound();

      while(!istrue(level.delay_music_reinforcements) && !var_2) {
        if(!var_2) {
          var_0 scripts\mp\gametypes\br::ending_fade_in();
          var_0 setclientomnvar("ui_br_transition_type", 4);
        }

        wait 0.3;
      }

      thread watch_for_usb_notetrack();
    } else {
      var_0.delay_explosion_fx = 0;
      var_0.br_infilstarted = 1;

      if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("squadLeader")) {
        var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

        if(!isDefined(var_3) || var_3.size == 0) {
          var_3 = [self];
        }

        ref_1322c(var_3);
      }

      thread ref_11c49();
    }
  }

  var_0 setclientomnvar("ui_br_transition_type", 0);
  var_0 setclientomnvar("ui_br_extended_load_screen", 0);
}

function watch_for_usb_notetrack() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isalive(var_0)) {
    var_0.watch_for_usb_notetrack_switchoff = 1;
    var_0 scripts\mp\playerlogic::spawnplayer(0);
  }

  var_0 playerhide();
  var_0.watch_for_usb_notetrack_switchoff = undefined;
  var_0 freezecontrols(1);
  var_1 = 1;

  if(isDefined(var_0.team) && isDefined(var_0.squadindex)) {
    var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_1 = var_2.size == 1;
  }

  var_0.stop_counter_beep_sfx_on_bomb_vests = var_1;

  if(var_0 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
    var_0.infilanimindex = 1;
  }

  if(!isDefined(var_0.infilanimindex) && level.teambased) {
    var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_3 = fivecontracts(var_2.size);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = 0;

      foreach(var_7 in var_2) {
        if(var_7 != var_0 && var_7 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
          continue;
        }

        if(isDefined(var_7.infilanimindex) && isDefined(var_3[var_4]) && var_7.infilanimindex == var_3[var_4]) {
          var_5 = 1;
          break;
        }
      }

      if(!var_5) {
        var_0.infilanimindex = var_3[var_4];
        break;
      }
    }
  }

  playerjoininfil(var_0);
  playerlinktopositionent(var_0, level.watch_for_total_counts_below_num);
  scripts\mp\utility\game::ref_131a3(var_0, 1);
  var_9 = remove_objective_on_flag(level.watch_for_total_counts_below_num);
  var_0 setOrigin(var_9.origin);
  playerplayinfilloopanim(var_0, level.watch_for_total_counts_below_num);
  waitframe();
  var_10 = 0;

  if(!var_10) {
    if(isDefined(var_0.team) && level.teambased) {
      var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

      foreach(var_12 in var_2) {
        var_0 showtoplayer(var_12);
        var_12 showtoplayer(var_0);
      }
    }
  }

  if(!isbot(var_0)) {
    scripts\mp\gametypes\br_public::orbitcam(level.br_ac130);
  }

  wait 0.5;
  var_0 freezecontrols(0);
  var_0 setclientomnvar("ui_br_transition_type", 0);
  var_0.br_infilstarted = 1;
}

function fivecontracts(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0 - 1; var_2++) {
    var_1 = var_2 + 2;
  }

  return var_1;
}

function ref_11c49() {
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  var_0 scripts\mp\gametypes\br_gulag::playergulagautowin("missedInfilPlayerHandler", undefined, undefined, 1);
  var_0 scripts\mp\playerlogic::addtoalivecount("spawnPlayer");
}

function ref_11fcc() {
  self endon("disconnect");
  var_0 = self;

  if(!isalive(var_0)) {
    var_0 scripts\mp\playerlogic::spawnplayer(0);
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("squadLeader")) {
    if(level.teambased) {
      var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

      if(!isDefined(var_1) || var_1.size == 0) {
        var_1 = [self];
      }

      var_2 = ref_1322c(var_1);

      if(isDefined(var_2)) {
        ref_12b12(var_2);
      }
    } else {
      var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 2);
      ref_12b12(var_0);
    }
  }

  var_0.br_infilstarted = 1;
}

function takeloadoutatinfilend(var_0) {
  self takeweapon(self.weaponlist[0]);
  var_1 = getcompleteweaponname("ks_remote_map_snatch");
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(scripts\mp\utility\weapon::isgesture(var_4)) {
      continue;
    }

    if(isnullweapon(var_1, var_4)) {
      continue;
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  self.primaryweaponobj = undefined;
  self.primaryweapon = "none";
  self.pers["primaryWeapon"] = self.primaryweapon;
  self.secondaryweaponobj = undefined;
  self.secondaryweapon = "none";
  self.pers["secondaryWeapon"] = self.secondaryweapon;

  if(!istrue(var_0)) {
    var_6 = getforcedloadoutweapon();
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_6, 1);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_6);
    self setspawnweapon(var_6, 1);

    if(level.magcount == 0) {
      self setweaponammoclip(var_6, 0);
      self setweaponammostock(var_6, 0);
    } else {
      self setweaponammoclip(var_6, weaponclipsize(var_6));
      self setweaponammostock(var_6, weaponclipsize(var_6) * (level.magcount - 1));
    }

    self.secondaryweaponobj = var_6;
    self.secondaryweapon = createheadicon(self.secondaryweaponobj);
    self.pers["secondaryWeapon"] = self.secondaryweapon;
    return;
  }
}

function getforcedloadoutweapon() {
  return scripts\mp\class::buildweapon("iw8_pi_golf21", ["reflex", "none", "none", "none", "none"], "none", "none", -1, undefined, undefined, undefined, undefined, undefined, 0);
}

function ref_1322c(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }

  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
      return var_3;
    }
  }

  foreach(var_3 in var_0) {
    if(level.onlinegame && var_3 isfireteamleader()) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_7 = 0;
    var_8 = 0;

    foreach(var_3 in var_0) {
      var_10 = var_7 == isbot(var_3);

      if(var_10) {
        var_8++;
        var_11 = 1 / var_8;

        if(randomfloat(1) < var_11) {
          var_1 = var_3;
        }
      }
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_1 scripts\mp\gametypes\br::ref_1319d(1);

  foreach(var_3 in var_0) {
    if(var_3 != var_1) {
      var_3 scripts\mp\gametypes\br::ref_1319d(0);
    }

    var_16 = scripts\engine\utility::ter_op(var_3 scripts\mp\gametypes\br_public::updatedragonsbreath(), 2, 1);
    scripts\mp\gametypes\br_c130::setteammateomnvarsforplayer(var_3, var_0, var_16);
  }

  return var_1;
}

function firespoutwatch(var_0, var_1) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return firesaleforplayers(var_0, var_1);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return fix_collision(var_0, var_1);
  }

  return buildac130infilanimstruct(var_0, var_1);
}

function buildac130infilanimstruct(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2.movingc130 = var_0;
  }

  var_2.staticc130 = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(var_2.staticc130)) {
    var_2.staticc130 show();
  } else {
    var_2.staticc130 = spawn("script_model", getdvarvector("br_infil_anim_pos", (0, 0, 0)));
    var_2.staticc130 setModel("veh8_mil_air_acharlie130_magma_animated");
    var_2.staticc130.cleanme = 1;
  }

  var_2.cameraent = spawn("script_model", var_2.staticc130.origin);
  var_2.cameraent setModel("generic_prop_x5");

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_trigger = spawn("script_model", var_2.movingc130.origin);
    var_2.gas_trigger setModel("generic_prop_x5");
    var_2.gas_trigger linkTo(var_2.movingc130, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_2.gas_trigger unmarkkeyframedmover(1);
  }

  spawnplayerpositionparentent(var_2, var_2.staticc130);

  if(var_1 == "script_model") {
    var_2.playerslot1 = spawn("script_model", var_2.staticc130.origin);
    var_2.playerslot1 setModel("fullbody_usmc_ar_br_infil");
    var_2.playerslot2 = spawn("script_model", var_2.staticc130.origin);
    var_2.playerslot2 setModel("fullbody_usmc_ar_br_infil");
    var_2.playerslot3 = spawn("script_model", var_2.staticc130.origin);
    var_2.playerslot3 setModel("fullbody_usmc_ar_br_infil");
    var_2.playerslot4 = spawn("script_model", var_2.staticc130.origin);
    var_2.playerslot4 setModel("fullbody_usmc_ar_br_infil");
    var_2.playerslot1 linkTo(var_2.playerpositionents["parent"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.playerslot2 linkTo(var_2.playerpositionents["parent"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2.playerslot3 linkTo(var_2.playerpositionents["parent"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2.playerslot4 linkTo(var_2.playerpositionents["parent"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "script_model";
  } else {
    var_3 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"];

    foreach(var_5 in var_3) {
      spawnplayerpositionent(var_2, var_5);
    }

    var_2.infil_anim_type = "player";
  }

  var_2.aidoorchief = spawn("script_model", var_2.staticc130.origin);
  var_2.aidoorchief setModel("fullbody_usmc_ar_br_infil");

  if(isDefined(var_0) && isDefined(var_2.movingc130.innards)) {
    var_2.movingc130.innards linkTo(var_2.movingc130, "", (0, 0, 0), (0, 0, 0));
  }

  var_2.aidoorchief linkTo(var_2.playerpositionents["parent"], "j_prop_5", (0, 0, 0), (0, 0, 0));
  var_2.cameraent linkTo(var_2.staticc130, "", (0, 0, 0), (0, 0, 0));
  var_2.helicountdownendcallback = spawnfx(level._effect["vfx_br_infil_cloud_anim"], var_2.staticc130.origin);
  return var_2;
}

function firesaleforplayers(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2.ref_11dbf = var_0;
  }

  var_3 = scripts\engine\utility::getStruct("infil_plane_ch2", "script_noteworthy");
  var_2.origin = var_3.origin;
  var_2.angles = (0, 0, 0);

  if(isDefined(var_3.angles)) {
    var_2.angles = var_3.angles;
  }

  var_2.chopper = spawn("script_model", var_2.origin);
  var_2.chopper.angles = var_2.angles;
  var_2.chopper setModel("tag_origin");
  var_2.chopper.cleanme = 1;
  var_2.goalradiustarget = spawn("script_model", var_2.origin);
  var_2.goalradiustarget setModel("veh8_mil_air_mindia8_interior_infil_netting");
  var_2.goalradiustarget linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.givestandardtableloadout = spawn("script_model", var_2.origin);
  var_2.givestandardtableloadout setModel("veh8_mil_air_mindia8_interior_infil_cabin_door");
  var_2.givestandardtableloadout linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.gas_trigger_think = spawn("script_model", var_2.origin);
  var_2.gas_trigger_think setModel("generic_prop_x3");
  var_2.gas_trigger_think linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.gas_tryplaycoughaudio = spawn("script_model", var_2.origin);
  var_2.gas_tryplaycoughaudio setModel("generic_prop_x3");
  var_2.gas_tryplaycoughaudio linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_triggers_init = spawn("script_model", var_0.origin);
    var_2.gas_triggers_init setModel("generic_prop_x3");
    var_2.gas_triggers_init linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_2.gas_triggers_init unmarkkeyframedmover(1);
    var_2.gas_vfx_and_triggers = spawn("script_model", var_0.origin);
    var_2.gas_vfx_and_triggers setModel("generic_prop_x3");
    var_2.gas_vfx_and_triggers linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_2.gas_vfx_and_triggers unmarkkeyframedmover(1);
  }

  var_2.playerpositionents["parent_solo"] = spawn("script_model", var_2.origin);
  var_2.playerpositionents["parent_solo"] setModel("generic_prop_x3");
  var_2.playerpositionents["parent_solo"] linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.playerpositionents["parent_squad"] = spawn("script_model", var_2.origin);
  var_2.playerpositionents["parent_squad"] setModel("generic_prop_x5");
  var_2.playerpositionents["parent_squad"] linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(var_1 == "script_model") {
    var_2.ref_1269e = spawn("script_model", var_2.origin);
    var_2.ref_1269e setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_1269e linkTo(var_2.playerpositionents["parent_solo"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.ref_1269f = spawn("script_model", var_2.origin);
    var_2.ref_1269f setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_1269f linkTo(var_2.playerpositionents["parent_squad"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a0 = spawn("script_model", var_2.origin);
    var_2.ref_126a0 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a0 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a1 = spawn("script_model", var_2.origin);
    var_2.ref_126a1 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a1 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a2 = spawn("script_model", var_2.origin);
    var_2.ref_126a2 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a2 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "script_model";
  } else {
    var_2.playerpositionents["child_solo"] = spawn("script_model", var_2.playerpositionents["parent_solo"] gettagorigin("j_prop_1"));
    var_2.playerpositionents["child_solo"] setModel("tag_player");
    var_2.playerpositionents["child_solo"] linkTo(var_2.playerpositionents["parent_solo"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_1"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_1"));
    var_2.playerpositionents["child_squad_1"] setModel("tag_player");
    var_2.playerpositionents["child_squad_1"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_2"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_2"));
    var_2.playerpositionents["child_squad_2"] setModel("tag_player");
    var_2.playerpositionents["child_squad_2"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_3"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_3"));
    var_2.playerpositionents["child_squad_3"] setModel("tag_player");
    var_2.playerpositionents["child_squad_3"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_4"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_4"));
    var_2.playerpositionents["child_squad_4"] setModel("tag_player");
    var_2.playerpositionents["child_squad_4"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "player";
  }

  var_2.bot_gametype_attacker_defender_ai_director_update = spawn("script_model", var_2.origin);
  var_2.bot_gametype_attacker_defender_ai_director_update setModel("fullbody_mp_eastern_bale_3_1");
  var_2.bot_gametype_attacker_defender_ai_director_update linkTo(var_2.playerpositionents["parent_solo"], "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_2.bot_clear_hq_zone = spawn("script_model", var_2.origin);
  var_2.bot_clear_hq_zone setModel("fullbody_usmc_ar_br_infil");
  var_2.bot_clear_hq_zone linkTo(var_2.playerpositionents["parent_solo"], "j_prop_3", (0, 0, 0), (0, 0, 0));
  var_2.calloutmarkerpingvo_handleraddnewelement = spawn("script_model", var_2.origin);
  var_2.calloutmarkerpingvo_handleraddnewelement setModel("generic_prop_x10");
  var_2.calloutmarkerpingvo_handleraddnewelement linkTo(var_2.chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.calloutmarkerpingvo_handleraddnewelement unmarkkeyframedmover(1);
  var_4 = 9;
  var_2.calloutmarkerpingvo_getmaxsoundaliaslength = [];

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = spawn("script_model", var_2.origin);
    var_6 setModel("veh8_mil_air_mindia8_infil_flight");
    var_6 linkTo(var_2.calloutmarkerpingvo_handleraddnewelement, "j_prop_" + var_5 + 2, (0, 0, 0), (0, 0, 0));
    var_6 unmarkkeyframedmover(1);
    var_6 playLoopSound("br_heli_infil_fleet_lp");
    var_2.calloutmarkerpingvo_getmaxsoundaliaslength[var_2.calloutmarkerpingvo_getmaxsoundaliaslength.size] = var_6;
  }

  return var_2;
}

function fix_collision(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2.ref_11dc3 = var_0;
  }

  var_2.ref_13886 = getEnt("infil_plane_ch3", "script_noteworthy");

  if(isDefined(var_2.ref_13886)) {
    var_2.ref_13886 show();
  } else {
    var_2.ref_13886 = spawn("script_model", getdvarvector("br_infil_anim_pos", (0, 0, 0)));
    var_2.ref_13886 setModel("veh8_mil_air_acharlie130_magma_animated");
  }

  var_2.ref_13886.cleanme = 1;
  var_2.chopper_kill = spawn("script_model", var_2.ref_13886.origin);
  var_2.chopper_kill setModel("veh8_mil_air_skilo_interior_infil_int_bags_back_left_up");
  var_2.chopper_kill linkTo(var_2.ref_13886, "tag_bags_back_left_up", (0, 0, 0), (0, 0, 0));
  var_2.chopper_kill_vehicle = spawn("script_model", var_2.ref_13886.origin);
  var_2.chopper_kill_vehicle setModel("veh8_mil_air_skilo_interior_infil_int_bags_back_right_up");
  var_2.chopper_kill_vehicle linkTo(var_2.ref_13886, "tag_bags_back_right_up", (0, 0, 0), (0, 0, 0));
  var_2.chopper_kill_person = spawn("script_model", var_2.ref_13886.origin);
  var_2.chopper_kill_person setModel("veh8_mil_air_skilo_interior_infil_int_bags_back_right_low");
  var_2.chopper_kill_person linkTo(var_2.ref_13886, "tag_bags_back_right_low", (0, 0, 0), (0, 0, 0));
  var_2.ref_12915 = [var_2.chopper_kill, var_2.chopper_kill_vehicle, var_2.chopper_kill_person];
  var_2.ref_12d98 = spawn("script_model", var_2.ref_13886.origin);
  var_2.ref_12d98 setModel("veh8_mil_air_skilo_interior_infil_ropes");
  var_2.ref_12d98 linkTo(var_2.ref_13886, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.ref_13887 = getEnt("infil_skilo_door", "script_noteworthy");
  var_2.staticskilointerior = getEnt("static_skilo_interior", "script_noteworthy");
  var_2.staticskiloexterior = getEnt("static_skilo_exterior", "script_noteworthy");
  var_2.staticskilobottomlight = getEnt("static_skilo_bottom_light", "script_noteworthy");
  var_2.staticskilotoplight = getEnt("static_skilo_top_light", "script_noteworthy");
  var_2.gas_trigger_think = spawn("script_model", var_2.ref_13886.origin);
  var_2.gas_trigger_think setModel("generic_prop_x3");
  var_2.gas_trigger_think linkTo(var_2.ref_13886, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.gas_tryplaycoughaudio = spawn("script_model", var_2.ref_13886.origin);
  var_2.gas_tryplaycoughaudio setModel("generic_prop_x3");
  var_2.gas_tryplaycoughaudio linkTo(var_2.ref_13886, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_triggers_init = spawn("script_model", var_0.origin);
    var_2.gas_triggers_init setModel("generic_prop_x3");
    var_2.gas_triggers_init linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_2.gas_triggers_init unmarkkeyframedmover(1);
    var_2.gas_vfx_and_triggers = spawn("script_model", var_0.origin);
    var_2.gas_vfx_and_triggers setModel("generic_prop_x3");
    var_2.gas_vfx_and_triggers linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_2.gas_vfx_and_triggers unmarkkeyframedmover(1);
  }

  var_2.playerpositionents["parent_solo"] = spawn("script_model", var_2.ref_13886.origin);
  var_2.playerpositionents["parent_solo"] setModel("generic_prop_x3");
  var_2.playerpositionents["parent_solo"] linkTo(var_2.ref_13886, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2.playerpositionents["parent_squad"] = spawn("script_model", var_2.ref_13886.origin);
  var_2.playerpositionents["parent_squad"] setModel("generic_prop_x5");
  var_2.playerpositionents["parent_squad"] linkTo(var_2.ref_13886, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(var_1 == "script_model") {
    var_2.ref_1269e = spawn("script_model", var_2.ref_13886.origin);
    var_2.ref_1269e setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_1269e linkTo(var_2.playerpositionents["parent_solo"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.ref_1269f = spawn("script_model", var_2.ref_13886.origin);
    var_2.ref_1269f setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_1269f linkTo(var_2.playerpositionents["parent_squad"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a0 = spawn("script_model", var_2.ref_13886.origin);
    var_2.ref_126a0 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a0 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a1 = spawn("script_model", var_2.ref_13886.origin);
    var_2.ref_126a1 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a1 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2.ref_126a2 = spawn("script_model", var_2.ref_13886.origin);
    var_2.ref_126a2 setModel("fullbody_usmc_ar_br_infil");
    var_2.ref_126a2 linkTo(var_2.playerpositionents["parent_squad"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "script_model";
  } else {
    var_2.playerpositionents["child_solo"] = spawn("script_model", var_2.playerpositionents["parent_solo"] gettagorigin("j_prop_1"));
    var_2.playerpositionents["child_solo"] setModel("tag_player");
    var_2.playerpositionents["child_solo"] linkTo(var_2.playerpositionents["parent_solo"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_1"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_1"));
    var_2.playerpositionents["child_squad_1"] setModel("tag_player");
    var_2.playerpositionents["child_squad_1"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_2"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_2"));
    var_2.playerpositionents["child_squad_2"] setModel("tag_player");
    var_2.playerpositionents["child_squad_2"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_3"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_3"));
    var_2.playerpositionents["child_squad_3"] setModel("tag_player");
    var_2.playerpositionents["child_squad_3"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["child_squad_4"] = spawn("script_model", var_2.playerpositionents["parent_squad"] gettagorigin("j_prop_4"));
    var_2.playerpositionents["child_squad_4"] setModel("tag_player");
    var_2.playerpositionents["child_squad_4"] linkTo(var_2.playerpositionents["parent_squad"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "player";
  }

  if(isDefined(var_0) && isDefined(var_2.ref_11dc3.innards)) {
    var_2.ref_11dc3.innards linkTo(var_2.ref_11dc3, "", (0, 0, 0), (0, 0, 0));
  }

  return var_2;
}

function handlefriendlyvisibility(var_0) {
  if(isDefined(var_0.calloutmarkerpingvo_getmaxsoundaliaslength)) {
    foreach(var_2 in var_0.calloutmarkerpingvo_getmaxsoundaliaslength) {
      var_2 delete();
    }
  }

  if(isDefined(var_0.calloutmarkerpingvo_handleraddnewelement)) {
    var_0.calloutmarkerpingvo_handleraddnewelement delete();
  }

  if(isDefined(var_0.bot_clear_hq_zone)) {
    var_0.bot_clear_hq_zone delete();
  }

  if(isDefined(var_0.bot_gametype_attacker_defender_ai_director_update)) {
    var_0.bot_gametype_attacker_defender_ai_director_update delete();
  }

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_5 in var_0.playerpositionents) {
      var_5 delete();
    }
  }

  if(isDefined(var_0.ref_1269e)) {
    var_0.ref_1269e delete();
  }

  if(isDefined(var_0.ref_1269f)) {
    var_0.ref_1269f delete();
  }

  if(isDefined(var_0.ref_126a0)) {
    var_0.ref_126a0 delete();
  }

  if(isDefined(var_0.ref_126a1)) {
    var_0.ref_126a1 delete();
  }

  if(isDefined(var_0.ref_126a2)) {
    var_0.ref_126a2 delete();
  }

  if(isDefined(var_0.gas_trigger_think)) {
    var_0.gas_trigger_think delete();
  }

  if(isDefined(var_0.gas_tryplaycoughaudio)) {
    var_0.gas_tryplaycoughaudio delete();
  }

  if(isDefined(var_0.gas_triggers_init)) {
    var_0.gas_triggers_init delete();
  }

  if(isDefined(var_0.gas_vfx_and_triggers)) {
    var_0.gas_vfx_and_triggers delete();
  }

  if(isDefined(var_0.givestandardtableloadout)) {
    var_0.givestandardtableloadout delete();
  }

  if(isDefined(var_0.goalradiustarget)) {
    var_0.goalradiustarget delete();
  }

  if(isDefined(var_0.chopper) && istrue(var_0.chopper.cleanme)) {
    var_0.chopper delete();
  }

  if(isDefined(var_0.ref_11dbf) && istrue(var_0.ref_11dbf.cleanme)) {
    if(isDefined(var_0.ref_11dbf.innards) && istrue(var_0.ref_11dbf.innards.cleanme)) {
      var_0.ref_11dbf.innards delete();
    }

    var_0.ref_11dbf delete();
    return;
  }
}

function handleimpact(var_0) {
  scripts\mp\utility\sound::ref_12c2a("br_infil_skilo");

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_2 in var_0.playerpositionents) {
      var_2 delete();
    }
  }

  if(isDefined(var_0.ref_1269e)) {
    var_0.ref_1269e delete();
  }

  if(isDefined(var_0.ref_1269f)) {
    var_0.ref_1269f delete();
  }

  if(isDefined(var_0.ref_126a0)) {
    var_0.ref_126a0 delete();
  }

  if(isDefined(var_0.ref_126a1)) {
    var_0.ref_126a1 delete();
  }

  if(isDefined(var_0.ref_126a2)) {
    var_0.ref_126a2 delete();
  }

  if(isDefined(var_0.gas_trigger_think)) {
    var_0.gas_trigger_think delete();
  }

  if(isDefined(var_0.gas_tryplaycoughaudio)) {
    var_0.gas_tryplaycoughaudio delete();
  }

  if(isDefined(var_0.gas_triggers_init)) {
    var_0.gas_triggers_init delete();
  }

  if(isDefined(var_0.gas_vfx_and_triggers)) {
    var_0.gas_vfx_and_triggers delete();
  }

  if(isDefined(var_0.ref_12d98)) {
    var_0.ref_12d98 delete();
  }

  foreach(var_5 in var_0.ref_12915) {
    if(isDefined(var_5)) {
      var_5 delete();
    }
  }

  if(isDefined(var_0.ref_13886) && istrue(var_0.ref_13886.cleanme)) {
    var_0.ref_13886 delete();
  }

  if(isDefined(var_0.ref_13887)) {
    var_0.ref_13887 delete();
  }

  if(isDefined(var_0.staticskilointerior)) {
    var_0.staticskilointerior delete();
  }

  if(isDefined(var_0.staticskiloexterior)) {
    var_0.staticskiloexterior delete();
  }

  if(isDefined(var_0.staticskilobottomlight)) {
    var_0.staticskilobottomlight delete();
  }

  if(isDefined(var_0.staticskilotoplight)) {
    var_0.staticskilotoplight delete();
  }

  if(isDefined(var_0.ref_11dc3) && istrue(var_0.ref_11dc3.cleanme)) {
    if(isDefined(var_0.ref_11dc3.innards) && istrue(var_0.ref_11dc3.innards.cleanme)) {
      var_0.ref_11dc3.innards delete();
    }

    if(isDefined(var_0.ref_11dc3.bunker_numberstation) && istrue(var_0.ref_11dc3.bunker_numberstation.cleanme)) {
      var_0.ref_11dc3.bunker_numberstation delete();
    }

    if(isDefined(var_0.ref_11dc3.door) && istrue(var_0.ref_11dc3.door.cleanme)) {
      var_0.ref_11dc3.door delete();
    }

    var_0.ref_11dc3 delete();
    return;
  }
}

function handleheadshotkillrewardbullets(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    handlefriendlyvisibility(var_0);
    return;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    handleimpact(var_0);
    return;
  }

  scripts\mp\gametypes\br_public::cleanac130struct(var_0);
}

function laser_vfx_think(var_0, var_1) {
  level endon("game_ended");
  var_2 = getEntArray("skilo_props", "script_noteworthy");

  if(istrue(var_1)) {
    if(isDefined(var_0)) {
      var_3 = remove_munitions_in_radius(var_0);
      var_3 waittillmatch("camera", "end");
    }
  }

  foreach(var_5 in var_2) {
    if(isDefined(var_5)) {
      var_5 delete();
    }
  }
}

function spawnplayerpositionparentent(var_0, var_1) {
  var_0.playerpositionents["parent"] = spawn("script_model", var_1.origin);
  var_0.playerpositionents["parent"] setModel("generic_prop_x5");
  var_0.playerpositionents["parent"] linkTo(var_1, "", (0, 0, 0), (0, 0, 0));
}

function spawnplayerpositionent(var_0, var_1) {
  var_0.playerpositionents[var_1] = spawn("script_model", var_0.playerpositionents["parent"] gettagorigin(var_1));
  var_0.playerpositionents[var_1] setModel("tag_player");
  var_0.playerpositionents[var_1] linkTo(var_0.playerpositionents["parent"], var_1, (0, 0, 0), (0, 0, 0));
}

function remove_veh_spawners_from_passive_wave_spawning(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return remove_usability_crutch_on_death(var_0);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return removeaccesscard(var_0);
  }

  return remove_tank_class(var_0);
}

#using_animtree("");

function remove_usability_crutch_on_death(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0.ref_11dbf.angles);
  var_4 = anglestoright(var_0.ref_11dbf.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45);

  if(var_5 < -1 * var_7) {
    return ["wz_infil_mindia8_jump_genpropx10", %wz_infil_mindia8_jump_genpropx10, "wz_infil_mindia8_jump01_pl01"];
  }

  if(var_6 > var_7) {
    return ["wz_infil_mindia8_jump_genpropx10_90_l", $wz_infil_mindia8_jump_genpropx10_90_l, "wz_infil_mindia8_jump01_pl01_90_l"];
  }

  if(var_6 < -1 * var_7) {
    return ["wz_infil_mindia8_jump_genpropx10_90_r", %wz_infil_mindia8_jump_genpropx10_90_r, "wz_infil_mindia8_jump01_pl01_90_r"];
  }

  if(var_6 > 0) {
    return ["wz_infil_mindia8_jump_genpropx10_180_l", %wz_infil_mindia8_jump_genpropx10_180_l, "wz_infil_mindia8_jump01_pl01_180_l"];
  }

  return ["wz_infil_mindia8_jump_genpropx10_180_r", %wz_infil_mindia8_jump_genpropx10_180_r, "wz_infil_mindia8_jump01_pl01_180_r"];
}

function remove_tank_class(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0.movingc130.angles);
  var_4 = anglestoright(var_0.movingc130.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45);

  if(var_5 < -1 * var_7) {
    return ["sdr_mp_infil_ac130_jump_genpropx10", %sdr_mp_infil_ac130_jump_genpropx10, "sdr_mp_infil_ac130_jump"];
  }

  if(var_6 > var_7) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_l", %sdr_mp_infil_ac130_jump_genpropx10_90_l, "sdr_mp_infil_ac130_jump_90_l"];
  }

  if(var_6 < -1 * var_7) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_r", %sdr_mp_infil_ac130_jump_genpropx10_90_r, "sdr_mp_infil_ac130_jump_90_r"];
  }

  if(var_6 > 0) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_l", %sdr_mp_infil_ac130_jump_genpropx10_180_l, "sdr_mp_infil_ac130_jump_180_l"];
  }

  return ["sdr_mp_infil_ac130_jump_genpropx10_180_r", %sdr_mp_infil_ac130_jump_genpropx10_180_r, "sdr_mp_infil_ac130_jump_180_r"];
}

function removeaccesscard(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0.ref_11dc3.angles);
  var_4 = anglestoright(var_0.ref_11dc3.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45);

  if(var_5 < -1 * var_7) {
    return ["wz_infil_skilo_jump_genpropx10", %wz_infil_skilo_jump_genpropx10, "wz_infil_skilo_jump01_pl01"];
  }

  if(var_6 > var_7) {
    return ["wz_infil_skilo_jump_genpropx10_90_l", %wz_infil_skilo_jump_genpropx10_90_l, "wz_infil_skilo_jump01_pl01_90_l"];
  }

  if(var_6 < -1 * var_7) {
    return ["wz_infil_skilo_jump_genpropx10_90_r", %wz_infil_skilo_jump_genpropx10_90_r, "wz_infil_skilo_jump01_pl01_90_r"];
  }

  if(var_6 > 0) {
    return ["wz_infil_skilo_jump_genpropx10_180_l", %wz_infil_skilo_jump_genpropx10_180_l, "wz_infil_skilo_jump01_pl01_180_l"];
  }

  return ["wz_infil_skilo_jump_genpropx10_180_r", %wz_infil_skilo_jump_genpropx10_180_r, "wz_infil_skilo_jump01_pl01_180_r"];
}

function ref_1274b(var_0) {
  var_1 = "";

  if(var_0 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
    var_1 = "br_infil_squad_leader_jump";
  } else {
    var_1 = "br_infil_squadmate_jump";
  }

  var_0 scripts\mp\gametypes\br_public::ref_1276a(var_1, var_0.team, var_0);
}

function watchinfiljumpanim(var_0) {
  self endon("death_or_disconnect");

  if(!isDefined(level.infiljumpentsspawned)) {
    level.infiljumpentsspawned = 0;
  }

  self.shouldhumanspawntags = 0;
  self waittill("br_jump");
  var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
  var_2 = [];

  if(self.jumptype == "leader") {
    foreach(var_4 in var_1) {
      if(isDefined(var_4.infilanimindex)) {
        var_2 = var_4;
      }
    }
  } else if(self.jumptype == "solo" || self.jumptype == "outOfBounds") {
    var_2 = [self];
  }

  var_6 = var_2.size > 0;

  if(var_6) {
    var_7 = getdvarint("br_infil_play_jump_anims", 1) != 0;

    if(level.infiljumpentsspawned >= 100) {
      var_7 = 0;
    }

    var_8 = undefined;

    if(var_7) {
      var_8 = 0;
      var_9 = remove_veh_spawners_from_passive_wave_spawning(var_0);
      var_10 = var_9[0];
      var_11 = var_9[1];
      var_12 = var_9[2];
      var_9 = undefined;
      var_13 = remove_objective_on_flag(var_0);
      GscBinSkip1(0x45, "parent", spawn("script_model", var_13.origin));
    }

    var_13 = 1;
    waittillframeend();

    foreach(var_4 in var_10) {
      var_4.infilanimindex = undefined;
      var_4 stopanimscriptsceneevent();
      var_4 notify("infil_jump_done");
      var_4 scripts\mp\gametypes\br::ref_1254e();
    }

    if(var_13) {
      waitframe();
      var_13 = remove_objective_on_flag(var_8);

      if(isDefined(var_13)) {
        if(isDefined(var_13.playeroffsets) && isDefined(var_13.currentplayeroffset)) {
          foreach(var_4 in var_10) {
            var_28 = var_13.playeroffsets[var_13.currentplayeroffset];
            var_4 setOrigin(var_13.origin + var_28, 1, 1);
            var_13.currentplayeroffset++;

            if(var_13.currentplayeroffset == var_13.playeroffsets.size) {
              var_13.currentplayeroffset = 0;
            }

            var_4 playershow(1);
            thread ref_1274b(level);
          }

          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function playinfilplayeranims(var_0, var_1) {
  var_2 = ref_1256d(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 thread[[level.parachutetakeweaponscb]]();
    var_5 scripts\mp\gametypes\br::ref_1254d();
    scripts\mp\utility\game::ref_131a3(var_5, 1);
    var_5.plotarmor = 1;
    var_5 unlink();
    playerlinktopositionent(var_5, var_0);
    var_6 = ref_1256e(var_5, var_0);
    var_5 playanimscriptsceneevent("scripted_scene", var_6);
  }

  wait var_2;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    thread playerplayinfilloopanim(var_5);
  }
}

function ref_1256d(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return getanimlength(%wz_infil_mindia8_solo_player);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return getanimlength(%wz_infil_skilo_single_sdr01);
  }

  return getanimlength(%sdr_mp_infil_ac130_redux_player1);
}

function ref_1256e(var_0) {
  var_1 = "";
  var_2 = self hasfemalecustomizationmodel();

  if(var_2) {
    var_1 = "_fem";
  }

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return ("wz_infil_mindia8_solo_player" + var_1);
    }

    return ("wz_infil_mindia8_squad_player" + self.infilanimindex + var_1);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return ("wz_infil_skilo_single_sdr01" + var_1);
    }

    return ("wz_infil_skilo_squad_sdr0" + self.infilanimindex + var_1);
  }

  return "sdr_mp_infil_ac130_redux_player" + self.infilanimindex;
}

function ref_1256f(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return "wz_infil_mindia8_loop_pl01";
    }

    return ("wz_infil_mindia8_loop_pl0" + self.infilanimindex);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return "wz_infil_skilo_squad_sdr01_loop";
    }

    return ("wz_infil_skilo_squad_sdr0" + self.infilanimindex + "_loop");
  }

  return "sdr_mp_infil_ac130_loop_pl0" + self.infilanimindex;
}

function ref_12571(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return var_0.playerpositionents["child_solo"];
    }

    return var_0.playerpositionents["child_squad_" + self.infilanimindex];
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return var_0.playerpositionents["child_solo"];
    }

    return var_0.playerpositionents["child_squad_" + self.infilanimindex];
  }

  return var_0.playerpositionents["j_prop_" + self.infilanimindex];
}

function ref_12572(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return "j_prop_1";
    }

    return ("j_prop_" + self.infilanimindex);
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests) {
      return "j_prop_1";
    }

    return ("j_prop_" + self.infilanimindex);
  }

  return "j_prop_" + self.infilanimindex;
}

function playerlinktopositionent(var_0) {
  if(isai(self) && !istrue(self.hasspawned)) {
    return;
  }

  if(!isDefined(self.infilanimindex)) {
    self.infilanimindex = 1;
  }

  var_1 = ref_12571(var_0);
  self playerlinkTo(var_1, "tag_player");
}

function playerplayinfilloopanim(var_0) {
  if(!isDefined(self.infilanimindex)) {
    self.infilanimindex = 1;
  }

  if(!isDefined(self.stop_counter_beep_sfx_on_bomb_vests)) {
    var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
    self.stop_counter_beep_sfx_on_bomb_vests = var_1.size == 1;
  }

  var_2 = ref_1256f(var_0);
  self playanimscriptsceneevent("scripted_scene", var_2);
  thread watchinfiljumpanim(var_0);
}

function ref_12ab5(var_0) {
  var_0 endon("stopScene");
  var_0.staticc130 waittillmatch("plane", "gored");
  var_1 = getentitylessscriptablearrayinradius("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_on", 1);
  }
}

function serverroomrewardlocs(var_0) {
  var_0 endon("stopScene");
  var_0.staticc130 waittillmatch("plane", "gogreen");
  var_1 = getentitylessscriptablearrayinradius("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_jump", 1);
  }
}

function ref_133b1(var_0) {
  var_0 endon("stopScene");
  var_1 = getentitylessscriptablearrayinradius("infil_green_light", "script_noteworthy");
  var_2 = getentitylessscriptablearrayinradius("infil_green_light_spot", "script_noteworthy");
  var_3 = getentitylessscriptablearrayinradius("infil_red_light", "script_noteworthy");
  var_4 = getentitylessscriptablearrayinradius("infil_red_light_spot", "script_noteworthy");

  foreach(var_6 in var_1) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_green", "light_off_hold", 1);
  }

  foreach(var_6 in var_2) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_green_spot", "light_off_hold", 1);
  }

  foreach(var_6 in var_3) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_red", "light_on", 1);
  }

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_red_spot", "light_on", 1);
  }

  wait 4.6;

  foreach(var_6 in var_1) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_green", "light_jump", 1);
  }

  foreach(var_6 in var_2) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_green_spot", "light_jump", 1);
  }

  foreach(var_6 in var_3) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_red", "light_jump", 1);
  }

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("light_blinking_infil_wz_island_red_spot", "light_jump", 1);
  }
}

function ref_11fac(var_0) {
  var_1 = getentitylessscriptablearrayinradius("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_off_hold", 1);
  }
}

function ref_126f4(var_0, var_1) {
  var_0 endon("stopScene");
  var_0.staticc130 scripts\engine\utility::waittill_match_or_timeout("plane", "opendoor", 30);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }

    var_4 scripts\mp\utility\player::ref_1328c("100", 1);
  }

  var_0.aidoorchief scripts\mp\utility\player::ref_1328c("100");
}

function headoffset(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4.manualoverridewindmaterial = undefined;
  }

  var_0.aidoorchief scripts\mp\utility\player::ref_1328c("0");
}

function ref_126f5(var_0, var_1) {
  var_0 endon("stopScene");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }

    var_4 scripts\mp\utility\player::ref_1328c("80", 1);
  }
}

function headshot_distance(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4.manualoverridewindmaterial = undefined;
  }
}

function ref_126f6(var_0, var_1) {
  var_0 endon("stopScene");
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("camera", "opendoor", 30);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }

    var_4 scripts\mp\utility\player::ref_1328c("80", 1);
  }
}

function healdamage(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4.manualoverridewindmaterial = undefined;
  }
}

function healthpack_health(var_0) {
  ref_14361(7.7);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 clearsoundsubmix("mp_br_infil_ac130", 30);
  }
}

function healthpool(var_0) {
  ref_14361(0.65);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 clearsoundsubmix("mp_br_infil_anim", 3);
  }
}

function health_remaining_max(var_0) {
  ref_14361(0.5);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 1);
  }
}

function ref_131bf(var_0) {
  ref_14361(2);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
    var_3 setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2);
  }
}

function ref_12c3e(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3 getlinkedchildren();

    if(isDefined(var_4) && var_4.size) {
      var_5 = var_4.size;

      if(var_5 > 0) {
        var_6 = "Infil Player (" + var_3.name + ") with (" + var_5 + ") linked ents: ";

        foreach(var_8 in var_4) {
          if(isDefined(var_8.equipmentref)) {
            var_6 += "equip:" + var_8.equipmentref + ",";
            continue;
          }

          if(isDefined(var_8.weapon_name)) {
            var_6 += "weapon:" + var_8.weapon_name + ",";
            continue;
          }

          if(isDefined(var_8.model)) {
            var_6 += "model:" + var_8.model + ",";
            continue;
          }

          var_6 += "?,";
        }

        scripts\mp\utility\script::laststand_dogtags(var_6);
      }
    }
  }
}

function ref_1273c(var_0, var_1) {
  ref_12c3e(var_1);

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    ref_1245a(var_0, var_1);
    return;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    ref_12765(var_0, var_1);
    return;
  }

  playac130infilanim(var_0, var_1);
}

function ref_1245a(var_0, var_1) {
  thread ref_131bf(var_1);
  ref_12459(var_0, var_1);
  ref_13ce9(var_0, var_1);
  mp_m_trench_patch_giveplayer_c4(var_0, var_1);
}

function playac130infilanim(var_0, var_1) {
  thread ref_131bf(var_1);
  ref_12442(var_0, var_1);
  ref_13ce8(var_0, var_1);
  mp_m_speed_patch(var_0, var_1);
}

function ref_12765(var_0, var_1) {
  thread ref_131bf(var_1);
  ref_12764(var_0, var_1);
  ref_13cf1(var_0, var_1);
  neverspectate(var_0, var_1);
}

function helicopter_death_lockon_clear(var_0) {
  var_0 endon("stopScene");
  var_0.staticc130 waittillmatch("plane", "transitionstart");
  triggerfx(var_0.helicountdownendcallback);
}

function ref_1324f(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.sort = -1;
  var_0.color = (0.21, 0.21, 0.17);
  var_0.alpha = 0;
  var_0 sendcollectedclientanticheatdata(1);
}

function ref_13250(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.sort = -1;
  var_0.color = (0.93, 0.95, 0.94);
  var_0.alpha = 0;
  var_0 sendcollectedclientanticheatdata(1);
}

function remove_munitions_globally() {
  var_0 = undefined;
  var_1 = undefined;

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    var_0 = 0.15;
    var_1 = 0.2;
  } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    var_0 = 0.16;
    var_1 = 0.5;
  } else {
    var_0 = 0.16;
    var_1 = 0.5;
  }

  return [var_0, var_1];
}

function patch_ent_fixes(var_0, var_1) {
  level endon("game_ended");
  var_2 = remove_munitions_in_radius(var_0);

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_4 = level.players.size == var_3.size;

  if(var_4) {
    level.stop_passedby_once = newhudelem();
    ref_1324f(level.stop_passedby_once);
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_passedby_once = newclienthudelem(var_6);
      ref_1324f(var_6.stop_passedby_once);
    }
  }

  var_8 = remove_munitions_globally();
  var_9 = var_8[0];
  var_10 = var_8[1];
  var_8 = undefined;
  var_2 waittillmatch("camera", "fadeinstart");

  if(var_4) {
    level.stop_passedby_once fadeovertime(var_9);
    level.stop_passedby_once.alpha = 1;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_passedby_once fadeovertime(var_9);
      var_6.stop_passedby_once.alpha = 1;
    }
  }

  var_2 waittillmatch("camera", "fadeoutstart");

  if(var_4) {
    level.stop_passedby_once fadeovertime(var_10);
    level.stop_passedby_once.alpha = 0;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_passedby_once fadeovertime(var_10);
      var_6.stop_passedby_once.alpha = 0;
    }
  }

  ref_14361(var_10 + 0.1);

  if(var_4) {
    level.stop_passedby_once destroy();
    level.stop_passedby_once = undefined;
    return;
  }

  foreach(var_6 in var_3) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6.stop_passedby_once destroy();
  }
}

function helicopter_firendly_dmg_text_display(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("stopScene");
  var_2 = remove_munitions_in_radius(var_0);

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_4 = level.players.size == var_3.size;

  if(var_4) {
    level.stop_turbulence_just_before_the_end = newhudelem();
    ref_13250(level.stop_turbulence_just_before_the_end);
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_turbulence_just_before_the_end = newclienthudelem(var_6);
      ref_13250(var_6.stop_turbulence_just_before_the_end);
    }
  }

  var_8 = 0.2;
  var_9 = 0.6;
  var_2 waittillmatch("camera", "coverstart");
  wait 0.12;

  if(var_4) {
    level.stop_turbulence_just_before_the_end fadeovertime(var_8);
    level.stop_turbulence_just_before_the_end.alpha = 1;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_turbulence_just_before_the_end fadeovertime(var_8);
      var_6.stop_turbulence_just_before_the_end.alpha = 1;
    }
  }

  var_2 waittillmatch("camera", "end");
  wait 0.3;

  if(var_4) {
    level.stop_turbulence_just_before_the_end fadeovertime(var_9);
    level.stop_turbulence_just_before_the_end.alpha = 0;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6.stop_turbulence_just_before_the_end fadeovertime(var_9);
      var_6.stop_turbulence_just_before_the_end.alpha = 0;
    }
  }

  ref_14361(var_9 + 0.1);

  if(var_4) {
    level.stop_turbulence_just_before_the_end destroy();
    level.stop_turbulence_just_before_the_end = undefined;
    return;
  }

  foreach(var_6 in var_3) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6.stop_turbulence_just_before_the_end destroy();
  }
}

function stimmodelattached(var_0) {
  var_1 = getdvarfloat("LKOLRONRNQ");
  var_2 = getdvarint("LTQMSPKRKO");
  var_3 = getdvarint("MROOOROPKL");
  var_4 = getdvarfloat("NPONLLLSPL");
  setDvar("LKOLRONRNQ", 1000);
  setDvar("LTQMSPKRKO", 6);
  setDvar("MROOOROPKL", 8);
  setDvar("NPONLLLSPL", 0.25);
  var_0 scripts\engine\utility::waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar("LKOLRONRNQ", var_1);
  setDvar("LTQMSPKRKO", var_2);
  setDvar("MROOOROPKL", var_3);
  setDvar("NPONLLLSPL", var_4);
}

function stompeenemyprogressupdate(var_0) {
  var_1 = getdvarfloat("LKOLRONRNQ");
  var_2 = getdvarint("LTQMSPKRKO");
  var_3 = getdvarint("MROOOROPKL");
  var_4 = getdvarfloat("NPONLLLSPL");
  setDvar("LKOLRONRNQ", 1000);
  setDvar("LTQMSPKRKO", 8);
  setDvar("MROOOROPKL", 8);
  setDvar("NPONLLLSPL", 0.25);
  var_0 scripts\engine\utility::waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar("LKOLRONRNQ", var_1);
  setDvar("LTQMSPKRKO", var_2);
  setDvar("MROOOROPKL", var_3);
  setDvar("NPONLLLSPL", var_4);
}

function givecustomloadout(var_0) {
  if(isDefined(var_0.givestandardtableloadout)) {
    var_0.givestandardtableloadout hide();
  }

  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("camera", "showdoor", 30);

  if(isDefined(var_0.givestandardtableloadout)) {
    var_0.givestandardtableloadout show();
    return;
  }
}

function cargo_truck_mg_initinteract(var_0, var_1) {
  var_2 = undefined;

  if(var_0.infil_anim_type == "player") {
    jumpiftrue(isDefined(var_1)) LOC_0000013f;

    foreach(var_4 in level.teamnamelist) {
      var_5 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_4);

      for(var_6 = 0; var_6 < var_5.size; var_6++) {
        var_7 = var_5[var_6];
        var_8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_4, var_7);
        var_9 = var_8.size == 1;
        var_10 = fivecontracts(var_8.size);

        foreach(var_12 in var_8) {
          if(var_12 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
            var_12.infilanimindex = 1;
          } else {
            var_13 = scripts\engine\utility::random(var_10);
            var_12.infilanimindex = var_13;
            var_10 = scripts\engine\utility::array_remove(var_10, var_13);
          }

          var_12.stop_counter_beep_sfx_on_bomb_vests = var_9;
        }
      }
    }

    ref_12acc();

    foreach(var_12 in level.players) {
      if(isDefined(var_12) && !isDefined(var_12.stop_counter_beep_sfx_on_bomb_vests)) {
        var_12.infilanimindex = 1;
        var_12.stop_counter_beep_sfx_on_bomb_vests = 1;
      }
    }

    return;
  }
}

function ref_12442(var_0, var_1) {
  var_0 endon("stopScene");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_2 = 34;
  var_3 = 5.6;
  var_4 = 50.7;
  var_5 = 2;
  var_6 = 4;
  var_0.cameraent scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera");

  if(isDefined(var_0.gas_trigger)) {
    var_0.gas_trigger scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera");
  }

  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 stoploopsound();
  }

  var_7 = scripts\mp\gametypes\br_public::isusinginfilselection();
  var_0.aidoorchief hide();
  var_8 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }

    if(!var_7) {
      var_10 setsoundsubmix("mp_br_infil_anim", 0);
      var_10 setsoundsubmix("mp_br_infil_music", 0);

      if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level.ref_12d05)) {
        var_10 setsoundsubmix("mp_br_infil_ac130", 0);
      }

      var_10 setclienttriggeraudiozone("mp_donetsk_infil_int", 1);
    }

    var_0.gas_trap_weapon = "j_prop_" + var_10.infilanimindex;
    var_10 cameraunlink();
    var_10 cameralinkTo(var_0.cameraent, var_0.gas_trap_weapon, 1, 1);
    var_10 setclientdvar("QTSPTNLOL", var_2);
    var_10 enablephysicaldepthoffieldscripting();
    var_10 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    var_10 scripts\mp\utility\player::_freezelookcontrols(1);
    var_0.aidoorchief showtoplayer(var_10);
  }

  thread healthpool(var_1);
  thread getlightingvalues();
  playFXOnTag(level._effect["vfx_br_ac130_clouds"], var_0.staticc130, "tag_body");
  var_0.staticc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");

  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");
    var_0.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "planeInnards");
  }

  var_0.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_redux_character_link", "prop");

  if(var_0.infil_anim_type == "script_model") {
    var_0.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player1", "p1");
    var_0.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player2", "p2");
    var_0.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player3", "p3");
    var_0.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player4", "p4");
  } else if(var_0.infil_anim_type == "player") {
    thread playinfilplayeranims(var_0, var_1);
  }

  var_0.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_redux_doorchief", "doorchief");
  thread ref_11fac(level);
  thread ref_12ab5(level);
  thread serverroomrewardlocs(level);
  thread ref_126f4(level, var_0);
  thread helicopter_death_lockon_clear(level);
  thread patch_ent_fixes(level, var_0);
  thread stimmodelattached(level);
  thread ks_circleminimapradius(level, var_0);
  var_0.cameraent scripts\engine\utility::waittill_match_or_timeout("camera", "transition", 30);
  var_0 notify("infil_reset_light_dvars");
  headoffset(level, var_0, var_1);
}

function ref_12459(var_0, var_1, var_2, var_3) {
  var_0 endon("stopScene");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_4 = 48;
  var_5 = 5.6;
  var_6 = 50.7;
  var_7 = 2;
  var_8 = 4;
  var_0.gas_trigger_think scriptmodelplayanim("wz_infil_mindia8_solo_cam", "camera");

  if(isDefined(var_0.gas_triggers_init)) {
    var_0.gas_triggers_init scriptmodelplayanim("wz_infil_mindia8_solo_cam", "camera");
  }

  var_0.gas_tryplaycoughaudio scriptmodelplayanim("wz_infil_mindia8_squad_cam", "camera");

  if(isDefined(var_0.gas_vfx_and_triggers)) {
    var_0.gas_vfx_and_triggers scriptmodelplayanim("wz_infil_mindia8_squad_cam", "camera");
  }

  if(isDefined(var_0.ref_11dbf)) {
    var_0.ref_11dbf stoploopsound();
  }

  var_0.bot_gametype_attacker_defender_ai_director_update hide();
  var_0.bot_clear_hq_zone hide();
  var_9 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_11 in var_9) {
    if(!isDefined(var_11)) {
      continue;
    }

    var_11 playlocalsound("br_heli_infil_part2_lr");
    var_11 setsoundsubmix("mp_br_infil_anim", 0);
    var_11 setsoundsubmix("mp_br_infil_music", 0);

    if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level.ref_12d05)) {
      var_11 setsoundsubmix("mp_br_infil_ac130", 0);
    }

    var_11 setclienttriggeraudiozone("mp_donetsk_infil_int", 1);
    var_12 = scripts\engine\utility::ter_op(var_11.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_trigger_think, var_0.gas_tryplaycoughaudio);
    var_13 = "j_prop_1";
    var_11 cameraunlink();
    var_11 cameralinkTo(var_12, var_13, 1, 1);
    var_11 setclientdvar("QTSPTNLOL", var_4);
    var_11 setclientdvar("LTMOQONPQ", 1);
    var_11 enablephysicaldepthoffieldscripting();
    var_11 setphysicaldepthoffield(var_5, var_6, var_7, var_8);
    var_11 scripts\mp\utility\player::_freezelookcontrols(1);
    var_0.bot_gametype_attacker_defender_ai_director_update showtoplayer(var_11);
    var_0.bot_clear_hq_zone showtoplayer(var_11);
  }

  thread healthpool(var_1);

  if(isDefined(var_0.ref_11dbf)) {
    var_0.ref_11dbf setscriptablepartstate("infil_fx_hero", "on");
  }

  var_0.playerpositionents["parent_solo"] scriptmodelplayanim("wz_infil_mindia8_solo_character_link", "prop");
  var_0.playerpositionents["parent_squad"] scriptmodelplayanim("wz_infil_mindia8_squad_character_link", "prop");

  if(var_0.infil_anim_type == "script_model") {
    if(istrue(var_2)) {
      var_0.ref_1269e show();
      var_0.ref_1269f hide();
      var_0.ref_126a0 hide();
      var_0.ref_126a1 hide();
      var_0.ref_126a2 hide();
    } else {
      var_0.ref_1269e hide();
      var_0.ref_1269f show();
      var_0.ref_126a0 show();
      var_0.ref_126a1 show();
      var_0.ref_126a2 show();
    }

    var_15 = "";

    if(istrue(var_3)) {
      var_15 = "_fem";
    }

    var_0.ref_1269e scriptmodelplayanim("wz_infil_mindia8_solo_player" + var_15, "p1");
    var_0.ref_1269f scriptmodelplayanim("wz_infil_mindia8_squad_player1" + var_15, "p1");
    var_0.ref_126a0 scriptmodelplayanim("wz_infil_mindia8_squad_player2" + var_15, "p2");
    var_0.ref_126a1 scriptmodelplayanim("wz_infil_mindia8_squad_player3" + var_15, "p3");
    var_0.ref_126a2 scriptmodelplayanim("wz_infil_mindia8_squad_player4" + var_15, "p4");
  } else if(var_0.infil_anim_type == "player") {
    thread playinfilplayeranims(var_0, var_1);
  }

  var_0.bot_gametype_attacker_defender_ai_director_update scriptmodelplayanim("wz_infil_mindia8_solo_pilot", "aiPilot");
  var_0.bot_clear_hq_zone scriptmodelplayanim("wz_infil_mindia8_solo_copilot", "aiCopilot");
  var_0.calloutmarkerpingvo_handleraddnewelement scriptmodelplayanim("wz_infil_mindia8_armada", "armadaRig");

  foreach(var_17 in var_0.calloutmarkerpingvo_getmaxsoundaliaslength) {
    var_18 = getanimlength(%wz_infil_mindia8_loop_veh);
    var_19 = randomfloatrange(0.5, var_18 - 0.5);
    var_17 scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopper", var_19);
    var_17 setscriptablepartstate("infil_fx_armada", "on");

    if(isDefined(var_17.innards)) {
      var_17.innards scriptmodelplayanim("wz_infil_mindia8_loop_veh", "armadaChopperInnards", var_19);
    }
  }

  thread ref_126f5(level, var_0);
  thread givecustomloadout(level);
  thread patch_ent_fixes(level, var_0);
  thread stompeenemyprogressupdate(level);
  thread ks_circleminimapradius(level, var_0);
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("camera", "transition", 30);
  var_0 notify("infil_reset_light_dvars");
  headshot_distance(level, var_0, var_1);
}

function ref_12764(var_0, var_1, var_2, var_3) {
  var_0 endon("stopScene");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_4 = 42;
  var_5 = 5.6;
  var_6 = 50.7;
  var_7 = 2;
  var_8 = 4;
  var_0.gas_trigger_think scriptmodelplayanim("wz_infil_skilo_single_cam", "camera");

  if(isDefined(var_0.gas_triggers_init)) {
    var_0.gas_triggers_init scriptmodelplayanim("wz_infil_skilo_single_cam", "camera");
  }

  var_0.gas_tryplaycoughaudio scriptmodelplayanim("wz_infil_skilo_squad_cam", "camera");

  if(isDefined(var_0.gas_vfx_and_triggers)) {
    var_0.gas_vfx_and_triggers scriptmodelplayanim("wz_infil_skilo_squad_cam", "camera");
  }

  if(isDefined(var_0.ref_11dc3)) {
    var_0.ref_11dc3 stoploopsound();
  }

  var_0.ref_13886 setscriptablepartstate("infil_fx_skilo", "static");
  var_9 = scripts\mp\gametypes\br_public::isusinginfilselection();
  var_10 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12)) {
      continue;
    }

    if(!var_9) {
      if(var_12.stop_counter_beep_sfx_on_bomb_vests) {
        thread stop_strafe_minigun_manager("br_skilo_solo_infil_part1_lr", 0.8, var_12);
        thread stop_strafe_minigun_manager("br_skilo_solo_infil_part2_lr", 6.4, var_12);
      } else {
        thread stop_strafe_minigun_manager("br_skilo_quad_infil_part1_lr", 0.8, var_12);
        thread stop_strafe_minigun_manager("br_skilo_quad_infil_part2_lr", 6.4, var_12);
      }

      var_12 setsoundsubmix("mp_br_infil_anim", 0);
      var_12 setsoundsubmix("mp_br_infil_music", 0);

      if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level.ref_12d05)) {
        var_12 setsoundsubmix("mp_br_infil_ac130", 0);
      }

      var_12 setclienttriggeraudiozone("mp_island_infil_int", 1);
    }

    var_13 = scripts\engine\utility::ter_op(var_12.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_trigger_think, var_0.gas_tryplaycoughaudio);
    var_14 = "j_prop_1";
    var_12 cameraunlink();
    var_12 cameralinkTo(var_13, var_14, 1, 1);
    var_12 setclientdvar("QTSPTNLOL", var_4);
    var_12 setclientdvar("LTMOQONPQ", 1);
    var_12 enablephysicaldepthoffieldscripting();
    var_12 setphysicaldepthoffield(var_5, var_6, var_7, var_8);
    var_12 scripts\mp\utility\player::_freezelookcontrols(1);
    var_12 calloutmarkerping_getinventoryslot(5000);
    var_12 scripts\mp\gametypes\br_public::ref_126b9(var_0.ref_13886.origin);
  }

  thread healthpool(var_1);

  if(isDefined(var_0.ref_11dc3.bunker_numberstation)) {
    var_0.ref_11dc3.bunker_numberstation setscriptablepartstate("infil_fx_clouds", "on");
    var_0.ref_11dc3.bunker_numberstation setscriptablepartstate("infil_fx_skilo", "moving");
  }

  thread getlightingvalues();
  var_0.playerpositionents["parent_solo"] scriptmodelplayanim("wz_infil_skilo_single_sdr_link", "prop");
  var_0.playerpositionents["parent_squad"] scriptmodelplayanim("wz_infil_skilo_squad_sdr_link", "prop");

  if(var_0.infil_anim_type == "script_model") {
    if(istrue(var_2)) {
      var_0.ref_1269e show();
      var_0.ref_1269f hide();
      var_0.ref_126a0 hide();
      var_0.ref_126a1 hide();
      var_0.ref_126a2 hide();
    } else {
      var_0.ref_1269e hide();
      var_0.ref_1269f show();
      var_0.ref_126a0 show();
      var_0.ref_126a1 show();
      var_0.ref_126a2 show();
    }

    var_16 = "";

    if(istrue(var_3)) {
      var_16 = "_fem";
    }

    var_0.ref_1269e scriptmodelplayanim("wz_infil_skilo_single_sdr01" + var_16, "p1");
    var_0.ref_1269f scriptmodelplayanim("wz_infil_skilo_squad_sdr01" + var_16, "p1");
    var_0.ref_126a0 scriptmodelplayanim("wz_infil_skilo_squad_sdr02" + var_16, "p2");
    var_0.ref_126a1 scriptmodelplayanim("wz_infil_skilo_squad_sdr03" + var_16, "p3");
    var_0.ref_126a2 scriptmodelplayanim("wz_infil_skilo_squad_sdr04" + var_16, "p4");
  } else if(var_0.infil_anim_type == "player") {
    thread playinfilplayeranims(var_0, var_1);
  }

  if(isDefined(var_0.ref_13886)) {
    var_0.ref_13886 scriptmodelplayanim("wz_infil_skilo_single_veh", "plane", 0, 1);
  }

  if(isDefined(var_0.ref_12d98)) {
    var_0.ref_12d98 scriptmodelplayanim("wz_infil_skilo_single_veh_ropes", "plane", 0, 1);
  }

  foreach(var_18 in var_0.ref_12915) {
    if(isDefined(var_18)) {
      var_18 scriptmodelplayanim("wz_infil_skilo_single_veh", "plane", 0, 1);
    }
  }

  if(isDefined(var_0.ref_13887)) {
    var_0.ref_13887 scriptmodelplayanim("wz_infil_skilo_single_door", "plane", 0, 1);
  }

  thread ref_126f6(level, var_0);
  thread ref_133b1(level);
  thread patch_ent_fixes(level, var_0);
  thread helicopter_firendly_dmg_text_display(level, var_0);
  thread spawn_apache_chopper(level, var_0);
  thread laser_vfx_think(level, var_0);
  thread stimmodelattached(level);
  thread ks_circleminimapradius(level, var_0);
  thread ref_12e63(level, var_0);
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("camera", "transition", 30);
  var_0 notify("infil_reset_light_dvars");
  thread healdamage(level, var_0);
}

function ref_12e63(var_0, var_1) {
  if(getdvarint("scr_br_infil_skilo_safe_remove_black_border", 1) == 0) {
    return;
  }

  var_2 = remove_munitions_in_radius(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_2 scripts\engine\utility::waittill_match_or_timeout("camera", "end", 30);
  wait 0.25;

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 setclientomnvar("ui_br_bink_overlay_state", 0);
    var_5 skydive_cutparachuteoff();
  }
}

function spawn_apache_chopper(var_0, var_1) {
  level endon("game_ended");

  if(getdvarint("scr_br_alt_mode_rebirth_skip_initial_circle", 0) == 0 || !isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.br_infils_disabled)) {
    return;
  }

  var_2 = remove_munitions_in_radius(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    level.br_circle.dangercircleent hidefromplayer(var_5);
  }

  var_2 scripts\engine\utility::waittill_match_or_timeout("camera", "end", 30);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    level.br_circle.dangercircleent showtoplayer(var_5);
  }
}

function stop_strafe_minigun_manager(var_0, var_1, var_2) {
  var_2 endon("death_or_disconnect");
  wait var_1;
  var_2 playlocalsound(var_0);
}

function ks_circleminimapradius(var_0, var_1) {
  var_2 = remove_objective_on_flag(var_0);

  if(isDefined(var_2) && getdvarint("scr_br_streamToMovingPlane", 1) == 1) {
    var_3 = getdvarint("scr_br_streamToMovingPlaneDelay", 8);
    wait var_3;
    var_4 = var_2.origin;
    var_5 = getdvarint("scr_br_streamToMovingPlaneForward", 0);

    if(var_5 > 0) {
      var_6 = anglesToForward(var_2.angles);
      var_4 = var_2.origin + var_6 * var_5;
    }

    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getinventoryslot(0);
      var_9 scripts\mp\gametypes\br_public::ref_126b9(var_4);
    }

    return;
  }
}

function ref_138f3(var_0, var_1) {
  var_2 = remove_objective_on_flag(var_0);

  if(isDefined(var_2) && getdvarint("scr_br_streamToMovingPlane", 1) == 1) {
    var_3 = getdvarint("scr_br_streamToMovingPlaneEndDelay", 5);
    wait var_3;
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_6 thread scripts\mp\gametypes\br_public::ref_1252b();
    }

    return;
  }
}

function ref_13f06(var_0, var_1) {
  wait var_0;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 scripts\mp\utility\player::_freezelookcontrols(0);
  }
}

function ref_13ce8(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2;
  var_6 = 4;

  if(isDefined(var_0.gas_trigger)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);

      if(!isDefined(var_9.infilanimindex)) {
        var_9.infilanimindex = 1;
      }

      var_0.gas_trap_weapon = "j_prop_" + var_9.infilanimindex;
      var_9 cameraunlink();
      var_9 cameralinkTo(var_0.gas_trigger, var_0.gas_trap_weapon, 1, 1);
      var_9 setclientdvar("QTSPTNLOL", var_2);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);
    }
  }

  if(isDefined(var_2.helicountdownendcallback)) {
    if(isDefined(var_2.movingc130)) {
      var_2.helicountdownendcallback.origin = var_2.movingc130.origin;
    }
  }

  var_2.staticc130 hide();
  var_2.cameraent unlink();
  var_2.playerpositionents["parent"] unlink();

  if(isDefined(var_2.movingc130)) {
    var_2.playerpositionents["parent"] linkTo(var_2.movingc130, "", (0, 0, 0), (0, 0, 0));
    var_2.cameraent linkTo(var_2.movingc130, "", (0, 0, 0), (0, 0, 0));
    var_2.movingc130 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }

    var_9 setclienttriggeraudiozone("mp_donetsk_infil_ext", 2);
  }

  thread healthpack_health(var_3);

  if(var_2.infil_anim_type == "script_model") {
    var_2.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl01", "p1");
    var_2.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl02", "p2");
    var_2.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl03", "p3");
    var_2.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl04", "p4");
  }

  var_2.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_loop_doorchief", "doorchief");
  thread playac130infilloopanims(level);

  if(isDefined(var_2.gas_trigger)) {
    var_2.gas_trigger waittillmatch("camera", "end");
  }

  thread ref_13f06(1.2, var_3);
}

function ref_13ce9(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2;
  var_6 = 4;

  if(isDefined(var_0.gas_triggers_init) && isDefined(var_0.gas_vfx_and_triggers)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);

      if(!isDefined(var_9.infilanimindex)) {
        var_9.infilanimindex = 1;
      }

      if(!isDefined(var_9.stop_counter_beep_sfx_on_bomb_vests)) {
        var_9.stop_counter_beep_sfx_on_bomb_vests = 1;
      }

      var_10 = scripts\engine\utility::ter_op(var_9.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_triggers_init, var_0.gas_vfx_and_triggers);
      var_11 = "j_prop_1";
      var_9 cameraunlink();
      var_9 cameralinkTo(var_10, var_11, 1, 1);
      var_9 setclientdvar("QTSPTNLOL", var_2);
      var_9 setclientdvar("LTMOQONPQ", 0);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);
    }
  }

  var_2.playerpositionents["parent_solo"] unlink();
  var_2.playerpositionents["parent_squad"] unlink();

  if(isDefined(var_2.ref_11dbf)) {
    var_2.playerpositionents["parent_solo"] linkTo(var_2.ref_11dbf, "", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["parent_squad"] linkTo(var_2.ref_11dbf, "", (0, 0, 0), (0, 0, 0));
    var_2.ref_11dbf notify("start_moving");
  }

  var_2.calloutmarkerpingvo_handleraddnewelement unlink();

  if(isDefined(var_2.ref_11dbf)) {
    var_2.calloutmarkerpingvo_handleraddnewelement linkTo(var_2.ref_11dbf, "", (0, 0, 0), (0, 0, 0));
  }

  setomnvar("ui_hide_player_icons", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }

    var_9 setclienttriggeraudiozone("mp_donetsk_infil_ext", 2);
  }

  thread healthpack_health(var_3);

  if(var_2.infil_anim_type == "script_model") {
    var_2.ref_1269e scriptmodelplayanim("wz_infil_mindia8_loop_pl01", "p1");
    var_2.ref_1269f scriptmodelplayanim("wz_infil_mindia8_loop_pl01", "p1");
    var_2.ref_126a0 scriptmodelplayanim("wz_infil_mindia8_loop_pl02", "p2");
    var_2.ref_126a1 scriptmodelplayanim("wz_infil_mindia8_loop_pl03", "p3");
    var_2.ref_126a2 scriptmodelplayanim("wz_infil_mindia8_loop_pl04", "p4");
  }

  var_2.bot_gametype_attacker_defender_ai_director_update hide();
  var_2.bot_clear_hq_zone hide();
  thread ref_12520(level);

  if(isDefined(var_2.gas_triggers_init)) {
    var_2.gas_triggers_init waittillmatch("camera", "end");
  }

  thread ref_13f06(1.2, var_3);
}

function ref_13cf1(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2;
  var_6 = 4;

  if(isDefined(var_0.gas_triggers_init) && isDefined(var_0.gas_vfx_and_triggers)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);

      if(!isDefined(var_9.infilanimindex)) {
        var_9.infilanimindex = 1;
      }

      if(!isDefined(var_9.stop_counter_beep_sfx_on_bomb_vests)) {
        var_9.stop_counter_beep_sfx_on_bomb_vests = 1;
      }

      var_10 = scripts\engine\utility::ter_op(var_9.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_triggers_init, var_0.gas_vfx_and_triggers);
      var_11 = "j_prop_1";
      var_9 cameraunlink();
      var_9 cameralinkTo(var_10, var_11, 1, 1);
      var_9 setclientdvar("QTSPTNLOL", var_2);
      var_9 setclientdvar("LTMOQONPQ", 0);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9 calloutmarkerping_getcreatedtime(0);
    }
  }

  var_2.playerpositionents["parent_solo"] unlink();
  var_2.playerpositionents["parent_squad"] unlink();

  if(isDefined(var_2.ref_11dc3)) {
    var_2.playerpositionents["parent_solo"] linkTo(var_2.ref_11dc3, "", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["parent_squad"] linkTo(var_2.ref_11dc3, "", (0, 0, 0), (0, 0, 0));
    var_2.ref_11dc3 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }

    var_9 setclienttriggeraudiozone("mp_island_infil_ext", 2);
  }

  thread healthpack_health(var_3);

  if(var_2.infil_anim_type == "script_model") {
    var_2.playerslot1 scriptmodelplayanim("wz_infil_skilo_squad_sdr01_loop", "p1");
    var_2.playerslot2 scriptmodelplayanim("wz_infil_skilo_squad_sdr02_loop", "p2");
    var_2.playerslot3 scriptmodelplayanim("wz_infil_skilo_squad_sdr03_loop", "p3");
    var_2.playerslot4 scriptmodelplayanim("wz_infil_skilo_squad_sdr04_loop", "p4");
  }

  thread ref_12766(level);

  if(isDefined(var_2.ref_11dc3.door)) {
    var_2.ref_11dc3.door scriptmodelplayanim("wz_infil_skilo_single_door_loop", "plane", 0, 1);
  }

  if(isDefined(var_2.gas_triggers_init)) {
    var_2.gas_triggers_init waittillmatch("camera", "end");
  }

  thread ref_13f06(1.2, var_3);
}

function mp_m_speed_patch(var_0, var_1) {
  thread wires_on_bombs();
  stopFXOnTag(level._effect["vfx_br_ac130_clouds"], var_0.staticc130, "tag_body");
  var_0.staticc130 stoploopsound();

  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 playLoopSound("br_ac130_lp");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 calloutmarkerping_getcreatedtime(0);
    var_4 cameraunlink();
    var_4 setclientdvar("QTSPTNLOL", 65);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  thread ref_138f3(level, var_0);
}

function mp_m_trench_patch_giveplayer_c4(var_0, var_1) {
  var_0.chopper stoploopsound();

  if(isDefined(var_0.ref_11dbf)) {
    var_0.ref_11dbf playLoopSound("br_heli_infil_hero_lp");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 calloutmarkerping_getcreatedtime(0);
    var_4 cameraunlink();
    var_4 setclientdvar("QTSPTNLOL", 65);
    var_4 setclientdvar("LTMOQONPQ", 0);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  thread ref_138f3(level, var_0);
}

function neverspectate(var_0, var_1) {
  thread wires_on_bombs();
  var_0.ref_13886 stoploopsound();

  if(isDefined(var_0.ref_11dc3)) {
    var_0.ref_11dc3 playLoopSound("br_infil_skilo_plane_lp");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 calloutmarkerping_getcreatedtime(0);
    var_4 cameraunlink();
    var_4 setclientdvar("QTSPTNLOL", 65);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  thread ref_138f3(level, var_0);
}

function stop_hotjoining(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    stop_firing_minigun(var_0);
    return;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    stop_module_on_delay(var_0);
    return;
  }

  stop_eye_barkov(var_0);
}

function stop_eye_barkov(var_0) {
  var_1 = level._effect["vfx_br_ac130_clouds"];
  var_2 = level._effect["vfx_br_ac130_oneshot"];

  if(scripts\mp\utility\game::getgametype() != "br") {
    var_1 = level._effect["vfx_snatch_ac130_clouds"];
  }

  if(isDefined(var_1)) {
    stopFXOnTag(var_1, var_0, "tag_body");
  }

  if(isDefined(var_2)) {
    stopFXOnTag(var_2, var_0, "tag_body");
    return;
  }
}

function stop_firing_minigun(var_0) {}

function stop_module_on_delay(var_0) {}

function playac130infilloopanims(var_0) {
  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "plane");
    var_0.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "planeInnards");
  }

  var_0.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_loop_genpropx10", "prop");
}

function ref_12766(var_0) {
  if(isDefined(var_0.ref_11dc3)) {
    var_0.ref_11dc3 scriptmodelplayanim("wz_infil_skilo_loop_veh", "plane");
    var_0.ref_11dc3.bunker_numberstation scriptmodelplayanim("wz_infil_skilo_loop_veh", "plane");
    var_0.ref_11dc3.innards scriptmodelplayanim("wz_infil_skilo_loop_veh", "planeInnards");
  }

  var_0.playerpositionents["parent_solo"] scriptmodelplayanim("wz_infil_skilo_loop_genpropx10", "prop");
  var_0.playerpositionents["parent_squad"] scriptmodelplayanim("wz_infil_skilo_loop_genpropx10", "prop");
}

function ref_12520(var_0) {
  if(isDefined(var_0.ref_11dbf)) {
    var_0.ref_11dbf scriptmodelplayanim("wz_infil_mindia8_loop_veh", "plane");
    var_0.ref_11dbf.innards scriptmodelplayanim("wz_infil_mindia8_loop_veh", "planeInnards");
  }

  var_0.playerpositionents["parent_solo"] scriptmodelplayanim("wz_infil_mindia8_loop_genpropx10", "prop");
  var_0.playerpositionents["parent_squad"] scriptmodelplayanim("wz_infil_mindia8_loop_genpropx10", "prop");
}

function infiloverridevisionset(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2.operatorcustomization.operatorref == "s4_palmer" || var_2.operatorcustomization.operatorref == "s4_doggett") {
      var_2 visionsetnakedforplayer("wz_tu345_te");
    }
  }
}

function infilhandleterminusoutlines(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2.operatorcustomization.operatorref == "s4_palmer" || var_2.operatorcustomization.operatorref == "s4_doggett") {
      thread infildoterminusoutlines();
    }
  }
}

function infildoterminusoutlines() {
  self endon("disconnect");
  var_0 = scripts\mp\utility\player::getteamarray(self.team, 1);
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.infilanimindex) && var_3.infilanimindex == 1) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    var_1 hudoutlineenableforclient(self, "outline_terminus");
  }

  wait 0.75;

  if(isDefined(var_1)) {
    var_1 hudoutlinedisableforclient(self);
  }

  wait 8.25;
  var_5 = scripts\engine\utility::random(var_0);

  if(isDefined(var_5)) {
    var_5 hudoutlineenableforclient(self, "outline_terminus");
  }

  wait 0.75;

  if(isDefined(var_5)) {
    var_5 hudoutlinedisableforclient(self);
    return;
  }
}

function infilsetupterminusbink(var_0, var_1) {
  wait var_1;
  infilpreloadterminusbink(var_0);
  infilplayterminusbink(var_0);
  wait 1;
  infilhandleterminusoutlines(var_0);
}

function infilpreloadterminusbink(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2.operatorcustomization.operatorref == "s4_palmer" || var_2.operatorcustomization.operatorref == "s4_doggett") {
      var_2 skydive_cutparachuteon("mp_terminus_vision");
    }
  }
}

function infilplayterminusbink(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2.operatorcustomization.operatorref == "s4_palmer" || var_2.operatorcustomization.operatorref == "s4_doggett") {
      var_2 preloadcinematicforplayer("mp_terminus_vision");
    }
  }
}

function stoparmorinsert(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_0)) {
    preloadcinematicforall(var_1, 0, var_2);
    return;
  }

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_4 skydive_cutparachuteon(var_1, 0, var_2);
    }
  }
}

function stop_with_front_truck(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);
  var_6 = level.players.size == var_5.size;

  if(var_6) {
    setglobalsoundcontext("lobby_fade", "", 2);
  }

  foreach(var_8 in var_5) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(!var_6) {
      var_8 setentitysoundcontext("lobby_fade", "", 2);
    }

    if(!isDefined(var_4)) {
      var_4 = "";
    }

    switch (var_4) {
      case "s2":
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
      case "infil_dov_part1":
        var_8 playlocalsound("br_infil_part1_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("mp_br_event_dovp1_infil", 0.5);
        break;
      case "chopper_infil":
        var_8 playlocalsound("br_heli_infil_part1_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
      case "skilo_infil":
        var_8 playlocalsound("br_infil_ch3_plane_intro_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
      case "skilo_infil_mxp":
        var_8 playlocalsound("br_infil_ch3_mxp_plane_intro_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
      case "terminus_infil":
        var_8 playlocalsound("br_infil_ch3_t2_plane_intro_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
      default:
        var_8 playlocalsound("br_infil_part1_lr");
        var_8 clearsoundsubmix("mp_br_lobby_fade", 1.5);
        var_8 clearsoundsubmix("fade_to_black_all_except_music", 0.5);
        var_8 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
        break;
    }
  }

  var_2 = var_2 || istrue(level.vehicle_collision_getleveldata);

  if(var_6) {
    if(istrue(level.vehicle_collision_getleveldata) || var_2) {
      playcinematicforall(var_1, 1, 1);
    } else {
      playcinematicforall(var_1);
    }
  } else {
    foreach(var_8 in var_5) {
      if(!isDefined(var_8)) {
        continue;
      }

      if(istrue(level.vehicle_collision_getleveldata) || var_2) {
        var_8 preloadcinematicforplayer(var_1, 1, 1);
        continue;
      }

      var_8 preloadcinematicforplayer(var_1);
    }
  }

  var_12 = 3;

  if(getdvarint("scr_br_c130_intro_s2", 0) == 1) {
    var_12 = 9;
  } else if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    var_12 = 11;
  } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    if(getdvarint("scr_br_infil_skilo_use_skilo_infil_overlay", 1) == 0) {
      var_12 = 11;
    } else {
      var_12 = 13;
    }
  } else if(istrue(var_3)) {
    var_12 = 10;
  }

  foreach(var_8 in var_5) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(!istrue(var_8.watch_for_usb_notetrack_switchoff)) {
      var_8 setclientomnvar("ui_br_bink_overlay_state", var_12);
    }
  }
}

function getboltmodel(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 setclientomnvar("ui_br_bink_overlay_state", var_1);
  }
}

function stop_spawn_modules(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self setclientomnvar("ui_br_bink_overlay_state", 5);
    self skydive_cutparachuteoff();
    return;
  }
}

function stop_vehicle_on_pilot_death(var_0, var_1) {
  if(var_0 == "bink_complete") {
    wait 0.6;
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self skydive_cutparachuteoff();
    return;
  }
}

function stop_wave_section(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self skydive_cutparachuteoff();
    return;
  }
}

function stopchallengetimer(var_0) {
  if(getdvarint("scr_br_c130_intro_s2", 0) == 1) {
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&stop_spawn_modules);
  } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&stop_vehicle_on_pilot_death);
  } else {
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&stop_wave_section);
  }

  var_1 = undefined;

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    var_1 = 4.95;
  } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    var_1 = 7.23;
  } else {
    var_1 = 3.2;
  }

  if(istrue(level.vehicle_collision_getleveldata)) {
    var_1 = 4.6;
  } else if(getdvarint("scr_br_c130_intro_s2", 0) == 1) {
    var_1 = 36;
  }

  wait var_1;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  if(isDefined(level.ref_133b4)) {
    level.ref_133b4 = undefined;
  }

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 notify("beginC130");
  }

  if(isDefined(level.throwingknives)) {
    foreach(var_7 in level.throwingknives) {
      if(isDefined(var_7)) {
        var_7 thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
      }
    }

    return;
  }
}

function setup_jugg_maze_kill_trigger() {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    self setModel("veh8_mil_air_mindia8_open_back_infil");
    self notsolid();
    self.innards setModel("veh8_mil_air_mindia8_interior_vm_infil");
    self.innards notsolid();
    self.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
    return;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    self setModel("veh8_mil_air_skilo_infil_flight");
    self notsolid();
    self.innards setModel("veh8_mil_air_skilo_interior_vm_infil");
    self.innards notsolid();
    self.playeroffsets = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
    self.bunker_numberstation = spawn("script_model", self.origin);
    self.bunker_numberstation setModel("veh8_mil_air_skilo_infil_flight_articulated");
    self.bunker_numberstation linkTo(self, "", (0, 0, 0), (0, 0, 0));
    self.bunker_numberstation.cleanme = 1;
    self.door = spawn("script_model", self.origin);
    self.door setModel("veh8_mil_air_skilo_interior_infil_cabin_door");
    self.door linkTo(self.bunker_numberstation, "TAG_DOOR", (0, 0, 0), (0, 0, 0));
    self.door.cleanme = 1;
    return;
  }

  self notsolid();

  if(isDefined(self.innards)) {
    self.innards notsolid();
    return;
  }
}

function setup_last_enemies_standing(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self hide();

  if(isDefined(self.innards)) {
    self.innards hide();
  }

  self waittill("start_moving");
  self show();

  if(isDefined(self.innards)) {
    self.innards show();
  }

  self moveTo(var_0, var_1);
  thread scripts\mp\gametypes\br_c130::killaftertime(var_1, "c130");

  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    self playLoopSound("br_heli_infil_hero_lp");
    return;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    self playLoopSound("br_ac130_lp");
    return;
  }

  thread scripts\mp\gametypes\br_public::gunship_spawnvfx();
  self playLoopSound("br_ac130_lp");
}

function remove_outline(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return var_0.chopper;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return var_0.ref_13886;
  }

  return var_0.staticc130;
}

function remove_objective_on_flag(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return var_0.ref_11dbf;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return var_0.ref_11dc3;
  }

  return var_0.movingc130;
}

function remove_munitions_in_radius(var_0) {
  if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
    return var_0.gas_triggers_init;
  }

  if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    return var_0.gas_triggers_init;
  }

  return var_0.gas_trigger;
}

function clear_tier_lights(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

  if(!scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }

      var_5 calloutmarkerping_getcreatedtime(-1);
    }
  }

  level.infilstruct = spawnStruct();
  level.infilstruct.playersinc130 = 0;

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  level.infilstruct.c130pathstruct = var_0;
  level.infilstruct.transporttime = scripts\mp\gametypes\br_c130::spawnc130(level.infilstruct.c130pathstruct, &setup_last_enemies_standing, &setup_jugg_maze_kill_trigger);
  level.infilstruct.firstc130endtime = level.infilstruct.transporttime + gettime();
  var_7 = firespoutwatch(level.br_ac130, var_1);
  level.watch_for_total_counts_below_num = var_7;

  if(isDefined(level.ref_12852)) {
    [[level.ref_12852]](var_7);
  }

  level.stop_end_breach_fx = 1;
  level.allowprematchdamage = 0;
  thread gunship_updateplayercount();
  var_8 = remove_outline(var_7);
  var_9 = 0;
  var_10 = 0;

  if(getdvarint("scr_br_c130_intro_s2", 0) == 1) {
    var_10 = 1;
    ref_13cf0(var_3, "player", var_8, 1);
    stoparmorinsert(var_3, "mp_donetsk_c130_intro_s2");
    stop_with_front_truck(var_3, "mp_donetsk_c130_intro_s2", var_9, 0, "s2");
    stopchallengetimer(var_3);
    var_11 = game["music"]["br_infil_intro"].size;
    var_12 = randomint(var_11);
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

    foreach(var_5 in var_3) {
      var_5 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
      var_5 setplayermusicstate(game["music"]["br_infil_intro"][var_12]);
    }
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "reveal") {
    ref_13cf0(var_3, var_1, var_8, 0);
    var_15 = undefined;
    var_16 = 0;

    if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
      var_15 = "mp_donetsk_mindia8_intro";
      var_16 = 1;
    } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
      var_15 = "mp_wz_island_plane_intro";
    } else {
      var_15 = "mp_donetsk_c130_intro";
    }

    stoparmorinsert(var_3, var_15);
    stop_with_front_truck(var_3, var_15, var_9, var_16, "infil_dov_part1");
    stopchallengetimer(var_3);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "mendota") {
    ref_13cf0(var_8, var_3, var_10, 0);
    var_15 = "mendota_infil_intro";
    var_16 = 0;
    var_17 = "skilo_infil_mxp";
    var_15 = 1;
    stoparmorinsert(var_8, var_15);
    stop_with_front_truck(var_8, var_15, var_15, var_16, var_17);
    stopchallengetimer(var_8);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "tdbd") {
    ref_13cf0(var_15, var_9, var_15, 0);
    var_15 = "mp_wz_tdbd_plane_intro";
    var_16 = 0;
    var_17 = "skilo_infil";
    var_16 = 0;

    if(getdvarint("scr_terminus_infil_override", 0) == 1) {
      infiloverridevisionset(var_15);
    }

    stoparmorinsert(var_15, var_15);
    stop_with_front_truck(var_15, var_15, var_16, var_16, "terminus_infil");
    stopchallengetimer(var_15);
  } else {
    ref_13cf0(var_16, var_16, var_15, 0);
    var_15 = undefined;
    var_16 = 0;
    var_17 = undefined;

    if(getdvarint("scr_terminus_infil_override", 0) == 1) {
      infiloverridevisionset(var_16);
    }

    if(scripts\mp\gametypes\br_public::tv_station_intro_already_played()) {
      if(scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent()) {
        var_15 = "mp_escape_mindia8_intro";
      } else {
        var_15 = "mp_donetsk_mindia8_intro";
      }

      var_16 = 1;
      var_17 = "chopper_infil";
    } else if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
      var_15 = "mp_wz_island_plane_intro";
      var_17 = "skilo_infil";
    } else {
      var_15 = "mp_donetsk_c130_intro";
    }

    var_15 = getfixedinfilname(var_15);
    stoparmorinsert(var_16, var_15);
    stop_with_front_truck(var_16, var_15, var_16, var_16, var_17);
    stopchallengetimer(var_16);
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound() || scripts\mp\gametypes\br_public::uniquelootcallbacks()) {
    var_16 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, level.players);

    foreach(var_5 in var_16) {
      if(isDefined(var_5) && isPlayer(var_5)) {
        var_5 notify("play_intro");
      }
    }
  }

  if(var_17) {
    getboltmodel(var_16, 0);
  }

  var_20 = remove_munition_on_use();
  var_21 = var_20[0];
  var_22 = var_20[1];
  var_20 = undefined;
  thread infilallfadetoblack(level, 0, var_21, var_22, undefined);

  if(getdvarint("scr_terminus_infil_override", 0) == 1) {
    thread infilsetupterminusbink(level, var_16);
  }

  ref_1273c(var_17, var_15);
  var_16 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, level.players);
  ref_13cee(var_16, var_16);
  level.stop_end_breach_fx = 0;
  level.infilstruct.infil_anim_type = var_16;

  if(isDefined(level.obit_activation)) {
    level thread scripts\mp\gametypes\br_alt_mode_escape::obj_fob2(var_15);
  } else {
    thread scripts\mp\gametypes\br_gametypes::ref_12e05("onInfilSequenceEnd", var_15);

    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("match_start_VO")) {
      scripts\mp\gametypes\br_public::brleaderdialog("match_start", 0, var_15);
    }
  }

  var_23 = scripts\mp\gametypes\br_public::validtousesticker() || scripts\mp\gametypes\br_public::uniquelootitemid();

  if(!var_23) {
    var_24 = getDvar("scr_br_lateSpawnFallback") == "";
    var_16 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, level.players);

    foreach(var_5 in var_16) {
      thread playerjoininfil();

      if(var_5 calloutmarkerping_getEnt()) {
        ref_12b22(var_5);
        LOC_00000537:
      }
      LOC_00000537:
    }

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("addToC130Infil")) {
      level.br_ac130 scripts\mp\gametypes\br_gametypes::ref_12e05("addToC130Infil");
    }
  }

  if(isDefined(level.showexfilstartsplash)) {
    thread showextractionobjectivetoteam();
    return;
  }
}

function getfixedinfilname(var_0) {
  if(istrue(level.vehicle_collision_getleveldata)) {
    var_0 = "mp_donetsk_c130_intro_x1";
  } else if(scripts\cp_mp\utility\game_utility::turretlightsonstate()) {
    var_0 = "ta_gov_inf";
  } else if(level.mapname == "mp_kstenod" || scripts\mp\utility\game::round_vehicle_logic() == "zxp") {
    var_0 = "mp_donetsk_c130_intro_zxp";
  } else if(level.mapname == "mp_don4_pm") {
    var_0 = "ta_gov_inf";
  }

  return var_0;
}

function ref_1324e(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.sort = -1;
  var_0 sendcollectedclientanticheatdata(1);
}

function infilallfadetoblack(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);
  var_7 = level.players.size == var_6.size;

  if(var_7 && !isDefined(level.infilblackoverlay)) {
    level.infilblackoverlay = newhudelem();
    ref_1324e(level.infilblackoverlay);
  } else if(!var_7) {
    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9.infilblackoverlay = newclienthudelem(var_9);
      ref_1324e(var_9.infilblackoverlay);
    }
  }

  if(isDefined(var_0) && var_0 > 0) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(!var_5) {
        var_9 setsoundsubmix("iw8_br_infil_fadeout", 0);

        if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level.ref_12d05)) {
          var_9 setsoundsubmix("mp_br_infil_music", 0);
        }
      }

      if(!var_7) {
        var_9.infilblackoverlay.alpha = 0;
        var_9.infilblackoverlay fadeovertime(var_0);
        var_9.infilblackoverlay.alpha = 1;
      }
    }

    if(var_7) {
      level.infilblackoverlay.alpha = 0;
      level.infilblackoverlay fadeovertime(var_2);
      level.infilblackoverlay.alpha = 1;
    }

    wait var_0;
  }

  if(!scripts\mp\gametypes\br_public::isusinginfilselection()) {
    if(var_7) {
      level.infilblackoverlay.alpha = 1;
    }

    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(!var_5) {
        var_9 setsoundsubmix("mp_br_infil_anim", 0);
        var_9 setsoundsubmix("mp_br_infil_ac130", 0);
      }

      if(!var_7) {
        var_9.infilblackoverlay.alpha = 1;
      }
    }
  }

  if(isDefined(var_3)) {
    level waittill(var_3);
  }

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  if(isDefined(var_2) && var_2 > 0) {
    if(var_7) {
      level.infilblackoverlay.alpha = 1;
      level.infilblackoverlay fadeovertime(var_2);
      level.infilblackoverlay.alpha = 0;
    }

    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(!var_5) {
        if(!scripts\mp\gametypes\br_public::isusinginfilselection()) {
          if(scripts\mp\gametypes\br_public::usefailcapacitymsg()) {
            var_9 setclienttriggeraudiozone("mp_island_infil_int", var_2);
          } else {
            var_9 setclienttriggeraudiozone("mp_donetsk_infil_int", var_2);
          }
        }

        var_9 clearsoundsubmix("iw8_br_infil_fadeout", 2);
        var_9 clearsoundsubmix("deaths_door_mp");
      }

      if(!var_7) {
        var_9.infilblackoverlay.alpha = 1;
        var_9.infilblackoverlay fadeovertime(var_2);
        var_9.infilblackoverlay.alpha = 0;
      }
    }

    wait var_2;
  } else if(!var_5) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(!scripts\mp\gametypes\br_public::isusinginfilselection()) {
        var_9 setclienttriggeraudiozone("mp_donetsk_infil_int");
      }

      var_9 clearsoundsubmix("iw8_br_infil_fadeout", 2);
      var_9 clearsoundsubmix("deaths_door_mp");
    }
  }

  if(var_7) {
    level.infilblackoverlay.alpha = 0;
    return;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

  foreach(var_9 in var_6) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(isDefined(var_9.infilblackoverlay)) {
      var_9.infilblackoverlay destroy();
    }

    var_9.infilblackoverlay = undefined;
  }
}

function ref_12acc(var_0) {
  var_1 = 0;
  var_2 = isDefined(var_0) && var_0.size != level.players.size;

  foreach(var_4 in level.teamnamelist) {
    var_5 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_4);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_5[var_6];
      var_8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_4, var_7);

      foreach(var_10 in var_8) {
        if(var_2 && !scripts\engine\utility::array_contains(var_0, var_10)) {
          continue;
        }

        var_10 playerhide();

        if(!var_1) {
          foreach(var_12 in var_8) {
            var_10 showtoplayer(var_12);
          }
        }
      }
    }
  }
}

function ref_13cf0(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    scripts\mp\utility\game::ref_131a3(var_5, 1);
    var_5 scripts\mp\utility\player::hidehudenable();
    var_5 scripts\mp\class::computerrebootsequence_init();
  }

  scripts\mp\deathicons::ref_12bfd();
  setomnvar("ui_hide_player_icons", 1);
  thread infilallfadetoblack(1, 3.5, 1, "prematch_respawn_finished", var_0, var_3);

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 predictstreampos(var_2.origin, 1);
  }

  level.stop_visited_once = 1;
  ref_14361(1);
  waitframe();
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  setomnvar("ui_in_infil", 1);
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 playerhide();
  }

  ref_1435f(var_0, var_2.origin, var_2);
  level notify("prematch_respawn_finished");
  ref_14361(3.5);

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 clearpredictedstreampos();
    neurotoxin_damage_loop(var_5);
    var_5.delay_explosion_fx = 1;
  }

  if(var_1 == "script_model") {
    foreach(var_5 in var_0) {
      if(!isDefined(var_5)) {
        continue;
      }

      var_5 playerhide();
    }

    return;
  }

  ref_12acc(var_0);
}

function ref_13cee(var_0, var_1) {
  var_2 = var_1 == "script_model";

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 scripts\mp\class::ref_13f02();
    var_4.instantclassswapallowed = 1;

    if(scripts\mp\gametypes\br::get_int_or_0(var_4.hidehudenabled) > 0) {
      var_4 scripts\mp\utility\player::hidehuddisable();
    }

    var_4 visionsetfadetoblackforplayer("", 1);

    if(var_2) {
      var_4 playershow();
    }
  }

  setomnvar("ui_in_infil", -1);
  level.stop_visited_once = undefined;
}

function gunship_updateplayercount() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");

  for(;;) {
    setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

function playerjoininfil() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("joining_Infil");
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0.health = var_0.maxhealth;
  var_0 scripts\mp\gametypes\br_c130::spawnplayertoc130();
  playersetupcontrolsforinfil(var_0);
  var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("isInInfilPlane", 1);
  level.infilstruct.playersinc130++;
  var_0 scripts\mp\gametypes\br_public::ref_1264d();
  thread ref_12525();
}

function ref_12525() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0) {
    level.infilstruct.playersinc130--;
    return;
  }
}

function playersetupcontrolsforinfil(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!var_0) {
    self notifyonplayercommand("halo_jump_c130", "+gostand");
  } else {
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");
  }

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

function getlightingvalues() {}

function within_points() {}

function wires_on_bombs() {}

function initinfillocationselectionhandlers() {
  registerinfillocationselectionhandler("exclusion", &handleexclusionils, &spawnselectionbegin, &spawnselectionend);
}

function handleinfillocationselection(var_0) {
  var_1 = self;
  var_2 = level.infilselectionmethod;
  var_3 = getinfillocationselectionfunc(var_2);

  if(!isDefined(var_3)) {
    return;
  }

  return var_1[[var_3]](var_0.location, var_0.angles);
}

function registerinfillocationselectionhandler(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.br_infillocationselectionhandlers)) {
    level.br_infillocationselectionhandlers = [];
  }

  var_4 = spawnStruct();
  var_4.locationselectionfunc = var_1;
  var_4.spawnselectstartfunc = var_2;
  var_4.spawnselectendfunc = var_3;
  level.br_infillocationselectionhandlers[var_0] = var_4;
}

function getinfillocationselectionfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers)) {
    return undefined;
  }

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1.locationselectionfunc;
}

function handleexclusionils(var_0, var_1) {
  var_2 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) && !istrue(var_2.issquadleader)) {
    return 0;
  }

  var_3 = getspawnselectionpoi(var_0);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_3 = undefined;
  var_6 = getspawnselectionexclusionsize(var_0, var_4, var_5);

  if(isDefined(var_2.team)) {
    var_7 = scripts\mp\utility\player::getteamarray(var_2.team);
    var_6 *= var_7.size;
  }

  if(istrue(level.get_bomb_interaction_ent_cut_hint) && !istrue(var_2.issquadleader)) {
    return setuplocalelocation(var_2, var_0, var_1, var_6);
  }

  foreach(var_9 in level.br_spawns) {
    var_10 = round_logic(var_2);

    if(isDefined(var_10) && var_9 == var_10) {
      if(level.get_bomb_interaction_ent_cut_hint) {
        if(getquickdropplundercount(var_2, var_9, var_6, var_0, 1)) {
          return 1;
        }
      }

      continue;
    } else if(level.get_bomb_interaction_ent_cut_hint) {
      if(!getquickdropplundercount(var_2, var_9, var_6, var_0, 0)) {
        return 0;
      }
    }

    if(pow(var_6 + var_9.spawnexclusion2ddist, 2) > distance2dsquared(var_9.locationorigin, var_0)) {
      thread sendplayerstatusmessage(var_2, 50);
      var_2 playlocalsound("br_map_selection_error");
      return 0;
    }
  }

  return registerspawnlocation(var_2, var_0, var_1, var_6);
}

function setuplocalelocation(var_0, var_1, var_2) {
  var_3 = self;

  foreach(var_5 in level.br_spawns) {
    var_6 = round_logic();
    var_7 = 0;

    if(isDefined(var_6) && var_5 == var_6) {
      var_7 = 1;
    }

    if(pow(var_2 + var_5.spawnexclusion2ddist, 2) > distance2dsquared(var_5.locationorigin, var_0)) {
      if(var_7) {
        var_8 = roof_spawners(var_3);
        lastlocationcallouttime(var_8);
        thread sendplayerstatusmessage(var_3, 56);
        var_3 playlocalsound("br_map_selection_placed");
        return 1;
      }

      thread sendplayerstatusmessage(var_4, 50);
      var_4 playlocalsound("br_map_selection_error");
      return 0;
    }

    if(var_9 && getquickdropplundercount(var_4, var_6, var_3, var_1, var_9)) {
      return 1;
    }
  }

  var_5 = undefined;
  var_8 = undefined;
  return registerspawnlocation(var_4, var_1, var_2, var_3);
}

function getquickdropplundercount(var_0, var_1, var_2, var_3) {
  var_4 = self;

  foreach(var_6 in var_0.ref_134cc) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = roof_spawners(var_4);

    if(isDefined(var_7) && var_6 == var_7) {
      continue;
    }

    if(pow(var_1 + var_6.spawnexclusion2ddist, 2) > distance2dsquared(var_6.locationorigin, var_2)) {
      if(!var_3) {
        thread sendplayerstatusmessage(var_4, 50);
        var_4 playlocalsound("br_map_selection_error");
        return 0;
      }

      var_2 = var_6.locationorigin;
      var_8 = var_6.locationangles;
      var_1 = var_6.spawnexclusion2ddist;

      if(isDefined(var_7) && isDefined(var_7.circleent)) {
        var_7.circleent delete();
      }

      var_9 = registerspawnlocation(var_4, var_2, var_8, var_1);

      if(!var_9) {
        return var_9;
      }

      if(!istrue(var_4.issquadleader)) {
        thread sendplayerstatusmessage(var_4, 55);
      } else {
        thread sendplayerstatusmessage(var_4, 54);
      }

      return var_9;
    }
  }

  var_7 = undefined;
  var_9 = undefined;

  if(!var_5) {
    return 1;
  }

  return 0;
}

function sendplayerstatusmessage(var_0, var_1) {
  var_2 = self;
  var_2 notify("sendPlayerStatusMessage");
  var_2 endon("sendPlayerStatusMessage");
  var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(var_0);

  if(isDefined(var_1)) {
    wait var_1;
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    return;
  }
}

function registerspawnlocation(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\engine\trace::create_default_contents(1);

  if(istrue(var_3.issquadleader)) {
    var_5 = round_logic(var_3);

    if(!isDefined(var_5)) {
      var_5 = totalhealth(var_3);
    }
  } else if(istrue(level.get_bomb_interaction_ent_cut_hint)) {
    var_5 = roof_spawners(var_4);

    if(!isDefined(var_5)) {
      var_5 = total_spawns(var_4);
    }
  } else {
    return false;
  }

  var_6 = getdvarfloat("scr_infil_plus_spawn_height", 5500);
  var_7 = (0, 0, var_6);
  var_8 = (0, 0, 10000);
  var_9 = var_1 + var_8;
  var_10 = var_1 - var_8;
  var_11 = scripts\engine\trace::ray_trace(var_9, var_10, undefined, var_5);
  var_12 = var_1;

  if(var_11["hittype"] != "hittype_none") {
    var_12 = var_11["position"];
  }

  var_5.locationorigin = var_12 + var_7;

  if(istrue(var_4.issquadleader)) {
    var_5.groundorigin = var_12;
  }

  var_5.locationangles = var_2;
  var_5.spawnexclusion2ddist = var_3;
  var_13 = var_5.locationorigin;
  var_14 = var_13[0];
  var_15 = var_13[1];
  var_16 = var_13[2];
  var_13 = undefined;

  if(isDefined(var_5.circleent)) {
    var_5.circleent.origin = (var_14, var_15, var_3);
  } else {
    var_5.circleent = getmaxobjectivecount(var_14, var_15, var_3, var_4);

    if(istrue(var_4.issquadleader)) {
      var_5.circleent setmapcircleiconindex(1);
    }
  }

  var_17 = scripts\mp\utility\teams::getfriendlyplayers(var_4.team, 0);

  foreach(var_19 in var_17) {
    if(!istrue(var_4.issquadleader)) {
      thread sendplayerstatusmessage(var_19, 64);
      var_19 playlocalsound("br_map_selection_placed");
      continue;
    }

    thread sendplayerstatusmessage(var_19, 57);
    var_19 playlocalsound("br_map_selection_placed");
  }

  return true;
}

function assignrandomspawnselection() {
  var_0 = self;

  if(!isDefined(var_0.issquadleader)) {
    var_0.issquadleader = 1;
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      if(var_3 != var_0) {
        var_3.issquadleader = 0;
      }
    }
  }

  var_5 = (0, 0, 0);

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_7 = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
    var_8 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
    var_5 = (var_7, var_8, 0);
    var_9 = handleexclusionils(var_0, var_5);

    if(var_9) {
      return true;
    }
  }

  registerspawnlocation(var_0, var_5, undefined, getdvarint("scr_map_selection_dense_min", 2000));
  return false;
}

function notifyafkofselection(var_0) {
  var_1 = self;
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team, 0);
  var_3 = "";

  if(var_0) {
    var_3 = "Safe Spawn Selection Assigned";
  } else {
    var_3 = "Unsafe Spawn Selection Assigned";
  }

  foreach(var_5 in var_2) {
    var_5 iprintlnbold(var_3);
  }
}

function ref_13aec() {
  var_0 = self;
  var_0 playershow(1);
  var_0 unlink(1);
  var_1 = round_logic(var_0);

  if(isDefined(var_1.locationorigin)) {
    var_2 = var_1.locationorigin;
    var_3 = roof_spawners(var_0);

    if(isDefined(var_3)) {
      var_2 = var_3.locationorigin;
    }

    var_4 = 512;
    var_5 = (0, 60 * var_0.pers["squadMemberIndex"] % 360, 0);
    var_6 = anglesToForward(var_5) * var_4;
    var_2 = var_2 + var_6 + (0, 0, randomfloatrange(0, 512));

    if(getdvarint("scr_br_fallbackinfilspawn", 0)) {
      var_0.forcespawnorigin = var_2;
      var_0.forcespawnangles = undefined;
      var_0.alreadyaddedtoalivecount = 1;
      var_0 scripts\mp\playerlogic::spawnplayer(0, 0);
    } else {
      var_0 setOrigin(var_2, 1);
      var_0 setplayerangles(var_5);
    }
  }

  var_0 stopanimscriptsceneevent();
  var_0 clearpredictedstreampos();
  var_0 playershow(1);
  var_0.br_infilstarted = 1;
  var_0 setclientomnvar("ui_br_infil_started", 1);
  var_0 setclientomnvar("ui_br_infiled", 1);
  var_0 scripts\cp_mp\parachute::startfreefall(0, 0);
  var_0 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(var_0);
}

function postspawnselectionstream() {
  var_0 = self;
  var_1 = roof_spawners(var_0);
  var_2 = round_logic(var_0);

  if(isDefined(var_1)) {
    var_0 predictstreampos(var_1.locationorigin, 1);
    return;
  }

  if(isDefined(var_2)) {
    var_0 predictstreampos(var_2.locationorigin, 1);
    return;
  }
}

function spawnselectionbegin() {
  setomnvar("ui_match_start_text", "prepare_for_infil");
  scripts\mp\gamelogic::matchstarttimerperplayer_internal(10);
  scripts\mp\flags::gameflaginit("end_spawn_selection", 0);
  level notify("begin_infil_map_selection");

  if(!isDefined(level.br_spawns)) {
    level.br_spawns = [];
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\gametypes\br::playerselectspawnsequence();
    var_1.isselectingspawn = 1;
  }

  wait 2;
}

function spawnselectionend() {
  scripts\mp\flags::gameflagset("end_spawn_selection");
  var_0 = getdvarint("scr_sendAfkToGulag", 0);

  foreach(var_2 in level.players) {
    var_2 notify("cancel_location");
    thread sendplayerstatusmessage(var_2, 51);
    var_3 = round_logic(var_2);

    if(!isDefined(var_3)) {
      if(var_0) {
        var_2.brmapselectionafk = 1;
        continue;
      } else {
        var_4 = assignrandomspawnselection(var_2);
        notifyafkofselection(var_2, var_4);
      }
    }

    var_2.brmapselectionafk = 0;
    var_2.isselectingspawn = 0;
    postspawnselectionstream(var_2);
  }

  thread ref_12c24();
  wait 4;

  foreach(var_2 in level.players) {
    thread sendplayerstatusmessage(var_2);
    var_2 scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 0);
  }

  thread ref_14392();
}

function ref_14392() {
  level endon("game_ended");
  level waittill("infils_ready");
}

function roof_spawners() {
  var_0 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) || istrue(var_0.issquadleader)) {
    return undefined;
  }

  var_1 = round_logic(var_0);

  if(isDefined(var_0.pers["squadMemberIndex"]) && isDefined(var_1)) {
    if(isDefined(var_1.ref_134cc[var_0.pers["squadMemberIndex"]]) && isDefined(var_1.ref_134cc[var_0.pers["squadMemberIndex"]].locationorigin)) {
      return var_1.ref_134cc[var_0.pers["squadMemberIndex"]];
    }
  }

  return undefined;
}

function round_logic() {
  var_0 = self;

  if(isDefined(level.br_spawns) && isDefined(var_0.team) && isDefined(level.br_spawns[var_0.team]) && isDefined(level.br_spawns[var_0.team].locationorigin)) {
    return level.br_spawns[var_0.team];
  }

  return undefined;
}

function total_spawns() {
  var_0 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) || istrue(var_0.issquadleader)) {
    return undefined;
  }

  var_1 = round_logic(var_0);

  if(isDefined(var_1) && isDefined(var_0.pers["squadMemberIndex"])) {
    var_1.ref_134cc[var_0.pers["squadMemberIndex"]] = spawnStruct();
    var_1.ref_134cc[var_0.pers["squadMemberIndex"]].circleent = undefined;
    return var_1.ref_134cc[var_0.pers["squadMemberIndex"]];
  }

  return undefined;
}

function totalhealth() {
  var_0 = self;

  if(!istrue(var_0.issquadleader)) {
    return undefined;
  }

  if(isDefined(level.br_spawns) && isDefined(var_0.team)) {
    level.br_spawns[var_0.team] = spawnStruct();
    level.br_spawns[var_0.team].circleent = undefined;
    level.br_spawns[var_0.team].ref_134cc = [];
    return level.br_spawns[var_0.team];
  }

  return undefined;
}

function lastlocationcallouttime(var_0) {
  if(isDefined(var_0.circleent)) {
    var_0.circleent delete();
  }

  var_1 = undefined;
}

function lastmovingplatform(var_0) {
  if(isDefined(var_0.circleent)) {
    var_0.circleent delete();
  }

  var_0 = undefined;
}

function classselectionbeginnonexclusion() {
  scripts\mp\flags::gameflaginit("end_spawn_selection", 0);

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\gametypes\br::playerstartselectspawnclassnonexclusion();
  }
}

function classselectionendnonexclusion() {
  scripts\mp\flags::gameflagset("end_spawn_selection");
}

function ref_12c24() {
  wait 25;

  if(isDefined(level.br_spawns)) {
    foreach(var_1 in level.br_spawns) {
      if(isDefined(var_1.ref_134cc)) {
        foreach(var_3 in var_1.ref_134cc) {
          lastlocationcallouttime(var_3);
        }
      }

      lastmovingplatform(var_1);
    }

    return;
  }
}

function getspawnselectionlockedtimer() {
  return 5;
}

function spawnselectioninfil(var_0) {
  foreach(var_2 in level.players) {
    var_2.br_infilstarted = 1;
    var_2 setclientomnvar("ui_br_infil_started", 1);
    var_2 setclientomnvar("ui_br_infiled", 1);
  }

  var_4 = buildac130infilanimstruct(undefined, var_0);
  playac130infilanim(var_4);
}

function initspawnexclusionpois() {
  setdvarifuninitialized("scr_map_selection_sparse_min", 813);
  setdvarifuninitialized("scr_map_selection_sparse_max", 1000);
  setdvarifuninitialized("scr_map_selection_semidense_min", 625);
  setdvarifuninitialized("scr_map_selection_semidense_max", 813);
  setdvarifuninitialized("scr_map_selection_dense_min", 500);
  setdvarifuninitialized("scr_map_selection_dense_max", 625);
  setdvarifuninitialized("scr_map_selection_falloff_max_distance", 25000);
  setdvarifuninitialized("scr_map_selection_falloff_fxn", "continuous");
  level.br_spawnsparsepois = ["boneyard", "farm", "lumber", "dam", "smallAirport", "quarry"];
  level.br_spawnsemidensepois = ["transit", "hospital", "port", "stadium", "tvStation", "storagetown", "supermarket"];
  level.br_spawndensepois = ["gulag", "northDowntown", "southDowntown", "eastAirport", "westAirport"];
  var_0 = getdvarint("scr_map_selection_sparse_min");
  var_1 = getdvarint("scr_map_selection_sparse_max");

  foreach(var_3 in level.br_spawnsparsepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_0;
    level.br_spawnpois[var_3].exclusionmax = var_1;
  }

  var_5 = getdvarint("scr_map_selection_semidense_min");
  var_6 = getdvarint("scr_map_selection_semidense_max");

  foreach(var_3 in level.br_spawnsemidensepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_5;
    level.br_spawnpois[var_3].exclusionmax = var_6;
  }

  var_9 = getdvarint("scr_map_selection_dense_min");
  var_10 = getdvarint("scr_map_selection_dense_max");

  foreach(var_3 in level.br_spawndensepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_9;
    level.br_spawnpois[var_3].exclusionmax = var_10;
  }

  level.br_spawnpois["transit"].pos = (-12420, -26792, 0);
  level.br_spawnpois["boneyard"].pos = (-26542, -21776, 0);
  level.br_spawnpois["hospital"].pos = (7827, -22240, 0);
  level.br_spawnpois["port"].pos = (35008, -37117, 0);
  level.br_spawnpois["farm"].pos = (48757, -25620, 0);
  level.br_spawnpois["gulag"].pos = (51019, -52257, 0);
  level.br_spawnpois["lumber"].pos = (51048, -8557, 0);
  level.br_spawnpois["stadium"].pos = (28873, -9839, 0);
  level.br_spawnpois["tvStation"].pos = (14423, 4999, 0);
  level.br_spawnpois["northDowntown"].pos = (20311, -18724, 0);
  level.br_spawnpois["southDowntown"].pos = (22076, -29372, 0);
  level.br_spawnpois["storagetown"].pos = (-24594, -3984, 0);
  level.br_spawnpois["supermarket"].pos = (-12782, -3634, 0);
  level.br_spawnpois["eastAirport"].pos = (-8280, 5837, 0);
  level.br_spawnpois["westAirport"].pos = (-21055, 7124, 0);
  level.br_spawnpois["dam"].pos = (-26873, 32208, 0);
  level.br_spawnpois["smallAirport"].pos = (5823, 38518, 0);
  level.br_spawnpois["quarry"].pos = (32653, 26929, 0);
}

function getspawnselectioncontexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("scr_map_selection_falloff_max_distance");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4) {
    return getdvarint("scr_map_selection_exclusion", 2800);
  }

  var_6 = log(var_3) / log(var_2) * var_4;
  var_7 = var_2 * exp(var_6 * var_5);
  return var_7;
}

function getspawnselectionconstexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = var_2 / var_3;
  var_5 = getdvarint("scr_map_selection_falloff_max_distance");
  var_6 = distance2d(var_0, var_1);

  if(var_6 > var_5) {
    return getdvarint("scr_map_selection_exclusion", 2800);
  }

  var_7 = var_6 / var_5;
  var_8 = var_2 * pow(1 + var_4, var_7);
  return var_8;
}

function getspawnselectionlerpexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("scr_map_selection_falloff_max_distance");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4) {
    return getdvarint("scr_map_selection_exclusion", 2800);
  }

  var_6 = var_5 / var_4;
  var_7 = scripts\engine\math::lerp(var_2, var_3, var_6);
  return var_7;
}

function getspawnselectionpoi(var_0) {
  var_1 = 2147483647;
  var_2 = undefined;

  foreach(var_4 in level.br_spawnpois) {
    var_5 = distance2d(var_0, var_4.pos);

    if(var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_6;
    }
  }

  return [var_1, var_2];
}

function getspawnselectionexclusionsize(var_0, var_1, var_2) {
  var_3 = getDvar("scr_map_selection_falloff_fxn", "continuous");
  var_4 = level.br_spawnpois[var_2];

  switch (var_3) {
    case "continuous":
      var_4.spawnexclusion2ddist = getspawnselectioncontexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    case "constant":
      var_4.spawnexclusion2ddist = getspawnselectionconstexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    case "lerp":
      var_4.spawnexclusion2ddist = getspawnselectionlerpexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    default:
      var_4.spawnexclusion2ddist = getdvarint("scr_map_selection_exclusion", 2800);
      break;
  }

  return var_4.spawnexclusion2ddist;
}

function ref_14361(var_0) {
  wait var_0;
}

function ref_11dbb(var_0, var_1, var_2, var_3) {
  self moveTo(var_0, var_1, var_2, var_3);
}

function ref_12d9f(var_0, var_1, var_2, var_3) {
  self rotateTo(var_0, var_1, var_2, var_3);
}

function showextractionobjectivetoteam() {
  var_0 = distance(level.br_ac130.ref_12205.startpt, level.br_ac130.ref_12205.endpt);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() / level.showexfilstartsplash.size;

  for(var_2 = 0; var_2 < level.showexfilstartsplash.size; var_2++) {
    wait var_1;
    level.showexfilstartsplash[var_2] notify("halo_jump_c130");
  }

  level.showexfilstartsplash = undefined;
}

function ref_12b22(var_0) {
  if(!isDefined(level.showexfilstartsplash)) {
    level.showexfilstartsplash = [];
  }

  level.showexfilstartsplash[level.showexfilstartsplash.size] = var_0;
}