/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_pillage.gsc
**************************************************/

init_pillage_drops() {
  scripts\engine\utility::flag_init("can_drop_coins");
  scripts\engine\utility::flag_init("pillage_enabled");
  level.var_B44A = 1;
  level.var_C1FC = 0;
  level.var_A8F5 = 30000;
  level.var_CB5D = 15000;
  level.var_CB5C = -20536;
  level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D, level.var_CB5C);
  level.pillage_item_drop_func = ::pillage_item_drop_func;
  level.should_drop_pillage = ::func_FF3D;
  level.var_163C = [];
}

register_zombie_pillageable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.part = var_1;
  var_5.model = var_3;
  var_5.var_AAB6 = var_4;
  var_5.var_AAB3 = var_2;
  level.var_13F49[var_0] = var_5;
}

func_6690(var_0) {
  if(!scripts\engine\utility::flag("pillage_enabled")) {
    return;
  }

  if(!func_381B(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::random(func_7B81(var_0));
  if(isDefined(var_1)) {
    level.var_C1FC++;
    var_0 thread func_136B6(var_0);
    func_668F(var_0, var_1);
  }
}

func_136B6(var_0) {
  var_0 waittill("death");
  level.var_C1FC--;
}

func_668F(var_0, var_1) {
  var_2 = level.var_13F49[var_1].part;
  var_0 setscriptablepartstate(var_2, var_1);
  var_0.has_backpack = var_1;
}

func_381B(var_0) {
  if(var_0 scripts\asm\zombie\zombie::func_9E0F()) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.karatemaster)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.is_cop)) {
    return 0;
  }

  return 1;
}

func_50AF(var_0) {
  wait(5);
  var_0 delete();
}

func_7B81(var_0) {
  if(level.var_C1FC >= level.var_B44A) {
    return [];
  } else if(level.var_BF51 > gettime()) {
    return [];
  } else if(randomint(100) <= 100) {
    var_1 = func_7DB3(var_0.model);
    return var_1;
  }

  return [];
}

func_7DB3(var_0) {
  if(!isDefined(level.var_13F49)) {
    return [];
  }

  switch (var_0) {
    case "zombie_female_outfit_7_3":
    case "zombie_female_outfit_7_2":
    case "zombie_female_outfit_7":
    case "zombie_female_outfit_6_3":
    case "zombie_female_outfit_6_2":
    case "zombie_female_outfit_6":
    case "zombie_female_outfit_5_3":
    case "zombie_female_outfit_5_2":
    case "zombie_female_outfit_5":
    case "zombie_female_outfit_4_3":
    case "zombie_female_outfit_4_2":
    case "zombie_female_outfit_4":
    case "zombie_female_outfit_3_3":
    case "zombie_female_outfit_3_2":
    case "zombie_female_outfit_3":
    case "zombie_female_outfit_2_3":
    case "zombie_female_outfit_2_2":
    case "zombie_female_outfit_2":
    case "zombie_female_outfit_1_2":
    case "zombie_female_outfit_1":
    case "zombie_male_outfit_6_2_c":
    case "zombie_male_outfit_6_c":
    case "zombie_male_outfit_5_3_c":
    case "zombie_male_outfit_5_2_c":
    case "zombie_male_outfit_5_c":
    case "zombie_male_outfit_4_3_c":
    case "zombie_male_outfit_4_2_c":
    case "zombie_male_outfit_4_c":
    case "zombie_male_outfit_3_3_c":
    case "zombie_male_outfit_3_2_c":
    case "zombie_male_outfit_3_c":
    case "zombie_male_outfit_2_6_c":
    case "zombie_male_outfit_2_5_c":
    case "zombie_male_outfit_2_4_c":
    case "zombie_male_outfit_2_3_c":
    case "zombie_male_outfit_2_2_c":
    case "zombie_male_outfit_2_c":
    case "zombie_male_outfit_1_2_c":
    case "zombie_male_outfit_1_c":
    case "zombie_male_outfit_6_2_b":
    case "zombie_male_outfit_6_b":
    case "zombie_male_outfit_5_3_b":
    case "zombie_male_outfit_5_2_b":
    case "zombie_male_outfit_5_b":
    case "zombie_male_outfit_4_3_b":
    case "zombie_male_outfit_4_2_b":
    case "zombie_male_outfit_4_b":
    case "zombie_male_outfit_3_3_b":
    case "zombie_male_outfit_3_2_b":
    case "zombie_male_outfit_3_b":
    case "zombie_male_outfit_2_6_b":
    case "zombie_male_outfit_2_5_b":
    case "zombie_male_outfit_2_4_b":
    case "zombie_male_outfit_2_3_b":
    case "zombie_male_outfit_2_2_b":
    case "zombie_male_outfit_2_b":
    case "zombie_male_outfit_1_2_b":
    case "zombie_male_outfit_1_b":
    case "zombie_male_outfit_6_2":
    case "zombie_male_outfit_6":
    case "zombie_male_outfit_5_3":
    case "zombie_male_outfit_5_2":
    case "zombie_male_outfit_5":
    case "zombie_male_outfit_4_3":
    case "zombie_male_outfit_4_2":
    case "zombie_male_outfit_4":
    case "zombie_male_outfit_3_3":
    case "zombie_male_outfit_3_2":
    case "zombie_male_outfit_3":
    case "zombie_male_outfit_2_6":
    case "zombie_male_outfit_2_5":
    case "zombie_male_outfit_2_4":
    case "zombie_male_outfit_2_3":
    case "zombie_male_outfit_2_2":
    case "zombie_male_outfit_2":
    case "zombie_male_outfit_1_2":
    case "zombie_male_outfit_1":
      return getarraykeys(level.var_13F49);

    case "zombie_male_bluejeans_c":
    case "zombie_male_bluejeans_b":
    case "zombie_male_bluejeans_a":
      return [];

    default:
      return getarraykeys(level.var_13F49);
  }
}

