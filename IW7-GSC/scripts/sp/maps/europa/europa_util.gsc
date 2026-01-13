/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_util.gsc
**************************************************/

func_10690(var_0) {
  if(!isDefined(var_0)) {
    foreach(var_2 in scripts\engine\utility::getstructarray("corpse_struct", "targetname")) {
      var_2 func_1068F();
    }

    return;
  }

  foreach(var_4 in scripts\engine\utility::getstructarray("corpse_struct", "targetname")) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_2) {
      var_4 func_1068F();
    }
  }
}

func_1068F() {
  getspawner("corpse_worker", "targetname").var_C1 = 100;
  if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "office_fight") {
    var_0 = func_B285();
    var_0.var_1FBB = "script_model_corpse";
    var_0 scripts\sp\utility::func_23B7();
    scripts\sp\utility::func_16AE(var_0, self.script_noteworthy);
  } else {
    if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "base_entrance") {
      var_0 = scripts\sp\utility::func_107EA("corpse_security", 1);
    } else {
      var_0 = scripts\sp\utility::func_107EA("corpse_worker", 1);
    }

    var_0.var_1FBB = "generic";
    var_0 scripts\sp\utility::func_86E4();
  }

  scripts\sp\anim::func_1EC3(var_0, self.animation);
  if(self.script_noteworthy == "base_exterior") {
    var_0 linkto(level.var_CC5B);
    return;
  } else if(self.script_noteworthy == "office_fight") {
    return;
  }

  wait(0.05);
  thread scripts\sp\maps\europa\europa_anim::func_C7C7(var_0);
  if(isDefined(self.script_parameters)) {
    wait(0.05);
    var_0 giverankxp();
  }
}

