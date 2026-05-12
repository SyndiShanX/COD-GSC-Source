/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_wallbuys_shattered.gsc
***********************************************************/

override_wall_buys_by_class() {
  level.active_zombie_models_to_outline = [];
  level.plr_custom_on_scoreboard_open_func = ::show_wallbuy_waypoints;
  level.plr_custom_on_scoreboard_off_func = ::hide_wallbuy_waypoints;
  while(!isDefined(level.var_A7DE)) {
    wait 0.05;
  }

  if(!isDefined(level.rand_wallbuys)) {
    level.rand_wallbuys = [];
  }

  var_00 = function_021F("wallbuy_lgt", "targetname");
  foreach(var_02 in level.var_A7DE) {
    if(isDefined(var_02.var_81C7) && var_02.var_81C7 == "rand_wallbuy") {
      level.rand_wallbuys = common_scripts\utility::func_F6F(level.rand_wallbuys, var_02);
      var_03 = common_scripts\utility::func_4461(var_02.var_116, var_00);
      if(isDefined(var_03)) {
        var_02.scriptable_light = var_03;
      }

      foreach(var_05 in var_02.var_A7E3) {
        var_05.weapon_class = lib_0547::zm_get_weapon_class(var_02.var_165);
        var_02.weapon_class = var_05.weapon_class;
        level.active_zombie_models_to_outline = common_scripts\utility::func_F6F(level.active_zombie_models_to_outline, var_05);
      }

      var_02 thread run_wallbuy_mysterybox_mod();
    }
  }

  var_08 = getEntArray("shattered_wallbuy_model", "targetname");
  level.active_zombie_models_to_outline = common_scripts\utility::func_F73(level.active_zombie_models_to_outline, var_08);
}

show_wallbuy_waypoints(param_00) {
  if(isDefined(param_00.pingingwaypoints)) {
    param_00.pingingwaypoints = common_scripts\utility::func_FA0(param_00.pingingwaypoints);
    foreach(var_02 in param_00.pingingwaypoints) {
      if(!waypoint_exists(var_02)) {
        continue;
      }

      param_00.pingingwaypoints = common_scripts\utility::func_F93(param_00.pingingwaypoints, var_02);
      var_02 destroy();
    }
  }

  foreach(var_05 in level.active_zombie_models_to_outline) {
    if(!isDefined(var_05.weapon_class)) {
      var_06 = common_scripts\utility::func_40B0(var_05.var_116, level.active_zombie_models_to_outline);
      foreach(var_08 in var_06) {
        if(isDefined(var_08.weapon_class)) {
          var_05.weapon_class = var_08.weapon_class;
          var_05.no_waypoint = 1;
          break;
        }
      }
    }

    if(!weapon_class_available(var_05.weapon_class)) {
      continue;
    }

    var_05 hudoutlineenableforclient(param_00, 0, 0);
    if(!isDefined(var_05.no_waypoint)) {
      continue;
    }

    var_02 = newclienthudelem(param_00);
    var_02 setshader(level.zombies_shotgun_weapon_waypoints[var_05.weapon_class], 1, 1);
    var_02.var_18 = 1;
    var_02.var_18 = 1;
    var_02.var_56 = (1, 1, 1);
    var_02.maxsightdistsqrd = var_05.var_116[0];
    var_02.var_1D7 = var_05.var_116[1];
    var_02.var_1D9 = var_05.var_116[2] + 35;
    var_02 setwaypoint(0, 0, 0);
    if(!isDefined(param_00.shwaypoints)) {
      param_00.shwaypoints = [];
    }

    param_00.shwaypoints = common_scripts\utility::func_F6F(param_00.shwaypoints, var_02);
    var_05.var_A98D = var_02;
  }
}

hide_wallbuy_waypoints(param_00) {
  foreach(var_02 in level.active_zombie_models_to_outline) {
    if(isDefined(var_02.var_A98D) && !function_0279(var_02.var_A98D)) {
      var_02.var_A98D destroy();
    }

    var_02 hudoutlinedisableforclient(param_00);
  }

  if(isDefined(param_00.shwaypoints)) {
    foreach(var_05 in param_00.shwaypoints) {
      if(isDefined(var_05) && !function_0279(var_05)) {
        var_05 destroy();
      }
    }
  }

  param_00.shwaypoints = [];
}

