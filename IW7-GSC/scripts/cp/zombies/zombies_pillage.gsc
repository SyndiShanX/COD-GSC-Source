/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

register_zombie_pillageable(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.part = param_01;
  var_05.model = param_03;
  var_05.var_AAB6 = param_04;
  var_05.var_AAB3 = param_02;
  level.var_13F49[param_00] = var_05;
}

func_6690(param_00) {
  if(!scripts\engine\utility::flag("pillage_enabled")) {
    return;
  }

  if(!func_381B(param_00)) {
    return;
  }

  var_01 = scripts\engine\utility::random(func_7B81(param_00));
  if(isDefined(var_01)) {
    level.var_C1FC++;
    param_00 thread func_136B6(param_00);
    func_668F(param_00, var_01);
  }
}

func_136B6(param_00) {
  param_00 waittill("death");
  level.var_C1FC--;
}

func_668F(param_00, param_01) {
  var_02 = level.var_13F49[param_01].part;
  param_00 setscriptablepartstate(var_02, param_01);
  param_00.has_backpack = param_01;
}

func_381B(param_00) {
  if(param_00 scripts\asm\zombie\zombie::func_9E0F()) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.karatemaster)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.is_cop)) {
    return 0;
  }

  return 1;
}

func_50AF(param_00) {
  wait(5);
  param_00 delete();
}

func_7B81(param_00) {
  if(level.var_C1FC >= level.var_B44A) {
    return [];
  } else if(level.var_BF51 > gettime()) {
    return [];
  } else if(randomint(100) <= 100) {
    var_01 = func_7DB3(param_00.model);
    return var_01;
  }

  return [];
}

