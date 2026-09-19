/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1351.gsc
**************************************/

get_zombies_mode_starter_weapons(var_0) {
  var_1 = ["shovel_zm", "m1911_zm", "luger_zm", "reich_zm", "p38_zm", "m712_zm", "enfieldno2_zm", "g43_zm", "m1a1_zm", "kar98_zm", "model21_zm", "m30_zm"];
  var_2 = [];

  if(common_scripts\utility::_id_562E(var_0)) {
    foreach(var_4 in var_1) {
      if(!_id_5864(var_4))
        var_2 = common_scripts\utility::_id_0F6F(var_2, _id_0586::_id_078B(var_4, 1, 1));
    }
  }

  return common_scripts\utility::_id_0F73(var_1, var_2);
}

_id_0A52(var_0, var_1) {
  if(!isDefined(var_0._id_4C12))
    var_0._id_4C12 = 1;

  if(!isDefined(var_0._id_4C07)) {
    var_2 = maps\mp\gametypes\zombies::getzombietotalhealthscale(var_0, 4);
    var_3 = 1000000;
    var_4 = var_2 * var_3;
    var_0._id_4C07 = var_4;
  }

  if(!isDefined(level._id_0A50))
    level._id_0A50 = [];

  level._id_0A50[var_1] = var_0;
}

registeranimtree(var_0, var_1) {
  if(!isDefined(level.animtree_lookup))
    level.animtree_lookup = [];

  level.animtree_lookup[var_0] = var_1;
}

getanimtree(var_0) {
  return level.animtree_lookup[var_0];
}

_id_0A51(var_0) {
  return level._id_0A50[var_0];
}

_id_7CE5(var_0, var_1, var_2) {
  if(var_2 != 1) {
    var_3 = "ks_icon" + common_scripts\utility::_id_9AAD(var_2);
    self setclientomnvar(var_3, 0);
  }
}

is_important_zombie() {
  if(common_scripts\utility::_id_562E(self.sgvip) || common_scripts\utility::_id_562E(self.sgboss) || common_scripts\utility::_id_562E(self.sgisdyingboss))
    return 1;

  return 0;
}

remove_important_zombie_corpse_next_round(var_0) {
  self endon("entitydeleted");
  self endon("death");

  if(var_0) {
    level waittill("waveupdate");
    level waittill("waveupdate");
  } else {
    while(!self isragdoll())
      waitframe();

    wait 3;
  }

  self _meth_86D3(0);
}

_id_AC51() {
  self endon("death");
  self endon("zombies_make_unusable");

  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(!isDefined(self)) {
      continue;
    }
    self notify("player_used", var_0);

    if(isDefined(self._id_0117))
      self._id_0117 notify("player_used", var_0);
  }
}

_id_AC41(var_0, var_1, var_2) {
  _id_AC40();
  self._id_9D65 = spawn("script_model", self.origin);
  self._id_9D65._id_0117 = self;
  self._id_9D65 setModel("tag_origin");

  if(isDefined(var_1))
    self._id_9D65.origin = self._id_9D65.origin + var_1;

  if(isDefined(var_2))
    self._id_9D65.origin = var_2;

  self._id_9D65 linkto(self);
  self._id_9D65 makeusable();

  if(isDefined(var_0))
    self._id_9D65 sethintstring(var_0);

  self._id_9D65 thread _id_AC51();
}

_id_AC40() {
  self notify("zombies_make_unusable");

  if(isDefined(self._id_9D65)) {
    self._id_9D65 notify("zombies_make_unusable");
    self._id_9D65 delete();
  }

  self._id_9D65 = undefined;
}

_id_AC3F(var_0) {
  _id_AC3E();
  self._id_6989 = _id_04D1::_id_45A9();
  _objective_add(self._id_6989, "invisible", (0, 0, 0));
  _objective_position(self._id_6989, self.origin);
  _objective_state(self._id_6989, "active");
  _objective_icon(self._id_6989, var_0);
  _objective_team(self._id_6989, "allies");
  _objective_onentity(self._id_6989, self);
}

_id_AC3E() {
  if(isDefined(self._id_6989)) {
    maps\mp\_utility::_objective_delete(self._id_6989);
    self._id_6989 = undefined;
  }
}

_id_40F0(var_0) {
  var_1 = 0;

  foreach(var_3 in _func_2D1()) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(var_3._id_0A4B) && var_3._id_0A4B == var_0)
      var_1++;
  }

  return var_1;
}

_id_45C9() {
  var_0 = 0;

  if(!isDefined(level.players))
    return 0;

  foreach(var_2 in level.players) {
    if(_id_5767(var_2))
      var_0++;
  }

  return var_0;
}

_id_57E1(var_0) {
  return _id_5565(var_0.team, "spectator");
}

_id_5767(var_0) {
  return _id_5565(var_0.team, level._id_746E);
}

_id_5768(var_0) {
  return _id_5767(var_0) || _id_57E1(var_0);
}

_id_585C(var_0) {
  return _id_5863(var_0) || _id_5866(var_0);
}

_id_5863(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "scythe_shard_zm":
    case "zom_hammer_grenade_zm":
    case "zom_moonorb_grenade_emp_zm":
    case "zom_moonorb_grenade_zm":
    case "throwinghammer_rhand_zm":
    case "throwinghammer_lhand_zm":
    case "frag_grenade_funderbuss_zm":
    case "alt+wunderbuss_zm":
    case "throwingknife_zm":
    case "thermite_zm":
    case "semtex_zm":
    case "frag_grenade_zm":
    case "killstreak_carepackage_grenade_mp":
    case "bouncingbetty_zm":
    case "c4_zm":
    case "thermite_flames_mp":
      var_1 = 1;
      break;
  }

  if(common_scripts\utility::_id_562E(level.zombielethalweapon[var_0]))
    var_1 = 1;

  return var_1;
}

_id_5866(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "island_grenade_hc_zm":
    case "jack_in_box_decoy_zm":
    case "zom_moonorb_grenade_emp_zm":
    case "zom_moonorb_grenade_zm":
      var_1 = 1;
      break;
  }

  if(common_scripts\utility::_id_562E(level.zombietacticalweapon[var_0]))
    var_1 = 1;

  return var_1;
}

_id_73F9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 hasweapon(var_1))
    return 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 1;

  var_6 = var_0 getweaponlistprimaries();

  foreach(var_8 in var_6) {
    if(_id_0586::_id_0791(var_1, var_8, var_2, var_3, var_4, var_5))
      return 1;
  }

  return 0;
}

_id_5862(var_0) {
  switch (var_0) {
    case "airdrop_sentry_marker_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

iszombieindirectweapon(var_0) {
  switch (var_0) {
    case "electric_cherry_zm":
    case "dot_generic_zm":
    case "hitem_hard_zm":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_5865(var_0) {
  switch (var_0) {
    case "spine_inspect_depleted_zm":
    case "spine_inspect_zombie_zm":
    case "spine_inspect_assassin_zm":
    case "spine_inspect_wustling_zm":
    case "spine_inspect_pest_zm":
    case "training_unarmed_zm":
    case "hilt_inspect_hc_zm":
    case "hilt_inspect_zm":
    case "elec_inspect_zm":
    case "unarmed_perk_machine_zm":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_5864(var_0) {
  var_0 = _id_AAF9(var_0, 0, 0);

  switch (var_0) {
    case "zom_dlc4_scythe_emp_zm":
    case "zom_dlc4_scythe_zm":
    case "zom_dlc4_shield_emp_zm":
    case "zom_dlc4_shield_zm":
    case "zom_dlc4_spike_emp_zm":
    case "zom_dlc4_spike_zm":
    case "zom_dlc4_hammer_emp_zm":
    case "zom_dlc4_hammer_zm":
    case "razergun_melee_zm":
    case "shovel_zm":
    case "raven_sword_zm":
      return 1;
    default:
      break;
  }

  if(issubstr(var_0, "shovel"))
    return 1;

  if(issubstr(var_0, "razergun_zm")) {
    if(!common_scripts\utility::_id_3C83("ripsaw_punch_active") || common_scripts\utility::_id_3C83("ripsaw_punch_active") && !common_scripts\utility::_id_3C77("ripsaw_punch_active"))
      return 1;
  }

  if(common_scripts\utility::_id_562E(level.zombiemeleeweapon[var_0]))
    return 1;

  return 0;
}

iszombieconsumableweapon(var_0) {
  switch (var_0) {
    case "flamethrower_zm":
    case "panzerschreck_zm":
    case "bazooka_zm":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_585B(var_0) {
  if(maps\mp\_utility::_id_4571() == "mp_zombie_island" && var_0 == "teslagun_zm")
    return 1;

  switch (var_0) {
    case "stone_baby_zm":
    case "sentryhead_zm":
    case "blimp_battery_zm":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_462A(var_0) {
  var_1 = var_0 getcurrentweapon();

  if(isDefined(var_0._id_20CC))
    var_1 = var_0._id_20CC;

  if(!var_0 hasweapon(var_1)) {
    var_2 = var_0 getweaponlistprimaries();

    if(var_2.size > 0)
      var_1 = var_2[0];
  }

  return var_1;
}

_id_4747(var_0, var_1) {
  var_2 = _getweaponbasename(var_1);

  if(_id_5868(var_2))
    return 1;
  else
    return 0;
}

_id_5868(var_0) {
  return _id_0569::_id_55D4(var_0);
}

iszombieweaponamped(var_0) {
  return issubstr(var_0, "zmb_amp");
}

_id_4BA8(var_0, var_1) {
  return 0;
}

_id_7D1F(var_0, var_1) {
  var_2 = undefined;

  for(;;) {
    var_2 = maps\mp\agents\_agent_common::_id_2586(var_0, var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 0.1;
  }

  return var_2;
}

_id_902E(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_3 = _id_7D1F(var_1._id_0A4B, var_2);
  var_3 maps\mp\agents\_agents::_id_8F70(var_0.origin, var_0.angles);
  return var_3;
}

_id_6BAA(var_0, var_1, var_2) {
  maps\mp\agents\humanoid\_humanoid::_id_8FC9(self._id_0EAE, var_0, var_1, var_2);
}

_id_90A0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_7 = _id_7D1F(var_1._id_0A4B, var_2);
  var_7._id_0EAE = undefined;

  if(isDefined(var_1._id_0EAE))
    var_7._id_0EAE = var_1._id_0EAE;

  var_7 common_scripts\utility::_id_3799("zombie_passive");

  if(common_scripts\utility::_id_562E(var_4))
    var_7 common_scripts\utility::_id_379A("zombie_passive");

  var_7._id_901F = var_5;
  var_7._id_9024 = var_6;
  var_7 thread[[var_7 maps\mp\agents\_agent_utility::_id_0A59("spawn")]](var_0.origin, var_0.angles);
  var_8 = undefined;

  if(var_0 should_play_spawn_vfx()) {
    if(isDefined(level._id_902A))
      var_8 = var_7[[level._id_902A]](var_0);
  }

  if(isDefined(var_0.setflaggedanimknoball)) {
    var_9 = isDefined(var_0._id_81C7) && var_0._id_81C7 == "ignoreRealign";
    var_10 = var_7 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0.setflaggedanimknoball);

    if(isDefined(var_10))
      var_7 thread _id_AC3A(var_0, var_10, var_8, var_9);
    else {}
  }

  if(isDefined(var_7) && isDefined(var_1)) {
    if(isDefined(level._id_10E8) && var_7[[level._id_10E8]]())
      return var_7;

    if(isDefined(var_3))
      var_11 = var_3;
    else {
      var_12 = [];

      foreach(var_15, var_14 in var_1._id_5ED2) {
        if(common_scripts\utility::_id_562E(var_14["request only"])) {
          continue;
        }
        var_12[var_12.size] = var_15;
      }

      if(isDefined(level.zmb_additional_look_check))
        var_12 = [[level.zmb_additional_look_check]](var_12);

      var_11 = common_scripts\utility::random(var_12);
    }

    var_16 = var_1._id_5ED2[var_11];
    var_7._id_18B0 = var_11;
    var_7._id_2FDB = 0;

    if(isDefined(var_16["right_arm"]))
      var_7._id_2FDB = var_7._id_2FDB | 1;

    if(isDefined(var_16["left_arm"]))
      var_7._id_2FDB = var_7._id_2FDB | 2;

    if(isDefined(var_16["right_leg"]))
      var_7._id_2FDB = var_7._id_2FDB | 4;

    if(isDefined(var_16["left_leg"]))
      var_7._id_2FDB = var_7._id_2FDB | 8;

    if(isDefined(var_16["heads"])) {
      var_7._id_2FDB = var_7._id_2FDB | 16;
      var_7.headmodel = common_scripts\utility::random(var_16["heads"]);
    } else
      var_7.headmodel = undefined;

    var_7._id_4B5A = 0;
    var_7._id_4B6E = 0;
    var_7._id_4CAA = undefined;
    var_17 = randomint(100);

    if(var_17 < 33) {} else if(var_17 < 66) {
      if(isDefined(var_16["helmets"])) {
        var_7._id_4B6E = 1;
        var_7._id_4CAA = common_scripts\utility::random(var_16["helmets"]);
      }
    } else if(isDefined(var_16["caps"])) {
      var_7._id_4B5A = 1;
      var_7._id_4CAA = common_scripts\utility::random(var_16["caps"]);
    }

    if(isDefined(var_16["facegear"]))
      var_7._id_399E = common_scripts\utility::random(var_16["facegear"]);

    var_7._id_6250 = 0;
    var_7 _id_A19E();
    var_18 = var_7 maps\mp\agents\_agent_utility::_id_0A59("post_model");

    if(isDefined(var_18))
      var_7 thread[[var_18]]();

    if(isDefined(var_1._id_8303))
      var_7._id_8303 = var_1._id_8303;

    if(isDefined(var_1._id_8302))
      var_7._id_8302 = var_1._id_8302;
  }

  return var_7;
}

should_play_spawn_vfx() {
  return isDefined(self.setflaggedanimknoball) || _id_5565(self.weaponlocktargettooclose, "spawn_fire");
}

_id_AC3A(var_0, var_1, var_2, var_3) {
  var_0._id_50D5 = 1;
  var_4 = undefined;
  var_5 = [];

  if(isDefined(var_0.optional_script_anim_index)) {
    var_6 = self getanimentrycount(var_1);
    var_4 = var_0.optional_script_anim_index;

    if(isDefined(var_0.optional_timeoffset))
      var_5["timeOffset"] = var_0.optional_timeoffset;
  }

  maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(var_0.origin, var_0.angles, var_1, var_4, 1, var_2, var_3, 0, undefined, undefined, var_5);
  var_0._id_50D5 = 0;
}

_id_443A(var_0) {
  switch (var_0) {
    case 1:
      return "right_arm";
    case 2:
      return "left_arm";
    case 4:
      return "right_leg";
    case 8:
      return "left_leg";
    default:
  }
}

_id_4744(var_0) {
  var_1 = _id_0A51(self._id_0A4B);
  var_2 = var_1._id_5ED2[self._id_18B0];

  if(var_0 == 16)
    return self.headmodel;

  var_3 = _id_443A(var_0);
  return var_2[var_3];
}

_id_A19E() {
  var_0 = _id_0A51(self._id_0A4B);
  var_1 = var_0._id_5ED2[self._id_18B0];
  self detachall();

  if((self._id_6250 &~16) == 0 && isDefined(var_1["whole_body"]))
    self setModel(var_1["whole_body"]);
  else {
    self setModel(var_1["torso"]);
    _id_A19F(var_1, 1);
    _id_A19F(var_1, 2);
    _id_A19F(var_1, 4);
    _id_A19F(var_1, 8);
  }

  var_2 = isDefined(self.headmodel) && (self._id_6250 & 16) == 0;

  if(var_2)
    self attach(self.headmodel);

  if(var_2 && self._id_4B6E || var_2 && self._id_4B5A)
    self attach(self._id_4CAA);

  if(var_2 && isDefined(self._id_399E))
    self attach(self._id_399E);
}

_id_A19F(var_0, var_1) {
  var_2 = _id_443A(var_1);
  var_3 = var_0[var_2];

  if((self._id_6250 &var_1) != 0) {
    var_4 = _id_0541::_id_4559(var_1, var_3, "nub");

    if(isDefined(var_4)) {
      self attach(var_4, "", 1);
      return;
    }
  } else
    self attach(var_3);
}

_id_2696(var_0) {
  for(var_1 = 0; var_0 > 0; var_0 = var_0 - (var_0 & 0 - var_0))
    var_1++;

  return var_1;
}

_id_4495() {
  return "dismemberSound";
}

_id_647A(var_0) {
  return _getmovedelta(var_0, 0, _id_463F(var_0));
}

_id_2574(var_0) {
  var_1 = _id_463F(var_0);
  var_2 = _getmovedelta(var_0, 0, var_1);
  var_3 = _getanimlength(var_0);

  if(var_3 == 0)
    return 0;

  return var_2 / (var_1 * var_3);
}

_id_5E44(var_0) {
  return self localtoworldcoords(var_0) - self.origin;
}

_id_2204(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 2;
  var_10 = 100;
  var_11 = 3;
  var_12 = 50;
  var_13 = 600;
  var_14 = 1;

  if(!isDefined(var_7) || _lengthsquared(var_7) < 0.1) {
    if(isDefined(var_2))
      var_7 = self.origin - var_2.origin;
    else if(isDefined(var_3))
      var_7 = self.origin - var_3.origin;
    else
      var_7 = (0, 0, 0);
  }

  var_7 = vectorNormalize(common_scripts\utility::_id_3D5D(var_7));
  var_15 = anglesToForward(self.angles);
  var_16 = var_15 * vectordot(var_15, var_7);
  var_17 = var_7 - var_16;
  var_18 = var_17 * var_11 + var_16;
  var_19 = self getanimentry();
  var_20 = _id_5E44(_getmovedelta(var_19, 0, 1));
  var_21 = _getanimlength(var_19);

  if(var_21 > 0)
    var_22 = var_20 / var_21;
  else
    var_22 = (0, 0, 0);

  var_23 = var_22 * var_9;
  var_24 = var_18 * (var_4 * var_12 / self.maxhealth);
  var_25 = var_23 + var_24;
  var_27 = undefined;
  var_28 = undefined;
  var_29 = self getanimentrycount(var_0);

  for(var_31 = 0; var_31 < var_29; var_31++) {
    var_32 = self getanimentry(var_0, var_31);
    var_33 = _id_463F(var_32);
    var_34 = _getmovedelta(var_32, 0, var_33);
    var_35 = _getanimlength(var_32);

    if(var_35 == 0)
      var_36 = 0;
    else
      var_36 = var_34 / (var_33 * var_35);

    var_37 = _id_5E44(var_36);
    var_38 = (_randomfloatrange(-1, 1), _randomfloatrange(-1, 1), 0) * var_10;
    var_39 = var_37 + var_38;
    var_40 = 0 - distance(var_25, var_39);
    var_41 = self localtoworldcoords(var_34);

    if(_func_2DC(self.origin, var_41, self, 0))
      var_40 = var_40 - 1000;

    foreach(var_43 in level.players) {
      if(distance(var_41, var_43.origin) < 32)
        var_40 = var_40 - 500;
    }

    if(!isDefined(var_27) || var_40 > var_27) {
      var_27 = var_40;
      var_28 = var_31;
    }
  }

  var_45 = common_scripts\utility::_id_5D93(var_27, -30, -100, 0.1, 1);

  if(var_5 == "MOD_GRENADE" || var_5 == "MOD_GRENADE_SPLASH")
    var_45 = 0.9;

  if(isDefined(var_6) && weaponclass(var_6) == "spread")
    var_45 = 0.5;

  if(var_1 && _randomfloat(1) < var_45) {
    if(var_5 == "MOD_GRENADE" || var_5 == "MOD_GRENADE_SPLASH")
      var_51 = 1;
    else if(isDefined(var_6) && weaponclass(var_6) == "spread")
      var_51 = 0.8;
    else
      var_51 = 0.4;

    if(maps\mp\agents\_agent_utility::_id_0A5A("ragdoll_overrides"))
      var_52 = [[maps\mp\agents\_agent_utility::_id_0A59("ragdoll_overrides")]]();
    else
      var_52 = 1;

    var_53 = common_scripts\utility::_id_5D93(var_4, 0, self.maxhealth, 0.6, 1);
    var_54 = 3500;
    var_55 = var_54 * var_51 * var_52 * var_53;
    var_56 = _vectorcross((0, 0, 1), var_7);
    self._id_78D5 = (var_7 + (0, 0, 0.3) + _randomfloat(0.4) * var_56) * var_55;
    self._id_78D2 = 1;
    self._id_78D3 = var_8;

    if(self._id_78D3 == "none")
      self._id_78D3 = "torso_upper";
  }

  return var_28;
}

_id_6B9E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self._id_565F = 0;
  self._id_4B60 = 0;

  if(isDefined(self._id_0EAD._id_6B2F[self._id_0BA4]))
    self[[self._id_0EAD._id_6B2F[self._id_0BA4]]]();

  var_9 = 1;
  var_10 = 0;
  var_11 = maps\mp\agents\humanoid\_humanoid::_id_45FB(var_4, var_1);

  if(isDefined(self._id_2A9D)) {
    var_12 = self._id_2A9D;
    var_9 = 0;
  } else if(self._id_90DC == "dog")
    var_12 = "death";
  else if(var_3 == "MOD_MELEE" && !common_scripts\utility::_id_562E(self.nopairmelee)) {
    var_13 = undefined;

    if(self _meth_864D(var_1) && (!maps\mp\agents\humanoid\_humanoid_util::_id_56BC() || common_scripts\utility::_id_562E(self._id_0103)) && isDefined(var_11)) {
      if(!var_1 _meth_8661() || common_scripts\utility::_id_562E(self._id_0103))
        var_13 = var_11["fatal_zombie_action"];
      else
        var_13 = var_11["hit_zombie_action"];
    }

    if(isDefined(var_13)) {
      var_10 = 1;
      var_9 = 0;
      var_12 = var_13;
      var_14 = var_11["invalid_pair_distance"];

      if(isDefined(var_14)) {
        if(distance(self.origin, var_1.origin) > var_14) {
          _id_0542::set_zombie_too_far_for_pairing(var_1);
          var_15 = 1;
        }
      }
    } else
      var_12 = "death_melee_knife";
  } else if(_id_0541::_id_56FD()) {
    if(self._id_0108 == "run" || self._id_0108 == "sprint")
      var_12 = "death_full_body_run";
    else
      var_12 = "death_full_body_stand";
  } else if(self._id_0BA4 == "idle" || self._id_0BA4 == "melee")
    var_12 = "death_stand";
  else
    var_12 = "death_" + self._id_0108;

  var_16 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_12);

  if(isDefined(self._id_9D07))
    _id_649D();

  self scragentsetphysicsmode("gravity");
  var_17 = _id_2204(var_16, var_9, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_18 = self getanimentryname(var_16, var_17);
  var_19 = self getanimentry(var_16, var_17);
  var_20 = 1;
  var_21 = 0;

  if(var_10) {
    var_7 = var_7 - 1;

    if(var_7 < 0)
      var_7 = 0;

    var_21 = var_7 * 0.001;
    var_22 = 0.2;
    var_21 = var_21 - var_22;
    var_23 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_19, "melee_sync", 0) * _getanimlength(var_19);
    var_21 = var_21 + var_23;

    if(var_21 < 0)
      var_21 = 0;
  }

  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_16, var_17, var_20, var_21);
  var_24 = _id_4488(var_19);

  if(isDefined(var_4) && var_4 == "zombie_vaporize_mp" && common_scripts\utility::_id_3F6F("zombie_death_vaporize")) {
    self._id_1DEB = 1;
    playFX(common_scripts\utility::_id_44F5("zombie_death_vaporize"), self.origin + (0, 0, 30));
  }

  if(!isDefined(self._id_1DEB) || !self._id_1DEB) {
    var_25 = is_important_zombie();
    var_26 = var_25 || var_10;
    self._id_18A8 = self cloneagent(var_24 - int(var_21 * 1000), var_26);
    self._id_18A8._id_0A4B = self._id_0A4B;
    self._id_18A8._id_90AB = self._id_90AB;
    self._id_18A8.headmodel = self.headmodel;
    self._id_18A8._id_4B6E = self._id_4B6E;
    self._id_18A8._id_4B5A = self._id_4B5A;
    self._id_18A8._id_4CAA = self._id_4CAA;
    self._id_18A8._id_18B0 = self._id_18B0;
    self._id_18A8._id_6250 = self._id_6250;
    self._id_18A8._id_2FDB = self._id_2FDB;
    self._id_18A8._id_2FE3 = self._id_2FE3;
    self._id_18A8.too_far_for_melee_pairing = self.too_far_for_melee_pairing;
    self notify("body_spawned", self._id_18A8);
    level notify("level_notify_body_spawned", self, self._id_18A8);
    var_27 = "zmb_jolts_out";

    if(should_play_zombie_fx() && common_scripts\utility::_id_3F6F(var_27)) {
      var_28 = common_scripts\utility::_id_44F5(var_27);
      _playfxontag(var_28, self._id_18A8, "J_Head");
    }

    if(isDefined(var_4) && (var_4 == "repulsor_zombie_mp" || var_4 == "zombie_water_trap_mp"))
      self._id_78D2 = 1;

    var_29 = _id_4640(var_24 * 0.001, var_10);
    var_29 = max(0, var_29 - var_21);
    thread _id_4AE8(self._id_18A8, var_29, var_19, var_10);

    if(var_26)
      self._id_18A8 thread remove_important_zombie_corpse_next_round(var_25);

    if(var_10)
      thread _id_0542::_id_4ADD(self._id_18A8, var_11, var_19, var_21, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }

  maps\mp\agents\_agent_utility::_id_2A73();
  self notify("killanimscript");
}

should_play_zombie_fx() {
  return !isDefined(level.zombie_prevent_fx_play_func) || !self[[level.zombie_prevent_fx_play_func]]();
}

_id_8B97() {
  if(isDefined(self._id_2A9D))
    return 0;

  if(_id_0541::_id_56FD())
    return 1;

  if(!self isonground() || common_scripts\utility::_id_562E(self._id_50D9))
    return 1;

  if(isDefined(self._id_78D2) && self._id_78D2)
    return 1;

  if(self._id_0BA4 == "traverse" || self._id_0BA4 == "scripted")
    return 1;

  return 0;
}

_id_1F67(var_0) {
  var_1 = _getanimlength(var_0);
  var_2 = _getnotetracktimes(var_0, "ignore_ragdoll");
  return var_2.size == 0;
}

_id_649D() {
  var_0 = 20;
  var_1 = vectortoangles(self._id_9D07);
  var_2 = anglestoup(var_1);
  var_3 = self.origin + var_2 * var_0;
  self setOrigin(var_3);
}

_id_463F(var_0) {
  var_1 = _getnotetracktimes(var_0, "start_ragdoll");

  if(var_1.size > 0)
    return var_1[0];
  else
    return 0.5;
}

_id_4488(var_0) {
  var_1 = _getanimlength(var_0);
  var_1 = var_1 * _id_463F(var_0);
  var_2 = int(var_1 * 1000);
  return var_2;
}

_id_5A85(var_0, var_1, var_2, var_3) {
  self._id_78D5 = var_1;
  self._id_78D2 = 1;
  self._id_78D3 = var_0;
  self dodamage(self.health * 2, self.origin, undefined, var_2, "MOD_IMPACT", var_3);
}

_id_A69D(var_0, var_1) {
  self endon("entitydeleted");
  self endon("waitForEarlyRagdollOrTimeout");
  childthread getanimentry("waitForEarlyRagdollOrTimeout", var_0);

  for(;;) {
    self waittill("start_ragdoll", var_2, var_3);

    if(!var_1 && var_2 < 0.5) {
      self startragdoll();
      break;
    }
  }
}

getanimentry(var_0, var_1) {
  wait(var_1);
  self notify(var_0);
}

_id_4AE8(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_id_1F67(var_2)) {
    return;
  }
  if(!var_3 && _id_8B97()) {
    if(isDefined(self._id_78D3))
      var_0 startragdollfromimpact(self._id_78D3, self._id_78D5);
    else
      var_0 startragdoll();

    if(var_0 isragdoll())
      return;
  }

  var_0 _id_A69D(var_1, var_3);

  if(!isDefined(var_0)) {
    return;
  }
  var_0 startragdoll();

  if(var_0 isragdoll()) {
    return;
  }
  var_4 = _getanimlength(var_2);

  if(var_4 > var_1) {
    wait(var_4 - var_1);

    if(!isDefined(var_0)) {
      return;
    }
    var_0 startragdoll();
  }

  if(!var_0 isragdoll())
    var_0 delete();
}

_id_4640(var_0, var_1) {
  var_2 = 0.2;

  if(var_1)
    return var_0;

  if(self._id_0BA4 == "traverse" || self._id_0BA4 == "scripted" && !isDefined(self._id_2A9D))
    return var_2;

  return var_0;
}

_id_A692() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path");
    self._id_173E = 1;

    if(isDefined(self._id_3043))
      self._id_3044++;
  }
}

_id_8B95(var_0) {
  if(common_scripts\utility::_id_562E(level.zmb_lockdown_event_active) && !common_scripts\utility::_id_562E(var_0.participatinginevent))
    return 1;

  if(isDefined(self._id_3043) && !common_scripts\utility::_id_562E(self.has_lost_distractiondrone_interest))
    return 1;

  if(isDefined(self.my_ignore_players_list) && self.my_ignore_players_list.size > 0 && common_scripts\utility::_id_0F79(self.my_ignore_players_list, var_0))
    return 1;

  if(common_scripts\utility::_id_562E(self._id_56EB) && common_scripts\utility::_id_562E(var_0._id_7414))
    return 1;

  if(_id_577E(var_0))
    return 1;

  if(_id_5783(var_0))
    return 1;

  if(common_scripts\utility::_id_562E(var_0._id_AC5B) && !common_scripts\utility::_id_562E(self.ignorecamo))
    return 1;

  if(_id_0796() && _id_4253() <= 10 && _id_4088() > 1 && common_scripts\utility::_id_562E(var_0._id_5579))
    return 1;

  if(isDefined(level._id_8B96)) {
    if([[level._id_8B96]](var_0))
      return 1;
  }

  if(isDefined(level.shouldignoreplayerzombiecallback)) {
    if([[level.shouldignoreplayerzombiecallback]](var_0, self))
      return 1;
  }

  if(common_scripts\utility::_id_562E(var_0._id_5869) && _id_580A())
    return 1;

  return 0;
}

_id_4253() {
  var_0 = 0;

  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return 999;

  var_1 = _id_408F();

  foreach(var_3 in level.players) {
    foreach(var_5 in var_1) {
      if(!isDefined(var_5._id_0088)) {
        continue;
      }
      foreach(var_7 in level._id_08CB) {
        if(distance(var_3.origin, var_7._id_38B7) < var_7._id_38BA && var_5._id_0088 == var_3)
          var_0++;
      }
    }
  }

  return var_0;
}

_id_4088() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isalive(var_2) && !common_scripts\utility::_id_562E(var_2._id_5728))
      var_0++;
  }

  return var_0;
}

_id_0795() {
  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return 0;
  else
    return 1;
}

_id_0BC7() {
  var_0 = 0;

  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return 1;

  foreach(var_2 in level._id_08CB) {
    if(!common_scripts\utility::_id_562E(var_2._id_552B))
      var_0++;
  }

  return var_0 == level._id_08CB.size;
}

_id_0796() {
  var_0 = 0;

  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return 0;

  foreach(var_2 in level._id_08CB) {
    if(common_scripts\utility::_id_562E(var_2._id_552B))
      return 1;
  }

  return 0;
}

_id_4254() {
  var_0 = 0;

  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return 0;

  foreach(var_2 in level._id_08CB) {
    if(common_scripts\utility::_id_562E(var_2._id_552B)) {
      var_3 = _id_408F();

      foreach(var_5 in var_3) {
        if(distance(var_5.origin, var_2._id_38B7) < var_2._id_38BA)
          var_0++;
      }
    }
  }

  return var_0;
}

_id_7A37() {
  var_0 = [];

  if(!isDefined(level._id_08CB) || level._id_08CB.size == 0)
    return undefined;

  foreach(var_2 in level._id_08CB) {
    if(common_scripts\utility::_id_562E(var_2._id_552B))
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  return common_scripts\utility::random(var_0);
}

_id_5E54() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_6E97) {
      if(_id_5767(var_1))
        self getenemyinfo(var_1);
    }

    wait 0.5;
  }
}

