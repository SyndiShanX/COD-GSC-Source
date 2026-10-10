/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_324b68cb416acbec.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_d7008f2c77d25ce5;

function main() {
  squads_init();
}

function squads_init() {
  level.var_d7008f2c77d25ce5 = [];
  level.var_d7008f2c77d25ce5["ar"] = ["ar", "ar", "ar"];
  level.var_d7008f2c77d25ce5["smg"] = ["smg", "smg", "smg"];
  level.var_d7008f2c77d25ce5["shotgun"] = ["shotgun", "shotgun", "shotgun"];
  level.var_d7008f2c77d25ce5["lmg"] = ["lmg", "lmg", "lmg"];
  level.var_d7008f2c77d25ce5["ar_smg"] = ["smg", "ar_ak", "smg", "ar_ak"];
  level.var_d7008f2c77d25ce5["ar_shotgun"] = ["shotgun", "ar_ak", "shotgun", "ar_ak"];
  level.var_d7008f2c77d25ce5["ar_lmg"] = ["lmg", "ar_ak", "lmg", "ar_ak"];
  level.var_d7008f2c77d25ce5["smg_shotgun"] = ["smg", "shotgun", "smg", "shotgun"];
  level.var_d7008f2c77d25ce5["smg_lmg"] = ["lmg", "smg", "lmg", "smg"];
  level.var_d7008f2c77d25ce5["smg_ar_support"] = ["smg", "smg", "ar"];
  level.var_d7008f2c77d25ce5["sniper"] = ["sniper", "sniper", "sniper", "sniper"];
  level.var_d7008f2c77d25ce5["rpg"] = ["rpg", "rpg", "rpg"];
  level.var_d7008f2c77d25ce5["riot"] = ["riotshield", "smg", "ar"];
  level.var_d7008f2c77d25ce5["jug"] = ["juggernaut"];
}

function squad_get(squad_name) {
  return level.var_d7008f2c77d25ce5[squad_name];
}