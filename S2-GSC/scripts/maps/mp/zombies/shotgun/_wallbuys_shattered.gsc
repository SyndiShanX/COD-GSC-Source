/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_wallbuys_shattered.gsc
*******************************************************************/

override_wall_buys_by_class() {
  level.active_zombie_models_to_outline = [];
  level.plr_custom_on_scoreboard_open_func = ::show_wallbuy_waypoints;
  level.plr_custom_on_scoreboard_off_func = ::hide_wallbuy_waypoints;

  while(!isDefined(level._id_A7DE))
    waitframe();

  if(!isDefined(level.rand_wallbuys))
    level.rand_wallbuys = [];

  var_0 = _getscriptablearray("wallbuy_lgt", "targetname");

  foreach(var_2 in level._id_A7DE) {
    if(isDefined(var_2._id_81C7) && var_2._id_81C7 == "rand_wallbuy") {
      level.rand_wallbuys = common_scripts\utility::_id_0F6F(level.rand_wallbuys, var_2);
      var_3 = common_scripts\utility::_id_4461(var_2.origin, var_0);

      if(isDefined(var_3))
        var_2.scriptable_light = var_3;

      foreach(var_5 in var_2._id_A7E3) {
        var_5.weapon_class = _id_0547::zm_get_weapon_class(var_2._id_0165);
        var_2.weapon_class = var_5.weapon_class;
        level.active_zombie_models_to_outline = common_scripts\utility::_id_0F6F(level.active_zombie_models_to_outline, var_5);
      }

      var_2 thread run_wallbuy_mysterybox_mod();
    }
  }

  var_8 = getEntArray("shattered_wallbuy_model", "targetname");
  level.active_zombie_models_to_outline = common_scripts\utility::_id_0F73(level.active_zombie_models_to_outline, var_8);
}

show_wallbuy_waypoints(var_0) {
  if(isDefined(var_0.pingingwaypoints)) {
    var_0.pingingwaypoints = common_scripts\utility::_id_0FA0(var_0.pingingwaypoints);

    foreach(var_2 in var_0.pingingwaypoints) {
      if(!waypoint_exists(var_2)) {
        continue;
      }
      var_0.pingingwaypoints = common_scripts\utility::_id_0F93(var_0.pingingwaypoints, var_2);
      var_2 destroy();
    }
  }

  foreach(var_5 in level.active_zombie_models_to_outline) {
    if(!isDefined(var_5.weapon_class)) {
      var_6 = common_scripts\utility::_id_40B0(var_5.origin, level.active_zombie_models_to_outline);

      foreach(var_8 in var_6) {
        if(isDefined(var_8.weapon_class)) {
          var_5.weapon_class = var_8.weapon_class;
          var_5.no_waypoint = 1;
          break;
        }
      }
    }

    if(!weapon_class_available(var_5.weapon_class)) {
      continue;
    }
    var_5 hudoutlineenableforclient(var_0, 0, 0);

    if(!isDefined(var_5.no_waypoint)) {
      continue;
    }
    var_2 = _newclienthudelem(var_0);
    var_2 setshader(level.zombies_shotgun_weapon_waypoints[var_5.weapon_class], 1, 1);
    var_2.alpha = 1;
    var_2.alpha = 1;
    var_2.color = (1, 1, 1);
    var_2.x = var_5.origin[0];
    var_2.y = var_5.origin[1];
    var_2._id_01D9 = var_5.origin[2] + 35;
    var_2 setwaypoint(0, 0, 0);

    if(!isDefined(var_0.shwaypoints))
      var_0.shwaypoints = [];

    var_0.shwaypoints = common_scripts\utility::_id_0F6F(var_0.shwaypoints, var_2);
    var_5._id_A98D = var_2;
  }
}

