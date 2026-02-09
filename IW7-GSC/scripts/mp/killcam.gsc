/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killcam.gsc
*********************************************/

init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\miscKillcamItems.csv", var_0, 0);
    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp\miscKillcamItems.csv", var_0, 1);
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    level.killcammiscitems[var_2] = var_1;
    var_0++;
  }
}

setcinematiccamerastyle(var_0, var_1, var_2) {
  self setclientomnvar("cam_scene_name", var_0);
  self setclientomnvar("cam_scene_lead", var_1);
  self setclientomnvar("cam_scene_support", var_2);
}

func_7F32(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_0 == var_1 && !isagent(var_0)) {
    return undefined;
  }

  if(scripts\mp\utility::istrue(var_1.israllytrap)) {
    return var_1.killcament;
  }

  switch (var_2) {
    case "hashima_missiles_mp":
    case "sentry_shock_grenade_mp":
    case "jackal_fast_cannon_mp":
    case "sentry_shock_missile_mp":
    case "bombproj_mp":
    case "sentry_shock_mp":
    case "heli_pilot_turret_mp":
    case "iw7_c8landing_mp":
    case "super_trophy_mp":
    case "micro_turret_gun_mp":
    case "bouncingbetty_mp":
    case "player_trophy_system_mp":
    case "trophy_mp":
    case "power_exploding_drone_mp":
    case "trip_mine_mp":
    case "bomb_site_mp":
      return scripts\engine\utility::ter_op(isDefined(var_1.killcament), var_1.killcament, var_1);

    case "remote_tank_projectile_mp":
    case "jackal_turret_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "aamissile_projectile_mp":
    case "jackal_cannon_mp":
      if(isDefined(var_1.vehicle_fired_from) && isDefined(var_1.vehicle_fired_from.killcament)) {
        return var_1.vehicle_fired_from.killcament;
      } else if(isDefined(var_1.vehicle_fired_from)) {
        return var_1.vehicle_fired_from;
      }
      break;

    case "iw7_minigun_c8_mp":
    case "iw7_chargeshot_c8_mp":
    case "iw7_c8offhandshield_mp":
      if(isDefined(var_0) && isDefined(var_0.var_4BE1) && var_0.var_4BE1 == "MANUAL") {
        return undefined;
      }
      break;

    case "ball_drone_projectile_mp":
    case "ball_drone_gun_mp":
      if(isPlayer(var_0) && isDefined(var_0.balldrone) && isDefined(var_0.balldrone.turret) && isDefined(var_0.balldrone.turret.killcament)) {
        return var_0.balldrone.turret.killcament;
      }
      break;

    case "shockproj_mp":
      if(isDefined(var_0.var_B7AA.killcament)) {
        return var_0.var_B7AA.killcament;
      }
      break;

    case "artillery_mp":
    case "none":
      if((isDefined(var_1.var_336) && var_1.var_336 == "care_package") || isDefined(var_1.killcament) && var_1.classname == "script_brushmodel" || var_1.classname == "trigger_multiple" || var_1.classname == "script_model") {
        return var_1.killcament;
      }
      break;

    case "switch_blade_child_mp":
    case "drone_hive_projectile_mp":
      if(isDefined(var_0.extraeffectkillcam)) {
        return var_0.extraeffectkillcam;
      } else {
        return undefined;
      }

      break;

    case "alt_iw7_venomx_mp+venomxalt_burst":
    case "remote_turret_mp":
    case "ugv_turret_mp":
    case "remotemissile_projectile_mp":
    case "osprey_player_minigun_mp":
    case "minijackal_assault_mp":
    case "minijackal_strike_mp":
    case "venomproj_mp":
    case "iw7_venomx_mp+venomxalt_burst":
      return undefined;
  }

  if(scripts\engine\utility::isdestructibleweapon(var_2) || scripts\mp\utility::isbombsiteweapon(var_2)) {
    if(isDefined(var_1.killcament) && !var_0 scripts\mp\utility::func_24ED()) {
      return var_1.killcament;
    } else {
      return undefined;
    }
  }

  return var_1;
}