run_wallbuy_mysterybox_mod() {
  foreach(var_01 in self.var_A7E9) {
    var_01.wallbuy = self;
    lib_0547::func_8A4F(var_01, ::assignwallbuymysterypurchasetoplayer, ::func_4D1B);
  }

  var_03 = lib_0547::zm_get_weapon_class(self.var_165);
  if(isDefined(self.wallbuyguncard)) {
    var_04 = get_wallbuy_gun_card_model(var_03);
    if(isDefined(var_04)) {
      self.wallbuyguncard setModel(var_04);
    }
  }

  var_05 = get_current_weapon_level(var_03);
  var_06 = var_05[0];
  var_07 = var_05[1];
  var_08 = var_05[2];
  var_09 = var_07;
  self.requiredbuildmaterials = var_08;
  foreach(var_01 in self.var_A7E9) {
    var_01.var_267B = var_07;
    var_01.wallbuy.var_A9A5 = var_09;
    var_01.requiredbuildmaterials = var_08;
    var_01 thread watch_for_player_purchase();
    var_01 thread run_wallbuy_trigger_mysterybox_mod(var_06, var_03);
  }
}

setwallbuyitements(param_00, param_01, param_02) {
  if(!isDefined(param_01.var_586E)) {
    var_03 = replace_wallbuy_weapon(param_01, param_02);
    var_03 method_86B3(0);
    param_01.var_586E = var_03;
    param_01.itementlink = param_00;
  } else {
    param_01.var_586E method_848E(param_02);
  }

  param_01.var_586E.var_A9E0 = param_02;
  param_01.var_586E makeunusable();
  param_01.var_586E method_8511();
}

slide_left() {
  var_00 = 0;
  switch (self.var_A9E0) {
    case "m1a1_zm":
      var_00 = -3;
      break;

    case "p38_zm":
      var_00 = 4;
      break;

    case "g43_zm":
      var_00 = -3.5;
      break;

    case "m1911_zm":
      var_00 = 0;
      break;

    case "model21_zm":
      var_00 = 3;
      break;

    case "luger_zm":
      var_00 = 2;
      break;

    case "m30_zm":
      var_00 = -5;
      break;

    case "k98_zm":
      var_00 = -5;
      break;

    case "reich_zm":
      var_00 = 3;
      break;

    case "enfieldno2_zm":
      var_00 = 5;
      break;

    case "svt40_zm":
      var_00 = -5;
      break;

    case "m712_zm":
      var_00 = 2;
      break;
  }

  var_01 = self.var_116;
  self.var_116 = self.var_116 + var_00 * vectornormalize(anglesToForward(self.var_1D));
}