playLoopSound() {
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

func_B285() {
  var_0 = spawn("script_model", self.origin);
  var_1 = undefined;
  var_2 = undefined;
  if(self.script_noteworthy == "base_exterior") {
    var_3 = ["body_un_moon_guards_loadout_a", "body_un_moon_guards_loadout_b"];
    var_1 = ::_meth_810D;
    var_2 = "europa_security";
  } else {
    var_3 = ["body_civ_facility_worker_lt", "body_civ_facility_worker_drk"];
    var_1 = ::playloopsound;
    var_2 = "europa_worker";
  }

  var_0 scripts\code\character::setmodelfromarray(var_3);
  var_0 scripts\code\character::attachhead(var_2, [[var_1]]());
  return var_0;
}

_meth_810D() {
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
  if(var_0) {
    scripts\engine\utility::array_call(var_1, ::show);
    return;
  }

  scripts\engine\utility::array_call(var_1, ::hide);
}

func_100CA(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  if(getdvarint("debug_europa")) {
    iprintln("showing " + var_1.size + "brushes with targetname " + var_0);
  }

  foreach(var_3 in var_1) {
    var_3 show();
  }
}

func_8E72(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  if(getdvarint("debug_europa")) {
    iprintln("Hiding " + var_1.size + "brushes with targetname " + var_0);
  }

  foreach(var_3 in var_1) {
    var_3 hide();
  }
}

func_D2DC(var_0) {
  level endon("stop_player_stay_behind");
  var_1 = scripts\engine\utility::ter_op(!isDefined(var_0), 22500, var_0 * var_0);
  var_2 = 0.5;
  var_3 = 0.7;
  if(!isDefined(level.player.var_BCF5)) {
    level.player.var_BCF5 = 1;
  }

  for(;;) {
    var_4 = distancesquared(level.player.origin, self.origin);
    var_5 = scripts\sp\math::func_C097(0, var_1, var_4);
    var_5 = clamp(var_5, var_3, 1);
    var_6 = var_5 - level.player.var_BCF5;
    var_7 = var_6 * var_2;
    var_8 = level.player.var_BCF5 + var_7;
    level.player setmovespeedscale(var_8);
    level.player.var_BCF5 = var_8;
    wait(0.05);
  }
}

func_10181() {
  setsaveddvar("player_sprintspeedscale", 1.4);
  level notify("stop_player_stay_behind");
  thread scripts\sp\utility::func_2B77(1);
}

func_D24C(var_0) {
  var_1 = level.player scripts\sp\utility::func_D08C("ges_radio");
  if(var_1) {
    level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
    level.player getnumownedagentsonteambytype(0);
    wait(0.8);
  }

  func_48BD(var_0);
  if(var_1) {
    level.player playSound("ges_plr_radio_off");
    level.player stopgestureviewmodel("ges_radio", 1);
    level.player getnumownedagentsonteambytype(1);
  }
}

func_134B7(var_0) {
  level.player endon("death");
  var_1 = strtok(var_0, "_");
  switch (var_1[1]) {
    case "sip":
      level.var_EBBB scripts\sp\utility::func_10346(var_0);
      break;

    case "tee":
      level.var_EBBC scripts\sp\utility::func_10346(var_0);
      break;

    case "plr":
      if(isalive(level.player)) {
        level.player scripts\sp\utility::func_1034D(var_0);
      }
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

func_48BD(var_0, var_1) {
  if(isDefined(var_1)) {
    level endon(var_1);
  }

  foreach(var_3 in var_0) {
    func_134B7(var_3);
    wait(randomfloatrange(0.1, 0.15));
  }
}

func_8E46(var_0) {
  level.var_EBBB thread func_8E34(var_0);
  level.var_EBBC thread func_8E34(var_0);
  wait(0.1);
  scripts\engine\utility::array_thread(level.var_EBCA, ::func_13013, var_0);
}

func_8E34(var_0) {
  if(var_0 && isDefined(self.issoldier)) {
    return;
  }

  if(var_0) {
    if(self == level.player) {
      self.issoldier = 1;
      level.player givegoproattachments("viewmodel_un_jackal_pilots_frost");
      if(getdvarint("debug_europa")) {
        iprintln("Swapping playerto snow gear");
      }

      return;
    } else {
      self.issoldier = 1;
      var_1 = scripts\engine\utility::ter_op(self == level.var_10214, "body_hero_sipes_frost", "body_hero_t_frost");
      var_2 = scripts\engine\utility::ter_op(self == level.var_10214, "helmet_head_hero_sipes_frost", "head_hero_t_helmet_frost");
      var_3 = "pack_un_jackal_pilots_frost";
      if(getdvarint("debug_europa")) {
        iprintln(self.var_1FBB + " swapping to snow gear");
      }
    }
  } else {
    if(!isDefined(self.issoldier)) {
      return;
    }

    if(self == level.player) {
      self.issoldier = undefined;
      level.player givegoproattachments("viewmodel_un_jackal_pilots");
      if(getdvarint("debug_europa")) {
        iprintln("Swapping player to non-snow gear");
      }

      return;
    } else {
      self.issoldier = undefined;
      var_1 = scripts\engine\utility::ter_op(self == level.var_10214, "body_hero_sipes", "body_hero_t");
      var_2 = scripts\engine\utility::ter_op(self == level.var_10214, "helmet_head_hero_sipes", "head_hero_t_helmet");
      var_3 = "pack_un_jackal_pilots_zerog";
      if(getdvarint("debug_europa")) {
        iprintln(self.var_1FBB + " swapping to non-snow gear");
      }
    }
  }

  self setModel(var_1);
  self detach(self.hatmodel);
  self.hatmodel = var_2;
  self attach(self.hatmodel);
  self detach(self.var_A489);
  self.var_A489 = var_3;
  self attach(self.var_A489);
}

func_13013(var_0, var_1) {
  if(isai(self)) {
    var_2 = scripts\engine\utility::ter_op(var_0 == 1, "iw7_fhr_snow+reflexsmg+silencersmg_snow", "iw7_fhr+reflexsmg+silencersmg");
    scripts\sp\utility::func_72EC(var_2, "primary");
    return;
  }

  var_3 = level.player getcurrentprimaryweapon();
  var_4 = issubstr(var_3, "m4");
  var_5 = issubstr(level.player getcurrentweapon(), "alt_");
  var_6 = undefined;
  var_7 = scripts\sp\utility::func_7D74(1);
  var_8 = 0;
  foreach(var_2 in var_7) {
    func_119C6(var_2, var_0);
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(isDefined(var_1) && !var_1) {
    return;
  }

  var_0B = scripts\sp\utility::func_7D74(1);
  foreach(var_0D in var_0B) {
    if(var_4) {
      if(issubstr(var_0D, "m4")) {
        var_6 = var_0D;
        break;
      }

      continue;
    }

    if(issubstr(var_0D, "fhr")) {
      var_6 = var_0D;
      break;
    }
  }

  if(var_5) {
    var_6 = "alt_" + var_6;
  }

  level.player switchtoweaponimmediate(var_6);
}

func_119C6(var_0, var_1) {
  var_2 = strtok(var_0, "+");
  if(var_1) {
    var_3["iw7_m4"] = 1;
    var_3["iw7_fhr"] = 1;
  } else {
    var_0["iw7_m4_snow"] = 1;
    var_3["iw7_fhr_snow"] = 1;
  }

  if(isDefined(var_3[var_2[0]])) {
    var_4 = level.player getrunningforwardpainanim(var_0);
    var_5 = level.player getweaponammoclip(var_0);
    if(var_1) {
      var_6 = var_2[0] + "_snow";
    } else {
      var_6 = scripts\engine\utility::ter_op(var_3[0] == "iw7_m4_snow", "iw7_m4", "iw7_fhr");
    }

    if(getdvarint("debug_europa")) {
      iprintln("Swapping player weapon from " + var_2[0] + " to " + var_6);
    }

    for(var_7 = 0; var_7 < var_2.size; var_7++) {
      if(var_7 == 0) {
        continue;
      }

      if(issubstr(var_2[var_7], "silencer")) {
        var_2[var_7] = modifyblastshieldperk(var_2[var_7], var_1);
      }

      if(issubstr(var_2[var_7], "hybrid")) {
        var_2[var_7] = ::scripts\engine\utility::ter_op(var_1, "hybrid_snow", "hybrid");
      }

      if(issubstr(var_2[var_7], "reflexsmg")) {
        var_2[var_7] = ::scripts\engine\utility::ter_op(var_1, "reflexsmg_snow", "reflexsmg");
      }

      var_6 = var_6 + "+" + var_2[var_7];
    }

    if(level.player hasweapon("alt_" + var_0)) {
      level.player takeweapon("alt_" + var_0);
    }

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
    if(issubstr(var_0, "smg")) {
      var_0 = "silencersmg_snow";
    } else {
      var_0 = "silencer_snow";
    }
  } else if(issubstr(var_0, "smg")) {
    var_0 = "silencersmg";
  } else {
    var_0 = "silencer";
  }

  return var_0;
}

func_8CA5() {
  self endon("stop_headtrack_when_close");
  var_0 = squared(60);
  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= var_0) {
      thread scripts\sp\utility::func_7799(level.player, 2, 2);
      thread scripts\sp\utility::func_7792(level.player);
      wait(2);
      while(distance2dsquared(self.origin, level.player.origin) <= var_0) {
        wait(0.05);
      }

      scripts\sp\utility::func_77B9(1.25);
      wait(3);
    }

    wait(0.1);
  }
}

func_11003() {
  self notify("stop_headtrack_when_close");
  scripts\sp\utility::func_77B9(0.25);
}

func_D85C() {
  level.player.var_C39D = level.player getcurrentweapon();
  level.player getradiuspathsighttestnodes();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player _meth_84FE();
}

func_DF3E() {
  level.player unlink(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.player _meth_84FD();
  var_0 = undefined;
  if(isDefined(level.player.var_C39D)) {
    var_0 = level.player.var_C39D;
  } else {
    var_0 = level.player getweaponslistprimaries()[0];
  }

  level.player switchtoweaponimmediate(var_0);
}

func_51E2(var_0) {
  if(isDefined(self.demeanoroverride) && self.demeanoroverride == var_0) {
    return;
  }

  if(isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb") {
    scripts\sp\utility::func_5514();
  }

  scripts\sp\utility::func_51E1(var_0);
}

func_1968() {
  self endon("death");
  if(!isDefined(self.script_parameters)) {
    iprintln("ai gesture trig has no script_paramaters");
  }

  for(;;) {
    self waittill("trigger", var_0);
    if(!isDefined(var_0) || isplayer(var_0)) {
      continue;
    }

    var_1 = strtok(self.script_parameters, " ");
    if(var_1.size > 1) {
      var_2 = scripts\engine\utility::random(var_1);
    } else {
      var_2 = var_2[0];
    }

    var_0 thread func_193C(var_2, self);
  }
}

func_193C(var_0, var_1) {
  if(isDefined(self.var_4B79) && self.var_4B79 == var_1) {
    return;
  }

  if(!isDefined(self.var_4B79) || self.var_4B79 != var_1) {
    self.var_4B79 = var_1;
  }

  scripts\sp\utility::func_77B7(var_0);
}

func_5F7C(var_0) {
  level endon("stop_catching_up");
  level.player endon("death");
  scripts\engine\utility::array_thread(var_0, ::scripts\sp\utility::func_61E7);
  for(;;) {
    foreach(var_2 in var_0) {
      var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
      if(!var_0.size) {
        return;
      }

      if(isDefined(var_2.var_C9BD)) {
        wait(0.05);
        continue;
      }

      var_3 = 0;
      var_4 = var_2 func_9B77();
      var_5 = distance2dsquared(var_2.origin, level.player.origin);
      if(var_5 >= 10000 && var_4) {
        var_3 = 1;
        if(isDefined(var_2.demeanoroverride) && var_2.demeanoroverride == "cqb") {
          if(isalive(var_2)) {
            var_2 scripts\sp\utility::func_51E1("sprint");
          }
        }

        continue;
      }

      if(!isDefined(var_2.demeanoroverride) || var_2.demeanoroverride != "cqb") {
        if(isalive(var_2)) {
          var_2 scripts\sp\utility::func_61E7();
        }
      }
    }

    wait(0.1);
  }
}

func_9B77() {
  if(!isalive(self)) {
    return 0;
  }

  var_0 = anglesToForward(self.angles);
  var_1 = vectornormalize(level.player.origin - self.origin);
  var_2 = vectordot(var_0, var_1);
  if(var_2 < 0) {
    return 0;
  }

  return 1;
}

func_10FE5(var_0) {
  level notify("stop_catching_up");
  scripts\engine\utility::array_thread(var_0, ::scripts\sp\utility::func_5514);
}

func_10FC2() {
  scripts\sp\utility::anim_stopanimscripted();
  self notify("new_anim_reach");
  self.objective_playermask_showto = 32;
}

func_107C5() {
  func_107C2();
  func_107C3();
  level.var_EBCA = [level.var_EBBB, level.var_EBBC];
  scripts\engine\utility::flag_set("scars_spawned");
}

func_107C2() {
  var_0 = scripts\engine\utility::get_target_ent("scar_1");
  var_0.var_C1 = 1;
  level.var_EBBB = var_0 scripts\sp\utility::func_10619(1);
  level.var_EBBB thread scripts\sp\utility::func_5131();
  level.var_EBBB.var_1FBB = "scar1";
  level.var_EBBB.script_noteworthy = "scar1";
  level.var_EBBB scripts\sp\utility::func_F3B5("r");
  level.var_EBBB scripts\sp\utility::func_F2DA(0);
  level.var_EBBB.var_C062 = 1;
  level.var_EBBB scripts\sp\utility::func_F417(1);
  level.var_EBBB scripts\sp\utility::func_72EC("iw7_fhr+reflexsmg+silencersmg", "primary");
  level.var_EBBB scripts\sp\utility::func_F3E6(0);
  level.var_EBBB.objective_playermask_showto = 32;
  level.var_EBBB.var_C065 = 1;
  level.var_10214 = level.var_EBBB;
}

func_107C3() {
  var_0 = scripts\engine\utility::get_target_ent("scar_2");
  var_0.var_C1 = 1;
  level.var_EBBC = var_0 scripts\sp\utility::func_10619(1);
  level.var_EBBC thread scripts\sp\utility::func_5131();
  level.var_EBBC.var_1FBB = "scar2";
  level.var_EBBC.script_noteworthy = "scar2";
  level.var_EBBC scripts\sp\utility::func_F3B5("r");
  level.var_EBBC scripts\sp\utility::func_F2DA(0);
  level.var_EBBC.var_C062 = 1;
  level.var_EBBC scripts\sp\utility::func_F417(1);
  level.var_EBBC scripts\sp\utility::func_72EC("iw7_fhr+reflexsmg+silencersmg", "primary");
  level.var_EBBC scripts\sp\utility::func_F3E6(0);
  level.var_EBBC.objective_playermask_showto = 32;
  level.var_EBBC.var_C065 = 1;
  level.var_113AD = level.var_EBBC;
}

func_EBC7() {
  level.var_EBBB scripts\sp\utility::func_F3B5("r");
  level.var_EBBC scripts\sp\utility::func_F3B5("b");
}

func_EBC4() {
  level.var_EBBB scripts\sp\utility::func_F3B5("r");
  level.var_EBBC scripts\sp\utility::func_F3B5("r");
}

func_EBCE(var_0) {
  if(var_0) {
    foreach(var_2 in level.var_EBCA) {
      var_2.var_43A9 = ::func_D965;
    }

    return;
  }

  foreach(var_2 in level.var_EBCA) {
    var_2.var_43A9 = undefined;
  }
}

func_D965(var_0) {
  wait(2);
  self waittill("goal");
  if(isDefined(var_0.var_ED9E)) {
    scripts\engine\utility::flag_set(var_0.var_ED9E);
  }

  if(isDefined(var_0.var_ED80)) {
    scripts\sp\utility::func_65E1(var_0.var_ED80);
  }

  if(isDefined(var_0.var_ED9B)) {
    scripts\engine\utility::flag_clear(var_0.var_ED9B);
  }

  if(isDefined(var_0.var_EDC7)) {
    thread scripts\sp\utility::func_77B7(var_0.var_EDC7);
  }
}

func_19DB() {
  self endon("death");
  var_0 = 250;
  var_1 = distance(self.origin, level.player.origin);
  for(;;) {
    wait(level.var_F106);
    self.objective_playermask_showto = var_1;
    self setgoalentity(level.player);
    var_1 = var_1 - 175;
    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

func_C120(var_0, var_1) {
  if(!isDefined(self.script_noteworthy)) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_noteworthy);
  if(!isDefined(var_1)) {
    if(var_2 == var_0) {
      return 1;
    }

    return 0;
  }

  var_3 = strtok(var_2, var_1);
  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_C8ED(var_0, var_1) {
  if(!isDefined(self.script_parameters)) {
    return 0;
  }

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_parameters);
  if(!isDefined(var_1)) {
    if(var_2 == var_0) {
      return 1;
    }

    return 0;
  }

  var_3 = strtok(var_2, var_1);
  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_F5B1(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");
  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;

      case "salter":
        level.var_EA2C _meth_80F1(var_3.origin, var_3.angles);
        level.var_EA2C give_mp_super_weapon(var_3.origin);
        if(isDefined(var_3.animation)) {
          var_3 thread scripts\sp\anim::func_1EC7(level.var_EA2C, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level.var_EA2C thread scripts\sp\utility::func_7227(var_3);
        }
        break;

      case "mccallum":
        level.var_B4F1 _meth_80F1(var_3.origin, var_3.angles);
        level.var_B4F1 give_mp_super_weapon(var_3.origin);
        if(isDefined(var_3.animation)) {
          var_3 thread scripts\sp\anim::func_1EC7(level.var_B4F1, var_3.animation);
        }

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level.var_B4F1 thread scripts\sp\utility::func_7227(var_3);
        }
        break;
    }
  }
}

func_1F8A() {
  var_0 = self.animation;
  if(isDefined(self.var_EDA0)) {
    scripts\engine\utility::flag_wait(self.var_EDA0);
  }

  scripts\sp\utility::script_delay();
  self glinton(#animtree);
  thread scripts\sp\anim::func_1ECC(self, var_0);
  if(isDefined(self.var_EE2C)) {
    scripts\engine\utility::waitframe();
    self _meth_82B1(scripts\sp\utility::func_7DC3(var_0)[0], self.var_EE2C);
  }

  if(isDefined(self.var_ED48)) {
    scripts\engine\utility::flag_wait(self.var_ED48);
    self delete();
  }
}

func_5168() {
  self waittill("trigger");
  var_0 = scripts\sp\utility::func_7A8F();
  scripts\sp\utility::func_228A(var_0);
}

func_67C4(var_0) {
  var_1 = getent(var_0, "targetname");
  var_2 = [level.var_B4F1, level.var_EA2C];
  while(isDefined(var_1.target)) {
    var_3 = getent(var_1.target, "targetname");
    func_13865(var_1, var_3, var_2);
    var_1 scripts\engine\utility::trigger_off();
    var_1 = var_3;
  }

  foreach(var_5 in var_2) {
    var_5.demeanoroverride = undefined;
  }
}

func_13865(var_0, var_1, var_2) {
  var_1 endon("trigger");
  for(;;) {
    foreach(var_4 in var_2) {
      var_5 = anglesToForward(var_4.angles);
      var_6 = vectornormalize(var_4.origin - level.player.origin);
      var_7 = vectordot(var_5, var_6);
      if(var_7 > 0) {
        var_4.demeanoroverride = "casual_gun";
        continue;
      }

      var_4.demeanoroverride = undefined;
    }

    wait(0.1);
  }
}

func_1F38(var_0, var_1, var_2, var_3) {
  scripts\sp\anim::func_1F35(var_0, var_1);
  thread scripts\sp\anim::func_1EEA(var_0, var_2);
  if(isDefined(var_3)) {
    self notify("sNotify");
  }
}

func_1F15(var_0, var_1, var_2, var_3, var_4) {
  scripts\sp\anim::func_1F17(var_0, var_1);
  scripts\sp\anim::func_1F35(var_0, var_1);
  thread scripts\sp\anim::func_1EEA(var_0, var_2, var_3);
  if(isDefined(var_4)) {
    self notify(var_4);
  }
}

func_9E47(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectornormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);
  if(var_3 <= 0) {
    return 1;
  }

  return 0;
}

func_9D64(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectornormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);
  if(var_3 > 0) {
    return 1;
  }

  return 0;
}

func_61DC() {
  scripts\sp\utility::func_61F7();
  scripts\sp\utility::func_61DB();
}

func_5505() {
  scripts\sp\utility::func_5528();
  scripts\sp\utility::func_5504();
}

func_13815(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
}

func_13814(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 waittill("trigger");
}

func_127B6(var_0) {
  self endon("death");
  var_0 endon("death");
  for(;;) {
    self waittill("trigger", var_1);
    if(var_1 == var_0) {
      break;
    }
  }
}

func_127B5(var_0) {
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

    wait(0.05);
  }
}

turretfireenable() {
  var_0 = getglass(self.target);
  self waittill("trigger", var_1);
  var_2 = anglesToForward(var_1.angles);
  destroyglass(var_0, var_2);
}

func_519D(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 delete();
}

func_1144C() {
  var_0 = level.player getweaponslist("offhand");
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "frag")) {
      level.player takeweapon(var_2);
    }
  }
}