func_F76C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5.var_37CC = "unknown";
  if(isDefined(var_1) && isDefined(var_1.agent_type)) {
    if(var_1.agent_type == "dog" || var_1.agent_type == "wolf") {
      setcinematiccamerastyle("killcam_dog", var_0 getentitynumber(), var_3 getentitynumber());
      var_5.var_37CC = "killcam_dog";
    } else if(var_1.agent_type == "remote_c8") {
      setcinematiccamerastyle("killcam_rc8", var_0 getentitynumber(), var_3 getentitynumber());
      var_5.var_37CC = "killcam_rc8";
    } else {
      setcinematiccamerastyle("killcam_agent", var_0 getentitynumber(), var_3 getentitynumber());
      var_5.var_37CC = "killcam_agent";
    }

    return 1;
  } else if(isDefined(var_6) && var_6 == "nuke_mp") {
    setcinematiccamerastyle("killcam_nuke", var_3 getentitynumber(), var_3 getentitynumber());
    var_5.var_37CC = "killcam_nuke";
    return 1;
  } else if(var_4 > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  }

  return 0;
}

func_127CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_5 + var_6;
  if(isDefined(var_8) && var_9 > var_8) {
    if(var_8 < 2) {
      return;
    }

    if(var_8 - var_5 >= 1) {
      var_6 = var_8 - var_5;
    } else {
      var_6 = 1;
      var_5 = var_8 - 1;
    }

    var_9 = var_5 + var_6;
  }

  var_10 = var_5 + var_7;
  if(isDefined(var_1) && isDefined(var_1.lastspawntime)) {
    var_11 = var_1.lastspawntime;
  } else {
    var_11 = var_3.lastspawntime;
    if(isDefined(var_2.deathtime)) {
      if(gettime() - var_2.deathtime < var_6 * 1000) {
        var_6 = 1;
        var_6 = var_6 - 0.05;
        var_9 = var_5 + var_6;
      }
    }
  }

  var_12 = gettime() - var_11 / 1000;
  if(var_10 > var_12 && var_12 > var_7) {
    var_13 = var_12 - var_7;
    if(var_5 > var_13) {
      var_5 = var_13;
      var_9 = var_5 + var_6;
      var_10 = var_5 + var_7;
    }
  }

  var_14 = spawnStruct();
  var_14.var_37F1 = var_5;
  var_14.var_D6F8 = var_6;
  var_14.var_A63E = var_9;
  var_14.killcamoffset = var_10;
  return var_14;
}

func_D83E(var_0, var_1) {
  if(isDefined(var_1) && !isagent(var_1)) {
    if(isDefined(self.class)) {
      var_2 = spawnStruct();
      scripts\mp\playerlogic::getplayerassets(var_2, self.class);
      scripts\mp\playerlogic::loadplayerassets(var_2, 1);
    }

    self gettweakablelastvalue(var_1);
  }
}

killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, param_10) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  if(level.showingfinalkillcam) {
    setglobalsoundcontext("atmosphere", "killcam", 0.1);
    foreach(var_12 in level.players) {
      self playlocalsound("final_killcam_in");
      self func_82C2("killcam", "mix");
    }
  }

  if(var_2 < 0 || !isDefined(var_12)) {
    return;
  }

  level.var_C23C++;
  var_14 = 0.05 * level.var_C23C - 1;
  level.var_B4A7 = var_14;
  if(level.var_C23C > 1) {
    wait(var_14);
  }

  wait(0.05);
  level.var_C23C--;
  if(getDvar("scr_killcam_time") == "") {
    if(var_7 == "artillery_mp" || var_7 == "stealth_bomb_mp" || var_7 == "warhawk_mortar_mp") {
      var_15 = gettime() - var_4 / 1000 - var_8 - 0.1;
    } else if(var_8 == "remote_mortar_missile_mp") {
      var_15 = 6.5;
    } else if(level.showingfinalkillcam) {
      var_15 = 4 + level.var_B4A7 - var_15;
    } else if(var_8 == "apache_minigun_mp") {
      var_15 = 3;
    } else if(var_8 == "javelin_mp") {
      var_15 = 8;
    } else if(var_8 == "iw7_niagara_mp") {
      var_15 = 5;
    } else if(issubstr(var_8, "remotemissile_")) {
      var_15 = 5;
    } else if(isDefined(var_1.sentrytype) && var_1.sentrytype == "multiturret") {
      var_15 = 2;
    } else if(!var_11 || var_11 > 5) {
      var_15 = 5;
    } else if(var_8 == "frag_grenade_mp" || var_8 == "frag_grenade_short_mp" || var_8 == "semtex_mp" || var_8 == "semtexproj_mp" || var_8 == "mortar_shell__mp" || var_8 == "cluster_grenade_mp") {
      var_15 = 4.25;
    } else {
      var_15 = 2.5;
    }
  } else {
    var_15 = getdvarfloat("scr_killcam_time");
  }

  if(isDefined(var_11)) {
    if(var_15 > var_11) {
      var_15 = var_11;
    }

    if(var_15 < 0.05) {
      var_15 = 0.05;
    }
  }

  if(getDvar("scr_killcam_posttime") == "") {
    if(isDefined(var_0) && var_0 == var_12) {
      var_16 = 3.5;
    } else {
      var_16 = 2;
    }
  } else {
    var_16 = getdvarfloat("scr_killcam_posttime");
    if(var_16 < 0.05) {
      var_16 = 0.05;
    }
  }

  if(var_2 < 0 || !isDefined(var_12)) {
    return;
  }

  var_17 = func_127CF(var_0, var_1, var_12, var_13, var_3, var_15, var_16, var_8, var_11);
  if(!isDefined(var_17)) {
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  if(level.showingfinalkillcam) {
    self setclientomnvar("post_game_state", 3);
  }

  if(isPlayer(var_12)) {
    self setclientomnvar("ui_killcam_killedby_id", var_12 getentitynumber());
    self setclientomnvar("ui_killcam_victim_id", var_13 getentitynumber());
    self gettweakablelastvalue(var_12);
  }

  if(scripts\mp\utility::iskillstreakweapon(var_7)) {
    func_F76E(var_7, param_10);
  } else {
    scripts\mp\perks\perks::func_F7C5("ui_killcam_killedby_perk", var_15);
  }

  var_18 = getdvarint("scr_player_forcerespawn");
  if((var_10 && !level.gameended) || isDefined(self) && isDefined(self.battlebuddy) && !level.gameended || var_18 == 0 && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  var_19 = gettime();
  self notify("begin_killcam", var_19);
  scripts\mp\utility::updatesessionstate("spectator");
  self.clearstartpointtransients = 1;
  if(isagent(var_12) || isagent(var_0)) {
    var_2 = var_13 getentitynumber();
    var_9 = var_9 - 25;
  }

  self.missile_createrepulsorent = var_2;
  self.setclientmatchdatadef = -1;
  var_1A = func_F76C(var_0, var_1, var_2, var_13, var_3, var_17, var_7);
  if(!var_1A) {
    thread func_F76B(var_3, var_17.killcamoffset, var_4, var_5, var_6);
  }

  self.var_4A = var_17.killcamoffset;
  self.var_A63E = var_17.var_A63E;
  self.box = var_9;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  if(level.multiteambased) {
    foreach(var_1C in level.teamnamelist) {
      self allowspectateteam(var_1C, 1);
    }
  }

  thread func_6315();
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  if(self.var_4A < var_17.killcamoffset) {
    var_1E = var_17.killcamoffset - self.var_4A;
    if(game["truncated_killcams"] < 32) {
      game["truncated_killcams"]++;
    }
  }

  var_17.var_37F1 = self.var_4A - 0.05 - var_8;
  var_17.var_A63E = var_17.var_37F1 + var_17.var_D6F8;
  self.var_A63E = var_17.var_A63E;
  if(var_17.var_37F1 <= 0) {
    scripts\mp\utility::updatesessionstate("dead");
    scripts\mp\utility::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  var_1F = level.showingfinalkillcam;
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_17.var_A63E * 1000) + gettime());
  if(var_1F) {
    self setclientomnvar("ui_killcam_victim_or_attacker", 1);
  }

  if(var_1F) {
    thread scripts\mp\final_killcam::func_5854(var_17, self.setclientmatchdatadef, var_12, var_13, var_14);
  }

  self.killcam = 1;
  if(isDefined(self.battlebuddy) && !level.gameended) {
    self.var_28CD = gettime();
  }

  thread func_10855();
  if(!level.showingfinalkillcam) {
    thread func_13715(var_10);
  } else {
    self notify("showing_final_killcam");
  }

  thread func_635D();
  waittillkillcamover();
  if(level.showingfinalkillcam) {
    thread scripts\mp\playerlogic::spawnendofgame();
    return;
  }

  thread func_A639(1);
}