pillageable_piece_lethal_monitor(var_0, var_1, var_2) {
  var_3 = level.var_13F49[var_1].var_AAB3;
  var_4 = level.var_13F49[var_1].var_AAB6;
  var_5 = var_0 gettagorigin(var_4);
  var_6 = var_0 gettagangles(var_4);
  if(var_0[[level.should_drop_pillage]](var_2, var_5)) {
    level thread func_10798(var_5, var_6, var_3);
  }
}

pillage_init() {
  level.var_CB58 = [];
  level.pillageable_powers = ["power_speedBoost", "power_teleport", "power_transponder", "power_cloak", "power_barrier", "power_mortarMount"];
  level.pillageable_explosives = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level.var_C32B = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level.var_C32C = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level.pillageable_attachments = ["reflex", "grip", "barrelrange", "xmags", "overclock", "fastaim", "rof"];
  if(isDefined(level.custom_pillageinitfunc)) {
    [[level.custom_pillageinitfunc]]();
  }

  func_31AF();
}

func_31AF(var_0) {
  if(!isDefined(level.pillageinfo)) {
    return;
  }

  if(!isDefined(level.var_CB87)) {
    level.var_CB87 = [];
  }

  if(isDefined(level.pillageinfo.explosive)) {
    func_31AE("explosive", level.pillageinfo.explosive);
  }

  if(isDefined(level.pillageinfo.clip)) {
    func_31AE("clip", level.pillageinfo.clip);
  }

  if(isDefined(level.pillageinfo.money)) {
    func_31AE("money", level.pillageinfo.money);
  }

  if(isDefined(level.pillageinfo.var_B47C)) {
    func_31AE("maxammo", level.pillageinfo.var_B47C);
  }

  if(isDefined(level.pillageinfo.tickets)) {
    func_31AE("tickets", level.pillageinfo.tickets);
  }

  if(isDefined(level.pillageinfo.powers)) {
    func_31AE("powers", level.pillageinfo.powers);
  }

  if(isDefined(level.pillageinfo.var_28C2)) {
    func_31AE("battery", level.pillageinfo.var_28C2);
  }

  if(isDefined(level.var_4C3F)) {
    [[level.var_4C3F]]();
  }
}

func_31AE(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = spawnStruct();
  var_2.ref = var_0;
  var_2.var_3C35 = var_1;
  level.var_CB87[level.var_CB87.size] = var_2;
}

