/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1807.gsc
*************************************************/

init() {
  if(!challengesenabled()) {
    return;
  }
  level.meansofdeathids = [];
  level.meansofdeathids["MOD_UNKNOWN"] = 0;
  level.meansofdeathids["MOD_PISTOL_BULLET"] = 1;
  level.meansofdeathids["MOD_RIFLE_BULLET"] = 2;
  level.meansofdeathids["MOD_GRENADE"] = 3;
  level.meansofdeathids["MOD_GRENADE_SPLASH"] = 4;
  level.meansofdeathids["MOD_PROJECTILE"] = 5;
  level.meansofdeathids["MOD_PROJECTILE_SPLASH"] = 6;
  level.meansofdeathids["MOD_MELEE"] = 7;
  level.meansofdeathids["MOD_MELEE_WEAPON_BUTT"] = 8;
  level.meansofdeathids["MOD_MELEE_ASSASSINATE"] = 9;
  level.meansofdeathids["MOD_HEAD_SHOT"] = 10;
  level.meansofdeathids["MOD_CRUSH"] = 11;
  level.meansofdeathids["MOD_TELEFRAG"] = 12;
  level.meansofdeathids["MOD_FALLING"] = 13;
  level.meansofdeathids["MOD_SUICIDE"] = 14;
  level.meansofdeathids["MOD_TRIGGER_HURT"] = 15;
  level.meansofdeathids["MOD_EXPLOSIVE"] = 16;
  level.meansofdeathids["MOD_IMPACT"] = 17;
  level.meansofdeathids["MOD_FIRE"] = 18;
  level.meansofdeathids["MOD_ELECTROCUTED"] = 19;
  level.meansofdeathids["MOD_HIT_BY_OBJECT"] = 20;
  level.meansofdeathids["MOD_DROWN"] = 21;
  level.meansofdeathids["MOD_DOT"] = 22;
  level.meansofdeathids["MOD_DOT_SELF"] = 23;
  level.meansofdeathids["MOD_GAS"] = 24;
  level.meansofdeathids["MOD_POST_GAME"] = 25;
  level.meansofdeathids["MOD_META"] = 26;
  level.meansofdeathids["MOD_AAT"] = 27;
  level.meansofdeathids["MOD_DEATH_CIRCLE"] = 28;
  level.meansofdeathids["MOD_DOWNED"] = 29;
  level.meansofdeathids["MOD_BLED_OUT"] = 30;
  level.meansofdeathids["MOD_EXECUTION"] = 31;
}

challengesenabled() {
  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled()) {
    return 0;
  }

  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  return 1;
}

setaebit(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 30 || _func_0121(var_0)) {
    var_2 = _func_0436(var_0 + "", var_1);
  } else {
    var_2 = var_0 | 1 << var_1;
  }

  return var_2;
}

