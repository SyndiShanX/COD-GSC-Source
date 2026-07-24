/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_util.gsc
**************************************************/

_id_10690(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_2 in scripts\engine\utility::getStructArray("corpse_struct", "targetname"))
    var_2 _id_1068F();

    return;
  }

  foreach(var_2 in scripts\engine\utility::getStructArray("corpse_struct", "targetname")) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0)
      var_2 _id_1068F();
  }
}

_id_1068F() {
  getspawner("corpse_worker", "targetname").count = 100;

  if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "office_fight") {
    var_0 = _id_B285();
    var_0._id_1FBB = "script_model_corpse";
    var_0 scripts\sp\utility::_id_23B7();
    scripts\sp\utility::_id_16AE(var_0, self.script_noteworthy);
  } else {
    if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "base_entrance")
      var_0 = scripts\sp\utility::_id_107EA("corpse_security", 1);
    else
      var_0 = scripts\sp\utility::_id_107EA("corpse_worker", 1);

    var_0._id_1FBB = "generic";
    var_0 scripts\sp\utility::_id_86E4();
  }

  scripts\sp\anim::_id_1EC3(var_0, self.animation);

  if(self.script_noteworthy == "base_exterior") {
    var_0 linkTo(level._id_CC5B);
    return;
  } else if(self.script_noteworthy == "office_fight") {
    return;
  }
  wait 0.05;
  thread scripts\sp\maps\europa\europa_anim::_id_C7C7(var_0);

  if(isDefined(self.script_parameters)) {
    wait 0.05;
    var_0 startragdoll();
  }
}

_id_8243() {
  var_0 = [];
  var_0[var_0.size] = "head_bg_var_head_bg_male_06_head_sc_lee_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_01_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_05_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_male_06_head_male_bc_04_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_male_07_head_male_bc_03_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_male_07_head_male_bc_04_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_male_07_head_male_bc_05_blast_damage";
  var_0[var_0.size] = "head_bg_var_head_bg_male_07_head_sc_engineering_mate_blast_damage";
  return var_0;
}

_id_B285() {
  var_0 = spawn("script_model", self.origin);
  var_1 = undefined;
  var_2 = undefined;

  if(self.script_noteworthy == "base_exterior") {
    var_3 = ["body_un_moon_guards_loadout_a", "body_un_moon_guards_loadout_b"];
    var_1 = ::_id_810D;
    var_2 = "europa_security";
  } else {
    var_3 = ["body_civ_facility_worker_lt", "body_civ_facility_worker_drk"];
    var_1 = ::_id_8243;
    var_2 = "europa_worker";
  }

  var_0 scripts\code\character::setmodelfromarray(var_3);
  var_0 scripts\code\character::attachhead(var_2, [[var_1]]());
  return var_0;
}

_id_810D() {
  var_0[0] = "head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage";
  var_0[1] = "head_bg_var_head_bg_engineering_mate_head_male_bc_01_blast_damage";
  var_0[2] = "head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage";
  var_0[3] = "head_bg_var_head_bg_engineering_mate_head_male_bc_03_blast_damage";
  var_0[4] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_blast_damage";
  var_0[5] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_beard_blast_damage";
  var_0[6] = "head_bg_var_head_bg_engineering_mate_head_male_bc_05_blast_damage";
  var_0[7] = "head_bg_var_head_bg_engineering_mate_head_male_bc_06_blast_damage";
  var_0[8] = "head_bg_var_head_bg_engineering_mate_head_male_bc_07_blast_damage";
  var_0[9] = "head_bg_var_head_bg_engineering_mate_head_sc_lee_blast_damage";
  var_0[10] = "head_bg_male_06_blast_damage";
  var_0[11] = "head_bg_var_head_bg_male_06_head_male_bc_04_blast_damage";
  var_0[12] = "head_bg_var_head_bg_male_06_head_male_bc_04_beard_blast_damage";
  var_0[13] = "head_bg_var_head_bg_male_06_head_male_bc_05_blast_damage";
  var_0[14] = "head_bg_var_head_bg_male_06_head_sc_lee_blast_damage";
  var_0[15] = "head_bg_male_07_blast_damage";
  var_0[16] = "head_bg_var_head_bg_male_07_head_male_bc_03_blast_damage";
  var_0[17] = "head_bg_var_head_bg_male_07_head_male_bc_04_blast_damage";
  var_0[18] = "head_bg_var_head_bg_male_07_head_male_bc_04_beard_blast_damage";
  var_0[19] = "head_bg_var_head_bg_male_07_head_male_bc_05_blast_damage";
  var_0[20] = "head_bg_var_head_bg_male_07_head_male_bc_06_blast_damage";
  var_0[21] = "head_bg_var_head_bg_male_07_head_sc_engineering_mate_blast_damage";
  var_0[22] = "head_bg_var_head_bg_male_07_head_sc_lee_blast_damage";
  return var_0;
}

toggle_cockpit_lights(var_0) {
  var_1 = getEntArray("base_reveal_vista", "targetname");

  if(var_0)
    scripts\engine\utility::array_call(var_1, ::show);
  else
    scripts\engine\utility::array_call(var_1, ::hide);
}

_id_100CA(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(getdvarint("debug_europa"))
    iprintln("showing " + var_1.size + "brushes with targetname " + var_0);

  foreach(var_3 in var_1)
  var_3 show();
}

_id_8E72(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(getdvarint("debug_europa"))
    iprintln("Hiding " + var_1.size + "brushes with targetname " + var_0);

  foreach(var_3 in var_1)
  var_3 hide();
}

_id_D2DC(var_0) {
  level endon("stop_player_stay_behind");
  var_1 = scripts\engine\utility::ter_op(!isDefined(var_0), 22500, var_0 * var_0);
  var_2 = 0.5;
  var_3 = 0.7;

  if(!isDefined(level.player._id_BCF5))
    level.player._id_BCF5 = 1;

  for(;;) {
    var_4 = distancesquared(level.player.origin, self.origin);
    var_5 = scripts\sp\math::_id_C097(0, var_1, var_4);
    var_5 = clamp(var_5, var_3, 1);
    var_6 = var_5 - level.player._id_BCF5;
    var_7 = var_6 * var_2;
    var_8 = level.player._id_BCF5 + var_7;
    level.player setmovespeedscale(var_8);
    level.player._id_BCF5 = var_8;
    wait 0.05;
  }
}

_id_10181() {
  setsaveddvar("player_sprintspeedscale", 1.4);
  level notify("stop_player_stay_behind");
  thread scripts\sp\utility::_id_2B77(1);
}

_id_D24C(var_0) {
  var_1 = level.player scripts\sp\utility::_id_D08C("ges_radio");

  if(var_1) {
    level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
    level.player allowsprint(0);
    wait 0.8;
  }

  _id_48BD(var_0);

  if(var_1) {
    level.player playSound("ges_plr_radio_off");
    level.player stopgestureviewmodel("ges_radio", 1);
    level.player allowsprint(1);
  }
}

_id_134B7(var_0) {
  level.player endon("death");
  var_1 = strtok(var_0, "_");

  switch (var_1[1]) {
    case "sip":
      level._id_EBBB scripts\sp\utility::_id_10346(var_0);
      break;
    case "tee":
      level._id_EBBC scripts\sp\utility::_id_10346(var_0);
      break;
    case "plr":
      if(isalive(level.player))
        level.player scripts\sp\utility::_id_1034D(var_0);

      break;
    case "war":
    case "cmp":
    case "rpr":
      level.player scripts\sp\utility::play_sound_on_entity(var_0);
      break;
    case "default":
      break;
  }
}

_id_48BD(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  foreach(var_3 in var_0) {
    _id_134B7(var_3);
    wait(randomfloatrange(0.1, 0.15));
  }
}

_id_8E46(var_0) {
  level._id_EBBB thread _id_8E34(var_0);
  level._id_EBBC thread _id_8E34(var_0);
  wait 0.1;
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_13013, var_0);
}

_id_8E34(var_0) {
  if(var_0 && isDefined(self.issoldier)) {
    return;
  }
  if(var_0) {
    if(self == level.player) {
      self.issoldier = 1;
      level.player setviewmodel("viewmodel_un_jackal_pilots_frost");

      if(getdvarint("debug_europa"))
        iprintln("Swapping playerto snow gear");

      return;
    } else {
      self.issoldier = 1;
      var_1 = scripts\engine\utility::ter_op(self == level._id_10214, "body_hero_sipes_frost", "body_hero_t_frost");
      var_2 = scripts\engine\utility::ter_op(self == level._id_10214, "helmet_head_hero_sipes_frost", "head_hero_t_helmet_frost");
      var_3 = "pack_un_jackal_pilots_frost";

      if(getdvarint("debug_europa"))
        iprintln(self._id_1FBB + " swapping to snow gear");
    }
  } else {
    if(!isDefined(self.issoldier)) {
      return;
    }
    if(self == level.player) {
      self.issoldier = undefined;
      level.player setviewmodel("viewmodel_un_jackal_pilots");

      if(getdvarint("debug_europa"))
        iprintln("Swapping player to non-snow gear");

      return;
    } else {
      self.issoldier = undefined;
      var_1 = scripts\engine\utility::ter_op(self == level._id_10214, "body_hero_sipes", "body_hero_t");
      var_2 = scripts\engine\utility::ter_op(self == level._id_10214, "helmet_head_hero_sipes", "head_hero_t_helmet");
      var_3 = "pack_un_jackal_pilots_zerog";

      if(getdvarint("debug_europa"))
        iprintln(self._id_1FBB + " swapping to non-snow gear");
    }
  }

  self setModel(var_1);
  self detach(self.hatmodel);
  self.hatmodel = var_2;
  self attach(self.hatmodel);
  self detach(self._id_A489);
  self._id_A489 = var_3;
  self attach(self._id_A489);
}