_id_0A58() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self scragentsetgoalpos(self.origin);
    wait 0.5;
  }
}

_id_6AB7() {
  self._id_0009 = &"ZOMBIES_EMPTY_STRING";
}

_id_AC70() {
  return isDefined(self._id_99A3);
}

_id_AC59(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_2 < self.maxhealth)
    return 0;

  if(!isDefined(level._id_AB28) || level._id_AB28 != _id_45A2()) {
    level._id_AB28 = _id_45A2();
    level._id_AB27 = 0;
  }

  if(!isDefined(level._id_AB29))
    level._id_AB29 = 0;

  if(isDefined(self._id_99A4)) {
    self._id_99A4 = undefined;
    return 0;
  } else if(level._id_AB29 + level._id_AB27 + 1 > 4)
    return 1;

  level._id_AB27++;
  return 0;
}

_id_AC24() {
  self endon("processDelayDeath");
  self waittill("death");
  level._id_AB29--;
}

_id_AC19(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  level._id_AB29++;
  self._id_6730 = gettime();
  self._id_99A3 = _id_45A2() + int(_ceil(level._id_AB29 / 4));
  thread _id_AC24();

  while(_id_45A2() < self._id_99A3)
    _id_A6F6();

  if(level._id_AB28 != _id_45A2()) {
    level._id_AB28 = _id_45A2();
    level._id_AB27 = 0;
  }

  self._id_99A3 = undefined;
  self._id_99A4 = 1;
  level._id_AB29--;
  level._id_AB27++;
  self notify("processDelayDeath");
  self dodamage(var_2, var_5, var_1, undefined, var_3, var_4);
}

_id_1F4C() {
  if(gettime() - self._id_90AB <= 0.05)
    return 0;

  if(isDefined(self.poweredupfx))
    return 0;

  return 1;
}

_id_5774(var_0) {
  return isDefined(self._id_6F44) && self._id_6F44;
}

_id_AC36(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");

  while(isDefined(self) && isalive(self)) {
    self._id_6F44 = 1;

    if(!_id_1F4C()) {
      waitframe();
      continue;
    }

    self._id_6F44 = 0;
    _id_054D::_id_6BD3(var_0, var_1, self.health + 1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, "");
  }
}

_id_376A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level._id_5B95 = self.origin;

  if(!common_scripts\utility::_id_562E(level.zmbdisablechancetospawnpickup))
    level thread maps\mp\gametypes\zombies::_id_20B0(var_1, self, var_3, var_4);

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread _id_054E::_id_72D2(var_6, var_3, var_4, self);
    var_1 maps\mp\_utility::incplayerstat("kills", 1);
    var_1 maps\mp\_utility::incpersstat("kills", 1);
    var_1._id_00E3 = var_1 maps\mp\_utility::getpersstat("kills");
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "kills", var_1._id_00E3);
    level notify("zom_kill");

    if(maps\mp\_utility::_id_4431(var_4) == var_1._id_76D8)
      var_1._id_A9BA[var_1._id_76D9]._id_00E3 = var_1._id_A9BA[var_1._id_76D9]._id_00E3 + 1;
    else {
      var_9 = _id_4837(var_1, var_4);

      if(var_9 == -1) {
        var_1._id_76D8 = "";
        var_1._id_76D9 = -1;
      } else {
        var_1._id_A9BA[var_9]._id_00E3 = var_1._id_A9BA[var_9]._id_00E3 + 1;
        var_1._id_76D8 = maps\mp\_utility::_id_4431(var_4);
        var_1._id_76D9 = var_9;
      }
    }
  }

  _id_2157(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_2157(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_376B)) {
    if(isDefined(level._id_7756))
      self thread[[level._id_7756]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    else
      return;
  }

  for(var_9 = 0; var_9 < level._id_376B.size; var_9++)
    self thread[[level._id_376B[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(level.postenemykilledfuncs)) {
    for(var_9 = 0; var_9 < level.postenemykilledfuncs.size; var_9++)
      self thread[[level.postenemykilledfuncs[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

register_postenemykilledfunc(var_0) {
  if(!isDefined(level.postenemykilledfuncs))
    level.postenemykilledfuncs = [];

  level.postenemykilledfuncs[level.postenemykilledfuncs.size] = var_0;
}

deregister_postenemykilledfunc(var_0) {
  if(isDefined(level.postenemykilledfuncs))
    level.postenemykilledfuncs = common_scripts\utility::_id_0F93(level.postenemykilledfuncs, var_0);
}

_id_7BA9(var_0) {
  if(!isDefined(level._id_376B))
    level._id_376B = [];

  level._id_376B[level._id_376B.size] = var_0;
}

_id_2D8C(var_0) {
  if(isDefined(level._id_376B))
    level._id_376B = common_scripts\utility::_id_0F93(level._id_376B, var_0);
}

check_allykilledfuncs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.allykilledfuncs)) {
    if(isDefined(level.processallykilledfunc))
      self thread[[level.processallykilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    else
      return;
  }

  for(var_9 = 0; var_9 < level.allykilledfuncs.size; var_9++)
    self thread[[level.allykilledfuncs[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

register_allykilledfunc(var_0) {
  if(!isDefined(level.allykilledfuncs))
    level.allykilledfuncs = [];

  level.allykilledfuncs[level.allykilledfuncs.size] = var_0;
}

deregister_allykilledfunc(var_0) {
  if(isDefined(level.allykilledfuncs))
    level.allykilledfuncs = common_scripts\utility::_id_0F93(level.allykilledfuncs, var_0);
}

_id_AB18(var_0, var_1) {
  self endon("death");

  if(isDefined(level.zmb_custom_crawl_rule))
    var_0 = [[level.zmb_custom_crawl_rule]](var_0);

  wait(var_0);

  if(isDefined(var_1))
    self._id_1DEB = var_1;

  self suicide();
}

_id_577A(var_0, var_1) {
  if(!_id_5767(var_0))
    return 0;

  if(_id_577E(var_0) && !(common_scripts\utility::_id_562E(var_1) && var_0 _id_73BF()) && maps\mp\agents\_agent_utility::_id_45C7(var_0) == 0)
    return 0;

  if(!isDefined(var_0.sessionstate) || var_0.sessionstate != "playing")
    return 0;

  return 1;
}

_id_0F51(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(isDefined(var_0) && var_0 == var_4) {
      continue;
    }
    var_2 = var_2 | _id_577A(var_4, var_1);
  }

  return var_2;
}

_id_1F2C() {
  foreach(var_1 in level.players) {
    if(var_1 _id_73BF())
      return 1;
  }

  return 0;
}

_id_73BF() {
  if(_id_83C0())
    return 1;

  if(self.sessionstate != "playing")
    return 0;

  if(_id_0553::_id_4B87())
    return 1;

  if(_id_0576::_id_4B92() && !common_scripts\utility::_id_562E(level.block_self_revive_use))
    return 1;

  if(common_scripts\utility::_id_562E(self.mapreviveenabled))
    return 1;

  return 0;
}

_id_83C0() {
  return 0;
}

_id_5731() {
  var_0 = maps\mp\_utility::gameflag("insta_kill");
  return var_0;
}

_id_577E(var_0) {
  return isDefined(var_0._id_00E8) && var_0._id_00E8;
}

_id_5783(var_0) {
  return isDefined(var_0._id_53F0) && var_0._id_53F0;
}

_id_577D(var_0) {
  return isDefined(var_0._id_5118) && var_0._id_5118;
}

_id_0F10() {
  foreach(var_1 in level.players) {
    if(_id_577D(var_1))
      return 1;
  }

  return 0;
}

_id_09E9(var_0, var_1) {
  var_0.switchtoweaponimmediate[var_1] = 1;
}

_id_7CF8(var_0, var_1) {
  var_0.switchtoweaponimmediate[var_1] = undefined;
}

_id_57C2(var_0) {
  return var_0.switchtoweaponimmediate.size > 0;
}

setclienttriggeraudiozonelerp(var_0) {
  if(var_0) {
    self._id_00CE = 1;

    if(!isDefined(self._id_509C) || self._id_509C < 0)
      self._id_509C = 0;

    self._id_509C++;
  } else if(isDefined(self._id_509C) && self._id_509C > 0) {
    self._id_509C--;

    if(self._id_509C > 0) {
      return;
    }
    self._id_00CE = 0;
  }
}

_id_8A6D(var_0) {
  if(!isDefined(self._id_AC5C)) {
    self._id_AC5C = 0;
    self._id_AC5B = 0;
  }

  var_1 = 0;

  if(var_0) {
    self._id_AC5C++;
    var_1 = self._id_AC5C == 1;
  } else if(self._id_AC5C > 0) {
    self._id_AC5C--;
    var_1 = self._id_AC5C == 0;
  }

  if(var_1) {
    self._id_AC5B = var_0;
    self notify("zombiesIgnoreMeChanged", var_0);
  }
}

_id_2306() {
  return isDefined(level._id_AC52) && level._id_AC52;
}

_id_0C23(var_0) {
  var_1 = "specialty_longersprint";

  if(var_0)
    maps\mp\_utility::giveperk(var_1);
  else if(maps\mp\_utility::_hasperk(var_1))
    maps\mp\_utility::_id_0735(var_1);
}

_id_73B0(var_0, var_1) {
  maps\mp\_utility::_id_0693("extendedSprint", var_0, var_1, ::_id_0C23, 0);
}

_id_0C26(var_0) {
  var_1 = "specialty_lightweight";

  if(var_0)
    maps\mp\_utility::giveperk(var_1);
  else if(maps\mp\_utility::_hasperk(var_1))
    maps\mp\_utility::_id_0735(var_1);
}

_id_73B1(var_0, var_1) {
  maps\mp\_utility::_id_0693("lightweight", var_0, var_1, ::_id_0C26, 0);
}

_id_AC16(var_0, var_1) {
  maps\mp\_utility::_id_73AF(var_0, var_1);
  _id_73B0(var_0, var_1);
  _id_73B1(var_0, var_1);
}

_id_4474(var_0) {
  return "" + var_0;
}

_id_4660(var_0) {
  switch (var_0) {
    case 0:
      return 0;
    case 100:
      return 0;
    case 200:
      return 100;
    case 250:
      return 100;
    case 300:
      return 200;
    case 400:
      return 200;
    case 500:
      return 250;
    case 600:
      return 300;
    case 700:
      return 300;
    case 750:
      return 300;
    case 800:
      return 400;
    case 900:
      return 400;
    case 1000:
      return 500;
    case 1250:
      return 500;
    case 1500:
      return 750;
    case 1750:
      return 800;
    case 2000:
      return 1000;
    case 2500:
      return 1250;
    case 3000:
      return 1500;
    case 4000:
      return 2000;
    case 5000:
      return 2500;
    default:
      return 500;
  }
}

_id_4522(var_0) {
  switch (var_0) {
    case 0:
      return 0;
    case 100:
      return 200;
    case 200:
      return 300;
    case 250:
      return 400;
    case 300:
      return 500;
    case 400:
      return 600;
    case 500:
      return 1000;
    case 600:
      return 1000;
    case 700:
      return 1000;
    case 750:
      return 1000;
    case 800:
      return 1250;
    case 900:
      return 1500;
    case 1000:
      return 1500;
    case 1250:
      return 1750;
    case 1500:
      return 2000;
    case 1750:
      return 2500;
    case 2000:
      return 2500;
    case 2500:
      return 3000;
    case 3000:
      return 4000;
    case 3750:
      return 4000;
    case 4000:
      return 5000;
    case 5000:
      return 7500;
    case 7500:
      return 10000;
    case 10000:
      return 10000;
    default:
      return 1000;
  }
}

_id_ABF1(var_0, var_1) {
  if(getdvarint("spawnZombiesWithEyes", 0) == 0) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = "tag_eye";

  self._id_3998 = 1;
  _id_74A5(common_scripts\utility::_id_44F5(var_0), self, var_1);
  thread _id_AC61(var_0, var_1, "humanoidPendingDeath");
}

_id_AC61(var_0, var_1, var_2) {
  self notify("zombieStopEyeEffectsOnNotify");
  self endon("zombieStopEyeEffectsOnNotify");
  self endon("death");
  self waittill(var_2);
  _id_9406(common_scripts\utility::_id_44F5(var_0), self, var_1);
}

_id_2D19(var_0) {
  if(_isagent(var_0))
    var_0 maps\mp\agents\_agent_utility::deleteentonagentdeath(self);
  else
    _id_2D20(var_0, "death");
}

_id_2D20(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);

  if(isDefined(self))
    self delete();
}

_id_57DB(var_0) {
  return !isDefined(level._id_62B2[var_0]);
}

_id_0FBF(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(_isnumber(var_4)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_1[var_4] = var_3;
  }

  return var_1;
}

_id_5702(var_0) {
  if(!isDefined(var_0._id_0A4B))
    return 0;

  if(var_0._id_0A4B != "zombie_generic")
    return 0;

  return 1;
}

_id_4B4F(var_0) {
  return isDefined(var_0._id_08D9);
}

_id_21AA(var_0) {
  return isDefined(self._id_08D9) && isDefined(self._id_08D9[var_0]);
}

resetcharacterclientindex(var_0) {
  if(!isDefined(level._id_AB21)) {
    return;
  }
  level._id_AB21[level._id_AB21.size] = var_0;
}

selectcharacterclientindextouse() {
  if(isDefined(level._id_AB21) && level._id_AB21.size == 0)
    return -1;

  var_0 = -1;

  if(!isDefined(level._id_AB21)) {
    level._id_AB21 = [];
    level._id_AB21[level._id_AB21.size] = 3;
    level._id_AB21[level._id_AB21.size] = 2;
    level._id_AB21[level._id_AB21.size] = 1;
    level._id_AB21[level._id_AB21.size] = 0;
  }

  var_0 = level._id_AB21[level._id_AB21.size - 1];
  level._id_AB21[level._id_AB21.size - 1] = undefined;
  return var_0;
}

scragentsetorientmode(var_0) {
  if(isDefined(var_0))
    return var_0;

  var_1 = self getplayerdata(common_scripts\utility::_id_46A8(), "activeCostume");
  var_2 = self getplayerdata(common_scripts\utility::_id_46A8(), "costumePrefZM");
  var_3 = [0, 1, 2, 3];
  var_4 = [];
  var_5 = "mp/zombieDLC3MapInfoTable.csv";

  if(_tableexists(var_5) && _tablegetrowcount(var_5) > 0) {
    var_6 = tablelookup(var_5, 0, maps\mp\_utility::_id_4571(), 2);

    if(isDefined(var_6) && var_6 != "") {
      var_7 = strtok(var_6, " ,");

      foreach(var_9 in var_7)
      var_4[var_4.size] = int(var_9);
    }

    if(var_4.size >= 4)
      var_3 = common_scripts\utility::_id_0F8C(var_3, var_4);
    else
      var_4 = var_3;
  }

  var_11 = [];

  foreach(var_13 in level.players)
  var_11[var_13._id_20D8] = 1;

  if((var_1 < 4 || !common_scripts\utility::_id_562E(var_2)) && common_scripts\utility::_id_562E(var_11[var_1]) && common_scripts\utility::_id_0F79(var_3, var_1)) {
    var_15 = [];

    foreach(var_9 in var_4) {
      if(!common_scripts\utility::_id_562E(var_11[var_9]))
        var_15[var_15.size] = var_9;
    }

    var_1 = common_scripts\utility::random(var_15);
    self setplayerdata(common_scripts\utility::_id_46A8(), "activeCostume", var_1);
    self setplayerdata(common_scripts\utility::_id_46A8(), "costumePrefZM", 0);
  }

  return var_1;
}

_id_0A00(var_0, var_1) {
  var_2 = var_0._id_A9BB;
  var_3 = maps\mp\_utility::_id_4431(var_1);

  if(var_2 == 0) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4._id_4DDE = 0;
    var_4._id_32D0 = 0;
    var_4._id_4BF9 = 0;
    var_4._id_55D3 = _id_5868(var_1);
    var_4._id_00E3 = 0;
    var_4._id_72AC = var_0.clientid;
    var_4._id_8B34 = 0;
    var_4._id_99E8 = 0;
    var_0._id_A9BA[var_2] = var_4;
    var_0._id_A9BB = var_0._id_A9BB + 1;
  } else if(var_2 > 0 && var_2 < 10) {
    for(var_5 = 0; var_5 < var_2; var_5++) {
      if(var_0._id_A9BA[var_5].name == var_3)
        return;
    }

    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4._id_4DDE = 0;
    var_4._id_32D0 = 0;
    var_4._id_4BF9 = 0;
    var_4._id_55D3 = _id_5868(var_1);
    var_4._id_00E3 = 0;
    var_4._id_72AC = var_0.clientid;
    var_4._id_8B34 = 0;
    var_4._id_99E8 = 0;
    var_0._id_A9BA[var_2] = var_4;
    var_0._id_A9BB = var_0._id_A9BB + 1;
  }
}

_id_4837(var_0, var_1) {
  var_2 = var_0._id_A9BB;
  var_3 = maps\mp\_utility::_id_4431(var_1);

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(var_0._id_A9BA[var_4].name == var_3)
      return var_4;
  }

  return -1;
}

_id_429D(var_0) {
  return var_0._id_20D8;
}

_id_4309() {
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.team == level._id_3772)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_5565(var_0, var_1) {
  return isDefined(var_0) && isDefined(var_1) && var_0 == var_1;
}

scragentgettraversenoderadius(var_0) {
  self._id_56EA = var_0;
}

_id_429E() {
  return self._id_56EA;
}

initializezmcostumemodels() {
  level.zmcostumes = [];
  var_0 = _tablegetrowcount("mp/zmCharacterIdTable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = [_id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 1)), _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 2)), _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 3)), _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 4)), _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 5)), _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_1, 6))];
    level.zmcostumes[level.zmcostumes.size] = var_2;
  }

  if(isDefined(level.zmcharactervariantid) && level.zmcharactervariantid > 0) {
    for(var_10 = _tablegetrowcount("mp/zmCharacterVariantIdTable.csv") - 1; var_10 >= 0; var_10 = var_11 - 1) {
      var_11 = _tablelookuprownum("mp/zmCharacterVariantIdTable.csv", 7, level.zmcharactervariantid, var_10);

      if(var_11 >= 0) {
        var_2 = [_id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 1)), _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 2)), _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 3)), _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 4)), _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 5)), _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 6))];
        var_1 = _id_9470(_tablelookupbyrow("mp/zmCharacterVariantIdTable.csv", var_11, 0));
        level.zmcostumes[var_1] = var_2;
      }
    }
  }
}

