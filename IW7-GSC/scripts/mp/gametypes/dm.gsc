/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dm.gsc
***************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 30);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.didhalfscorevoboost = 0;
  setteammode("ffa");
  if(scripts\mp\utility::istrue(level.aonrules)) {
    level.ignorekdrstats = 1;
    level.bypassclasschoicefunc = ::alwaysgamemodeclass;
    setomnvar("ui_skip_loadout", 1);
    setspecialloadout();
    game["dialog"]["gametype"] = "allornothing";
  } else {
    game["dialog"]["gametype"] = "freeforall";
  }

  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["ffa_lead_second"] = "ffa_lead_second";
  game["dialog"]["ffa_lead_third"] = "ffa_lead_third";
  game["dialog"]["ffa_lead_last"] = "ffa_lead_last";
  game["dialog"]["offense_obj"] = "killall_intro";
  game["dialog"]["defense_obj"] = "ffa_intro";
  thread onplayerconnect();
}

alwaysgamemodeclass() {
  return "gamemode";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata(1);
  setdynamicdvar("scr_dm_aonrules", getmatchrulesdata("dmData", "aonRules"));
  setdynamicdvar("scr_dm_winlimit", 1);
  scripts\mp\utility::registerwinlimitdvar("dm", 1);
  setdynamicdvar("scr_dm_roundlimit", 1);
  scripts\mp\utility::registerroundlimitdvar("dm", 1);
  setdynamicdvar("scr_dm_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("dm", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility::setobjectivetext("allies", & "OBJECTIVES_DM");
  scripts\mp\utility::setobjectivetext("axis", & "OBJECTIVES_DM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DM");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_DM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_DM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", & "OBJECTIVES_DM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", & "OBJECTIVES_DM_HINT");
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_00[0] = "dm";
  scripts\mp\gameobjects::main(var_00);
  level.quickmessagetoall = 1;
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.aonrules = scripts\mp\utility::dvarintvalue("aonRules", 0, 0, 20);
  if(level.aonrules > 0) {
    level.blockweapondrops = 1;
    level.allowsupers = setdvar("scr_dm_allowSupers", 0);
    level.gesture_explode = loadfx("vfx\iw7\_requests\mp\power\vfx_exploding_drone_explode");
    return;
  }

  level notify("cancel_loadweapons");
}

getspawnpoint() {
  var_00 = undefined;
  if(level.ingraceperiod) {
    var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
    if(var_01.size > 0) {
      var_00 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01, 1);
    }

    if(!isDefined(var_00)) {
      var_01 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_00 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_01);
    }
  } else {
    var_01 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    var_02 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(self.team);
    var_00 = scripts\mp\spawnscoring::getspawnpoint(var_01, var_02);
  }

  return var_00;
}

onspawnplayer() {
  if(level.aonrules > 0) {
    thread onspawnfinished();
  }

  level notify("spawned_player");
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  scripts\mp\gametypes\common::onnormaldeath(param_00, param_01, param_02, param_03, param_04);
  if(level.aonrules > 0) {
    if(param_01 scripts\mp\utility::_hasperk("passive_aon_perks")) {
      param_01 thread scripts\mp\perks\_weaponpassives::func_8974(param_01, param_00);
    }
  }

  var_05 = 0;
  foreach(var_07 in level.players) {
    if(isDefined(var_07.destroynavrepulsor) && var_07.destroynavrepulsor > var_05) {
      var_05 = var_07.destroynavrepulsor;
    }
  }

  if(!level.didhalfscorevoboost) {
    if(param_01.destroynavrepulsor >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      thread dohalftimevo(param_01);
    }
  }

  if(param_01.destroynavrepulsor == level.scorelimit - 2) {
    level.kick_afk_check = 1;
  }

  var_09 = param_01 scripts\mp\utility::getpersstat("killChains");
  param_01 scripts\mp\utility::setextrascore1(var_09);
}