_id_4006(var_0, var_1, var_2, var_3, var_4) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_5 = getweaponlootid(var_3);
  var_6 = getweaponpaplevel(var_0, var_3);
  var_7 = getzombietype(var_1);
  var_8 = getaeweaponclass(var_3, var_4);
  var_9 = getzmeliminationbitfield(var_2);
  var_10 = getelimbitfield(var_2);
  var_11 = getkillbitfield(var_2, var_4);
  var_12 = getopticclass(var_3);
  var_13 = getweaponattachmentids(var_3);
  var_14 = getmeansofdeathid(var_4);
  var_15 = "";

  if(isDefined(var_3) && isDefined(var_3.basename)) {
    var_15 = var_3.basename;
  }

  var_16 = 0;

  if(isDefined(var_0.recentweaponkills) && isDefined(var_0.recentweaponkills[var_15])) {
    var_16 = var_0.recentweaponkills[var_15];

    if(isDefined(level._id_3BE9._id_0F51) && isDefined(var_0.highest_objective_rapid_kill) && var_0.highest_objective_rapid_kill < var_16) {
      var_9 = setaebit(var_9, 3);
      var_0.highest_objective_rapid_kill = var_16;
    }
  }

  var_16 = 0;

  if(isDefined(var_0.recentweaponkills) && isDefined(var_0.recentweaponkills[var_15])) {
    var_16 = var_0.recentweaponkills[var_15];

    if(isDefined(level._id_3BE9._id_0F51) && isDefined(var_0.highest_objective_rapid_kill) && var_16 >= 10 && !istrue(var_0.b_finish_first_objective_rapid_kill_ar) && var_8 == 3) {
      var_9 = setaebit(var_9, 17);
      var_0.b_finish_first_objective_rapid_kill_ar = 1;
    }
  }

  var_17 = 0;

  if(scripts\engine\utility::_id_1BA1(var_2, "critical_kill") && isDefined(var_0.recentweaponcriticalkills) && isDefined(var_0.recentweaponcriticalkills[var_15])) {
    var_17 = var_0.recentweaponcriticalkills[var_15];

    if(isDefined(level._id_3BE9._id_0F51) && isDefined(var_0.highest_objective_rapid_critical_kill) && var_0.highest_objective_rapid_critical_kill < var_17) {
      var_9 = setaebit(var_9, 15);
      var_0.highest_objective_rapid_critical_kill = var_17;
    }
  }

  var_17 = 0;

  if(scripts\engine\utility::_id_1BA1(var_2, "critical_kill") && isDefined(var_0.recentweaponcriticalkills) && isDefined(var_0.recentweaponcriticalkills[var_15])) {
    var_17 = var_0.recentweaponcriticalkills[var_15];

    if(isDefined(level._id_3BE9._id_0F51) && isDefined(var_0.highest_objective_rapid_critical_kill) && var_17 >= 5 && !istrue(var_0.b_finish_first_objective_rapid_critical_kill_lmg) && var_8 == 1) {
      var_9 = setaebit(var_9, 18);
      var_0.b_finish_first_objective_rapid_critical_kill_lmg = 1;
    }
  }

  if(_func_0107(var_0.a_wall_buy_weapons) && scripts\cp\utility::_id_88B7(var_0.a_wall_buy_weapons, var_3)) {
    var_9 = setaebit(var_9, 19);
  }

  var_18 = 0;

  if(isDefined(var_0.consecutiveweaponkills) && isDefined(var_0.consecutiveweaponkills[var_15])) {
    var_18 = var_0.consecutiveweaponkills[var_15];
  }

  if(!istrue(var_0.b_finish_1000_eliminations)) {
    if(!isDefined(var_0.eliminationcounts)) {
      var_0.eliminationcounts = 0;
    }

    if(var_0.eliminationcounts < 1000) {
      var_0.eliminationcounts++;
    } else {
      var_11 = setaebit(var_11, 34);
      var_0.b_finish_1000_eliminations = 1;
    }
  }

  if(!istrue(var_0.b_finish_500_eliminations) && var_8 == 3) {
    if(!isDefined(var_0.eliminationcounts_with_lmg)) {
      var_0.eliminationcounts_with_lmg = 0;
    }

    if(var_0.eliminationcounts_with_lmg < 500) {
      var_0.eliminationcounts_with_lmg++;
    } else {
      var_10 = setaebit(var_10, 10);
      var_0.b_finish_500_eliminations = 1;
    }
  }

  var_19 = 0;

  if(isDefined(var_0 _id_0766::getcurrentsuperlevel())) {
    var_19 = var_0 _id_0766::getcurrentsuperlevel();
  }

  var_20 = "";

  if(isDefined(var_3)) {
    var_20 = getweaponbasename(var_3);
  }

  if(isDefined(var_20) && var_20 == "s4_energy_mine_zm") {
    var_11 = setaebit(var_11, 40);
  }

  if(isDefined(var_20) && var_20 == "s4_throwing_knife_zm") {
    var_0.n_throwing_knife_kill = scripts\cp\utility::_id_459B(var_0.n_throwing_knife_kill, 0);
    var_0.n_throwing_knife_kill++;

    if(!(var_0.n_throwing_knife_kill % 5)) {
      var_11 = setaebit(var_11, 41);
    }
  }

  if(isDefined(var_20) && var_20 == "s4_frost_blast_zm") {
    var_11 = setaebit(var_11, 42);
  }

  var_21 = scripts\engine\utility::_id_1BAB(var_13, "");

  if(!isDefined(var_21)) {
    var_10 = setaebit(var_10, 2);
  }

  if(getdvarint("#x36ca14263dbaa1beb") == 1 && isPlayer(var_0) && var_8 == 7) {
    var_0.pistol_kill_count = scripts\cp\utility::_id_459B(var_0.pistol_kill_count, 0);
    var_0.pistol_kill_count++;

    if(var_0.pistol_kill_count >= 500 && !istrue(var_0.b_finish_pistol_500_kill)) {
      var_0.b_finish_pistol_500_kill = 1;
      var_10 = setaebit(var_10, 7);
    }
  }

  if(getdvarint("#x36ca14263dbaa1beb") == 1 && isPlayer(var_0) && isDefined(var_0 _meth_815A()) && level scripts\engine\utility::_id_5C00("zipline_moving")) {
    var_10 = setaebit(var_10, 8);
  }

  if(isPlayer(var_0)) {
    var_0.a_hit_trickers = scripts\cp\utility::_id_459B(var_0.a_hit_trickers, []);

    if(isDefined(var_1) && !scripts\cp\utility::_id_88B7(var_0.a_hit_trickers, var_1) && var_7 == 3) {
      var_11 = setaebit(var_11, 57);
    }
  }

  if(isDefined(var_1) && _func_0107(var_0.knockdownzombies) && scripts\cp\utility::_id_88B7(var_0.knockdownzombies, var_1) && istrue(var_1.isknockeddown) && var_0 _meth_8575("healingAura") == "active" && var_0 _id_0766::getcurrentsuperlevel() >= 1) {
    var_11 = setaebit(var_11, 59);
  }

  var_22 = getzonekillbitfield(var_0);
  var_23 = getcovenantkillbitfield(var_2, var_0, var_1, var_3, var_4);

  if(level scripts\engine\utility::_id_5C0C("start_rbz_exfil") || level scripts\engine\utility::_id_5C0C("start_objective_exfil")) {
    var_11 = setaebit(var_11, 58);
  }

  if(isDefined(var_0.killswithoutgettinghit_ar) && var_8 == 1) {
    var_0.killswithoutgettinghit_ar++;

    if(var_0.killswithoutgettinghit_ar % 20 == 0) {
      var_11 = setaebit(var_11, 63);
    }
  } else
    var_0.killswithoutgettinghit_ar = 0;

  if(istrue(var_1.b_slow_by_gas)) {
    var_10 = setaebit(var_10, 9);
  }

  var_0 reportchallengeuserevent("144115188075856011", [252, "CP", 1, var_5, 28, var_6, 18, var_7, 16, var_8, 17, var_9, 14, var_10, 13, var_11, 15, var_12, 41, var_16, 43, var_17, 42, var_18, 44, var_14, 48, var_19, 51, var_23, 52, var_22]);
}

