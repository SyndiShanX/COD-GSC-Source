/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dm.gsc
*********************************************/

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
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_DM");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_DM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DM");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_DM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_DM_HINT");
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
  var_0[0] = "dm";
  scripts\mp\gameobjects::main(var_0);
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
  var_0 = undefined;
  if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
    if(var_1.size > 0) {
      var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1, 1);
    }

    if(!isDefined(var_0)) {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_1);
    }
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
    var_2 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(self.team);
    var_0 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_2);
  }

  return var_0;
}

onspawnplayer() {
  if(level.aonrules > 0) {
    thread onspawnfinished();
  }

  level notify("spawned_player");
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
  if(level.aonrules > 0) {
    if(var_1 scripts\mp\utility::_hasperk("passive_aon_perks")) {
      var_1 thread scripts\mp\perks\_weaponpassives::func_8974(var_1, var_0);
    }
  }

  var_5 = 0;
  foreach(var_7 in level.players) {
    if(isDefined(var_7.destroynavrepulsor) && var_7.destroynavrepulsor > var_5) {
      var_5 = var_7.destroynavrepulsor;
    }
  }

  if(!level.didhalfscorevoboost) {
    if(var_1.destroynavrepulsor >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      thread dohalftimevo(var_1);
    }
  }

  if(var_1.destroynavrepulsor == level.scorelimit - 2) {
    level.kick_afk_check = 1;
  }

  var_9 = var_1 scripts\mp\utility::getpersstat("killChains");
  var_1 scripts\mp\utility::setextrascore1(var_9);
}

onplayerscore(var_0, var_1, var_2) {
  var_1 scripts\mp\utility::incperstat("gamemodeScore", var_2, 1);
  var_3 = var_1 scripts\mp\utility::getpersstat("gamemodeScore");
  var_1 scripts\mp\persistence::statsetchild("round", "gamemodeScore", var_3);
  if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility::getpersstat("killChains")) {
    var_1 scripts\mp\utility::setpersstat("killChains", var_1.pers["cur_kill_streak"]);
    var_1 scripts\mp\utility::setextrascore1(var_1.pers["cur_kill_streak"]);
  }

  if(issubstr(var_0, "super_")) {
    return 0;
  }

  if(issubstr(var_0, "kill_ss")) {
    return 0;
  }

  if(issubstr(var_0, "kill")) {
    var_4 = scripts\mp\rank::getscoreinfovalue("score_increment");
    if(scripts\mp\utility::istrue(level.aonrules)) {
      var_1 thread scripts\mp\rank::giverankxp("kill", 50, undefined);
      var_1 scripts\mp\utility::displayscoreeventpoints(50, "kill");
    }

    return var_4;
  } else if(var_1 == "assist_ffa") {
    var_2 scripts\mp\utility::bufferednotify("earned_score_buffered", var_3);
  }

  return 0;
}

dohalftimevo(var_0) {
  var_0 scripts\mp\utility::leaderdialogonplayer("halfway_friendly_boost");
  var_1 = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);
  if(isDefined(var_1[1])) {
    var_1[1] scripts\mp\utility::leaderdialogonplayer("ffa_lead_second");
  }

  if(isDefined(var_1[2]) && var_1.size > 2) {
    var_1[2] scripts\mp\utility::leaderdialogonplayer("ffa_lead_third");
  }

  if(isDefined(var_1[var_1.size - 1]) && var_1.size > 3) {
    var_1[var_1.size - 1] scripts\mp\utility::leaderdialogonplayer("ffa_lead_last");
  }

  level.didhalfscorevoboost = 1;
}

compare_player_score(var_0, var_1) {
  return var_0.destroynavrepulsor >= var_1.destroynavrepulsor;
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
  var_0 = self.loadoutgesture;
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
    var_1 = "secondary";
    var_2 = scripts\mp\powers::getcurrentequipment(var_1);
    if(isDefined(var_2)) {
      scripts\mp\powers::removepower(var_2);
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
    if(isDefined(var_0)) {
      scripts\mp\utility::_giveweapon(var_0);
      self _meth_8541(var_0);
      self.gestureweapon = var_0;
    }
  }

  var_1 = "primary";
  var_2 = scripts\mp\powers::getcurrentequipment(var_1);
  if(isDefined(var_2)) {
    scripts\mp\powers::removepower(var_2);
  }

  if(level.aonrules == 2) {
    scripts\mp\powers::givepower("power_blinkKnife", var_1, 0);
  } else {
    scripts\mp\powers::givepower("power_throwingKnife", var_1, 0);
  }

  scripts\mp\utility::func_11383("iw7_g18_mpr_aon_fixed", 1);
  if(level.aonrules > 2) {
    thread gesturewatcher(self.gestureweapon);
  }
}