func_1144E() {
  var_0 = level.player getweaponslist("offhand");
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "retractableshield")) {
      level.player takeweapon(var_2);
    }
  }
}

func_67C2() {
  if(getdvarint("ai_iw7") == 0) {
    self givescorefortrophyblocks();
    return;
  }

  lib_0A1E::func_2386();
}

func_79CE(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

func_E45E(var_0, var_1, var_2) {
  var_3 = var_1 * randomfloat(1);
  var_4 = randomfloat(360);
  var_5 = sin(var_4);
  var_6 = cos(var_4);
  var_7 = var_3 * var_6;
  var_8 = var_3 * var_5;
  var_9 = 0;
  if(isDefined(var_2)) {
    var_9 = randomfloatrange(var_2 * -1, var_2);
  }

  var_7 = var_7 + var_0[0];
  var_8 = var_8 + var_0[1];
  var_9 = var_9 + var_0[2];
  return (var_7, var_8, var_9);
}

func_36DF(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_7 = var_1[0];
  var_8 = var_1[1];
  var_9 = var_1[2];
  var_0A = [var_0, var_1];
  var_0B = func_7ADF(var_0A, var_2);
  var_0C = var_0B[0];
  var_0D = var_0B[1];
  var_0E = var_0B[2];
  var_0F = [];
  for(var_10 = 1; var_10 <= var_3; var_10++) {
    var_11 = var_10 / var_3;
    var_12 = int(1 - var_11 * 1 - var_11 * var_4 + 2 * 1 - var_11 * var_11 * var_0C + var_11 * var_11 * var_7);
    var_13 = int(1 - var_11 * 1 - var_11 * var_5 + 2 * 1 - var_11 * var_11 * var_0D + var_11 * var_11 * var_8);
    var_14 = int(1 - var_11 * 1 - var_11 * var_6 + 2 * 1 - var_11 * var_11 * var_0E + var_11 * var_11 * var_9);
    var_0F[var_10] = (var_12, var_13, var_14);
  }

  return var_0F;
}

func_7ADF(var_0, var_1) {
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

func_1776(var_0) {
  if(!isDefined(level.var_67B9)) {
    level.var_67B9 = [];
  }

  if(!isDefined(level.var_67B9[var_0])) {}

  var_1 = spawnStruct();
  level.var_67B9[var_0] = ::scripts\engine\utility::array_add(level.var_67B9[var_0], var_1);
  var_1 waittill("queue_hit");
  return var_1;
}

func_48F4(var_0, var_1, var_2) {
  level.var_67B9[var_0] = [];
  thread func_7766(var_0, var_1);
}

func_7766(var_0, var_1, var_2) {
  for(;;) {
    var_3 = level.var_67B9[var_0];
    if(!var_3.size) {} else {
      var_3[0] notify("queue_hit");
      if(isDefined(var_1)) {
        wait(var_1);
      }

      if(isDefined(var_2)) {
        var_3[0] waittill("continue_queue");
      }

      level.var_67B9[var_0] = ::scripts\engine\utility::array_remove(level.var_67B9[var_0], var_3[0]);
    }

    wait(0.1);
  }
}

func_BC50(var_0) {
  if(isstring(var_0)) {
    var_0 = func_7988(var_0);
  }

  var_1 = undefined;
  var_2 = (0, 0, 110);
  if(isDefined(level.var_133EC)) {
    if(isDefined(level.var_133EC.var_12F97)) {
      if(isDefined(level.var_133EC.var_12F97[0])) {
        var_1 = level.var_133EC.var_12F97[0].var_10229;
      }
    }
  }

  var_1 moveto(var_0.origin + var_2, 0.05);
  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  }
}

func_7988(var_0) {
  var_1 = getent(var_0, "targetname");
  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = [[level.getnodefunction]](var_0, "targetname");
  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "targetname");
  if(isDefined(var_1)) {
    return var_1;
  }
}

func_AFF1() {
  self notify("end_look_at_node");
  self endon("end_look_at_node");
  self endon("stop_look_at_next_node");
  while(!isDefined(self.var_4BF7)) {
    wait(0.05);
  }

  self giveloadout("instant");
  self.var_F472 = 1;
  self.var_B00A = spawn("script_origin", (0, 0, 0));
  self setlookatent(self.var_B00A);
  for(;;) {
    if(!isDefined(self.var_4BF7.target)) {
      break;
    }

    var_0 = scripts\engine\utility::getstruct(self.var_4BF7.target, "targetname");
    self.var_B00A.origin = var_0.origin;
    self waittill("reached_current_node");
  }
}

func_11017() {
  self notify("stop_look_at_next_node");
  self getplayerkillstreakcombatmode();
  self.var_F472 = 0;
  self.var_B00A delete();
}

func_D83D() {
  var_0 = scripts\engine\utility::get_target_ent("interior_base_speed_volume");
  var_0 hide();
}

func_1330E() {
  self notify("disable_jackal_dust_vfx");
  self endon("disable_jackal_dust_vfx");
  for(;;) {
    if(level.var_133EC.var_D1A4.var_BD69 <= 70 && level.var_133EC.var_D1A4.var_BD69 >= 20) {} else if(level.var_133EC.var_D1A4.var_BD69 >= 140) {} else if(level.var_133EC.var_D1A4.var_BD69 <= 19) {}

    wait(0.1);
  }
}