onplayerscore(param_00, param_01, param_02) {
  param_01 scripts\mp\utility::incperstat("gamemodeScore", param_02, 1);
  var_03 = param_01 scripts\mp\utility::getpersstat("gamemodeScore");
  param_01 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_03);
  if(param_01.pers["cur_kill_streak"] > param_01 scripts\mp\utility::getpersstat("killChains")) {
    param_01 scripts\mp\utility::setpersstat("killChains", param_01.pers["cur_kill_streak"]);
    param_01 scripts\mp\utility::setextrascore1(param_01.pers["cur_kill_streak"]);
  }

  if(issubstr(param_00, "super_")) {
    return 0;
  }

  if(issubstr(param_00, "kill_ss")) {
    return 0;
  }

  if(issubstr(param_00, "kill")) {
    var_04 = scripts\mp\rank::getscoreinfovalue("score_increment");
    if(scripts\mp\utility::istrue(level.aonrules)) {
      param_01 thread scripts\mp\rank::giverankxp("kill", 50, undefined);
      param_01 scripts\mp\utility::displayscoreeventpoints(50, "kill");
    }

    return var_04;
  } else if(param_01 == "assist_ffa") {
    param_02 scripts\mp\utility::bufferednotify("earned_score_buffered", var_03);
  }

  return 0;
}

dohalftimevo(param_00) {
  param_00 scripts\mp\utility::leaderdialogonplayer("halfway_friendly_boost");
  var_01 = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);
  if(isDefined(var_01[1])) {
    var_01[1] scripts\mp\utility::leaderdialogonplayer("ffa_lead_second");
  }

  if(isDefined(var_01[2]) && var_01.size > 2) {
    var_01[2] scripts\mp\utility::leaderdialogonplayer("ffa_lead_third");
  }

  if(isDefined(var_01[var_01.size - 1]) && var_01.size > 3) {
    var_01[var_01.size - 1] scripts\mp\utility::leaderdialogonplayer("ffa_lead_last");
  }

  level.didhalfscorevoboost = 1;
}

compare_player_score(param_00, param_01) {
  return param_00.destroynavrepulsor >= param_01.destroynavrepulsor;
}

onspawnfinished() {
  self endon("death");
  self endon("disconnect");
  self waittill("giveLoadout");
  runaonrules();
}

runaonrules() {
  giveextraaonperks();
  if(level.aonrules == 2) {
    self.loadoutarchetype = "archetype_assassin";
  }

  if(!scripts\mp\utility::istrue(level.tactical)) {
    _meth_8114(self.loadoutarchetype);
  }

  self.var_2049 = 0;
  self.var_204A = 0;
  var_00 = self.loadoutgesture;
  self takeallweapons();
  waittillframeend;
  if(level.aonrules >= 3) {
    self notify("gesture_rockPaperScissorsThink()");
    self notify("gesture_coinFlipThink()");
    self setclientomnvar("ui_gesture_reticle", -1);
    self.var_55C9 = 0;
    self giveweapon("iw7_g18_mpr_aon_fixed");
    self givestartammo("iw7_g18_mpr_aon_fixed");
    scripts\mp\utility::giveperk("specialty_sprintfire");
    var_01 = "secondary";
    var_02 = scripts\mp\powers::getcurrentequipment(var_01);
    if(isDefined(var_02)) {
      scripts\mp\powers::removepower(var_02);
    }

    if(level.aonrules == 3) {
      if(!isbot(self)) {
        randomizegesture();
      }
    }
  } else {
    self giveweapon("iw7_g18_mpr_aon_fixed");
    self giveweapon("iw7_knife_mp_aon");
    self assignweaponmeleeslot("iw7_knife_mp_aon");
    self giveweapon("iw7_knife_mp_aon2");
    self givestartammo("iw7_g18_mpr_aon_fixed");
    if(isDefined(var_00)) {
      scripts\mp\utility::_giveweapon(var_00);
      self _meth_8541(var_00);
      self.gestureweapon = var_00;
    }
  }

  var_01 = "primary";
  var_02 = scripts\mp\powers::getcurrentequipment(var_01);
  if(isDefined(var_02)) {
    scripts\mp\powers::removepower(var_02);
  }

  if(level.aonrules == 2) {
    scripts\mp\powers::givepower("power_blinkKnife", var_01, 0);
  } else {
    scripts\mp\powers::givepower("power_throwingKnife", var_01, 0);
  }

  scripts\mp\utility::func_11383("iw7_g18_mpr_aon_fixed", 1);
  if(level.aonrules > 2) {
    thread gesturewatcher(self.gestureweapon);
  }
}