_id_13013(var_0, var_1) {
  if(isai(self)) {
    var_2 = scripts\engine\utility::ter_op(var_0 == 1, "iw7_fhr_snow+reflexsmg+silencersmg_snow", "iw7_fhr+reflexsmg+silencersmg");
    scripts\sp\utility::_id_72EC(var_2, "primary");
  } else {
    var_3 = level.player getcurrentprimaryweapon();
    var_4 = issubstr(var_3, "m4");
    var_5 = issubstr(level.player getcurrentweapon(), "alt_");
    var_6 = undefined;
    var_7 = scripts\sp\utility::_id_7D74(1);
    var_8 = 0;

    foreach(var_2 in var_7)
    _id_119C6(var_2, var_0);

    if(!isDefined(var_1)) {
      return;
    }
    if(isDefined(var_1) && !var_1) {
      return;
    }
    var_11 = scripts\sp\utility::_id_7D74(1);

    foreach(var_13 in var_11) {
      if(var_4) {
        if(issubstr(var_13, "m4")) {
          var_6 = var_13;
          break;
        }
      } else if(issubstr(var_13, "fhr")) {
        var_6 = var_13;
        break;
      }
    }

    if(var_5)
      var_6 = "alt_" + var_6;

    level.player switchtoweaponimmediate(var_6);
  }
}

_id_119C6(var_0, var_1) {
  var_2 = strtok(var_0, "+");

  if(var_1) {
    var_3["iw7_m4"] = 1;
    var_3["iw7_fhr"] = 1;
  } else {
    var_3["iw7_m4_snow"] = 1;
    var_3["iw7_fhr_snow"] = 1;
  }

  if(isDefined(var_3[var_2[0]])) {
    var_4 = level.player getammocount(var_0);
    var_5 = level.player getweaponammoclip(var_0);

    if(var_1)
      var_6 = var_2[0] + "_snow";
    else
      var_6 = scripts\engine\utility::ter_op(var_2[0] == "iw7_m4_snow", "iw7_m4", "iw7_fhr");

    if(getdvarint("debug_europa"))
      iprintln("Swapping player weapon from " + var_2[0] + " to " + var_6);

    for(var_7 = 0; var_7 < var_2.size; var_7++) {
      if(var_7 == 0) {
        continue;
      }
      if(issubstr(var_2[var_7], "silencer"))
        var_2[var_7] = modifyblastshieldperk(var_2[var_7], var_1);

      if(issubstr(var_2[var_7], "hybrid"))
        var_2[var_7] = scripts\engine\utility::ter_op(var_1, "hybrid_snow", "hybrid");

      if(issubstr(var_2[var_7], "reflexsmg"))
        var_2[var_7] = scripts\engine\utility::ter_op(var_1, "reflexsmg_snow", "reflexsmg");

      var_6 = var_6 + "+" + var_2[var_7];
    }

    if(level.player hasweapon("alt_" + var_0))
      level.player takeweapon("alt_" + var_0);

    level.player takeweapon(var_0);
    level.player giveweapon(var_6);
    level.player setweaponammoclip(var_6, var_5);
    level.player setweaponammostock(var_6, var_4);
    return var_6;
  }

  return undefined;
}

modifyblastshieldperk(var_0, var_1) {
  if(var_1) {
    if(issubstr(var_0, "smg"))
      var_0 = "silencersmg_snow";
    else
      var_0 = "silencer_snow";
  } else if(issubstr(var_0, "smg"))
    var_0 = "silencersmg";
  else
    var_0 = "silencer";

  return var_0;
}

_id_8CA5() {
  self endon("stop_headtrack_when_close");
  var_0 = squared(60);

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= var_0) {
      thread scripts\sp\utility::_id_7799(level.player, 2, 2);
      thread scripts\sp\utility::_id_7792(level.player);
      wait 2;

      while(distance2dsquared(self.origin, level.player.origin) <= var_0)
        wait 0.05;

      scripts\sp\utility::_id_77B9(1.25);
      wait 3;
    }

    wait 0.1;
  }
}

_id_11003() {
  self notify("stop_headtrack_when_close");
  scripts\sp\utility::_id_77B9(0.25);
}

_id_D85C() {
  level.player._id_C39D = level.player getcurrentweapon();
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player _meth_84FE();
}

_id_DF3E() {
  level.player unlink(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.player _meth_84FD();
  var_0 = undefined;

  if(isDefined(level.player._id_C39D))
    var_0 = level.player._id_C39D;
  else
    var_0 = level.player getweaponslistprimaries()[0];

  level.player switchtoweaponimmediate(var_0);
}

_id_51E2(var_0) {
  if(isDefined(self.demeanoroverride) && self.demeanoroverride == var_0) {
    return;
  }
  if(isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb")
    scripts\sp\utility::_id_5514();

  scripts\sp\utility::_id_51E1(var_0);
}

_id_1968() {
  self endon("death");

  if(!isDefined(self.script_parameters))
    iprintln("ai gesture trig has no script_paramaters");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0) || isPlayer(var_0)) {
      continue;
    }
    var_1 = strtok(self.script_parameters, " ");

    if(var_1.size > 1)
      var_2 = scripts\engine\utility::random(var_1);
    else
      var_2 = var_1[0];

    var_0 thread _id_193C(var_2, self);
    return;
  }
}

_id_193C(var_0, var_1) {
  if(isDefined(self._id_4B79) && self._id_4B79 == var_1) {
    return;
  }
  if(!isDefined(self._id_4B79) || self._id_4B79 != var_1)
    self._id_4B79 = var_1;

  scripts\sp\utility::_id_77B7(var_0);
}

_id_5F7C(var_0) {
  level endon("stop_catching_up");
  level.player endon("death");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_61E7);

  for(;;) {
    foreach(var_2 in var_0) {
      var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

      if(!var_0.size) {
        return;
      }
      if(isDefined(var_2._id_C9BD)) {
        wait 0.05;
        continue;
      }

      var_3 = 0;
      var_4 = var_2 _id_9B77();
      var_5 = distance2dsquared(var_2.origin, level.player.origin);

      if(var_5 >= 10000 && var_4) {
        var_3 = 1;

        if(isDefined(var_2.demeanoroverride) && var_2.demeanoroverride == "cqb") {
          if(isalive(var_2))
            var_2 scripts\sp\utility::_id_51E1("sprint");
        }

        continue;
      }

      if(!isDefined(var_2.demeanoroverride) || var_2.demeanoroverride != "cqb") {
        if(isalive(var_2))
          var_2 scripts\sp\utility::_id_61E7();
      }
    }

    wait 0.1;
  }
}

_id_9B77() {
  if(!isalive(self))
    return 0;

  var_0 = anglesToForward(self.angles);
  var_1 = vectorNormalize(level.player.origin - self.origin);
  var_2 = vectordot(var_0, var_1);

  if(var_2 < 0)
    return 0;
  else
    return 1;
}

_id_10FE5(var_0) {
  level notify("stop_catching_up");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_5514);
}

_id_10FC2() {
  scripts\sp\utility::anim_stopanimScripted();
  self notify("new_anim_reach");
  self.goalradius = 32;
}

_id_107C5() {
  _id_107C2();
  _id_107C3();
  level._id_EBCA = [level._id_EBBB, level._id_EBBC];
  scripts\engine\utility::flag_set("scars_spawned");
}

_id_107C2() {
  var_0 = scripts\engine\utility::get_target_ent("scar_1");
  var_0.count = 1;
  level._id_EBBB = var_0 scripts\sp\utility::_id_10619(1);
  level._id_EBBB thread scripts\sp\utility::_id_5131();
  level._id_EBBB._id_1FBB = "scar1";
  level._id_EBBB.script_noteworthy = "scar1";
  level._id_EBBB scripts\sp\utility::_id_F3B5("r");
  level._id_EBBB scripts\sp\utility::_id_F2DA(0);
  level._id_EBBB._id_C062 = 1;
  level._id_EBBB scripts\sp\utility::_id_F417(1);
  level._id_EBBB scripts\sp\utility::_id_72EC("iw7_fhr+reflexsmg+silencersmg", "primary");
  level._id_EBBB scripts\sp\utility::_id_F3E6(0);
  level._id_EBBB.goalradius = 32;
  level._id_EBBB._id_C065 = 1;
  level._id_10214 = level._id_EBBB;
}

_id_107C3() {
  var_0 = scripts\engine\utility::get_target_ent("scar_2");
  var_0.count = 1;
  level._id_EBBC = var_0 scripts\sp\utility::_id_10619(1);
  level._id_EBBC thread scripts\sp\utility::_id_5131();
  level._id_EBBC._id_1FBB = "scar2";
  level._id_EBBC.script_noteworthy = "scar2";
  level._id_EBBC scripts\sp\utility::_id_F3B5("r");
  level._id_EBBC scripts\sp\utility::_id_F2DA(0);
  level._id_EBBC._id_C062 = 1;
  level._id_EBBC scripts\sp\utility::_id_F417(1);
  level._id_EBBC scripts\sp\utility::_id_72EC("iw7_fhr+reflexsmg+silencersmg", "primary");
  level._id_EBBC scripts\sp\utility::_id_F3E6(0);
  level._id_EBBC.goalradius = 32;
  level._id_EBBC._id_C065 = 1;
  level._id_113AD = level._id_EBBC;
}

_id_EBC7() {
  level._id_EBBB scripts\sp\utility::_id_F3B5("r");
  level._id_EBBC scripts\sp\utility::_id_F3B5("b");
}

_id_EBC4() {
  level._id_EBBB scripts\sp\utility::_id_F3B5("r");
  level._id_EBBC scripts\sp\utility::_id_F3B5("r");
}

_id_EBCE(var_0) {
  if(var_0) {
    foreach(var_2 in level._id_EBCA)
    var_2._id_43A9 = ::_id_D965;
  } else {
    foreach(var_2 in level._id_EBCA)
    var_2._id_43A9 = undefined;
  }
}

_id_D965(var_0) {
  wait 2;
  self waittill("goal");

  if(isDefined(var_0._id_ED9E))
    scripts\engine\utility::flag_set(var_0._id_ED9E);

  if(isDefined(var_0._id_ED80))
    scripts\sp\utility::_id_65E1(var_0._id_ED80);

  if(isDefined(var_0._id_ED9B))
    scripts\engine\utility::flag_clear(var_0._id_ED9B);

  if(isDefined(var_0._id_EDC7))
    thread scripts\sp\utility::_id_77B7(var_0._id_EDC7);
}