player_used_pillage_spot(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.inlaststand)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(var_1 scripts\cp\utility::is_holding_deployable() || var_1 scripts\cp\utility::has_special_weapon()) {
    return;
  }

  switch (var_0.type) {
    case "explosive":
      var_0 notify("all_players_searched");
      var_1 func_12880(var_0, "primary", 1);
      break;

    case "powers":
      var_0 notify("all_players_searched");
      var_1 func_12880(var_0, "secondary", 0);
      break;

    case "maxammo":
      if(var_1 func_38BA()) {
        var_1 func_82E8();
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        scripts\engine\utility::waitframe();
        var_0 notify("all_players_searched");
      } else {
        var_1 scripts\cp\utility::setlowermessage("max_ammo", &"COOP_GAME_PLAY_AMMO_MAX", 3);
      }
      break;

    case "money":
      if(var_1 scripts\cp\cp_persistence::get_player_currency() < var_1.maxcurrency) {
        if(soundexists(var_1.vo_prefix + "pillage_cash")) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_cash", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        }

        var_1 scripts\cp\cp_persistence::give_player_currency(var_0.var_3C, undefined, undefined, 1, "pillage");
        var_0 notify("all_players_searched");
      } else {
        var_1 scripts\cp\utility::setlowermessage("max_money", &"COOP_GAME_PLAY_MONEY_MAX", 3);
      }
      break;

    case "tickets":
      var_1 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, var_0.var_3C);
      var_0 notify("all_players_searched");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
      break;

    case "clip":
      if(var_1 func_38B7()) {
        var_1 setaimspreadmovementscale();
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        scripts\engine\utility::waitframe();
        var_0 notify("all_players_searched");
      } else {
        var_2 = var_1 scripts\cp\utility::getvalidtakeweapon();
        if(issubstr(var_2, "iw7_cutie_zm") || issubstr(var_2, "iw7_cutier_zm")) {
          var_1 scripts\cp\utility::setlowermessage("invalid_ammo", &"CP_TOWN_INVALID_AMMO", 3);
        } else {
          var_1 scripts\cp\utility::setlowermessage("max_ammo", &"COOP_GAME_PLAY_AMMO_MAX", 3);
        }

        return;
      }
      break;

    case "quest":
      if(isDefined(level.quest_specific_pillage_show_func)) {
        var_1[[level.quest_specific_pillage_show_func]](var_2, "pickup", var_1);
      }

      break;

    case "battery":
      if(scripts\engine\utility::istrue(var_2.has_battery)) {
        var_2 scripts\cp\utility::setlowermessage("have_battery", &"CP_TOWN_HAVE_BATTERY", 4);
        return;
      }

      if(isDefined(level.quest_pillage_give_func)) {
        var_2 thread[[level.quest_pillage_give_func]](var_2);
      }

      var_1 notify("all_players_searched");
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
      break;

    default:
      if(isDefined(level.var_ABE7)) {
        var_1[[level.var_ABE7]](var_2, "pick_up");
      }
      break;
  }

  if(isDefined(var_1.var_A038)) {
    var_2 thread func_100F2(var_1.var_A038);
  }

  var_2 playlocalsound("zmb_item_pickup");
  var_2 thread scripts\cp\utility::usegrenadegesture(var_2, "iw7_pickup_zm");
}

gesture_activate(var_0, var_1, var_2, var_3) {
  self notify("forcingGesture");
  self endon("forcingGesture");
  self allowmelee(0);
  scripts\engine\utility::allow_ads(0);
  if(scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(0);
  }

  if(self isgestureplaying(var_0)) {
    self stopgestureviewmodel(var_0, 0);
  }

  var_4 = self getgestureanimlength(var_0) * 0.4;
  var_5 = self playgestureviewmodel(var_0, var_1, 1);
  if(var_5) {
    var_6 = func_7DCA(var_0);
    self playanimscriptevent("power_active_cp", var_6);
    wait(var_4);
  }

  self allowmelee(1);
  scripts\engine\utility::allow_ads(1);
  if(!scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }
}

func_7DCA(var_0) {
  switch (var_0) {
    default:
      return "gesture008";
  }
}

