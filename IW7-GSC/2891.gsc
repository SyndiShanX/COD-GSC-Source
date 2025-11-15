/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2891.gsc
***************************************/

func_EB77(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  level.player endon("death");

  if(level.player.health == 0) {
    return;
  }
  var_02 = level.player getcurrentprimaryweapon();

  if(!isDefined(var_02) || var_02 == "none") {}

  game["weaponstates"][var_00]["current"] = var_02;
  var_03 = level.player getcurrentoffhand();
  game["weaponstates"][var_00]["offhand"] = var_03;
  game["weaponstates"][var_00]["list"] = [];
  var_04 = scripts\engine\utility::array_combine(level.player getweaponslistprimaries(), level.player getweaponslistall());

  for(var_05 = 0; var_05 < var_4.size; var_5++) {
    game["weaponstates"][var_00]["list"][var_05]["name"] = var_4[var_05];

    if(var_01) {
      game["weaponstates"][var_00]["list"][var_05]["clip"] = level.player getweaponammoclip(var_4[var_05]);
      game["weaponstates"][var_00]["list"][var_05]["stock"] = level.player getweaponammostock(var_4[var_05]);
    }
  }
}

func_E2E3(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::ter_op(isDefined(var_02) && var_02, ::switchtoweaponimmediate, ::switchtoweapon);

  if(!isDefined(var_01))
    var_01 = 0;

  if(!isDefined(game["weaponstates"]))
    return 0;

  if(!isDefined(game["weaponstates"][var_00]))
    return 0;

  level.player takeallweapons();

  for(var_04 = 0; var_04 < game["weaponstates"][var_00]["list"].size; var_4++) {
    var_05 = game["weaponstates"][var_00]["list"][var_04]["name"];

    if(var_05 == "c4") {
      continue;
    }
    if(var_05 == "claymore") {
      continue;
    }
    level.player giveweapon(var_05);
    level.player givemaxammo(var_05);

    if(var_01) {
      level.player setweaponammoclip(var_05, game["weaponstates"][var_00]["list"][var_04]["clip"]);
      level.player setweaponammostock(var_05, game["weaponstates"][var_00]["list"][var_04]["stock"]);
    }
  }

  level.player giveunifiedpoints(game["weaponstates"][var_00]["offhand"]);
  level.player call[[var_03]](game["weaponstates"][var_00]["current"]);
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
  if(isDefined(level.func_AE21))
    return level.func_AE21;

  return level.script;
}

func_37E7(var_00) {
  level.func_1303 = var_00;
}

persist(var_00, var_01, var_02) {
  var_03 = func_7AA6();

  if(var_00 != var_03) {
    return;
  }
  if(!isDefined(game["previous_map"])) {
    return;
  }
  level.func_1304 = 1;

  if(isDefined(var_02))
    level.player give_player_xp(var_02);

  func_E2E3(func_7AA6(), 1);
  level.func_8B8E = 1;
}

func_AE21(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(isDefined(var_00)) {
    var_08 = func_7AA6();

    if(var_00 != var_08 || isDefined(level.func_1304))
      return;
  }

  if(isDefined(var_01)) {
    if(var_01 == "iw7_ar57")
      var_01 = "iw7_ar57+ar57scope";

    level.default_weapon = var_01;
    level.player giveweapon(var_01);
  }

  if(isDefined(var_06)) {
    if(var_06 == "iw7_erad")
      var_06 = "iw7_erad+eradscope";

    level.player give_player_xp(var_06);
  }

  if(isDefined(var_02))
    level.player giveweapon(var_02);

  if(isDefined(var_03))
    level.player giveweapon(var_03);

  if(isDefined(var_04))
    level.player giveweapon(var_04);

  level.player switchtoweapon(var_01);

  if(isDefined(var_05))
    level.player setviewmodel(var_05);

  level.func_37E7 = level.func_1303;
  level.func_1303 = undefined;
  level.func_8B8E = 1;

  if(isDefined(var_07))
    func_F551(var_07);
}

func_F551(var_00) {
  level.func_D32B = var_00;
  precachemodel(level.func_D32B);
}

func_AE27() {
  level.func_AE64 = 1;
  level notify("loadout complete");
}

func_4FFD() {
  if(level.func_8B8E) {
    return;
  }
  func_AE21(undefined, "iw7_ar57_reflex", undefined, "flash_grenade", "fraggrenade", "viewmodel_base_viewhands", "flash");
  level.func_B32C = 1;
}