_id_19DB() {
  self endon("death");
  var_0 = 250;
  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait(level._id_F106);
    self.goalradius = var_1;
    self setgoalentity(level.player);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

_id_C120(var_0, var_1) {
  if(!isDefined(self.script_noteworthy))
    return 0;

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_noteworthy);

  if(!isDefined(var_1)) {
    if(var_2 == var_0)
      return 1;

    return 0;
  }

  var_3 = strtok(var_2, var_1);

  foreach(var_5 in var_3) {
    if(var_5 == var_0)
      return 1;
  }

  return 0;
}

_id_C8ED(var_0, var_1) {
  if(!isDefined(self.script_parameters))
    return 0;

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_parameters);

  if(!isDefined(var_1)) {
    if(var_2 == var_0)
      return 1;

    return 0;
  }

  var_3 = strtok(var_2, var_1);

  foreach(var_5 in var_3) {
    if(var_5 == var_0)
      return 1;
  }

  return 0;
}

_id_F5B1(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setOrigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "salter":
        level._id_EA2C _meth_80F1(var_3.origin, var_3.angles);
        level._id_EA2C setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread scripts\sp\anim::_id_1EC7(level._id_EA2C, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level._id_EA2C thread scripts\sp\utility::_id_7227(var_3);
        }

        break;
      case "mccallum":
        level._id_B4F1 _meth_80F1(var_3.origin, var_3.angles);
        level._id_B4F1 setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread scripts\sp\anim::_id_1EC7(level._id_B4F1, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level._id_B4F1 thread scripts\sp\utility::_id_7227(var_3);
        }

        break;
    }
  }
}

#using_animtree("script_model");

_id_1F8A() {
  var_0 = self.animation;

  if(isDefined(self._id_EDA0))
    scripts\engine\utility::flag_wait(self._id_EDA0);

  scripts\sp\utility::script_delay();
  self _meth_83D0(#animtree);
  thread scripts\sp\anim::_id_1ECC(self, var_0);

  if(isDefined(self._id_EE2C)) {
    scripts\engine\utility::waitframe();
    self _meth_82B1(scripts\sp\utility::_id_7DC3(var_0)[0], self._id_EE2C);
  }

  if(isDefined(self._id_ED48)) {
    scripts\engine\utility::flag_wait(self._id_ED48);
    self delete();
  }
}

_id_5168() {
  self waittill("trigger");
  var_0 = scripts\sp\utility::_id_7A8F();
  scripts\sp\utility::_id_228A(var_0);
}

_id_67C4(var_0) {
  var_1 = getEnt(var_0, "targetname");

  for(var_2 = [level._id_B4F1, level._id_EA2C]; isDefined(var_1.target); var_1 = var_3) {
    var_3 = getEnt(var_1.target, "targetname");
    _id_13865(var_1, var_3, var_2);
    var_1 scripts\engine\utility::trigger_off();
  }

  foreach(var_5 in var_2)
  var_5.demeanoroverride = undefined;
}

_id_13865(var_0, var_1, var_2) {
  var_1 endon("trigger");

  for(;;) {
    foreach(var_4 in var_2) {
      var_5 = anglesToForward(var_4.angles);
      var_6 = vectorNormalize(var_4.origin - level.player.origin);
      var_7 = vectordot(var_5, var_6);

      if(var_7 > 0) {
        var_4.demeanoroverride = "casual_gun";
        continue;
      }

      var_4.demeanoroverride = undefined;
    }

    wait 0.1;
  }
}

_id_1F38(var_0, var_1, var_2, var_3) {
  scripts\sp\anim::_id_1F35(var_0, var_1);
  thread scripts\sp\anim::_id_1EEA(var_0, var_2);

  if(isDefined(var_3))
    self notify("sNotify");
}

_id_1F15(var_0, var_1, var_2, var_3, var_4) {
  scripts\sp\anim::_id_1F17(var_0, var_1);
  scripts\sp\anim::_id_1F35(var_0, var_1);
  thread scripts\sp\anim::_id_1EEA(var_0, var_2, var_3);

  if(isDefined(var_4))
    self notify(var_4);
}

_id_9E47(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectorNormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 <= 0)
    return 1;

  return 0;
}

_id_9D64(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectorNormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return 1;

  return 0;
}

_id_61DC() {
  scripts\sp\utility::_id_61F7();
  scripts\sp\utility::_id_61DB();
}

_id_5505() {
  scripts\sp\utility::_id_5528();
  scripts\sp\utility::_id_5504();
}

_id_13815(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger");
}

_id_13814(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 waittill("trigger");
}

_id_127B6(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 == var_0) {
      break;
    }
  }
}

_id_127B5(var_0) {
  for(;;) {
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(!var_3 istouching(self)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      break;
    }

    wait 0.05;
  }
}

_id_83C7() {
  var_0 = getglass(self.target);
  self waittill("trigger", var_1);
  var_2 = anglesToForward(var_1.angles);
  destroyglass(var_0, var_2);
}

_id_519D(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 delete();
}

_id_1144C() {
  var_0 = level.player getweaponslist("offhand");

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "frag"))
      level.player takeweapon(var_2);
  }
}

_id_1144E() {
  var_0 = level.player getweaponslist("offhand");

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "retractableshield"))
      level.player takeweapon(var_2);
  }
}

_id_67C2() {
  if(getdvarint("ai_iw7") == 0)
    self _meth_83A1();
  else
    _id_0A1E::_id_2386();
}

_id_79CE(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_E45E(var_0, var_1, var_2) {
  var_3 = var_1 * randomfloat(1.0);
  var_4 = randomfloat(360.0);
  var_5 = sin(var_4);
  var_6 = cos(var_4);
  var_7 = var_3 * var_6;
  var_8 = var_3 * var_5;
  var_9 = 0;

  if(isDefined(var_2))
    var_9 = randomfloatrange(var_2 * -1, var_2);

  var_7 = var_7 + var_0[0];
  var_8 = var_8 + var_0[1];
  var_9 = var_9 + var_0[2];
  return (var_7, var_8, var_9);
}

_id_36DF(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_7 = var_1[0];
  var_8 = var_1[1];
  var_9 = var_1[2];
  var_10 = [var_0, var_1];
  var_11 = _id_7ADF(var_10, var_2);
  var_12 = var_11[0];
  var_13 = var_11[1];
  var_14 = var_11[2];
  var_15 = [];

  for(var_16 = 1; var_16 <= var_3; var_16++) {
    var_17 = var_16 / var_3;
    var_18 = int((1 - var_17) * (1 - var_17) * var_4 + 2 * (1 - var_17) * var_17 * var_12 + var_17 * var_17 * var_7);
    var_19 = int((1 - var_17) * (1 - var_17) * var_5 + 2 * (1 - var_17) * var_17 * var_13 + var_17 * var_17 * var_8);
    var_20 = int((1 - var_17) * (1 - var_17) * var_6 + 2 * (1 - var_17) * var_17 * var_14 + var_17 * var_17 * var_9);
    var_15[var_16] = (var_18, var_19, var_20);
  }

  return var_15;
}

_id_7ADF(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_2 = var_2 + var_0[var_5][0];
    var_3 = var_3 + var_0[var_5][1];
    var_4 = var_4 + var_0[var_5][2];
  }

  return (var_2 / var_0.size, var_3 / var_0.size, var_4 / var_0.size + var_1);
}

_id_1776(var_0) {
  if(!isDefined(level._id_67B9))
    level._id_67B9 = [];

  if(!isDefined(level._id_67B9[var_0])) {}

  var_1 = spawnStruct();
  level._id_67B9[var_0] = scripts\engine\utility::array_add(level._id_67B9[var_0], var_1);
  var_1 waittill("queue_hit");
  return var_1;
}

_id_48F4(var_0, var_1, var_2) {
  level._id_67B9[var_0] = [];
  thread _id_7766(var_0, var_1);
}

_id_7766(var_0, var_1, var_2) {
  for(;;) {
    var_3 = level._id_67B9[var_0];

    if(!var_3.size) {} else {
      var_3[0] notify("queue_hit");

      if(isDefined(var_1))
        wait(var_1);

      if(isDefined(var_2))
        var_3[0] waittill("continue_queue");

      level._id_67B9[var_0] = scripts\engine\utility::array_remove(level._id_67B9[var_0], var_3[0]);
    }

    wait 0.1;
  }
}

_id_BC50(var_0) {
  if(isstring(var_0))
    var_0 = _id_7988(var_0);

  var_1 = undefined;
  var_2 = (0, 0, 110);

  if(isDefined(level._id_133EC)) {
    if(isDefined(level._id_133EC._id_12F97)) {
      if(isDefined(level._id_133EC._id_12F97[0]))
        var_1 = level._id_133EC._id_12F97[0]._id_10229;
    }
  }

  var_1 moveTo(var_0.origin + var_2, 0.05);

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
}