func_7DB3(param_00) {
  if(!isDefined(level.var_13F49)) {
    return [];
  }

  switch (param_00) {
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

pillageable_piece_lethal_monitor(param_00, param_01, param_02) {
  var_03 = level.var_13F49[param_01].var_AAB3;
  var_04 = level.var_13F49[param_01].var_AAB6;
  var_05 = param_00 gettagorigin(var_04);
  var_06 = param_00 gettagangles(var_04);
  if(param_00[[level.should_drop_pillage]](param_02, var_05)) {
    level thread func_10798(var_05, var_06, var_03);
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

func_31AF(param_00) {
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

func_31AE(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  var_02 = spawnStruct();
  var_02.ref = param_00;
  var_02.var_3C35 = param_01;
  level.var_CB87[level.var_CB87.size] = var_02;
}

player_used_pillage_spot(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.inlaststand)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return;
  }

  if(param_01 scripts\cp\utility::is_holding_deployable() || param_01 scripts\cp\utility::has_special_weapon()) {
    return;
  }

  switch (param_00.type) {
    case "explosive":
      param_00 notify("all_players_searched");
      param_01 func_12880(param_00, "primary", 1);
      break;

    case "powers":
      param_00 notify("all_players_searched");
      param_01 func_12880(param_00, "secondary", 0);
      break;

    case "maxammo":
      if(param_01 func_38BA()) {
        param_01 _meth_82E8();
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        scripts\engine\utility::waitframe();
        param_00 notify("all_players_searched");
      } else {
        param_01 scripts\cp\utility::setlowermessage("max_ammo", & "COOP_GAME_PLAY_AMMO_MAX", 3);
      }
      break;

    case "money":
      if(param_01 scripts\cp\cp_persistence::get_player_currency() < param_01.maxcurrency) {
        if(soundexists(param_01.vo_prefix + "pillage_cash")) {
          param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_cash", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else {
          param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        }

        param_01 scripts\cp\cp_persistence::give_player_currency(param_00.var_3C, undefined, undefined, 1, "pillage");
        param_00 notify("all_players_searched");
      } else {
        param_01 scripts\cp\utility::setlowermessage("max_money", & "COOP_GAME_PLAY_MONEY_MAX", 3);
      }
      break;

    case "tickets":
      param_01 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_01, param_00.var_3C);
      param_00 notify("all_players_searched");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
      break;

    case "clip":
      if(param_01 func_38B7()) {
        param_01 setaimspreadmovementscale();
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        scripts\engine\utility::waitframe();
        param_00 notify("all_players_searched");
      } else {
        var_02 = param_01 scripts\cp\utility::getvalidtakeweapon();
        if(issubstr(var_02, "iw7_cutie_zm") || issubstr(var_02, "iw7_cutier_zm")) {
          param_01 scripts\cp\utility::setlowermessage("invalid_ammo", & "CP_TOWN_INVALID_AMMO", 3);
        } else {
          param_01 scripts\cp\utility::setlowermessage("max_ammo", & "COOP_GAME_PLAY_AMMO_MAX", 3);
        }

        return;
      }
      break;

    case "quest":
      if(isDefined(level.quest_specific_pillage_show_func)) {
        param_01[[level.quest_specific_pillage_show_func]](var_02, "pickup", param_01);
      }

      break;

    case "battery":
      if(scripts\engine\utility::istrue(var_02.has_battery)) {
        var_02 scripts\cp\utility::setlowermessage("have_battery", & "CP_TOWN_HAVE_BATTERY", 4);
        return;
      }

      if(isDefined(level.quest_pillage_give_func)) {
        var_02 thread[[level.quest_pillage_give_func]](var_02);
      }

      param_01 notify("all_players_searched");
      var_02 thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
      break;

    default:
      if(isDefined(level.var_ABE7)) {
        param_01[[level.var_ABE7]](var_02, "pick_up");
      }
      break;
  }

  if(isDefined(param_01.var_A038)) {
    var_02 thread func_100F2(param_01.var_A038);
  }

  var_02 playlocalsound("zmb_item_pickup");
  var_02 thread scripts\cp\utility::usegrenadegesture(var_02, "iw7_pickup_zm");
}

gesture_activate(param_00, param_01, param_02, param_03) {
  self notify("forcingGesture");
  self endon("forcingGesture");
  self allowmelee(0);
  scripts\engine\utility::allow_ads(0);
  if(scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(0);
  }

  if(self isgestureplaying(param_00)) {
    self stopgestureviewmodel(param_00, 0);
  }

  var_04 = self getgestureanimlength(param_00) * 0.4;
  var_05 = self playgestureviewmodel(param_00, param_01, 1);
  if(var_05) {
    var_06 = func_7DCA(param_00);
    self playanimscriptevent("power_active_cp", var_06);
    wait(var_04);
  }

  self allowmelee(1);
  scripts\engine\utility::allow_ads(1);
  if(!scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }
}

func_7DCA(param_00) {
  switch (param_00) {
    default:
      return "gesture008";
  }
}

_meth_831A(param_00) {
  self endon("all_players_searched");
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(param_00)) {
    var_01 = param_00 getcurrentweapon();
    var_02 = scripts\cp\utility::getrawbaseweaponname(var_01);
    param_00 takeweapon(var_01);
    param_00.var_A037 = var_02;
    level.transactionid = randomint(100);
    scripts\cp\zombies\zombie_analytics::func_AF76(param_00.var_A037, level.transactionid);
    if(isDefined(param_00.pap[var_02])) {
      param_00.pap[var_02] = undefined;
      param_00 notify("weapon_level_changed");
    }
  }

  var_03 = self.pillageinfo.randomintrange.var_394;
  var_04 = scripts\cp\utility::getrawbaseweaponname(var_03);
  param_00.itempicked = var_04;
  param_00 giveweapon(var_03);
  if(!isDefined(param_00.itemkills[var_04])) {
    param_00.itemkills[var_04] = 0;
  }

  param_00 switchtoweapon(var_03);
  var_05 = spawnStruct();
  var_05.lvl = 1;
  param_00.pap[var_04] = var_05;
  param_00 notify("weapon_level_changed");
  self notify("weapon_taken");
}

func_5135(param_00) {
  thread func_13971();
  var_01 = scripts\engine\utility::waittill_any_timeout_1(60, "stop_pillage_spot_think", "all_players_searched", "redistributed_pillage_spots");
  var_02 = var_01 != "redistributed_pillage_spots";
  self.var_A032 = param_00.model;
  thread func_5189(param_00, var_02);
}

func_10D4C() {
  wait(60);
  self notify("all_players_searched");
}

func_13971() {
  self endon("all_players_searched");
  for(;;) {
    scripts\engine\utility::waittill_any_3("picked_up", "swapped");
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

func_7A09(param_00) {
  param_00 = "" + param_00;
  switch (param_00) {
    case "power_bolaSpray":
      return & "ZOMBIE_PILLAGE_FOUND_BOLA_BARRAGE";

    case "power_semtex":
      return & "ZOMBIE_PILLAGE_FOUND_SEMTEX";

    case "power_splashGrenade":
      return & "ZOMBIE_PILLAGE_FOUND_PLASMA_GRENADE";

    case "power_bioSpike":
      return & "COOP_PILLAGE_FOUND_BIO_SPIKE";

    case "power_gasGrenade":
      return & "COOP_PILLAGE_FOUND_GAS_GRENADE";

    case "power_clusterGrenade":
      return & "COOP_PILLAGE_FOUND_CLUSTER_GRENADE";

    case "power_repulsor":
      return & "COOP_PILLAGE_FOUND_REPULSOR";

    case "power_frag":
      return & "ZOMBIE_PILLAGE_FOUND_FRAG_GRENADE";

    case "power_arcGrenade":
      return & "ZOMBIE_PILLAGE_FOUND_ARC_GRENADE";

    case "power_c4":
      return & "ZOMBIE_PILLAGE_FOUND_C4";

    case "power_concussionGrenade":
      return & "ZOMBIE_PILLAGE_FOUND_CONCUSSION_GRENADES";

    case "maxammo":
      return & "COOP_PILLAGE_FOUND_MAX_AMMO";

    case "clip":
      return & "COOP_PILLAGE_FOUND_CLIP";

    case "tickets":
      return & "ZOMBIE_PILLAGE_FOUND_TICKETS";

    default:
      return undefined;
  }

  if(isDefined(level.var_7A0A)) {
    return [[level.var_7A0A]](param_00);
  }
}

func_7A06(param_00) {
  param_00 = "" + param_00;
  switch (param_00) {
    case "power_frag":
      return & "ZOMBIE_PILLAGE_PICKUP_FRAG_GRENADE";

    case "power_splashGrenade":
      return & "ZOMBIE_PILLAGE_PICKUP_PLASMA_GRENADE";

    case "power_bolaSpray":
      return & "ZOMBIE_PILLAGE_PICKUP_BOLA_BARRAGE";

    case "power_semtex":
      return & "ZOMBIE_PILLAGE_PICKUP_SEMTEX";

    case "power_gasGrenade":
      return & "COOP_PILLAGE_PICKUP_GAS_GRENADE";

    case "power_clusterGrenade":
      return & "COOP_PILLAGE_PICKUP_CLUSTER_GRENADE";

    case "power_bioSpike":
      return & "COOP_PILLAGE_PICKUP_BIO_SPIKE";

    case "power_repulsor":
      return & "COOP_PILLAGE_PICKUP_REPULSOR";

    case "power_arcGrenade":
      return & "ZOMBIE_PILLAGE_PICKUP_ARC_GRENADE";

    case "power_c4":
      return & "ZOMBIE_PILLAGE_PICKUP_C4";

    case "power_concussionGrenade":
      return & "ZOMBIE_PILLAGE_PICKUP_CONCUSSION_GRENADE";

    case "maxammo":
      return & "COOP_PILLAGE_PICKUP_MAX_AMMO";

    case "money":
      return & "ZOMBIE_PILLAGE_PICKUP_POINTS";

    case "tickets":
      return & "ZOMBIE_PILLAGE_PICKUP_TICKETS";

    case "clip":
      return & "COOP_PILLAGE_PICKUP_CLIP";

    case "quest":
      return & "CP_QUEST_WOR_PART";

    case "battery":
      return & "CP_TOWN_PILLAGE_BATTERY";

    default:
      return undefined;
  }

  if(isDefined(level.var_7A07)) {
    return [[level.var_7A07]](param_00);
  }
}

func_5D00() {
  if(self.model != "tag_origin") {
    var_00 = 20;
    var_01 = (0, 0, 2);
    var_02 = (0, 0, 0);
    var_03 = getgroundposition(self.origin, 5, var_00);
    switch (self.model) {
      case "attachment_zmb_arcane_muzzlebrake_wm":
        var_02 = (0, 0, 6);
        break;
    }

    self.origin = var_03 + var_02;
  }
}

func_5189(param_00, param_01) {
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
  param_00 delete();
}

func_7B82(param_00, param_01) {
  if(!scripts\engine\utility::flag("can_drop_coins")) {
    var_05 = ["quest"];
  } else {
    var_05 = [];
  }

  var_02 = func_7BEF(level.var_CB87, var_05);
  if(isDefined(param_00.var_4FFB)) {
    var_02 = param_00.var_4FFB;
  }

  switch (var_02) {
    case "explosive":
      param_00.randomintrange = func_3E8D();
      param_00.type = "explosive";
      param_00.var_C1 = 0;
      break;

    case "powers":
      param_00.randomintrange = func_3E8E();
      param_00.type = "powers";
      param_00.var_C1 = 0;
      break;

    case "clip":
      param_00.type = "clip";
      param_00.randomintrange = "clip";
      param_00.var_C1 = 1;
      break;

    case "maxammo":
      param_00.type = "maxammo";
      param_00.randomintrange = "maxammo";
      param_00.var_C1 = 1;
      break;

    case "money":
      param_00.type = "money";
      var_04 = int(scripts\engine\utility::random([1000, 500, 250, 200, 100, 50]));
      param_00.var_3C = var_04;
      param_00.randomintrange = "money";
      break;

    case "tickets":
      param_00.type = "tickets";
      param_00.randomintrange = "tickets";
      var_03 = randomint(100);
      param_00.var_3C = var_03;
      break;

    case "quest":
      if(isDefined(level.quest_create_pillage_interaction)) {
        [
          [level.quest_create_pillage_interaction]
        ](param_00, param_01);
      }
      break;

    case "battery":
      param_00.type = "battery";
      param_00.randomintrange = "battery";
      param_00.var_C1 = 1;
      break;
  }

  return param_00;
}

func_7BEF(param_00, param_01) {
  if(isDefined(level.quest_pillage_func)) {
    var_02 = [[level.quest_pillage_func]]();
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  var_03 = [];
  var_04 = 0;
  foreach(var_06 in param_00) {
    if(scripts\engine\utility::array_contains(param_01, var_06.ref)) {
      continue;
    }

    if(var_06.var_3C35 == 0) {
      continue;
    }

    var_03[var_03.size] = var_06;
    var_04 = var_04 + var_06.var_3C35;
  }

  var_08 = randomintrange(0, var_04 + 1);
  var_09 = 0;
  foreach(var_06 in var_03) {
    var_09 = var_09 + var_06.var_3C35;
    if(var_08 <= var_09) {
      return var_06.ref;
    }
  }
}

func_100F2(param_00) {
  self endon("disconnect");
  if(isDefined(self.var_1304A)) {
    return;
  }

  var_01 = level.primaryprogressbarfontsize;
  var_02 = "objective";
  if(level.splitscreen) {
    var_01 = 1.3;
  }

  self.var_1304A = scripts\cp\utility::createprimaryprogressbartext(0, 25, var_01, var_02);
  self.var_1304A settext(param_00);
  self.var_1304A setpulsefx(50, 2000, 800);
  scripts\engine\utility::waittill_any_timeout_1(3, "death");
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

func_12880(param_00, param_01, param_02) {
  var_03 = param_00.randomintrange;
  var_04 = param_00.var_1E2D;
  self.itempicked = var_03;
  level.transactionid = randomint(100);
  if(!isDefined(param_01)) {
    param_01 = level.powers[var_03].defaultslot;
  }

  thread scripts\cp\powers\coop_powers::givepower(var_03, param_01, undefined, undefined, undefined, 0, param_02);
  self playlocalsound("grenade_pickup");
  if(randomint(100) > 50) {
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
  } else {
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_generic", "zmb_comment_vo", "medium", 5, 0, 0, 0);
  }

  scripts\engine\utility::waitframe();
  scripts\cp\zombies\zombie_analytics::func_AF82(1, self, param_00.type, self.itempicked, " None ", level.transactionid);
  param_00 notify("picked_up");
}

func_1287B(param_00) {
  var_01 = param_00.pillageinfo.randomintrange;
  var_02 = param_00.pillageinfo.var_1E2D;
  self.itempicked = var_01;
  level.transactionid = randomint(100);
  if(isDefined(level.var_1287A)) {
    if(![
        [level.var_1287A]
      ]()) {
      return;
    }
  }

  if(self hasweapon(var_01) && self getrunningforwardpainanim(var_01) > 0) {
    var_03 = self getfractionmaxammo(var_01);
    if(var_03 < 1) {
      var_04 = self getweaponammoclip(var_01);
      self setweaponammoclip(var_01, var_04 + var_02);
      self playlocalsound("grenade_pickup");
      param_00.var_CB63 disableplayeruse(self);
      thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
      scripts\engine\utility::waitframe();
      scripts\cp\zombies\zombie_analytics::func_AF82(1, self, param_00.type, self.itempicked, " None ", level.transactionid);
      param_00 notify("picked_up");
      return;
    }

    scripts\cp\utility::setlowermessage("max_explosives", & "COOP_INTERACTIONS_EXPLO_MAX", 3);
    return;
  }

  var_05 = func_FFA4(level.var_C32B);
  self _meth_831C("other");
  if(!isDefined(var_05)) {
    self giveweapon(var_01);
    self setweaponammoclip(var_01, var_02);
    self playlocalsound("grenade_pickup");
    param_00.var_CB63 disableplayeruse(self);
    thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
    scripts\engine\utility::waitframe();
    scripts\cp\zombies\zombie_analytics::func_AF82(1, self, param_00.type, self.itempicked, " None ", level.transactionid);
    param_00 notify("picked_up");
    return;
  }

  self.itempicked = var_01;
  self.var_A037 = var_05;
  level.transactionid = randomint(100);
  scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037, level.transactionid);
  self takeweapon(var_05);
  self giveweapon(var_01);
  self setweaponammoclip(var_01, var_02);
  self playlocalsound("grenade_pickup");
  thread scripts\cp\cp_vo::try_to_play_vo("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  scripts\cp\zombies\zombie_analytics::func_AF82(1, self, param_00.type, self.itempicked, " None ", level.transactionid);
  param_00.var_CB63 setModel(getweaponmodel(var_05));
  var_06 = func_7A06(var_05);
  param_00.var_CB63 sethintstring(var_06);
  param_00.var_CB63 makeusable();
  param_00.pillageinfo = spawnStruct();
  param_00.pillageinfo.type = "explosive";
  param_00.pillageinfo.randomintrange = var_05;
  param_00.pillageinfo.var_1E2D = self.var_1131E;
  param_00.var_CB63 func_5D00();
}

func_FFA4(param_00) {
  var_01 = 0;
  var_02 = undefined;
  var_03 = 0;
  var_04 = self getweaponslistoffhands();
  foreach(var_06 in var_04) {
    foreach(var_08 in param_00) {
      if(var_06 != var_08) {
        continue;
      }

      if(isDefined(var_06) && var_06 != "none" && self getrunningforwardpainanim(var_06) > 0) {
        var_02 = var_06;
        var_03 = self getweaponammoclip(var_06);
        var_01 = 1;
        break;
      }

      if(var_01) {
        break;
      }
    }
  }

  if(isDefined(var_02)) {
    self.var_1131E = var_03;
  }

  return var_02;
}

func_38B7() {
  var_00 = scripts\cp\utility::getvalidtakeweapon();
  if(issubstr(var_00, "iw7_cutie_zm") || issubstr(var_00, "iw7_cutier_zm")) {
    return 0;
  }

  var_01 = self getcurrentweapon();
  var_02 = weaponmaxammo(var_01);
  var_03 = weaponclipsize(var_01);
  var_04 = scripts\cp\utility::getrawbaseweaponname(var_01);
  if(var_01 == "iw7_axe_zm" || var_01 == "iw7_axe_zm_pap1" || var_01 == "iw7_axe_zm_pap2" || var_01 == "none" || scripts\cp\utility::weapon_is_dlc_melee(var_01) || var_01 == "iw7_katana_zm" || issubstr(var_01, "iw7_entangler")) {
    return 0;
  }

  if(issubstr(var_01, "iw7_fists")) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    return 0;
  }

  if(self getweaponammostock(var_01) < var_02) {
    return 1;
  }

  if(weapontype(var_01) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var_01)) {
    var_05 = self getweaponslistprimaries();
    foreach(var_07 in var_05) {
      if(var_07 == var_01) {
        continue;
      }

      var_02 = weaponmaxammo(var_07);
      var_03 = weaponclipsize(var_07);
      var_04 = scripts\cp\utility::getrawbaseweaponname(var_07);
      if(self getweaponammostock(var_07) < var_02) {
        return 1;
      }
    }
  }

  return 0;
}

setaimspreadmovementscale() {
  var_00 = self getcurrentweapon();
  var_01 = scripts\cp\utility::getrawbaseweaponname(var_00);
  var_02 = weaponclipsize(var_00);
  if(weapontype(var_00) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var_00)) {
    var_03 = self getweaponslistprimaries();
    foreach(var_05 in var_03) {
      if(var_05 == var_00) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isbulletweapon(var_00)) {
        continue;
      }

      var_02 = weaponclipsize(var_05);
      var_01 = scripts\cp\utility::getrawbaseweaponname(var_05);
      if(self getweaponammostock(var_05) < weaponmaxammo(var_05)) {
        var_06 = self getweaponammostock(var_05);
        self setweaponammostock(var_05, var_02 + var_06);
        self.itempicked = var_05;
      }

      return;
    }
  } else {
    var_06 = self getweaponammostock(var_00);
    self setweaponammostock(var_00, var_02 + var_06);
    self.itempicked = scripts\cp\utility::getrawbaseweaponname(var_00);
  }

  self playlocalsound("weap_ammo_pickup");
}

_meth_82E8() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(weapontype(var_02) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_02)) {
      continue;
    }

    var_03 = scripts\cp\utility::getrawbaseweaponname(var_02);
    self.itempicked = var_03;
    var_04 = weaponmaxammo(var_02);
    var_05 = int(var_04 * scripts\cp\perks\prestige::prestige_getminammo());
    self setweaponammostock(var_02, var_05);
  }

  self playlocalsound("weap_ammo_pickup");
}