_id_8648(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 == 0)
    self waittill("spawned_player");

  if(!isDefined(level.zmcostumes) || !isDefined(level.zmcostumes[self._id_20D8]))
    initializezmcostumemodels();

  if(!isDefined(var_0)) {
    var_0 = "sold";
    self._id_20D8 = 0;
  }

  if(self._id_20D8 < 0 || self._id_20D8 >= level.zmcostumes.size) {
    var_0 = "sold";
    self._id_20D8 = 0;
  }

  self._id_267E = level.zmcostumes[self._id_20D8];
  self _meth_84C7(self._id_267E);
  self._id_20DA = var_0;
  self.altchartypes = var_2;
}

_id_4780(var_0) {
  var_1 = -1;

  if(!isDefined(self.characterclientindex))
    var_1 = selectcharacterclientindextouse();
  else
    var_1 = self.characterclientindex;

  var_2 = scragentsetorientmode(var_0);
  var_3 = 1;

  if(var_2 == -1) {
    var_3 = 0;
    var_2 = 0;
  }

  if(var_3) {
    var_4 = "ui_zm_characterClient_" + var_1;
    _setomnvar(var_4, self getentitynumber());
    var_5 = "ui_zm_character_" + var_1;
    _setomnvar(var_5, var_2);
    var_6 = "ui_zm_character_" + var_1 + "_alive";
    _setomnvar(var_6, 0);
    thread _id_7D59(var_4, var_5, var_6, var_1);
  }

  self._id_20D8 = var_2;
  self.characterclientindex = var_1;
  _id_865A(self._id_20D8, 0);
  _id_8647(self._id_20D8);
}

_id_8647(var_0) {
  self._id_3A63 = [];
  var_1 = _id_0378::dlg_get_char_name_callouts_from_index(self._id_20D8);
  var_1 = var_1 + "_";
  level._id_A62B _id_054E::_id_AB1E("player", var_1, self, self._id_20D8);
  _id_04C2::_id_2F72(self);

  if(var_0 == 39)
    self.nobayocharge = 1;
}

_id_865A(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;

  if(!isDefined(level.charidtotype) || !isDefined(level.charidtogender) || !isDefined(level.charidtoalttypes)) {
    level.charidtotype = [];
    level.charidtogender = [];
    level.charidtoalttypes = [];
    var_4 = _tablegetrowcount("mp/zmCharacterIdTable.csv");

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = _tablelookupbyrow("mp/zmCharacterIdTable.csv", var_5, 13);
      var_7 = _id_9470(_tablelookupbyrow("mp/zmCharacterIdTable.csv", var_5, 14));
      var_8 = _tablelookupbyrow("mp/zmCharacterIdTable.csv", var_5, 15);
      level.charidtotype[var_5] = var_6;
      level.charidtogender[var_5] = var_7;
      level.charidtoalttypes[var_5] = var_8;
    }
  }

  if(!isDefined(var_0) || !isDefined(level.charidtotype[var_0]))
    var_0 = 0;

  var_2 = level.charidtotype[var_0];
  var_3 = level.charidtogender[var_0];
  var_9 = level.charidtoalttypes[var_0];

  if(isDefined(var_2)) {
    thread _id_8648(var_2, var_1, var_9);
    scragentgettraversenoderadius(var_3);
    _id_0378::_id_8DDA(var_0);
  }
}

_id_7D59(var_0, var_1, var_2, var_3) {
  self waittill("disconnect");
  _setomnvar(var_0, -1);
  _setomnvar(var_1, -1);
  _setomnvar(var_2, 0);
  _setomnvar("ui_zm_points_" + var_3, 0);
  resetcharacterclientindex(var_3);
}

_id_3C8A(var_0, var_1) {
  level thread _id_0628(var_0, var_1);
}

_id_0628(var_0, var_1) {
  if(_isarray(var_0))
    common_scripts\utility::_id_3CA1(var_0);
  else
    common_scripts\utility::_id_3C9F(var_0);

  common_scripts\utility::flag_set(var_1);
}

_id_45A2() {
  return int(gettime() / 100);
}

_id_A6F6() {
  waitframe();
  waitframe();
}

_id_74A5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 0;

  thread _id_069C(var_0, var_1, var_2, var_3);
}

_id_069C(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _id_076F(var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!var_3 && !isDefined(level._id_37E6[var_1 getentitynumber()]))
    level._id_37E6[var_1 getentitynumber()] = var_1;

  _playfxontag(var_0, var_1, var_2);
  var_1 _id_061D();
  var_4 = spawnStruct();
  var_4._id_502A = var_0;
  var_4._id_95B9 = var_2;
  var_1._id_9BA5[var_1._id_9BA5.size] = var_4;
  var_1 thread _id_0621(var_4);
}

_id_74A4(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _id_069B(var_0, var_1, var_2, var_3);
}

_id_069B(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _id_076F(var_1);
  _playfxontagforclients(var_0, var_1, var_2, var_3);
  var_1 _id_061D();
}

_id_9405(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _id_0724(var_0, var_1, var_2, var_3);
}

_id_0724(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _id_076F(var_1);
  _stopfxontagforclient(var_0, var_1, var_2, var_3);
  var_1 _id_061D();
}

_id_9406(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  thread _id_0725(var_0, var_1, var_2);
}

_id_0725(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _id_076F(var_1);
  _stopfxontag(var_0, var_1, var_2);
  var_1 _id_061D();
}

_id_5A48(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  _id_066B(var_0, var_1, var_2);
}

_id_066B(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 notify("StopFxOnTagNetwork_" + var_0 + var_2);
  var_1 endon("StopFxOnTagNetwork_" + var_0 + var_2);
  _id_076F(var_1);
  _killfxontag(var_0, var_1, var_2);
  var_1 _id_061D();
}

_id_076F(var_0) {
  var_1 = 0;

  if(!isDefined(var_0._id_9BA6))
    var_0 _id_061F();
  else if(_id_45A2() > var_0._id_9BA6._id_666D)
    var_0 _id_061E();

  while(var_0._id_9BA6._id_005C >= level._id_666C || isDefined(var_0._id_002B) && var_0._id_002B == gettime()) {
    _id_A6F6();
    var_1 = 1;

    if(!isDefined(var_0))
      return var_1;

    if(!isDefined(var_0._id_9BA6))
      var_0 _id_061F();

    if(_id_45A2() > var_0._id_9BA6._id_666D)
      var_0 _id_061E();
  }

  return var_1;
}

_id_061F() {
  self._id_9BA5 = [];
  self._id_9BA6 = spawnStruct();
  _id_061E();
}

_id_061E() {
  self._id_9BA6._id_005C = 0;
  self._id_9BA6._id_666D = _id_45A2();
}

_id_061D() {
  self._id_9BA6._id_005C++;
}

_id_0621(var_0) {
  self endon("death");
  thread _id_0620();
  self waittill("StopFxOnTagNetwork_" + var_0._id_502A + var_0._id_95B9);
  self._id_9BA5 = common_scripts\utility::_id_0F93(self._id_9BA5, var_0);

  if(self._id_9BA5.size == 0)
    thread _id_061C();
}

_id_0620() {
  self notify("_entityKillFXOnDeath");
  self endon("_entityKillFXOnDeath");
  var_0 = self getentitynumber();
  self waittill("death");
  level._id_37E6[var_0] = undefined;

  if(isDefined(self)) {
    self._id_9BA5 = undefined;
    self._id_9BA6 = undefined;
  }
}

_id_061C() {
  level._id_37E6[self getentitynumber()] = undefined;
  self._id_9BA5 = undefined;
  self._id_9BA6 = undefined;
}

_id_92D8(var_0) {
  var_0 endon("disconnect");

  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn())
    var_0 waittill("spawned_player");
  else
    var_0 waittill("joined_spectators");

  _id_A78A(var_0);

  if(common_scripts\utility::_id_562E(var_0._id_5C16)) {
    return;
  }
  var_0._id_5C16 = 1;

  foreach(var_2 in level._id_37E6)
  thread _id_92D9(var_0, var_2);
}

_id_92D9(var_0, var_1) {
  var_1 endon("death");

  if(!isDefined(var_1) || !isDefined(var_1._id_9BA5)) {
    return;
  }
  var_2 = [];
  var_3 = var_1._id_9BA5.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_1._id_9BA5[var_4];
    _id_9405(var_5._id_502A, var_1, var_5._id_95B9, var_0);
    var_2[var_2.size] = var_5;
  }

  _id_A78A(var_0);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5) || !common_scripts\utility::_id_0F79(var_1._id_9BA5, var_5)) {
      continue;
    }
    _id_74A4(var_5._id_502A, var_1, var_5._id_95B9, var_0);
  }
}

_id_4AD7() {
  thread _id_6B6F();
  thread _id_6B44();
}

_id_6B6F() {
  if(!isDefined(level._id_37E6))
    level._id_37E6 = [];

  level._id_666C = 2;

  for(;;) {
    level waittill("connected", var_0);

    if(isbot(var_0)) {
      continue;
    }
    level thread _id_92D8(var_0);
  }
}

_id_6B44() {
  for(;;) {
    level waittill("host_migration_begin");

    foreach(var_1 in level._id_37E6)
    thread _id_92D7(var_1);
  }
}

_id_92D7(var_0) {
  var_0 endon("death");

  if(!isDefined(var_0) || !isDefined(var_0._id_9BA5)) {
    return;
  }
  waittillframeend;
  var_1 = [];
  var_2 = var_0._id_9BA5.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_0._id_9BA5[var_3];
    _id_9406(var_4._id_502A, var_0, var_4._id_95B9);
    var_1[var_1.size] = var_4;
  }

  level waittill("host_migration_end");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];
    _id_74A5(var_4._id_502A, var_0, var_4._id_95B9);
  }
}

_id_5752(var_0) {
  if(isDefined(var_0)) {
    var_1 = _getweaponbasename(var_0);

    if(!isDefined(var_1))
      return 0;

    switch (var_1) {
      case "electric_cherry_zm":
      case "raven_sword_tod_aoe_zm":
        return 1;
    }

    if(isDefined(level.meleeaoeweapons[var_1]))
      return 1;
  }

  return 0;
}

_id_580B(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "zombie_trap_turret_mp":
      case "trap_sniper_zm_mp":
      case "trap_missile_zm_mp":
      case "trap_zm_mp":
      case "portaltrap_zm":
      case "zombie_water_trap_mp":
      case "zombie_vaporize_mp":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

_id_57AC(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "portaltrap_zm":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

_id_466A(var_0) {
  switch (var_0) {
    case "zombie_dog":
      return 1;
    case "normal":
    default:
      return 0;
  }
}

_id_A737() {
  while(!_id_4B2C())
    waitframe();
}

_id_4B2C() {
  return common_scripts\utility::_id_562E(self._id_4BA0);
}

disableoffhandsecondaryweapons() {
  if(!common_scripts\utility::_id_562E(self._id_4BA0)) {
    self._id_4BA0 = 1;
    self._id_37BB = self.origin;
  }
}

_id_5819(var_0) {
  return isDefined(var_0.setmovespeedscale);
}

_id_581A(var_0) {
  return !isDefined(var_0.setmovespeedscale) || var_0.setmovespeedscale == 0;
}

_id_8A4F(var_0, var_1, var_2) {
  if(!isDefined(var_0.setmovespeedscale)) {
    return;
  }
  var_0 common_scripts\utility::_id_9D9F();
  var_0._id_2307 = 0;
  var_3 = [];
  var_3["trigger"] = var_0;
  var_3["updateFunc"] = var_1;
  var_3["otherClientsUpdateFunc"] = var_2;
  thread _id_A243(var_3);
}

_id_A243(var_0) {
  var_1 = var_0["trigger"];
  var_1 endon("death");
  maps\mp\_utility::_id_6F74(::_id_A242, var_0);
}

_id_A242(var_0) {
  var_1 = var_0["trigger"];
  var_2 = var_0["otherClientsUpdateFunc"];

  if(_id_0696(var_1))
    thread _id_0694(var_0);
  else if(isDefined(var_2))
    var_1 thread[[var_2]](self);
}

_id_0696(var_0) {
  return isDefined(var_0.setmovespeedscale) && self getentitynumber() == var_0.setmovespeedscale;
}

_id_0694(var_0) {
  var_1 = var_0["trigger"];
  self clientclaimtrigger(var_1);
  var_1 common_scripts\utility::_id_9DA3();
  var_1 notify("claimed");
  var_1._id_2307 = 1;
  var_1._id_230A = self;
  thread _id_069A(var_0);
  var_2 = var_0["updateFunc"];
  var_1 thread[[var_2]](self);
}

_id_069A(var_0) {
  var_1 = var_0["trigger"];
  var_1 endon("death");
  self waittill("disconnect");

  if(isDefined(self))
    self clientreleasetrigger(var_1);

  var_1 common_scripts\utility::_id_9D9F();
  var_1._id_2307 = 0;
  var_1._id_230A = undefined;
}

_id_57AF(var_0) {
  return var_0 == "turretheadenergy_mp" || var_0 == "turretheadrocket_mp" || var_0 == "turretheadmg_mp";
}

_id_6C72(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2.sessionstate == "spectator" || var_2.sessionstate == "intermission") {
        continue;
      }
      if(var_2 isnoclip()) {
        continue;
      }
      var_3 = var_2 _id_055A::_id_462D();

      if(!isDefined(var_3)) {
        var_4 = !var_0;

        if(var_4)
          var_2 suicide();
        else {
          _iprintlnbold("Player out of bounds at " + var_2.origin);
          wait 1;
        }
      }

      if(!var_0)
        wait 0.5;
    }

    waitframe();
  }
}

_id_A78A(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0 getsnapshotindexforclient();

  if(!isDefined(var_1)) {
    return;
  }
  for(;;) {
    waitframe();
    var_2 = var_0 getsnapshotacknowledgedindexforclient();

    if(!isDefined(var_2)) {
      return;
    }
    if(var_2 >= var_1) {
      break;
    }
  }
}

_id_A78B() {
  while(!isDefined(level.players) || level.players.size <= 0)
    waitframe();
}

trackzombiedvar(var_0) {
  if(!isDefined(level.zombie_tracked_dvars))
    level.zombie_tracked_dvars = [];

  var_1 = spawnStruct();
  var_1.dvar_name = var_0;
  var_1.dvar_value = getDvar(var_0);
  level.zombie_tracked_dvars[level.zombie_tracked_dvars.size] = var_1;
  return var_1;
}

_id_585E() {
  if(!isDefined(level._id_AC21))
    return 0;

  return level._id_AC21;
}

_id_4AE4(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.zmb_events_purchase_callback))
    level thread[[level.zmb_events_purchase_callback]](var_0, var_1, var_2);

  if(isDefined(level.zmb_events_purchase_notify))
    var_0 notify(level.zmb_events_purchase_notify + "_" + var_1);

  var_3 = _id_AAF9(var_3, 1, 0);
  var_5 = level._id_77B7;

  if(var_5 >= 500) {
    return;
  }
  var_6 = var_0 getentitynumber();
  var_7 = gettime();
  var_8 = var_0.origin;
  var_9 = level._id_A980;
  setmatchdata("purchase_events", var_5, "purchase_type", var_1);
  setmatchdata("purchase_events", var_5, "player_index", var_6);
  setmatchdata("purchase_events", var_5, "game_time", int(var_7));
  setmatchdata("purchase_events", var_5, "round_index", var_9);
  setmatchdata("purchase_events", var_5, "pos", 0, maps\mp\_utility::_id_2315(var_8[0]));
  setmatchdata("purchase_events", var_5, "pos", 1, maps\mp\_utility::_id_2315(var_8[1]));
  setmatchdata("purchase_events", var_5, "pos", 2, maps\mp\_utility::_id_2315(var_8[2]));
  setmatchdata("purchase_events", var_5, "cost", var_2);

  if(_func_12A("ZombieWeapon", var_3))
    setmatchdata("purchase_events", var_5, "weapon", var_3);
  else {}

  if(_func_12A("ZombieDoors", var_4))
    setmatchdata("purchase_events", var_5, "door", var_4);
  else if(!common_scripts\utility::_id_562E(level.door_data_out_of_date)) {}

  level._id_77B7++;
}

writeusedconsumable(var_0, var_1, var_2) {
  if(!level._id_585D) {
    return;
  }
  var_3 = getmatchdata("consumable_count");
  setmatchdata("consumable_count", var_3 + 1);

  if(var_3 < 16) {
    var_4 = level._id_A980 - 1;
    setmatchdata("consumables", var_3, "guid", var_0);
    setmatchdata("consumables", var_3, "player_index", var_1);
    setmatchdata("consumables", var_3, "round_index", var_4);
    setmatchdata("consumables", var_3, "time_activated_ms", maps\mp\_utility::gettimepassed());
    setmatchdata("consumables", var_3, "position", 0, maps\mp\_utility::_id_2315(var_2[0]));
    setmatchdata("consumables", var_3, "position", 1, maps\mp\_utility::_id_2315(var_2[1]));
    setmatchdata("consumables", var_3, "position", 2, maps\mp\_utility::_id_2315(var_2[2]));
  }
}