createassistchallengeevent(var_0, var_1, var_2, var_3, var_4) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_5 = getweaponlootid(var_3);
  var_6 = getweaponpaplevel(var_0, var_3);
  var_7 = getzombietype(var_1);
  var_8 = getaeweaponclass(var_3, var_4);
  var_9 = getkillbitfield(var_2, var_4);
  var_10 = getzmeliminationbitfield(var_2);
  var_11 = getelimbitfield(var_2);
  var_12 = getweaponattachmentids(var_3);

  if(!istrue(var_0.b_finish_1000_eliminations)) {
    if(!isDefined(var_0.eliminationcounts)) {
      var_0.eliminationcounts = 0;
    }

    if(var_0.eliminationcounts < 1000) {
      var_0.eliminationcounts++;
    } else {
      var_9 = setaebit(var_9, 34);
      var_0.b_finish_1000_eliminations = 1;
    }
  }

  if(!istrue(var_0.b_finish_500_eliminations)) {
    if(!isDefined(var_0.eliminationcounts)) {
      var_0.eliminationcounts = 0;
    }

    if(var_0.eliminationcounts < 500) {
      var_0.eliminationcounts++;
    } else {
      var_11 = setaebit(var_11, 10);
      var_0.b_finish_500_eliminations = 1;
    }
  }

  var_13 = scripts\engine\utility::_id_1BAB(var_12, "");

  if(!isDefined(var_13)) {
    var_11 = setaebit(var_11, 2);
  }

  if(getdvarint("#x36ca14263dbaa1beb") == 1 && isPlayer(var_0)) {
    var_0.pistol_kill_count = scripts\cp\utility::_id_459B(var_0.pistol_kill_count, 0);
    var_0.pistol_kill_count++;

    if(var_0.pistol_kill_count >= 500 && !istrue(var_0.b_finish_pistol_500_kill)) {
      var_0.b_finish_pistol_500_kill = 1;
      var_11 = setaebit(var_11, 7);
    }
  }

  if(getdvarint("#x36ca14263dbaa1beb") == 1 && isPlayer(var_0) && isDefined(var_0 _meth_815A()) && level scripts\engine\utility::_id_5C00("zipline_moving")) {
    var_11 = setaebit(var_11, 8);
  }

  if(_func_0107(var_0.a_hit_trickers) && !scripts\cp\utility::_id_88B7(var_0.a_hit_trickers, var_1) && var_7 == 3) {
    var_9 = setaebit(var_9, 57);
  }

  if(level scripts\engine\utility::_id_5C0C("start_rbz_exfil") || level scripts\engine\utility::_id_5C0C("start_objective_exfil")) {
    var_9 = setaebit(var_9, 58);
  }

  if(_func_0107(var_0.a_wall_buy_weapons) && scripts\cp\utility::_id_88B7(var_0.a_wall_buy_weapons, var_3)) {
    var_10 = setaebit(var_10, 19);
  }

  var_14 = getzonekillbitfield(var_0);
  var_15 = getcovenantkillbitfield(var_2, var_0, var_1, var_3, var_4);
  var_0 reportchallengeuserevent("144115188075856013", [252, "CP", 1, var_5, 28, var_6, 18, var_7, 16, var_8, 17, var_10, 14, var_11, 13, var_9, 51, var_15, 52, var_14]);
}

getweaponattachmentids(var_0) {
  var_1 = ["optic", "undermount", "reargrip", "muzzle", "magazine", "backpiece", "frontpiece", "trigger", "gunperk"];
  var_2 = 7;
  var_3 = 6;
  var_4 = scripts\engine\utility::ter_op(var_0.classname == "pistol", var_3, var_2);
  var_5 = [];

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5[var_6] = "";
  }

  if(isDefined(var_0) && isDefined(var_0._id_0070)) {
    var_6 = 0;
    var_7 = scripts\cp\utility::_id_69D8(var_0.basename);
    var_8 = _func_0222("mp/statstable.csv", 5, var_7, 4);

    foreach(var_10 in var_0._id_0070) {
      var_11 = scripts\cp\utility::_id_1DA5(var_10);
      var_12 = _func_0222("mp/attachmenttable.csv", 5, var_11, 11);

      if(issubstr(var_11, "zm_")) {
        var_11 = strtok(var_11, "_")[1];
      }

      if(_id_1D9B(var_0, var_11) || var_12 != "") {
        var_5[var_6] = _func_0222("loot/" + var_8 + "_attachment_ids.csv", 1, var_11, 0);
        var_6++;
      }

      if(isDefined(level.activeattachmentoverrides) && isDefined(level.activeattachmentoverrides[var_10]) && _id_1D9B(var_0, level.activeattachmentoverrides[var_10])) {
        var_5[var_6] = _func_0222("loot/" + var_8 + "_attachment_ids.csv", 1, level.activeattachmentoverrides[var_10], 0);
        var_6++;
      }
    }
  }

  return var_5;
}

_id_1D9B(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponrootname(var_0);
  return _id_1D9C(var_2, var_1);
}