devforcegestures(var_0, var_1) {
  if(level.aonrules == 4) {
    var_0 = "ges_plyr_gesture010";
    scripts\mp\powers::givepower("power_transponder", var_1, 0);
  } else if(level.aonrules == 5) {
    var_0 = "ges_plyr_gesture042";
    scripts\mp\powers::givepower("power_bouncingBetty", var_1, 0);
  } else if(level.aonrules == 6) {
    var_0 = "ges_plyr_gesture002";
    scripts\mp\powers::givepower("power_gasGrenade", var_1, 0);
  } else if(level.aonrules == 7) {
    var_0 = "ges_plyr_gesture006";
    scripts\mp\powers::givepower("power_siegeMode", var_1, 0);
  } else if(level.aonrules == 8) {
    var_0 = "ges_plyr_gesture038";
    scripts\mp\powers::givepower("power_sensorGrenade", var_1, 0);
  } else if(level.aonrules == 9) {
    var_0 = "ges_plyr_gesture053";
    scripts\mp\powers::givepower("power_proxyBomb", var_1, 0);
  } else if(level.aonrules == 10) {
    var_0 = "ges_plyr_gesture051";
    scripts\mp\powers::givepower("power_phaseSplit", var_1, 0);
  } else if(level.aonrules == 11) {
    var_0 = "ges_plyr_gesture040";
    scripts\mp\powers::givepower("power_discMarker", var_1, 0);
  } else if(level.aonrules == 12) {
    var_0 = "ges_plyr_gesture049";
    scripts\mp\powers::givepower("power_caseBomb", var_1, 0);
  } else if(level.aonrules == 13) {
    var_0 = "ges_plyr_gesture001";
    scripts\mp\powers::givepower("power_adrenalineMist", var_1, 0);
  } else if(level.aonrules == 14) {
    var_0 = "ges_plyr_gesture041";
    scripts\mp\powers::givepower("power_thermobaric", var_1, 0);
  }

  scripts\mp\utility::_giveweapon(var_0);
  self _meth_8541(var_0);
  self.gestureweapon = var_0;
}

randomizegesture() {
  var_0 = "ges_plyr_gesture010";
  var_1 = "power_transponder";
  var_2 = "secondary";
  if(self.gestureindex >= self.gesturelist.size) {
    self.gesturelist = scripts\engine\utility::array_randomize(self.gesturelist);
    self.gestureindex = 0;
  }

  var_0 = self.gesturelist[self.gestureindex];
  var_1 = getpowerfromgesture(var_0);
  scripts\mp\powers::givepower(var_1, var_2, 0);
  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    scripts\mp\utility::_takeweapon(self.gestureweapon);
  }

  scripts\mp\utility::_giveweapon(var_0);
  self _meth_8541(var_0);
  self.gestureweapon = var_0;
  return var_1;
}

getpowerfromgesture(var_0) {
  switch (var_0) {
    case "ges_plyr_gesture010":
      var_1 = "power_transponder";
      break;

    case "ges_plyr_gesture042":
      var_1 = "power_bouncingBetty";
      break;

    case "ges_plyr_gesture002":
      var_1 = "power_gasGrenade";
      break;

    case "ges_plyr_gesture006":
      var_1 = "power_siegeMode";
      break;

    case "ges_plyr_gesture038":
      var_1 = "power_sensorGrenade";
      break;

    case "ges_plyr_gesture053":
      var_1 = "power_proxyBomb";
      break;

    case "ges_plyr_gesture051":
      var_1 = "power_phaseSplit";
      break;

    case "ges_plyr_gesture040":
      var_1 = "power_discMarker";
      break;

    case "ges_plyr_gesture049":
      var_1 = "power_caseBomb";
      break;

    case "ges_plyr_gesture001":
      var_1 = "power_adrenalineMist";
      break;

    case "ges_plyr_gesture041":
      var_1 = "power_thermobaric";
      break;

    default:
      var_1 = "power_transponder";
      break;
  }

  return var_1;
}