_id_AABF() {
  var_0 = level._id_A980 - 1;
  _id_AABD();

  if(var_0 >= 0 && var_0 < 75) {
    var_1 = maps\mp\_utility::_id_2315(maps\mp\_utility::getsecondspassed());
    setmatchdata("rounds", var_0, "endTime", var_1);
    var_2 = getmatchdata("rounds", var_0, "startTime");
    setmatchdata("rounds", var_0, "duration", maps\mp\_utility::_id_2315(var_1 - var_2));
    setmatchdata("rounds", var_0, "round_players_total", maps\mp\_utility::_id_2314(level._id_745F));

    foreach(var_5, var_4 in self._id_AC60)
    setmatchdata("rounds", var_0, "zombies_spawned", var_5, var_4);
  }

  foreach(var_7 in level.players) {
    writezombieendgameplayerstats(var_7);

    if(var_0 >= 0 && var_0 < 75) {
      var_7 _id_7B36(var_0);
      var_7 _id_5292(var_0);
    }
  }
}

_id_AABD() {
  foreach(var_1 in level.players) {
    setmatchdata("players", var_1.clientid, "end_assists", maps\mp\_utility::_id_2315(var_1._id_0021));
    setmatchdata("players", var_1.clientid, "end_kills", maps\mp\_utility::_id_2315(var_1._id_00E3));
    setmatchdata("players", var_1.clientid, "end_hits", var_1._id_8B33);
    setmatchdata("players", var_1.clientid, "end_shots", var_1._id_8B3D);
    setmatchdata("players", var_1.clientid, "end_money_earned", var_1._id_62D7);
    setmatchdata("players", var_1.clientid, "end_money_spent", var_1._id_62D7 - var_1._id_62D6);
    setmatchdata("players", var_1.clientid, "end_magic_box_uses", maps\mp\_utility::_id_2315(var_1._id_5F7C));
    setmatchdata("players", var_1.clientid, "end_trap_uses", maps\mp\_utility::_id_2315(var_1._id_9CFF));
    setmatchdata("players", var_1.clientid, "end_headshot_kills", maps\mp\_utility::_id_2315(var_1._id_4BF7));
    setmatchdata("players", var_1.clientid, "end_melee_kills", maps\mp\_utility::_id_2315(var_1._id_60EC));
    setmatchdata("players", var_1.clientid, "end_explosive_kills", maps\mp\_utility::_id_2315(var_1._id_394C));
    setmatchdata("players", var_1.clientid, "play_time", var_1._id_9A06["total"]);
    setmatchdata("players", var_1.clientid, "end_total_downs", maps\mp\_utility::_id_2315(var_1._id_6882));
    setmatchdata("players", var_1.clientid, "end_total_rounds", maps\mp\_utility::_id_2315(level._id_A980));
    setmatchdata("players", var_1.clientid, "end_doors_opened", maps\mp\_utility::_id_2315(var_1._id_3295));
    setmatchdata("players", var_1.clientid, "present_at_end", var_1.connected);
    level._id_7F2B = [];
    level._id_7F2B["normal"] = 0;
    level._id_7F2B["zombie_dog"] = 1;
    level._id_7F2B["zombie_host"] = 2;
    level._id_7F2B["zombie_melee_goliath"] = 3;
    level._id_7F2B["civilian"] = 4;

    if(isDefined(level._id_7F2B[level._id_7F2A]))
      setmatchdata("players", var_1.clientid, "end_unlock_points", level._id_7F2B[level._id_7F2A]);

    for(var_2 = 0; var_2 < var_1._id_A9BB; var_2++) {
      var_3 = _id_AAF9(var_1._id_A9BA[var_2].name, 1, 0);

      if(!_id_5844(var_3))
        var_3 = "none";

      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "weapon_id", var_3);
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "hits", var_1._id_A9BA[var_2]._id_4DDE);
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "downs", maps\mp\_utility::_id_2314(var_1._id_A9BA[var_2]._id_32D0));
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "headshots", maps\mp\_utility::_id_2315(var_1._id_A9BA[var_2]._id_4BF9));
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "is_pap_version", var_1._id_A9BA[var_2]._id_55D3);
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "kills", maps\mp\_utility::_id_2315(var_1._id_A9BA[var_2]._id_00E3));
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "player_index", maps\mp\_utility::_id_2314(var_1._id_A9BA[var_2]._id_72AC));
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "shots", var_1._id_A9BA[var_2]._id_8B34);
      setmatchdata("players", var_1.clientid, "weapon_usage", var_2, "time_used", var_1._id_A9BA[var_2]._id_99E8);
    }
  }
}

_id_7B3A(var_0, var_1, var_2) {
  var_3 = self getweaponlistprimaries();

  for(var_4 = 0; var_4 < var_3.size && var_4 < 4; var_4++) {
    if(common_scripts\utility::_id_57E9(var_3[var_4], "alt+", 0, 4)) {
      continue;
    }
    var_5 = _id_AAF9(var_3[var_4], 1, 0);

    if(!_id_5844(var_5)) {
      continue;
    }
    if(_func_12A("ZombieWeapon", var_5)) {
      if(isDefined(var_2)) {
        if(!var_2)
          setmatchdata("rounds", var_0, "player_rounds", var_1, "start_weapons", var_4, var_5);
        else
          setmatchdata("rounds", var_0, "player_rounds", var_1, "end_weapons", var_4, var_5);
      }

      continue;
    }
  }
}

_id_7B37(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = self getentitynumber();
  var_2 = self.origin;
  setmatchdata("rounds", var_0, "player_rounds", var_1, "player_index", maps\mp\_utility::_id_2314(var_1));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "round_index", maps\mp\_utility::_id_2314(var_0));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "startPos", 0, int(var_2[0]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "startPos", 1, int(var_2[1]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "startPos", 2, int(var_2[2]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "start_score", int(self._id_62D7));

  if(!common_scripts\utility::_id_562E(level.door_data_out_of_date))
    setmatchdata("rounds", var_0, "player_rounds", var_1, "starting_zone", getplayerddlzonename());

  _id_7B3A(var_0, var_1, 0);
  var_3 = self getweaponlistall();
  var_4 = 1;

  foreach(var_6 in var_3) {
    var_7 = _getweaponbasename(var_6);
    var_8 = level._id_A9E2[var_7];

    if(!isDefined(var_8)) {
      continue;
    }
    if(_id_5863(var_7)) {
      setmatchdata("rounds", var_0, "player_rounds", var_1, "equipment", 0, var_8);
      continue;
    }

    if(_id_5866(var_7)) {
      setmatchdata("rounds", var_0, "player_rounds", var_1, "equipment", 1, var_8);
      continue;
    }

    var_9 = _id_4747(self, var_7);

    if(var_4) {
      var_4 = 0;
      setmatchdata("rounds", var_0, "player_rounds", var_1, "weapons", 0, var_8);
      setmatchdata("rounds", var_0, "player_rounds", var_1, "weaponLevels", 0, var_9);
    } else {
      setmatchdata("rounds", var_0, "player_rounds", var_1, "weapons", 1, var_8);
      setmatchdata("rounds", var_0, "player_rounds", var_1, "weaponLevels", 1, var_9);
    }
  }
}

_id_7B36(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = self getentitynumber();
  var_2 = self.origin;
  setmatchdata("rounds", var_0, "player_rounds", var_1, "endPos", 0, int(var_2[0]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "endPos", 1, int(var_2[1]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "endPos", 2, int(var_2[2]));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "moneyEarned", maps\mp\_utility::_id_2315(self._id_7F1D));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "moneySpent", maps\mp\_utility::_id_2315(self._id_7F1E));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "kills", maps\mp\_utility::_id_2315(self._id_00E3 - self._id_5A52));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "headshot_kills", maps\mp\_utility::_id_2315(self._id_4BF7 - self._id_4BF8));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "printerUses", maps\mp\_utility::_id_2314(self._id_5F7C - self._id_5F7D));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "perk_machines_used", maps\mp\_utility::_id_2314(self._id_6F5F - self._id_6F60));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "doors_purchased", maps\mp\_utility::_id_2314(self._id_3295 - self._id_3296));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "magic_box_uses", maps\mp\_utility::_id_2314(self._id_5F7C - self._id_5F7D));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "end_score", int(self._id_62D7));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "special_ability_uses", maps\mp\_utility::_id_2314(self._id_90CC - self._id_90CD));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "revives", maps\mp\_utility::_id_2314(self._id_0021 - self._id_7E60));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "jump_scares_triggered", maps\mp\_utility::_id_2314(self._id_598C - self._id_598D));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "pap_uses", maps\mp\_utility::_id_2314(self._id_6E48 - self._id_6E49));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "hints_used", maps\mp\_utility::_id_2314(self._id_4DC4 - self._id_4DC5));
  self._id_4DC5 = self._id_4DC4;
  _id_7B3A(var_0, var_1, 1);

  foreach(var_5, var_4 in self._id_AC5D)
  setmatchdata("rounds", var_0, "player_rounds", var_1, "zombies_killed", var_5, var_4);

  if(self._id_178B != self._id_6881)
    setmatchdata("rounds", var_0, "player_rounds", var_1, "died", 1);

  var_6 = getmatchdata("rounds", var_0, "startTime");
  var_7 = getmatchdata("rounds", var_0, "endTime");
  var_8 = var_7 - var_6;
  var_9 = self._id_6882 - self._id_32D1;
  setmatchdata("rounds", var_0, "player_rounds", var_1, "times_downed", maps\mp\_utility::_id_2314(var_9));
  var_10 = var_8;
  var_11 = getmatchdata("rounds", var_0, "player_rounds", var_1, "died");

  if(var_11) {
    var_12 = gettime();

    if(var_9 > 0 && _id_577E(self))
      self._id_32CD = self._id_32CD + int((var_12 - self._id_5BF3) / 1000);
    else
      self._id_32CD = self._id_32CD + int((var_12 - self._id_2AB8) / 1000);

    self._id_99F8 = self._id_99F8 + self._id_32CD;
  }

  var_10 = var_10 - self._id_99F8;
  setmatchdata("rounds", var_0, "player_rounds", var_1, "time_alive_total", maps\mp\_utility::_id_2315(var_10));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "windows_boarded", maps\mp\_utility::_id_2314(self._id_7F11));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "grenade_kills", maps\mp\_utility::_id_2314(self._id_4868 - self._id_7F06));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "ammo_purchased", maps\mp\_utility::_id_2314(self._id_7EFE));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "melee_kills", maps\mp\_utility::_id_2314(self._id_7F09));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "wallbuy_weapons_purchased", maps\mp\_utility::_id_2314(self._id_7F10));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "insta_kill_counter", maps\mp\_utility::_id_2314(self._id_7F07));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "double_points_counter", maps\mp\_utility::_id_2314(self._id_7F04));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "nuke_counter", maps\mp\_utility::_id_2314(self._id_7F0B));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "overcharge_counter", maps\mp\_utility::_id_2314(self._id_7F0D));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "max_ammo_counter", maps\mp\_utility::_id_2314(self._id_7F08));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "distance_travelled", int(self._id_3036 - self._id_3037));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "distance_sprinted", int(self._id_3034 - self._id_3035));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "total_shots", int(self._id_8B3D - self._id_8B39));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "hits", int(self._id_8B33 - self._id_4DE1));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "misses", int(self._id_8B3D - self._id_8B39 - (self._id_8B33 - self._id_4DE1)));

  if(!common_scripts\utility::_id_562E(level.door_data_out_of_date))
    setmatchdata("rounds", var_0, "player_rounds", var_1, "ending_zone", getplayerddlzonename());

  setmatchdata("rounds", var_0, "player_rounds", var_1, "sacrifices", maps\mp\_utility::_id_2314(self._id_801C - self.isonladder));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "failed_sacrifices", maps\mp\_utility::_id_2314(self._id_39E5 - self._id_39E6));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "failed_assists", maps\mp\_utility::_id_2314(self._id_39E3 - self._id_39E4));
  setmatchdata("rounds", var_0, "player_rounds", var_1, "explosive_kills", maps\mp\_utility::_id_2315(self._id_394C - self._id_3963));
}

_id_5292(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  self._id_7F1D = 0;
  self._id_7F1E = 0;
  self._id_99F8 = 0;
  self._id_32CD = 0;
  self._id_5BF3 = 0;
  self._id_5A52 = self._id_00E3;
  self._id_4BF8 = self._id_4BF7;
  self._id_3963 = self._id_394C;
  self._id_178B = self._id_6881;
  self._id_32D1 = self._id_6882;
  self._id_5F7D = self._id_5F7C;
  self._id_6F60 = self._id_6F5F;
  self._id_3296 = self._id_3295;
  self._id_5F7D = self._id_5F7C;
  self._id_90CD = self._id_90CC;
  self._id_7E60 = self._id_0021;
  self._id_598D = self._id_598C;
  self._id_6E49 = self._id_6E48;
  self._id_3037 = self._id_3036;
  self._id_3035 = self._id_3034;
  self._id_4DE1 = self._id_8B33;
  self._id_8B39 = self._id_8B3D;
  self.isonladder = self._id_801C;
  self._id_39E6 = self._id_39E5;
  self._id_39E4 = self._id_39E3;
  level._id_745F = level.players.size;
  self._id_7F11 = 0;
  self._id_7F06 = self._id_4868;
  self._id_7EFE = 0;
  self._id_7F09 = 0;
  self._id_7F10 = 0;
  self._id_7F07 = 0;
  self._id_7F04 = 0;
  self._id_7F0B = 0;
  self._id_7F0D = 0;
  self._id_7F08 = 0;
  var_1 = "mp/zombieTypeTable.csv";
  var_2 = _tablegetrowcount(var_1);

  if(var_2 > 24) {}

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _tablelookupbyrow(var_1, var_3, 1);
    self._id_AC5D[var_4] = 0;
  }
}

_id_7B34(var_0) {
  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_1 = maps\mp\_utility::_id_2315(maps\mp\_utility::getsecondspassed());
  setmatchdata("rounds", var_0, "startTime", var_1);

  foreach(var_3 in level.players)
  var_3 _id_7B37(var_0);

  level._id_7F25 = [];
  level._id_7F21 = [];
}

_id_7B33(var_0) {
  foreach(var_2 in level.players) {
    if(common_scripts\utility::_id_562E(var_2._id_596A)) {
      var_3 = var_0 + 1;

      switch (var_3) {
        case 10:
          var_2.besttimetrialtimes[0] = int(gettime() / 1000);
          break;
        case 25:
          var_2.besttimetrialtimes[1] = int(gettime() / 1000);
          break;
        case 50:
          var_2.besttimetrialtimes[2] = int(gettime() / 1000);
          break;
        case 100:
          var_2.besttimetrialtimes[3] = int(gettime() / 1000);
          break;
      }
    }
  }

  if(var_0 < 0 || var_0 >= 75) {
    return;
  }
  var_5 = maps\mp\_utility::_id_2315(maps\mp\_utility::getsecondspassed());
  setmatchdata("rounds", var_0, "endTime", var_5);
  var_6 = getmatchdata("rounds", var_0, "startTime");
  setmatchdata("rounds", var_0, "duration", maps\mp\_utility::_id_2315(var_5 - var_6));
  setmatchdata("rounds", var_0, "round_players_total", maps\mp\_utility::_id_2314(level._id_745F));

  foreach(var_9, var_8 in self._id_AC60)
  setmatchdata("rounds", var_0, "zombies_spawned", var_9, var_8);

  _id_7D79();

  foreach(var_11 in level._id_7F21) {
    if(var_11 >= 0 && var_11 < 24)
      setmatchdata("rounds", var_0, "powerStationActivated", var_11, 1);
  }

  var_13 = 0;

  foreach(var_15 in level._id_7F25) {
    var_16 = 1;

    foreach(var_18 in level._id_275F["airdrop_assault"]) {
      if(var_18.type == var_15) {
        setmatchdata("rounds", var_0, "supplyDrops", var_13, maps\mp\_utility::_id_2314(var_16));
        var_13++;
        break;
      }

      var_16++;
    }

    if(var_13 >= 2) {
      break;
    }
  }

  foreach(var_2 in level.players) {
    var_2 _id_7B36(var_0);
    var_2 _id_5292(var_0);
  }
}

writezombieendgameplayerstats(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_AB46["pendingXP"]) && var_0._id_AB46["pendingXP"] > 0) {
    var_1 = var_0._id_AB46["pendingXP"];
    var_0._id_AB46["pendingXP"] = 0;
  }

  if(var_1 > 0)
    var_0 _id_054C::zombieupdateplayerxp(var_1, 1);

  var_0 _id_054C::zombiewritestats();
  _id_8A6C(var_0, "totalGames", 1, 1);
  var_0 _id_0561::_id_AABA();

  if(isDefined(level._id_AC2E) && level._id_AC2E != 0)
    _id_A19C(var_0);
  else {}

  var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevMapEndTime", _gettimeutc());

  if(isDefined(level.unlockzmshatteredmap))
    var_0[[level.unlockzmshatteredmap]]();
}

_id_A19C(var_0) {
  updatezombieleaderboardgameplaystatsformap(var_0, 0);
  updatezombieleaderboardgameplaystatsformap(var_0, level._id_AC2E);

  if(common_scripts\utility::_id_562E(var_0._id_596A)) {
    _id_A19D(var_0, level._id_AC2E, 0);
    _id_A19D(var_0, level._id_AC2E, level.players.size);
  }
}

updatezombieleaderboardgameplaystatsformap(var_0, var_1) {
  inczombieleaderboardgameplaystat(var_0, var_1, "totalRounds", level._id_A980);
  inczombieleaderboardgameplaystat(var_0, var_1, "timePlayed", var_0._id_9A06["total"]);
  inczombieleaderboardgameplaystat(var_0, var_1, "gamesPlayed", 1);
  inczombieleaderboardgameplaystat(var_0, var_1, "kills", var_0._id_00E3);
  inczombieleaderboardgameplaystat(var_0, var_1, "headshots", var_0._id_0090);
  inczombieleaderboardgameplaystat(var_0, var_1, "revives", var_0._id_0021);
  inczombieleaderboardgameplaystat(var_0, var_1, "moneyEarned", var_0._id_62D7);
  inczombieleaderboardgameplaystat(var_0, var_1, "zombiePointsEarned", var_0.zombiepointsearned);
  inczombieleaderboardgameplaystat(var_0, var_1, "downs", var_0._id_6882);
  inczombieleaderboardgameplaystat(var_0, var_1, "shots", var_0._id_8B3D);
  inczombieleaderboardgameplaystat(var_0, var_1, "hits", var_0._id_8B33);
  inczombieleaderboardgameplaystat(var_0, var_1, "distanceTraveled", int(var_0._id_3036 * 0.00158));
  inczombieleaderboardgameplaystat(var_0, var_1, "doorsOpened", var_0._id_3295);
  inczombieleaderboardgameplaystat(var_0, var_1, "blitzUsed", var_0._id_6F5F);
  inczombieleaderboardgameplaystat(var_0, var_1, "explosiveKills", var_0.equipmentkills);
  inczombieleaderboardgameplaystat(var_0, var_1, "explosivesUsed", var_0.equipmentused);
}

_id_A19D(var_0, var_1, var_2) {
  setbestroundzombieleaderboardstats(var_0, var_1, var_2);

  if(isDefined(var_0.besttimetrialtimes[0])) {
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 0);

    if(!isDefined(var_3) || isDefined(var_3) && (var_0.besttimetrialtimes[0] < var_3 || var_3 == 0))
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 0, var_0.besttimetrialtimes[0]);
  }

  if(isDefined(var_0.besttimetrialtimes[1])) {
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 1);

    if(!isDefined(var_3) || isDefined(var_3) && (var_0.besttimetrialtimes[1] < var_3 || var_3 == 0))
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 1, var_0.besttimetrialtimes[1]);
  }

  if(isDefined(var_0.besttimetrialtimes[2])) {
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 2);

    if(!isDefined(var_3) || isDefined(var_3) && (var_0.besttimetrialtimes[2] < var_3 || var_3 == 0))
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 2, var_0.besttimetrialtimes[2]);
  }

  if(isDefined(var_0.besttimetrialtimes[3])) {
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 3);

    if(!isDefined(var_3) || isDefined(var_3) && (var_0.besttimetrialtimes[3] < var_3 || var_3 == 0))
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 3, var_0.besttimetrialtimes[3]);
  }

  if(isDefined(var_0.besttimetrialtimes[4])) {
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 4);

    if(!isDefined(var_3) || isDefined(var_3) && (var_0.besttimetrialtimes[4] < var_3 || var_3 == 0))
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestTimeTrialTimes", 4, var_0.besttimetrialtimes[4]);
  }
}

inczombieleaderboardperplayerstat(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, var_3);
  var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, var_3, var_5 + var_4);
}

inczombieleaderboardgameplaystat(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataGameplayStats", var_2);
  var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataGameplayStats", var_2, var_4 + var_3);
}

setbestroundzombieleaderboardstats(var_0, var_1, var_2) {
  var_3 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestRoundStats", "round");

  if(level._id_A980 > var_3) {
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestRoundStats", "round", level._id_A980);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestRoundStats", "kills", var_0._id_00E3);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestRoundStats", "revives", var_0._id_0021);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "leaderboardData", var_1, "leaderboardDataPerPlayerCount", var_2, "bestRoundStats", "downs", var_0._id_6882);
  }
}

_id_4745(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_0)) {
    return;
  }
  var_2 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), var_1);

  if(!isDefined(var_2))
    var_2 = 0;

  return var_2;
}

_id_8A6C(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 0;

  switch (var_3) {
    case 0:
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), var_1, var_2);
      break;
    case 1:
      var_4 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), var_1);
      var_5 = var_4 + var_2;
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), var_1, var_5);
      break;
    case 2:
      var_4 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), var_1);

      if(var_2 > var_4)
        var_0 setplayerdata(common_scripts\utility::_id_46A8(), var_1, var_2);

      break;
  }
}

_id_7D79() {
  var_0 = "mp/zombieTypeTable.csv";
  var_1 = _tablegetrowcount(var_0);

  if(var_1 > 24) {}

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = _tablelookupbyrow(var_0, var_2, 1);
    self._id_AC60[var_3] = 0;
  }
}

markmapcompleteforleaderboards() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1._id_596A))
      var_1.besttimetrialtimes[4] = int(gettime() / 1000);
  }
}

_id_86C8(var_0) {
  self._id_60F0 = var_0;
  self._id_60F1 = _squared(var_0);
}