hide_wallbuy_waypoints(var_0) {
  foreach(var_2 in level.active_zombie_models_to_outline) {
    if(isDefined(var_2._id_A98D) && !_isremovedentity(var_2._id_A98D))
      var_2._id_A98D destroy();

    var_2 hudoutlinedisableforclient(var_0);
  }

  if(isDefined(var_0.shwaypoints)) {
    foreach(var_5 in var_0.shwaypoints) {
      if(isDefined(var_5) && !_isremovedentity(var_5))
        var_5 destroy();
    }
  }

  var_0.shwaypoints = [];
}

run_wallbuy_mysterybox_mod() {
  foreach(var_1 in self._id_A7E9) {
    var_1.wallbuy = self;
    _id_0547::_id_8A4F(var_1, ::assignwallbuymysterypurchasetoplayer, ::_id_4D1B);
  }

  var_3 = _id_0547::zm_get_weapon_class(self._id_0165);

  if(isDefined(self.wallbuyguncard)) {
    var_4 = get_wallbuy_gun_card_model(var_3);

    if(isDefined(var_4))
      self.wallbuyguncard setModel(var_4);
  }

  var_5 = get_current_weapon_level(var_3);
  var_6 = var_5[0];
  var_7 = var_5[1];
  var_8 = var_5[2];
  var_9 = var_7;
  self.requiredbuildmaterials = var_8;

  foreach(var_1 in self._id_A7E9) {
    var_1._id_267B = var_7;
    var_1.wallbuy._id_A9A5 = var_9;
    var_1.requiredbuildmaterials = var_8;
    var_1 thread watch_for_player_purchase();
    var_1 thread run_wallbuy_trigger_mysterybox_mod(var_6, var_3);
  }
}

setwallbuyitements(var_0, var_1, var_2) {
  if(!isDefined(var_1._id_586E)) {
    var_3 = replace_wallbuy_weapon(var_1, var_2);
    var_3 _meth_86B3(0);
    var_1._id_586E = var_3;
    var_1.itementlink = var_0;
  } else
    var_1._id_586E setpickupweapon(var_2);

  var_1._id_586E._id_A9E0 = var_2;
  var_1._id_586E makeunusable();
  var_1._id_586E ghost();
}

slide_left() {
  var_0 = 0;

  switch (self._id_A9E0) {
    case "m1a1_zm":
      var_0 = -3;
      break;
    case "p38_zm":
      var_0 = 4;
      break;
    case "g43_zm":
      var_0 = -3.5;
      break;
    case "m1911_zm":
      var_0 = 0;
      break;
    case "model21_zm":
      var_0 = 3;
      break;
    case "luger_zm":
      var_0 = 2;
      break;
    case "m30_zm":
      var_0 = -5;
      break;
    case "k98_zm":
      var_0 = -5;
      break;
    case "reich_zm":
      var_0 = 3;
      break;
    case "enfieldno2_zm":
      var_0 = 5;
      break;
    case "svt40_zm":
      var_0 = -5;
      break;
    case "m712_zm":
      var_0 = 2;
      break;
  }

  var_1 = self.origin;
  self.origin = self.origin + var_0 * vectorNormalize(anglesToForward(self.angles));
}

