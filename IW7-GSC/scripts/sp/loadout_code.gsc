/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\loadout_code.gsc
***************************************/

func_EB77(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  level.player endon("death");
  if(level.player.health == 0) {
    return;
  }

  var_02 = level.player getcurrentprimaryweapon();
  if(!isDefined(var_02) || var_02 == "none") {}

  game["weaponstates"][param_00]["current"] = var_02;
  var_03 = level.player getcurrentoffhand();
  game["weaponstates"][param_00]["offhand"] = var_03;
  game["weaponstates"][param_00]["list"] = [];
  var_04 = scripts\engine\utility::array_combine(level.player getweaponslistprimaries(), level.player getweaponslistoffhands());
  for(var_05 = 0; var_05 < var_04.size; var_05++) {
    game["weaponstates"][param_00]["list"][var_05]["name"] = var_04[var_05];
    if(param_01) {
      game["weaponstates"][param_00]["list"][var_05]["clip"] = level.player getweaponammoclip(var_04[var_05]);
      game["weaponstates"][param_00]["list"][var_05]["stock"] = level.player getweaponammostock(var_04[var_05]);
    }
  }
}

func_E2E3(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::ter_op(isDefined(param_02) && param_02, ::switchtoweaponimmediate, ::switchtoweapon);
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(game["weaponstates"])) {
    return 0;
  }

  if(!isDefined(game["weaponstates"][param_00])) {
    return 0;
  }

  level.player takeallweapons();
  for(var_04 = 0; var_04 < game["weaponstates"][param_00]["list"].size; var_04++) {
    var_05 = game["weaponstates"][param_00]["list"][var_04]["name"];
    if(var_05 == "c4") {
      continue;
    }

    if(var_05 == "claymore") {
      continue;
    }

    level.player giveweapon(var_05);
    level.player givemaxammo(var_05);
    if(param_01) {
      level.player setweaponammoclip(var_05, game["weaponstates"][param_00]["list"][var_04]["clip"]);
      level.player setweaponammostock(var_05, game["weaponstates"][param_00]["list"][var_04]["stock"]);
    }
  }

  level.player giveunifiedpoints(game["weaponstates"][param_00]["offhand"]);
  level.player[[var_03]](game["weaponstates"][param_00]["current"]);
  return 1;
}

func_F6B5() {
  self setactionslot(1, "");
  self setactionslot(2, "altMode");
  self setactionslot(3, "");
  self setactionslot(4, "");
}

func_96D7() {
  func_F6B5();
  self takeallweapons();
}

func_7AA6() {
  if(isDefined(level.var_AE21)) {
    return level.var_AE21;
  }

  return level.script;
}

func_37E7(param_00) {
  level.var_1303 = param_00;
}

persist(param_00, param_01, param_02) {
  var_03 = func_7AA6();
  if(param_00 != var_03) {
    return;
  }

  if(!isDefined(game["previous_map"])) {
    return;
  }

  level.var_1304 = 1;
  if(isDefined(param_02)) {
    level.player give_player_xp(param_02);
  }

  func_E2E3(func_7AA6(), 1);
  level.var_8B8E = 1;
}

func_AE21(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_00)) {
    var_08 = func_7AA6();
    if(param_00 != var_08 || isDefined(level.var_1304)) {
      return;
    }
  }

  if(isDefined(param_01)) {
    if(param_01 == "iw7_ar57") {
      param_01 = "iw7_ar57+ar57scope";
    }

    level.default_weapon = param_01;
    level.player giveweapon(param_01);
  }

  if(isDefined(param_06)) {
    if(param_06 == "iw7_erad") {
      param_06 = "iw7_erad+eradscope";
    }

    level.player give_player_xp(param_06);
  }

  if(isDefined(param_02)) {
    level.player giveweapon(param_02);
  }

  if(isDefined(param_03)) {
    level.player giveweapon(param_03);
  }

  if(isDefined(param_04)) {
    level.player giveweapon(param_04);
  }

  level.player switchtoweapon(param_01);
  if(isDefined(param_05)) {
    level.player givegoproattachments(param_05);
  }

  level.var_37E7 = level.var_1303;
  level.var_1303 = undefined;
  level.var_8B8E = 1;
  if(isDefined(param_07)) {
    func_F551(param_07);
  }
}

func_F551(param_00) {
  level.var_D32B = param_00;
  precachemodel(level.var_D32B);
}

func_AE27() {
  level.var_AE64 = 1;
  level notify("loadout complete");
}

func_4FFD() {
  if(level.var_8B8E) {
    return;
  }

  func_AE21(undefined, "iw7_ar57_reflex", undefined, "flash_grenade", "fraggrenade", "viewmodel_base_viewhands", "flash");
  level.var_B32C = 1;
}