gesturewatcher(var_0) {
  self endon("death");
  for(;;) {
    self waittill("offhand_pullback", var_0);
    if(var_0 == "throwingknife_mp") {
      continue;
    }

    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = 1;
    var_6 = undefined;
    var_7 = 1200;
    switch (var_0) {
      case "power_bang_mp":
      case "ges_plyr_gesture010":
        var_0 = "ges_plyr_gesture010";
        var_1 = 0.65;
        var_2 = 0.3;
        break;

      case "power_crush_mp":
      case "ges_plyr_gesture042":
        scripts\mp\utility::giveperk("passive_gore");
        var_0 = "ges_plyr_gesture042";
        var_1 = 0.8;
        var_2 = 0.1;
        var_3 = 0.1;
        break;

      case "power_headcrush_mp":
      case "ges_plyr_gesture002":
        scripts\mp\utility::giveperk("passive_gore");
        var_0 = "ges_plyr_gesture002";
        var_1 = 1.15;
        var_2 = 0.65;
        var_3 = 0.3;
        break;

      case "power_throatcut_mp":
      case "ges_plyr_gesture006":
        scripts\mp\utility::giveperk("passive_gore");
        var_0 = "ges_plyr_gesture006";
        var_1 = 0.85;
        var_2 = 0.1;
        var_3 = 0.1;
        var_5 = 1;
        var_6 = 55;
        break;

      case "power_boom_mp":
      case "ges_plyr_gesture038":
        var_0 = "ges_plyr_gesture038";
        var_1 = 1.15;
        break;

      case "power_lighter_mp":
      case "ges_plyr_gesture053":
        var_0 = "ges_plyr_gesture053";
        var_1 = 1.65;
        var_6 = 55;
        break;

      case "power_rc8_mp":
      case "ges_plyr_gesture051":
        var_0 = "ges_plyr_gesture051";
        var_1 = 1.45;
        var_2 = 0.6;
        var_3 = 0.15;
        var_6 = 55;
        break;

      case "power_chinflick_mp":
      case "ges_plyr_gesture040":
        var_0 = "ges_plyr_gesture040";
        var_1 = 0.95;
        break;

      case "power_jackal_mp":
      case "ges_plyr_gesture049":
        var_0 = "ges_plyr_gesture049";
        var_1 = 1.5;
        var_2 = 0.9;
        var_3 = 0.9;
        break;

      case "power_no_mp":
      case "ges_plyr_gesture001":
        var_0 = "ges_plyr_gesture001";
        var_1 = 0.75;
        var_2 = 0.2;
        var_3 = 0.1;
        var_4 = 0.1;
        break;

      case "power_begone_mp":
      case "ges_plyr_gesture041":
        var_0 = "ges_plyr_gesture041";
        var_1 = 0.35;
        var_2 = 0.3;
        var_3 = 0.1;
        var_6 = 55;
        break;

      default:
        var_0 = "ges_plyr_gesture010";
        var_1 = 0.65;
        var_2 = 0.3;
        break;
    }

    if(scripts\mp\utility::gameflag("prematch_done")) {
      thread use_gesture_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    }
  }
}

gesturedumbfirekillwatcher(var_0) {
  self notify("finger_gun_used");
  self endon("finger_gun_used");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("got_a_kill", var_1, var_2, var_3);
  if(var_2 == "cluster_grenade_mp" || var_2 == "iw7_chargeshot_mp" || var_2 == "iw7_glprox_mp") {
    self.gesturekill = 1;
    incrementgestureindex(var_0);
  }
}