run_wallbuy_trigger_mysterybox_mod(var_0, var_1) {
  var_2 = self;
  var_3 = "";
  var_4 = undefined;
  var_5 = undefined;
  var_6 = spawn("script_model", var_2._id_A9E3);
  var_6 setModel("tag_origin");
  var_6 thread watch_player_consumable_usage(var_2);
  var_7 = common_scripts\utility::array_randomize(var_0);
  var_8 = 0;
  var_9 = maps\mp\gametypes\_class::_id_1D66("ppsh41_classic_zm", "extended_mag");

  for(;;) {
    if(var_1 == "weapon_smg" && common_scripts\utility::_id_3C77("shotgun_classic_add_to_box")) {
      if(!common_scripts\utility::_id_0F79(var_7, var_9)) {
        var_10 = _randomintrange(1, 4);
        var_7 = common_scripts\utility::_id_0F86(var_7, var_9, var_8 + var_10);
      }

      var_11 = 1;
    }

    var_3 = var_7[var_8];

    if(isDefined(getDvar("testingWallBuyWeap")) && getDvar("testingWallBuyWeap") != "")
      var_3 = getDvar("testingWallBuyWeap");

    var_2._id_6C5C = var_3;
    var_8++;

    if(var_8 >= var_7.size)
      var_8 = 0;

    var_12 = var_3;

    if(isDefined(var_2.lastclaimedplayer) && isPlayer(var_2.lastclaimedplayer)) {
      if(var_2.lastclaimedplayer _id_0579::_id_4BA5())
        var_3 = var_2.lastclaimedplayer._id_A99B;

      var_12 = _id_0548::_id_454B(var_2.lastclaimedplayer, var_3);
    }

    setwallbuyitements(var_6, var_2, var_12);
    var_2._id_A9E0 = var_12;
    var_2 waittill("mystery_wallbuy_used", var_13);
    var_3 = var_2._id_586E._id_A9E0;
    var_12 = var_3;
    playFX(level._effect["zmb_mystery_box_gun_gk"], var_2._id_A9E3);
    level._id_11CB._id_65F4 = _id_0380::_id_2889("zmb_mystery_box_elec", undefined, var_2._id_A9E3);
    var_2._id_586E showtoplayer(var_13);

    if(!isDefined(var_2._id_586E._id_6C4E))
      var_2._id_586E._id_6C4E = var_2._id_586E.origin;

    if(!isDefined(var_2.itementlink._id_6C4E))
      var_2.itementlink._id_6C4E = var_2.itementlink.origin;

    var_2._id_586E.origin = var_2._id_586E._id_6C4E;
    var_2.itementlink.origin = var_2.itementlink._id_6C4E;
    var_2._id_586E unlink();
    var_2._id_586E slide_left();
    var_2._id_586E linktosynchronizedparent(var_2.itementlink);
    var_14 = var_2._id_A9E3 + 6 * vectorNormalize(anglestoright(var_2._id_A9BD));
    var_2.itementlink moveto(var_14, 0.15);
    wait 0.25;

    if(var_13 _id_0579::_id_4BA5())
      var_13 _id_0579::_id_A246();

    if(_id_0547::_id_585C(var_12))
      _id_0548::_id_A7D5(var_13, var_12);
    else
      _id_0548::_id_A7D6(var_13, var_12);

    if(!common_scripts\utility::_id_562E(var_13._id_4B72)) {
      if(randomint(100) < level.zmb_shotgun_jack_in_box_odds) {
        level.zmb_shotgun_jack_in_box_odds_add_per_spin = 0;
        level.zmb_shotgun_jack_in_box_odds = 8;
        var_13 _id_057D::_id_4766();
        var_13 thread maps\mp\gametypes\_hud_message::_id_9102("zm_collectible_splash_jitb");
      } else
        level.zmb_shotgun_jack_in_box_odds = level.zmb_shotgun_jack_in_box_odds + int(level.zmb_shotgun_jack_in_box_odds_add_per_spin * get_wallbuy_jack_multiplier(var_1));
    }

    var_2._id_586E ghost();

    if(!common_scripts\utility::_id_562E(var_2.onceonly))
      var_2 wallbuymysterygatebuycycle();
    else
      waitframe();

    var_2 notify("mystery_wallbuy_done");
  }

  if(isDefined(var_2.itementlink))
    var_2.itementlink delete();
}

get_wallbuy_jack_multiplier(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "weapon_heavy":
      var_1 = 5;
      break;
    case "weapon_assault":
      var_1 = 4;
      break;
    case "weapon_shotgun":
      var_1 = 3;
      break;
    case "weapon_sniper":
      var_1 = 4.25;
      break;
    case "weapon_smg":
      var_1 = 3;
      break;
  }

  return var_1;
}