func_831A(var_0) {
  self endon("all_players_searched");
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_1 = var_0 getcurrentweapon();
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);
    var_0 takeweapon(var_1);
    var_0.var_A037 = var_2;
    level.transactionid = randomint(100);
    scripts\cp\zombies\zombie_analytics::func_AF76(var_0.var_A037, level.transactionid);
    if(isDefined(var_0.pap[var_2])) {
      var_0.pap[var_2] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_3 = self.pillageinfo.randomintrange.weapon;
  var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
  var_0.itempicked = var_4;
  var_0 giveweapon(var_3);
  if(!isDefined(var_0.itemkills[var_4])) {
    var_0.itemkills[var_4] = 0;
  }

  var_0 switchtoweapon(var_3);
  var_5 = spawnStruct();
  var_5.lvl = 1;
  var_0.pap[var_4] = var_5;
  var_0 notify("weapon_level_changed");
  self notify("weapon_taken");
}

func_5135(var_0) {
  thread func_13971();
  var_1 = scripts\engine\utility::waittill_any_timeout(60, "stop_pillage_spot_think", "all_players_searched", "redistributed_pillage_spots");
  var_2 = var_1 != "redistributed_pillage_spots";
  self.var_A032 = var_0.model;
  thread func_5189(var_0, var_2);
}

func_10D4C() {
  wait(60);
  self notify("all_players_searched");
}

func_13971() {
  self endon("all_players_searched");
  for(;;) {
    scripts\engine\utility::waittill_any("picked_up", "swapped");
    self.var_F073++;
    wait(0.25);
    if(self.var_F073 >= level.players.size) {
      self notify("all_players_searched");
      break;
    } else {
      wait(0.05);
    }
  }
}

func_7A09(var_0) {
  var_0 = "" + var_0;
  switch (var_0) {
    case "power_bolaSpray":
      return &"ZOMBIE_PILLAGE_FOUND_BOLA_BARRAGE";

    case "power_semtex":
      return &"ZOMBIE_PILLAGE_FOUND_SEMTEX";

    case "power_splashGrenade":
      return &"ZOMBIE_PILLAGE_FOUND_PLASMA_GRENADE";

    case "power_bioSpike":
      return &"COOP_PILLAGE_FOUND_BIO_SPIKE";

    case "power_gasGrenade":
      return &"COOP_PILLAGE_FOUND_GAS_GRENADE";

    case "power_clusterGrenade":
      return &"COOP_PILLAGE_FOUND_CLUSTER_GRENADE";

    case "power_repulsor":
      return &"COOP_PILLAGE_FOUND_REPULSOR";

    case "power_frag":
      return &"ZOMBIE_PILLAGE_FOUND_FRAG_GRENADE";

    case "power_arcGrenade":
      return &"ZOMBIE_PILLAGE_FOUND_ARC_GRENADE";

    case "power_c4":
      return &"ZOMBIE_PILLAGE_FOUND_C4";

    case "power_concussionGrenade":
      return &"ZOMBIE_PILLAGE_FOUND_CONCUSSION_GRENADES";

    case "maxammo":
      return &"COOP_PILLAGE_FOUND_MAX_AMMO";

    case "clip":
      return &"COOP_PILLAGE_FOUND_CLIP";

    case "tickets":
      return &"ZOMBIE_PILLAGE_FOUND_TICKETS";

    default:
      return undefined;
  }

  if(isDefined(level.var_7A0A)) {
    return [[level.var_7A0A]](var_0);
  }
}

func_7A06(var_0) {
  var_0 = "" + var_0;
  switch (var_0) {
    case "power_frag":
      return &"ZOMBIE_PILLAGE_PICKUP_FRAG_GRENADE";

    case "power_splashGrenade":
      return &"ZOMBIE_PILLAGE_PICKUP_PLASMA_GRENADE";

    case "power_bolaSpray":
      return &"ZOMBIE_PILLAGE_PICKUP_BOLA_BARRAGE";

    case "power_semtex":
      return &"ZOMBIE_PILLAGE_PICKUP_SEMTEX";

    case "power_gasGrenade":
      return &"COOP_PILLAGE_PICKUP_GAS_GRENADE";

    case "power_clusterGrenade":
      return &"COOP_PILLAGE_PICKUP_CLUSTER_GRENADE";

    case "power_bioSpike":
      return &"COOP_PILLAGE_PICKUP_BIO_SPIKE";

    case "power_repulsor":
      return &"COOP_PILLAGE_PICKUP_REPULSOR";

    case "power_arcGrenade":
      return &"ZOMBIE_PILLAGE_PICKUP_ARC_GRENADE";

    case "power_c4":
      return &"ZOMBIE_PILLAGE_PICKUP_C4";

    case "power_concussionGrenade":
      return &"ZOMBIE_PILLAGE_PICKUP_CONCUSSION_GRENADE";

    case "maxammo":
      return &"COOP_PILLAGE_PICKUP_MAX_AMMO";

    case "money":
      return &"ZOMBIE_PILLAGE_PICKUP_POINTS";

    case "tickets":
      return &"ZOMBIE_PILLAGE_PICKUP_TICKETS";

    case "clip":
      return &"COOP_PILLAGE_PICKUP_CLIP";

    case "quest":
      return &"CP_QUEST_WOR_PART";

    case "battery":
      return &"CP_TOWN_PILLAGE_BATTERY";

    default:
      return undefined;
  }

  if(isDefined(level.var_7A07)) {
    return [[level.var_7A07]](var_0);
  }
}