devforcegestures(param_00, param_01) {
  if(level.aonrules == 4) {
    param_00 = "ges_plyr_gesture010";
    scripts\mp\powers::givepower("power_transponder", param_01, 0);
  } else if(level.aonrules == 5) {
    param_00 = "ges_plyr_gesture042";
    scripts\mp\powers::givepower("power_bouncingBetty", param_01, 0);
  } else if(level.aonrules == 6) {
    param_00 = "ges_plyr_gesture002";
    scripts\mp\powers::givepower("power_gasGrenade", param_01, 0);
  } else if(level.aonrules == 7) {
    param_00 = "ges_plyr_gesture006";
    scripts\mp\powers::givepower("power_siegeMode", param_01, 0);
  } else if(level.aonrules == 8) {
    param_00 = "ges_plyr_gesture038";
    scripts\mp\powers::givepower("power_sensorGrenade", param_01, 0);
  } else if(level.aonrules == 9) {
    param_00 = "ges_plyr_gesture053";
    scripts\mp\powers::givepower("power_proxyBomb", param_01, 0);
  } else if(level.aonrules == 10) {
    param_00 = "ges_plyr_gesture051";
    scripts\mp\powers::givepower("power_phaseSplit", param_01, 0);
  } else if(level.aonrules == 11) {
    param_00 = "ges_plyr_gesture040";
    scripts\mp\powers::givepower("power_discMarker", param_01, 0);
  } else if(level.aonrules == 12) {
    param_00 = "ges_plyr_gesture049";
    scripts\mp\powers::givepower("power_caseBomb", param_01, 0);
  } else if(level.aonrules == 13) {
    param_00 = "ges_plyr_gesture001";
    scripts\mp\powers::givepower("power_adrenalineMist", param_01, 0);
  } else if(level.aonrules == 14) {
    param_00 = "ges_plyr_gesture041";
    scripts\mp\powers::givepower("power_thermobaric", param_01, 0);
  }

  scripts\mp\utility::_giveweapon(param_00);
  self _meth_8541(param_00);
  self.gestureweapon = param_00;
}

randomizegesture() {
  var_00 = "ges_plyr_gesture010";
  var_01 = "power_transponder";
  var_02 = "secondary";
  if(self.gestureindex >= self.gesturelist.size) {
    self.gesturelist = scripts\engine\utility::array_randomize(self.gesturelist);
    self.gestureindex = 0;
  }

  var_00 = self.gesturelist[self.gestureindex];
  var_01 = getpowerfromgesture(var_00);
  scripts\mp\powers::givepower(var_01, var_02, 0);
  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    scripts\mp\utility::_takeweapon(self.gestureweapon);
  }

  scripts\mp\utility::_giveweapon(var_00);
  self _meth_8541(var_00);
  self.gestureweapon = var_00;
  return var_01;
}

getpowerfromgesture(param_00) {
  switch (param_00) {
    case "ges_plyr_gesture010":
      var_01 = "power_transponder";
      break;

    case "ges_plyr_gesture042":
      var_01 = "power_bouncingBetty";
      break;

    case "ges_plyr_gesture002":
      var_01 = "power_gasGrenade";
      break;

    case "ges_plyr_gesture006":
      var_01 = "power_siegeMode";
      break;

    case "ges_plyr_gesture038":
      var_01 = "power_sensorGrenade";
      break;

    case "ges_plyr_gesture053":
      var_01 = "power_proxyBomb";
      break;

    case "ges_plyr_gesture051":
      var_01 = "power_phaseSplit";
      break;

    case "ges_plyr_gesture040":
      var_01 = "power_discMarker";
      break;

    case "ges_plyr_gesture049":
      var_01 = "power_caseBomb";
      break;

    case "ges_plyr_gesture001":
      var_01 = "power_adrenalineMist";
      break;

    case "ges_plyr_gesture041":
      var_01 = "power_thermobaric";
      break;

    default:
      var_01 = "power_transponder";
      break;
  }

  return var_01;
}