_id_86C7(var_0) {
  self._id_60EF = var_0;
  self._id_60F2 = var_0 * var_0;
}

_id_73EA() {
  return self.pers["em1Ammo"]._id_0D95;
}

_id_743F(var_0) {
  self.pers["em1Ammo"]._id_0D95 = var_0;
}

_id_73F7() {
  return isDefined(self.pers["em1Ammo"]);
}

_id_73C6() {
  self.pers["em1Ammo"] = undefined;
}

_id_208E(var_0) {
  if(!isDefined(var_0._id_942B)) {
    var_0._id_942B = var_0 maps\mp\gametypes\_hud_util::createfontstring("hudbig", 0.75);
    var_0._id_942B maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -120);
    var_0._id_942B settext("");
  }

  if(!isDefined(var_0._id_9423)) {
    var_0._id_9423 = var_0 maps\mp\gametypes\_hud_util::createfontstring("hudbig", 0.75);
    var_0._id_9423 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -95);
    var_0._id_9423 settext("");
  }
}

_id_A795() {
  self endon("death");
  thread _id_A951();
  thread _id_A952();
  self waittill("used", var_0, var_1);
  return [var_0, var_1];
}

_id_A951() {
  self endon("used");
  self endon("death");
  self waittill("trigger", var_0);
  self notify("used", var_0, "trigger");
}

_id_A952() {
  self endon("used");
  self endon("death");

  if(!level._id_9A87) {
    return;
  }
  foreach(var_1 in level.players)
  thread _id_A953(var_1);

  for(;;) {
    level waittill("connected", var_1);
    thread _id_A953(var_1);
  }
}

_id_A953(var_0) {
  _id_A954(var_0);

  if(isDefined(var_0))
    var_0 _id_2413();
}

_id_A954(var_0) {
  self endon("used");
  self endon("death");
  var_0 endon("disconnect");
  var_1 = undefined;

  for(;;) {
    if(common_scripts\utility::_id_562E(var_0._id_9A83) && common_scripts\utility::_id_562E(self._id_9A88) && _id_5784(var_0, self) && var_0 maps\mp\gametypes\zombies::_id_4B9D(self._id_9A84)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + var_0 maps\mp\gametypes\zombies::_id_46E8();
        var_0 _id_874C();
      }

      if(gettime() >= var_1) {
        var_0._id_9A83 = 0;
        self notify("used", var_0, "token");
      }
    } else if(isDefined(var_1)) {
      var_1 = undefined;
      var_0 _id_2413();
    }

    waitframe();
  }
}

_id_2413() {
  self setclientomnvar("ui_use_bar_start_time", 0);
  self setclientomnvar("ui_use_bar_end_time", 0);
  self setclientomnvar("ui_use_bar_text", 0);
}

_id_874C() {
  self setclientomnvar("ui_use_bar_start_time", gettime());
  var_0 = gettime() + maps\mp\gametypes\zombies::_id_46E8();
  self setclientomnvar("ui_use_bar_end_time", var_0);
  self setclientomnvar("ui_use_bar_text", 5);
}

_id_874A(var_0) {
  self._id_9A84 = var_0;
}

_id_9A85(var_0) {
  self._id_9A88 = 0;
  self settertiaryhintstring("");
}

_id_3665() {
  level._id_9A87 = getdvarint("5022", 0);
}

_id_5784(var_0, var_1) {
  var_2 = var_0 playergetuseent(1);
  return isDefined(var_2) && var_2 == var_1;
}

_id_34A6(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 18;

  if(!isDefined(var_2))
    var_2 = var_1;

  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + (0, 0, var_1 * -1);
  var_5 = self aiphysicstrace(var_3, var_4, self.radius, self._id_00BD, 1);

  if(_abs(var_5[2] - var_3[2]) < 0.1)
    return undefined;

  if(_abs(var_5[2] - var_4[2]) < 0.1)
    return undefined;

  return var_5;
}

_id_1F5B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 6;

  if(!isDefined(var_3))
    var_3 = self.radius;

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self aiphysicstracepassed(var_5, var_6, var_3, self._id_00BD - var_2, 1);
}

_id_6719(var_0) {
  return !isDefined(var_0._id_AC66);
}

_id_0F52(var_0, var_1, var_2) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] + (var_1[0] * var_2[1] - var_2[0] * var_1[1]) + (var_2[0] * var_0[1] - var_0[0] * var_2[1]);
}

_id_0F53(var_0, var_1, var_2) {
  return _id_0F52(var_0, var_1, var_2) * 0.5;
}

_id_5F36(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.0;

  var_4 = _id_0F52(var_1, var_2, var_0);

  if(var_4 > var_3)
    return 1;

  if(var_4 < var_3 * -1)
    return 2;

  return 3;
}

_id_776A(var_0, var_1) {
  var_2 = vectordot(var_0, var_1) / _lengthsquared(var_1);
  return [var_1 * var_2, var_2];
}

_id_7770(var_0, var_1, var_2) {
  var_0 = var_0 - var_1;
  [var_0, var_4] = _id_776A(var_0, var_2 - var_1);
  var_0 = var_0 + var_1;
  return [var_0, var_4];
}

_id_7771(var_0, var_1, var_2) {
  [var_0, var_4] = _id_7770(var_0, var_1, var_2);

  if(var_4 < 0.0)
    var_0 = var_1;
  else if(var_4 > 1.0)
    var_0 = var_2;

  return [var_0, var_4];
}

_id_3048(var_0, var_1, var_2) {
  [var_4, var_5] = _id_7770(var_0, var_1, var_2);
  return distance(var_4, var_0);
}

_id_2DA3() {
  self hudoutlinedisable();
  maps\mp\agents\_agent_utility::_id_2A73();
  self notify("killanimscript");
  self notify("death");
  self waittill("disconnect");
  self despawnagent();
}

_id_5844(var_0) {
  return _id_5836(var_0) || _id_583A(var_0);
}

isvalidequipmentzombies(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "jack_in_box_decoy_zm":
      var_1 = 1;
      break;
  }

  if(common_scripts\utility::_id_562E(level.zombietacticalweapon[var_0]) || common_scripts\utility::_id_562E(level.zombielethalweapon[var_0]))
    var_1 = 1;

  return var_1;
}

_id_5836(var_0) {
  var_1 = _id_AAF9(var_0, 1, 0);

  switch (var_1) {
    case "m712_pap_zm":
    case "ppsh41_classic_pap_zm":
    case "ppsh41_classic_zm":
    case "ppsh41_pap_zm":
    case "ppsh41_zm":
    case "greasegun_pap_zm":
    case "greasegun_zm":
    case "model21_pap_zm":
    case "springfield_pap_zm":
    case "springfield_zm":
    case "leeenfield_pap_zm":
    case "leeenfield_zm":
    case "bren_pap_zm":
    case "bren_zm":
    case "bar_pap_zm":
    case "bar_zm":
    case "svt40_pap_zm":
    case "svt40_zm":
    case "m1a1_pap_zm":
    case "winchester1897_pap_zm":
    case "winchester1897_zm":
    case "m1garand_pap_zm":
    case "m1garand_zm":
    case "type100_pap_zm":
    case "type100_zm":
    case "thompson_pap_zm":
    case "thompson_zm":
    case "karabin_pap_zm":
    case "karabin_zm":
    case "kar98_pap_zm":
    case "mp28_pap_zm":
    case "mp28_zm":
    case "mp40_pap_zm":
    case "mp40_zm":
    case "walther_pap_zm":
    case "walther_zm":
    case "m30_pap_zm":
    case "stg44_pap_zm":
    case "stg44_zm":
    case "m1941_pap_zm":
    case "m1941_zm":
    case "luger_auto_zm":
    case "luger_pap_zm":
    case "mg42_pap_zm":
    case "mg42_zm":
    case "mg15_pap_zm":
    case "mg15_zm":
    case "fg42_pap_zm":
    case "fg42_zm":
    case "lewis_pap_zm":
    case "lewis_zm":
    case "m1911_pap_zm":
    case "teslagun_pap_zm":
    case "teslagun_zm_death":
    case "teslagun_zm_moon":
    case "teslagun_zm_storm":
    case "teslagun_zm_blood":
    case "fliegerfaust_pap_zm":
    case "fliegerfaust_zm":
    case "type99_pap_zm":
    case "type99_zm":
    case "sentryhead_zm":
    case "flamethrower_zm":
    case "panzerschreck_zm":
    case "bazooka_zm":
    case "m30_zm":
    case "model21_zm":
    case "kar98_zm":
    case "m1a1_zm":
    case "m712_zm":
    case "luger_zm":
    case "m1911_zm":
    case "teslagun_zm":
      return 1;
    case "breda30_pap_zm":
    case "breda30_zm":
    case "sten_pap_zm":
    case "sten_zm":
    case "g43_pap_zm":
    case "g43_zm":
      return maps\mp\_utility::isproductionlevelactive(6);
    case "p38_pap_zm":
    case "beretta_pap_zm":
    case "beretta_zm":
    case "volk_pap_zm":
    case "volk_zm":
    case "p38_zm":
      return maps\mp\_utility::isproductionlevelactive(7);
    case "razergun_pap_zm":
    case "razergun_zm":
    case "razergun_melee_zm":
      return maps\mp\_utility::isproductionlevelactive(8);
    case "enfieldno2_pap_zm":
    case "reich_pap_zm":
    case "enfieldno2_zm":
    case "reich_zm":
      return maps\mp\_utility::isproductionlevelactive(9);
    case "mg81_pap_zm":
    case "mg81_zm":
    case "mas38_pap_zm":
    case "mas38_zm":
      return maps\mp\_utility::isproductionlevelactive(10);
    case "arisaka_pap_zm":
    case "arisaka_zm":
    case "m2carbine_pap_zm":
    case "m2carbine_zm":
    case "m1935_pap_zm":
    case "m1935_zm":
    case "sterling_pap_zm":
    case "sterling_zm":
    case "type5_pap_zm":
    case "type5_zm":
      return getdvarint("mtx4_killswitch", 1) == 0;
    case "ptrs41_pap_zm":
    case "ptrs41_zm":
    case "blunderbuss_pap_zm":
    case "blunderbuss_zm":
    case "nambu_pap_zm":
    case "nambu_zm":
    case "m1919_pap_zm":
    case "m1919_zm":
    case "leveraction_pap_zm":
    case "leveraction_zm":
      return getdvarint("mtx5_killswitch", 1) == 0;
    case "zk383_pap_zm":
    case "zk383_zm":
      return getdvarint("dlc3_killswitch", 1) == 0;
    case "avs36_pap_zm":
    case "avs36_zm":
    case "delisle_pap_zm":
    case "delisle_zm":
      return getdvarint("mtx6_killswitch", 1) == 0;
    case "ribeyrolles_pap_zm":
    case "ribeyrolles_zm":
    case "mosin_pap_zm":
    case "mosin_zm":
    case "federov_pap_zm":
    case "federov_zm":
      return getdvarint("mtx7_killswitch", 1) == 0;
    case "sudaev_pap_zm":
    case "sudaev_zm":
    case "vmg1927_pap_zm":
    case "vmg1927_zm":
    case "tokyo_pap_zm":
    case "tokyo_zm":
      return getdvarint("mtx8_killswitch", 1) == 0;
    case "raven_gun_pap_zm":
    case "raven_gun_zm":
    case "mg42_vintage_pap_zm":
    case "mg42_vintage_zm":
      return getdvarint("dlc4_killswitch", 1) == 0;
    case "dp28_pap_zm":
    case "dp28_zm":
    case "emp44_pap_zm":
    case "emp44_zm":
    case "charlton_pap_zm":
    case "charlton_zm":
    case "sdk_pap_zm":
    case "sdk_zm":
      return getdvarint("mtx9_killswitch", 1) == 0;
    case "lad_pap_zm":
    case "lad_zm":
    case "kgm21_pap_zm":
    case "kgm21_zm":
    case "erma_pap_zm":
    case "erma_zm":
    case "blyskawica_pap_zm":
    case "blyskawica_zm":
    case "wz35_pap_zm":
    case "wz35_zm":
      return getdvarint("mtx10_killswitch", 1) == 0;
    case "chatelleroult_pap_zm":
    case "chatelleroult_zm":
    case "m2hyde_pap_zm":
    case "m2hyde_zm":
    case "austen_pap_zm":
    case "austen_zm":
    case "wimmer_pap_zm":
    case "wimmer_zm":
    case "mas36_pap_zm":
    case "mas36_zm":
      return getdvarint("mtx11_killswitch", 1) == 0;
    case "bechowiec_pap_zm":
    case "bechowiec_zm":
    case "grofuss_pap_zm":
    case "grofuss_zm":
      return getdvarint("mtx12_killswitch", 1) == 0;
  }

  if(isDefined(level.zombieprimaryweapon[var_0]))
    return 1;

  return 0;
}

_id_583A(var_0) {
  switch (var_0) {
    case "combatknife_zm":
    case "shovel_zm":
    case "raven_sword_zm":
      return 1;
    case "razergun_zm":
    case "razergun_melee_zm":
      return maps\mp\_utility::isproductionlevelactive(8);
    case "zom_dlc2_1_zm":
    case "zom_dlc2_2_zm":
    case "zom_dlc2_3_zm":
    case "zom_dlc2_4_zm":
      return maps\mp\_utility::isproductionlevelactive(12);
    case "zom_dlc4_scythe_emp_zm":
    case "zom_dlc4_scythe_zm":
    case "zom_dlc4_shield_emp_zm":
    case "zom_dlc4_shield_zm":
    case "zom_dlc4_spike_emp_zm":
    case "zom_dlc4_spike_zm":
    case "zom_dlc4_hammer_emp_zm":
    case "zom_dlc4_hammer_zm":
      return getdvarint("dlc4_killswitch", 1) == 0;
    default:
      break;
  }

  if(common_scripts\utility::_id_562E(level.zombiemeleeweapon[var_0]))
    return 1;

  return 0;
}

_id_5823(var_0) {
  switch (var_0) {
    case "role_ability_mad_minute_zm":
    case "role_ability_taunt_zm":
    case "role_ability_camo_zm":
    case "role_ability_stunning_burst_zm":
      return 1;
    case "role_ability_melee_frenzy_zm":
      var_1 = 0;
      return var_1;
    default:
      return 0;
  }
}

_id_6F28(var_0) {
  if(!isDefined(level._id_ABE3))
    level._id_ABE3 = 0;

  if(var_0)
    level._id_ABE3++;
  else
    level._id_ABE3--;
}

_id_53DC() {
  return common_scripts\utility::_id_562E(self._id_55AB) || common_scripts\utility::_id_562E(self.zmdemigod);
}

_id_6720() {
  return common_scripts\utility::_id_562E(self._id_66EC);
}

_id_56CF() {
  return common_scripts\utility::_id_562E(self._id_5569);
}

_id_580A() {
  return common_scripts\utility::_id_562E(self._id_562B);
}

_id_44B7() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(!_isalliedsentient(self, var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_4422(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isalive(var_3)) {
      var_4 = var_3 getnearestnode();

      if(isDefined(var_4))
        var_1[var_1.size] = var_4;
    }
  }

  var_6 = [];

  foreach(var_8 in var_0) {
    if(var_8._id_0A4B == "zombie_melee_goliath" || issubstr(var_8._id_0A4B, "ranged_elite_soldier")) {
      continue;
    }
    var_9 = 1;
    var_10 = var_8 getnearestnode();

    if(isDefined(var_10)) {
      foreach(var_4 in var_1) {
        if(_nodesvisible(var_10, var_4, 1)) {
          var_9 = 0;
          break;
        }
      }
    }

    if(var_9)
      var_6[var_6.size] = var_8;
  }

  return var_6;
}

_id_A718(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();

  if(isDefined(var_0))
    childthread _id_A760(var_0, var_8);

  if(isDefined(var_1))
    childthread _id_A760(var_1, var_8);

  if(isDefined(var_2))
    childthread _id_A760(var_2, var_8);

  if(isDefined(var_3))
    childthread _id_A760(var_3, var_8);

  if(isDefined(var_4))
    childthread _id_A760(var_4, var_8);

  if(isDefined(var_5))
    childthread _id_A760(var_5, var_8);

  if(isDefined(var_6))
    childthread _id_A760(var_6, var_8);

  if(isDefined(var_7))
    childthread _id_A760(var_7, var_8);

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_A760(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];
  var_12[0] = var_0;

  if(isDefined(var_2))
    var_12[1] = var_2;

  if(isDefined(var_3))
    var_12[2] = var_3;

  if(isDefined(var_4))
    var_12[3] = var_4;

  if(isDefined(var_5))
    var_12[4] = var_5;

  if(isDefined(var_6))
    var_12[5] = var_6;

  if(isDefined(var_7))
    var_12[6] = var_7;

  if(isDefined(var_8))
    var_12[7] = var_8;

  if(isDefined(var_9))
    var_12[8] = var_9;

  if(isDefined(var_10))
    var_12[9] = var_10;

  if(isDefined(var_11))
    var_12[10] = var_11;

  var_1 notify("returned", var_12);
}

_id_089A(var_0) {
  level endon("exploderID_" + var_0);

  if(isDefined(level.players)) {
    foreach(var_2 in level.players)
    common_scripts\_exploder::_id_088E(var_0, var_2);
  }

  for(;;) {
    level waittill("connected", var_2);
    common_scripts\_exploder::_id_088E(var_0, var_2);
  }
}

_id_93DF(var_0) {
  level notify("exploderID_" + var_0);
  _stopclientexploder(var_0);
}

_id_4B24() {
  return isDefined(self._id_A08E) && self._id_A08E._id_15CB._id_17E9;
}

_id_562C(var_0) {
  return isDefined(var_0._id_15CB) && var_0._id_15CB._id_17E9;
}

get_zombies_touching_sphere(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(!isDefined(var_4))
    var_4 = _id_408F();

  foreach(var_8 in var_4) {
    var_9 = var_8.origin;
    var_10 = var_8._id_8302 * 0.5;
    var_9 = var_9 + (0, 0, var_10);
    var_11 = var_0 - var_9;

    if(_abs(var_11[2]) > var_10 + var_1) {
      continue;
    }
    if(_length2d(var_11) > var_8._id_8303 + var_1) {
      continue;
    }
    if(var_8 damageconetrace(var_0, var_3) == 0) {
      continue;
    }
    var_5[var_5.size] = var_8;
  }

  return var_5;
}

_id_43F0(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = _id_408F();
  var_6 = var_2 * var_2;
  var_7 = var_1 * 0.5;
  var_8 = var_0 + (0, 0, var_7);

  foreach(var_10 in var_5) {
    var_11 = var_10.origin;
    var_12 = 0;

    if(var_3) {
      var_12 = var_10._id_8302 * 0.5;
      var_11 = var_11 + (0, 0, var_12);
    }

    if(_abs(var_8[2] - var_11[2]) > var_12 + var_7) {
      continue;
    }
    var_13 = var_6;

    if(var_3)
      var_13 = _pow(var_2 + var_10._id_8303, 2);

    if(_distance2dsquared(var_10.origin, var_0) > var_13) {
      continue;
    }
    var_4[var_4.size] = var_10;
  }

  return var_4;
}

_id_55C2(var_0) {
  if(!isDefined(var_0.type))
    return 0;

  var_1 = var_0.type == "Begin" || var_0.type == "Begin 3D";
  return var_1;
}

_id_AC0E(var_0, var_1, var_2, var_3) {
  while(!isDefined(level._id_087B))
    waitframe();

  var_4 = common_scripts\utility::_id_46B7(var_0, var_1);
  var_5 = var_1 + ": " + var_0;

  foreach(var_7 in var_4)
  _id_AC0F(var_7, var_5, var_3);
}

_id_AC0D(var_0, var_1, var_2) {
  while(!isDefined(level._id_087B))
    waitframe();

  foreach(var_4 in var_0)
  _id_AC0F(var_4, var_1, var_2);
}

#using_animtree("zombie_generic");

_id_AC0F(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0._id_8C95) || isDefined(var_0._id_0165) && var_0._id_0165 == "zombie_sky_spawner")
    var_4 = _id_0540::_id_A26F(var_0, undefined, var_1);
  else if(isDefined(var_0.setflaggedanimknoball)) {
    var_8 = var_0.setflaggedanimknoball;
    var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_4081(var_8, "zombie_generic", #animtree);
    var_4 = var_9.size > 0;
    var_10 = "";

    foreach(var_12 in var_9) {
      var_13 = maps\mp\agents\_scripted_agent_anim_util::_id_446A(var_12);
      var_14 = _getmovedelta(var_12, 0, var_13);
      var_15 = _transformmove(var_0.origin, var_0.angles, (0, 0, 0), (0, 0, 0), var_14, (0, 0, 0))["origin"];

      if(!isDefined(var_15))
        var_15 = var_0.origin;

      var_16 = [];

      if(isDefined(var_2)) {
        foreach(var_18 in var_2) {
          if(!_animhasnotetrack(var_12, var_18))
            var_16 = common_scripts\utility::_id_0F6F(var_16, var_18);
        }
      }

      if(var_16.size > 0)
        var_4 = 0;

      var_23 = var_0 _id_054D::_id_ABFD(var_15, _debuggetanimname(var_12), var_3, "animated");

      if(!var_23) {}

      var_4 = var_4 &var_23;
    }
  } else {
    var_25 = "Bad Spawner";

    if(isDefined(var_1))
      var_25 = var_25 + (": " + var_1);

    var_4 = var_0 _id_054D::_id_ABFD(var_0.origin, var_25, var_3, "closet");
  }

  var_0.validitytestresult = var_4;
  return var_4;
}

_id_4282(var_0) {
  var_1 = [];

  if(isDefined(var_0.setlookatent)) {
    var_2 = strtok(var_0.setlookatent, ",");

    foreach(var_4 in var_2) {
      var_5 = strtok(var_4, " ");

      if(var_5.size > 0) {
        var_6 = var_5[0];

        if(var_5.size == 1)
          var_1[var_6] = 1;
        else if(var_5.size == 2)
          var_1[var_6] = var_5[1];
        else {
          var_7 = common_scripts\utility::_id_0F9A(var_5, 0);
          var_1[var_6] = var_7;
        }
      }
    }
  }

  return var_1;
}

_id_5637(var_0) {
  if(isDefined(var_0._id_003B) && var_0._id_003B == "script_model") {
    if(_id_6724(var_0.targetname) || _id_6724(var_0._id_0165) || _id_6724(var_0._id_0164))
      return 0;

    if(!isDefined(var_0.model) || !common_scripts\utility::_id_9467(var_0.model, "destp_"))
      return 0;

    return 1;
  }

  return 0;
}