func_5D00() {
  if(self.model != "tag_origin") {
    var_0 = 20;
    var_1 = (0, 0, 2);
    var_2 = (0, 0, 0);
    var_3 = getgroundposition(self.origin, 5, var_0);
    switch (self.model) {
      case "attachment_zmb_arcane_muzzlebrake_wm":
        var_2 = (0, 0, 6);
        break;
    }

    self.origin = var_3 + var_2;
  }
}

func_5189(var_0, var_1) {
  wait(0.25);
  while(scripts\engine\utility::istrue(self.inuse)) {
    wait(0.1);
  }

  if(isDefined(self.pillageinfo) && isDefined(self.type)) {
    self.pillageinfo.type = undefined;
  }

  if(isDefined(self.var_CB63)) {
    self.var_CB63 delete();
  }

  if(isDefined(self.fx)) {
    self.fx delete();
  }

  if(isDefined(self.var_F07F)) {
    self.var_F07F = undefined;
  }

  self.var_F073 = 4;
  if(scripts\engine\utility::array_contains(level.var_163C, self)) {
    level.var_163C = scripts\engine\utility::array_remove(level.var_163C, self);
  }

  self notify("stop_pillage_spot_think");
  var_0 delete();
}

func_7B82(var_0, var_1) {
  if(!scripts\engine\utility::flag("can_drop_coins")) {
    var_5 = ["quest"];
  } else {
    var_5 = [];
  }

  var_2 = func_7BEF(level.var_CB87, var_5);
  if(isDefined(var_0.var_4FFB)) {
    var_2 = var_0.var_4FFB;
  }

  switch (var_2) {
    case "explosive":
      var_0.randomintrange = func_3E8D();
      var_0.type = "explosive";
      var_0.var_C1 = 0;
      break;

    case "powers":
      var_0.randomintrange = func_3E8E();
      var_0.type = "powers";
      var_0.var_C1 = 0;
      break;

    case "clip":
      var_0.type = "clip";
      var_0.randomintrange = "clip";
      var_0.var_C1 = 1;
      break;

    case "maxammo":
      var_0.type = "maxammo";
      var_0.randomintrange = "maxammo";
      var_0.var_C1 = 1;
      break;

    case "money":
      var_0.type = "money";
      var_4 = int(scripts\engine\utility::random([1000, 500, 250, 200, 100, 50]));
      var_0.var_3C = var_4;
      var_0.randomintrange = "money";
      break;

    case "tickets":
      var_0.type = "tickets";
      var_0.randomintrange = "tickets";
      var_3 = randomint(100);
      var_0.var_3C = var_3;
      break;

    case "quest":
      if(isDefined(level.quest_create_pillage_interaction)) {
        [[level.quest_create_pillage_interaction]](var_0, var_1);
      }
      break;

    case "battery":
      var_0.type = "battery";
      var_0.randomintrange = "battery";
      var_0.var_C1 = 1;
      break;
  }

  return var_0;
}

func_7BEF(var_0, var_1) {
  if(isDefined(level.quest_pillage_func)) {
    var_2 = [[level.quest_pillage_func]]();
    if(isDefined(var_2)) {
      return var_2;
    }
  }

  var_3 = [];
  var_4 = 0;
  foreach(var_6 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_6.ref)) {
      continue;
    }

    if(var_6.var_3C35 == 0) {
      continue;
    }

    var_3[var_3.size] = var_6;
    var_4 = var_4 + var_6.var_3C35;
  }

  var_8 = randomintrange(0, var_4 + 1);
  var_9 = 0;
  foreach(var_6 in var_3) {
    var_9 = var_9 + var_6.var_3C35;
    if(var_8 <= var_9) {
      return var_6.ref;
    }
  }
}