watch_player_consumable_usage(var_0) {
  var_1 = self;
  var_1 endon("death");

  for(;;) {
    var_0 waittill("modify_wallbuy_data", var_2);
    var_0._id_65DC._id_401E = var_0 getwallbuytriggercost(var_2);
    var_0._id_65DC._id_6642 = 1;
    var_3 = var_0._id_6C5C;

    if(var_2 _id_0579::_id_4BA5())
      var_3 = var_2._id_A99B;

    var_3 = _id_0548::_id_454B(var_2, var_3);
    setwallbuyitements(var_1, var_0, var_3);
  }
}

weapon_class_available(var_0) {
  return level.wallbuymaterials >= level.zombies_shotgun_weapons_level[var_0];
}

replace_wallbuy_weapon(var_0, var_1) {
  var_2 = var_0._id_A9E3;
  var_3 = (0, 0, 0);

  if(isDefined(var_0._id_A9BD))
    var_3 = var_0._id_A9BD;

  var_4 = spawn("weapon_" + var_1, var_2, 1);
  var_4.angles = var_3;
  return var_4;
}

showwaywallbuypointping(var_0) {
  var_1 = self;
  var_2 = _newclienthudelem(var_1);

  if(!isDefined(var_1.pingingwaypoints))
    var_1.pingingwaypoints = [];

  var_1.pingingwaypoints = common_scripts\utility::_id_0FA0(var_1.pingingwaypoints);
  var_1.pingingwaypoints = common_scripts\utility::_id_0F6F(var_1.pingingwaypoints, var_2);
  var_3 = var_0.weap_origin;
  var_4 = var_0.weap_class;

  if(isDefined(var_4))
    var_2 setshader(level.zombies_shotgun_weapon_waypoints[var_4], 1, 1);
  else
    var_2 setshader(level.zmb_sg_wallbuy_waypoint_icon, 1, 1);

  var_2.alpha = 0;
  var_2.color = (1, 1, 1);
  var_2.x = var_3[0];
  var_2.y = var_3[1];
  var_2._id_01D9 = var_3[2] + 15;
  var_2 setwaypoint(0, 1, 0);
  var_2 fadeovertime(0.1);
  var_2.alpha = 1;
  wait 2;

  if(!waypoint_exists(var_2)) {
    return;
  }
  var_2 setwaypoint(0, 0, 0);
  wait 6;

  if(!waypoint_exists(var_2)) {
    return;
  }
  var_2 fadeovertime(2);
  var_2.alpha = 0;
  wait 2;

  if(waypoint_exists(var_2))
    var_2 destroy();
}

waypoint_exists(var_0) {
  return isDefined(var_0) && !_isremovedentity(var_0);
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
  foreach(var_1 in level.sg_wallbuyclasses) {
    if(level.wallbuymaterials > 1 && level.wallbuymaterials == level.zombies_shotgun_weapons_level[var_1])
      level thread maps\mp\_utility::_id_6F74(maps\mp\gametypes\_hud_message::_id_9102, level.zombies_shotgun_weapons_splashes[var_1]);
  }

  unlock_new_wallbuys();
}

hidewallbuymysterypurchasefromotherplayer(var_0) {}

set_prompt_data_needs_refresh() {
  var_0 = level._id_ABD1;

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(var_0[var_1] is_valid_prompt())
      var_0[var_1]._id_2903._id_9FD3._id_6642 = 1;
  }

  var_0 = level._id_AC0C;

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(var_0[var_1] is_valid_prompt())
      var_0[var_1]._id_2903._id_9FD3._id_6642 = 1;
  }
}

is_valid_prompt() {
  var_0 = self;
  return isDefined(var_0) && isDefined(var_0._id_2903);
}