func_116B5() {
  level notify("temp_player_speed");
  level endon("temp_player_speed");
  wait(5);
  for(;;) {
    iprintln(level.var_133EC.var_D1A4.var_BD69);
    wait(1);
  }
}

func_11690() {
  level notify("temp_flight_hack");
  level endon("temp_flight_hack");
  level.var_133EC.var_D1A4 scripts\sp\utility::func_65E1("auto_boost_on");
  wait(1);
  level.var_133EC.var_D1A4 scripts\sp\utility::func_65DD("auto_boost_on");
}

_meth_8578() {
  setdvarifuninitialized("grenade_indicator", 0);
  setsaveddvar("r_hudoutlineEnable", 1);
  if(getdvarint("grenade_indicator") != 1) {
    return;
  }

  var_0 = getspawnerarray();
  scripts\sp\utility::func_22C7(var_0, ::_meth_857A);
}

_meth_857A() {
  self endon("death");
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0 thread _meth_8579();
  }
}

_meth_8579() {
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
      continue;
    }

    if(var_1 <= 250 && var_0 == 1) {
      var_0 = 0;
      self hudoutlineenable(1, 0, 0);
      target_showtoplayer(self, level.player);
    }

    wait(0.1);
  }
}

func_4ED5() {
  for(;;) {
    if(!getdvarint("debug_ent_count")) {
      wait(0.2);
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
    thread func_65D8(var_3, var_4, var_5, var_6, var_7);
    while(getdvarint("debug_ent_count")) {
      wait(0.1);
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

func_4EA2(var_0, var_1) {
  level endon("stop_ai_drone_debug");
  for(;;) {
    var_2 = level.var_13267["allies"];
    var_2 = scripts\engine\utility::array_combine(var_2, level.var_13267["axis"]);
    var_3 = getaiarray();
    var_0 settext("Vehicles : " + var_2.size);
    var_1 settext("AI : " + var_3.size);
    wait(0.05);
  }
}

func_65D8(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ai_drone_debug");
  var_5 = 0;
  var_6 = 50;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  for(;;) {
    var_0A = getEntArray("script_model", "classname");
    var_0B = getEntArray("script_origin", "classname");
    var_0 settext("models : " + var_0A.size);
    var_1 settext("origins : " + var_0B.size);
    var_0C = var_0A.size + var_0B.size;
    var_2 settext("total : " + var_0C);
    var_7 = var_7 + var_0C;
    var_3 settext("average : " + var_5);
    var_8++;
    if(var_8 == var_6) {
      var_5 = int(var_7 / var_6);
      var_7 = 0;
      var_8 = 0;
    }

    if(var_0C > var_9) {
      var_9 = var_0C;
      var_4 settext("highest :" + var_9);
    }

    wait(0.05);
  }
}

func_16DD(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 thread[[var_1]]();
}

func_1368F(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 scripts\sp\utility::func_77E3("axis");
  var_4 = var_3.size;
  while(var_4 > var_1) {
    var_3 = var_2 scripts\sp\utility::func_77E3("axis");
    var_4 = var_3.size;
    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 scripts\sp\utility::func_58DA() || var_6.var_EB) {
          var_4--;
        }
      }
    }

    wait(0.2);
  }
}

func_A761(var_0, var_1, var_2) {
  if(!isDefined(level.var_5A91)) {
    level.var_5A91 = [];
  }

  var_3 = scripts\engine\utility::getstructarray(var_0, "targetname");
  foreach(var_5 in var_3) {
    var_5 thread func_A764(var_0, var_1, var_2);
  }
}

func_A764(var_0, var_1, var_2) {
  self endon("disable_spawn");
  if(isDefined(var_1)) {
    var_1 waittill("trigger");
  }

  var_3 = func_10752();
  var_3 scripts\sp\utility::func_F2A8(1);
  var_3 setCanDamage(1);
  var_3 scripts\sp\utility::func_1101B();
  var_3 endon("death");
  if(!isDefined(level.var_5A91[var_0])) {
    level.var_5A91[var_0] = [];
  }

  level.var_5A91[var_0] = ::scripts\engine\utility::array_add(level.var_5A91[var_0], var_3);
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  scripts\sp\anim::func_1EC3(var_3, "robot_power_on");
  var_4 = undefined;
  if(isDefined(self.target)) {
    var_5 = getEntArray(self.target, "targetname");
    var_4 = undefined;
    foreach(var_7 in var_5) {
      if(var_7 func_C120("delete_robot")) {
        thread func_A762(var_7);
        continue;
      }

      var_4 = var_7;
    }
  }

  if(isDefined(var_4)) {
    var_4 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "trigger");
  }

  if(isDefined(var_2) && var_2) {
    var_3 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "awaken");
  }

  if(isDefined(var_4) || isDefined(var_2) && var_2) {
    scripts\sp\utility::func_57D6();
  }

  var_3 notify("awaken");
  if(isDefined(self.var_EDCF)) {
    var_9 = self.var_EDCF;
    var_0A = getnode(self.target, "targetname");
    if(isDefined(var_0A)) {
      var_3 _meth_82F0(level.enableoffhandsecondaryweapons[var_9]);
    } else {
      var_3 _meth_82F1(level.enableoffhandsecondaryweapons[var_9]);
    }
  } else {
    var_3.var_BC = "no_cover";
  }

  var_3 give_mp_super_weapon(var_3.origin);
  var_3 func_A78D();
  scripts\sp\anim::func_1F35(var_3, "robot_power_on");
}

func_A762(var_0) {
  self endon("death");
  self endon("awaken");
  var_0 waittill("trigger");
  self delete();
}

func_A763(var_0) {
  self endon("spawned");
  var_0 waittill("trigger");
  self notify("disable_spawn");
}

func_E59D(var_0, var_1, var_2, var_3) {
  self endon("robot_locker_opened");
  if(isDefined(var_1)) {
    var_1 waittill("trigger");
  }

  var_4 = scripts\sp\utility::func_10639("robot", self.origin);
  var_5 = scripts\sp\utility::func_10639("locker_arm", self.origin);
  self.var_AF1E = var_5;
  self.var_6B53 = var_4;
  var_6 = [var_5, var_4];
  scripts\sp\anim::func_1EC1(var_6, "robot_locker_on");
  if(isDefined(self.script_noteworthy)) {
    thread func_E59A();
  }

  if(isDefined(var_3)) {
    var_3 waittill("trigger");
    if(isDefined(self.var_AF1E)) {
      self.var_AF1E delete();
    }

    if(isDefined(self.var_6B53)) {
      self.var_6B53 delete();
    }
  }
}

func_E59C(var_0) {
  if(isDefined(var_0)) {
    var_0 waittill("trigger");
  }

  var_1 = func_10752();
  var_2 = [self.var_AF1E, var_1];
  scripts\sp\anim::func_1EC3(self.var_AF1E, "robot_locker_on");
  thread scripts\sp\anim::func_1EEA(var_1, "robot_locker_idle");
  if(isDefined(self.var_6B53)) {
    self.var_6B53 delete();
  }

  var_3 = anglesToForward(self.angles);
  var_4 = self.origin + var_3 * 15;
  playFX(scripts\engine\utility::getfx("robot_locker_open"), var_4, var_3);
  func_E59B();
  var_5 = 2.2;
  var_6 = 1;
  foreach(var_8 in self.doors) {
    playworldsound("robot_locker_open", self.origin);
    var_9 = 45;
    if(var_8.script_parameters == "left") {
      var_9 = var_9 * -1;
    }

    var_8 rotateyaw(var_9, var_5, var_5 / 2, var_5 / 2);
    if(isDefined(var_6) && !var_6) {
      wait(randomfloatrange(0.1, 0.3));
    }

    var_6 = undefined;
  }

  wait(var_5 / 2);
  self notify("stop_loop");
  var_1 givescorefortrophyblocks();
  scripts\sp\anim::func_1F2C(var_2, "robot_locker_on");
  var_3 = anglesToForward(self.angles);
  var_0B = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  var_1 linkto(var_0B);
  var_0C = var_0B.origin + var_3 * 40;
  var_0B moveto(var_0C, 0.2);
  wait(0.2);
  var_1 unlink();
  var_0B delete();
  var_1 scripts\sp\utility::func_1101B();
  var_1 scripts\sp\utility::func_6224();
  var_1.precacheleaderboards = 0;
  var_1.ignoreme = 0;
  var_1 give_mp_super_weapon(var_1.origin);
  if(isDefined(self.var_EDCF)) {
    var_1 _meth_82F1(level.enableoffhandsecondaryweapons[self.var_EDCF]);
  }

  self notify("robot_locker_opened");
  return var_1;
}

func_E59A() {
  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  var_0 = 0;
  switch (self.script_noteworthy) {
    case "open_full":
      self.var_6B53 delete();
      self.var_6B53 = func_10752();
      var_1 = [self.var_AF1E, self.var_6B53];
      thread scripts\sp\anim::func_1F2C(var_1, "robot_locker_on");
      scripts\engine\utility::waitframe();
      var_2 = 2;
      foreach(var_4 in var_1) {
        var_5 = var_4 scripts\sp\utility::func_7DC1("robot_locker_on");
        var_6 = getanimlength(var_5);
        var_7 = var_2 / var_6;
        var_4 _meth_82B0(var_5, var_7);
      }

      scripts\sp\anim::func_1F27(var_1, "robot_locker_on", 0);
      var_0 = 1;
      break;

    case "open_empty":
      self.var_6B53 delete();
      var_1 = [self.var_AF1E];
      thread scripts\sp\anim::func_1F2C(var_1, "robot_locker_on");
      scripts\engine\utility::waitframe();
      scripts\sp\anim::func_1F2A(var_1, "robot_locker_on", 0.6);
      scripts\sp\anim::func_1F27(var_1, "robot_locker_on", 0);
      var_0 = 1;
      break;
  }

  func_E59B();
  if(var_0) {
    foreach(var_0A in self.doors) {
      var_0B = 45;
      if(var_0A.script_parameters == "left") {
        var_0B = var_0B * -1;
      }

      var_0A rotateyaw(var_0B, 0.05);
    }
  }
}

