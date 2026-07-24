/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2891.gsc
**************************************/

_id_EB77(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.player endon("death");

  if(level.player.health == 0) {
    return;
  }
  var_2 = level.player getcurrentprimaryweapon();

  if(!isDefined(var_2) || var_2 == "none") {}

  game["weaponstates"][var_0]["current"] = var_2;
  var_3 = level.player getcurrentoffhand();
  game["weaponstates"][var_0]["offhand"] = var_3;
  game["weaponstates"][var_0]["list"] = [];
  var_4 = scripts\engine\utility::array_combine(level.player getweaponslistprimaries(), level.player getweaponslistall());

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    game["weaponstates"][var_0]["list"][var_5]["name"] = var_4[var_5];

    if(var_1) {
      game["weaponstates"][var_0]["list"][var_5]["clip"] = level.player getweaponammoclip(var_4[var_5]);
      game["weaponstates"][var_0]["list"][var_5]["stock"] = level.player getweaponammostock(var_4[var_5]);
    }
  }
}

_id_E2E3(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(isDefined(var_2) && var_2, ::switchtoweaponimmediate, ::switchtoweapon);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(game["weaponstates"])) {
    return 0;
  }

  if(!isDefined(game["weaponstates"][var_0])) {
    return 0;
  }

  level.player takeallweapons();

  for(var_4 = 0; var_4 < game["weaponstates"][var_0]["list"].size; var_4++) {
    var_5 = game["weaponstates"][var_0]["list"][var_4]["name"];

    if(var_5 == "c4") {
      continue;
    }
    if(var_5 == "claymore") {
      continue;
    }
    level.player giveweapon(var_5);
    level.player givemaxammo(var_5);

    if(var_1) {
      level.player setweaponammoclip(var_5, game["weaponstates"][var_0]["list"][var_4]["clip"]);
      level.player setweaponammostock(var_5, game["weaponstates"][var_0]["list"][var_4]["stock"]);
    }
  }

  level.player _meth_83B4(game["weaponstates"][var_0]["offhand"]);
  level.player call[[var_3]](game["weaponstates"][var_0]["current"]);
  return 1;
}

_id_F6B5() {
  self setactionslot(1, "");
  self setactionslot(2, "altMode");
  self setactionslot(3, "");
  self setactionslot(4, "");
}

_id_96D7() {
  _id_F6B5();
  self takeallweapons();
}

_id_7AA6() {
  if(isDefined(level._id_AE21)) {
    return level._id_AE21;
  }

  return level.script;
}

_id_37E7(var_0) {
  level._id_1303 = var_0;
}

persist(var_0, var_1, var_2) {
  var_3 = _id_7AA6();

  if(var_0 != var_3) {
    return;
  }
  if(!isDefined(game["previous_map"])) {
    return;
  }
  level._id_1304 = 1;

  if(isDefined(var_2)) {
    level.player setoffhandsecondaryclass(var_2);
  }

  _id_E2E3(_id_7AA6(), 1);
  level._id_8B8E = 1;
}

_id_AE21(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_0)) {
    var_8 = _id_7AA6();

    if(var_0 != var_8 || isDefined(level._id_1304)) {
      return;
    }
  }

  if(isDefined(var_1)) {
    if(var_1 == "iw7_ar57") {
      var_1 = "iw7_ar57+ar57scope";
    }

    level.default_weapon = var_1;
    level.player giveweapon(var_1);
  }

  if(isDefined(var_6)) {
    if(var_6 == "iw7_erad") {
      var_6 = "iw7_erad+eradscope";
    }

    level.player setoffhandsecondaryclass(var_6);
  }

  if(isDefined(var_2)) {
    level.player giveweapon(var_2);
  }

  if(isDefined(var_3)) {
    level.player giveweapon(var_3);
  }

  if(isDefined(var_4)) {
    level.player giveweapon(var_4);
  }

  level.player switchtoweapon(var_1);

  if(isDefined(var_5)) {
    level.player setviewmodel(var_5);
  }

  level._id_37E7 = level._id_1303;
  level._id_1303 = undefined;
  level._id_8B8E = 1;

  if(isDefined(var_7)) {
    _id_F551(var_7);
  }
}

_id_F551(var_0) {
  level._id_D32B = var_0;
  precachemodel(level._id_D32B);
}

_id_AE27() {
  level._id_AE64 = 1;
  level notify("loadout complete");
}

_id_4FFD() {
  if(level._id_8B8E) {
    return;
  }
  _id_AE21(undefined, "iw7_ar57_reflex", undefined, "flash_grenade", "fraggrenade", "viewmodel_base_viewhands", "flash");
  level._id_B32C = 1;
}