run_wallbuy_trigger_mysterybox_mod(param_00, param_01) {
  var_02 = self;
  var_03 = "";
  var_04 = undefined;
  var_05 = undefined;
  var_06 = spawn("script_model", var_02.var_A9E3);
  var_06 setModel("tag_origin");
  var_06 thread watch_player_consumable_usage(var_02);
  var_07 = common_scripts\utility::func_F92(param_00);
  var_08 = 0;
  var_09 = maps\mp\gametypes\_class::func_1D66("ppsh41_classic_zm", "extended_mag");
  for(;;) {
    if(param_01 == "weapon_smg" && common_scripts\utility::func_3C77("shotgun_classic_add_to_box")) {
      if(!common_scripts\utility::func_F79(var_07, var_09)) {
        var_0A = randomintrange(1, 4);
        var_07 = common_scripts\utility::func_F86(var_07, var_09, var_08 + var_0A);
      }

      var_0B = 1;
    }

    var_03 = var_07[var_08];
    if(isDefined(getDvar("testingWallBuyWeap")) && getDvar("testingWallBuyWeap") != "") {
      var_03 = getDvar("testingWallBuyWeap");
    }

    var_02.var_6C5C = var_03;
    var_08++;
    if(var_08 >= var_07.size) {
      var_08 = 0;
    }

    var_0C = var_03;
    if(isDefined(var_02.lastclaimedplayer) && isPlayer(var_02.lastclaimedplayer)) {
      if(var_02.lastclaimedplayer lib_0579::func_4BA5()) {
        var_03 = var_02.lastclaimedplayer.var_A99B;
      }

      var_0C = maps\mp\zombies\_zombies_magicbox::func_454B(var_02.lastclaimedplayer, var_03);
    }

    setwallbuyitements(var_06, var_02, var_0C);
    var_02.var_A9E0 = var_0C;
    var_02 waittill("mystery_wallbuy_used", var_0D);
    var_03 = var_02.var_586E.var_A9E0;
    var_0C = var_03;
    playFX(level.var_611["zmb_mystery_box_gun_gk"], var_02.var_A9E3);
    level.var_11CB.var_65F4 = lib_0380::func_2889("zmb_mystery_box_elec", undefined, var_02.var_A9E3);
    var_02.var_586E showtoclient(var_0D);
    if(!isDefined(var_02.var_586E.var_6C4E)) {
      var_02.var_586E.var_6C4E = var_02.var_586E.var_116;
    }

    if(!isDefined(var_02.itementlink.var_6C4E)) {
      var_02.itementlink.var_6C4E = var_02.itementlink.var_116;
    }

    var_02.var_586E.var_116 = var_02.var_586E.var_6C4E;
    var_02.itementlink.var_116 = var_02.itementlink.var_6C4E;
    var_02.var_586E unlink();
    var_02.var_586E slide_left();
    var_02.var_586E method_8449(var_02.itementlink);
    var_0E = var_02.var_A9E3 + 6 * vectornormalize(anglestoright(var_02.var_A9BD));
    var_02.itementlink moveto(var_0E, 0.15);
    wait(0.25);
    if(var_0D lib_0579::func_4BA5()) {
      var_0D lib_0579::func_A246();
    }

    if(lib_0547::func_585C(var_0C)) {
      maps\mp\zombies\_zombies_magicbox::func_A7D5(var_0D, var_0C);
    } else {
      maps\mp\zombies\_zombies_magicbox::func_A7D6(var_0D, var_0C);
    }

    if(!common_scripts\utility::func_562E(var_0D.var_4B72)) {
      if(randomint(100) < level.zmb_shotgun_jack_in_box_odds) {
        level.zmb_shotgun_jack_in_box_odds_add_per_spin = 0;
        level.zmb_shotgun_jack_in_box_odds = 8;
        var_0D lib_057D::func_4766();
        var_0D thread maps\mp\gametypes\_hud_message::func_9102("zm_collectible_splash_jitb");
      } else {
        level.zmb_shotgun_jack_in_box_odds = level.zmb_shotgun_jack_in_box_odds + int(level.zmb_shotgun_jack_in_box_odds_add_per_spin * get_wallbuy_jack_multiplier(param_01));
      }
    }

    var_02.var_586E method_8511();
    if(!common_scripts\utility::func_562E(var_02.onceonly)) {
      var_02 wallbuymysterygatebuycycle();
    } else {
      wait 0.05;
    }

    var_02 notify("mystery_wallbuy_done");
  }

  if(isDefined(var_02.itementlink)) {
    var_02.itementlink delete();
  }
}

get_wallbuy_jack_multiplier(param_00) {
  var_01 = 1;
  switch (param_00) {
    case "weapon_heavy":
      var_01 = 5;
      break;

    case "weapon_assault":
      var_01 = 4;
      break;

    case "weapon_shotgun":
      var_01 = 3;
      break;

    case "weapon_sniper":
      var_01 = 4.25;
      break;

    case "weapon_smg":
      var_01 = 3;
      break;
  }

  return var_01;
}