func_E59B() {
  if(isDefined(self.doors)) {
    return;
  }

  var_0 = scripts\sp\utility::func_7A8F();
  var_1 = [];
  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  self.doors = var_1;
  return self;
}

func_10752(var_0, var_1) {
  func_1776("lab_robot");
  if(scripts\engine\utility::cointoss()) {
    level.var_E5AD.var_C1 = 999;
    var_2 = level.var_E5AD scripts\sp\utility::func_10619(1);
  } else {
    var_3 = randomintrange(0, 100);
    if(var_3 <= 80) {
      level.var_E5AF.var_C1 = 999;
      var_2 = level.var_E5AF scripts\sp\utility::func_10619(1);
    } else {
      level.var_E5AE.var_C1 = 999;
      var_2 = level.var_E5AE scripts\sp\utility::func_10619(1);
    }
  }

  var_2 scripts\sp\utility::func_B14F(1);
  var_2 scripts\sp\utility::func_F2DA(0);
  var_2 scripts\sp\utility::func_5564();
  if(isDefined(level.var_E5C0)) {
    var_2 thread[[level.var_E5C0]]();
  }

  var_2.var_1FBB = "robot";
  if(isDefined(var_0)) {
    var_2 _meth_82F1(level.enableoffhandsecondaryweapons[var_0]);
  }

  if(isDefined(self.var_EDD2)) {
    var_2.objective_state = self.var_EDD2;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.var_ECE7)) {
      var_1 = self.var_ECE7;
    }
  }

  if(isDefined(var_1)) {
    if(!isDefined(level.var_1162[var_1])) {
      lib_0B77::func_1A12(var_1);
    }

    var_2 thread lib_0B77::func_1A14(level.var_1162[var_1]);
  }

  self notify("spawned");
  return var_2;
}

func_E598() {
  self waittill("death");
  if(!isDefined(self)) {}
}

func_E5B0() {
  self endon("entitydeleted");
  scripts\engine\utility::waittill_either("death", "awaken");
}

func_A78D() {
  self.ignoreme = 0;
  self.precacheleaderboards = 0;
  scripts\sp\utility::func_6224();
  if(isDefined(self.var_B14F)) {
    scripts\sp\utility::func_1101B();
  }
}

func_6473() {
  var_0 = [level.var_EBBB, level.var_EBBC];
  var_1 = [];
  var_2 = [0, 1];
  foreach(var_6, var_4 in var_0) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("tag_origin");
    var_5 linkto(var_4, "j_Head", (0, 0, 0), anglesToForward(var_4.angles) + (-180, 90, 0), 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_5);
    playFXOnTag(level._effect["friendly_flashlight"], var_5, "tag_origin");
    wait(var_2[var_6]);
  }
}

func_A796() {
  var_0 = [level.var_EBBB, level.var_EBBC];
  var_1 = [];
  var_2 = [0, 1];
  foreach(var_6, var_4 in var_0) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("tag_origin");
    var_5 linkto(var_4, "j_Head", (0, 0, 0), anglesToForward(var_4.angles) + (-180, 90, 0), 1);
    var_1 = scripts\engine\utility::array_add(var_1, var_5);
    playFXOnTag(level._effect["friendly_flashlight"], var_5, "tag_origin");
    wait(var_2[var_6]);
  }

  wait(0.4);
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
  foreach(var_9 in var_1) {
    var_9 delete();
  }
}

func_6244(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    if(!isDefined(level.var_EBBB)) {
      wait(0.05);
    }

    if(!isDefined(level.var_EBBC)) {
      wait(0.05);
    }
  }

  var_1 = [level.var_EBBB, level.var_EBBC];
  foreach(var_3 in var_1) {
    var_3 scripts\sp\utility::func_61E7(1);
  }
}

func_558F(var_0) {
  if(isDefined(var_0) && var_0 == 1) {
    if(!isDefined(level.var_EBBB)) {
      wait(0.05);
    }

    if(!isDefined(level.var_EBBC)) {
      wait(0.05);
    }
  }

  var_1 = [level.var_EBBB, level.var_EBBC];
  foreach(var_3 in var_1) {
    var_3 scripts\sp\utility::func_5514();
  }
}

func_C807(var_0) {
  level.player scripts\sp\utility::play_sound_on_entity(var_0);
}

func_133A1() {
  level.player freezecontrols(1);
  level.player getradiuspathsighttestnodes();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player getnumownedagentsonteambytype(0);
}

func_133A2() {
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player getnumownedagentsonteambytype(1);
}

func_10F59(var_0, var_1, var_2) {
  level endon("stealthtakedownComplete");
  var_3 = spawnStruct();
  if(isDefined(var_2)) {
    level endon(var_2);
    var_3.var_C6BA = var_2;
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  var_3.enemies = var_0;
  var_3.var_2E = var_1;
  var_3.var_D435 = undefined;
  var_3.var_7423 = undefined;
  var_3.var_10D8F = 0;
  var_3.finished = 0;
  var_3.var_D3C9 = 0;
  level childthread func_10F56(var_3);
  level childthread func_10F57(var_3);
  level childthread func_10F54(var_3);
  scripts\engine\utility::array_thread(var_3.enemies, ::func_10F53, var_3);
  level.var_4BC1 = var_3;
  level waittill("stealthtakedownComplete");
}

func_10F57(var_0) {
  for(;;) {
    wait(0.5);
    foreach(var_2 in var_0.enemies) {
      if(!isalive(var_2)) {
        continue;
      }

      if(isDefined(var_2.var_10E6D)) {
        if(var_2.var_10E6D.state != 0 && !isDefined(var_0.var_D435)) {
          var_0.var_10D8F = 1;
          if(!var_0.var_D3C9) {
            var_0.var_D435 = var_2;
          }

          var_0 thread func_10F58(var_2);
          var_0 notify("cleartoengage");
          return;
        }

        continue;
      }

      if(isDefined(var_2.var_10F49)) {
        if(isDefined(var_2.var_10F49.var_2521) && var_2.var_10F49.var_2521 && !isDefined(var_0.var_D435)) {
          var_0.var_10D8F = 1;
          if(!var_0.var_D3C9) {
            var_0.var_D435 = var_2;
          }

          var_0 thread func_10F58(var_2);
          var_0 notify("cleartoengage");
          return;
        }
      }
    }
  }
}

func_10F58(var_0) {
  wait(1);
  if(isalive(var_0)) {
    self.var_10306 = 1;
  }
}

func_10F52(var_0) {
  for(;;) {
    var_0.enemies = scripts\sp\utility::array_removedeadvehicles(var_0.enemies);
    if(var_0.enemies.size < 2) {
      return;
    }

    foreach(var_2 in var_0.enemies) {
      if(func_D35D(var_2)) {
        wait(1);
        if(func_D35D(var_2) && !var_0.var_10D8F) {
          thread scripts\sp\utility::func_16C5("Wolf", "Target in sight.");
          return;
        }
      }
    }

    wait(0.5);
  }
}

func_10F53(var_0) {
  if(isDefined(var_0.var_C6BA)) {
    self endon(var_0.var_C6BA);
  }

  for(;;) {
    self waittill("damage", var_1, var_2);
    var_0.var_10D8F = 1;
    if(!isDefined(var_0.var_D435) && isDefined(var_2) && var_2 == level.player || isDefined(var_2.asmname) && var_2.asmname == "seeker") {
      var_0.var_D435 = self;
      var_0.var_D3C9 = 1;
      if(isalive(self)) {
        self _meth_81D0(self.origin, level.player);
      }
    }

    var_0 notify("cleartoengage");
  }
}

func_10F56(var_0) {
  var_0 waittill("cleartoengage");
  level notify("stealthtakedown_start");
  wait(0.65);
  var_1 = undefined;
  var_2 = 0;
  var_3 = var_0.enemies.size;
  var_4 = 0.5;
  var_5 = 2;
  foreach(var_7 in var_0.enemies) {
    var_3--;
    if(var_0.var_D435 == var_7) {
      continue;
    } else {
      if(isDefined(var_0.var_2E[var_2])) {
        var_1 = var_0.var_2E[var_2];
      } else {
        var_1 = var_0.var_2E[0];
      }

      var_0.var_7423 = var_7;
      var_1 func_10F55(var_0.var_7423);
      var_2++;
    }

    var_8 = scripts\engine\utility::ter_op(var_3 == 2, var_5, var_4);
    wait(var_8);
  }

  var_0 notify("friendlies_done_attacking");
}

func_10F55(var_0) {
  self endon("death");
  var_1 = 5000;
  var_2 = gettime() + var_1;
  while(gettime() < var_2) {
    if(scripts\sp\detonategrenades::func_385C(self getEye(), var_0)) {
      break;
    }

    wait(0.05);
  }

  if(isalive(var_0)) {
    magicbullet(self.var_394, self gettagorigin("tag_flash"), var_0 getEye());
  }

  wait(0.25);
  if(isalive(var_0)) {
    var_0 _meth_81D0(var_0.origin, self);
  }
}

func_10F54(var_0) {
  for(;;) {
    if(var_0.var_10D8F) {
      var_0 waittill("friendlies_done_attacking");
      if(!var_0.var_D3C9) {
        var_0.var_10306 = 1;
        scripts\engine\utility::random(var_0.var_2E) func_10F55(var_0.var_D435);
        wait(0.5);
        thread func_134B7("europa_sip_stayfocusedwolf");
      } else {
        wait(0.35);
      }

      var_0.finished = 1;
      level notify("stealthtakedownComplete");
      return;
    }

    wait(0.05);
  }
}

func_D35D(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(level.player adsbuttonpressed() && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0.origin, cos(5))) {
    if(scripts\sp\detonategrenades::func_385C(level.player getEye(), var_0)) {
      return 1;
    }
  }

  return 0;
}