_id_1D9C(var_0, var_1) {
  var_2 = level._id_10D64[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

getweaponlootid(var_0) {
  var_1 = _id_0728::_id_6A14(var_0);

  if(isDefined(var_1)) {
    return int(_func_0222("loot/equipment_ids.csv", 1, var_1, 0));
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::_id_69D8(var_0.basename);
    var_3 = _func_0222("mp/statstable.csv", 5, var_2, 4);
    var_4 = var_3 + "_variant_0";
    return int(_func_0222("loot/weapon_ids.csv", 9, var_4, 0));
  }

  return 0;
}

getweaponpaplevel(var_0, var_1) {
  if(isDefined(var_1)) {
    return var_0[[level._id_6E79]](var_1);
  }

  return 0;
}

getaeweaponclass(var_0, var_1) {
  if(isDefined(var_1) && var_1 == "MOD_MELEE") {
    var_2 = scripts\cp\utility::getweaponrootname(var_0);

    if(var_2 == "s4_me_rindigoww" || var_2 == "s4_me_axe" || var_2 == "s4_me_icepick" || var_2 == "s4_me_katana" || var_2 == "s4_me_knife" || var_2 == "s4_me_leiomano" || var_2 == "s4_me_pdelta" || var_2 == "s4_me_rindigo" || var_2 == "s4_me_sledgehammer") {
      return 8;
    }
  }

  switch (var_0.classname) {
    case "rifle":
      var_2 = scripts\cp\utility::getweaponrootname(var_0);

      if(var_2 == "s4_me_rindigoww_mp") {
        return 8;
      }

      return 1;
    case "sniper":
      var_2 = scripts\cp\utility::getweaponrootname(var_0);
      var_3 = _func_0222("mp/statstable.csv", 4, var_2, 1);

      if(var_3 == "weapon_dmr") {
        return 5;
      } else {
        return 4;
      }
    case "mg":
      return 3;
    case "smg":
      return 2;
    case "spread":
      return 6;
    case "pistol":
      return 7;
    case "grenade":
      if(var_0.basename == "s4_la_mkilo1_mp") {
        return 9;
      }

      return 0;
    case "rocketlauncher":
      return 9;
    default:
      return 0;
  }
}

getaeweaponclass_no_damage_type(var_0) {
  var_1 = scripts\cp\utility::getweaponrootname(var_0);

  if(var_1 == "s4_me_rindigoww" || var_1 == "s4_me_axe" || var_1 == "s4_me_icepick" || var_1 == "s4_me_katana" || var_1 == "s4_me_knife" || var_1 == "s4_me_leiomano" || var_1 == "s4_me_pdelta" || var_1 == "s4_me_rindigo" || var_1 == "s4_me_sledgehammer") {
    return 8;
  }

  switch (var_0.classname) {
    case "rifle":
      var_1 = scripts\cp\utility::getweaponrootname(var_0);

      if(var_1 == "s4_me_rindigoww_mp") {
        return 8;
      }

      return 1;
    case "sniper":
      var_1 = scripts\cp\utility::getweaponrootname(var_0);
      var_2 = _func_0222("mp/statstable.csv", 4, var_1, 1);

      if(var_2 == "weapon_dmr") {
        return 5;
      } else {
        return 4;
      }
    case "mg":
      return 3;
    case "smg":
      return 2;
    case "spread":
      return 6;
    case "pistol":
      return 7;
    case "grenade":
      if(var_0.basename == "s4_la_mkilo1_mp") {
        return 9;
      }

      return 0;
    case "rocketlauncher":
      return 9;
    default:
      return 0;
  }
}

getzombietype(var_0) {
  if(isDefined(var_0._id_1210)) {
    switch (var_0._id_1210) {
      case "actor_enemy_zombie_screamer_cp":
        return 1;
      case "actor_enemy_zombie_juggernaut_cp":
        return 2;
      case "actor_enemy_zombie_trickster_cp":
        if(isDefined(level.ai_saraxis_echo) && var_0 == level.ai_saraxis_echo) {
          return 0;
        }

        return 3;
      default:
        return 0;
    }
  }

  return 0;
}

getzmeliminationbitfield(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in var_0) {
    switch (var_4) {
      case "enemy_slowed":
        var_1 = setaebit(var_1, 0);
        break;
      case "field_upgrade_kill":
        var_1 = setaebit(var_1, 1);
        break;
      case "covenant_kill":
        var_1 = setaebit(var_1, 10);
        break;
      case "rapid_kill":
        var_1 = setaebit(var_1, 12);
        break;
      case "rapid_critical_kill":
        var_1 = setaebit(var_1, 13);
        break;
      case "consecutive_kill":
        var_1 = setaebit(var_1, 14);
        break;
      case "magic_box_weapon":
        var_1 = setaebit(var_1, 2);
        break;
      case "chest_weapon":
        var_1 = setaebit(var_1, 4);
        break;
      case "has_damage_perk":
        var_1 = setaebit(var_1, 5);
        break;
      case "brain_rot_kill":
        var_1 = setaebit(var_1, 6);
        break;
      case "screamer_kill":
        var_1 = setaebit(var_1, 7);
        break;
      case "splatterfest_kill":
        var_1 = setaebit(var_1, 8);
        break;
      case "throwing_knife_kill_all_type":
        var_1 = setaebit(var_1, 9);
        break;
      case "brain_rot_juggernaut_kill":
        var_1 = setaebit(var_1, 11);
        break;
      case "covenant_deadshot_kill":
        var_1 = setaebit(var_1, 16);
        break;
    }
  }

  return var_1;
}

getelimbitfield(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in var_0) {
    switch (var_4) {
      case "full_attachments":
        var_1 = setaebit(var_1, 2);
        break;
    }
  }

  return var_1;
}