_id_7988(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = call[[level.getnodefunction]](var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;
}

_id_AFF1() {
  self notify("end_look_at_node");
  self endon("end_look_at_node");
  self endon("stop_look_at_next_node");

  while(!isDefined(self._id_4BF7))
    wait 0.05;

  self setyawspeedbyname("instant");
  self._id_F472 = 1;
  self._id_B00A = spawn("script_origin", (0, 0, 0));
  self setlookatent(self._id_B00A);

  for(;;) {
    if(!isDefined(self._id_4BF7.target)) {
      break;
    }

    var_0 = scripts\engine\utility::getStruct(self._id_4BF7.target, "targetname");
    self._id_B00A.origin = var_0.origin;
    self waittill("reached_current_node");
  }
}

_id_11017() {
  self notify("stop_look_at_next_node");
  self clearlookatent();
  self._id_F472 = 0;
  self._id_B00A delete();
}

_id_D83D() {
  var_0 = scripts\engine\utility::get_target_ent("interior_base_speed_volume");
  var_0 hide();
}

_id_1330E() {
  self notify("disable_jackal_dust_vfx");
  self endon("disable_jackal_dust_vfx");

  for(;;) {
    if(level._id_133EC._id_D1A4._id_BD69 <= 70 && level._id_133EC._id_D1A4._id_BD69 >= 20) {} else if(level._id_133EC._id_D1A4._id_BD69 >= 140) {} else if(level._id_133EC._id_D1A4._id_BD69 <= 19) {} else {}

    wait 0.1;
  }
}

_id_116B5() {
  level notify("temp_player_speed");
  level endon("temp_player_speed");
  wait 5;

  for(;;) {
    iprintln(level._id_133EC._id_D1A4._id_BD69);
    wait 1;
  }
}

_id_11690() {
  level notify("temp_flight_hack");
  level endon("temp_flight_hack");
  level._id_133EC._id_D1A4 scripts\sp\utility::_id_65E1("auto_boost_on");
  wait 1;
  level._id_133EC._id_D1A4 scripts\sp\utility::_id_65DD("auto_boost_on");
}

_id_8578() {
  setdvarifuninitialized("grenade_indicator", 0);
  setsaveddvar("r_hudoutlineEnable", 1);

  if(getdvarint("grenade_indicator") != 1) {
    return;
  }
  var_0 = getspawnerarray();
  scripts\sp\utility::_id_22C7(var_0, ::_id_857A);
}

_id_857A() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0 thread _id_8579();
  }
}

_id_8579() {
  self hudoutlineenable(1, 0, 0);
  target_set(self);
  target_setshader(self, "hud_grenadethrowback");
  var_0 = 0;

  while(isDefined(self)) {
    var_1 = distance(self.origin, level.player.origin);

    if(var_1 > 250 && var_0 == 0) {
      var_0 = 1;
      self hudoutlinedisable();
      target_hidefromplayer(self, level.player);
    } else if(var_1 <= 250 && var_0 == 1) {
      var_0 = 0;
      self hudoutlineenable(1, 0, 0);
      target_showtoplayer(self, level.player);
    }

    wait 0.1;
  }
}

_id_4ED5() {
  for(;;) {
    if(!getdvarint("debug_ent_count")) {
      wait 0.2;
      continue;
    }

    var_0 = 110;
    var_1 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_1.x = 580;
    var_1.y = var_0;
    var_0 = var_0 + 15;
    var_2 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_2.x = 580;
    var_2.y = var_0;
    var_0 = var_0 + 15;
    var_3 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_3.x = 580;
    var_3.y = var_0;
    var_0 = var_0 + 15;
    var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_4.x = 580;
    var_4.y = var_0;
    var_0 = var_0 + 15;
    var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_5.x = 580;
    var_5.y = var_0;
    var_0 = var_0 + 15;
    var_6 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_6.x = 580;
    var_6.y = var_0;
    var_0 = var_0 + 15;
    var_7 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_7.x = 580;
    var_7.y = var_0;
    thread _id_65D8(var_3, var_4, var_5, var_6, var_7);

    while(getdvarint("debug_ent_count")) {
      wait 0.1;
      continue;
    }

    level notify("stop_ai_drone_debug");
    var_2 destroy();
    var_1 destroy();
    var_3 destroy();
    var_4 destroy();
    var_5 destroy();
    var_6 destroy();
    var_7 destroy();
  }
}

_id_4EA2(var_0, var_1) {
  level endon("stop_ai_drone_debug");

  for(;;) {
    var_2 = level._id_13267["allies"];
    var_2 = scripts\engine\utility::array_combine(var_2, level._id_13267["axis"]);
    var_3 = getaiarray();
    var_0 settext("Vehicles : " + var_2.size);
    var_1 settext("AI : " + var_3.size);
    wait 0.05;
  }
}

_id_65D8(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ai_drone_debug");
  var_5 = 0;
  var_6 = 50;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    var_10 = getEntArray("script_model", "classname");
    var_11 = getEntArray("script_origin", "classname");
    var_0 settext("models : " + var_10.size);
    var_1 settext("origins : " + var_11.size);
    var_12 = var_10.size + var_11.size;
    var_2 settext("total : " + var_12);
    var_7 = var_7 + var_12;
    var_3 settext("average : " + var_5);
    var_8++;

    if(var_8 == var_6) {
      var_5 = int(var_7 / var_6);
      var_7 = 0;
      var_8 = 0;
    }

    if(var_12 > var_9) {
      var_9 = var_12;
      var_4 settext("highest :" + var_9);
    }

    wait 0.05;
  }
}

_id_16DD(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 thread[[var_1]]();
  return;
}

_id_1368F(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 scripts\sp\utility::_id_77E3("axis");
  var_4 = var_3.size;

  while(var_4 > var_1) {
    var_3 = var_2 scripts\sp\utility::_id_77E3("axis");
    var_4 = var_3.size;

    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 scripts\sp\utility::_id_58DA() || var_6.delayeddeath)
          var_4--;
      }
    }

    wait 0.2;
  }
}

_id_A761(var_0, var_1, var_2) {
  if(!isDefined(level._id_5A91))
    level._id_5A91 = [];

  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3)
  var_5 thread _id_A764(var_0, var_1, var_2);
}

_id_A764(var_0, var_1, var_2) {
  self endon("disable_spawn");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_3 = _id_10752();
  var_3 scripts\sp\utility::_id_F2A8(1);
  var_3 setCanDamage(1);
  var_3 scripts\sp\utility::_id_1101B();
  var_3 endon("death");

  if(!isDefined(level._id_5A91[var_0]))
    level._id_5A91[var_0] = [];

  level._id_5A91[var_0] = scripts\engine\utility::array_add(level._id_5A91[var_0], var_3);

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  scripts\sp\anim::_id_1EC3(var_3, "robot_power_on");
  var_4 = undefined;

  if(isDefined(self.target)) {
    var_5 = getEntArray(self.target, "targetname");
    var_4 = undefined;

    foreach(var_7 in var_5) {
      if(var_7 _id_C120("delete_robot")) {
        thread _id_A762(var_7);
        continue;
      }

      var_4 = var_7;
    }
  }

  if(isDefined(var_4))
    var_4 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");

  if(isDefined(var_2) && var_2)
    var_3 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "awaken");

  if(isDefined(var_4) || isDefined(var_2) && var_2)
    scripts\sp\utility::_id_57D6();

  var_3 notify("awaken");

  if(isDefined(self._id_EDCF)) {
    var_9 = self._id_EDCF;
    var_10 = getnode(self.target, "targetname");

    if(isDefined(var_10))
      var_3 _meth_82F0(level._id_8438[var_9]);
    else
      var_3 _meth_82F1(level._id_8438[var_9]);
  } else
    var_3.combatmode = "no_cover";

  var_3 setgoalpos(var_3.origin);
  var_3 _id_A78D();
  scripts\sp\anim::_id_1F35(var_3, "robot_power_on");
}

_id_A762(var_0) {
  self endon("death");
  self endon("awaken");
  var_0 waittill("trigger");
  self delete();
}

_id_A763(var_0) {
  self endon("spawned");
  var_0 waittill("trigger");
  self notify("disable_spawn");
}

_id_E59D(var_0, var_1, var_2, var_3) {
  self endon("robot_locker_opened");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_4 = scripts\sp\utility::_id_10639("robot", self.origin);
  var_5 = scripts\sp\utility::_id_10639("locker_arm", self.origin);
  self._id_AF1E = var_5;
  self._id_6B53 = var_4;
  var_6 = [var_5, var_4];
  scripts\sp\anim::_id_1EC1(var_6, "robot_locker_on");

  if(isDefined(self.script_noteworthy))
    thread _id_E59A();

  if(isDefined(var_3)) {
    var_3 waittill("trigger");

    if(isDefined(self._id_AF1E))
      self._id_AF1E delete();

    if(isDefined(self._id_6B53))
      self._id_6B53 delete();

    return;
  }
}

_id_E59C(var_0) {
  if(isDefined(var_0))
    var_0 waittill("trigger");

  var_1 = _id_10752();
  var_2 = [self._id_AF1E, var_1];
  scripts\sp\anim::_id_1EC3(self._id_AF1E, "robot_locker_on");
  thread scripts\sp\anim::_id_1EEA(var_1, "robot_locker_idle");

  if(isDefined(self._id_6B53))
    self._id_6B53 delete();

  var_3 = anglesToForward(self.angles);
  var_4 = self.origin + var_3 * 15;
  playFX(scripts\engine\utility::getfx("robot_locker_open"), var_4, var_3);
  _id_E59B();
  var_5 = 2.2;
  var_6 = 1;

  foreach(var_8 in self.doors) {
    playworldsound("robot_locker_open", self.origin);
    var_9 = 45;

    if(var_8.script_parameters == "left")
      var_9 = var_9 * -1;

    var_8 rotateYaw(var_9, var_5, var_5 / 2, var_5 / 2);

    if(isDefined(var_6) && !var_6)
      wait(randomfloatrange(0.1, 0.3));

    var_6 = undefined;
  }

  wait(var_5 / 2);
  self notify("stop_loop");
  var_1 _meth_83A1();
  scripts\sp\anim::_id_1F2C(var_2, "robot_locker_on");
  var_3 = anglesToForward(self.angles);
  var_11 = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  var_1 linkTo(var_11);
  var_12 = var_11.origin + var_3 * 40;
  var_11 moveTo(var_12, 0.2);
  wait 0.2;
  var_1 unlink();
  var_11 delete();
  var_1 scripts\sp\utility::_id_1101B();
  var_1 scripts\sp\utility::_id_6224();
  var_1.ignoreall = 0;
  var_1.ignoreme = 0;
  var_1 setgoalpos(var_1.origin);

  if(isDefined(self._id_EDCF))
    var_1 _meth_82F1(level._id_8438[self._id_EDCF]);

  self notify("robot_locker_opened");
  return var_1;
}