func_100F2(var_0) {
  self endon("disconnect");
  if(isDefined(self.var_1304A)) {
    return;
  }

  var_1 = level.primaryprogressbarfontsize;
  var_2 = "objective";
  if(level.splitscreen) {
    var_1 = 1.3;
  }

  self.var_1304A = scripts\cp\utility::createprimaryprogressbartext(0, 25, var_1, var_2);
  self.var_1304A settext(var_0);
  self.var_1304A setpulsefx(50, 2000, 800);
  scripts\engine\utility::waittill_any_timeout(3, "death");
  self.var_1304A scripts\cp\utility::destroyelem();
  self.var_1304A = undefined;
}

func_3E90() {
  return scripts\engine\utility::random(level.var_138A1);
}

func_3E8C() {
  return scripts\engine\utility::random(level.pillageable_attachments);
}

func_3E8D() {
  return scripts\engine\utility::random(level.pillageable_explosives);
}

func_3E8E() {
  return scripts\engine\utility::random(level.pillageable_powers);
}

func_3E8F() {
  return scripts\engine\utility::random(["infinite_20", "ammo_max", "kill_50", "cash_2", "instakill_30"]);
}

func_12880(var_0, var_1, var_2) {
  var_3 = var_0.randomintrange;
  var_4 = var_0.var_1E2D;
  self.itempicked = var_3;
  level.transactionid = randomint(100);
  if(!isDefined(var_1)) {
    var_1 = level.powers[var_3].defaultslot;
  }

  thread scripts\cp\powers\coop_powers::givepower(var_3, var_1, undefined, undefined, undefined, 0, var_2);
  self playlocalsound("grenade_pickup");
  if(randomint(100) > 50) {
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
  } else {
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 5, 0, 0, 0);
  }

  scripts\engine\utility::waitframe();
  scripts\cp\zombies\zombie_analytics::func_AF82(1, self, var_0.type, self.itempicked, " None ", level.transactionid);
  var_0 notify("picked_up");
}

func_1287B(var_0) {
  var_1 = var_0.pillageinfo.randomintrange;
  var_2 = var_0.pillageinfo.var_1E2D;
  self.itempicked = var_1;
  level.transactionid = randomint(100);
  if(isDefined(level.var_1287A)) {
    if(![[level.var_1287A]]()) {
      return;
    }
  }

  if(self hasweapon(var_1) && self getrunningforwardpainanim(var_1) > 0) {
    var_3 = self getfractionmaxammo(var_1);
    if(var_3 < 1) {
      var_4 = self getweaponammoclip(var_1);
      self setweaponammoclip(var_1, var_4 + var_2);
      self playlocalsound("grenade_pickup");
      var_0.var_CB63 disableplayeruse(self);
      thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
      scripts\engine\utility::waitframe();
      scripts\cp\zombies\zombie_analytics::func_AF82(1, self, var_0.type, self.itempicked, " None ", level.transactionid);
      var_0 notify("picked_up");
      return;
    }

    scripts\cp\utility::setlowermessage("max_explosives", &"COOP_INTERACTIONS_EXPLO_MAX", 3);
    return;
  }

  var_5 = func_FFA4(level.var_C32B);
  self func_831C("other");
  if(!isDefined(var_5)) {
    self giveweapon(var_1);
    self setweaponammoclip(var_1, var_2);
    self playlocalsound("grenade_pickup");
    var_0.var_CB63 disableplayeruse(self);
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
    scripts\engine\utility::waitframe();
    scripts\cp\zombies\zombie_analytics::func_AF82(1, self, var_0.type, self.itempicked, " None ", level.transactionid);
    var_0 notify("picked_up");
    return;
  }

  self.itempicked = var_1;
  self.var_A037 = var_5;
  level.transactionid = randomint(100);
  scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037, level.transactionid);
  self takeweapon(var_5);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, var_2);
  self playlocalsound("grenade_pickup");
  thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  scripts\cp\zombies\zombie_analytics::func_AF82(1, self, var_0.type, self.itempicked, " None ", level.transactionid);
  var_0.var_CB63 setModel(getweaponmodel(var_5));
  var_6 = func_7A06(var_5);
  var_0.var_CB63 sethintstring(var_6);
  var_0.var_CB63 makeusable();
  var_0.pillageinfo = spawnStruct();
  var_0.pillageinfo.type = "explosive";
  var_0.pillageinfo.randomintrange = var_5;
  var_0.pillageinfo.var_1E2D = self.var_1131E;
  var_0.var_CB63 func_5D00();
}