gesturewatcher(param_00) {
  self endon("death");
  for(;;) {
    self waittill("offhand_pullback", param_00);
    if(param_00 == "throwingknife_mp") {
      continue;
    }

    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = undefined;
    var_05 = 1;
    var_06 = undefined;
    var_07 = 1200;
    switch (param_00) {
      case "power_bang_mp":
      case "ges_plyr_gesture010":
        param_00 = "ges_plyr_gesture010";
        var_01 = 0.65;
        var_02 = 0.3;
        break;

      case "power_crush_mp":
      case "ges_plyr_gesture042":
        scripts\mp\utility::giveperk("passive_gore");
        param_00 = "ges_plyr_gesture042";
        var_01 = 0.8;
        var_02 = 0.1;
        var_03 = 0.1;
        break;

      case "power_headcrush_mp":
      case "ges_plyr_gesture002":
        scripts\mp\utility::giveperk("passive_gore");
        param_00 = "ges_plyr_gesture002";
        var_01 = 1.15;
        var_02 = 0.65;
        var_03 = 0.3;
        break;

      case "power_throatcut_mp":
      case "ges_plyr_gesture006":
        scripts\mp\utility::giveperk("passive_gore");
        param_00 = "ges_plyr_gesture006";
        var_01 = 0.85;
        var_02 = 0.1;
        var_03 = 0.1;
        var_05 = 1;
        var_06 = 55;
        break;

      case "power_boom_mp":
      case "ges_plyr_gesture038":
        param_00 = "ges_plyr_gesture038";
        var_01 = 1.15;
        break;

      case "power_lighter_mp":
      case "ges_plyr_gesture053":
        param_00 = "ges_plyr_gesture053";
        var_01 = 1.65;
        var_06 = 55;
        break;

      case "power_rc8_mp":
      case "ges_plyr_gesture051":
        param_00 = "ges_plyr_gesture051";
        var_01 = 1.45;
        var_02 = 0.6;
        var_03 = 0.15;
        var_06 = 55;
        break;

      case "power_chinflick_mp":
      case "ges_plyr_gesture040":
        param_00 = "ges_plyr_gesture040";
        var_01 = 0.95;
        break;

      case "power_jackal_mp":
      case "ges_plyr_gesture049":
        param_00 = "ges_plyr_gesture049";
        var_01 = 1.5;
        var_02 = 0.9;
        var_03 = 0.9;
        break;

      case "power_no_mp":
      case "ges_plyr_gesture001":
        param_00 = "ges_plyr_gesture001";
        var_01 = 0.75;
        var_02 = 0.2;
        var_03 = 0.1;
        var_04 = 0.1;
        break;

      case "power_begone_mp":
      case "ges_plyr_gesture041":
        param_00 = "ges_plyr_gesture041";
        var_01 = 0.35;
        var_02 = 0.3;
        var_03 = 0.1;
        var_06 = 55;
        break;

      default:
        param_00 = "ges_plyr_gesture010";
        var_01 = 0.65;
        var_02 = 0.3;
        break;
    }

    if(scripts\mp\utility::gameflag("prematch_done")) {
      thread use_gesture_weapon(param_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    }
  }
}

gesturedumbfirekillwatcher(param_00) {
  self notify("finger_gun_used");
  self endon("finger_gun_used");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("got_a_kill", var_01, var_02, var_03);
  if(var_02 == "cluster_grenade_mp" || var_02 == "iw7_chargeshot_mp" || var_02 == "iw7_glprox_mp") {
    self.gesturekill = 1;
    incrementgestureindex(param_00);
  }
}

use_gesture_weapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  self endon("death");
  scripts\mp\utility::func_1C47(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  self.gesturekill = 0;
  var_08 = self.gestureindex;
  if(isDefined(param_01)) {
    scripts\mp\utility::giveperk("specialty_radarblip");
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(param_01);
    var_09 = get_enemies_within_fov(param_06, param_07, param_05);
    if(var_09.size == 0) {
      thread gesturedumbfirekillwatcher(var_08);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(param_00 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 1, var_0A);
      } else if(param_00 == "ges_plyr_gesture040") {
        self.projectile = scripts\mp\utility::_magicbullet("iw7_blackholegun_mp", self gettagorigin("j_wrist_le"), var_0A, self);
        self.gesturekill = 1;
        incrementgestureindex(var_08);
      } else if(param_00 == "ges_plyr_gesture010") {
        scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0A, self);
      } else if(param_00 == "ges_plyr_gesture038" || param_00 == "ges_plyr_gesture053") {
        self radiusdamage(var_0A + (0, 0, 40), 256, 150, 100, self, "MOD_IMPACT", "cluster_grenade_mp");
        playFX(level.gesture_explode, var_0A + (0, 0, 40));
        playsoundatpos(var_0A, "frag_grenade_explode");
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_09) {
        if(param_00 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 1);
        } else if(param_00 == "ges_plyr_gesture040") {
          self.projectile = scripts\mp\utility::_magicbullet("iw7_blackholegun_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          self.projectile missile_settargetent(var_0C, var_0C gettargetoffset());
        } else if(param_00 == "ges_plyr_gesture010") {
          scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          thread dogesturedamage(var_0C, "iw7_atomizer_mp", param_00, 1);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", param_00, 1);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_08);
      }
    }
  }

  if(isDefined(param_02)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(param_02);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_09 = get_enemies_within_fov(param_06, param_07, 1);
    if(var_09.size == 0) {
      thread gesturedumbfirekillwatcher(var_08);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(param_00 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 2, var_0A);
      } else if(param_00 == "ges_plyr_gesture010") {
        scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0A, self);
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_09) {
        if(param_00 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 2);
        } else if(param_00 == "ges_plyr_gesture010") {
          scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          thread dogesturedamage(var_0C, "iw7_atomizer_mp", param_00, 2);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", param_00, 2);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_08);
      }
    }
  }

  if(isDefined(param_03)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(param_03);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_09 = get_enemies_within_fov(param_06, param_07, 1);
    if(var_09.size == 0) {
      thread gesturedumbfirekillwatcher(var_08);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(param_00 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 3, var_0A);
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_09) {
        if(param_00 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 3);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", param_00, 3);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_08);
      }
    }
  }

  if(isDefined(param_04)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(param_04);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_09 = get_enemies_within_fov(param_06, param_07, 1);
    if(var_09.size == 0) {
      self setclientomnvar("ui_gesture_reticle", 1);
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_09) {
        thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", param_00, 4);
        self.gesturekill = 1;
        incrementgestureindex(var_08);
      }
    }
  }

  wait(0.1);
  scripts\mp\utility::removeperk("specialty_radarblip");
  self setclientomnvar("ui_gesture_reticle", -1);
  wait_for_gesture_length(param_00);
  powerrecharge();
}