getkillbitfield(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    switch (var_5) {
      case "critical_kill":
        var_2 = setaebit(var_2, 0);
        break;
      case "ads":
        var_2 = setaebit(var_2, 2);
        break;
      case "hipfire":
        var_2 = setaebit(var_2, 3);
        break;
      case "mounted":
        var_2 = setaebit(var_2, 6);
        break;
      case "crouch":
        var_2 = setaebit(var_2, 7);
        break;
      case "prone":
        var_2 = setaebit(var_2, 8);
        break;
      case "moving":
        var_2 = setaebit(var_2, 10);
        break;
      case "longshot":
        var_2 = setaebit(var_2, 4);
        break;
      case "pointblank":
        var_2 = setaebit(var_2, 9);
        break;
      case "equipment_kill":
        var_2 = setaebit(var_2, 28);
        break;
      case "recent_stim":
        var_2 = setaebit(var_2, 23);
        break;
      case "reload_kill":
        var_2 = setaebit(var_2, 24);
        break;
      case "low_health":
        var_2 = setaebit(var_2, 26);
        break;
      case "quickscope":
        var_2 = setaebit(var_2, 13);
        break;
      case "weapon_change_kill":
        var_2 = setaebit(var_2, 14);
        break;
      case "primary_weapon_kill":
        var_2 = setaebit(var_2, 33);
        break;
      case "using_wonder_weapon":
        var_2 = setaebit(var_2, 35);
        break;
      case "using_warmachine":
        var_2 = setaebit(var_2, 37);
        break;
      case "using_deathmachine":
        var_2 = setaebit(var_2, 38);
        break;
      case "frozen_zombie_kill":
        var_2 = setaebit(var_2, 39);
        break;
      case "in_ring_of_fire_zombie_kill":
        var_2 = setaebit(var_2, 43);
        break;
    }
  }

  if(var_1 == "MOD_MELEE") {
    var_2 = setaebit(var_2, 16);
  }

  return var_2;
}

getopticclass(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_0070)) {
    foreach(var_2 in var_0._id_0070) {
      var_3 = scripts\cp\utility::_id_1DA5(var_2);
      var_4 = _func_0222("mp/attachmenttable.csv", 5, var_3, 2);

      if(var_4 == "optic") {
        var_5 = _func_0222("mp/reticlecategorytable.csv", 1, var_3, 2);

        if(isDefined(var_5)) {
          switch (var_5) {
            case "reflex":
              return 1;
            case "lens":
              return 5;
            case "holo":
              return 2;
            case "acog":
              return 3;
            case "hybrid":
              return 6;
            case "scope":
              return 4;
          }
        }
      }
    }
  }

  return 0;
}

getmeansofdeathid(var_0) {
  if(isDefined(level.meansofdeathids[var_0])) {
    return level.meansofdeathids[var_0];
  } else {
    return level.meansofdeathids["MOD_UNKNOWN"];
  }
}

createignitezombieevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;

  if(var_1 scripts\cp\zombies\zombie_slow::is_slowed()) {
    var_2 = setaebit(var_2, 2);
  }

  if(var_1 scripts\aitypes\zombie_common\stun::is_stunned()) {
    var_2 = setaebit(var_2, 1);
  }

  if(istrue(var_1.is_distracted)) {
    var_2 = setaebit(var_2, 3);
  }

  var_0 reportchallengeuserevent("144115188075856025", [252, "CP", 38, var_2]);
}

createcraftequipmentevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = int(_func_0222("loot/equipment_ids.csv", 1, var_1, 0));
  var_0 reportchallengeuserevent("144115188075856019", [252, "CP", 23, var_2]);
}

createcraftarmorevent(var_0, var_1, var_2) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856018", [252, "CP", 21, var_1, 22, var_2]);
}

createdestroycrystalevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856022", [252, "CP"]);
}

createpurchasecovenantevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = var_0._id_3DC0[var_1.covenant_index];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2._id_3DBF[var_1.level_index];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = 0;

  if(isDefined(var_2.lootreference)) {
    var_4 = int(_func_0222("loot/covenant_ids.csv", 0, var_2.lootreference, 1));
  }

  var_0 reportchallengeuserevent("144115188075856020", [252, "CP", 24, var_4, 39, scripts\cp\utility::_id_459B(var_3._id_C040, 0)]);
}

createareaunlockevent(var_0, var_1, var_2) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856016", [252, "CP", 16, var_1, 17, var_2]);
}

createexfilevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_1 = scripts\cp\utility::_id_6871();
  var_2 = scripts\cp\utility::_id_459B(var_0._id_1B3D, 0);
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0._id_BE30)) {
    foreach(var_7 in var_0._id_BE30) {
      var_8 = var_0 _id_0717::get_covenant(var_7.covenant_index);

      if(isDefined(var_8)) {
        var_9 = scripts\cp\utility::_id_459B(var_8._id_3DBF[var_7.level_index]._id_C040, 0);

        if(var_9 == 2) {
          var_3++;
        }

        if(istrue(var_8.boostsdamage)) {
          var_4++;
        }

        var_5++;
      }
    }
  }

  var_11 = 0;

  if(var_0._id_9C09 != 0) {
    var_11 = var_0._id_1B26 == var_0._id_9C09;
  }

  var_12 = 0;

  if(isDefined(var_0 _id_0766::getcurrentsuperlevel())) {
    var_12 = var_0 _id_0766::getcurrentsuperlevel();
  }

  var_0 reportchallengeuserevent("144115188075856015", [252, "CP", 27, var_1, 21, var_2, 34, var_3, 35, var_4, 49, var_11, 53, var_5, 48, var_12]);
}