func_10F49() {
  self endon("shutdown_stealthlight");
  self endon("death");
  setdvarifuninitialized("debug_stealthlight", 0);
  self.var_10F49 = spawnStruct();
  self.var_10F49.var_2521 = 0;
  self getnodeyawfromoffsettable("gunshot");
  self getnodeyawfromoffsettable("gunshot_teammate");
  self getnodeyawfromoffsettable("bulletwhizby");
  self getnodeyawfromoffsettable("projectile_impact");
  self getnodeyawfromoffsettable("explode");
  self getnodeyawfromoffsettable("silenced_shot");
  setsaveddvar("ai_eventdistsilencedshot", 800);
  self.precacheleaderboards = 1;
  childthread func_10F4D();
  childthread func_10F4C();
  childthread func_10F4B();
  self waittill("stealthlight_attack");
  self.var_10F49.var_2521 = 1;
  func_10FC2();
  self.precacheleaderboards = 0;
  foreach(var_1 in getaiunittypearray("axis", "soldier")) {
    if(distance(self.origin, var_1.origin) < 800 && !var_1 func_10F4A()) {
      var_1 thread scripts\sp\utility::func_C12D("stealthlight_attack", randomfloatrange(0.4, 2));
    }
  }

  self _meth_8260("bulletwhizby");
  self _meth_8260("explode");
  setsaveddvar("ai_eventdistsilencedshot", 128);
  self notify("shutdown_stealthlight");
}