watch_player_consumable_usage(param_00) {
  var_01 = self;
  var_01 endon("death");
  for(;;) {
    param_00 waittill("modify_wallbuy_data", var_02);
    param_00.var_65DC.var_401E = param_00 getwallbuytriggercost(var_02);
    param_00.var_65DC.var_6642 = 1;
    var_03 = param_00.var_6C5C;
    if(var_02 lib_0579::func_4BA5()) {
      var_03 = var_02.var_A99B;
    }

    var_03 = maps\mp\zombies\_zombies_magicbox::func_454B(var_02, var_03);
    setwallbuyitements(var_01, param_00, var_03);
  }
}

weapon_class_available(param_00) {
  return level.wallbuymaterials >= level.zombies_shotgun_weapons_level[param_00];
}

replace_wallbuy_weapon(param_00, param_01) {
  var_02 = param_00.var_A9E3;
  var_03 = (0, 0, 0);
  if(isDefined(param_00.var_A9BD)) {
    var_03 = param_00.var_A9BD;
  }

  var_04 = spawn("weapon_" + param_01, var_02, 1);
  var_04.var_1D = var_03;
  return var_04;
}

showwaywallbuypointping(param_00) {
  var_01 = self;
  var_02 = newclienthudelem(var_01);
  if(!isDefined(var_01.pingingwaypoints)) {
    var_01.pingingwaypoints = [];
  }

  var_01.pingingwaypoints = common_scripts\utility::func_FA0(var_01.pingingwaypoints);
  var_01.pingingwaypoints = common_scripts\utility::func_F6F(var_01.pingingwaypoints, var_02);
  var_03 = param_00.weap_origin;
  var_04 = param_00.weap_class;
  if(isDefined(var_04)) {
    var_02 setshader(level.zombies_shotgun_weapon_waypoints[var_04], 1, 1);
  } else {
    var_02 setshader(level.zmb_sg_wallbuy_waypoint_icon, 1, 1);
  }

  var_02.var_18 = 0;
  var_02.var_56 = (1, 1, 1);
  var_02.maxsightdistsqrd = var_03[0];
  var_02.var_1D7 = var_03[1];
  var_02.var_1D9 = var_03[2] + 15;
  var_02 setwaypoint(0, 1, 0);
  var_02 fadeovertime(0.1);
  var_02.var_18 = 1;
  wait(2);
  if(!waypoint_exists(var_02)) {
    return;
  }

  var_02 setwaypoint(0, 0, 0);
  wait(6);
  if(!waypoint_exists(var_02)) {
    return;
  }

  var_02 fadeovertime(2);
  var_02.var_18 = 0;
  wait(2);
  if(waypoint_exists(var_02)) {
    var_02 destroy();
  }
}

waypoint_exists(param_00) {
  return isDefined(param_00) && !function_0279(param_00);
}

spend_wallbuy_materials() {
  level notify("build_materials_updated");
  level.wallbuymaterials--;
}

give_wallbuy_materials() {
  level.grant_new_weapons = 0;
  level notify("build_materials_updated");
  level.wallbuymaterials++;
  broadcast_and_unlock_available_weapon_wallbuys();
}

broadcast_and_unlock_available_weapon_wallbuys() {
  foreach(var_01 in level.sg_wallbuyclasses) {
    if(level.wallbuymaterials > 1 && level.wallbuymaterials == level.zombies_shotgun_weapons_level[var_01]) {
      level thread maps\mp\_utility::func_6F74(::maps\mp\gametypes\_hud_message::func_9102, level.zombies_shotgun_weapons_splashes[var_01]);
    }
  }

  unlock_new_wallbuys();
}

hidewallbuymysterypurchasefromotherplayer(param_00) {}

set_prompt_data_needs_refresh() {
  var_00 = level.var_ABD1;
  for(var_01 = 0; var_01 < 4; var_01++) {
    if(var_00[var_01] is_valid_prompt()) {
      var_00[var_01].var_2903.var_9FD3.var_6642 = 1;
    }
  }

  var_00 = level.var_AC0C;
  for(var_01 = 0; var_01 < 4; var_01++) {
    if(var_00[var_01] is_valid_prompt()) {
      var_00[var_01].var_2903.var_9FD3.var_6642 = 1;
    }
  }
}