createhealevent(var_0, var_1, var_2) {
  if(!var_0 challengesenabledforplayer() || var_1 == 0) {
    return;
  }
  var_3 = var_0.health == var_0.maxhealth;
  var_4 = 0;

  if(isDefined(var_2)) {
    switch (var_2) {
      case "bloodlust":
        var_4 = 1;
        break;
    }
  }

  var_0 reportchallengeuserevent("144115188075856021", [252, "CP", 36, var_1, 37, var_3, 38, var_4]);
}

createmaxperksevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;

  if(isDefined(var_0._id_11086)) {
    foreach(var_4, var_3 in var_0._id_11086) {
      if(var_0 scripts\cp\zombies\perks\zm_perks::is_perk_max_level(var_4)) {
        var_1++;
      }
    }
  }

  var_0 reportchallengeuserevent("144115188075856023", [252, "CP", 30, var_1]);
}

createperkgainevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;

  switch (var_1) {
    case "zm_perk_hp":
      var_2 = 0;
      break;
    case "zm_perk_critical_damage":
      var_2 = 1;
      break;
    case "zm_perk_reload_speed":
      var_2 = 2;
      break;
    case "zm_perk_hp_regen_speed":
      var_2 = 3;
      break;
    case "zm_perk_move_speed":
      var_2 = 4;
      break;
  }

  var_3 = var_0 scripts\cp\zombies\perks\zm_perks::get_perk_level(var_1);
  var_4 = _id_074D::get_perk_machine_activations(var_0, var_1);
  var_5 = 0;

  if(isDefined(var_0.perk_machine_activate_time)) {
    var_6 = gettime();

    foreach(var_8 in var_0.perk_machine_activate_time) {
      if(var_6 - var_8 <= 60000) {
        var_5++;
      }
    }
  }

  var_0.n_drink_perk_count = scripts\cp\utility::_id_459B(var_0.n_drink_perk_count, 0);
  var_0.n_drink_perk_count++;
  var_10 = 0;

  if(!istrue(var_0.b_finish_drink_10_times) && var_0.n_drink_perk_count % 10 == 0) {
    var_10 = setaebit(var_10, 0);
    var_0.b_finish_drink_10_times = 1;
  }

  var_0 reportchallengeuserevent("144115188075856017", [252, "CP", 18, var_2, 19, var_3, 20, var_4, 29, var_5, 54, var_10]);
}

createoneshotmultikillevent(var_0, var_1, var_2, var_3) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_4 = getweaponlootid(var_1);
  var_5 = scripts\cp\utility::_id_459B(var_1.basename, "");
  var_6 = _id_0728::_id_6A14(var_1);
  var_7 = 0;

  if(isDefined(var_6)) {
    var_7 = setaebit(var_7, 0);
  }

  if(var_5 == "s4_splatterfest_zm") {
    var_7 = setaebit(var_7, 2);
  }

  if(var_5 == "s4_brain_rot_explosion_zm") {
    var_7 = setaebit(var_7, 1);
  }

  var_8 = getmeansofdeathid(var_3);
  var_0 reportchallengeuserevent("144115188075856024", [252, "CP", 1, var_4, 2, var_2, 31, var_7, 44, var_8]);
}

