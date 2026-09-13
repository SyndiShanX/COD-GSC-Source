/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_324b68cb416acbec.gsc
***********************************************/

main() {
  _id_CA410274CA39D561();
}

_id_CA410274CA39D561() {
  level._id_D7008F2C77D25CE5 = [];
  level._id_D7008F2C77D25CE5["ar"] = ["ar", "ar", "ar"];
  level._id_D7008F2C77D25CE5["smg"] = ["smg", "smg", "smg"];
  level._id_D7008F2C77D25CE5["shotgun"] = ["shotgun", "shotgun", "shotgun"];
  level._id_D7008F2C77D25CE5["lmg"] = ["lmg", "lmg", "lmg"];
  level._id_D7008F2C77D25CE5["ar_smg"] = ["smg", "ar_ak", "smg", "ar_ak"];
  level._id_D7008F2C77D25CE5["ar_shotgun"] = ["shotgun", "ar_ak", "shotgun", "ar_ak"];
  level._id_D7008F2C77D25CE5["ar_lmg"] = ["lmg", "ar_ak", "lmg", "ar_ak"];
  level._id_D7008F2C77D25CE5["smg_shotgun"] = ["smg", "shotgun", "smg", "shotgun"];
  level._id_D7008F2C77D25CE5["smg_lmg"] = ["lmg", "smg", "lmg", "smg"];
  level._id_D7008F2C77D25CE5["smg_ar_support"] = ["smg", "smg", "ar"];
  level._id_D7008F2C77D25CE5["sniper"] = ["sniper", "sniper", "sniper", "sniper"];
  level._id_D7008F2C77D25CE5["rpg"] = ["rpg", "rpg", "rpg"];
  level._id_D7008F2C77D25CE5["riot"] = ["riotshield", "smg", "ar"];
  level._id_D7008F2C77D25CE5["jug"] = ["juggernaut"];
}

_id_0DE96B8A387DBE2A(_id_516FF72CF3A5B67D) {
  return level._id_D7008F2C77D25CE5[_id_516FF72CF3A5B67D];
}