_id_5638(var_0) {
  if(isDefined(var_0._id_003B) && var_0._id_003B == "script_model" && var_0.classname == "script_model") {
    if(_id_6724(var_0.targetname) || _id_6724(var_0._id_0165) || _id_6724(var_0._id_0164))
      return 0;

    return 1;
  }

  return 0;
}

_id_6724(var_0) {
  return isDefined(var_0) && _isstring(var_0) && var_0 != "";
}

_id_8FBA(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(isDefined(var_2))
    return _spawnfxforclient(common_scripts\utility::_id_44F5(var_1), var_0.origin, var_2, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  else
    return _spawnfx(common_scripts\utility::_id_44F5(var_1), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
}

playfxclient_for_player(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_4 = _id_8FBA(var_3, var_0, var_2);
  _triggerfx(var_4);
  var_2 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_4);
}

playfxclient(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_5 = _id_8FBA(var_4, var_0, var_2);
  _triggerfx(var_5);
  var_2 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_5);

  if(isDefined(var_3))
    level thread delete_fx_in_time(var_5, var_3);
}

delete_fx_in_time(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0))
    var_0 delete();
}

_id_1DB3(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 _meth_8682(0, var_1, 1, "none", 1);

  if(isDefined(var_1))
    var_0 _id_AB18(var_1);
}

_id_AC38(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_0 endon("death");

  if(!isDefined(var_1) || var_1 <= 0) {
    return;
  }
  if(!isDefined(var_3) || var_3 < 0)
    var_3 = 1;

  wait 0.25;
  var_6 = 0;

  for(;;) {
    var_0 dodamage(var_1, var_0.origin, var_2, undefined, undefined, var_5);
    wait(var_3);

    if(isDefined(var_4) && var_4 > 0) {
      var_6 = var_6 + var_3;

      if(var_6 > var_4) {
        break;
      }
    }
  }
}

_id_2436(var_0, var_1, var_2, var_3) {
  return _distance2d(var_0, var_1) <= var_2 && _abs(var_0[2] - var_1[2]) <= var_3;
}

_id_3151() {
  return isDefined(self._id_A022) && self._id_A022.size;
}

_id_7458(var_0, var_1) {
  if(!isDefined(self._id_A022))
    self._id_A022 = [];

  if(common_scripts\utility::_id_562E(self._id_A022[var_1]) == common_scripts\utility::_id_562E(var_0)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_0))
    self._id_A022[var_1] = 1;
  else
    self._id_A022[var_1] = undefined;

  if(self._id_A022.size > 0)
    self setclientomnvar("zm_unlimited_ammo", 1);
  else
    self setclientomnvar("zm_unlimited_ammo", 0);
}

_id_73EC() {
  self endon("death");
  self endon("disconnect");
  var_0 = self getweaponlistprimaries();

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "em1")) {
      waittillframeend;
      var_3 = _id_73EA();

      if(var_3 == 0) {
        _id_743F(1);
        self allowfire(1);
      }

      continue;
    }

    var_3 = self getweaponammoclip(var_2, "right");

    if(var_3 == 0)
      self setweaponammoclip(var_2, 1, "right");

    if(issubstr(var_2, "akimbo")) {
      var_3 = self getweaponammoclip(var_2, "left");

      if(var_3 == 0)
        self setweaponammoclip(var_2, 1, "left");
    }
  }
}

_id_5816(var_0) {
  return !isDefined(var_0) || var_0 == "";
}

_id_580D() {
  return !common_scripts\utility::_id_562E(self._id_9D9F);
}

_id_A28D(var_0, var_1) {
  if(isDefined(var_0))
    self._id_9D65._id_2984 = var_0;

  if(isDefined(var_1))
    self._id_9D65._id_2985 = var_1;
}

_id_A286() {
  return "valve_note";
}

_id_A28C(var_0, var_1, var_2) {
  self._id_A29A = var_0;
  self._id_A29F = var_1;
  self._id_A29C = var_2;

  if(!isDefined(var_0)) {
    self scriptmodelclearanim();
    return;
  }

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = "";

  if(isDefined(self._id_6766) && common_scripts\utility::_id_0F79(self._id_6766, var_0))
    var_3 = _id_A286();

  self scriptmodelclearanim();
  self scriptmodelplayanim(var_0, var_3, var_1, var_2);
}

_id_A298(var_0) {
  for(;;) {
    self waittill(_id_A286(), var_1);
    self thread[[var_0]](var_1);
  }
}

clear_progressive_interact(var_0) {
  common_scripts\utility::_id_A70A("valve_complete", "valve_turning_off");
  var_0.radial_interact_active = undefined;
  var_0 _meth_866C(&"stop_progressive_interact", 0);
  var_0 _meth_866C(&"remove_progressive_interact", 0);
}

valve_check_progressive_interact_input(var_0, var_1) {
  self endon("valve_complete");
  self endon("valve_turning_off");
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    var_4 = var_0 usebuttonpressed();

    if(!var_3) {
      if(var_4) {
        var_5 = (1 - self._id_A2A5) * self._id_A2A4;
        var_0 _meth_866C(&"start_progressive_interact", 1, var_5 * 1000);
        var_3 = 1;
        var_2 = 1;
      }
    } else if(!var_4) {
      var_0 _meth_866C(&"stop_progressive_interact", 0);
      var_3 = 0;
    }

    waitframe();
  }
}

_id_A299() {
  if(!self._id_9D65 _meth_8562())
    self._id_9D65 makeusable();
  else {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        if(!self._id_9D65 _meth_8691(var_1))
          self._id_9D65 enableplayeruse(var_1);
      }
    }

    if(isDefined(self._id_9D65._id_2984))
      self._id_9D65 sethintstring(self._id_9D65._id_2984);
    else
      self._id_9D65 sethintstring(&"ZOMBIES_TURN_VALVE");
  }

  self._id_9D65 usetriggerrequirelookat(1);

  while(!isDefined(self.player)) {
    self._id_9D65 waittill("trigger", var_3);

    if(isPlayer(var_3))
      self.player = var_3;
  }

  self._id_9D65 usetriggerrequirelookat(0);

  if(isDefined(self._id_9D65._id_2985))
    self._id_9D65 sethintstring(self._id_9D65._id_2985);
  else if(isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(isDefined(self.player) && var_1 == self.player) {
        if(!isDefined(self.player.radial_interact_active)) {
          childthread valve_check_progressive_interact_input(self.player, self._id_9D65);
          childthread clear_progressive_interact(self.player);
          self.player.radial_interact_active = 1;
        }

        continue;
      }

      self._id_9D65 disableplayeruse(var_1);
    }
  }
}

_id_A284(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self thread[[var_0]]();
}

_id_A288(var_0) {
  self._id_A2A5 = 0;
  _id_A28C(self._id_5058);
  _id_A284(self._id_5050);

  if(isDefined(self._id_6DFC))
    self._id_6DFC _id_A28C(self._id_6DFC._id_5058);

  thread _id_A299();
}

_id_A28A(var_0, var_1) {
  return isDefined(self.player);
}

_id_A289(var_0) {
  if(!self._id_4B75)
    _id_0378::_id_8D74("gas_valve_state", "start_opening", self._id_4B6B);
}

_id_A294() {
  self endon("sm_state_change");
  self.player common_scripts\utility::_id_A70A("disconnect", "begin_last_stand");
  self.player = undefined;
}

_id_A293(var_0) {
  if(isDefined(self._id_5986))
    self._id_5986 notify("valve_start", self.player);

  self._id_A29B = self._id_A2A5 * self._id_A2A4;
  self._id_A29D = (1 - self._id_A2A5) * self._id_A2A4;

  if(!self._id_4B75)
    _id_0378::_id_8D74("gas_valve_state", "opening", self._id_4B6B);

  _id_A28C(self._id_9ED0, self._id_A29B);
  _id_A284(self._id_9EC3);

  if(isDefined(self.valve_type) && isDefined(self.valve_type == "custom")) {
    var_1 = self._id_A2A5 * self._id_9ED7;
    var_2 = self._id_9ED7 / self._id_A2A4;
    _id_A28C(self._id_9ED0, var_1, var_2);
  }

  if(isDefined(self._id_6DFC)) {
    var_1 = self._id_A2A5 * self._id_6DFC._id_9ED7;
    var_2 = self._id_6DFC._id_9ED7 / self._id_A2A4;
    self._id_6DFC _id_A28C(self._id_6DFC._id_9ED0, var_1, var_2);
  }

  thread _id_A294();
}

_id_A297(var_0, var_1) {
  var_2 = (gettime() - var_1) / 1000.0;
  self._id_A2A5 = (self._id_A29B + var_2) / self._id_A2A4;

  if(self._id_A2A5 > 1)
    self._id_A2A5 = 1;
}

_id_A296(var_0, var_1) {
  if(common_scripts\utility::_id_562E(self._id_137B))
    return 0;

  if(isDefined(self.player) && isalive(self.player) && self.player usebuttonpressed() && self.player istouching(self._id_9D65))
    return 0;

  self.player = undefined;

  if(isDefined(self._id_5986))
    self._id_5986 _id_055B::_id_5989();

  return 1;
}

_id_A295(var_0, var_1) {
  return self._id_A2A5 >= 1;
}

_id_A28F(var_0) {
  self endon("sm_state_change");
  self._id_A29D = self._id_A2A5 * self._id_A2A3;
  self._id_A29B = self._id_A2A3 - self._id_A29D;
  _id_A28C(self._id_9ECA, self._id_A29B);
  _id_A284(self._id_9EC2);
  self notify("valve_turning_off");

  if(isDefined(self._id_6DFC)) {
    var_1 = (1 - self._id_A2A5) * self._id_6DFC._id_9ECE;
    var_2 = self._id_6DFC._id_9ECE / self._id_A2A3;
    self._id_6DFC _id_A28C(self._id_6DFC._id_9ECA, var_1, var_2);
  }

  if(!self._id_4B75)
    _id_0378::_id_8D74("gas_valve_state", "closing", self._id_4B6B);

  thread _id_A299();
}

_id_A292(var_0, var_1) {
  var_2 = (gettime() - var_1) / 1000.0;
  self._id_A2A5 = 1.0 - (self._id_A29B + var_2) / self._id_A2A3;

  if(self._id_A2A5 < 0)
    self._id_A2A5 = 0;
}

_id_A290(var_0, var_1) {
  if(self._id_A2A5 > 0)
    return 0;

  if(!self._id_4B75)
    _id_0378::_id_8D74("gas_valve_state", "closed", self._id_4B6B);

  return 1;
}

_id_A291(var_0, var_1) {
  return isDefined(self.player);
}

_id_A28B(var_0) {
  _id_A28C(self._id_5059);
  _id_A284(self._id_5052);

  if(!self._id_4B75)
    _id_0378::_id_8D74("gas_valve_state", "open", self._id_4B6B);

  if(isDefined(self.getnegotiationnextnode))
    common_scripts\utility::flag_set(self.getnegotiationnextnode);

  self._id_9D65 makeunusable();
  self notify("valve_complete");

  if(isDefined(self._id_5986))
    self._id_5986 notify("valve_complete");

  self._id_2566 = 1;
  var_1 = _id_AC4B(self.origin, "valve");
  var_1 _id_AC48("script_flag", self.getnegotiationnextnode);
  var_1 _id_AC47(self.player);
  var_1 _id_AC4D();
}

#using_animtree("animated_props_zombies");

_id_A287(var_0) {
  switch (var_0) {
    case "s2_zmb_valve_turn_on":
      return % s2_zmb_valve_turn_on;
    case "s2_zmb_valve_turn_off":
      return % s2_zmb_valve_turn_off;
    case "zmb_com_crank_idle":
      return % zmb_com_crank_idle;
    case "zmb_com_crank_turn":
      return % zmb_com_crank_turn;
    case "zmb_com_crank_reverse":
      return % zmb_com_crank_reverse;
    case "s2_zom_shroud_cover_lift_stuck_idle":
      return % s2_zom_shroud_cover_lift_stuck_idle;
    case "s2_zom_shroud_cover_lift_open":
      return % s2_zom_shroud_cover_lift_open;
    case "s2_zom_shroud_cover_lift_close":
      return % s2_zom_shroud_cover_lift_close;
  }
}

_id_A285(var_0) {
  var_1 = _id_A287(var_0);
  return _getanimlength(var_1);
}

_id_A283(var_0, var_1) {
  self._id_6766 = var_0;
  thread _id_A298(var_1);
}

_id_A2A1() {
  level._id_A2A0 = getEntArray("valve", "script_noteworthy");
  var_0 = getEntArray("valveTrigger", "script_noteworthy");

  foreach(var_2 in level._id_A2A0) {
    if(isDefined(var_2.getnegotiationnextnode))
      common_scripts\utility::flag_init(var_2.getnegotiationnextnode);

    var_3 = common_scripts\utility::_id_4461(var_2.origin, var_0, 200);
    var_0 = common_scripts\utility::_id_0F93(var_0, var_3);
    var_2._id_9D65 = var_3;
    var_4 = var_2 _id_4315();
    var_2._id_A2A4 = 4;
    var_2._id_9ED0 = var_4["turnOnAnim"];

    if(isDefined(var_2._id_9ED0))
      var_2._id_A2A4 = _id_A285(var_2._id_9ED0);

    var_2._id_A2A3 = 2;
    var_2._id_9ECA = var_4["turnOffAnim"];

    if(isDefined(var_2._id_9ECA))
      var_2._id_A2A3 = _id_A285(var_2._id_9ECA);

    var_2._id_5059 = var_4["idleOnAnim"];
    var_2._id_5058 = var_4["idleOffAnim"];
    var_2._id_4B6B = isDefined(var_4["hasGasSounds"]) && _tolower(var_4["hasGasSounds"]) == "true";
    var_2._id_4B75 = isDefined(var_4["hasLiftSounds"]) && _tolower(var_4["hasLiftSounds"]) == "true";
    var_2._id_A2A5 = 0;
  }

  var_6 = "idle off";
  var_7 = "idle on";
  var_8 = "turning off";
  var_9 = "turning on";
  var_10 = _id_02FE::_id_8CBE("valve");
  var_10 _id_02FE::_id_8CBB(var_6);
  var_10 _id_02FE::_id_8CB9(var_6, ::_id_A288);
  var_10 _id_02FE::_id_8CBA(var_6, ::_id_A289);
  var_10 _id_02FE::_id_8CBC(var_6, var_9, ::_id_A28A);
  var_10 _id_02FE::_id_8CBB(var_7);
  var_10 _id_02FE::_id_8CB9(var_7, ::_id_A28B);
  var_10 _id_02FE::_id_8CBB(var_8);
  var_10 _id_02FE::_id_8CB9(var_8, ::_id_A28F);
  var_10 _id_02FE::_id_8CBD(var_8, ::_id_A292);
  var_10 _id_02FE::_id_8CBC(var_8, var_6, ::_id_A290);
  var_10 _id_02FE::_id_8CBC(var_8, var_9, ::_id_A291);
  var_10 _id_02FE::_id_8CBB(var_9);
  var_10 _id_02FE::_id_8CB9(var_9, ::_id_A293);
  var_10 _id_02FE::_id_8CBD(var_9, ::_id_A297);
  var_10 _id_02FE::_id_8CBC(var_9, var_7, ::_id_A295);
  var_10 _id_02FE::_id_8CBC(var_9, var_8, ::_id_A296);
}

_id_A2A2() {
  foreach(var_1 in level._id_A2A0)
  var_1 thread _id_02FE::_id_8CBF("valve", 1);
}

_id_ABE5() {
  if(!_id_AC4C()) {
    return;
  }
  level waittill("game_ended");
  var_0 = _id_AC4B(undefined, "player_xp_summary");
  var_1 = [];
  var_2 = [];

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = 0;
    var_5 = 0;
    var_6 = level.players[var_3];
    var_7 = "player_" + (var_3 + 1);

    if(isDefined(var_6)) {
      var_4 = var_6._id_AB46["xp"] - var_6._id_AB46["totalXP"];
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
      var_5 = var_6._id_00E3;
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);
    }

    var_0 _id_AC44(var_7 + "_xp_gain", var_4);
    var_0 _id_AC44(var_7 + "_kill_count", var_5);
  }

  var_8 = gettime() / 3600000;
  var_9 = common_scripts\utility::_id_6880(var_1) / var_8;
  var_10 = common_scripts\utility::_id_6880(var_2) / var_8;
  var_0 _id_AC43("hrs", var_8);
  var_0 _id_AC43("xp_per_player_per_hr", var_9);
  var_0 _id_AC44("kills_per_player_per_hr", var_10);
  var_0 _id_AC4D();
}

_id_4315() {
  var_0 = [];

  if(isDefined(self.setlookatent)) {
    var_1 = strtok(self.setlookatent, ",");

    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, "=");
      var_0[var_4[0]] = var_4[1];
    }
  }

  return var_0;
}

_id_408F() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_000A) && var_3._id_000A == level._id_746E) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_4090(var_0) {
  var_1 = _id_408F();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!_id_5565(var_4._id_0A4B, var_0)) {
      continue;
    }
    var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  return var_2;
}

_id_9A6C(var_0) {
  return var_0 * 57.2958;
}

_id_9A9E(var_0) {
  return var_0 * 0.0174533;
}

_id_7BD0(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.startfiring))
    level.startfiring = [];

  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5._id_7F63 = var_1;
  var_5._id_5426 = var_2;
  var_5._id_6AA1 = var_4;
  var_5.priority = var_3;
  level.startfiring[var_0] = var_5;
}

_id_38DD(var_0) {
  var_1 = var_0._id_931E;
  var_0 endon("scripted_state_interrupt");
  common_scripts\utility::maketurretinoperable(var_1._id_7F63, var_0._id_6E59);

  if(isDefined(var_1._id_6AA1))
    common_scripts\utility::maketurretinoperable(var_1._id_6AA1, var_0._id_6E59);
}

_id_7D1A(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = level.startfiring[var_0];
  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5._id_9A01 = var_2;
  var_5.priority = var_4.priority;
  var_5._id_6E59 = var_1;
  var_5._id_931E = var_4;
  var_5._id_1F36 = var_3;
  _id_06A2(var_5);
  var_5 endon("scripted_state_cancel");
  wait 0;

  while(self._id_788D[0] != var_5 || !_id_05DC())
    var_5 waittill("scripted_state_try");

  var_5 notify("scripted_state_begin");
  self._id_08E1 = var_5;
  _id_38DD(var_5);
  self._id_08E1 = undefined;
  _id_05FC(var_5);
  _id_06B1();
}

sorted_array_compare_func(var_0, var_1) {
  return var_0 <= var_1;
}

insert_into_sorted_array(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = ::sorted_array_compare_func;

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if([[var_2]](var_1, var_0[var_3])) {
      break;
    }
  }

  return common_scripts\utility::_id_0F86(var_0, var_1, var_3);
}

_id_06A2(var_0) {
  self._id_788D = insert_into_sorted_array(self._id_788D, var_0, ::_id_05EA);
  thread _id_067D(var_0);
  _id_06B1();
}

_id_05EA(var_0, var_1) {
  return var_0.priority >= var_1.priority;
}

_id_05FC(var_0) {
  self._id_788D = common_scripts\utility::_id_0F93(self._id_788D, var_0);
}

_id_0660(var_0) {
  self._id_08E1 = undefined;

  if(isDefined(var_0._id_931E._id_5426))
    common_scripts\utility::maketurretinoperable(var_0._id_931E._id_5426, var_0._id_6E59);

  if(isDefined(var_0._id_931E._id_6AA1))
    common_scripts\utility::maketurretinoperable(var_0._id_931E._id_6AA1, var_0._id_6E59);

  var_0 notify("scripted_state_interrupt");
}

_id_067D(var_0) {
  var_0 endon("scripted_state_begin");
  var_0 endon("scripted_state_cancel");
  self endon("death");
  var_1 = [];

  if(isDefined(var_0._id_9A01))
    var_1[0] = var_0._id_9A01;

  if(isDefined(var_0._id_1F36))
    var_1 = common_scripts\utility::_id_0F73(var_1, var_0._id_1F36);

  if(isDefined(var_0._id_9A01)) {
    if(var_1.size > 1)
      common_scripts\utility::maketurretinoperable(common_scripts\utility::_id_A70D, var_1);
    else
      wait(var_0._id_9A01);
  } else if(var_1.size > 0)
    common_scripts\utility::maketurretinoperable(common_scripts\utility::_id_A70C, var_1);
  else
    return;

  thread _id_05DD(var_0);
}

_id_05DD(var_0) {
  _id_05FC(var_0);
  var_0 notify("scripted_state_cancel");
}

_id_06B1() {
  var_0 = self._id_788D[0];

  if(isDefined(self._id_08E1)) {
    if(self._id_08E1 != var_0)
      _id_0660(self._id_08E1);
  }

  if(isDefined(var_0) && !isDefined(self._id_08E1))
    var_0 notify("scripted_state_try");
}

_id_05DC() {
  if(self._id_0BA4 == "traverse")
    return 0;

  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2() && !isDefined(self._id_08E1) && !common_scripts\utility::_id_562E(self.ispermanentlyscripted))
    return 0;

  return 1;
}

_id_4A58() {
  self endon("death");
  self._id_788D = [];
  self._id_08E1 = undefined;

  for(;;) {
    common_scripts\utility::_id_A70A("traverse_end", "killanimscript");
    _id_06B1();
  }
}

has_scripted_state_queued(var_0) {
  if(!isDefined(self._id_788D))
    return 0;

  var_0 = _tolower(var_0);

  foreach(var_2 in self._id_788D) {
    if(_tolower(var_2.name) == var_0)
      return 1;
  }

  return 0;
}

is_in_scripted_state(var_0) {
  if(!isDefined(self._id_08E1))
    return 0;

  return self._id_08E1.name == var_0;
}

_id_7419(var_0, var_1) {
  var_2 = self.origin - var_0;
  var_3 = var_1 * vectorNormalize(var_2);
  var_3 = (var_3[0], var_3[1], 250);

  if(var_1 > 0)
    self setvelocity(var_3);
}

playerarmornotifychanges() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_98E7(isDefined(self._id_0F6B), self._id_0F6B, 0);
  var_2 = common_scripts\utility::_id_98E7(isDefined(self.armorvestpiececountold), self.armorvestpiececountold, 0);
  var_3 = var_1 - var_2;

  if(var_3 > 0)
    var_0 notify("give_armor", var_3);
  else if(var_3 < 0) {
    if(var_1 == 0)
      self notify("take_armor");
  }

  _id_747E();
}

_id_7454(var_0) {
  var_0 = int(_min(var_0, playergetmaxarmorcount()));

  if(_id_5565(self._id_0F6B, var_0)) {
    return;
  }
  self.armorvestpiececountold = self._id_0F6B;
  self._id_0F6B = var_0;
  playerarmornotifychanges();
}