createobjectivecompleteevent(var_0, var_1, var_2) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_3 = 0;

  switch (var_1._id_3BE5) {
    case "holdout":
      var_3 = 10;
      break;
    case "soul_capture":
      var_3 = 13;
      break;
    case "orb_follow":
      var_3 = 14;
      break;
    case "domination":
      var_3 = 16;
      break;
    case "forever_blitz":
      var_3 = 17;
      break;
    case "assault":
      var_3 = 15;
      break;
  }

  var_4 = 1;

  switch (var_2) {
    case "destination_royal_hotel":
      var_4 = 2;
      break;
    case "destination_tonga":
      var_4 = 4;
      break;
    case "destination_sumpf":
      var_4 = 3;
      break;
  }

  var_5 = scripts\cp\utility::_id_6871();
  var_6 = 0;

  if(istrue(var_0._id_0313)) {
    var_6 = setaebit(var_6, 0);
  }

  if(istrue(var_0.nomanualreloads)) {
    var_6 = setaebit(var_6, 2);
  }

  if(!istrue(var_0.completed_all_objectives_all_locations)) {
    var_7 = ["holdout", "soul_capture", "orb_follow", "forever_blitz", "assault"];
    var_8 = ["destination_royal_hotel", "destination_tonga", "destination_sumpf"];

    if(isDefined(var_0.completedobjectivetypes) && isDefined(var_0.completedobjectivelocations)) {
      var_9 = 1;

      foreach(var_11 in var_7) {
        if(scripts\cp\utility::_id_459B(var_0.completedobjectivetypes[var_11], 0) == 0) {
          var_9 = 0;
          break;
        }
      }

      if(var_9) {
        foreach(var_2 in var_8) {
          if(scripts\cp\utility::_id_459B(var_0.completedobjectivelocations[var_2], 0) == 0) {
            var_9 = 0;
            break;
          }
        }
      }

      if(var_9) {
        var_6 = setaebit(var_6, 1);
        var_0.completed_all_objectives_all_locations = 1;
      }
    }
  }

  if(!istrue(var_0.b_completed_3_objectives_in_locations)) {
    var_8 = ["destination_royal_hotel", "destination_tonga", "destination_sumpf"];

    foreach(var_2 in var_8) {
      if(isPlayer(var_0) && _func_0107(var_0.completedobjectiveinfo) && _func_0107(var_0.completedobjectiveinfo[var_2]) && var_0.completedobjectiveinfo[var_2].size >= 3) {
        var_6 = setaebit(var_6, 6);
        var_0.b_completed_3_objectives_in_locations = 1;
        break;
      }
    }
  }

  var_17 = 0;

  if(isDefined(var_0._id_BE30)) {
    foreach(var_19 in var_0._id_BE30) {
      var_20 = var_0 _id_0717::get_covenant(var_19.covenant_index);

      if(isDefined(var_20) && istrue(var_20.boostsdamage)) {
        var_17++;
      }
    }
  }

  var_22 = 0;

  if(var_1._id_3BE5 == "assault") {
    foreach(var_24 in var_1.ritual_sites) {
      if(istrue(var_24.is_destroyed)) {
        var_22 = 0;
        break;
      } else
        var_22 = 1;
    }
  }

  if(!istrue(var_0.b_getting_hit_in_objective)) {
    var_6 = setaebit(var_6, 3);
  }

  if(var_1._id_3BE5 == "assault" && istrue(level.b_perfect_finish_assault)) {
    var_6 = setaebit(var_6, 4);
  }

  var_26 = 0;

  if(var_1._id_3BE5 == "domination") {
    if(isDefined(var_0.n_capture_runes)) {
      var_26 = var_0.n_capture_runes;
    }
  }

  var_0 reportchallengeuserevent("144115188075856014", [252, "CP", 26, var_3, 25, var_4, 27, var_5, 33, var_6, 35, var_17, 47, var_22, 50, var_26]);
}

createopenportalevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856047", [252, "CP"]);
}

createopenchestevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856048", [252, "CP"]);
}

createmedalevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;

  switch (var_1) {
    case "multikillstreak_5":
      var_2 = 0;
      break;
    case "multikillstreak_10":
      var_2 = 1;
      break;
    case "multikillstreak_15":
      var_2 = 2;
      break;
    case "multikillstreak_20":
      var_2 = 3;
      break;
    case "multikillstreak_25":
      var_2 = 4;
      break;
    case "crit_finisher_multikill":
      var_2 = 5;
      break;
    case "oneshot_multikill":
      var_2 = 6;
      break;
    case "oneshot_explosive_multikill":
      var_2 = 7;
      break;
    case "melee_weapon_multikill":
      var_2 = 8;
      break;
    case "killstreak_without_getting_hit":
      var_2 = 9;
      break;
    default:
      return;
  }

  var_3 = var_0 getcurrentweapon();
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = getaeweaponclass_no_damage_type(var_3);
  }

  var_0 reportchallengeuserevent("144115188075856032", [252, "CP", 40, var_2, 16, var_4]);
}

createabsorbdamageevent(var_0, var_1, var_2, var_3) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_4 = undefined;
  var_5 = var_0 getweaponslistprimaries();

  foreach(var_7 in var_5) {
    if(scripts\cp\utility::_id_8A09(var_7)) {
      var_4 = var_7;
      break;
    }
  }

  var_9 = 0;

  if(isDefined(var_4)) {
    var_9 = getweaponlootid(var_4);
  }

  var_10 = getzombietype(var_1);
  var_11 = getmeansofdeathid(var_2);
  var_0 reportchallengeuserevent("144115188075856038", [252, "CP", 1, var_9, 18, var_10, 44, var_11, 45, var_3]);
}

createupgradeartifactsevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;

  if(isDefined(var_0 _id_0766::getcurrentsuperlevel())) {
    var_1 = var_0 _id_0766::getcurrentsuperlevel();
  }

  var_0 reportchallengeuserevent("144115188075856042", [252, "CP", 48, var_1]);
}

createupdatecovenantsevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;

  if(isDefined(var_0._id_BE30)) {
    foreach(var_4 in var_0._id_BE30) {
      var_5 = var_0 _id_0717::get_covenant(var_4.covenant_index);

      if(isDefined(var_5)) {
        var_6 = scripts\cp\utility::_id_459B(var_5._id_3DBF[var_4.level_index]._id_C040, 0);

        if(var_6 == 2) {
          var_2++;
        }
      }
    }
  }

  if(!istrue(self.b_finished_purchase_convenants) && var_2 == 3) {
    self.b_finished_purchase_convenants = 1;
  } else {
    return;
  }

  var_0 reportchallengeuserevent("144115188075856043", [252, "CP"]);
}

createmonkeybombdivertevent(var_0, var_1) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_2 = getzombietype(var_1);
  var_0 reportchallengeuserevent("144115188075856044", [252, "CP", 18, var_2]);
}