_id_E59A() {
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  var_0 = 0;

  switch (self.script_noteworthy) {
    case "open_full":
      self._id_6B53 delete();
      self._id_6B53 = _id_10752();
      var_1 = [self._id_AF1E, self._id_6B53];
      thread scripts\sp\anim::_id_1F2C(var_1, "robot_locker_on");
      scripts\engine\utility::waitframe();
      var_2 = 2;

      foreach(var_4 in var_1) {
        var_5 = var_4 scripts\sp\utility::_id_7DC1("robot_locker_on");
        var_6 = getanimlength(var_5);
        var_7 = var_2 / var_6;
        var_4 _meth_82B0(var_5, var_7);
      }

      scripts\sp\anim::_id_1F27(var_1, "robot_locker_on", 0);
      var_0 = 1;
      break;
    case "open_empty":
      self._id_6B53 delete();
      var_1 = [self._id_AF1E];
      thread scripts\sp\anim::_id_1F2C(var_1, "robot_locker_on");
      scripts\engine\utility::waitframe();
      scripts\sp\anim::_id_1F2A(var_1, "robot_locker_on", 0.6);
      scripts\sp\anim::_id_1F27(var_1, "robot_locker_on", 0);
      var_0 = 1;
      break;
  }

  _id_E59B();

  if(var_0) {
    foreach(var_10 in self.doors) {
      var_11 = 45;

      if(var_10.script_parameters == "left")
        var_11 = var_11 * -1;

      var_10 rotateYaw(var_11, 0.05);
    }
  }
}

_id_E59B() {
  if(isDefined(self.doors)) {
    return;
  }
  var_0 = scripts\sp\utility::_id_7A8F();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel")
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  self.doors = var_1;
  return self;
}

_id_10752(var_0, var_1) {
  _id_1776("lab_robot");

  if(scripts\engine\utility::cointoss()) {
    level._id_E5AD.count = 999;
    var_2 = level._id_E5AD scripts\sp\utility::_id_10619(1);
  } else {
    var_3 = randomintrange(0, 100);

    if(var_3 <= 80) {
      level._id_E5AF.count = 999;
      var_2 = level._id_E5AF scripts\sp\utility::_id_10619(1);
    } else {
      level._id_E5AE.count = 999;
      var_2 = level._id_E5AE scripts\sp\utility::_id_10619(1);
    }
  }

  var_2 scripts\sp\utility::_id_B14F(1);
  var_2 scripts\sp\utility::_id_F2DA(0);
  var_2 scripts\sp\utility::_id_5564();

  if(isDefined(level._id_E5C0))
    var_2 thread[[level._id_E5C0]]();

  var_2._id_1FBB = "robot";

  if(isDefined(var_0))
    var_2 _meth_82F1(level._id_8438[var_0]);

  if(isDefined(self._id_EDD2))
    var_2.grenadeammo = self._id_EDD2;

  if(!isDefined(var_1)) {
    if(isDefined(self._id_ECE7))
      var_1 = self._id_ECE7;
  }

  if(isDefined(var_1)) {
    if(!isDefined(level._id_1162[var_1]))
      _id_0B77::_id_1A12(var_1);

    var_2 thread _id_0B77::_id_1A14(level._id_1162[var_1]);
  }

  self notify("spawned");
  return var_2;
}

_id_E598() {
  self waittill("death");

  if(!isDefined(self))
    return;
}

_id_E5B0() {
  self endon("entitydeleted");
  scripts\engine\utility::waittill_either("death", "awaken");
}

_id_A78D() {
  self.ignoreme = 0;
  self.ignoreall = 0;
  scripts\sp\utility::_id_6224();

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();
}

_id_6473() {
  var_0 = [level._id_EBBB, level._id_EBBC];
  var_1 = [];
  var_2 = [0, 1];

  foreach(var_6, var_4 in var_0) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("tag_origin");
    var_5 linkTo(var_4, "j_Head", (0, 0, 0), anglesToForward(var_4.angles) + (-180, 90, 0), 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_5);
    playFXOnTag(level._effect["friendly_flashlight"], var_5, "tag_origin");
    wait(var_2[var_6]);
  }
}

_id_A796() {
  var_0 = [level._id_EBBB, level._id_EBBC];
  var_1 = [];
  var_2 = [0, 1];

  foreach(var_6, var_4 in var_0) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("tag_origin");
    var_5 linkTo(var_4, "j_Head", (0, 0, 0), anglesToForward(var_4.angles) + (-180, 90, 0), 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_5);
    playFXOnTag(level._effect["friendly_flashlight"], var_5, "tag_origin");
    wait(var_2[var_6]);
  }

  wait 0.4;
  var_7 = scripts\engine\utility::spawn_tag_origin();
  var_7 show();
  var_7 _meth_81E2(level.player, "tag_flash", (60, 0, -5), (0, 0, 0), 1);
  playFXOnTag(level._effect["player_flashlight"], var_7, "tag_origin");
  level.player thread scripts\sp\utility::play_sound_on_entity("flashlight_on");
  scripts\engine\utility::flag_wait("flashlights_off");
  level.player thread scripts\sp\utility::play_sound_on_entity("flashlight_off");
  stopFXOnTag(level._effect["player_flashlight"], var_7, "tag_origin");
  scripts\engine\utility::waitframe();
  var_7 delete();

  foreach(var_9 in var_1)
  var_9 delete();
}

_id_6244(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    if(!isDefined(level._id_EBBB))
      wait 0.05;

    if(!isDefined(level._id_EBBC))
      wait 0.05;
  }

  var_1 = [level._id_EBBB, level._id_EBBC];

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_61E7(1);
}

_id_558F(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    if(!isDefined(level._id_EBBB))
      wait 0.05;

    if(!isDefined(level._id_EBBC))
      wait 0.05;
  }

  var_1 = [level._id_EBBB, level._id_EBBC];

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_5514();
}

_id_C807(var_0) {
  level.player scripts\sp\utility::play_sound_on_entity(var_0);
}

_id_133A1() {
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowsprint(0);
}

_id_133A2() {
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowsprint(1);
}

_id_10F59(var_0, var_1, var_2) {
  level endon("stealthtakedownComplete");
  var_3 = spawnStruct();

  if(isDefined(var_2)) {
    level endon(var_2);
    var_3._id_C6BA = var_2;
  }

  if(!isarray(var_1))
    var_1 = [var_1];

  var_3.enemies = var_0;
  var_3.allies = var_1;
  var_3._id_D435 = undefined;
  var_3._id_7423 = undefined;
  var_3._id_10D8F = 0;
  var_3.finished = 0;
  var_3._id_D3C9 = 0;
  level childthread _id_10F56(var_3);
  level childthread _id_10F57(var_3);
  level childthread _id_10F54(var_3);
  scripts\engine\utility::array_thread(var_3.enemies, ::_id_10F53, var_3);
  level._id_4BC1 = var_3;
  level waittill("stealthtakedownComplete");
}

_id_10F57(var_0) {
  for(;;) {
    wait 0.5;

    foreach(var_2 in var_0.enemies) {
      if(!isalive(var_2)) {
        continue;
      }
      if(isDefined(var_2._id_10E6D)) {
        if(var_2._id_10E6D.state != 0 && !isDefined(var_0._id_D435)) {
          var_0._id_10D8F = 1;

          if(!var_0._id_D3C9)
            var_0._id_D435 = var_2;

          var_0 thread _id_10F58(var_2);
          var_0 notify("cleartoengage");
          return;
        }
      } else if(isDefined(var_2._id_10F49)) {
        if(isDefined(var_2._id_10F49._id_2521) && var_2._id_10F49._id_2521 && !isDefined(var_0._id_D435)) {
          var_0._id_10D8F = 1;

          if(!var_0._id_D3C9)
            var_0._id_D435 = var_2;

          var_0 thread _id_10F58(var_2);
          var_0 notify("cleartoengage");
          return;
        }
      }
    }
  }
}

_id_10F58(var_0) {
  wait 1;

  if(isalive(var_0))
    self._id_10306 = 1;
}

_id_10F52(var_0) {
  for(;;) {
    var_0.enemies = scripts\sp\utility::array_removedeadvehicles(var_0.enemies);

    if(var_0.enemies.size < 2) {
      return;
    }
    foreach(var_2 in var_0.enemies) {
      if(_id_D35D(var_2)) {
        wait 1;

        if(_id_D35D(var_2) && !var_0._id_10D8F) {
          thread scripts\sp\utility::_id_16C5("Wolf", "Target in sight.");
          return;
        }
      }
    }

    wait 0.5;
  }
}

_id_10F53(var_0) {
  if(isDefined(var_0._id_C6BA))
    self endon(var_0._id_C6BA);

  for(;;) {
    self waittill("damage", var_1, var_2);
    var_0._id_10D8F = 1;

    if(!isDefined(var_0._id_D435) && isDefined(var_2) && (var_2 == level.player || isDefined(var_2.asmname) && var_2.asmname == "seeker")) {
      var_0._id_D435 = self;
      var_0._id_D3C9 = 1;

      if(isalive(self))
        self _meth_81D0(self.origin, level.player);
    }

    var_0 notify("cleartoengage");
    return;
  }
}

_id_10F56(var_0) {
  var_0 waittill("cleartoengage");
  level notify("stealthtakedown_start");
  wait 0.65;
  var_1 = undefined;
  var_2 = 0;
  var_3 = var_0.enemies.size;
  var_4 = 0.5;
  var_5 = 2;

  foreach(var_7 in var_0.enemies) {
    var_3--;

    if(var_0._id_D435 == var_7)
      continue;
    else {
      if(isDefined(var_0.allies[var_2]))
        var_1 = var_0.allies[var_2];
      else
        var_1 = var_0.allies[0];

      var_0._id_7423 = var_7;
      var_1 _id_10F55(var_0._id_7423);
      var_2++;
    }

    var_8 = scripts\engine\utility::ter_op(var_3 == 2, var_5, var_4);
    wait(var_8);
  }

  var_0 notify("friendlies_done_attacking");
}

