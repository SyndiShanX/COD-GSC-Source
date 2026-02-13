/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2464.gsc
*************************************************/

_id_8050() {
  scripts\engine\utility::_id_5C11("can_drop_coins");
  scripts\engine\utility::_id_5C11("pillage_enabled");
  level._id_9C2A = 1;
  level._id_A75C = 0;
  level._id_8F47 = 30000;
  level._id_B0C2 = 15000;
  level._id_B0C1 = 45000;
  level._id_A478 = level._id_8F47 + randomintrange(level._id_B0C2, level._id_B0C1);
  level._id_B0C0 = ::_id_B0C0;
  level._id_DA9B = ::_id_DA9C;
  level._id_0F25 = [];
}

_id_C239(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_AE77 = var_1;
  var_5.model = var_3;
  var_5._id_9100 = var_4;
  var_5._id_90FA = var_2;
  level._id_1103A[var_0] = var_5;
}

_id_554B(var_0) {
  if(!scripts\engine\utility::_id_5C00("pillage_enabled")) {
    return;
  }
  if(!_id_30C4(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::random(_id_665C(var_0));

  if(isDefined(var_1) && var_1.size > 0) {
    level._id_A75C++;
    var_0 thread _id_107FF(var_0);
    _id_554A(var_0, var_1);
  }
}

_id_107FF(var_0) {
  var_0 waittill("death");
  level._id_A75C--;
}

_id_554A(var_0, var_1) {
  var_2 = level._id_1103A[var_1]._id_AE77;
  var_0 setscriptablepartstate(var_2, var_1);
  var_0._id_74D9 = var_1;
}

_id_30C4(var_0) {
  if(var_0 _id_0909::_id_887B()) {
    return 0;
  }

  if(istrue(var_0._id_8CAB)) {
    return 0;
  }

  if(istrue(var_0._id_8584)) {
    return 0;
  }

  return 1;
}

_id_464F(var_0) {
  wait 5.0;
  var_0 delete();
}

_id_665C(var_0) {
  if(level._id_A75C >= level._id_9C2A) {
    return [];
  } else if(level._id_A478 > gettime()) {
    return [];
  } else if(randomint(100) <= 100) {
    var_1 = _id_68A8(var_0.model);
    return var_1;
  }

  return [];
}

_id_68A8(var_0) {
  if(!isDefined(level._id_1103A)) {
    return [];
  }

  switch (var_0) {
    case "zombie_male_outfit_2_5_b":
    case "zombie_male_outfit_2_4_b":
    case "zombie_male_outfit_4_2_b":
    case "zombie_male_outfit_4_b":
    case "zombie_male_outfit_5_3_b":
    case "zombie_male_outfit_5_2_b":
    case "zombie_male_outfit_2_2_c":
    case "zombie_male_outfit_2_c":
    case "zombie_male_outfit_2_6_c":
    case "zombie_male_outfit_2_5_c":
    case "zombie_male_outfit_2_4_c":
    case "zombie_male_outfit_2_3_c":
    case "zombie_male_outfit_3_2_c":
    case "zombie_male_outfit_3_c":
    case "zombie_male_outfit_1_2_c":
    case "zombie_male_outfit_1_c":
    case "zombie_female_outfit_4":
    case "zombie_female_outfit_3_3":
    case "zombie_female_outfit_3_2":
    case "zombie_female_outfit_3":
    case "zombie_female_outfit_1":
    case "zombie_male_outfit_6_2_c":
    case "zombie_female_outfit_6_3":
    case "zombie_female_outfit_6_2":
    case "zombie_female_outfit_7_3":
    case "zombie_female_outfit_7_2":
    case "zombie_female_outfit_7":
    case "zombie_female_outfit_4_3":
    case "zombie_female_outfit_4_2":
    case "zombie_male_outfit_6_c":
    case "zombie_male_outfit_5_3_c":
    case "zombie_male_outfit_2_b":
    case "zombie_male_outfit_1_2_b":
    case "zombie_male_outfit_4_c":
    case "zombie_male_outfit_3_3_c":
    case "zombie_male_outfit_5_b":
    case "zombie_male_outfit_4_3_b":
    case "zombie_female_outfit_2":
    case "zombie_female_outfit_1_2":
    case "zombie_female_outfit_2_3":
    case "zombie_female_outfit_2_2":
    case "zombie_male_outfit_5_2_c":
    case "zombie_male_outfit_5_c":
    case "zombie_male_outfit_4_3_c":
    case "zombie_male_outfit_4_2_c":
    case "zombie_male_outfit_6_2_b":
    case "zombie_male_outfit_6_b":
    case "zombie_male_outfit_3_2":
    case "zombie_male_outfit_3":
    case "zombie_male_outfit_4_3":
    case "zombie_male_outfit_4_2":
    case "zombie_male_outfit_2_2":
    case "zombie_male_outfit_2":
    case "zombie_male_outfit_2_6":
    case "zombie_male_outfit_2_5":
    case "zombie_male_outfit_2_4":
    case "zombie_male_outfit_2_3":
    case "zombie_male_outfit_1_2":
    case "zombie_male_outfit_1":
    case "zombie_female_outfit_6":
    case "zombie_female_outfit_5_3":
    case "zombie_male_outfit_1_b":
    case "zombie_male_outfit_6_2":
    case "zombie_male_outfit_6":
    case "zombie_male_outfit_5_3":
    case "zombie_female_outfit_5_2":
    case "zombie_female_outfit_5":
    case "zombie_male_outfit_4":
    case "zombie_male_outfit_3_3":
    case "zombie_male_outfit_5_2":
    case "zombie_male_outfit_5":
    case "zombie_male_outfit_3_3_b":
    case "zombie_male_outfit_3_2_b":
    case "zombie_male_outfit_2_3_b":
    case "zombie_male_outfit_2_2_b":
    case "zombie_male_outfit_3_b":
    case "zombie_male_outfit_2_6_b":
      return getarraykeys(level._id_1103A);
    case "zombie_male_bluejeans_a":
    case "zombie_male_bluejeans_c":
    case "zombie_male_bluejeans_b":
      return [];
    default:
      return getarraykeys(level._id_1103A);
  }
}

_id_B0C7(var_0, var_1, var_2) {
  var_3 = level._id_1103A[var_1]._id_90FA;
  var_4 = level._id_1103A[var_1]._id_9100;
  var_5 = var_0 gettagorigin(var_4);
  var_6 = var_0 gettagangles(var_4);

  if(var_0[[level._id_DA9B]](var_2, var_5)) {
    level thread _id_E1BA(var_5, var_6, var_3);
  }
}

_id_B0BF() {
  level._id_B0BD = [];
  level._id_B0C8 = ["power_speedBoost", "power_teleport", "power_transponder", "power_cloak", "power_barrier", "power_mortarMount"];
  level._id_B0C6 = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level._id_A945 = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level._id_A947 = ["power_bioSpike", "power_sensorGrenade", "power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_repulsor", "power_semtex", "power_c4", "power_frag"];
  level._id_B0C5 = ["reflex", "grip", "barrelrange", "xmags", "overclock", "fastaim", "rof"];

  if(isDefined(level._id_4259)) {
    [[level._id_4259]]();
  }

  _id_2CD4();
}

_id_2CD4(var_0) {
  if(!isDefined(level._id_B0C9)) {
    return;
  }
  if(!isDefined(level._id_B0CA)) {
    level._id_B0CA = [];
  }

  if(isDefined(level._id_B0C9._id_57DC)) {
    _id_2CD3("explosive", level._id_B0C9._id_57DC);
  }

  if(isDefined(level._id_B0C9._id_39A7)) {
    _id_2CD3("clip", level._id_B0C9._id_39A7);
  }

  if(isDefined(level._id_B0C9._id_A0B9)) {
    _id_2CD3("money", level._id_B0C9._id_A0B9);
  }

  if(isDefined(level._id_B0C9._id_0298)) {
    _id_2CD3("maxammo", level._id_B0C9._id_0298);
  }

  if(isDefined(level._id_B0C9._id_F1DB)) {
    _id_2CD3("tickets", level._id_B0C9._id_F1DB);
  }

  if(isDefined(level._id_B0C9._id_BADE)) {
    _id_2CD3("powers", level._id_B0C9._id_BADE);
  }

  if(isDefined(level._id_4228)) {
    [[level._id_4228]]();
  }
}

_id_2CD3(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_2._id_C189 = var_0;
  var_2._id_33BC = var_1;
  level._id_B0CA[level._id_B0CA.size] = var_2;
}

_id_B61F(var_0, var_1) {
  if(istrue(var_1.inlaststand)) {
    return;
  }
  if(istrue(var_1._id_8E55)) {
    return;
  }
  if(var_1 scripts\cp\utility::_id_85F4() || var_1 scripts\cp\utility::_id_7521()) {
    return;
  }
  switch (var_0.type) {
    case "explosive":
      var_0 notify("all_players_searched");
      var_1 _id_F72C(var_0, "primary", 1);
      break;
    case "powers":
      var_0 notify("all_players_searched");
      var_1 _id_F72C(var_0, "secondary", 0);
      break;
    case "maxammo":
      if(var_1 _id_3186()) {
        var_1 _id_6F0C();
        var_1 thread _id_076F::_id_F72D("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        waitframe();
        var_0 notify("all_players_searched");
      } else
        var_1 scripts\cp\utility::_id_D5E9("max_ammo", &"COOP_GAME_PLAY/AMMO_MAX", 3);

      break;
    case "money":
      if(var_1 _id_074E::_id_666A() < var_1._id_9C61) {
        if(_func_0205(var_1._id_105F0 + "pillage_cash")) {
          var_1 thread _id_076F::_id_F72D("pillage_cash", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        } else {
          var_1 thread _id_076F::_id_F72D("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
        }

        var_1 _id_074E::_id_6F28(var_0._id_0050, undefined, undefined, 1, "pillage");
        var_0 notify("all_players_searched");
      } else
        var_1 scripts\cp\utility::_id_D5E9("max_money", &"COOP_GAME_PLAY/MONEY_MAX", 3);

      break;
    case "tickets":
      var_0 notify("all_players_searched");
      var_1 thread _id_076F::_id_F72D("pillage_generic", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
      break;
    case "clip":
      if(var_1 _id_3185()) {
        var_1 _id_6EC0();
        var_1 thread _id_076F::_id_F72D("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
        waitframe();
        var_0 notify("all_players_searched");
      } else {
        var_1 scripts\cp\utility::_id_D5E9("max_ammo", &"COOP_GAME_PLAY/AMMO_MAX", 3);
        return;
      }

      break;
    case "quest":
      if(isDefined(level._id_BEA9)) {
        var_0[[level._id_BEA9]](var_1, "pickup", var_0);
      }
    default:
      if(isDefined(level._id_9343)) {
        var_0[[level._id_9343]](var_1, "pick_up");
      }

      break;
  }

  if(isDefined(var_0._id_8B3C)) {
    var_1 thread _id_DC5F(var_0._id_8B3C);
  }

  var_1 playlocalsound("zmb_item_pickup");
  var_1 thread scripts\cp\utility::_id_FE75(var_1, "iw7_pickup_zm");
}

_id_62AB(var_0, var_1, var_2, var_3) {
  self notify("forcingGesture");
  self endon("forcingGesture");
  self allowmelee(0);
  scripts\common\utility::_id_151F(0);

  if(scripts\common\utility::_id_8650()) {
    scripts\common\utility::_id_1562(0);
  }

  if(self _meth_84B7(var_0)) {
    self _meth_8494(var_0, 0);
  }

  var_4 = self _meth_8495(var_0) * 0.4;
  var_5 = self _meth_8493(var_0, var_1, 1);

  if(var_5) {
    var_6 = _id_68C6(var_0);
    self _meth_84FE("power_active_cp", var_6);
    wait(var_4);
  }

  self allowmelee(1);
  scripts\common\utility::_id_151F(1);

  if(!scripts\common\utility::_id_8650()) {
    scripts\common\utility::_id_1562(1);
  }
}

_id_68C6(var_0) {
  switch (var_0) {
    default:
      return "gesture008";
  }
}

_id_6F36(var_0) {
  self endon("all_players_searched");

  if(_id_0993::_id_DAE4(var_0)) {
    var_1 = var_0 getcurrentweapon();
    var_2 = scripts\cp\utility::_id_6CE3(var_1);
    var_0 takeweapon(var_1);
    var_0._id_8B37 = var_2;
    level._id_F464 = randomint(100);
    _id_0995::_id_9732(var_0._id_8B37, level._id_F464);

    if(isDefined(var_0._id_AE0A[var_2])) {
      var_0._id_AE0A[var_2] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_3 = self._id_B0C9._id_024F._id_04F6;
  var_4 = scripts\cp\utility::_id_6CE3(var_3);
  var_0._id_8B35 = var_4;
  var_0 giveweapon(var_3);

  if(!isDefined(var_0._id_8B32[var_4])) {
    var_0._id_8B32[var_4] = 0;
  }

  var_0 switchtoweapon(var_3);
  var_5 = spawnStruct();
  var_5._id_991E = 1;
  var_0._id_AE0A[var_4] = var_5;
  var_0 notify("weapon_level_changed");
  self notify("weapon_taken");
}

_id_46EE(var_0) {
  thread _id_10A80();
  var_1 = scripts\engine\utility::_id_108A9(60, "stop_pillage_spot_think", "all_players_searched", "redistributed_pillage_spots");
  var_2 = var_1 != "redistributed_pillage_spots";
  self._id_8B30 = var_0.model;
  thread _id_473D(var_0, var_2);
}

_id_E659() {
  wait 60;
  self notify("all_players_searched");
}

_id_10A80() {
  self endon("all_players_searched");

  for(;;) {
    scripts\engine\utility::waittill_any_2("picked_up", "swapped");
    self._id_CFAA++;
    wait 0.25;

    if(self._id_CFAA >= level.players.size) {
      self notify("all_players_searched");
      break;
    } else
      wait 0.05;
  }
}

_id_64EA(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "power_bolaSpray":
      return &"ZOMBIE_PILLAGE/FOUND_BOLA_BARRAGE";
    case "power_semtex":
      return &"ZOMBIE_PILLAGE/FOUND_SEMTEX";
    case "power_splashGrenade":
      return &"ZOMBIE_PILLAGE/FOUND_PLASMA_GRENADE";
    case "power_bioSpike":
      return &"COOP_PILLAGE/FOUND_BIO_SPIKE";
    case "power_gasGrenade":
      return &"COOP_PILLAGE/FOUND_GAS_GRENADE";
    case "power_clusterGrenade":
      return &"COOP_PILLAGE/FOUND_CLUSTER_GRENADE";
    case "power_repulsor":
      return &"COOP_PILLAGE/FOUND_REPULSOR";
    case "power_frag":
      return &"ZOMBIE_PILLAGE/FOUND_FRAG_GRENADE";
    case "power_arcGrenade":
      return &"ZOMBIE_PILLAGE_FOUND_ARC_GRENADE";
    case "power_c4":
      return &"ZOMBIE_PILLAGE/FOUND_C4";
    case "power_concussionGrenade":
      return &"ZOMBIE_PILLAGE/FOUND_CONCUSSION_GRENADES";
    case "maxammo":
      return &"COOP_PILLAGE/FOUND_MAX_AMMO";
    case "clip":
      return &"COOP_PILLAGE/FOUND_CLIP";
    case "tickets":
      return &"ZOMBIE_PILLAGE/FOUND_TICKETS";
    default:
      return undefined;
  }

  if(isDefined(level._id_64EB)) {
    return [[level._id_64EB]](var_0);
  }
}

_id_64E8(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "power_frag":
      return &"ZOMBIE_PILLAGE/PICKUP_FRAG_GRENADE";
    case "power_splashGrenade":
      return &"ZOMBIE_PILLAGE/PICKUP_PLASMA_GRENADE";
    case "power_bolaSpray":
      return &"ZOMBIE_PILLAGE/PICKUP_BOLA_BARRAGE";
    case "power_semtex":
      return &"ZOMBIE_PILLAGE/PICKUP_SEMTEX";
    case "power_gasGrenade":
      return &"COOP_PILLAGE/PICKUP_GAS_GRENADE";
    case "power_clusterGrenade":
      return &"COOP_PILLAGE/PICKUP_CLUSTER_GRENADE";
    case "power_bioSpike":
      return &"COOP_PILLAGE/PICKUP_BIO_SPIKE";
    case "power_repulsor":
      return &"COOP_PILLAGE_PICKUP_REPULSOR";
    case "power_arcGrenade":
      return &"ZOMBIE_PILLAGE_PICKUP_ARC_GRENADE";
    case "power_c4":
      return &"ZOMBIE_PILLAGE/PICKUP_C4";
    case "power_concussionGrenade":
      return &"ZOMBIE_PILLAGE/PICKUP_CONCUSSION_GRENADE";
    case "maxammo":
      return &"COOP_PILLAGE_PICKUP_MAX_AMMO";
    case "money":
      return &"ZOMBIE_PILLAGE/PICKUP_POINTS";
    case "tickets":
      return &"ZOMBIE_PILLAGE/PICKUP_TICKETS";
    case "clip":
      return &"COOP_PILLAGE/PICKUP_CLIP";
    case "quest":
      return &"CP_QUEST_WOR/PART";
    default:
      return undefined;
  }

  if(isDefined(level._id_64E9)) {
    return [[level._id_64E9]](var_0);
  }
}

_id_4FF9() {
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

_id_473D(var_0, var_1) {
  wait 0.25;

  while(istrue(self._id_84EF)) {
    wait 0.1;
  }

  if(isDefined(self._id_B0C9) && isDefined(self.type)) {
    self._id_B0C9.type = undefined;
  }

  if(isDefined(self._id_B0C4)) {
    self._id_B0C4 delete();
  }

  if(isDefined(self._id_605B)) {
    self._id_605B delete();
  }

  if(isDefined(self._id_CFB1)) {
    self._id_CFB1 = undefined;
  }

  self._id_CFAA = 4;

  if(scripts\engine\utility::array_contains(level._id_0F25, self)) {
    level._id_0F25 = scripts\engine\utility::array_remove(level._id_0F25, self);
  }

  self notify("stop_pillage_spot_think");
  var_0 delete();
}

_id_665D(var_0, var_1) {
  if(!scripts\engine\utility::_id_5C00("can_drop_coins")) {
    var_5 = ["quest"];
  } else {
    var_5 = [];
  }

  var_2 = _id_66DC(level._id_B0CA, var_5);

  if(isDefined(var_0._id_4576)) {
    var_2 = var_0._id_4576;
  }

  switch (var_2) {
    case "explosive":
      var_0._id_024F = _id_3596();
      var_0.type = "explosive";
      var_0._id_011A = 0;
      break;
    case "powers":
      var_0._id_024F = _id_3598();
      var_0.type = "powers";
      var_0._id_011A = 0;
      break;
    case "clip":
      var_0.type = "clip";
      var_0._id_024F = "clip";
      var_0._id_011A = 1;
      break;
    case "maxammo":
      var_0.type = "maxammo";
      var_0._id_024F = "maxammo";
      var_0._id_011A = 1;
      break;
    case "money":
      var_0.type = "money";
      var_4 = int(scripts\engine\utility::random([1000, 500, 250, 200, 100, 50]));
      var_0._id_0050 = var_4;
      var_0._id_024F = "money";
      break;
    case "tickets":
      var_0.type = "tickets";
      var_0._id_024F = "tickets";
      var_3 = randomint(100);
      var_0._id_0050 = var_3;
      break;
    case "quest":
      if(isDefined(level._id_BEA1)) {
        [[level._id_BEA1]](var_0, var_1);
      }

      break;
  }

  return var_0;
}

_id_66DC(var_0, var_1) {
  if(isDefined(level._id_BEA6)) {
    var_2 = [[level._id_BEA6]]();

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_6._id_C189)) {
      continue;
    }
    if(var_6._id_33BC == 0) {
      continue;
    }
    var_3[var_3.size] = var_6;
    var_4 = var_4 + var_6._id_33BC;
  }

  var_8 = randomintrange(0, var_4 + 1);
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_9 = var_9 + var_6._id_33BC;

    if(var_8 <= var_9) {
      return var_6._id_C189;
    }
  }
}

_id_DC5F(var_0) {
  self endon("disconnect");

  if(isDefined(self._id_FE2B)) {
    return;
  }
  var_1 = level._id_BCD6;
  var_2 = "objective";

  if(level.splitscreen) {
    var_1 = 1.3;
  }

  self._id_FE2B = scripts\cp\utility::_id_4036(0, 25, var_1, var_2);
  self._id_FE2B settext(var_0);
  self._id_FE2B setpulsefx(50, 2000, 800);
  scripts\engine\utility::_id_108A7(3, "death");
  self._id_FE2B scripts\cp\utility::destroyelem();
  self._id_FE2B = undefined;
}

_id_359A() {
  return scripts\engine\utility::random(level._id_1099F);
}

_id_3595() {
  return scripts\engine\utility::random(level._id_B0C5);
}

_id_3596() {
  return scripts\engine\utility::random(level._id_B0C6);
}

_id_3598() {
  return scripts\engine\utility::random(level._id_B0C8);
}

_id_3599() {
  return scripts\engine\utility::random(["infinite_20", "ammo_max", "kill_50", "cash_2", "instakill_30"]);
}

_id_F72C(var_0, var_1, var_2) {
  var_3 = var_0._id_024F;
  var_4 = var_0._id_16CC;
  self._id_8B35 = var_3;
  level._id_F464 = randomint(100);

  if(!isDefined(var_1)) {
    var_1 = level._id_BADE[var_3]._id_45C7;
  }

  thread _id_0753::_id_6FD3(var_3, var_1, undefined, undefined, undefined, 0, var_2);
  self playlocalsound("grenade_pickup");

  if(randomint(100) > 50) {
    thread _id_076F::_id_F72D("pillage_grenade", "zmb_comment_vo", "medium", 10, 0, 1, 0, 50);
  } else {
    thread _id_076F::_id_F72D("pillage_generic", "zmb_comment_vo", "medium", 5, 0, 0, 0);
  }

  waitframe();
  _id_0995::_id_973F(1, self, var_0.type, self._id_8B35, " None ", level._id_F464);
  var_0 notify("picked_up");
}

_id_F72B(var_0) {
  var_1 = var_0._id_B0C9._id_024F;
  var_2 = var_0._id_B0C9._id_16CC;
  self._id_8B35 = var_1;
  level._id_F464 = randomint(100);

  if(isDefined(level._id_F72A)) {
    if(![[level._id_F72A]]()) {
      return;
    }
  }

  if(self hasweapon(var_1) && self _meth_8109(var_1) > 0) {
    var_3 = self _meth_8135(var_1);

    if(var_3 < 1) {
      var_4 = self getweaponammoclip(var_1);
      self setweaponammoclip(var_1, var_4 + var_2);
      self playlocalsound("grenade_pickup");
      var_0._id_B0C4 disableplayeruse(self);
      thread _id_076F::_id_F72D("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
      waitframe();
      _id_0995::_id_973F(1, self, var_0.type, self._id_8B35, " None ", level._id_F464);
      var_0 notify("picked_up");
      return;
    }

    scripts\cp\utility::_id_D5E9("max_explosives", &"COOP_INTERACTIONS/EXPLO_MAX", 3);
    return;
  } else {
    var_5 = _id_DAE2(level._id_A945);
    self _meth_835D("other");

    if(!isDefined(var_5)) {
      self giveweapon(var_1);
      self setweaponammoclip(var_1, var_2);
      self playlocalsound("grenade_pickup");
      var_0._id_B0C4 disableplayeruse(self);
      thread _id_076F::_id_F72D("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
      waitframe();
      _id_0995::_id_973F(1, self, var_0.type, self._id_8B35, " None ", level._id_F464);
      var_0 notify("picked_up");
    } else {
      var_6 = getcompleteweaponname(var_5);
      self._id_8B35 = var_1;
      self._id_8B37 = var_6;
      level._id_F464 = randomint(100);
      _id_0995::_id_9732(self._id_8B37, level._id_F464);
      self takeweapon(var_5);
      self giveweapon(var_1);
      self setweaponammoclip(var_1, var_2);
      self playlocalsound("grenade_pickup");
      thread _id_076F::_id_F72D("pillage_grenade", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
      _id_0995::_id_973F(1, self, var_0.type, self._id_8B35, " None ", level._id_F464);
      var_0._id_B0C4 setModel(getweaponmodel(var_5));
      var_7 = _id_64E8(var_6);
      var_0._id_B0C4 sethintstring(var_7);
      var_0._id_B0C4 makeuseable();
      var_0._id_B0C9 = spawnStruct();
      var_0._id_B0C9.type = "explosive";
      var_0._id_B0C9._id_024F = var_6;
      var_0._id_B0C9._id_16CC = self._id_EC09;
      var_0._id_B0C4 _id_4FF9();
    }
  }
}

_id_DAE2(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;
  var_4 = self _meth_8195();

  foreach(var_6 in var_4) {
    foreach(var_8 in var_0) {
      if(var_6.basename != var_8) {
        continue;
      }
      if(!isnullweapon(var_6) && self _meth_8109(var_6) > 0) {
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
    self._id_EC09 = var_3;
  }

  return var_2;
}

_id_3185() {
  var_0 = self getcurrentweapon();
  var_1 = weaponmaxammo(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = scripts\cp\utility::_id_6CE3(var_0);

  if(isnullweapon(var_0)) {
    return 0;
  }

  var_4 = var_0.basename;

  if(var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2" || scripts\cp\utility::_id_10D02(var_0) || var_4 == "iw7_katana_zm") {
    return 0;
  }

  if(issubstr(var_4, "iw7_fists")) {
    return 0;
  }

  if(self getweaponammostock(var_0) < var_1) {
    return 1;
  }

  if(weapontype(var_0) == "riotshield" || scripts\cp\cp_weapon::_id_8607(var_0)) {
    var_5 = self getweaponslistprimaries();

    foreach(var_7 in var_5) {
      if(var_7 == var_0) {
        continue;
      }
      var_1 = weaponmaxammo(var_7);
      var_2 = weaponclipsize(var_7);
      var_3 = scripts\cp\utility::_id_6CE3(var_7);

      if(self getweaponammostock(var_7) < var_1) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6EC0() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::_id_6CE3(var_0);
  var_2 = weaponclipsize(var_0);

  if(weapontype(var_0) == "riotshield" || scripts\cp\cp_weapon::_id_8607(var_0)) {
    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        continue;
      }
      if(!scripts\cp\cp_weapon::_id_8795(var_0)) {
        continue;
      }
      var_2 = weaponclipsize(var_5);
      var_1 = scripts\cp\utility::_id_6CE3(var_5);

      if(self getweaponammostock(var_5) < weaponmaxammo(var_5)) {
        var_6 = self getweaponammostock(var_5);
        self setweaponammostock(var_5, var_2 + var_6);
        self._id_8B35 = getcompleteweaponname(var_5);
      }

      return;
    }
  } else {
    var_6 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 + var_6);
    self._id_8B35 = scripts\cp\utility::_id_6CE3(var_0);
  }

  self playlocalsound("weap_ammo_pickup");
}

_id_6F0C() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    var_3 = scripts\cp\utility::_id_6CE3(var_2);
    self._id_8B35 = var_3;
    var_4 = weaponmaxammo(var_2);
    var_5 = int(var_4 * _id_094A::_id_BBF1());
    self setweaponammostock(var_2, var_5);
  }

  self playlocalsound("weap_ammo_pickup");
}

_id_3186() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    var_3 = scripts\cp\utility::_id_6CE3(var_2);
    var_4 = weaponmaxammo(var_2);
    var_5 = var_4;
    var_6 = self getweaponammostock(var_2);

    if(var_6 < var_5) {
      return 1;
    }
  }

  return 0;
}

_id_B0C0(var_0, var_1, var_2) {
  if(![[level._id_DA9B]](var_2, var_1)) {
    return 0;
  } else {
    level thread _id_E1BA(var_1);
    return 1;
  }
}

_id_DA9C(var_0, var_1) {
  if(istrue(self._id_4982)) {
    return 0;
  }

  if(isDefined(self._id_54D1) && !self._id_54D1) {
    return 0;
  }

  if(!_id_8662(var_1)) {
    return 0;
  }

  return 1;
}

_id_8662(var_0) {
  if(isDefined(level._id_84F7)) {
    if(!scripts\cp\cp_weapon::_id_88D5(var_0, level._id_84F7, undefined, undefined, 1)) {
      return 0;
    }
  } else if(!scripts\cp\cp_weapon::_id_88D5(var_0, undefined, undefined, undefined, 1))
    return 0;

  if(!isDefined(level._id_0F31)) {
    return 1;
  }

  foreach(var_2 in level._id_0F31) {
    if(_func_011A(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_E1BA(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_3) {
    var_4 = 2;
    var_5 = -150;
    var_6 = 50;
    level._id_8F47 = gettime();
    level._id_A478 = level._id_8F47 + randomintrange(level._id_B0C2, level._id_B0C1);
    var_7 = spawn("script_model", var_0 + (0, 0, 80));
    var_7.angles = (0, 0, 0);
    var_8 = scripts\engine\utility::random(level._id_B0C3);
    var_7 setModel(var_8);
    waitframe();
    var_9 = _func_024A(var_0 + (0, 0, 80), var_0 + (0, 0, 80) + (randomintrange(-10, 10), randomintrange(-10, 10), 0), (0, 0, var_5), 2);
    var_7 physicslaunchserver(var_7.origin + (randomintrange(-5, 5), randomintrange(-5, 5), 0), var_9 * var_4, var_6);
  } else {
    var_4 = 10;
    var_5 = 800;
    var_6 = 50;
    var_7 = spawn("script_model", var_0);

    if(isDefined(var_1)) {
      var_7.angles = var_1;
    } else {
      var_7.angles = (0, 0, 0);
    }

    var_7 setModel(var_2);
    waitframe();
    var_7 physicslaunchserver(var_7.origin + (12, 0, 0), (0, 0, 0));
  }

  for(;;) {
    var_10 = var_7.origin;
    wait 0.25;

    if(distance(var_10, var_7.origin) < 8) {
      break;
    }
  }

  if(_func_02AE(var_7.origin)) {
    level._id_8F47 = gettime();
    level._id_A478 = level._id_8F47 + randomintrange(level._id_B0C2, level._id_B0C1);
    var_11 = _id_3F5C(var_7);
  } else {
    var_7 scripts\cp\cp_weapon::_id_B164("pillage", 1, var_7.origin);
    var_7 delete();
  }
}

_id_3F5C(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1._id_039B = "pillage_item";
  var_1._id_3BEB = _id_665D(var_1, var_0);
  var_1._id_B0B2 = _id_64E8(var_1._id_024F);
  var_1._id_8B3C = _id_64EA(var_1._id_024F);
  var_1._id_C588 = 0;
  var_1._id_BAD8 = 1;
  var_1._id_CE18 = "default";
  var_1._id_425E = 96;
  var_1 setModel(var_0.model);
  var_0 delete();
  var_1 thread _id_10A80();
  var_1 thread _id_46EE(var_1);
  level._id_0F25[level._id_0F25.size] = var_1;
  _id_0737::_id_1037(var_1);

  if(var_1.type != "quest") {
    var_2 = spawnfx(level._effect["pillage_box"], var_1.origin);
    waitframe();
    triggerfx(var_2);
    var_1 scripts\engine\utility::_id_108A7(60, "all_players_searched");

    if(isDefined(var_2)) {
      var_2 delete();
    }
  } else
    var_1 scripts\engine\utility::_id_108A7(60, "all_players_searched");

  _id_0737::_id_C3C5(var_1);
}

_id_B0BE(var_0, var_1) {
  if(istrue(var_1.inlaststand)) {
    return "";
  }

  if(istrue(var_1._id_8E55)) {
    return "";
  }

  if(isDefined(var_0._id_B0B2)) {
    return var_0._id_B0B2;
  } else {
    return "";
  }
}

_id_665B(var_0) {
  switch (var_0) {}
}

_id_4449(var_0) {
  var_1 = strtok(var_0, "+");
  var_2 = var_1[0];
  var_3 = var_1[1];

  foreach(var_5 in level._id_E2A4) {
    var_5 setscriptablepartstate(var_2, var_3);
  }
}