unlock_new_wallbuys() {
  foreach(var_1 in level.rand_wallbuys) {
    if(var_1.weapon_class != "weapon_smg" && var_1.weapon_class != "weapon_pistol" && !common_scripts\utility::_id_562E(var_1.hasshownwaypoint) && var_1 players_have_required_build_materials()) {
      var_1.hasshownwaypoint = 1;
      var_2 = spawnStruct();
      var_2.weap_origin = var_1._id_A7E9[0]._id_A9E3;
      var_2.weap_class = var_1.weapon_class;
      level thread maps\mp\_utility::_id_6F74(::showwaywallbuypointping, var_2);
    }
  }
}

_id_4D1B(var_0) {
  self.issighted _meth_8006(var_0);
}

getwallbuytriggercost(var_0) {
  if(maps\mp\_utility::gameflag("fire_sale"))
    return int(10);

  var_1 = 1000;

  if(isDefined(self._id_267B))
    var_1 = self._id_267B;

  if(isPlayer(var_0) && var_0 _id_0573::_id_4B7B())
    var_1 = var_1 - var_0._id_65EC.flatdiscount;

  if(isPlayer(var_0) && var_0 _id_0577::_id_4B95())
    var_1 = var_1 - var_0._id_8C71.flatdiscount;

  if(var_1 < 0)
    var_1 = 0;

  return int(var_1);
}

should_run_buildable_logic(var_0) {
  return common_scripts\utility::_id_562E(level.buildablewallbuys) && common_scripts\utility::_id_0F79(level.validbuildablewallbuys, _id_0547::zm_get_weapon_class(var_0._id_0165));
}

watch_for_player_purchase() {
  for(;;) {
    var_0 = get_use_player();
    var_1 = getwallbuytriggercost(var_0);

    if(common_scripts\utility::_id_562E(self.progressblocked)) {
      _id_0555::issprinting("dlc3_progress_hint", var_0);
      continue;
    }

    if(!var_0 maps\mp\gametypes\zombies::_id_1F32(var_1) || !common_scripts\utility::_id_562E(self.canusewb)) {
      continue;
    }
    if(!var_0 maps\mp\gametypes\zombies::_id_11C2(var_1)) {
      var_0 thread _id_054E::_id_0695("needmoney");
      continue;
    } else {
      self notify("mystery_wallbuy_used", var_0);
      self.canusewb = 0;

      if(maps\mp\_utility::gameflag("fire_sale")) {
        continue;
      }
      var_0 _id_0573::_id_A21E();
    }
  }
}

get_wallbuy_gun_card_model(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "weapon_heavy":
      var_1 = "zmd_wallbuy_cards_01_lmg";
      break;
    case "weapon_assault":
      var_1 = "zmd_wallbuy_cards_01_assault";
      break;
    case "weapon_shotgun":
      var_1 = "zmd_wallbuy_cards_01_shotgun";
      break;
    case "weapon_sniper":
      var_1 = "zmd_wallbuy_cards_01_sniper";
      break;
    case "weapon_smg":
      var_1 = "zmd_wallbuy_cards_01_smg";
      break;
    case "weapon_pistol":
      var_1 = "zmd_wallbuy_cards_01_starter";
      break;
  }

  return var_1;
}

get_weapon_from_trigger_data(var_0, var_1) {
  return _id_0548::_id_454B(var_0, var_1._id_6C5C);
}

get_wallbuy_class_friendly_name(var_0) {
  var_1 = "";

  switch (var_0) {
    case "weapon_heavy":
      var_1 = "LMG";
      break;
    case "weapon_assault":
      var_1 = "Rifle";
      break;
    case "weapon_shotgun":
      var_1 = "Shotgun";
      break;
    case "weapon_sniper":
      var_1 = "Sniper Rifle";
      break;
    case "weapon_smg":
      var_1 = "SMG";
      break;
    case "weapon_pistol":
      var_1 = "Pistol";
      break;
    case "weapon_projectile":
      var_1 = "Launcher";
      break;
  }

  return var_1;
}