is_valid_prompt() {
  var_00 = self;
  return isDefined(var_00) && isDefined(var_00.var_2903);
}

unlock_new_wallbuys() {
  foreach(var_01 in level.rand_wallbuys) {
    if(var_01.weapon_class != "weapon_smg" && var_01.weapon_class != "weapon_pistol" && !common_scripts\utility::func_562E(var_01.hasshownwaypoint) && var_01 players_have_required_build_materials()) {
      var_01.hasshownwaypoint = 1;
      var_02 = spawnStruct();
      var_02.weap_origin = var_01.var_A7E9[0].var_A9E3;
      var_02.weap_class = var_01.weapon_class;
      level thread maps\mp\_utility::func_6F74(::showwaywallbuypointping, var_02);
    }
  }
}

func_4D1B(param_00) {
  self.var_82EF hidefromclient(param_00);
}

getwallbuytriggercost(param_00) {
  if(maps\mp\_utility::func_3FA0("fire_sale")) {
    return int(10);
  }

  var_01 = 1000;
  if(isDefined(self.var_267B)) {
    var_01 = self.var_267B;
  }

  if(isPlayer(param_00) && param_00 lib_0573::func_4B7B()) {
    var_01 = var_01 - param_00.var_65EC.flatdiscount;
  }

  if(isPlayer(param_00) && param_00 lib_0577::func_4B95()) {
    var_01 = var_01 - param_00.var_8C71.flatdiscount;
  }

  if(var_01 < 0) {
    var_01 = 0;
  }

  return int(var_01);
}

should_run_buildable_logic(param_00) {
  return common_scripts\utility::func_562E(level.buildablewallbuys) && common_scripts\utility::func_F79(level.validbuildablewallbuys, lib_0547::zm_get_weapon_class(param_00.var_165));
}

watch_for_player_purchase() {
  for(;;) {
    var_00 = get_use_player();
    var_01 = getwallbuytriggercost(var_00);
    if(common_scripts\utility::func_562E(self.progressblocked)) {
      lib_0555::func_83DD("dlc3_progress_hint", var_00);
      continue;
    }

    if(!var_00 maps\mp\gametypes\zombies::func_1F32(var_01) || !common_scripts\utility::func_562E(self.canusewb)) {
      continue;
    }

    if(!var_00 maps\mp\gametypes\zombies::func_11C2(var_01)) {
      var_00 thread lib_054E::func_695("needmoney");
      continue;
    } else {
      self notify("mystery_wallbuy_used", var_00);
      self.canusewb = 0;
      if(maps\mp\_utility::func_3FA0("fire_sale")) {
        continue;
      }

      var_00 lib_0573::func_A21E();
    }
  }
}

get_wallbuy_gun_card_model(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "weapon_heavy":
      var_01 = "zmd_wallbuy_cards_01_lmg";
      break;

    case "weapon_assault":
      var_01 = "zmd_wallbuy_cards_01_assault";
      break;

    case "weapon_shotgun":
      var_01 = "zmd_wallbuy_cards_01_shotgun";
      break;

    case "weapon_sniper":
      var_01 = "zmd_wallbuy_cards_01_sniper";
      break;

    case "weapon_smg":
      var_01 = "zmd_wallbuy_cards_01_smg";
      break;

    case "weapon_pistol":
      var_01 = "zmd_wallbuy_cards_01_starter";
      break;
  }

  return var_01;
}

get_weapon_from_trigger_data(param_00, param_01) {
  return maps\mp\zombies\_zombies_magicbox::func_454B(param_00, param_01.var_6C5C);
}

get_wallbuy_class_friendly_name(param_00) {
  var_01 = "";
  switch (param_00) {
    case "weapon_heavy":
      var_01 = "LMG";
      break;

    case "weapon_assault":
      var_01 = "Rifle";
      break;

    case "weapon_shotgun":
      var_01 = "Shotgun";
      break;

    case "weapon_sniper":
      var_01 = "Sniper Rifle";
      break;

    case "weapon_smg":
      var_01 = "SMG";
      break;

    case "weapon_pistol":
      var_01 = "Pistol";
      break;

    case "weapon_projectile":
      var_01 = "Launcher";
      break;
  }

  return var_01;
}