func_10F4B() {
  for(;;) {
    self waittill("ai_events", var_0);
    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

func_10F4F() {
  for(;;) {
    self waittill("gunshot");
    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

func_10F4E() {
  for(;;) {
    self waittill("explode");
    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

func_10F4D() {
  for(;;) {
    self waittill("damage", var_0, var_1);
    if(isDefined(var_1) && var_1 == level.player) {
      if(getdvarint("debug_stealthlight")) {}

      self notify("stealthlight_attack");
    }
  }
}

func_10F4C() {
  var_0 = 400;
  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < var_0 * var_0) {
      if(self getpersstat(level.player)) {
        if(getdvarint("debug_stealthlight")) {}

        self notify("stealthlight_attack");
      }
    }

    wait(1);
  }
}

func_10F50() {
  for(;;) {
    self waittill("bulletwhizby");
    if(getdvarint("debug_stealthlight")) {}

    self notify("stealthlight_attack");
  }
}

func_10F4A() {
  if(isDefined(self.var_10F49) && self.var_10F49.var_2521) {
    return 1;
  }

  return 0;
}

func_1108E() {
  self _meth_8260("bulletwhizby");
  self _meth_8260("explode");
  self notify("shutdown_stealthlight");
  self.precacheleaderboards = 0;
}

func_D988(var_0) {
  if(isDefined(level.var_116B1)) {
    return;
  }

  var_1 = scripts\sp\math::func_6A8E(-298, -376, var_0);
  level.player setclientomnvar("ui_helmet_meter_temperature", int(var_1));
}

func_982F(var_0) {
  level.var_116B1 = 1;
  var_1 = gettime() + var_0 * 1000;
  var_2 = -297;
  while(gettime() < var_1) {
    level.player setclientomnvar("ui_helmet_meter_temperature", int(var_2));
    var_2 = var_2 - 1;
    wait(1.5);
  }

  level.var_116B1 = undefined;
}

func_12992() {
  if(isDefined(level.var_11695) && level.var_11695) {
    return;
  }

  level.player setclientomnvar("ui_show_temperature_gauge", 1);
  level.var_11695 = 1;
  level.player playSound("ui_europa_temperature_warning");
}

func_12970() {
  if(isDefined(level.var_11695) && !level.var_11695) {
    return;
  }

  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  level.var_11695 = 0;
}

func_5F32(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  return var_1;
}

func_203B(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::flag(var_2)) {
      return 1;
    }
  }

  return 0;
}

func_117FF(var_0) {
  var_1 = level.player getweaponslist("primary");
  if(var_1.size > 1) {
    var_2 = level.player getcurrentprimaryweapon();
    foreach(var_4 in var_1) {
      if(var_2 != var_4) {
        level.player takeweapon(var_4);
        func_11801(var_4, var_0);
        break;
      }
    }
  }
}

func_11801(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.player getEye();
  }

  if(!isDefined(var_1)) {
    var_1 = 500;
  }

  var_3 = anglesToForward(level.player getplayerangles());
  var_4 = var_2 + (0, 0, -10) + var_3 * 16;
  var_5 = spawn("weapon_" + var_0, var_4);
  var_3 = anglesToForward(level.player getplayerangles() + (-20, 0, 0));
  var_6 = var_3 * var_1;
  var_5 physicslaunchserveritem(var_5.origin, var_6);
}

func_BE3C(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_nag_thread");
  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  if(!isDefined(var_3)) {
    var_3 = 5;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_5 = 2;
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  wait(3);
  var_6 = 0;
  var_7 = 0;
  if(isarray(var_0[0])) {
    if(isent(var_0[0][0])) {
      var_7 = 1;
      var_8 = var_0[0][1];
    } else {
      var_7 = 1;
      var_8 = var_1[0][1];
    }
  } else {
    var_8 = "";
  }

  for(;;) {
    if(func_203B(var_1)) {
      break;
    }

    var_0 = scripts\engine\utility::array_randomize(var_0);
    if(var_6 || var_7) {
      if(var_0.size > 1) {
        while(var_0[0][1] == var_8) {
          var_0 = scripts\engine\utility::array_randomize(var_0);
          wait(0.05);
        }
      }
    } else if(var_0.size > 1) {
      while(var_0[0] == var_8) {
        var_0 = scripts\engine\utility::array_randomize(var_0);
        wait(0.05);
      }
    }

    foreach(var_0A in var_0) {
      if(var_6) {
        thread scripts\sp\utility::func_16C5(var_0A[0], var_0A[1]);
        var_8 = var_0A[1];
      } else if(var_7) {
        var_0A[0] scripts\sp\utility::func_10346(var_0A[1]);
        var_8 = var_0A[1];
      } else {
        scripts\sp\utility::func_10346(var_0A);
        var_8 = var_0A;
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

      if(func_203B(var_1)) {
        break;
      }
    }
  }
}

func_6F30() {
  func_95E7();
  var_0 = scripts\engine\utility::getstructarray("fling_object", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_6F2E();
  }
}

func_95E7(var_0) {
  level.var_6F2F = [];
  level.var_6F2F[level.var_6F2F.size] = "blackice_coupler_gray";
  level.var_6F2F[level.var_6F2F.size] = "boots_civ_miner_burnt_01_left";
  level.var_6F2F[level.var_6F2F.size] = "boots_civ_miner_burnt_01_right";
  level.var_6F2F[level.var_6F2F.size] = "clk_lab_compoundanalyzer_01_device03";
  level.var_6F2F[level.var_6F2F.size] = "cnd_laptop_001_open_off";
  level.var_6F2F[level.var_6F2F.size] = "com_extinguisher_wallmount";
  level.var_6F2F[level.var_6F2F.size] = "com_office_book_red_flat";
  level.var_6F2F[level.var_6F2F.size] = "com_studiolight_hanging_off";
  level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_box_cover";
  level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_b";
  level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_e";
  level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_g2";
  level.var_6F2F[level.var_6F2F.size] = "consumer_grade_pc_opened";
  level.var_6F2F[level.var_6F2F.size] = "consumer_grade_pc_tower";
  level.var_6F2F[level.var_6F2F.size] = "container_ammo_box_01";
  level.var_6F2F[level.var_6F2F.size] = "ctl_biometric_lock";
  level.var_6F2F[level.var_6F2F.size] = "cup_paper_open_iw6";
  level.var_6F2F[level.var_6F2F.size] = "emergency_stop_box_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_aid_oxygen_tank_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_computer_screen_01_arm";
  level.var_6F2F[level.var_6F2F.size] = "equipment_field_computer_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_access_keypad_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_hand_clamp_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_pliers_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_power_drill_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_rivet_tool_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_screwdriver_02";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_toolbox_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_wrench_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_memory_chip_01";
  level.var_6F2F[level.var_6F2F.size] = "equipment_wall_mounted_phone_01_white";
  level.var_6F2F[level.var_6F2F.size] = "equipment_wall_mounted_phone_01_yellow";
  level.var_6F2F[level.var_6F2F.size] = "fac_keyboard";
  level.var_6F2F[level.var_6F2F.size] = "fire_extinguisher_digital";
  level.var_6F2F[level.var_6F2F.size] = "furniture_exam_stool_01";
  level.var_6F2F[level.var_6F2F.size] = "hjk_clipboard_wpaper";
  level.var_6F2F[level.var_6F2F.size] = "hjk_plane_debris_cable_sml_2";
  level.var_6F2F[level.var_6F2F.size] = "ind_pipe_metal_hp_4_coupling";
  level.var_6F2F[level.var_6F2F.size] = "ind_railing_01_32_d";
  level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_bend_elbow_white";
  level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_end_white";
  level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_joint_c_white";
  level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_coupling_screw";
  level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_coupling_screw_white";
  level.var_6F2F[level.var_6F2F.size] = "lab_microscope";
  level.var_6F2F[level.var_6F2F.size] = "light_ceiling_corridor_01";
  level.var_6F2F[level.var_6F2F.size] = "loki_wif_socket";
  level.var_6F2F[level.var_6F2F.size] = "misc_duffelbag_03";
  level.var_6F2F[level.var_6F2F.size] = "misc_interior_multi_tool_01";
  level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_black";
  level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_blue";
  level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_red";
  level.var_6F2F[level.var_6F2F.size] = "mp_weapon_crate";
  level.var_6F2F[level.var_6F2F.size] = "office_paper_piece01_iw6";
  level.var_6F2F[level.var_6F2F.size] = "p7_chain_metal_str_64_hook";
  level.var_6F2F[level.var_6F2F.size] = "p7_desk_metal_military_03_tablet";
  level.var_6F2F[level.var_6F2F.size] = "portable_battery_pack_01";
  level.var_6F2F[level.var_6F2F.size] = "sign_ind_misc_03";
  level.var_6F2F[level.var_6F2F.size] = "sign_ind_misc_12";
  level.var_6F2F[level.var_6F2F.size] = "space_aid_supplybag_01";
  level.var_6F2F[level.var_6F2F.size] = "space_bracket_01_metal_painted";
  level.var_6F2F[level.var_6F2F.size] = "space_interior_handle_med_blue";
  level.var_6F2F[level.var_6F2F.size] = "space_interior_pack_square";
  level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_green";
  level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_orange";
  level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_white";
  if(isDefined(var_0)) {
    foreach(var_2 in level.var_6F2F) {
      precachemodel(var_2);
    }

    level.var_6F2F = undefined;
  }
}

func_6F2E() {
  var_0 = 200;
  var_1 = [];
  for(var_2 = self; isDefined(var_2.target); var_2 = var_3) {
    var_1[var_1.size] = var_2;
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2.getclosestpointonnavmesh3d = 300;
  }

  self.path = func_4AF3(var_1, 1);
  self.var_C96D = self.path.segments[self.path.segments.size - 1].var_630D;
  var_4 = 2000;
  for(;;) {
    thread func_6F31(var_4);
    wait(randomfloatrange(0.2, 1));
  }
}

func_6F31(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel(level.var_6F2F[randomint(level.var_6F2F.size)]);
  var_1 notsolid();
  var_2 = randomintrange(300, 500);
  var_3 = randomintrange(-30, 30);
  var_4 = randomintrange(-50, 50);
  var_1 rotatevelocity((var_2, var_3, var_4), 100);
  var_5 = 0;
  var_6 = 50;
  var_0 = var_0 * 0.05;
  while(var_5 < self.var_C96D) {
    var_5 = var_5 + var_0;
    var_7 = func_4AEA(self.path, var_5);
    var_1.origin = var_7["pos"];
    wait(0.05);
  }

  var_1 delete();
}

func_6F2C() {
  self endon("death");
  var_0 = 100;
  for(;;) {
    var_1 = self.path.segments[self.path.segments.size - 1].var_630D;
    var_2 = func_4AEA(self.path, 0);
    var_3 = var_2["pos"];
    var_4 = 0;
    while(var_4 < var_1) {
      var_4 = var_4 + var_0;
      var_2 = func_4AEA(self.path, var_4);
      var_3 = var_2["pos"];
    }

    wait(0.05);
  }
}

func_AC90(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self _meth_8134();
  var_4 = var_0 - var_3 / var_2;
  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread func_AC91(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait(0.05);
  }

  var_6[0] = self;
  if(isDefined(self.var_AD22)) {
    var_6 = scripts\engine\utility::array_combine(var_6, self.var_AD22);
  }

  foreach(var_8 in var_6) {
    var_8 thread func_AC91(var_0);
    var_8 setlightintensity(var_0);
  }
}

func_AC91(var_0) {
  if(!isDefined(self.script_threshold)) {
    return;
  }

  var_1 = var_0 > self.script_threshold;
  foreach(var_3 in self.var_AD83) {
    if(var_1 && !var_3.var_13438) {
      var_3.var_13438 = var_1;
      var_3 show();
      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\sp\utility::func_E2B0();
      }

      continue;
    }

    if(!var_1 && var_3.var_13438) {
      var_3.var_13438 = var_1;
      var_3 hide();
      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }
  }

  foreach(var_3 in self.var_12BB6) {
    if(!var_1 && !var_3.var_13438) {
      var_3.var_13438 = 1;
      var_3 show();
      continue;
    }

    if(var_1 && var_3.var_13438) {
      var_3.var_13438 = 0;
      var_3 hide();
    }
  }
}

func_AC87(var_0) {
  func_AC90(var_0, 0.5);
}

func_AC86() {
  func_AC90(0, 0.5);
}

func_EF3F(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(!isDefined(var_5.var_9BB1)) {
      if(var_5 getscriptablepartstate(var_1) == var_2) {
        var_5 setscriptablepartstate(var_1, var_3);
      }
    }
  }
}

func_4AF3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.segments = [];
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_6 = 0;
  var_7 = [];
  var_8 = distance(var_0[0].origin, var_0[1].origin);
  while(isDefined(var_0[var_5.segments.size + 2])) {
    var_9 = var_5.segments.size;
    var_0A = var_0[var_9].origin;
    var_0B = var_0[var_9 + 1].origin;
    var_0C = var_0[var_9 + 2].origin;
    var_0D = var_8;
    var_8 = distance(var_0[var_9 + 1].origin, var_0[var_9 + 2].origin);
    var_0E = var_7;
    var_7 = func_4AE5(var_0A, var_0C, var_0D, var_8, 0.5);
    if(var_9 == 0) {
      if(isDefined(var_2)) {
        var_0E["outgoing"] = var_2 * var_0D;
      } else {
        var_0E = func_4AE6(var_0A, var_0B, var_7["incoming"]);
      }
    }

    if(var_4) {
      var_5.segments[var_9] = func_4AFC(var_0A, var_0B, var_0E["outgoing"], var_7["incoming"], var_0D);
      var_6 = var_6 + var_5.segments[var_9].var_630D;
      continue;
    }

    var_5.segments[var_9] = func_4AFB(var_0A, var_0B, var_0E["outgoing"], var_7["incoming"]);
    var_6 = var_6 + var_0D;
    var_5.segments[var_9].var_630D = var_6;
  }

  var_9 = var_5.segments.size;
  var_0A = var_0[var_9].origin;
  var_0B = var_0[var_9 + 1].origin;
  var_0D = var_8;
  var_0E = var_7;
  if(var_9 == 0 && isDefined(var_2)) {
    var_0E["outgoing"] = var_2 * var_0D;
  }

  if(isDefined(var_3)) {
    var_7["incoming"] = var_3 * var_0D;
  } else {
    var_7 = func_4AE6(var_0A, var_0B, var_0E["outgoing"]);
  }

  if(var_9 == 0 && !isDefined(var_2)) {
    var_0E = func_4AE6(var_0A, var_0B, var_7["incoming"]);
  }

  if(var_4) {
    var_5.segments[var_9] = func_4AFC(var_0A, var_0B, var_0E["outgoing"], var_7["incoming"], var_0D);
    var_6 = var_6 + var_5.segments[var_9].var_630D;
  } else {
    var_5.segments[var_9] = func_4AFB(var_0A, var_0B, var_0E["outgoing"], var_7["incoming"]);
    var_6 = var_6 + var_0D;
  }

  var_5.segments[var_9].var_630D = var_6;
  if(var_1) {
    var_0F = 0;
    var_10 = 0;
    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      if(!isDefined(var_0[var_9 + 1].getclosestpointonnavmesh3d)) {
        var_0[var_9 + 1].getclosestpointonnavmesh3d = var_0[var_9].getclosestpointonnavmesh3d;
      }

      var_0D = var_5.segments[var_9].var_630D - var_10;
      var_11 = 2 * var_0D / var_0[var_9].getclosestpointonnavmesh3d + var_0[var_9 + 1].getclosestpointonnavmesh3d / 20;
      var_0F = var_0F + var_11;
      var_5.segments[var_9].var_6393 = var_0F;
      var_10 = var_5.segments[var_9].var_630D;
      var_5.segments[var_9].var_109B1 = var_0[var_9].getclosestpointonnavmesh3d / 20;
      var_5.segments[var_9].var_109A8 = var_0[var_9 + 1].getclosestpointonnavmesh3d / 20;
    }
  } else {
    for(var_9 = 0; var_9 < var_5.segments.size; var_9++) {
      var_5.segments[var_9].var_6393 = var_5.segments[var_9].var_630D;
      var_5.segments[var_9].var_109B1 = 1;
      var_5.segments[var_9].var_109A8 = 1;
    }
  }

  return var_5;
}

func_4AE5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  for(var_7 = 0; var_7 < 3; var_7++) {
    var_5[var_7] = 1 - var_4 * var_1[var_7] - var_0[var_7];
    var_6[var_7] = var_5[var_7];
    var_5[var_7] = var_5[var_7] * 2 * var_2 / var_2 + var_3;
    var_6[var_7] = var_6[var_7] * 2 * var_3 / var_2 + var_3;
  }

  var_8 = [];
  var_8["incoming"] = (var_5[0], var_5[1], var_5[2]);
  var_8["outgoing"] = (var_6[0], var_6[1], var_6[2]);
  return var_8;
}