get_current_weapon_level(var_0) {
  var_1 = get_weapons_by_class(var_0);
  var_2 = level.zombies_shotgun_weapons_cost[var_0];
  var_3 = level.zombies_shotgun_weapons_level[var_0];
  return [var_1, var_2, var_3];
}

get_weapons_by_class(var_0) {
  return common_scripts\utility::array_randomize(level.zombies_shotgun_weapons_in_play[var_0]);
}

get_use_player() {
  self waittill("trigger", var_0);
  return var_0;
}

re_enabble_hammer() {
  waitframe();
  self enableweapons();
}

start_hammer() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = var_0 getweaponlistprimaries();
  var_2 = var_0 getcurrentweapon();
  var_3 = var_1[0];

  foreach(var_5 in var_1) {
    if(common_scripts\utility::_id_0F79(var_1, var_2))
      var_3 = var_2;
  }

  _id_0548::_id_A7D6(var_0, "war_hammer_assemble_mp");
  var_0 disableweaponswitch();
  return var_3;
}

take_hammer(var_0) {
  var_1 = self;
  var_1 _id_0586::_id_0790("war_hammer_assemble_mp");
  var_1 enableweaponswitch();

  if(isDefined(var_0))
    var_1 _id_0586::_id_078E(var_0);
}

wallbuymysterytogglegatescriptables(var_0) {
  var_1 = "zmb_wallbuy_close";

  if(common_scripts\utility::_id_562E(var_0))
    var_1 = "zmb_wallbuy_open";

  var_2 = _id_0380::_id_2889(var_1, undefined, self._id_A9E3);
  _id_0378::_id_8D14(var_2);
  thread wallbuymysterytogglegatescriptable_single(var_0);
  wait 1.13333;
}

wallbuymysterytogglegate(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0) && common_scripts\utility::_id_562E(self.isopen) || !common_scripts\utility::_id_562E(var_0) && !common_scripts\utility::_id_562E(self.isopen)) {
    return;
  }
  wallbuymysterytogglegatescriptables(var_0);

  if(isDefined(self.wallbuy.scriptable_light)) {
    var_2 = "off";

    if(common_scripts\utility::_id_562E(var_0))
      var_2 = "on";

    self.wallbuy.scriptable_light setscriptablepartstate("lightpart", var_2);
  }

  if(isDefined(self.wallbuy.wallbuyguncard) && isDefined(var_1) && isPlayer(var_1)) {
    if(common_scripts\utility::_id_562E(var_0))
      self.wallbuy.wallbuyguncard showtoplayer(var_1);
    else
      self.wallbuy.wallbuyguncard _meth_8006(var_1);
  }

  self.isopen = var_0;
}

wallbuymysterygatebuycycle() {
  wallbuymysterytogglegatescriptables(0);
  wait 1;
  wallbuymysterytogglegatescriptables(1);
}

wallbuymysterytogglegatescriptable_single(var_0) {
  var_1 = "buy_loop_closing";
  var_2 = "buy_loop_closed";

  if(common_scripts\utility::_id_562E(var_0)) {
    var_1 = "buy_loop_opening";
    var_2 = "buy_loop_open";
  }

  self.issighted setscriptablepartstate("base", var_1);
  self.issighted notify("script_state_change");
  wait 1.13333;
  self.issighted setscriptablepartstate("base", var_2);
}

canopenwallbuy(var_0) {
  return common_scripts\utility::_id_562E(self.wallbuy players_have_required_build_materials()) || var_0 _id_0577::_id_4B95();
}