_id_10F55(var_0) {
  self endon("death");
  var_1 = 5000;
  var_2 = gettime() + var_1;

  while(gettime() < var_2) {
    if(_id_0B1D::_id_385C(self getEye(), var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isalive(var_0))
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_0 getEye());

  wait 0.25;

  if(isalive(var_0))
    var_0 _meth_81D0(var_0.origin, self);
}

_id_10F54(var_0) {
  for(;;) {
    if(var_0._id_10D8F) {
      var_0 waittill("friendlies_done_attacking");

      if(!var_0._id_D3C9) {
        var_0._id_10306 = 1;
        scripts\engine\utility::random(var_0.allies) _id_10F55(var_0._id_D435);
        wait 0.5;
        thread _id_134B7("europa_sip_stayfocusedwolf");
      } else
        wait 0.35;

      var_0.finished = 1;
      level notify("stealthtakedownComplete");
      return;
    }

    wait 0.05;
  }
}

_id_D35D(var_0) {
  if(!isalive(var_0))
    return 0;

  if(level.player adsButtonPressed() && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0.origin, cos(5))) {
    if(_id_0B1D::_id_385C(level.player getEye(), var_0))
      return 1;
  }

  return 0;
}

_id_10F49() {
  self endon("shutdown_stealthlight");
  self endon("death");
  setdvarifuninitialized("debug_stealthlight", 0);
  self._id_10F49 = spawnStruct();
  self._id_10F49._id_2521 = 0;
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  self addaieventlistener("silenced_shot");
  setsaveddvar("ai_eventdistsilencedshot", 800);
  self.ignoreall = 1;
  childthread _id_10F4D();
  childthread _id_10F4C();
  childthread _id_10F4B();
  self waittill("stealthlight_attack");
  self._id_10F49._id_2521 = 1;
  _id_10FC2();
  self.ignoreall = 0;

  foreach(var_1 in getaiunittypearray("axis", "soldier")) {
    if(distance(self.origin, var_1.origin) < 800 && !var_1 _id_10F4A())
      var_1 thread scripts\sp\utility::_id_C12D("stealthlight_attack", randomfloatrange(0.4, 2));
  }

  self _meth_8260("bulletwhizby");
  self _meth_8260("explode");
  setsaveddvar("ai_eventdistsilencedshot", 128);
  self notify("shutdown_stealthlight");
}