func_FFA4(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;
  var_4 = self getweaponslistoffhands();
  foreach(var_6 in var_4) {
    foreach(var_8 in var_0) {
      if(var_6 != var_8) {
        continue;
      }

      if(isDefined(var_6) && var_6 != "none" && self getrunningforwardpainanim(var_6) > 0) {
        var_2 = var_6;
        var_3 = self getweaponammoclip(var_6);
        var_1 = 1;
        break;
      }

      if(var_1) {
        break;
      }
    }
  }

  if(isDefined(var_2)) {
    self.var_1131E = var_3;
  }

  return var_2;
}

func_38B7() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  if(issubstr(var_0, "iw7_cutie_zm") || issubstr(var_0, "iw7_cutier_zm")) {
    return 0;
  }

  var_1 = self getcurrentweapon();
  var_2 = weaponmaxammo(var_1);
  var_3 = weaponclipsize(var_1);
  var_4 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(var_1 == "iw7_axe_zm" || var_1 == "iw7_axe_zm_pap1" || var_1 == "iw7_axe_zm_pap2" || var_1 == "none" || scripts\cp\utility::weapon_is_dlc_melee(var_1) || var_1 == "iw7_katana_zm" || issubstr(var_1, "iw7_entangler")) {
    return 0;
  }

  if(issubstr(var_1, "iw7_fists")) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    return 0;
  }

  if(self getweaponammostock(var_1) < var_2) {
    return 1;
  }

  if(weapontype(var_1) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var_1)) {
    var_5 = self getweaponslistprimaries();
    foreach(var_7 in var_5) {
      if(var_7 == var_1) {
        continue;
      }

      var_2 = weaponmaxammo(var_7);
      var_3 = weaponclipsize(var_7);
      var_4 = scripts\cp\utility::getrawbaseweaponname(var_7);
      if(self getweaponammostock(var_7) < var_2) {
        return 1;
      }
    }
  }

  return 0;
}

setaimspreadmovementscale() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0);
  var_2 = weaponclipsize(var_0);
  if(weapontype(var_0) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var_0)) {
    var_3 = self getweaponslistprimaries();
    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isbulletweapon(var_0)) {
        continue;
      }

      var_2 = weaponclipsize(var_5);
      var_1 = scripts\cp\utility::getrawbaseweaponname(var_5);
      if(self getweaponammostock(var_5) < weaponmaxammo(var_5)) {
        var_6 = self getweaponammostock(var_5);
        self setweaponammostock(var_5, var_2 + var_6);
        self.itempicked = var_5;
      }

      return;
    }
  } else {
    var_6 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 + var_6);
    self.itempicked = scripts\cp\utility::getrawbaseweaponname(var_0);
  }

  self playlocalsound("weap_ammo_pickup");
}

func_82E8() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }

    var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);
    self.itempicked = var_3;
    var_4 = weaponmaxammo(var_2);
    var_5 = int(var_4 * scripts\cp\perks\prestige::prestige_getminammo());
    self setweaponammostock(var_2, var_5);
  }

  self playlocalsound("weap_ammo_pickup");
}

func_38BA() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }

    var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);
    var_4 = weaponmaxammo(var_2);
    var_5 = var_4;
    var_6 = self getweaponammostock(var_2);
    if(var_6 < var_5) {
      return 1;
    }
  }

  return 0;
}

pillage_item_drop_func(var_0, var_1, var_2) {
  if(![[level.should_drop_pillage]](var_2, var_1)) {
    return 0;
  }

  level thread func_10798(var_1);
  return 1;
}

func_FF3D(var_0, var_1) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  if(isDefined(self.entered_playspace) && !self.entered_playspace) {
    return 0;
  }

  if(!is_in_active_volume(var_1)) {
    return 0;
  }

  return 1;
}