func_F770(var_0, var_1, var_2) {
  var_3 = getweaponbasename(var_0);
  if(!isDefined(var_3) || var_3 == "none") {
    clearkillcamattachmentomnvars();
    return;
  }

  var_4 = scripts\mp\utility::getequipmenttype(var_3);
  if(isDefined(scripts\mp\supers::func_7F0D(var_3))) {
    func_F772(var_3);
    return;
  }

  if(isDefined(var_4) && var_4 == "lethal" || var_4 == "tactical") {
    func_F771(var_3);
    return;
  }

  if(isDefined(level.killcammiscitems[var_3])) {
    func_F76F(level.killcammiscitems[var_3]);
    return;
  }

  func_F773(var_0, var_2);
}

waittillkillcamover() {
  self endon("abort_killcam");
  if(level.showingfinalkillcam) {
    thread scripts\mp\utility::setuipostgamefade(1, self.var_A63E - 0.5);
  }

  wait(self.var_A63E - 0.05);
  if(level.showingfinalkillcam) {
    setglobalsoundcontext("atmosphere", "", 0.5);
    self playlocalsound("final_killcam_out");
    self clearclienttriggeraudiozone(4);
  }
}

func_F76B(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_5 = gettime() - var_1 * 1000;
  if(var_2 > var_5) {
    wait(0.05);
    var_1 = self.var_4A;
    var_5 = gettime() - var_1 * 1000;
    if(var_2 > var_5) {
      wait(var_2 - var_5 / 1000);
    }
  }

  self.setclientmatchdatadef = var_0;
  if(isDefined(var_3)) {
    self.setclientnamemode = var_3;
  }

  if(isDefined(var_4)) {
    self func_85C4(var_4);
  }
}

func_13715(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    if(scripts\mp\killstreaks\_orbital_deployment::func_D39C("orbital_deployment")) {
      thread func_1CA0(var_0);
    }

    self waittill("kc_respawn");
    self.cancelkillcam = 1;
    if(var_0 <= 0) {
      scripts\mp\utility::clearlowermessage("kc_info");
    }

    self notify("abort_killcam");
  }
}

func_1CA0(var_0) {
  self notifyonplayercommand("orbital_deployment_action", "+attack");
  self notifyonplayercommand("orbital_deployment_action", "+attack_akimbo_accessible");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 1);
  var_1 = scripts\engine\utility::waittill_any_return("orbital_deployment_action", "spawned_player");
  if(var_1 == "spawned_player") {
    self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
    return;
  }

  self.cancelkillcam = 1;
  if(var_0 <= 0) {
    scripts\mp\utility::clearlowermessage("kc_info");
  }

  self notify("abort_killcam");
  self waittill("spawned_player");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
  var_2 = scripts\mp\killstreaks\killstreaks::missile_settargetpos("orbital_deployment");
  if(isDefined(var_2)) {
    var_3 = scripts\mp\killstreaks\killstreaks::func_7F45(var_2);
    var_3.var_98F2 = 1;
    scripts\mp\killstreaks\killstreaks::func_A69A(var_3);
  }
}