_id_10F4B() {
  for(;;) {
    self waittill("ai_events", var_0);

    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

_id_10F4F() {
  for(;;) {
    self waittill("gunshot");

    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

_id_10F4E() {
  for(;;) {
    self waittill("explode");

    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

_id_10F4D() {
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player) {
      if(getdvarint("debug_stealthlight")) {}

      self notify("stealthlight_attack");
    }
  }
}

_id_10F4C() {
  var_0 = 400;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < var_0 * var_0) {
      if(self cansee(level.player)) {
        if(getdvarint("debug_stealthlight")) {}

        self notify("stealthlight_attack");
      }
    }

    wait 1;
  }
}

_id_10F50() {
  for(;;) {
    self waittill("bulletwhizby");

    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

_id_10F4A() {
  if(isDefined(self._id_10F49) && self._id_10F49._id_2521)
    return 1;

  return 0;
}

_id_1108E() {
  self _meth_8260("bulletwhizby");
  self _meth_8260("explode");
  self notify("shutdown_stealthlight");
  self.ignoreall = 0;
}

_id_D988(var_0) {
  if(isDefined(level._id_116B1)) {
    return;
  }
  var_1 = scripts\sp\math::_id_6A8E(-298, -376, var_0);
  level.player setclientomnvar("ui_helmet_meter_temperature", int(var_1));
}

_id_982F(var_0) {
  level._id_116B1 = 1;
  var_1 = gettime() + var_0 * 1000;
  var_2 = -297;

  while(gettime() < var_1) {
    level.player setclientomnvar("ui_helmet_meter_temperature", int(var_2));
    var_2 = var_2 - 1;
    wait 1.5;
  }

  level._id_116B1 = undefined;
}

_id_12992() {
  if(isDefined(level._id_11695) && level._id_11695) {
    return;
  }
  level.player setclientomnvar("ui_show_temperature_gauge", 1);
  level._id_11695 = 1;
  level.player playSound("ui_europa_temperature_warning");
}

_id_12970() {
  if(isDefined(level._id_11695) && !level._id_11695) {
    return;
  }
  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  level._id_11695 = 0;
}

_id_5F32(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  return var_1;
}

_id_203B(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::flag(var_2))
      return 1;
  }

  return 0;
}

_id_117FF(var_0) {
  var_1 = level.player getweaponslist("primary");

  if(var_1.size > 1) {
    var_2 = level.player getcurrentprimaryweapon();

    foreach(var_4 in var_1) {
      if(var_2 != var_4) {
        level.player takeweapon(var_4);
        _id_11801(var_4, var_0);
        break;
      }
    }
  }
}

_id_11801(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level.player getEye();

  if(!isDefined(var_1))
    var_1 = 500;

  var_3 = anglesToForward(level.player getplayerangles());
  var_4 = var_2 + (0, 0, -10) + var_3 * 16;
  var_5 = spawn("weapon_" + var_0, var_4);
  var_3 = anglesToForward(level.player getplayerangles() + (-20, 0, 0));
  var_6 = var_3 * var_1;
  var_5 _meth_8226(var_5.origin, var_6);
}

_id_BE3C(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_nag_thread");

  if(!isDefined(var_2))
    var_2 = 3;

  if(!isDefined(var_3))
    var_3 = 5;

  if(!isDefined(var_4))
    var_4 = 1;

  var_5 = 2;

  if(!isarray(var_1))
    var_1 = [var_1];

  wait 3;
  var_6 = 0;
  var_7 = 0;

  if(isarray(var_0[0])) {
    if(isent(var_0[0][0])) {
      var_7 = 1;
      var_8 = var_0[0][1];
    } else {
      var_6 = 1;
      var_8 = var_0[0][1];
    }
  } else
    var_8 = "";

  for(;;) {
    if(_id_203B(var_1)) {
      break;
    }

    var_0 = scripts\engine\utility::array_randomize(var_0);

    if(var_6 || var_7) {
      if(var_0.size > 1) {
        while(var_0[0][1] == var_8) {
          var_0 = scripts\engine\utility::array_randomize(var_0);
          wait 0.05;
        }
      }
    } else if(var_0.size > 1) {
      while(var_0[0] == var_8) {
        var_0 = scripts\engine\utility::array_randomize(var_0);
        wait 0.05;
      }
    }

    foreach(var_11, var_10 in var_0) {
      if(var_6) {
        thread scripts\sp\utility::_id_16C5(var_10[0], var_10[1]);
        var_8 = var_10[1];
      } else if(var_7) {
        var_10[0] scripts\sp\utility::_id_10346(var_10[1]);
        var_8 = var_10[1];
      } else {
        scripts\sp\utility::_id_10346(var_10);
        var_8 = var_10;
      }

      wait(randomfloatrange(var_2, var_3));

      if(var_4) {
        var_5 = var_5 + 3;
        var_2 = min(var_2 + var_5, 20);
        var_3 = min(var_3 + var_5, 30);
      } else {
        var_2 = min(var_2, 20);
        var_3 = min(var_3, 30);
      }

      if(_id_203B(var_1)) {
        break;
      }
    }
  }
}

_id_6F30() {
  _id_95E7();
  var_0 = scripts\engine\utility::getStructArray("fling_object", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_6F2E();
}

_id_95E7(var_0) {
  level._id_6F2F = [];
  level._id_6F2F[level._id_6F2F.size] = "blackice_coupler_gray";
  level._id_6F2F[level._id_6F2F.size] = "boots_civ_miner_burnt_01_left";
  level._id_6F2F[level._id_6F2F.size] = "boots_civ_miner_burnt_01_right";
  level._id_6F2F[level._id_6F2F.size] = "clk_lab_compoundanalyzer_01_device03";
  level._id_6F2F[level._id_6F2F.size] = "cnd_laptop_001_open_off";
  level._id_6F2F[level._id_6F2F.size] = "com_extinguisher_wallmount";
  level._id_6F2F[level._id_6F2F.size] = "com_office_book_red_flat";
  level._id_6F2F[level._id_6F2F.size] = "com_studiolight_hanging_off";
  level._id_6F2F[level._id_6F2F.size] = "conduit_metal_outlet_box_cover";
  level._id_6F2F[level._id_6F2F.size] = "conduit_metal_outlet_plug_b";
  level._id_6F2F[level._id_6F2F.size] = "conduit_metal_outlet_plug_e";
  level._id_6F2F[level._id_6F2F.size] = "conduit_metal_outlet_plug_g2";
  level._id_6F2F[level._id_6F2F.size] = "consumer_grade_pc_opened";
  level._id_6F2F[level._id_6F2F.size] = "consumer_grade_pc_tower";
  level._id_6F2F[level._id_6F2F.size] = "container_ammo_box_01";
  level._id_6F2F[level._id_6F2F.size] = "ctl_biometric_lock";
  level._id_6F2F[level._id_6F2F.size] = "cup_paper_open_iw6";
  level._id_6F2F[level._id_6F2F.size] = "emergency_stop_box_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_aid_oxygen_tank_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_computer_screen_01_arm";
  level._id_6F2F[level._id_6F2F.size] = "equipment_field_computer_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_access_keypad_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_hand_clamp_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_pliers_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_power_drill_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_rivet_tool_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_screwdriver_02";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_toolbox_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_industrial_wrench_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_memory_chip_01";
  level._id_6F2F[level._id_6F2F.size] = "equipment_wall_mounted_phone_01_white";
  level._id_6F2F[level._id_6F2F.size] = "equipment_wall_mounted_phone_01_yellow";
  level._id_6F2F[level._id_6F2F.size] = "fac_keyboard";
  level._id_6F2F[level._id_6F2F.size] = "fire_extinguisher_digital";
  level._id_6F2F[level._id_6F2F.size] = "furniture_exam_stool_01";
  level._id_6F2F[level._id_6F2F.size] = "hjk_clipboard_wpaper";
  level._id_6F2F[level._id_6F2F.size] = "hjk_plane_debris_cable_sml_2";
  level._id_6F2F[level._id_6F2F.size] = "ind_pipe_metal_hp_4_coupling";
  level._id_6F2F[level._id_6F2F.size] = "ind_railing_01_32_d";
  level._id_6F2F[level._id_6F2F.size] = "industrial_conduit_metal_1_body_bend_elbow_white";
  level._id_6F2F[level._id_6F2F.size] = "industrial_conduit_metal_1_body_end_white";
  level._id_6F2F[level._id_6F2F.size] = "industrial_conduit_metal_1_body_joint_c_white";
  level._id_6F2F[level._id_6F2F.size] = "industrial_conduit_metal_1_coupling_screw";
  level._id_6F2F[level._id_6F2F.size] = "industrial_conduit_metal_1_coupling_screw_white";
  level._id_6F2F[level._id_6F2F.size] = "lab_microscope";
  level._id_6F2F[level._id_6F2F.size] = "light_ceiling_corridor_01";
  level._id_6F2F[level._id_6F2F.size] = "loki_wif_socket";
  level._id_6F2F[level._id_6F2F.size] = "misc_duffelbag_03";
  level._id_6F2F[level._id_6F2F.size] = "misc_interior_multi_tool_01";
  level._id_6F2F[level._id_6F2F.size] = "misc_operations_manual_black";
  level._id_6F2F[level._id_6F2F.size] = "misc_operations_manual_blue";
  level._id_6F2F[level._id_6F2F.size] = "misc_operations_manual_red";
  level._id_6F2F[level._id_6F2F.size] = "mp_weapon_crate";
  level._id_6F2F[level._id_6F2F.size] = "office_paper_piece01_iw6";
  level._id_6F2F[level._id_6F2F.size] = "p7_chain_metal_str_64_hook";
  level._id_6F2F[level._id_6F2F.size] = "p7_desk_metal_military_03_tablet";
  level._id_6F2F[level._id_6F2F.size] = "portable_battery_pack_01";
  level._id_6F2F[level._id_6F2F.size] = "sign_ind_misc_03";
  level._id_6F2F[level._id_6F2F.size] = "sign_ind_misc_12";
  level._id_6F2F[level._id_6F2F.size] = "space_aid_supplybag_01";
  level._id_6F2F[level._id_6F2F.size] = "space_bracket_01_metal_painted";
  level._id_6F2F[level._id_6F2F.size] = "space_interior_handle_med_blue";
  level._id_6F2F[level._id_6F2F.size] = "space_interior_pack_square";
  level._id_6F2F[level._id_6F2F.size] = "tank_nitrogen_01_green";
  level._id_6F2F[level._id_6F2F.size] = "tank_nitrogen_01_orange";
  level._id_6F2F[level._id_6F2F.size] = "tank_nitrogen_01_white";

  if(isDefined(var_0)) {
    foreach(var_2 in level._id_6F2F)
    precachemodel(var_2);

    level._id_6F2F = undefined;
  }
}

_id_6F2E() {
  var_0 = 200;
  var_1 = [];

  for(var_2 = self; isDefined(var_2.target); var_2 = var_3) {
    var_1[var_1.size] = var_2;
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2.speed = 300;
  }

  self.path = _id_4AF3(var_1, 1);
  self._id_C96D = self.path.segments[self.path.segments.size - 1]._id_630D;
  var_4 = 2000;

  for(;;) {
    thread _id_6F31(var_4);
    wait(randomfloatrange(0.2, 1));
  }
}

_id_6F31(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel(level._id_6F2F[randomint(level._id_6F2F.size)]);
  var_1 notsolid();
  var_2 = randomintrange(300, 500);
  var_3 = randomintrange(-30, 30);
  var_4 = randomintrange(-50, 50);
  var_1 rotatevelocity((var_2, var_3, var_4), 100);
  var_5 = 0;
  var_6 = 50;
  var_0 = var_0 * 0.05;

  while(var_5 < self._id_C96D) {
    var_5 = var_5 + var_0;
    var_7 = _id_4AEA(self.path, var_5);
    var_1.origin = var_7["pos"];
    wait 0.05;
  }

  var_1 delete();
}

_id_6F2C() {
  self endon("death");
  var_0 = 100;

  for(;;) {
    var_1 = self.path.segments[self.path.segments.size - 1]._id_630D;
    var_2 = _id_4AEA(self.path, 0);
    var_3 = var_2["pos"];

    for(var_4 = 0; var_4 < var_1; var_3 = var_2["pos"]) {
      var_4 = var_4 + var_0;
      var_2 = _id_4AEA(self.path, var_4);
    }

    wait 0.05;
  }
}

_id_AC90(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self _meth_8134();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread _id_AC91(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self._id_AD22))
    var_6 = scripts\engine\utility::array_combine(var_6, self._id_AD22);

  foreach(var_8 in var_6) {
    var_8 thread _id_AC91(var_0);
    var_8 setlightintensity(var_0);
  }
}

_id_AC91(var_0) {
  if(!isDefined(self.script_threshold)) {
    return;
  }
  var_1 = var_0 > self.script_threshold;

  foreach(var_3 in self._id_AD83) {
    if(var_1 && !var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 show();

      if(isDefined(var_3.effect))
        var_3.effect thread scripts\sp\utility::_id_E2B0();

      continue;
    }

    if(!var_1 && var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 hide();

      if(isDefined(var_3.effect))
        var_3.effect thread scripts\engine\utility::pauseeffect();
    }
  }

  foreach(var_3 in self._id_12BB6) {
    if(!var_1 && !var_3._id_13438) {
      var_3._id_13438 = 1;
      var_3 show();
      continue;
    }

    if(var_1 && var_3._id_13438) {
      var_3._id_13438 = 0;
      var_3 hide();
    }
  }
}

_id_AC87(var_0) {
  _id_AC90(var_0, 0.5);
}

_id_AC86() {
  _id_AC90(0.0, 0.5);
}

_id_EF3F(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(!isDefined(var_5._id_9BB1)) {
      if(var_5 getscriptablepartstate(var_1) == var_2)
        var_5 setscriptablepartstate(var_1, var_3);
    }
  }
}

_id_4AF3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.segments = [];

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_4))
    var_4 = 1;

  var_6 = 0;
  var_7 = [];

  for(var_8 = distance(var_0[0].origin, var_0[1].origin); isDefined(var_0[var_5.segments.size + 2]); var_5.segments[var_9]._id_630D = var_6) {
    var_9 = var_5.segments.size;
    var_10 = var_0[var_9].origin;
    var_11 = var_0[var_9 + 1].origin;
    var_12 = var_0[var_9 + 2].origin;
    var_13 = var_8;
    var_8 = distance(var_0[var_9 + 1].origin, var_0[var_9 + 2].origin);
    var_14 = var_7;
    var_7 = _id_4AE5(var_10, var_12, var_13, var_8, 0.5);

    if(var_9 == 0) {
      if(isDefined(var_2))
        var_14["outgoing"] = var_2 * var_13;
      else
        var_14 = _id_4AE6(var_10, var_11, var_7["incoming"]);
    }

    if(var_4) {
      var_5.segments[var_9] = _id_4AFC(var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13);
      var_6 = var_6 + var_5.segments[var_9]._id_630D;
      continue;
    }

    var_5.segments[var_9] = _id_4AFB(var_10, var_11, var_14["outgoing"], var_7["incoming"]);
    var_6 = var_6 + var_13;
  }

  var_9 = var_5.segments.size;
  var_10 = var_0[var_9].origin;
  var_11 = var_0[var_9 + 1].origin;
  var_13 = var_8;
  var_14 = var_7;

  if(var_9 == 0 && isDefined(var_2))
    var_14["outgoing"] = var_2 * var_13;

  if(isDefined(var_3))
    var_7["incoming"] = var_3 * var_13;
  else
    var_7 = _id_4AE6(var_10, var_11, var_14["outgoing"]);

  if(var_9 == 0 && !isDefined(var_2))
    var_14 = _id_4AE6(var_10, var_11, var_7["incoming"]);

  if(var_4) {
    var_5.segments[var_9] = _id_4AFC(var_10, var_11, var_14["outgoing"], var_7["incoming"], var_13);
    var_6 = var_6 + var_5.segments[var_9]._id_630D;
  } else {
    var_5.segments[var_9] = _id_4AFB(var_10, var_11, var_14["outgoing"], var_7["incoming"]);
    var_6 = var_6 + var_13;
  }

  var_5.segments[var_9]._id_630D = var_6;

  if(var_1) {
    var_15 = 0;
    var_16 = 0;

    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      if(!isDefined(var_0[var_9 + 1].speed))
        var_0[var_9 + 1].speed = var_0[var_9].speed;

      var_13 = var_5.segments[var_9]._id_630D - var_16;
      var_17 = 2 * var_13 / ((var_0[var_9].speed + var_0[var_9 + 1].speed) / 20);
      var_15 = var_15 + var_17;
      var_5.segments[var_9]._id_6393 = var_15;
      var_16 = var_5.segments[var_9]._id_630D;
      var_5.segments[var_9]._id_109B1 = var_0[var_9].speed / 20;
      var_5.segments[var_9]._id_109A8 = var_0[var_9 + 1].speed / 20;
    }
  } else {
    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      var_5.segments[var_9]._id_6393 = var_5.segments[var_9]._id_630D;
      var_5.segments[var_9]._id_109B1 = 1;
      var_5.segments[var_9]._id_109A8 = 1;
    }
  }

  return var_5;
}

_id_4AE5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];

  for(var_7 = 0; var_7 < 3; var_7++) {
    var_5[var_7] = (1 - var_4) * (var_1[var_7] - var_0[var_7]);
    var_6[var_7] = var_5[var_7];
    var_5[var_7] = var_5[var_7] * (2 * var_2 / (var_2 + var_3));
    var_6[var_7] = var_6[var_7] * (2 * var_3 / (var_2 + var_3));
  }

  var_8 = [];
  var_8["incoming"] = (var_5[0], var_5[1], var_5[2]);
  var_8["outgoing"] = (var_6[0], var_6[1], var_6[2]);
  return var_8;
}