use_gesture_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  self endon("death");
  scripts\mp\utility::func_1C47(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  self.gesturekill = 0;
  var_8 = self.gestureindex;
  if(isDefined(var_1)) {
    scripts\mp\utility::giveperk("specialty_radarblip");
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(var_1);
    var_9 = get_enemies_within_fov(var_6, var_7, var_5);
    if(var_9.size == 0) {
      thread gesturedumbfirekillwatcher(var_8);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(var_0 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 1, var_0A);
      } else if(var_0 == "ges_plyr_gesture040") {
        self.projectile = scripts\mp\utility::_magicbullet("iw7_blackholegun_mp", self gettagorigin("j_wrist_le"), var_0A, self);
        self.gesturekill = 1;
        incrementgestureindex(var_8);
      } else if(var_0 == "ges_plyr_gesture010") {
        scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0A, self);
      } else if(var_0 == "ges_plyr_gesture038" || var_0 == "ges_plyr_gesture053") {
        self radiusdamage(var_0A + (0, 0, 40), 256, 150, 100, self, "MOD_IMPACT", "cluster_grenade_mp");
        playFX(level.gesture_explode, var_0A + (0, 0, 40));
        playsoundatpos(var_0A, "frag_grenade_explode");
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_9) {
        if(var_0 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 1);
        } else if(var_0 == "ges_plyr_gesture040") {
          self.projectile = scripts\mp\utility::_magicbullet("iw7_blackholegun_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          self.projectile missile_settargetent(var_0C, var_0C gettargetoffset());
        } else if(var_0 == "ges_plyr_gesture010") {
          scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          thread dogesturedamage(var_0C, "iw7_atomizer_mp", var_0, 1);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", var_0, 1);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_8);
      }
    }
  }

  if(isDefined(var_2)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(var_2);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_9 = get_enemies_within_fov(var_6, var_7, 1);
    if(var_9.size == 0) {
      thread gesturedumbfirekillwatcher(var_8);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(var_0 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 2, var_0A);
      } else if(var_0 == "ges_plyr_gesture010") {
        scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0A, self);
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_9) {
        if(var_0 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 2);
        } else if(var_0 == "ges_plyr_gesture010") {
          scripts\mp\utility::_magicbullet("iw7_atomizer_mp", self gettagorigin("j_wrist_le"), var_0C gettagorigin("j_spine4"), self);
          thread dogesturedamage(var_0C, "iw7_atomizer_mp", var_0, 2);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", var_0, 2);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_8);
      }
    }
  }

  if(isDefined(var_3)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(var_3);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_9 = get_enemies_within_fov(var_6, var_7, 1);
    if(var_9.size == 0) {
      thread gesturedumbfirekillwatcher(var_8);
      self setclientomnvar("ui_gesture_reticle", 1);
      var_0A = getdumbfirepos(self);
      if(var_0 == "ges_plyr_gesture049") {
        firejackalmissiles(undefined, 3, var_0A);
      }
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_9) {
        if(var_0 == "ges_plyr_gesture049") {
          firejackalmissiles(var_0C, 3);
        } else {
          thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", var_0, 3);
        }

        self.gesturekill = 1;
        incrementgestureindex(var_8);
      }
    }
  }

  if(isDefined(var_4)) {
    scripts\mp\utility::removeperk("specialty_radarblip");
    wait(0.1);
    self setclientomnvar("ui_gesture_reticle", 0);
    wait(var_4);
    scripts\mp\utility::giveperk("specialty_radarblip");
    var_9 = get_enemies_within_fov(var_6, var_7, 1);
    if(var_9.size == 0) {
      self setclientomnvar("ui_gesture_reticle", 1);
    } else {
      self setclientomnvar("ui_gesture_reticle", 2);
      foreach(var_0C in var_9) {
        thread dogesturedamage(var_0C, "iw7_g18_mpr_aon_fixed", var_0, 4);
        self.gesturekill = 1;
        incrementgestureindex(var_8);
      }
    }
  }

  wait(0.1);
  scripts\mp\utility::removeperk("specialty_radarblip");
  self setclientomnvar("ui_gesture_reticle", -1);
  wait_for_gesture_length(var_0);
  powerrecharge();
}

incrementgestureindex(var_0) {
  if(var_0 == self.gestureindex) {
    self.gestureindex++;
  }
}

wait_for_gesture_length(var_0) {
  self endon("disconnect");
  self endon("death");
  while(self isgestureplaying(var_0)) {
    scripts\engine\utility::waitframe();
  }
}

firejackalmissiles(var_0, var_1, var_2) {
  var_3 = 0;
  if(!isDefined(var_0)) {
    var_3 = 1;
  }

  var_4 = self gettagorigin("j_wrist_le");
  var_5 = self gettagorigin("j_wrist_le");
  var_6 = self gettagorigin("j_wrist_le");
  if(var_3) {
    var_7 = var_2;
    var_8 = var_7;
    var_9 = var_8;
  } else {
    var_7 = var_3 gettagorigin("j_spine4");
    var_8 = var_2 gettagorigin("j_spineupper");
    var_9 = var_1 getEye();
    var_0A = scripts\mp\utility::_magicbullet("iw7_lockon_mp", var_4, var_7, self);
    var_0A missile_settargetent(var_0, var_0 gettargetoffset());
    var_0B = scripts\mp\utility::_magicbullet("iw7_lockon_mp", var_5, var_8, self);
    var_0B missile_settargetent(var_0, var_0 gettargetoffset());
  }

  if(var_1 == 3) {
    scripts\mp\utility::_magicbullet("iw7_chargeshot_mp", var_6, var_9, self);
    return;
  }

  scripts\mp\utility::_magicbullet("iw7_glprox_mp", var_6, var_9, self);
}