get_current_weapon_level(param_00) {
  var_01 = get_weapons_by_class(param_00);
  var_02 = level.zombies_shotgun_weapons_cost[param_00];
  var_03 = level.zombies_shotgun_weapons_level[param_00];
  return [var_01, var_02, var_03];
}

get_weapons_by_class(param_00) {
  return common_scripts\utility::func_F92(level.zombies_shotgun_weapons_in_play[param_00]);
}

get_use_player() {
  self waittill("trigger", var_00);
  return var_00;
}

re_enabble_hammer() {
  wait 0.05;
  self method_8323();
}

start_hammer() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = var_00 getweaponslistprimaries();
  var_02 = var_00 getcurrentweapon();
  var_03 = var_01[0];
  foreach(var_05 in var_01) {
    if(common_scripts\utility::func_F79(var_01, var_02)) {
      var_03 = var_02;
    }
  }

  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00, "war_hammer_assemble_mp");
  var_00 method_8326();
  return var_03;
}

take_hammer(param_00) {
  var_01 = self;
  var_01 lib_0586::func_790("war_hammer_assemble_mp");
  var_01 method_8327();
  if(isDefined(param_00)) {
    var_01 lib_0586::func_78E(param_00);
  }
}

wallbuymysterytogglegatescriptables(param_00) {
  var_01 = "zmb_wallbuy_close";
  if(common_scripts\utility::func_562E(param_00)) {
    var_01 = "zmb_wallbuy_open";
  }

  var_02 = lib_0380::func_2889(var_01, undefined, self.var_A9E3);
  lib_0378::func_8D14(var_02);
  thread wallbuymysterytogglegatescriptable_single(param_00);
  wait(1.133333);
}

wallbuymysterytogglegate(param_00, param_01) {
  if((common_scripts\utility::func_562E(param_00) && common_scripts\utility::func_562E(self.isopen)) || !common_scripts\utility::func_562E(param_00) && !common_scripts\utility::func_562E(self.isopen)) {
    return;
  }

  wallbuymysterytogglegatescriptables(param_00);
  if(isDefined(self.wallbuy.scriptable_light)) {
    var_02 = "off";
    if(common_scripts\utility::func_562E(param_00)) {
      var_02 = "on";
    }

    self.wallbuy.scriptable_light setscriptablepartstate("lightpart", var_02);
  }

  if(isDefined(self.wallbuy.wallbuyguncard) && isDefined(param_01) && isPlayer(param_01)) {
    if(common_scripts\utility::func_562E(param_00)) {
      self.wallbuy.wallbuyguncard showtoclient(param_01);
    } else {
      self.wallbuy.wallbuyguncard hidefromclient(param_01);
    }
  }

  self.isopen = param_00;
}

wallbuymysterygatebuycycle() {
  wallbuymysterytogglegatescriptables(0);
  wait(1);
  wallbuymysterytogglegatescriptables(1);
}

wallbuymysterytogglegatescriptable_single(param_00) {
  var_01 = "buy_loop_closing";
  var_02 = "buy_loop_closed";
  if(common_scripts\utility::func_562E(param_00)) {
    var_01 = "buy_loop_opening";
    var_02 = "buy_loop_open";
  }

  self.var_82EF setscriptablepartstate("base", var_01);
  self.var_82EF notify("script_state_change");
  wait(1.133333);
  self.var_82EF setscriptablepartstate("base", var_02);
}

canopenwallbuy(param_00) {
  return common_scripts\utility::func_562E(self.wallbuy players_have_required_build_materials()) || param_00 lib_0577::func_4B95();
}