_id_4AE6(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = [];
  var_5 = [];

  if(isDefined(var_2)) {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4[var_6] = (-3 * var_0[var_6] + 3 * var_1[var_6] - var_2[var_6]) / 2;
      var_5[var_6] = var_4[var_6];
    }
  } else {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4[var_6] = var_1[var_6] - var_0[var_6];
      var_5[var_6] = var_1[var_6] - var_0[var_6];
    }
  }

  var_7 = [];
  var_7["incoming"] = (var_4[0], var_4[1], var_4[2]);
  var_7["outgoing"] = (var_5[0], var_5[1], var_5[2]);
  return var_7;
}

_id_4AFB(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = spawnStruct();
  var_5._id_BE20 = [];
  var_5._id_BE1F = [];
  var_5._id_BE21 = [];
  var_5._id_365F = [];

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5._id_BE20[var_6] = 2 * var_0[var_6] - 2 * var_1[var_6] + var_2[var_6] + var_3[var_6];
    var_5._id_BE1F[var_6] = -3 * var_0[var_6] + 3 * var_1[var_6] - 2 * var_2[var_6] - var_3[var_6];
    var_5._id_BE21[var_6] = var_2[var_6];
    var_5._id_365F[var_6] = var_0[var_6];
  }

  return var_5;
}

_id_4AFC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_4AFB(var_0, var_1, var_2, var_3);
  var_6 = _id_4AFE(var_5, var_4);

  if(var_6 > 1) {
    var_4 = var_4 * var_6;
    var_2 = var_2 / var_6;
    var_3 = var_3 / var_6;
    var_5 = _id_4AFB(var_0, var_1, var_2, var_3);
  }

  var_5._id_630D = var_4;
  return var_5;
}

_id_4AFE(var_0, var_1) {
  var_2 = _id_4AFF(var_0, var_1);
  return var_2;
}

_id_4AFF(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  for(var_8 = 0; var_8 < 3; var_8++) {
    var_2 = var_2 + var_0._id_BE20[var_8] * var_0._id_BE20[var_8];
    var_3 = var_3 + var_0._id_BE20[var_8] * var_0._id_BE1F[var_8];
    var_4 = var_4 + var_0._id_BE20[var_8] * var_0._id_BE21[var_8];
    var_5 = var_5 + var_0._id_BE1F[var_8] * var_0._id_BE1F[var_8];
    var_6 = var_6 + var_0._id_BE1F[var_8] * var_0._id_BE21[var_8];
    var_7 = var_7 + var_0._id_BE21[var_8] * var_0._id_BE21[var_8];
  }

  var_9 = 36 * var_2;
  var_10 = 36 * var_3;
  var_11 = 12 * var_4 + 8 * var_5;
  var_12 = 4 * var_6;
  var_13 = [];
  var_13[0] = 0;

  if(var_9 == 0) {
    if(var_10 == 0 && var_11 == 0 && var_12 == 0)
      return sqrt(var_7) / var_1;

    var_14 = _id_E6EB(var_10, var_11, var_12);

    if(isDefined(var_14[0]) && var_14[0] > 0 && var_14[0] < 1) {
      var_15 = 2 * var_10 * var_14[0] + var_11;

      if(var_15 < 0)
        var_13[var_13.size] = var_14[0];
    }

    if(isDefined(var_14[1]) && var_14[1] > 0 && var_14[1] < 1) {
      var_15 = 2 * var_10 * var_14[0] + var_11;

      if(var_15 < 0)
        var_13[var_13.size] = var_14[1];
    }
  } else {
    var_16 = _id_E6EB(3 * var_9, 2 * var_10, var_11);
    var_17 = 0;
    var_18[0] = 0;

    for(var_17 = 0; var_17 < var_16.size; var_17++) {
      if(var_16[var_17] > 0 && var_16[var_17] < 1)
        var_18[var_18.size] = var_16[var_17];
    }

    var_18[var_18.size] = 1;

    for(var_17 = 1; var_17 < var_18.size; var_17++) {
      var_19 = var_18[var_17 - 1];
      var_20 = var_18[var_17];
      var_21 = var_9 * var_19 * var_19 * var_19 + var_10 * var_19 * var_19 + var_11 * var_19 + var_12;
      var_22 = var_9 * var_20 * var_20 * var_20 + var_10 * var_20 * var_20 + var_11 * var_20 + var_12;

      if(var_21 > 0 && var_22 < 0)
        var_13[var_13.size] = _id_BF2D(var_19, var_20, var_9, var_10, var_11, var_12, 0.02);
    }
  }

  var_13[var_13.size] = 1;
  var_9 = 9 * var_2;
  var_10 = 12 * var_3;
  var_11 = 6 * var_4 + 4 * var_5;
  var_12 = 4 * var_6;
  var_23 = var_7;
  var_24 = 0;

  foreach(var_26 in var_13) {
    var_27 = var_9 * var_26 * var_26 * var_26 * var_26 + var_10 * var_26 * var_26 * var_26 + var_11 * var_26 * var_26 + var_12 * var_26 + var_23;

    if(var_27 > var_24)
      var_24 = var_27;
  }

  return sqrt(var_24) / var_1;
}

_id_4AEA(var_0, var_1, var_2) {
  if(var_1 <= 0) {
    var_3 = var_0.segments[0]._id_630D;
    var_4 = _id_4B02(var_0.segments[0], 0, var_3, var_0.segments[0]._id_109B1);
    return var_4;
  } else if(var_1 >= var_0.segments[var_0.segments.size - 1]._id_630D) {
    if(var_0.segments.size > 1)
      var_3 = var_0.segments[var_0.segments.size - 1]._id_630D - var_0.segments[var_0.segments.size - 2]._id_630D;
    else
      var_3 = var_0.segments[var_0.segments.size - 1]._id_630D;

    var_4 = _id_4B02(var_0.segments[var_0.segments.size - 1], 1, var_3, var_0.segments[var_0.segments.size - 1]._id_109A8);
    return var_4;
  } else {
    for(var_5 = 0; var_0.segments[var_5]._id_630D < var_1; var_5++) {}

    if(var_5 > 0)
      var_6 = var_0.segments[var_5 - 1]._id_630D;
    else
      var_6 = 0;

    var_3 = var_0.segments[var_5]._id_630D - var_6;
    var_7 = (var_1 - var_6) / var_3;
    var_8 = undefined;

    if(isDefined(var_2) && var_2)
      var_8 = _id_4AF7(var_0.segments[var_5]._id_109B1, var_0.segments[var_5]._id_109A8, var_7);

    var_4 = _id_4B02(var_0.segments[var_5], var_7, var_3, var_8);
    return var_4;
  }
}

_id_4AF7(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = (var_1 - var_0) * (var_1 + var_0) / 2;
  return sqrt(2 * var_4 * var_3 + var_0 * var_0);
}

_id_4B02(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_5[var_9] = var_0._id_BE20[var_9] * var_1 * var_1 * var_1 + var_0._id_BE1F[var_9] * var_1 * var_1 + var_0._id_BE21[var_9] * var_1 + var_0._id_365F[var_9];
    var_6[var_9] = 3 * var_0._id_BE20[var_9] * var_1 * var_1 + 2 * var_0._id_BE1F[var_9] * var_1 + var_0._id_BE21[var_9];
    var_7[var_9] = 6 * var_0._id_BE20[var_9] * var_1 + 2 * var_0._id_BE1F[var_9];
  }

  var_8["pos"] = (var_5[0], var_5[1], var_5[2]);
  var_8["vel"] = (var_6[0], var_6[1], var_6[2]);
  var_8["acc"] = (var_7[0], var_7[1], var_7[2]);

  if(isDefined(var_2)) {
    var_8["vel"] = var_8["vel"] / var_2;
    var_8["acc"] = var_8["acc"] / (var_2 * var_2);
  }

  if(isDefined(var_3)) {
    var_8["vel"] = var_8["vel"] * var_3;
    var_8["acc"] = var_8["acc"] * (var_3 * var_3);
  }

  var_8["speed"] = var_3;
  return var_8;
}

_id_BF2D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 5;
  var_8 = (var_0 + var_1) / 2;

  for(var_9 = var_6 + 1; abs(var_9) > var_6 && var_7 > 0; var_7--) {
    var_10 = var_2 * var_8 * var_8 * var_8 + var_3 * var_8 * var_8 + var_4 * var_8 + var_5;
    var_11 = 3 * var_2 * var_8 * var_8 + 2 * var_3 * var_8 + var_4;
    var_9 = -1 * var_10 / var_11;
    var_12 = var_8;
    var_8 = var_8 + var_9;

    if(var_8 > var_1) {
      var_8 = (var_12 + 3 * var_1) / 4;
      continue;
    }

    if(var_8 < var_0)
      var_8 = (var_12 + 3 * var_0) / 4;
  }

  return var_8;
}

_id_E6EB(var_0, var_1, var_2) {
  while(abs(var_0) > 65536 || abs(var_1) > 65536 || abs(var_2) > 65536) {
    var_0 = var_0 / 10;
    var_1 = var_1 / 10;
    var_2 = var_2 / 10;
  }

  var_3 = [];

  if(var_0 == 0) {
    if(var_1 != 0)
      var_3[0] = -1 * var_2 / var_1;
  } else {
    var_4 = var_1 * var_1 - 4 * var_0 * var_2;

    if(var_4 > 0) {
      var_3[0] = (-1 * var_1 - sqrt(var_4)) / (2 * var_0);
      var_3[1] = (-1 * var_1 + sqrt(var_4)) / (2 * var_0);
    } else if(var_4 == 0)
      var_3[0] = -1 * var_1 / (2 * var_0);
  }

  return var_3;
}

_id_67B6(var_0, var_1, var_2, var_3) {
  objective_add(var_0, var_1);
  objective_string(var_0, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  scripts\engine\utility::flag_wait(var_3);
  objective_state(var_0, "done");
}