getdumbfirepos(var_0) {
  var_1 = var_0 getplayerangles();
  var_1 = (clamp(var_1[0], -85, 85), var_1[1], var_1[2]);
  var_2 = anglesToForward(var_1);
  var_3 = var_0 gettagorigin("j_wrist_le");
  var_4 = vectornormalize(var_2) * 500;
  var_5 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\common\trace::ray_trace(var_3, var_3 + var_4, var_0, var_6);
  if(var_7["fraction"] < 1) {
    var_4 = vectornormalize(var_2) * 500 * var_7["fraction"];
  } else {
    var_4 = vectornormalize(var_2) * 500;
  }

  return var_3 + var_4;
}

gettargetoffset() {
  var_0 = gettargetorigin();
  return (0, 0, var_0[2] - self.origin[2]);
}

gettargetorigin() {
  var_0 = 10;
  switch (self getstance()) {
    case "crouch":
      var_0 = 15;
      break;

    case "prone":
      var_0 = 5;
      break;
  }

  var_1 = self getworldupreferenceangles();
  var_2 = anglestoup(var_1);
  var_3 = self gettagorigin("j_spinelower", 1, 1);
  var_4 = var_3 + var_2 * var_0;
  return var_4;
}

powerrecharge() {
  if(level.aonrules == 3 && self.gesturekill) {
    var_0 = "secondary";
    var_1 = scripts\mp\powers::getcurrentequipment(var_0);
    if(isDefined(var_1)) {
      scripts\mp\powers::removepower(var_1);
    }

    var_2 = randomizegesture();
  } else {
    var_2 = scripts\mp\powers::getcurrentequipment("secondary");
    scripts\mp\powers::func_D74C(var_2);
  }

  if(scripts\mp\utility::_hasperk("passive_gore")) {
    scripts\mp\utility::removeperk("passive_gore");
  }

  scripts\mp\utility::func_1C47(1);
  scripts\engine\utility::allow_offhand_weapons(1);
}

dogesturedamage(var_0, var_1, var_2, var_3) {
  if(var_2 == "ges_plyr_gesture038" || var_2 == "ges_plyr_gesture053") {
    self radiusdamage(var_0.origin + (0, 0, 40), 256, 150, 100, self, "MOD_IMPACT", "cluster_grenade_mp");
    playFX(level.mine_explode, var_0.origin + (0, 0, 40));
    playsoundatpos(var_0.origin + (0, 0, 40), "frag_grenade_explode");
    return;
  }

  if(var_2 == "ges_plyr_gesture010" || var_2 == "ges_plyr_gesture006") {
    wait(0.05);
    if(isDefined(self) && isDefined(var_0)) {
      var_0 dodamage(var_0.health + 1000, self.origin, self, self, "MOD_UNKNOWN", var_1);
      return;
    }

    return;
  }

  if(var_2 == "ges_plyr_gesture051" || var_2 == "ges_plyr_gesture041" || var_2 == "ges_plyr_gesture001") {
    var_4 = vectortoangles(var_0.origin - self.origin);
    var_5 = anglestoright(var_4);
    var_6 = vectornormalize(var_5) * 500;
    if(var_2 == "ges_plyr_gesture041" || var_2 == "ges_plyr_gesture001" && var_3 == 2 || var_2 == "ges_plyr_gesture001" && var_3 == 4) {
      var_6 = var_6 * -1;
    }

    var_0 _meth_84DC(var_6 + (0, 0, 500), 750);
  } else {
    var_0 _meth_84DC(vectornormalize(var_0.origin - self.origin) * 500 + (0, 0, 800), 750);
  }

  wait(0.05);
  if(isDefined(self) && isDefined(var_0)) {
    var_0 dodamage(var_0.health + 1000, self.origin, self, self, "MOD_CRUSH", var_1);
    return;
  }
}