assignwallbuymysterypurchasetoplayer(var_0) {
  var_0 endon("disconnect");
  var_1 = self;
  var_1 releaseclaimedtrigger();
  var_0 clientclaimtrigger(var_1);
  var_1.lastclaimedplayer = var_0;

  if(!isDefined(var_0.claimedwbtriggers))
    var_0.claimedwbtriggers = [];

  var_0.claimedwbtriggers[var_0.claimedwbtriggers.size] = var_1;

  while(common_scripts\utility::_id_562E(var_0.playerconnectedbuthasntstreamedweapons))
    waitframe();

  wait(_randomfloat(0.5));
  var_1 notify("modify_wallbuy_data", var_0);

  if(isDefined(var_1._id_6C1D))
    var_1._id_6C1D delete();

  var_2 = _id_0552::_id_7BE1(var_0, self);
  _id_0559::_id_7BE2(var_0, self, "wallbuy_dlc3");
  var_1._id_65DC = var_2;
  var_2._id_4028 = _id_0552::_id_44FF(get_state_for_weapon_class(_id_0547::zm_get_weapon_class(var_1.wallbuy._id_0165)));
  var_2._id_2F74 = 0;
  var_2._id_6642 = 1;
  var_1.canusewb = 0;
  var_3 = 0;
  var_1 wallbuymysterytogglegate(0, var_0);

  for(;;) {
    while(!var_1 canopenwallbuy(var_0)) {
      var_1.progressblocked = 1;
      waitframe();
    }

    var_1.progressblocked = 0;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = "mystery_wallbuy_break_early";

    if(var_0 _id_0577::_id_4B95()) {
      var_4 = var_0;
      var_5 = var_6;
      var_3 = 1;
      var_1.onceonly = 1;
    }

    _id_0547::_id_A6F6();
    var_2._id_401E = var_1 getwallbuytriggercost(var_0);
    var_2._id_2F74 = 0;
    var_2._id_6642 = 1;
    var_2._id_4028 = _id_0552::_id_44FF(get_state_for_weapon_class(_id_0547::zm_get_weapon_class(var_1.wallbuy._id_0165)));
    var_1.canusewb = 1;
    var_1 wallbuymysterytogglegate(1, var_0);
    [var_8, var_9] = common_scripts\utility::_id_A70E(var_1, "mystery_wallbuy_used", var_4, var_5);
    var_2._id_4028 = _id_0552::_id_44FF(get_state_for_weapon_class(_id_0547::zm_get_weapon_class(var_1.wallbuy._id_0165)));
    var_2._id_6642 = 1;

    if(var_8 == "mystery_wallbuy_used") {
      var_2._id_2F74 = 1;
      var_1 waittill("mystery_wallbuy_done");
      var_2._id_4028 = _id_0552::_id_44FF(get_state_for_weapon_class(_id_0547::zm_get_weapon_class(var_1.wallbuy._id_0165)));
      var_2._id_401E = var_1 getwallbuytriggercost(var_0);
      var_2._id_6642 = 1;
      var_0 _id_0577::_id_A236();
      var_0 notify(var_6);
    }

    var_2._id_2F74 = 0;

    if(var_3) {
      if(var_1 canopenwallbuy(var_0)) {
        var_2._id_4028 = _id_0552::_id_44FF("dlc3_interact_state_9");
        var_2._id_401E = 0;
      }

      var_1.canusewb = 0;
      var_3 = 0;
      var_1.onceonly = 0;
      wait 1;
      var_1 wallbuymysterytogglegate(0, var_0);
    }
  }
}

get_state_for_weapon_class(var_0) {
  var_1 = "";

  switch (var_0) {
    case "weapon_pistol":
      var_1 = "dlc3_interact_state_2";
      break;
    case "weapon_smg":
      var_1 = "dlc3_interact_state_7";
      break;
    case "weapon_shotgun":
      var_1 = "dlc3_interact_state_3";
      break;
    case "weapon_sniper":
      var_1 = "dlc3_interact_state_4";
      break;
    case "weapon_assault":
      var_1 = "dlc3_interact_state_5";
      break;
    case "weapon_heavy":
      var_1 = "dlc3_interact_state_6";
      break;
  }

  return var_1;
}

players_have_required_build_materials() {
  return level.wallbuymaterials >= self.requiredbuildmaterials;
}

delete_on_disconenct(var_0) {
  var_0 waittill("disconnect");
  self delete();
}