func_4AE6(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = [];
  var_5 = [];
  if(isDefined(var_2)) {
    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_4[var_6] = -3 * var_0[var_6] + 3 * var_1[var_6] - var_2[var_6] / 2;
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

func_4AFB(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = spawnStruct();
  var_5.var_BE20 = [];
  var_5.var_BE1F = [];
  var_5.var_BE21 = [];
  var_5.var_365F = [];
  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5.var_BE20[var_6] = 2 * var_0[var_6] - 2 * var_1[var_6] + var_2[var_6] + var_3[var_6];
    var_5.var_BE1F[var_6] = -3 * var_0[var_6] + 3 * var_1[var_6] - 2 * var_2[var_6] - var_3[var_6];
    var_5.var_BE21[var_6] = var_2[var_6];
    var_5.var_365F[var_6] = var_0[var_6];
  }

  return var_5;
}

func_4AFC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_4AFB(var_0, var_1, var_2, var_3);
  var_6 = func_4AFE(var_5, var_4);
  if(var_6 > 1) {
    var_4 = var_4 * var_6;
    var_2 = var_2 / var_6;
    var_3 = var_3 / var_6;
    var_5 = func_4AFB(var_0, var_1, var_2, var_3);
  }

  var_5.var_630D = var_4;
  return var_5;
}

func_4AFE(var_0, var_1) {
  var_2 = func_4AFF(var_0, var_1);
  return var_2;
}

func_4AFF(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  for(var_8 = 0; var_8 < 3; var_8++) {
    var_2 = var_2 + var_0.var_BE20[var_8] * var_0.var_BE20[var_8];
    var_3 = var_3 + var_0.var_BE20[var_8] * var_0.var_BE1F[var_8];
    var_4 = var_4 + var_0.var_BE20[var_8] * var_0.var_BE21[var_8];
    var_5 = var_5 + var_0.var_BE1F[var_8] * var_0.var_BE1F[var_8];
    var_6 = var_6 + var_0.var_BE1F[var_8] * var_0.var_BE21[var_8];
    var_7 = var_7 + var_0.var_BE21[var_8] * var_0.var_BE21[var_8];
  }

  var_9 = 36 * var_2;
  var_0A = 36 * var_3;
  var_0B = 12 * var_4 + 8 * var_5;
  var_0C = 4 * var_6;
  var_0D = [];
  var_0D[0] = 0;
  if(var_9 == 0) {
    if(var_0A == 0 && var_0B == 0 && var_0C == 0) {
      return sqrt(var_7) / var_1;
    }

    var_0E = func_E6EB(var_0A, var_0B, var_0C);
    if(isDefined(var_0E[0]) && var_0E[0] > 0 && var_0E[0] < 1) {
      var_0F = 2 * var_0A * var_0E[0] + var_0B;
      if(var_0F < 0) {
        var_0D[var_0D.size] = var_0E[0];
      }
    }

    if(isDefined(var_0E[1]) && var_0E[1] > 0 && var_0E[1] < 1) {
      var_0F = 2 * var_0A * var_0E[0] + var_0B;
      if(var_0F < 0) {
        var_0D[var_0D.size] = var_0E[1];
      }
    }
  } else {
    var_10 = func_E6EB(3 * var_9, 2 * var_0A, var_0B);
    var_11 = 0;
    var_12[0] = 0;
    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(var_10[var_11] > 0 && var_10[var_11] < 1) {
        var_12[var_12.size] = var_10[var_11];
      }
    }

    var_12[var_12.size] = 1;
    for(var_11 = 1; var_11 < var_12.size; var_11++) {
      var_13 = var_12[var_11 - 1];
      var_14 = var_12[var_11];
      var_15 = var_9 * var_13 * var_13 * var_13 + var_0A * var_13 * var_13 + var_0B * var_13 + var_0C;
      var_16 = var_9 * var_14 * var_14 * var_14 + var_0A * var_14 * var_14 + var_0B * var_14 + var_0C;
      if(var_15 > 0 && var_16 < 0) {
        var_0D[var_0D.size] = func_BF2D(var_13, var_14, var_9, var_0A, var_0B, var_0C, 0.02);
      }
    }
  }

  var_0D[var_0D.size] = 1;
  var_9 = 9 * var_2;
  var_0A = 12 * var_3;
  var_0B = 6 * var_4 + 4 * var_5;
  var_0C = 4 * var_6;
  var_17 = var_7;
  var_18 = 0;
  foreach(var_1A in var_0D) {
    var_1B = var_9 * var_1A * var_1A * var_1A * var_1A + var_0A * var_1A * var_1A * var_1A + var_0B * var_1A * var_1A + var_0C * var_1A + var_17;
    if(var_1B > var_18) {
      var_18 = var_1B;
    }
  }

  return sqrt(var_18) / var_1;
}

func_4AEA(var_0, var_1, var_2) {
  if(var_1 <= 0) {
    var_3 = var_0.segments[0].var_630D;
    var_4 = func_4B02(var_0.segments[0], 0, var_3, var_0.segments[0].var_109B1);
    return var_4;
  }

  if(var_3 >= var_2.segments[var_2.segments.size - 1].var_630D) {
    if(var_2.segments.size > 1) {
      var_3 = var_2.segments[var_2.segments.size - 1].var_630D - var_2.segments[var_2.segments.size - 2].var_630D;
    } else {
      var_3 = var_2.segments[var_2.segments.size - 1].var_630D;
    }

    var_4 = func_4B02(var_1.segments[var_1.segments.size - 1], 1, var_4, var_1.segments[var_1.segments.size - 1].var_109A8);
    return var_4;
  }

  for(var_5 = 0; var_2.segments[var_5].var_630D < var_3; var_5++) {}

  if(var_5 > 0) {
    var_6 = var_2.segments[var_5 - 1].var_630D;
  } else {
    var_6 = 0;
  }

  var_3 = var_2.segments[var_5].var_630D - var_6;
  var_7 = var_2 - var_5 / var_6;
  var_8 = undefined;
  if(isDefined(var_3) && var_3) {
    var_8 = func_4AF7(var_1.segments[var_4].var_109B1, var_1.segments[var_4].var_109A8, var_7);
  }

  var_4 = func_4B02(var_1.segments[var_4], var_7, var_6, var_8);
  return var_8;
}

func_4AF7(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = var_1 - var_0 * var_1 + var_0 / 2;
  return sqrt(2 * var_4 * var_3 + var_0 * var_0);
}

func_4B02(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_5[var_9] = var_0.var_BE20[var_9] * var_1 * var_1 * var_1 + var_0.var_BE1F[var_9] * var_1 * var_1 + var_0.var_BE21[var_9] * var_1 + var_0.var_365F[var_9];
    var_6[var_9] = 3 * var_0.var_BE20[var_9] * var_1 * var_1 + 2 * var_0.var_BE1F[var_9] * var_1 + var_0.var_BE21[var_9];
    var_7[var_9] = 6 * var_0.var_BE20[var_9] * var_1 + 2 * var_0.var_BE1F[var_9];
  }

  var_8["pos"] = (var_5[0], var_5[1], var_5[2]);
  var_8["vel"] = (var_6[0], var_6[1], var_6[2]);
  var_8["acc"] = (var_7[0], var_7[1], var_7[2]);
  if(isDefined(var_2)) {
    var_8["vel"] = var_8["vel"] / var_2;
    var_8["acc"] = var_8["acc"] / var_2 * var_2;
  }

  if(isDefined(var_3)) {
    var_8["vel"] = var_8["vel"] * var_3;
    var_8["acc"] = var_8["acc"] * var_3 * var_3;
  }

  var_8["speed"] = var_3;
  return var_8;
}

func_BF2D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 5;
  var_8 = var_0 + var_1 / 2;
  var_9 = var_6 + 1;
  while(abs(var_9) > var_6 && var_7 > 0) {
    var_0A = var_2 * var_8 * var_8 * var_8 + var_3 * var_8 * var_8 + var_4 * var_8 + var_5;
    var_0B = 3 * var_2 * var_8 * var_8 + 2 * var_3 * var_8 + var_4;
    var_9 = -1 * var_0A / var_0B;
    var_0C = var_8;
    var_8 = var_8 + var_9;
    if(var_8 > var_1) {
      var_8 = var_0C + 3 * var_1 / 4;
      continue;
    }

    if(var_8 < var_0) {
      var_8 = var_0C + 3 * var_0 / 4;
    }

    var_7--;
  }

  return var_8;
}

func_E6EB(var_0, var_1, var_2) {
  while(abs(var_0) > 65536 || abs(var_1) > 65536 || abs(var_2) > 65536) {
    var_0 = var_0 / 10;
    var_1 = var_1 / 10;
    var_2 = var_2 / 10;
  }

  var_3 = [];
  if(var_0 == 0) {
    if(var_1 != 0) {
      var_3[0] = -1 * var_2 / var_1;
    }
  } else {
    var_4 = var_1 * var_1 - 4 * var_0 * var_2;
    if(var_4 > 0) {
      var_3[0] = -1 * var_1 - sqrt(var_4) / 2 * var_0;
      var_3[1] = -1 * var_1 + sqrt(var_4) / 2 * var_0;
    } else if(var_4 == 0) {
      var_3[0] = -1 * var_1 / 2 * var_0;
    }
  }

  return var_3;
}

func_67B6(var_0, var_1, var_2, var_3) {
  objective_add(var_0, var_1);
  objective_string(var_0, var_2);
  if(!isDefined(var_3)) {
    return;
  }

  scripts\engine\utility::flag_wait(var_3);
  objective_state(var_0, "done");
}