func_38BA() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(weapontype(var_02) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_02)) {
      continue;
    }

    var_03 = scripts\cp\utility::getrawbaseweaponname(var_02);
    var_04 = weaponmaxammo(var_02);
    var_05 = var_04;
    var_06 = self getweaponammostock(var_02);
    if(var_06 < var_05) {
      return 1;
    }
  }

  return 0;
}

pillage_item_drop_func(param_00, param_01, param_02) {
  if(![[level.should_drop_pillage]](param_02, param_01)) {
    return 0;
  }

  level thread func_10798(param_01);
  return 1;
}

func_FF3D(param_00, param_01) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  if(isDefined(self.entered_playspace) && !self.entered_playspace) {
    return 0;
  }

  if(!is_in_active_volume(param_01)) {
    return 0;
  }

  return 1;
}

is_in_active_volume(param_00) {
  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(param_00, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return 0;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(param_00, undefined, undefined, undefined, 1)) {
    return 0;
  }

  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  foreach(var_02 in level.active_spawn_volumes) {
    if(ispointinvolume(param_00, var_02)) {
      return 1;
    }
  }

  return 0;
}

func_10798(param_00, param_01, param_02) {
  var_03 = 0;
  if(var_03) {
    var_04 = 2;
    var_05 = -150;
    var_06 = 50;
    level.var_A8F5 = gettime();
    level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D, level.var_CB5C);
    var_07 = spawn("script_model", param_00 + (0, 0, 80));
    var_07.angles = (0, 0, 0);
    var_08 = scripts\engine\utility::random(level.var_CB5E);
    var_07 setModel(var_08);
    scripts\engine\utility::waitframe();
    var_09 = trajectorycalculateinitialvelocity(param_00 + (0, 0, 80), param_00 + (0, 0, 80) + (randomintrange(-10, 10), randomintrange(-10, 10), 0), (0, 0, var_05), 2);
    var_07 physicslaunchserver(var_07.origin + (randomintrange(-5, 5), randomintrange(-5, 5), 0), var_09 * var_04, var_06);
  } else {
    var_04 = 10;
    var_05 = 800;
    var_06 = 50;
    var_07 = spawn("script_model", param_01);
    if(isDefined(param_01)) {
      var_07.angles = param_01;
    } else {
      var_07.angles = (0, 0, 0);
    }

    var_07 setModel(param_02);
    scripts\engine\utility::waitframe();
    var_07 physicslaunchserver(var_07.origin + (12, 0, 0), (0, 0, 0));
  }

  for(;;) {
    var_0A = var_07.origin;
    wait(0.25);
    if(distance(var_0A, var_07.origin) < 8) {
      break;
    }
  }

  if(ispointonnavmesh(var_07.origin)) {
    level.var_A8F5 = gettime();
    level.var_BF51 = level.var_A8F5 + randomintrange(level.var_CB5D, level.var_CB5C);
    var_0B = func_4934(var_07);
    return;
  }

  var_07 scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_07.origin);
  var_07 delete();
}