createvoidroundcompeletedevent() {
  var_0 = 0;

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(!var_2 challengesenabledforplayer()) {
      return;
    }
    var_0 = setaebit(var_0, 0);
    var_2 reportchallengeuserevent("144115188075856045", [46, var_0]);
  }
}

createroundcompeletedevent() {
  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    if(!var_1 challengesenabledforplayer()) {
      return;
    }
    var_2 = level._id_11049;
    var_3 = 0;

    if(_func_0107(var_1._id_11086)) {
      var_3 = var_1._id_11086.size;
    }

    var_4 = 0;

    if(level.mapname == "cp_zm_oasis") {
      var_4 = setaebit(var_4, 1);
    }

    if(level.mapname == "cp_sumpf") {
      var_4 = setaebit(var_4, 0);
    }

    var_1 reportchallengeuserevent("144115188075856054", [27, var_2, 30, var_3, 55, var_4]);
  }
}

createfloggerkillevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856055", [252, "CP"]);
}

createelectrictrapkillevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_0 reportchallengeuserevent("144115188075856057", [252, "CP"]);
}

createfinishquestevent(var_0) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;

  if(level.mapname == "cp_zm_oasis") {
    var_1 = setaebit(var_1, 5);
  }

  if(level.mapname == "cp_sumpf") {
    var_1 = setaebit(var_1, 7);
  }

  var_0 reportchallengeuserevent("144115188075856056", [252, "CP", 33, var_1]);
}

getzonekillbitfield(var_0) {
  if(getdvarint("#x3dee089cb49164e4e", 0) != 1) {
    return 0;
  }

  var_1 = 0;
  var_2 = var_0 scripts\cp\zone_manager::_id_642F();

  if(isPlayer(var_0) && isDefined(var_2)) {
    if(!isDefined(var_2.script_zone_name)) {
      return 0;
    }

    switch (var_2.script_zone_name) {
      case "fishing_hut_building_zone":
        var_1 = setaebit(var_1, 0);
        break;
      case "comm_room_building_zone":
        var_1 = setaebit(var_1, 1);
        break;
    }
  }

  if(getdvarint("#x36ca14263dbaa1beb") == 1 && level.mapname == "cp_sumpf") {
    var_1 = setaebit(var_1, 2);
  }

  return var_1;
}

getcovenantkillbitfield(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(istrue(var_0["critical_kill_with_dead_blow"])) {
    var_5 = setaebit(var_5, 0);
  }

  if(scripts\cp\covenants\cp_swift_vengeance::is_swift_vengeance_active(var_1, var_4, var_3)) {
    var_5 = setaebit(var_5, 1);
  }

  if(var_3.basename == "s4_splatterfest_zm" && var_4 == "MOD_EXPLOSIVE") {
    var_5 = setaebit(var_5, 2);
  }

  if(isPlayer(var_1) && var_1 _meth_8575("aetherShroud") == "active") {
    var_5 = setaebit(var_5, 3);
  }

  if(scripts\cp\covenants\cull_the_weak::is_cull_the_weak_active(var_1, var_2)) {
    var_5 = setaebit(var_5, 4);
  }

  if(scripts\cp\covenants\bloodlust::is_bloodlust_active(var_1, var_4)) {
    var_5 = setaebit(var_5, 5);
  }

  if(scripts\cp\covenants\cp_covenants::is_unholy_ground_active(var_1)) {
    var_5 = setaebit(var_5, 6);
  }

  if(scripts\cp\covenants\cp_dead_wire::is_dead_wire_active(var_2, var_1)) {
    var_5 = setaebit(var_5, 7);
  }

  if(var_1 _id_0990::_id_860D()) {
    var_5 = setaebit(var_5, 8);
  }

  var_6 = scripts\cp\utility::getweaponrootname(var_3);

  if(isPlayer(var_1) && isDefined(var_6) && var_6 == "s4_me_rindigoww" && var_4 == "MOD_EXPLOSIVE") {
    var_1.ww_shield_slam_kill_count = scripts\cp\utility::_id_459B(var_1.ww_shield_slam_kill_count, 0);
    var_1.ww_shield_slam_kill_count++;
    var_1 thread ww_rapid_kill_reset();

    if(var_1.ww_shield_slam_kill_count % 20 == 0) {
      var_5 = setaebit(var_5, 9);
      var_1.ww_shield_slam_kill_count = 0;
    }
  }

  if(isPlayer(var_1) && isDefined(var_3.basename) && var_3.basename == "s4_pi_raygun_mp") {
    var_1.ray_gun_kill_count = scripts\cp\utility::_id_459B(var_1.ray_gun_kill_count, 0);
    var_1.ray_gun_kill_count++;
    var_1 thread ray_gun_rapid_kill_reset();

    if(var_1.ray_gun_kill_count % 5 == 0) {
      var_5 = setaebit(var_5, 10);
      var_1.ray_gun_kill_count = 0;
    }
  }

  return var_5;
}

ww_rapid_kill_reset() {
  self notify("ww_rapid_kill_reset");
  self endon("ww_rapid_kill_reset");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 1;

  if(isDefined(self.ww_shield_slam_kill_count)) {
    self.ww_shield_slam_kill_count = 0;
  }
}

ray_gun_rapid_kill_reset() {
  self notify("ray_gun_rapid_kill_reset");
  self endon("ray_gun_rapid_kill_reset");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 1;

  if(isDefined(self.ray_gun_kill_count)) {
    self.ray_gun_kill_count = 0;
  }
}