func_635D() {
  self endon("disconnect");
  self endon("killcam_ended");
  for(;;) {
    if(self.var_4A <= 0) {
      break;
    }

    wait(0.05);
  }

  self notify("abort_killcam");
}

func_10855() {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  thread func_A639(0);
}

func_6315() {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  thread func_A639(1);
}

clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  clearkillcamattachmentomnvars();
  for(var_0 = 0; var_0 < 6; var_0++) {
    self setclientomnvar("ui_killcam_killedby_perk" + var_0, -1);
  }
}

func_A639(var_0) {
  clearkillcamomnvars();
  if(level.showingfinalkillcam) {
    setomnvarforallclients("post_game_state", 1);
  }

  self.killcam = undefined;
  var_1 = level.showingfinalkillcam;
  if(!var_1) {
    setcinematiccamerastyle("unknown", -1, -1);
  }

  if(!level.gameended) {
    scripts\mp\utility::clearlowermessage("kc_info");
  }

  thread scripts\mp\spectating::setspectatepermissions();
  self notify("killcam_ended");
  if(!var_0) {
    return;
  }

  scripts\mp\utility::updatesessionstate("dead");
  scripts\mp\utility::clearkillcamstate();
}

clearlootweaponomnvars() {
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
}

clearkillcamkilledbyitemomnvars() {
  self setclientomnvar("ui_killcam_killedby_item_type", -1);
  self setclientomnvar("ui_killcam_killedby_item_id", -1);
}

setkillcamkilledbyitemomnvars(var_0, var_1) {
  self setclientomnvar("ui_killcam_killedby_item_type", var_0);
  self setclientomnvar("ui_killcam_killedby_item_id", var_1);
}

func_F773(var_0, var_1) {
  var_0 = scripts\mp\utility::func_13CA1(var_0, var_1);
  var_2 = scripts\mp\utility::getweaponrootname(var_0);
  var_3 = tablelookuprownum("mp\statsTable.csv", 4, var_2);
  if(!isDefined(var_3) || var_3 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var_4 = scripts\mp\loot::getlootinfoforweapon(var_0);
  if(isDefined(var_4)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_4.variantid);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_4.quality - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  setkillcamkilledbyitemomnvars(0, var_3);
  if(var_2 != "iw7_knife") {
    var_5 = getweaponattachments(var_0);
    if(!isDefined(var_5)) {
      var_5 = [];
    }

    var_6 = 0;
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = scripts\mp\utility::attachmentmap_tobase(var_8);
      if(scripts\mp\weapons::func_9F3C(var_2, var_9)) {
        if(var_6 >= 6) {
          break;
        }

        var_10 = tablelookuprownum("mp\attachmentTable.csv", 4, var_8);
        self setclientomnvar("ui_killcam_killedby_attachment" + var_6 + 1, var_10);
        var_6++;
      }
    }

    for(var_7 = var_6; var_7 < 6; var_7++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + var_7 + 1, -1);
    }
  }
}

func_F772(var_0) {
  var_1 = scripts\mp\supers::func_7F0D(var_0);
  setkillcamkilledbyitemomnvars(2, var_1);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76E(var_0, var_1) {
  var_2 = scripts\mp\utility::getkillstreakindex(level.killstreakweildweapons[var_0]);
  if(isDefined(var_1)) {
    var_2 = var_1.id;
    var_3 = var_1.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_2);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_3 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var_2);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

func_F771(var_0) {
  var_1 = level.var_D7A4[var_0];
  var_2 = level.powers[var_1].id;
  setkillcamkilledbyitemomnvars(3, var_2);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76F(var_0) {
  setkillcamkilledbyitemomnvars(4, var_0);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

clearkillcamattachmentomnvars() {
  for(var_0 = 0; var_0 < 6; var_0++) {
    self setclientomnvar("ui_killcam_killedby_attachment" + var_0 + 1, -1);
  }
}