func_4934(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01.origin = param_00.origin;
  var_01.angles = param_00.angles;
  var_01.script_noteworthy = "pillage_item";
  var_01.var_457D = func_7B82(var_01, param_00);
  var_01.var_CB47 = func_7A06(var_01.randomintrange);
  var_01.var_A038 = func_7A09(var_01.randomintrange);
  var_01.requires_power = 0;
  var_01.powered_on = 1;
  var_01.script_parameters = "default";
  var_01.custom_search_dist = 96;
  var_01 setModel(param_00.model);
  param_00 delete();
  var_01 thread func_13971();
  var_01 thread func_5135(var_01);
  level.var_163C[level.var_163C.size] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  if(var_01.type == "battery") {
    var_02 = spawn("script_model", var_01.origin + (0, 0, 20));
    var_03 = spawnfx(level._effect["pillage_box"], var_01.origin);
    scripts\engine\utility::waitframe();
    triggerfx(var_03);
    scripts\engine\utility::waitframe();
    var_02 setModel("crafting_battery_single_01");
    var_01 scripts\engine\utility::waittill_any_timeout_1(60, "all_players_searched");
    if(isDefined(var_02)) {
      var_02 delete();
    }

    if(isDefined(var_03)) {
      var_03 delete();
    }
  } else if(var_01.type != "quest" && var_01.type != "battery") {
    var_03 = spawnfx(level._effect["pillage_box"], var_01.origin);
    scripts\engine\utility::waitframe();
    triggerfx(var_03);
    var_01 scripts\engine\utility::waittill_any_timeout_1(60, "all_players_searched");
    if(isDefined(var_03)) {
      var_03 delete();
    }
  } else {
    var_01 scripts\engine\utility::waittill_any_timeout_1(60, "all_players_searched");
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
}

pillage_hint_func(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.inlaststand)) {
    return "";
  }

  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return "";
  }

  if(isDefined(param_00.var_CB47)) {
    return param_00.var_CB47;
  }

  return "";
}

func_7B80(param_00) {
  switch (param_00) {}
}

func_4ED7(param_00) {
  var_01 = strtok(param_00, "+");
  var_02 = var_01[0];
  var_03 = var_01[1];
  foreach(var_05 in level.spawned_enemies) {
    var_05 setscriptablepartstate(var_02, var_03);
  }
}