is_in_active_volume(var_0) {
  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(var_0, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return 0;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(var_0, undefined, undefined, undefined, 1)) {
    return 0;
  }

  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  foreach(var_2 in level.active_spawn_volumes) {
    if(ispointinvolume(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

func_10798(var_0, var_1, var_2) {
  var_3 = 0;
  if(var_3) {
    var_4 = 2;
    var_5 = -150;
    var_6 = 50;
    level.var_A8F5 = gettime();
    level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D, level.var_CB5C);
    var_7 = spawn("script_model", var_0 + (0, 0, 80));
    var_7.angles = (0, 0, 0);
    var_8 = scripts\engine\utility::random(level.var_CB5E);
    var_7 setModel(var_8);
    scripts\engine\utility::waitframe();
    var_9 = trajectorycalculateinitialvelocity(var_0 + (0, 0, 80), var_0 + (0, 0, 80) + (randomintrange(-10, 10), randomintrange(-10, 10), 0), (0, 0, var_5), 2);
    var_7 physicslaunchserver(var_7.origin + (randomintrange(-5, 5), randomintrange(-5, 5), 0), var_9 * var_4, var_6);
  } else {
    var_4 = 10;
    var_5 = 800;
    var_6 = 50;
    var_7 = spawn("script_model", var_1);
    if(isDefined(var_1)) {
      var_7.angles = var_1;
    } else {
      var_7.angles = (0, 0, 0);
    }

    var_7 setModel(var_2);
    scripts\engine\utility::waitframe();
    var_7 physicslaunchserver(var_7.origin + (12, 0, 0), (0, 0, 0));
  }

  for(;;) {
    var_10 = var_7.origin;
    wait(0.25);
    if(distance(var_10, var_7.origin) < 8) {
      break;
    }
  }

  if(ispointonnavmesh(var_7.origin)) {
    level.var_A8F5 = gettime();
    level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D, level.var_CB5C);
    var_11 = func_4934(var_7);
    return;
  }

  var_7 scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_7.origin);
  var_7 delete();
}

func_4934(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.script_noteworthy = "pillage_item";
  var_1.var_457D = func_7B82(var_1, var_0);
  var_1.var_CB47 = func_7A06(var_1.randomintrange);
  var_1.var_A038 = func_7A09(var_1.randomintrange);
  var_1.requires_power = 0;
  var_1.powered_on = 1;
  var_1.script_parameters = "default";
  var_1.custom_search_dist = 96;
  var_1 setModel(var_0.model);
  var_0 delete();
  var_1 thread func_13971();
  var_1 thread func_5135(var_1);
  level.var_163C[level.var_163C.size] = var_1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  if(var_1.type == "battery") {
    var_2 = spawn("script_model", var_1.origin + (0, 0, 20));
    var_3 = spawnfx(level._effect["pillage_box"], var_1.origin);
    scripts\engine\utility::waitframe();
    triggerfx(var_3);
    scripts\engine\utility::waitframe();
    var_2 setModel("crafting_battery_single_01");
    var_1 scripts\engine\utility::waittill_any_timeout(60, "all_players_searched");
    if(isDefined(var_2)) {
      var_2 delete();
    }

    if(isDefined(var_3)) {
      var_3 delete();
    }
  } else if(var_1.type != "quest" && var_1.type != "battery") {
    var_3 = spawnfx(level._effect["pillage_box"], var_1.origin);
    scripts\engine\utility::waitframe();
    triggerfx(var_3);
    var_1 scripts\engine\utility::waittill_any_timeout(60, "all_players_searched");
    if(isDefined(var_3)) {
      var_3 delete();
    }
  } else {
    var_1 scripts\engine\utility::waittill_any_timeout(60, "all_players_searched");
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
}

pillage_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.inlaststand)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(isDefined(var_0.var_CB47)) {
    return var_0.var_CB47;
  }

  return "";
}

func_7B80(var_0) {
  switch (var_0) {}
}

func_4ED7(var_0) {
  var_1 = strtok(var_0, "+");
  var_2 = var_1[0];
  var_3 = var_1[1];
  foreach(var_5 in level.spawned_enemies) {
    var_5 setscriptablepartstate(var_2, var_3);
  }
}