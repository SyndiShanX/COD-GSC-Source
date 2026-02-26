/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_weapons\.csc
*************************************************/

#include clientscripts\_utility;

weapon_box_callback(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    self thread weapon_floats_up();
  } else {
    self notify("end_float");
    cleanup_weapon_models();
  }
}
cleanup_weapon_models() {
  if(isDefined(self.weapon_models)) {
    players = getlocalplayers();
    for(index = 0; index < players.size; index++) {
      player = players[index];
      lcn = player getlocalclientnumber();
      if(isDefined(self.weapon_models[lcn])) {
        self.weapon_models[lcn].dw Delete();
        self.weapon_models[lcn] Delete();
      }
    }
    self.weapon_models = undefined;
  }
}
weapon_is_dual_wield(name) {
  switch (name) {
    case "cz75dw_zm":
    case "cz75dw_upgraded_zm":
    case "m1911_upgraded_zm":
    case "hs10_upgraded_zm":
    case "pm63_upgraded_zm":
      return true;
    default:
      return false;
  }
}
weapon_floats_up() {
  self endon("end_float");
  cleanup_weapon_models();
  self.weapon_models = [];
  number_cycles = 39;
  floatHeight = 64;
  rand = treasure_chest_ChooseRandomWeapon();
  modelname = GetWeaponModel(rand);
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    lcn = player getlocalclientnumber();
    self.weapon_models[lcn] = spawn(lcn, self.origin, "script_model");
    self.weapon_models[lcn].angles = self.angles + (0, 180, 0);
    self.weapon_models[lcn].dw = spawn(lcn, self.weapon_models[0].origin - (3, 3, 3), "script_model");
    self.weapon_models[lcn].dw.angles = self.weapon_models[0].angles;
    self.weapon_models[lcn].dw Hide();
    self.weapon_models[lcn] setModel(modelname);
    self.weapon_models[lcn].dw setModel(modelname);
    self.weapon_models[lcn] useweaponhidetags(rand);
    self.weapon_models[lcn] moveto(self.origin + (0, 0, floatHeight), 3, 2, 0.9);
    self.weapon_models[lcn].dw MoveTo(self.origin + (0, 0, floatHeight) - (3, 3, 3), 3, 2, 0.9);
  }
  for(i = 0; i < number_cycles; i++) {
    if(i < 20) {
      wait(0.05);
    } else if(i < 30) {
      wait(0.1);
    } else if(i < 35) {
      wait(0.2);
    } else if(i < 38) {
      wait(0.3);
    }
    rand = treasure_chest_ChooseRandomWeapon();
    modelname = GetWeaponModel(rand);
    players = getlocalplayers();
    for(index = 0; index < players.size; index++) {
      player = players[index];
      lcn = player getlocalclientnumber();
      if(isDefined(self.weapon_models[lcn])) {
        self.weapon_models[lcn] setModel(modelname);
        self.weapon_models[lcn] useweaponhidetags(rand);
        if(weapon_is_dual_wield(rand)) {
          self.weapon_models[lcn].dw setModel(modelname);
          self.weapon_models[lcn].dw useweaponhidetags(rand);
          self.weapon_models[lcn].dw show();
        } else {
          self.weapon_models[lcn].dw Hide();
        }
      }
    }
  }
  cleanup_weapon_models();
}
is_weapon_included(weapon_name) {
  if(!isDefined(level._box_weapons)) {
    return false;
  }
  for(i = 0; i < level._box_weapons.size; i++) {
    if(weapon_name == level._box_weapons[i]) {
      return true;
    }
  }
  return false;
}
include_weapon(weapon, in_box, func) {
  if(!isDefined(level._box_weapons)) {
    level._box_weapons = [];
  }
  if(!isDefined(in_box)) {
    in_box = true;
  }
  if(!in_box) {
    return;
  }
  level._box_weapons[level._box_weapons.size] = weapon;
}
treasure_chest_ChooseRandomWeapon() {
  if(!isDefined(level._box_weapons)) {
    level._box_weapons = array("python_zm", "g11_lps_zm", "famas_zm");
  }
  return level._box_weapons[RandomInt(level._box_weapons.size)];
}