_id_73AC(var_0) {
  var_0 = int(_min(var_0, playergetmaxarmorcount() - self._id_0F6B));
  self.armorvestpiececountold = self._id_0F6B;
  self._id_0F6B = self._id_0F6B + var_0;
  playerarmornotifychanges();
}

_id_7442(var_0) {
  self.armorvestpiececountold = self._id_0F6B;
  self._id_0F6B = int(max(0, self._id_0F6B - var_0));
  playerarmornotifychanges();
}

_id_73E9() {
  return common_scripts\utility::_id_98E7(isDefined(self._id_0F6B), self._id_0F6B, 0);
}

playergetmaxarmorcount() {
  if(!isDefined(self.armorvestmaxcount))
    return 3;

  return self.armorvestmaxcount;
}

playersetmaxarmorcount(var_0) {
  var_0 = int(max(0, _min(var_0, 3)));
  self.armorvestmaxcount = var_0;

  if(self._id_0F6B > self.armorvestmaxcount)
    _id_7454(self.armorvestmaxcount);
  else
    playerarmornotifychanges();
}

_id_747E() {
  var_0 = 0;

  if(isDefined(self.armorvestmaxcount))
    var_0 = 3 - self.armorvestmaxcount;

  self setclientomnvar("ui_zm_exo_health", self._id_0F6B + var_0 * 10);
  self notify("update_armor_hints");
}

clearrangedperk(var_0) {
  if(isDefined(level.players)) {
    foreach(var_2 in level.players)
    var_2 _meth_866C(&"clear_teammate_mod_buffs", 1, var_0);
  }
}

rangedperknotifyteammateui(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(level.players)) {
    return;
  }
  var_2 = 1;

  while(var_2) {
    var_2 = 0;

    if(var_0 == "specialty_class_squad_tactics_zm")
      var_2 = self._id_5F5C;

    foreach(var_4 in level.players) {
      if(!isDefined(var_4.rangeperkon))
        var_4.rangeperkon = [];

      if(var_4 == self || !isalive(var_4)) {
        continue;
      }
      if(distancesquared(self.origin, var_4.origin) < var_1) {
        var_5 = 1;

        if(isDefined(var_4.rangeperkon)) {
          for(var_6 = 0; var_6 < var_4.rangeperkon.size; var_6++) {
            if(var_4.rangeperkon[var_6].perkref == var_0 && var_4.rangeperkon[var_6].sendingplayer == self)
              var_5 = 0;
          }
        }

        if(var_5 == 1) {
          var_4 _meth_866C(&"add_teammate_mod_buffs", 3, var_0, 0, self);
          var_7 = spawnStruct();
          var_7.perkref = var_0;
          var_7.sendingplayer = self;
          var_4.rangeperkon[var_4.rangeperkon.size] = var_7;
        }

        continue;
      }

      if(distancesquared(self.origin, var_4.origin) >= var_1) {
        for(var_6 = 0; var_6 < var_4.rangeperkon.size; var_6++) {
          if(var_4.rangeperkon[var_6].perkref == var_0 && var_4.rangeperkon[var_6].sendingplayer == self) {
            var_4 _meth_866C(&"remove_teammate_mod_buffs", 1, var_0);
            var_4.rangeperkon = common_scripts\utility::_id_0F9A(var_4.rangeperkon, var_6);
          }
        }
      }
    }

    wait 0.2;
  }

  foreach(var_4 in level.players) {
    if(isDefined(var_4.rangeperkon)) {
      for(var_6 = 0; var_6 < var_4.rangeperkon.size; var_6++) {
        if(var_4.rangeperkon[var_6].perkref == var_0 && var_4.rangeperkon[var_6].sendingplayer == self) {
          var_4 _meth_866C(&"remove_teammate_mod_buffs", 1, var_0);
          var_4.rangeperkon = common_scripts\utility::_id_0F9A(var_4.rangeperkon, var_6);
        }
      }
    }
  }
}

_id_0F0F(var_0) {
  if(!isDefined(level.players))
    return 0;

  foreach(var_2 in level.players) {
    if(var_2 _id_4BA7(var_0))
      return 1;
  }

  return 0;
}

_id_4BA7(var_0) {
  return maps\mp\_utility::_hasperk(var_0);
}

_id_8A6B(var_0) {
  maps\mp\_utility::giveperk(var_0);
}

_id_A086(var_0) {
  maps\mp\_utility::_id_0735(var_0);
}

_id_9470(var_0) {
  var_1 = int(var_0);
  return var_1;
}

_id_7ACD() {
  _id_0513::_id_A13B();
}

zombiesmovespeedscale() {
  var_0 = 1;

  if(isDefined(self.inlaststand) && self.inlaststand && isDefined(self._id_172C) && self._id_172C)
    return 0;

  if(isDefined(self._id_5799) && self._id_5799)
    return 0;

  if(_id_4BA7("specialty_class_mobilization_zm") && isDefined(self._id_569F) && self._id_569F)
    var_0 = var_0 * 1.5;

  if(_id_4BA7("specialty_class_charge_the_line_zm") && isDefined(self._id_60E8) && self._id_60E8)
    var_0 = var_0 * 1.5;

  if(isDefined(self._id_570B) && self._id_570B)
    var_0 = var_0 * 0.9;

  if(isDefined(self._id_570C) && self._id_570C)
    var_0 = var_0 * 0.7;

  if(isDefined(self._id_570D) && self._id_570D)
    var_0 = var_0 * 0.5;

  if(isDefined(self.bayonetboost) && self.bayonetboost && isDefined(self._id_165B) && self._id_165B)
    var_0 = var_0 * 1.1;

  if(isDefined(self.bayonetboosthc) && self.bayonetboosthc && isDefined(self._id_165B) && self._id_165B)
    var_0 = var_0 * 1.25;

  return var_0;
}

_id_AB2B() {
  if(!isalive(self) && !_id_73F9(self, common_scripts\utility::_id_4550()))
    return common_scripts\utility::_id_4550();
  else if(!_id_73F9(self, common_scripts\utility::_id_4550()))
    return maps\mp\_utility::_id_44DD();
  else
    return common_scripts\utility::_id_4550();
}

_id_52B0() {
  level._id_32BC = [];
  _id_7BDE("dot_generic_zm");
}

_id_7BDE(var_0) {
  var_1 = spawnStruct();
  level._id_32BC[var_0] = var_1;
  var_1.name = var_0;
}

_id_56D0(var_0) {
  if(isDefined(var_0) && isDefined(level._id_32BC[var_0]))
    return 1;

  return 0;
}

_id_AAFA(var_0, var_1) {
  var_2 = _getent(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  for(;;) {
    var_2 waittill("trigger", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }
    return var_3;
  }
}

_id_AAFB(var_0) {
  return _id_AAFA(var_0, "targetname");
}

_id_1E5F(var_0, var_1) {
  switch (var_1.size) {
    case 0:
      return call[[var_0]]();
    case 1:
      return call[[var_0]](var_1[0]);
    case 2:
      return call[[var_0]](var_1[0], var_1[1]);
    case 3:
      return call[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    case 10:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9]);
    case 11:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10]);
    case 12:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11]);
    case 13:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12]);
    case 14:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13]);
    case 15:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14]);
    case 16:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15]);
    case 17:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16]);
    case 18:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17]);
    case 19:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18]);
    case 20:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19]);
    case 21:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20]);
    case 22:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21]);
    case 23:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22]);
    case 24:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23]);
    case 25:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24]);
    case 26:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24], var_1[25]);
    case 27:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24], var_1[25], var_1[26]);
    case 28:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24], var_1[25], var_1[26], var_1[27]);
    case 29:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24], var_1[25], var_1[26], var_1[27], var_1[28]);
    case 30:
      return call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8], var_1[9], var_1[10], var_1[11], var_1[12], var_1[13], var_1[14], var_1[15], var_1[16], var_1[17], var_1[18], var_1[19], var_1[20], var_1[21], var_1[22], var_1[23], var_1[24], var_1[25], var_1[26], var_1[27], var_1[28], var_1[29]);
    default:
  }
}

_id_AC42(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  _id_AC46(var_0, var_1, "%b");
}

_id_AC44(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  _id_AC46(var_0, int(var_1), "%d");
}

_id_AC43(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  _id_AC46(var_0, _float(var_1), "%f");
}

_id_AC48(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "";

  _id_AC46(var_0, var_1, "%s");
}

_id_AC45(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = &"ZOMBIES_EMPTY_STRING";

  _id_AC46(var_0, var_1, "%t");
}

_id_AC49(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  _id_AC46(var_0, var_1, "%v");
}

_id_AC46(var_0, var_1, var_2) {
  if(!_id_AC4C()) {
    return;
  }
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.value = var_1;
  var_3.type = var_2;
  self._id_6E5C = common_scripts\utility::_id_0F6F(self._id_6E5C, var_3);
  var_4 = 48;
}

_id_AC4C() {
  if(!isDefined(level._id_AC4C))
    level._id_AC4C = getDvar("3038") != "";

  return level._id_AC4C;
}

_id_AC4B(var_0, var_1) {
  var_2 = spawnStruct();

  if(_id_AC4C()) {
    if(isDefined(var_0)) {
      var_2._id_AC7C = _id_055A::_id_4562(var_0);

      if(!isDefined(var_2._id_AC7C))
        var_2._id_AC7C = "";
    }

    var_3 = 0;

    if(!var_3 && !isDefined(var_0))
      var_0 = (0, 0, 0);

    var_2.origin = var_0;
    var_2._id_3E3D = "script_zombie_" + var_1 + ": ";
    var_2._id_6E5C = [];
  }

  return var_2;
}

_id_AC4D() {
  if(!_id_AC4C()) {
    return;
  }
  _id_AC44("game_time_ms", gettime());
  _id_AC42("is_atvi_recon_playtest_build", 0);
  var_0 = 4;
  var_1 = [];

  if(isDefined(level.players)) {
    foreach(var_3 in level.players)
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_3.name);
  }

  while(var_1.size < var_0)
    var_1 = common_scripts\utility::_id_0F6F(var_1, "");

  for(var_5 = 0; var_5 < var_0; var_5++)
    _id_AC48("player_" + (var_5 + 1), var_1[var_5]);

  if(isDefined(self._id_AC7C))
    _id_AC48("zone", self._id_AC7C);

  _id_AC48("quests", _id_0557::_id_7837());
  _id_AC44("zombies_wave", level._id_A980);
  var_6 = [];
  var_7 = "";

  foreach(var_9 in self._id_6E5C) {
    self._id_3E3D = self._id_3E3D + (var_7 + var_9.name + " " + var_9.type);
    var_7 = ", ";
    var_6 = common_scripts\utility::_id_0F6F(var_6, var_9.value);
  }

  if(isDefined(self.origin)) {
    var_6 = common_scripts\utility::_id_0F73([self.origin, self._id_3E3D], var_6);
    _id_1E5F(::_reconspatialevent, var_6);
  } else {
    var_6 = common_scripts\utility::_id_0F73([self._id_3E3D], var_6);
    _id_1E5F(::_reconevent, var_6);
  }
}

_id_AC4A() {
  var_0 = -1;

  if(isDefined(level._id_7F23))
    var_0 = maps\mp\gametypes\_gamelogic::_id_44F8() - level._id_7F23;

  _id_AC43("zombies_wave_time", var_0);
}

_id_AC47(var_0) {
  var_1 = "";

  if(isDefined(var_0))
    var_1 = var_0.name;

  _id_AC48("player", var_1);
}

_id_1F54(var_0, var_1) {
  var_2 = 0;

  switch (var_0._id_0A4B) {
    case "zombie_sizzler":
    case "zombie_berserker":
    case "zombie_generic":
      var_2 = 1;
      break;
  }

  if(!var_2)
    return 0;

  if(common_scripts\utility::_id_562E(var_0._id_2FDA))
    return 0;

  if(var_0 _id_5774() || common_scripts\utility::_id_562E(var_0._id_0103) || var_0 _id_AC70())
    return 0;

  if(common_scripts\utility::_id_562E(var_0.nopairmelee))
    return 0;

  var_3 = level._id_A9C8[var_1];

  if(isDefined(var_3))
    return self[[var_3]](var_0);
  else
    return _id_0586::_id_2BA2(var_0);
}

currentplayersthread(var_0, var_1) {
  if(!isDefined(level.players)) {
    return;
  }
  foreach(var_3 in level.players)
  var_3 thread common_scripts\utility::maketurretinoperable(var_0, var_1);

  foreach(var_3 in level._id_596C)
  var_3 thread common_scripts\utility::maketurretinoperable(var_0, var_1);
}

perzombiethread(var_0, var_1) {
  foreach(var_3 in _id_408F())
  var_3 thread common_scripts\utility::maketurretinoperable(var_0, var_1);

  for(;;) {
    level waittill("zombie_spawned", var_3);
    var_3 thread common_scripts\utility::maketurretinoperable(var_0, var_1);
  }
}

_id_ABCB(var_0, var_1) {
  var_2 = var_0 getclientomnvar("ui_zm_hud_vis_bits");
  var_3 = 1 << var_1;
  var_4 = var_2 &var_3;
  var_5 = var_4 != 0;
  return var_5;
}

_id_ABCC(var_0, var_1, var_2) {
  if(_id_ABCB(var_0, var_1) == var_2)
    return 0;

  var_3 = var_0 getclientomnvar("ui_zm_hud_vis_bits");

  if(var_2)
    var_3 = var_3 | 1 << var_1;
  else
    var_3 = var_3 &~(1 << var_1);

  var_0 setclientomnvar("ui_zm_hud_vis_bits", var_3);
  return 1;
}

_id_ABCA(var_0, var_1) {
  return _id_ABCC(var_0, var_1, 1);
}

_id_ABC9(var_0, var_1) {
  return _id_ABCC(var_0, var_1, 0);
}

_id_9597() {
  _id_7BD0("tackle", ::_id_959B, undefined, 4.5, ::_id_959A);
}

_id_43EF(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2._id_0A4B) && common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker"], var_2._id_0A4B) && var_1 < var_0._id_2434)
    return "close";

  if(var_1 < var_0._id_60C1)
    return "medium";

  return "far";
}

tackle_is_in_range(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vectordot(var_0, var_1);

  if(var_5 < 0 || var_5 > var_3)
    return 0;

  var_6 = _abs(vectordot(var_0, var_2));

  if(var_6 > var_4)
    return 0;

  return 1;
}

tackle_thread(var_0, var_1, var_2) {
  for(;;) {
    waitframe();

    if(common_scripts\utility::_id_562E(var_0._id_2F74)) {
      continue;
    }
    var_3 = anglestoright(var_0.angles);
    var_4 = anglesToForward(var_0.angles);
    var_5 = var_1;
    var_6 = var_5._id_2434;
    var_7 = var_5._id_60C1;
    var_8 = var_5._id_3A20;
    var_9 = var_5._id_1B70;
    var_10 = max(var_6, max(var_7, var_8)) / 2;
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in _id_408F()) {
      if(var_14 == self) {
        continue;
      }
      var_15 = _id_0A51(var_14._id_0A4B);
      var_16 = isDefined(var_15) && common_scripts\utility::_id_562E(var_15.tacklebycharge);

      if(!var_16) {
        continue;
      }
      var_17 = var_14.origin - var_0.origin;

      if(common_scripts\utility::_id_562E(var_14.immunetotackling)) {
        continue;
      }
      if(!tackle_is_in_range(var_17, var_4, var_3, var_9, var_10)) {
        continue;
      }
      if(var_14 maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
        maps\mp\agents\_agent_utility::_id_5A28(var_14);
        continue;
      }

      var_18 = _abs(vectordot(var_17, var_3));
      var_19 = var_14 _id_43EF(var_5, var_18);
      _id_7D1B(var_0, var_14, var_19, var_2);
    }

    if(common_scripts\utility::_id_562E(var_5.tackleplayers)) {
      var_27 = var_5.far_dist_p;
      var_28 = var_5.box_height_p;
      var_29 = gettime();
      var_30 = 2000;

      foreach(var_32 in level.players) {
        if(isDefined(var_32.lasttackledtime) && var_29 - var_32.lasttackledtime <= var_30) {
          continue;
        }
        var_33 = var_32.origin - var_0.origin;

        if(!tackle_is_in_range(var_33, var_4, var_3, var_28, var_27)) {
          continue;
        }
        var_32.lasttackledtime = var_29;
        var_32 dodamage(var_5.tackle_dmg_p, var_0.origin, var_0);
      }
    }
  }
}

create_temp_tackler(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  return var_1;
}

_id_7D1B(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = "medium";

  var_4 = spawnStruct();
  var_4._id_959C = var_0;
  var_4._id_9598 = var_2;
  var_4._id_53E8 = var_3;
  var_1 thread _id_7D1A("tackle", [var_4], 0.05, [var_0, "death"]);
  var_0._id_5B55 = gettime();
}

_id_959B(var_0) {
  var_1 = var_0._id_959C;
  var_2 = anglestoright(var_1.angles);
  var_3 = var_2 * common_scripts\utility::_id_8C4F(vectordot(var_2, self.origin - var_1.origin));
  var_4 = _angleclamp180(_vectortoyaw(var_3) - self.angles[1]);
  var_5 = [];
  var_6 = [];

  if(isDefined(var_1) && isDefined(var_1._id_0117) && _isagent(var_1._id_0117))
    set_tackled_by(var_1._id_0117, 1);

  switch (var_0._id_9598) {
    case "close":
      var_5 = ["side_stumble_1_back_left", "side_stumble_1_back_right", "side_stumble_1_forward_left", "side_stumble_1_forward_right"];
      var_6 = [135, -135, 45, -45];
      break;
    case "medium":
      var_5 = ["side_stumble_2_left", "side_stumble_2_right"];
      var_6 = [90, -90];
      break;
    case "far":
      var_5 = ["side_stumble_3_left", "side_stumble_3_right"];
      var_6 = [90, -90];
      break;
    default:
      return;
  }

  var_7 = 180;
  var_8 = 0;

  for(var_9 = 0; var_9 < var_6.size; var_9++) {
    var_10 = var_6[var_9];
    var_11 = _abs(_angleclamp180(var_10 - var_4));

    if(var_11 > var_7) {
      continue;
    }
    var_7 = var_11;
    var_8 = var_9;
  }

  var_12 = var_5[var_8];
  var_13 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_12);
  var_14 = self getanimentrycount(var_13);
  var_15 = randomint(var_14);
  var_16 = 0.5;
  var_7 = _angleclamp180(var_4 - var_6[var_8]);
  var_17 = (self.angles[0], self.angles[1] + var_7 * var_16, self.angles[2]);
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "tackle");
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_17);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_13, var_15, 1, "stun_anim");
  _id_054D::_id_4788(var_0._id_959C, var_0._id_53E8);
}

_id_959A(var_0) {
  if(isDefined(var_0._id_959C) && isDefined(var_0._id_959C._id_0117) && _isagent(var_0._id_959C._id_0117))
    set_tackled_by(var_0._id_959C._id_0117, 0);

  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "tackle");
}

set_tackled_by(var_0, var_1) {
  if(!isDefined(var_0.tacklevictims))
    var_0.tacklevictims = [];

  if(!isDefined(self.tackleattackers))
    self.tackleattackers = [];

  var_2 = self getentitynumber();
  var_3 = var_0 getentitynumber();

  if(var_1) {
    var_0.tacklevictims[var_2] = self;
    self.tackleattackers[var_3] = var_0;
  } else {
    var_0.tacklevictims[var_2] = undefined;
    self.tackleattackers[var_3] = undefined;
  }

  update_tackle_status(self);
  update_tackle_status(var_0);
}

tackle_system_handle_zombie_death(var_0) {
  if(isDefined(self.tacklevictims)) {
    foreach(var_2 in self.tacklevictims)
    var_2 set_tackled_by(self, 0);
  }

  if(isDefined(self.tackleattackers)) {
    foreach(var_5 in self.tackleattackers)
    set_tackled_by(var_5, 0);
  }
}

update_tackle_status(var_0) {
  if(isDefined(self.tacklevictims) && self.tacklevictims.size > 0) {
    return;
  }
  if(isDefined(self.tackleattackers) && self.tackleattackers.size > 0) {
    return;
  }
  return;
  return;
}

_id_0619(var_0, var_1) {
  if(common_scripts\utility::_id_0F79(var_0["attachments"], var_1))
    return var_0;

  return _id_0593(var_0, var_1);
}

_id_0593(var_0, var_1) {
  if(!isDefined(var_0["attachments"]))
    var_0["attachments"] = [];

  var_2 = common_scripts\utility::_id_0F6F(var_0["attachments"], var_1);
  var_0["attachments"] = common_scripts\utility::alphabetize(var_2);
  return var_0;
}

_id_6117(var_0, var_1) {
  var_2 = [];
  var_3 = ["alt_mode", "weapon", "cond", "camo", "reticle", "customization", "model"];

  foreach(var_5 in var_3) {
    var_6 = undefined;
    var_7 = var_0[var_5];
    var_8 = var_1[var_5];

    if(isDefined(var_7))
      var_6 = var_7;
    else if(isDefined(var_8))
      var_6 = var_8;

    var_2[var_5] = var_6;
  }

  var_10 = common_scripts\utility::_id_0F73(var_0["attachments"], var_1["attachments"]);
  var_10 = common_scripts\utility::_id_0F97(var_10);

  if(var_10.size > 6)
    var_10 = common_scripts\utility::_id_0FA3(var_10, 0, 6);

  var_2["attachments"] = common_scripts\utility::alphabetize(var_10);
  return var_2;
}

_id_06AD(var_0, var_1) {
  var_0["attachments"] = common_scripts\utility::_id_0F93(var_0["attachments"], var_1);
  return var_0;
}

_id_062F(var_0) {
  var_1 = "";

  if(isDefined(var_0["alt_mode"]))
    var_1 = var_1 + (var_0["alt_mode"] + "+");

  var_2 = var_0["weapon"];
  var_1 = var_1 + var_2;
  var_3 = var_0["attachments"];

  if(isDefined(var_3)) {
    var_4 = maps\mp\gametypes\_class::_id_774F(var_2, var_3);

    foreach(var_6 in var_4)
    var_1 = var_1 + ("+" + var_6);
  }

  foreach(var_9 in ["cond", "camo", "reticle", "customization", "model"]) {
    var_10 = var_0[var_9];
    var_1 = maps\mp\gametypes\_class::_id_0F1E(var_1, var_10);
  }

  return var_1;
}

_id_AAFC(var_0) {
  var_1 = weaponclass(var_0);
  return var_1;
}