incrementgestureindex(param_00) {
  if(param_00 == self.gestureindex) {
    self.gestureindex++;
  }
}

wait_for_gesture_length(param_00) {
  self endon("disconnect");
  self endon("death");
  while(self isgestureplaying(param_00)) {
    scripts\engine\utility::waitframe();
  }
}

firejackalmissiles(param_00, param_01, param_02) {
  var_03 = 0;
  if(!isDefined(param_00)) {
    var_03 = 1;
  }

  var_04 = self gettagorigin("j_wrist_le");
  var_05 = self gettagorigin("j_wrist_le");
  var_06 = self gettagorigin("j_wrist_le");
  if(var_03) {
    var_07 = param_02;
    var_08 = var_07;
    var_09 = var_08;
  } else {
    var_07 = var_03 gettagorigin("j_spine4");
    var_08 = param_02 gettagorigin("j_spineupper");
    var_09 = param_01 getEye();
    var_0A = scripts\mp\utility::_magicbullet("iw7_lockon_mp", var_04, var_07, self);
    var_0A missile_settargetent(param_00, param_00 gettargetoffset());
    var_0B = scripts\mp\utility::_magicbullet("iw7_lockon_mp", var_05, var_08, self);
    var_0B missile_settargetent(param_00, param_00 gettargetoffset());
  }

  if(param_01 == 3) {
    scripts\mp\utility::_magicbullet("iw7_chargeshot_mp", var_06, var_09, self);
    return;
  }

  scripts\mp\utility::_magicbullet("iw7_glprox_mp", var_06, var_09, self);
}

getdumbfirepos(param_00) {
  var_01 = param_00 getplayerangles();
  var_01 = (clamp(var_01[0], -85, 85), var_01[1], var_01[2]);
  var_02 = anglesToForward(var_01);
  var_03 = param_00 gettagorigin("j_wrist_le");
  var_04 = vectornormalize(var_02) * 500;
  var_05 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_06 = physics_createcontents(var_05);
  var_07 = scripts\common\trace::ray_trace(var_03, var_03 + var_04, param_00, var_06);
  if(var_07["fraction"] < 1) {
    var_04 = vectornormalize(var_02) * 500 * var_07["fraction"];
  } else {
    var_04 = vectornormalize(var_02) * 500;
  }

  return var_03 + var_04;
}

gettargetoffset() {
  var_00 = gettargetorigin();
  return (0, 0, var_00[2] - self.origin[2]);
}