get_enemies_within_fov(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  var_3 = [];
  var_4 = level.players;
  var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_4, undefined, 17, var_1, 1);
  var_6 = anglesToForward(self.angles);
  var_7 = vectornormalize(var_6) * -35;
  var_8 = 0;
  var_9 = 50;
  if(isDefined(var_0)) {
    var_9 = var_0;
  }

  foreach(var_0B in var_5) {
    if(!scripts\mp\utility::isreallyalive(var_0B)) {
      continue;
    }

    var_0C = var_0B.origin;
    var_0D = distance2d(self.origin, var_0C);
    if(var_0D < 100) {
      var_9 = 120;
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
    var_17 = self worldpointinreticle_circle(var_0B getEye(), 65, var_9);
    if(var_17) {
      var_17 = 0;
      if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B getEye(), var_14, var_16)) {
        var_17 = 1;
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B.origin, 65, var_9);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B.origin, var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_spinelower"), 65, var_9);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_spinelower"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_elbow_le"), 65, var_9);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_elbow_le"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(!var_17) {
      var_17 = self worldpointinreticle_circle(var_0B gettagorigin("j_elbow_ri"), 65, var_9);
      if(var_17) {
        var_17 = 0;
        if(scripts\common\trace::ray_trace_passed(self getEye(), var_0B gettagorigin("j_elbow_ri"), var_14, var_16)) {
          var_17 = 1;
        }
      }
    }

    if(var_17) {
      if(isDefined(var_1)) {
        var_0D = distance2d(self.origin, var_0C);
        if(var_0D < var_1) {
          var_0E = 1;
        }
      } else {
        var_0E = 1;
      }
    }

    if(var_0E && var_3.size < var_2) {
      var_3[var_3.size] = var_0B;
      var_5 = scripts\engine\utility::array_remove(var_5, var_0B);
    }

    if(var_3.size >= var_2) {
      var_8 = 1;
      break;
    }
  }

  return var_3;
}

giveextraaonperks() {
  var_0 = ["specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker", "passive_aon_perks"];
  foreach(var_2 in var_0) {
    scripts\mp\utility::giveperk(var_2);
  }
}

_meth_8114(var_0) {
  switch (var_0) {
    case "archetype_assault":
      var_0 = "assault_mp";
      break;

    case "archetype_heavy":
      var_0 = "armor_mp";
      break;

    case "archetype_scout":
      var_0 = "scout_mp";
      break;

    case "archetype_assassin":
      var_0 = "assassin_mp";
      break;

    case "archetype_engineer":
      var_0 = "engineer_mp";
      break;

    case "archetype_sniper":
      var_0 = "sniper_mp";
      break;

    default:
      if(!isDefined(level.aonrules) || level.aonrules == 0) {}

      var_0 = "assault_mp";
      break;
  }

  self setsuit(var_0 + "_classic");
  if(scripts\mp\utility::istrue(level.supportdoublejump_MAYBE)) {
    self goalflag(0, 200);
    self goal_type(0, 1800);
  }
}

onplayerconnect() {
  level endon("cancel_loadweapons");
  var_0 = 1;
  for(;;) {
    level waittill("connected", var_1);
    if(level.aonrules > 0) {
      if(var_0) {
        level notify("lethal_delay_end");
        level.var_ABBF = 0;
        level.allowkillstreaks = 0;
        var_0 = 0;
      }

      var_1.pers["class"] = "gamemode";
      var_1.pers["lastClass"] = "";
      var_1.class = var_1.pers["class"];
      var_1.lastclass = var_1.pers["lastClass"];
      var_1.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
      var_1 loadweaponsforplayer(["iw7_g18_mpr_aon_fixed", "iw7_knife_mp_aon", "iw7_knife_mp_aon2"]);
    }

    if(level.aonrules == 3) {
      var_1 thread hintnotify();
      var_1.gesturelist = [];
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture042";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture002";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture006";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture038";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture053";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture051";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture040";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture049";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture001";
      var_1.gesturelist[var_1.gesturelist.size] = "ges_plyr_gesture041";
      var_1.gesturelist = scripts\engine\utility::array_randomize(var_1.gesturelist);
      var_1.gesturelist = scripts\engine\utility::array_insert(var_1.gesturelist, "ges_plyr_gesture010", 0);
      var_1.gestureindex = 0;
    }
  }
}

hintnotify() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 1;
  var_1 = 0;
  for(;;) {
    if(var_0) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    wait(4);
    var_1++;
    if(var_1 < 3) {
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
    self iprintlnbold(&"PLATFORM_GESTURE_MODE_HINT_SLOT3");
    return;
  }

  self iprintlnbold(&"PLATFORM_GESTURE_MODE_HINT_SLOT7");
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