_id_9469(var_0) {
  if(!isDefined(level._id_946A))
    level._id_946A = [];

  var_1 = level._id_946A[var_0];

  if(!isDefined(var_1)) {
    var_1 = _id_946B(var_0);

    if(level._id_946A.size < 1000)
      level._id_946A[var_0] = var_1;
  }

  return var_1;
}

_id_946B(var_0) {
  var_1 = "_loot";
  var_2 = common_scripts\utility::_id_9462(var_0, var_1);

  if(var_2 == -1)
    return var_0;

  for(var_3 = var_2 + var_1.size; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(var_4 != "_") {
      continue;
    }
    var_5 = getsubstr(var_0, 0, var_2);
    var_6 = getsubstr(var_0, var_3);
    var_0 = var_5 + var_6;
    return var_0;
  }

  return var_0;
}

_id_AAF9(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = _getweaponbasename(var_0);

  if(!isDefined(var_3))
    return "none";

  var_0 = var_3;

  if(!var_1)
    var_0 = _id_0569::_id_40BD(var_0);

  if(!var_2)
    var_0 = _id_9469(var_0);

  return var_0;
}

_id_5843(var_0) {
  var_1 = "none" != weaponclass(var_0);
  return var_1;
}

_id_9475(var_0) {
  var_0 = _func_2FF(var_0, "_zm");
  var_0 = _func_2FF(var_0, "_mp");
  var_0 = _func_2FF(var_0, "_raid");
  return var_0;
}

_id_0FB9(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!common_scripts\utility::_id_0F79(var_1, var_3))
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
  }

  return var_1;
}

_id_4584(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "none")
    return [undefined, undefined];

  var_2 = _getweaponbasename(var_0);

  if(isPlayer(var_1) && var_1 _meth_8661())
    var_3 = "heavy";
  else
    var_3 = "default";

  return [var_3, var_2];
}

is_power_on(var_0) {
  if(!common_scripts\utility::_id_3C77("power_sz2"))
    return 0;

  return 1;
}

getzombiemapsetting(var_0) {
  if(!isDefined(level.zmutils)) {
    level.zmutils = [];
    loadzombiemapsettings("default");
    loadzombiemapsettings(maps\mp\_utility::_id_4571());
  }

  return level.zmutils[var_0];
}

loadzombiemapsettings(var_0) {
  var_1 = "mp/zombieSettingsSwitchTable.csv";
  var_2 = 0;
  var_3 = 1;

  if(!_tableexists(var_1)) {
    return;
  }
  var_4 = tablelookup(var_1, var_2, var_0, var_3);

  if(!_tableexists(var_4)) {
    return;
  }
  var_5 = _tablegetrowcount(var_4);
  var_6 = 0;
  var_7 = 1;

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = _tablelookupbyrow(var_4, var_8, var_6);
    var_10 = _tablelookupbyrow(var_4, var_8, var_7);
    level.zmutils[var_9] = var_10;
  }
}

localtoworldcoords_actual(var_0) {
  return _transformmove(self.origin, self.angles, (0, 0, 0), (0, 0, 0), var_0, (0, 0, 0))["origin"];
}

monitor_stick_input() {
  thread managelocationselect();
  self endon("stop_using_station");
  self endon("confirm_location");
  self endon("cancel_location");
  self endon("disconnect");
  self endon("begin_last_stand");
  self.rightstickinput = 0;
  self.leftstickinput = 0;

  for(;;) {
    self waittill("radio_tuning", var_0, var_1);
    self.rightstickinput = var_0;
    self.leftstickinput = var_1;
    waitframe();
  }
}

managelocationselect() {
  self beginlocationselection("map_artillery_selector", 1, 0.01, 1);
  common_scripts\utility::_id_A70A("confirm_location", "cancel_location", "begin_last_stand", "disconnect", "death");
  self notify("stop_using_station");
  self.rightstickinput = undefined;
  self.leftstickinput = undefined;
  self endlocationselection();
}

get_right_stick_input() {
  return self.rightstickinput;
}

get_left_stick_input() {
  return self.leftstickinput;
}

milesperhour_to_inchespersec(var_0) {
  var_1 = var_0 * 17.6;
  return var_1;
}

zombie_charge_tackle_thread(var_0, var_1) {
  self endon("attack_hit");
  self endon("attack_miss");
  childthread tackle_thread(self, var_1, var_0);
}

zombie_charge_set_smooth_turn_speed(var_0, var_1) {
  var_8 = _id_9A9E(360 * var_0) * 0.05;
  self _meth_85DE(var_8);
}

zombie_charge_turn_smoothing_thread(var_0) {
  var_1 = var_0.initial_turn_deg;
  var_2 = var_0.initial_turn_secs;
  var_3 = var_0.initial_turn_speed;
  self _meth_85E0(1);
  self scragentsetanimmode("code_move");
  self scragentsetorientmode("face motion");

  if(var_2 > 0) {
    var_4 = var_1 / (360 * var_2);
    zombie_charge_set_smooth_turn_speed(var_4, var_0.debug_dvar);
    wait(var_2);
  }

  zombie_charge_set_smooth_turn_speed(var_3, var_0.debug_dvar);
}

zombie_monitor_ignored_stalkee(var_0) {
  var_0 endon("disconnect");

  while(!_id_8B95(var_0))
    wait 0.2;

  var_0 notify("shouldBeIgnored");
}

zombie_charge_run_to_player(var_0) {
  var_1 = var_0.player;
  var_1 endon("zombiesIgnoreMeChanged");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("begin_last_stand");
  var_2 = var_0._id_7462;
  var_3 = common_scripts\utility::_id_3D5C(vectortoangles(var_2 - self.origin));
  var_4 = 0;
  var_5 = 0;
  var_6 = undefined;
  var_7 = 0;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_3);
  self scragentsetanimscale(1, 1);
  var_8 = var_0.react_state_name;
  var_4 = 0;
  var_9 = var_0.react_anim_rate;
  var_10 = 0;
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_8, var_4, var_9, var_10);
  var_11 = self getanimentry(var_8, var_4);
  var_12 = maps\mp\agents\_scripted_agent_anim_util::getnotetracktimeinsecs(var_11, "start_run") / var_9;
  self.end_roar_secs = gettime() / 1000 + var_12;
  wait(var_12);
  childthread zombie_charge_tackle_thread(var_1, var_0);

  if(isDefined(var_0.turn_smoothing_thread))
    childthread[[var_0.turn_smoothing_thread]](var_0);

  var_8 = var_0.run_state_name;
  var_9 = 1;
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_8, var_4, var_9, var_10);
  var_11 = self getanimentry(var_0.stop_run_state_name, 0);

  if(_animhasnotetrack(var_11, "attack")) {
    var_13 = maps\mp\agents\_scripted_agent_anim_util::getnotetracktimeinsecs(var_11, "attack");
    var_14 = _getmovedelta(var_11, 0, var_13);
    var_15 = length(var_14);
    var_16 = var_0.extra_lunge_radius;
    self._id_5F49 = var_15 + var_16;
  }

  var_17 = 0;
  var_18 = (0.784314, 0.47451, 0.223529);
  var_19 = (0.160784, 0.317647, 0.623529);
  var_20 = 0;
  var_21 = 0;
  var_22 = 0;

  while(!var_21) {
    waitframe();
    var_20 = var_20 + 0.05;
    var_23 = _func_2E1(var_1.origin);
    var_0._id_5B2E = var_23;
    self scragentsetgoalpos(var_23);
    var_24 = var_0.trigger_lerp_deg;
    var_25 = var_0.trigger_nolerp_deg;
    var_26 = var_0._id_9DAA;
    var_27 = var_24 / 2;
    var_28 = var_25 / 2;
    var_29 = maps\mp\_utility::_id_3B8E(self, var_1, var_27);
    var_30 = maps\mp\_utility::_id_3B8E(self, var_1, var_28);

    if(var_29 || var_30) {
      var_31 = _distance2d(self.origin, var_1.origin) < var_26;

      if(var_31) {
        var_17 = var_29;
        var_32 = (0, 1, 0);
        var_21 = 1;
      }

      continue;
    }

    var_36 = 1;
    var_37 = isDefined(self._id_5B55) && gettime() - self._id_5B55 < var_36 * 1000;

    if(var_20 > 1 && !var_37)
      var_21 = 1;
  }

  self._id_20DD = var_17;
  self notify("commence_attack!");
}

zombie_charge_run(var_0) {
  self._id_645E = var_0;
  var_1 = var_0.player;
  var_2 = self.origin;

  if(!isalive(var_1)) {
    return;
  }
  self endon(var_0.end_notify);
  self._id_5542 = 1;
  self scragentsetscripted(1);
  self._id_01BB = 1;
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, var_0.scripted_state);
  childthread zombie_monitor_ignored_stalkee(var_1);
  childthread zombie_charge_run_to_player(var_0);

  if(isalive(var_1) && self._id_0A4B == "zombie_heavy")
    var_1 thread _id_054E::_id_73B3();

  [var_4, var_5] = common_scripts\utility::_id_A70E(var_1, "zombiesIgnoreMeChanged", var_1, "shouldBeIngored", var_1, "death", var_1, "disconnect", var_1, "begin_last_stand", self, "commence_attack!");
  var_6 = var_0.stop_run_state_name;
  var_7 = 1;
  var_8 = self getanimentry(var_0.stop_run_state_name, 0);

  if(var_4 == "commence_attack!" && _animhasnotetrack(var_8, "attack") && isDefined(var_1)) {
    var_9 = 1;
    var_10 = undefined;
    var_11 = 0;
    maps\mp\agents\humanoid\_humanoid_melee::_id_3107(var_1, var_1.origin, var_6, self._id_20DD, var_10, var_7, var_11, var_9);
  } else {
    var_12 = 0.2;
    var_13 = gettime() / 1000;

    if(isDefined(self.end_roar_secs) && self.end_roar_secs > var_13)
      var_12 = self.end_roar_secs - var_13;

    wait(var_12);
    var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_6);
    var_15 = self getanimentry(var_6, var_14);
    var_16 = _getanimlength(var_15);
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetanimmode("anim deltas");
    maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_6, var_14, var_7);
    wait(var_16);
  }

  self._id_20ED = 0;
}

zombie_charge_cleanup(var_0) {
  self scragentsetscripted(0);
  self _meth_85E0(0);
  self scragentsetmaxturnspeed(_id_9A9E(10));
  self scragentsetphysicsmode("gravity");
  self._id_5542 = 0;
  self._id_64AB = undefined;
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, var_0.scripted_state);
  self notify(var_0.end_notify);
}

getplayerddlzonename() {
  var_0 = self;

  if(isDefined(var_0._id_295A))
    return var_0._id_295A;

  return "none";
}

zmcreatesustainedholdent() {
  var_0 = spawn("script_origin", self.origin);
  var_0._id_28D5 = 0;
  var_0._id_A22B = 0;
  var_0._id_54F5 = 0;
  var_0 thread zmdeletesustainedholdent(self);
  return var_0;
}

zmdeletesustainedholdent(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

zmsustainedholdthink(var_0, var_1, var_2) {
  if(isPlayer(var_0))
    var_0 playerlinkto(self);
  else
    var_0 linkto(self);

  var_0 common_scripts\utility::_id_0602();
  thread zmsustainedholdthinkplayerreset(var_0, var_2);
  self._id_28D5 = 0;
  self._id_54F5 = 1;
  self._id_A22B = 0;
  var_3 = zmsustainedholdthinkloop(var_0, var_1);

  if(!isDefined(self))
    return 0;

  self notify("useHoldThinkLoopDone");
  self._id_54F5 = 0;
  self._id_28D5 = 0;
  return var_3;
}

zmsustainedholdthinkplayerreset(var_0, var_1) {
  var_0 endon("death");
  var_2 = ["death", "useHoldThinkLoopDone"];

  if(isDefined(var_1)) {
    if(_isarray(var_1))
      var_2 = maps\mp\_utility::array_combine_no_dupes(var_2, var_1);
    else
      var_2[var_2.size] = var_1;
  }

  var_3 = common_scripts\utility::_id_A712(var_2);

  if(isalive(var_0)) {
    var_0 common_scripts\utility::_id_0616();

    if(var_0 islinked())
      var_0 unlink();

    var_0.radial_interact_active = undefined;
    var_0 _meth_866C(&"stop_progressive_interact", 0);
    var_0 _meth_866C(&"remove_progressive_interact", 0);
  }
}

zmsustainedholdthinkloop(var_0, var_1) {
  var_2 = 0;

  while(isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 usebuttonpressed()) {
    self._id_28D5 = self._id_28D5 + self._id_A22B * 50;

    if(!common_scripts\utility::_id_562E(var_0.radial_interact_active))
      var_0.radial_interact_active = 1;

    if(!self._id_A22B)
      self._id_A22B = 1;

    var_3 = var_1 - self._id_28D5;

    if(var_3 <= 0)
      return 1;
    else if(!var_2) {
      var_2 = 1;
      var_0 _meth_866C(&"start_progressive_interact", 1, var_3);
      var_0.radial_interact_active = undefined;
    }

    waitframe();
  }

  return 0;
}

playerspawneroverrideset(var_0) {
  level.zombies_active_spawn_event = var_0;
}

playerspawneroverrideclear() {
  level.zombies_active_spawn_event = undefined;
}

zm_util_create_client_overlay(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    var_4 = _newclienthudelem(var_2);
  else
    var_4 = newhudelem();

  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4._id_00C6 = "fullscreen";
  var_4._id_01CA = "fullscreen";
  var_4.alpha = var_1;
  var_4.foreground = 1;

  if(isDefined(var_3))
    var_4.color = var_3;

  return var_4;
}

zm_util_overlayfade(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  wait(var_0);
  var_3 fadeovertime(var_1);
  var_3.alpha = var_2;
  wait(var_1);
}

zm_util_run_outro_for_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_6 endon("disconnect");
  var_6 playerhide();
  var_6 disableweapons();
  var_6 setclientomnvar("ui_hide_hud", 1);
  var_6._id_324E = 1;
  var_6 _id_8A6D(1);

  if(isDefined(var_5))
    var_6 clientaddsoundsubmix(var_5);

  var_7 = var_2;
  var_8 = "black";

  if(!isDefined(var_6._id_1781))
    var_6._id_1781 = zm_util_create_client_overlay(var_8, 0, var_6, (1, 1, 1));

  var_9 = var_6._id_1781;
  var_9 setshader(var_8, 640, 480);
  var_9 thread zm_util_overlayfade(0, var_7, 1);
  wait(var_7);
  var_9 thread zm_util_overlayfade(0, var_7, 0);
  _func_290(var_6, var_0, var_3, var_4);
  var_9 thread zm_util_overlayfade(var_1 - var_7, var_7, 1);
  wait(var_1);
  _func_292(var_6);
  var_9 thread zm_util_overlayfade(0, var_7, 0);
  var_6 playershow();
  var_6 enableweapons();
  var_6 setclientomnvar("ui_hide_hud", 0);
  var_6._id_324E = 0;
  var_6 _id_8A6D(0);

  if(isDefined(var_5))
    var_6 clientclearsoundsubmix(var_5);
}

zm_util_run_outro(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_AC21 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_2))
    var_2 = 0.5;

  foreach(var_7 in level.players)
  var_7 thread zm_util_run_outro_for_player(var_0, var_1, var_2, var_3, var_4, var_5);

  wait(var_1 + var_2);
  level notify("outro_cinematic_finished");
  level._id_AC21 = 0;
}

solo_challenge_safety_think() {
  while(!isDefined(level.players))
    waitframe();

  for(;;) {
    wait 1;

    if(level.players.size == 0) {
      continue;
    }
    if(level.players.size > 1)
      level notify("zmb_solo_hc_challenges_invalid");
  }
}

solo_challenge_kill_think(var_0) {
  level waittill("zmb_solo_hc_challenges_invalid");
  level notify(var_0);
}

player_validate_is_in_zones(var_0) {
  var_1 = get_volumes_by_targetname_array(var_0);
  var_2 = self;

  foreach(var_4 in var_1) {
    if(var_2 istouching(var_4))
      return 1;
  }

  return 0;
}

get_volumes_by_targetname_array(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = getEntArray(var_3, "targetname");
    var_1 = common_scripts\utility::_id_0F73(var_4, var_1);
  }

  return var_1;
}

zm_get_weapon_class(var_0) {
  return maps\mp\_utility::getweaponclass(zombies_to_mp(var_0), 1);
}

zombies_to_mp(var_0) {
  if(issubstr(var_0, "_pap"))
    var_0 = _func_337(var_0, "_pap");

  var_0 = maps\mp\_utility::strip_suffix(var_0, "_zm");
  var_0 = maps\mp\_utility::strip_suffix(var_0, "_mp");
  var_0 = var_0 + "_mp";
  return var_0;
}

mp_to_zombies(var_0) {
  if(issubstr(var_0, "_pap"))
    var_0 = _func_337(var_0, "_pap");

  var_0 = maps\mp\_utility::strip_suffix(var_0, "_zm");
  var_0 = maps\mp\_utility::strip_suffix(var_0, "_mp");
  var_0 = var_0 + "_zm";
  return var_0;
}

obj_fall_onto_pos(var_0) {
  self endon("entitydeleted");
  var_1 = var_0 - self.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  self movegravity(var_4, var_2);
  wait(var_2);
  self.origin = var_0;
}

obj_fall_to_ent_location(var_0) {
  var_1 = var_0.origin - self.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  self movegravity(var_4, var_2);
  self rotateto(var_0.angles, var_2, 0, var_2);
  wait(var_2);
  self.origin = var_0.origin;
}

set_player_cinematic_mode(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_2.incinematicmode = 1;

  if(common_scripts\utility::_id_562E(var_0)) {
    var_2 playerhide();
    var_2 disableweapons();
  }

  var_2 allowfire(0);
  var_2 hideviewmodel();
  var_2 setclientomnvar("ui_hide_hud", 1);

  if(isDefined(var_1))
    var_2 clientaddsoundsubmix(var_1);

  var_2._id_324E = 1;
  var_2 _id_8A6D(1);
  var_2 freezecontrols(1);
}

unset_player_cinematic_mode(var_0, var_1) {
  var_2 = self;
  var_2 unlink();
  var_2 cameraunlink();
  var_2 showviewmodel();
  var_2.incinematicmode = 0;

  if(common_scripts\utility::_id_562E(var_0)) {
    var_2 setOrigin(_func_2E1(var_2.origin));
    var_2 playershow();
    var_2 enableweapons();
  }

  var_2 allowfire(1);
  var_2 setclientomnvar("ui_hide_hud", 0);
  var_2 freezecontrols(0);

  if(isDefined(var_1))
    var_2 clientclearsoundsubmix(var_1);

  var_2._id_324E = 0;
  var_2 _id_8A6D(0);
}

init_damageable_script_model() {
  self setcandamage(1);

  if(isDefined(self.damagecallback)) {
    return;
  }
  self setdamagecallbackon(1);
  self.damagecallback = ::damageable_script_model_ondamage;
}

cleanup_damageable_script_model() {
  self setcandamage(0);
  self.damagecallback = undefined;
}

damageable_script_model_ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_4) && maps\mp\_utility::_id_5755(var_4) && !common_scripts\utility::_id_562E(self.delayedmeleedamagewrapper)) {
    thread damageable_script_model_delayed_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    return;
  }

  self finishentitydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

damageable_script_model_delayed_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  wait 0;
  self.delayedmeleedamagewrapper = 1;
  self dodamage(var_2, var_6, var_1, var_0, var_4, var_5, var_8);
  self.delayedmeleedamagewrapper = undefined;
}

get_closest_spawn_by_type(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  var_3 = common_scripts\utility::_id_40B0(var_0, var_2);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.setlookatent) || issubstr(var_5.setlookatent, var_1))
      return var_5;
  }
}

force_use_hint_on(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_1))
    var_1 = "force_use_hint_on";

  self.forceusehintreason = var_1;
  var_2 forceusehinton(var_0);
}

force_use_hint_off(var_0) {
  var_1 = self;

  if(!isDefined(var_0))
    var_0 = "force_use_hint_on";

  self.forceusehintreason = undefined;
  var_1 forceusehintoff();
}

add_zombie_stun(var_0, var_1) {
  if(!isDefined(self.zombiestuns))
    self.zombiestuns = [];

  self.zombiestuns[var_0] = var_1;
  self notify("zombie_stunned");
}

remove_zombie_stun(var_0) {
  if(isDefined(self.zombiestuns))
    self.zombiestuns[var_0] = undefined;
}

is_zombie_stunned() {
  if(_id_053A::_id_AC2A())
    return 1;

  if(isDefined(self.zombiestuns))
    return self.zombiestuns.size > 0;

  return 0;
}

can_pair_melee() {
  var_0 = self;

  if(var_0 maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  return 1;
}

razergunmaxammo() {
  var_0 = self;
  var_1 = "razergun";
  var_2 = var_0 getweaponlistall();

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && issubstr(var_4, var_1)) {
      var_0 givemaxammo(var_4);
      var_5 = _weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_5);
    }
  }
}

zombie_shattered_get_map_number(var_0) {
  if(!isDefined(var_0))
    var_0 = maps\mp\_utility::_id_4571();

  var_1 = 0;

  if(_tableexists("mp/zombieDLC3MapInfoTable.csv") && _tablegetrowcount("mp/zombieDLC3MapInfoTable.csv") > 0) {
    var_2 = tablelookup("mp/zombieDLC3MapInfoTable.csv", 0, var_0, 1);

    if(isDefined(var_2) && var_2 != "")
      var_1 = int(var_2);
  }

  return var_1;
}

is_zm_shattered_thule_map(var_0) {
  var_1 = zombie_shattered_get_map_number(var_0);

  if(var_1 == 3)
    return 1;

  return 0;
}

is_zm_shattered_dnk_map(var_0) {
  var_1 = zombie_shattered_get_map_number(var_0);

  if(var_1 == 2)
    return 1;

  return 0;
}

is_zm_shattered_windmill_map(var_0) {
  var_1 = zombie_shattered_get_map_number(var_0);

  if(var_1 == 1)
    return 1;

  return 0;
}

is_wet_zombie(var_0, var_1, var_2, var_3) {
  return issubstr(var_1.model, "_wet_");
}

is_jack_box(var_0, var_1, var_2, var_3) {
  return issubstr(var_2, "jack_in_box");
}

remove_wallbuys_from_box() {
  var_0 = common_scripts\utility::_id_46B7("wallbuy", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_0165)) {
      continue;
    }
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_3._id_0165);
  }

  foreach(var_6 in var_1)
  _id_0548::_id_7CEA(var_6);
}

is_solo() {
  if(level.players.size == 1)
    return 1;

  return 0;
}