gettargetorigin() {
  var_00 = 10;
  switch (self getstance()) {
    case "crouch":
      var_00 = 15;
      break;

    case "prone":
      var_00 = 5;
      break;
  }

  var_01 = self getworldupreferenceangles();
  var_02 = anglestoup(var_01);
  var_03 = self gettagorigin("j_spinelower", 1, 1);
  var_04 = var_03 + var_02 * var_00;
  return var_04;
}

powerrecharge() {
  if(level.aonrules == 3 && self.gesturekill) {
    var_00 = "secondary";
    var_01 = scripts\mp\powers::getcurrentequipment(var_00);
    if(isDefined(var_01)) {
      scripts\mp\powers::removepower(var_01);
    }

    var_02 = randomizegesture();
  } else {
    var_02 = scripts\mp\powers::getcurrentequipment("secondary");
    scripts\mp\powers::func_D74C(var_02);
  }

  if(scripts\mp\utility::_hasperk("passive_gore")) {
    scripts\mp\utility::removeperk("passive_gore");
  }

  scripts\mp\utility::func_1C47(1);
  scripts\engine\utility::allow_offhand_weapons(1);
}

dogesturedamage(param_00, param_01, param_02, param_03) {
  if(param_02 == "ges_plyr_gesture038" || param_02 == "ges_plyr_gesture053") {
    self radiusdamage(param_00.origin + (0, 0, 40), 256, 150, 100, self, "MOD_IMPACT", "cluster_grenade_mp");
    playFX(level.mine_explode, param_00.origin + (0, 0, 40));
    playsoundatpos(param_00.origin + (0, 0, 40), "frag_grenade_explode");
    return;
  }

  if(param_02 == "ges_plyr_gesture010" || param_02 == "ges_plyr_gesture006") {
    wait(0.05);
    if(isDefined(self) && isDefined(param_00)) {
      param_00 dodamage(param_00.health + 1000, self.origin, self, self, "MOD_UNKNOWN", param_01);
      return;
    }

    return;
  }

  if(param_02 == "ges_plyr_gesture051" || param_02 == "ges_plyr_gesture041" || param_02 == "ges_plyr_gesture001") {
    var_04 = vectortoangles(param_00.origin - self.origin);
    var_05 = anglestoright(var_04);
    var_06 = vectornormalize(var_05) * 500;
    if(param_02 == "ges_plyr_gesture041" || param_02 == "ges_plyr_gesture001" && param_03 == 2 || param_02 == "ges_plyr_gesture001" && param_03 == 4) {
      var_06 = var_06 * -1;
    }

    param_00 _meth_84DC(var_06 + (0, 0, 500), 750);
  } else {
    param_00 _meth_84DC(vectornormalize(param_00.origin - self.origin) * 500 + (0, 0, 800), 750);
  }

  wait(0.05);
  if(isDefined(self) && isDefined(param_00)) {
    param_00 dodamage(param_00.health + 1000, self.origin, self, self, "MOD_CRUSH", param_01);
    return;
  }
}

get_enemies_within_fov(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 3;
  }

  var_03 = [];
  var_04 = level.players;
  var_05 = scripts\engine\utility::get_array_of_closest(self.origin, var_04, undefined, 17, param_01, 1);
  var_06 = anglesToForward(self.angles);
  var_07 = vectornormalize(var_06) * -35;
  var_08 = 0;
  var_09 = 50;
  if(isDefined(param_00)) {
    var_09 = param_00;
  }

  foreach(var_0B in var_05) {
    if(!scripts\mp\utility::isreallyalive(var_0B)) {
      continue;
    }

    var_0C = var_0B.origin;
    var_0D = distance2d(self.origin, var_0C);
    if(var_0D < 100) {
      var_09 = 120;
    }

    var_0E = 0;
    var_0F = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = [];
    var_14[var_14.size] = self;
    var_14[var_14.size] = var_0B;
    var_15 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_itemclip"];
    var_16 = physics_createcontents(var_15);
    var_17 = self worldpointinreticle_circle(var_0B getEye(), 65, var_09);
    if(var_17) {
      var_17 = 0;
      if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B getEye(), var_14, var_16)) {
        var_17 = 1;
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B.origin, 65, var_09);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B.origin, var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_spinelower"), 65, var_09);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_spinelower"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_elbow_le"), 65, var_09);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_elbow_le"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_elbow_ri"), 65, var_09);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_elbow_ri"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(var_17) {
      if(isDefined(param_01)) {
        var_0D = distance2d(self.origin, var_0C);
        if(var_0D < param_01) {
          var_0E = 1;
        }
      } else {
        var_0E = 1;
      }
    }

    if(var_0E && var_03.size < param_02) {
      var_03[var_03.size] = var_0B;
      var_05 = scripts\engine\utility::array_remove(var_05, var_0B);
    }

    if(var_03.size >= param_02) {
      var_08 = 1;
      break;
    }
  }

  return var_03;
}