assignwallbuymysterypurchasetoplayer(param_00) {
  param_00 endon("disconnect");
  var_01 = self;
  var_01 releaseclaimedtrigger();
  param_00 clientclaimtrigger(var_01);
  var_01.lastclaimedplayer = param_00;
  if(!isDefined(param_00.claimedwbtriggers)) {
    param_00.claimedwbtriggers = [];
  }

  param_00.claimedwbtriggers[param_00.claimedwbtriggers.size] = var_01;
  while(common_scripts\utility::func_562E(param_00.playerconnectedbuthasntstreamedweapons)) {
    wait 0.05;
  }

  wait(randomfloat(0.5));
  var_01 notify("modify_wallbuy_data", param_00);
  if(isDefined(var_01.var_6C1D)) {
    var_01.var_6C1D delete();
  }

  var_02 = lib_0552::func_7BE1(param_00, self);
  lib_0559::func_7BE2(param_00, self, "wallbuy_dlc3");
  var_01.var_65DC = var_02;
  var_02.var_4028 = lib_0552::func_44FF(get_state_for_weapon_class(lib_0547::zm_get_weapon_class(var_01.wallbuy.var_165)));
  var_02.var_2F74 = 0;
  var_02.var_6642 = 1;
  var_01.canusewb = 0;
  var_03 = 0;
  var_01 wallbuymysterytogglegate(0, param_00);
  for(;;) {
    while(!var_01 canopenwallbuy(param_00)) {
      var_01.progressblocked = 1;
      wait 0.05;
    }

    var_01.progressblocked = 0;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = "mystery_wallbuy_break_early";
    if(param_00 lib_0577::func_4B95()) {
      var_04 = param_00;
      var_05 = var_06;
      var_03 = 1;
      var_01.onceonly = 1;
    }

    lib_0547::func_A6F6();
    var_02.var_401E = var_01 getwallbuytriggercost(param_00);
    var_02.var_2F74 = 0;
    var_02.var_6642 = 1;
    var_02.var_4028 = lib_0552::func_44FF(get_state_for_weapon_class(lib_0547::zm_get_weapon_class(var_01.wallbuy.var_165)));
    var_01.canusewb = 1;
    var_01 wallbuymysterytogglegate(1, param_00);
    var_07 = common_scripts\utility::func_A70E(var_01, "mystery_wallbuy_used", var_04, var_05);
    var_08 = var_07[0];
    var_09 = var_07[1];
    var_02.var_4028 = lib_0552::func_44FF(get_state_for_weapon_class(lib_0547::zm_get_weapon_class(var_01.wallbuy.var_165)));
    var_02.var_6642 = 1;
    if(var_08 == "mystery_wallbuy_used") {
      var_02.var_2F74 = 1;
      var_01 waittill("mystery_wallbuy_done");
      var_02.var_4028 = lib_0552::func_44FF(get_state_for_weapon_class(lib_0547::zm_get_weapon_class(var_01.wallbuy.var_165)));
      var_02.var_401E = var_01 getwallbuytriggercost(param_00);
      var_02.var_6642 = 1;
      param_00 lib_0577::func_A236();
      param_00 notify(var_06);
    }

    var_02.var_2F74 = 0;
    if(var_03) {
      if(var_01 canopenwallbuy(param_00)) {
        var_02.var_4028 = lib_0552::func_44FF("dlc3_interact_state_9");
        var_02.var_401E = 0;
      }

      var_01.canusewb = 0;
      var_03 = 0;
      var_01.onceonly = 0;
      wait(1);
      var_01 wallbuymysterytogglegate(0, param_00);
    }
  }
}

get_state_for_weapon_class(param_00) {
  var_01 = "";
  switch (param_00) {
    case "weapon_pistol":
      var_01 = "dlc3_interact_state_2";
      break;

    case "weapon_smg":
      var_01 = "dlc3_interact_state_7";
      break;

    case "weapon_shotgun":
      var_01 = "dlc3_interact_state_3";
      break;

    case "weapon_sniper":
      var_01 = "dlc3_interact_state_4";
      break;

    case "weapon_assault":
      var_01 = "dlc3_interact_state_5";
      break;

    case "weapon_heavy":
      var_01 = "dlc3_interact_state_6";
      break;
  }

  return var_01;
}

players_have_required_build_materials() {
  return level.wallbuymaterials >= self.requiredbuildmaterials;
}

delete_on_disconenct(param_00) {
  param_00 waittill("disconnect");
  self delete();
}