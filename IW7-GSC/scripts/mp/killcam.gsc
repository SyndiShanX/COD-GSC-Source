/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killcam.gsc
**********************************/

init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp\miscKillcamItems.csv", var_00, 0);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    var_01 = int(var_01);
    var_02 = tablelookupbyrow("mp\miscKillcamItems.csv", var_00, 1);
    if(!isDefined(var_02) || var_02 == "") {
      break;
    }

    level.killcammiscitems[var_02] = var_01;
    var_00++;
  }
}

setcinematiccamerastyle(param_00, param_01, param_02) {
  self setclientomnvar("cam_scene_name", param_00);
  self setclientomnvar("cam_scene_lead", param_01);
  self setclientomnvar("cam_scene_support", param_02);
}

func_7F32(param_00, param_01, param_02) {
  if(!isDefined(param_00) || !isDefined(param_01) || param_00 == param_01 && !isagent(param_00)) {
    return undefined;
  }

  if(scripts\mp\utility::istrue(param_01.israllytrap)) {
    return param_01.killcament;
  }

  switch (param_02) {
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
      return scripts\engine\utility::ter_op(isDefined(param_01.killcament), param_01.killcament, param_01);

    case "remote_tank_projectile_mp":
    case "jackal_turret_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "aamissile_projectile_mp":
    case "jackal_cannon_mp":
      if(isDefined(param_01.vehicle_fired_from) && isDefined(param_01.vehicle_fired_from.killcament)) {
        return param_01.vehicle_fired_from.killcament;
      } else if(isDefined(param_01.vehicle_fired_from)) {
        return param_01.vehicle_fired_from;
      }
      break;

    case "iw7_minigun_c8_mp":
    case "iw7_chargeshot_c8_mp":
    case "iw7_c8offhandshield_mp":
      if(isDefined(param_00) && isDefined(param_00.var_4BE1) && param_00.var_4BE1 == "MANUAL") {
        return undefined;
      }
      break;

    case "ball_drone_projectile_mp":
    case "ball_drone_gun_mp":
      if(isplayer(param_00) && isDefined(param_00.balldrone) && isDefined(param_00.balldrone.turret) && isDefined(param_00.balldrone.turret.killcament)) {
        return param_00.balldrone.turret.killcament;
      }
      break;

    case "shockproj_mp":
      if(isDefined(param_00.var_B7AA.killcament)) {
        return param_00.var_B7AA.killcament;
      }
      break;

    case "artillery_mp":
    case "none":
      if((isDefined(param_01.var_336) && param_01.var_336 == "care_package") || isDefined(param_01.killcament) && param_01.classname == "script_brushmodel" || param_01.classname == "trigger_multiple" || param_01.classname == "script_model") {
        return param_01.killcament;
      }
      break;

    case "switch_blade_child_mp":
    case "drone_hive_projectile_mp":
      if(isDefined(param_00.extraeffectkillcam)) {
        return param_00.extraeffectkillcam;
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

  if(scripts\engine\utility::isdestructibleweapon(param_02) || scripts\mp\utility::isbombsiteweapon(param_02)) {
    if(isDefined(param_01.killcament) && !param_00 scripts\mp\utility::func_24ED()) {
      return param_01.killcament;
    } else {
      return undefined;
    }
  }

  return param_01;
}

func_F76C(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_05.var_37CC = "unknown";
  if(isDefined(param_01) && isDefined(param_01.agent_type)) {
    if(param_01.agent_type == "dog" || param_01.agent_type == "wolf") {
      setcinematiccamerastyle("killcam_dog", param_00 getentitynumber(), param_03 getentitynumber());
      param_05.var_37CC = "killcam_dog";
    } else if(param_01.agent_type == "remote_c8") {
      setcinematiccamerastyle("killcam_rc8", param_00 getentitynumber(), param_03 getentitynumber());
      param_05.var_37CC = "killcam_rc8";
    } else {
      setcinematiccamerastyle("killcam_agent", param_00 getentitynumber(), param_03 getentitynumber());
      param_05.var_37CC = "killcam_agent";
    }

    return 1;
  } else if(isDefined(param_06) && param_06 == "nuke_mp") {
    setcinematiccamerastyle("killcam_nuke", param_03 getentitynumber(), param_03 getentitynumber());
    param_05.var_37CC = "killcam_nuke";
    return 1;
  } else if(param_04 > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  }

  return 0;
}

func_127CF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = param_05 + param_06;
  if(isDefined(param_08) && var_09 > param_08) {
    if(param_08 < 2) {
      return;
    }

    if(param_08 - param_05 >= 1) {
      param_06 = param_08 - param_05;
    } else {
      param_06 = 1;
      param_05 = param_08 - 1;
    }

    var_09 = param_05 + param_06;
  }

  var_0A = param_05 + param_07;
  if(isDefined(param_01) && isDefined(param_01.lastspawntime)) {
    var_0B = param_01.lastspawntime;
  } else {
    var_0B = param_03.lastspawntime;
    if(isDefined(param_02.deathtime)) {
      if(gettime() - param_02.deathtime < param_06 * 1000) {
        param_06 = 1;
        param_06 = param_06 - 0.05;
        var_09 = param_05 + param_06;
      }
    }
  }

  var_0C = gettime() - var_0B / 1000;
  if(var_0A > var_0C && var_0C > param_07) {
    var_0D = var_0C - param_07;
    if(param_05 > var_0D) {
      param_05 = var_0D;
      var_09 = param_05 + param_06;
      var_0A = param_05 + param_07;
    }
  }

  var_0E = spawnStruct();
  var_0E.var_37F1 = param_05;
  var_0E.var_D6F8 = param_06;
  var_0E.var_A63E = var_09;
  var_0E.killcamoffset = var_0A;
  return var_0E;
}

func_D83E(param_00, param_01) {
  if(isDefined(param_01) && !isagent(param_01)) {
    if(isDefined(self.class)) {
      var_02 = spawnStruct();
      scripts\mp\playerlogic::getplayerassets(var_02, self.class);
      scripts\mp\playerlogic::loadplayerassets(var_02, 1);
    }

    self gettweakablelastvalue(param_01);
  }
}

killcam(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  if(level.showingfinalkillcam) {
    setglobalsoundcontext("atmosphere", "killcam", 0.1);
    foreach(var_12 in level.players) {
      self playlocalsound("final_killcam_in");
      self _meth_82C2("killcam", "mix");
    }
  }

  if(param_02 < 0 || !isDefined(param_0C)) {
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
  if(getdvar("scr_killcam_time") == "") {
    if(param_07 == "artillery_mp" || param_07 == "stealth_bomb_mp" || param_07 == "warhawk_mortar_mp") {
      var_15 = gettime() - param_04 / 1000 - param_08 - 0.1;
    } else if(param_08 == "remote_mortar_missile_mp") {
      var_15 = 6.5;
    } else if(level.showingfinalkillcam) {
      var_15 = 4 + level.var_B4A7 - var_15;
    } else if(param_08 == "apache_minigun_mp") {
      var_15 = 3;
    } else if(param_08 == "javelin_mp") {
      var_15 = 8;
    } else if(param_08 == "iw7_niagara_mp") {
      var_15 = 5;
    } else if(issubstr(param_08, "remotemissile_")) {
      var_15 = 5;
    } else if(isDefined(param_01.sentrytype) && param_01.sentrytype == "multiturret") {
      var_15 = 2;
    } else if(!param_0B || param_0B > 5) {
      var_15 = 5;
    } else if(param_08 == "frag_grenade_mp" || param_08 == "frag_grenade_short_mp" || param_08 == "semtex_mp" || param_08 == "semtexproj_mp" || param_08 == "mortar_shell__mp" || param_08 == "cluster_grenade_mp") {
      var_15 = 4.25;
    } else {
      var_15 = 2.5;
    }
  } else {
    var_15 = getdvarfloat("scr_killcam_time");
  }

  if(isDefined(param_0B)) {
    if(var_15 > param_0B) {
      var_15 = param_0B;
    }

    if(var_15 < 0.05) {
      var_15 = 0.05;
    }
  }

  if(getdvar("scr_killcam_posttime") == "") {
    if(isDefined(param_00) && param_00 == param_0C) {
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

  if(param_02 < 0 || !isDefined(param_0C)) {
    return;
  }

  var_17 = func_127CF(param_00, param_01, param_0C, param_0D, param_03, var_15, var_16, param_08, param_0B);
  if(!isDefined(var_17)) {
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  if(level.showingfinalkillcam) {
    self setclientomnvar("post_game_state", 3);
  }

  if(isplayer(param_0C)) {
    self setclientomnvar("ui_killcam_killedby_id", param_0C getentitynumber());
    self setclientomnvar("ui_killcam_victim_id", param_0D getentitynumber());
    self gettweakablelastvalue(param_0C);
  }

  if(scripts\mp\utility::iskillstreakweapon(param_07)) {
    func_F76E(param_07, param_10);
  } else {
    scripts\mp\perks\_perks::func_F7C5("ui_killcam_killedby_perk", param_0F);
  }

  var_18 = getdvarint("scr_player_forcerespawn");
  if((param_0A && !level.gameended) || isDefined(self) && isDefined(self.battlebuddy) && !level.gameended || var_18 == 0 && !level.gameended) {
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
  if(isagent(param_0C) || isagent(param_00)) {
    param_02 = param_0D getentitynumber();
    param_09 = param_09 - 25;
  }

  self.missile_createrepulsorent = param_02;
  self.setclientmatchdatadef = -1;
  var_1A = func_F76C(param_00, param_01, param_02, param_0D, param_03, var_17, param_07);
  if(!var_1A) {
    thread func_F76B(param_03, var_17.killcamoffset, param_04, param_05, param_06);
  }

  self.var_4A = var_17.killcamoffset;
  self.var_A63E = var_17.var_A63E;
  self.box = param_09;
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

  var_17.var_37F1 = self.var_4A - 0.05 - param_08;
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
    thread scripts\mp\final_killcam::func_5854(var_17, self.setclientmatchdatadef, param_0C, param_0D, param_0E);
  }

  self.killcam = 1;
  if(isDefined(self.battlebuddy) && !level.gameended) {
    self.var_28CD = gettime();
  }

  thread func_10855();
  if(!level.showingfinalkillcam) {
    thread func_13715(param_0A);
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

func_F770(param_00, param_01, param_02) {
  var_03 = getweaponbasename(param_00);
  if(!isDefined(var_03) || var_03 == "none") {
    clearkillcamattachmentomnvars();
    return;
  }

  var_04 = scripts\mp\utility::getequipmenttype(var_03);
  if(isDefined(scripts\mp\supers::func_7F0D(var_03))) {
    func_F772(var_03);
    return;
  }

  if(isDefined(var_04) && var_04 == "lethal" || var_04 == "tactical") {
    func_F771(var_03);
    return;
  }

  if(isDefined(level.killcammiscitems[var_03])) {
    func_F76F(level.killcammiscitems[var_03]);
    return;
  }

  func_F773(param_00, param_02);
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

func_F76B(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_05 = gettime() - param_01 * 1000;
  if(param_02 > var_05) {
    wait(0.05);
    param_01 = self.var_4A;
    var_05 = gettime() - param_01 * 1000;
    if(param_02 > var_05) {
      wait(param_02 - var_05 / 1000);
    }
  }

  self.setclientmatchdatadef = param_00;
  if(isDefined(param_03)) {
    self.setclientnamemode = param_03;
  }

  if(isDefined(param_04)) {
    self _meth_85C4(param_04);
  }
}

func_13715(param_00) {
  self endon("disconnect");
  self endon("killcam_ended");
  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    if(scripts\mp\killstreaks\_orbital_deployment::func_D39C("orbital_deployment")) {
      thread func_1CA0(param_00);
    }

    self waittill("kc_respawn");
    self.cancelkillcam = 1;
    if(param_00 <= 0) {
      scripts\mp\utility::clearlowermessage("kc_info");
    }

    self notify("abort_killcam");
  }
}

func_1CA0(param_00) {
  self notifyonplayercommand("orbital_deployment_action", "+attack");
  self notifyonplayercommand("orbital_deployment_action", "+attack_akimbo_accessible");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 1);
  var_01 = scripts\engine\utility::waittill_any_return("orbital_deployment_action", "spawned_player");
  if(var_01 == "spawned_player") {
    self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
    return;
  }

  self.cancelkillcam = 1;
  if(param_00 <= 0) {
    scripts\mp\utility::clearlowermessage("kc_info");
  }

  self notify("abort_killcam");
  self waittill("spawned_player");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
  var_02 = scripts\mp\killstreaks\_killstreaks::missile_settargetpos("orbital_deployment");
  if(isDefined(var_02)) {
    var_03 = scripts\mp\killstreaks\_killstreaks::func_7F45(var_02);
    var_03.var_98F2 = 1;
    scripts\mp\killstreaks\_killstreaks::func_A69A(var_03);
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
  for(var_00 = 0; var_00 < 6; var_00++) {
    self setclientomnvar("ui_killcam_killedby_perk" + var_00, -1);
  }
}

func_A639(param_00) {
  clearkillcamomnvars();
  if(level.showingfinalkillcam) {
    setomnvarforallclients("post_game_state", 1);
  }

  self.killcam = undefined;
  var_01 = level.showingfinalkillcam;
  if(!var_01) {
    setcinematiccamerastyle("unknown", -1, -1);
  }

  if(!level.gameended) {
    scripts\mp\utility::clearlowermessage("kc_info");
  }

  thread scripts\mp\spectating::setspectatepermissions();
  self notify("killcam_ended");
  if(!param_00) {
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

setkillcamkilledbyitemomnvars(param_00, param_01) {
  self setclientomnvar("ui_killcam_killedby_item_type", param_00);
  self setclientomnvar("ui_killcam_killedby_item_id", param_01);
}

func_F773(param_00, param_01) {
  param_00 = scripts\mp\utility::func_13CA1(param_00, param_01);
  var_02 = scripts\mp\utility::getweaponrootname(param_00);
  var_03 = tablelookuprownum("mp\statsTable.csv", 4, var_02);
  if(!isDefined(var_03) || var_03 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var_04 = scripts\mp\loot::getlootinfoforweapon(param_00);
  if(isDefined(var_04)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_04.variantid);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_04.quality - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  setkillcamkilledbyitemomnvars(0, var_03);
  if(var_02 != "iw7_knife") {
    var_05 = getweaponattachments(param_00);
    if(!isDefined(var_05)) {
      var_05 = [];
    }

    var_06 = 0;
    for(var_07 = 0; var_07 < var_05.size; var_07++) {
      var_08 = var_05[var_07];
      var_09 = scripts\mp\utility::attachmentmap_tobase(var_08);
      if(scripts\mp\weapons::func_9F3C(var_02, var_09)) {
        if(var_06 >= 6) {
          break;
        }

        var_0A = tablelookuprownum("mp\attachmentTable.csv", 4, var_08);
        self setclientomnvar("ui_killcam_killedby_attachment" + var_06 + 1, var_0A);
        var_06++;
      }
    }

    for(var_07 = var_06; var_07 < 6; var_07++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + var_07 + 1, -1);
    }
  }
}

func_F772(param_00) {
  var_01 = scripts\mp\supers::func_7F0D(param_00);
  setkillcamkilledbyitemomnvars(2, var_01);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76E(param_00, param_01) {
  var_02 = scripts\mp\utility::getkillstreakindex(level.killstreakweildweapons[param_00]);
  if(isDefined(param_01)) {
    var_02 = param_01.id;
    var_03 = param_01.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_02);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_03 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var_02);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

func_F771(param_00) {
  var_01 = level.var_D7A4[param_00];
  var_02 = level.powers[var_01].id;
  setkillcamkilledbyitemomnvars(3, var_02);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76F(param_00) {
  setkillcamkilledbyitemomnvars(4, param_00);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

clearkillcamattachmentomnvars() {
  for(var_00 = 0; var_00 < 6; var_00++) {
    self setclientomnvar("ui_killcam_killedby_attachment" + var_00 + 1, -1);
  }
}