giveextraaonperks() {
  var_00 = ["specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker", "passive_aon_perks"];
  foreach(var_02 in var_00) {
    scripts\mp\utility::giveperk(var_02);
  }
}

_meth_8114(param_00) {
  switch (param_00) {
    case "archetype_assault":
      param_00 = "assault_mp";
      break;

    case "archetype_heavy":
      param_00 = "armor_mp";
      break;

    case "archetype_scout":
      param_00 = "scout_mp";
      break;

    case "archetype_assassin":
      param_00 = "assassin_mp";
      break;

    case "archetype_engineer":
      param_00 = "engineer_mp";
      break;

    case "archetype_sniper":
      param_00 = "sniper_mp";
      break;

    default:
      if(!isDefined(level.aonrules) || level.aonrules == 0) {}

      param_00 = "assault_mp";
      break;
  }

  self setsuit(param_00 + "_classic");
  if(scripts\mp\utility::istrue(level.supportdoublejump_MAYBE)) {
    self goalflag(0, 200);
    self goal_type(0, 1800);
  }
}

onplayerconnect() {
  level endon("cancel_loadweapons");
  var_00 = 1;
  for(;;) {
    level waittill("connected", var_01);
    if(level.aonrules > 0) {
      if(var_00) {
        level notify("lethal_delay_end");
        level.var_ABBF = 0;
        level.allowkillstreaks = 0;
        var_00 = 0;
      }

      var_01.pers["class"] = "gamemode";
      var_01.pers["lastClass"] = "";
      var_01.class = var_01.pers["class"];
      var_01.lastclass = var_01.pers["lastClass"];
      var_01.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
      var_01 loadweaponsforplayer(["iw7_g18_mpr_aon_fixed", "iw7_knife_mp_aon", "iw7_knife_mp_aon2"]);
    }

    if(level.aonrules == 3) {
      var_01 thread hintnotify();
      var_01.gesturelist = [];
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture042";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture002";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture006";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture038";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture053";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture051";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture040";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture049";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture001";
      var_01.gesturelist[var_01.gesturelist.size] = "ges_plyr_gesture041";
      var_01.gesturelist = scripts\engine\utility::array_randomize(var_01.gesturelist);
      var_01.gesturelist = scripts\engine\utility::array_insert(var_01.gesturelist, "ges_plyr_gesture010", 0);
      var_01.gestureindex = 0;
    }
  }
}

hintnotify() {
  level endon("game_ended");
  self endon("disconnect");
  var_00 = 1;
  var_01 = 0;
  for(;;) {
    if(var_00) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    wait(4);
    var_01++;
    if(var_01 < 3) {
      thread givehintmessage();
      continue;
    }

    break;
  }
}

givehintmessage() {
  self notify("practiceMessage");
  self endon("practiceMessage");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self iprintlnbold( & "PLATFORM_GESTURE_MODE_HINT_SLOT3");
    return;
  }

  self iprintlnbold( & "PLATFORM_GESTURE_MODE_HINT_SLOT7");
}

setspecialloadout() {
  level.aon_loadouts["allies"]["loadoutPrimary"] = "iw7_g18";
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
  level.aon_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondary"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
  level.aon_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
  level.aon_loadouts["allies"]["loadoutPowerPrimary"] = "power_throwingKnife";
  level.aon_loadouts["allies"]["loadoutPowerSecondary"] = "none";
  level.aon_loadouts["allies"]["loadoutSuper"] = "none";
  level.aon_loadouts["allies"]["loadoutStreakType"] = "assault";
  level.aon_loadouts["allies"]["loadoutKillstreak1"] = "none";
  level.aon_loadouts["allies"]["loadoutKillstreak2"] = "none";
  level.aon_loadouts["allies"]["loadoutKillstreak3"] = "none";
  level.aon_loadouts["allies"]["loadoutJuggernaut"] = 0;
  level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_fastreload"];
  level.aon_loadouts["allies"]["loadoutGesture"] = "playerData";
  level.aon_loadouts["axis"] = level.aon_loadouts["allies"];
}