/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2272cea833355e09.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("boss1_silo_power", ::_id_51EBD0D840C931AC);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_silo_2nd_stop", ::_id_13C49206ACB76C7B);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_silo_2nd_power", ::_id_40EE6CA243652C78);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_silo_end", ::_id_331B35503051EA80);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_fil", ::_id_AA20177B8222D97B);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_fil_p", ::_id_4185C675DC8FD3A3);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_fil_end", ::_id_5D55766BAE355051);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_fil_vent", ::_id_03E92897AFFC94AD);
  scripts\cp\cp_checkpoint::checkpoint_register("boss1_fil_tripwire", ::_id_71E2EAF4754AF6BA);
  scripts\cp\cp_checkpoint::checkpoint_register("b1_p0", ::_id_A420D6ED641BE150);
  scripts\cp\cp_checkpoint::checkpoint_register("b1_p1", ::_id_70C9A125D9A99A6D);
  scripts\cp\cp_checkpoint::checkpoint_register("b1_p2", ::_id_05B45E647EDD745E);
  scripts\cp\cp_checkpoint::checkpoint_register("b1_p3", ::_id_65E889D5B8A6BB3B);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

checkpoint_player_spawns() {
  spawnpoints = [];
  _id_F5A4893C2CCB7CC2 = scripts\engine\utility::getStructArray("b1_silo_checkpoint_playerstart", "targetname");
  _id_26BD722F7FA9D6CC = scripts\engine\utility::getStructArray("b1_silo_2nd_stop_playerstart", "targetname");
  _id_024C38969574ABCD = scripts\engine\utility::getStructArray("b1_silo_2nd_power_playerstart", "targetname");
  _id_44EF8BAD5A8832C6 = scripts\engine\utility::getStructArray("b1_silo_end_playerstart", "targetname");
  fil = scripts\engine\utility::getStructArray("fil_playerstart", "targetname");
  _id_65DC0E99D91B97C8 = scripts\engine\utility::getStructArray("b1_fil_power_players", "targetname");
  _id_3E882D8EC24680CD = scripts\engine\utility::getStructArray("b1_fil_end_players", "targetname");
  _id_11BE8DAE2F06A12E = scripts\engine\utility::getStructArray("b1_fil_vent_players", "targetname");
  _id_CA2FA8C0BC8196C7 = scripts\engine\utility::getStructArray("b1_fil_tripwire_players", "targetname");
  _id_3F96611EFB37E7AA = scripts\engine\utility::getStructArray("b1_p1_playerstart", "targetname");
  _id_3F96601EFB37E577 = scripts\engine\utility::getStructArray("b1_p2_playerstart", "targetname");
  _id_3F965F1EFB37E344 = scripts\engine\utility::getStructArray("b1_p3_playerstart", "targetname");

  foreach(struct in _id_F5A4893C2CCB7CC2) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_silo_power", og, angles);
  }

  foreach(struct in _id_26BD722F7FA9D6CC) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_silo_2nd_stop", og, angles);
  }

  foreach(struct in _id_024C38969574ABCD) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_silo_2nd_power", og, angles);
  }

  foreach(struct in _id_44EF8BAD5A8832C6) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_silo_end", og, angles);
  }

  foreach(struct in fil) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_fil", og, angles);
  }

  foreach(struct in _id_65DC0E99D91B97C8) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_fil_p", og, angles);
  }

  foreach(struct in _id_3E882D8EC24680CD) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_fil_end", og, angles);
  }

  foreach(struct in _id_11BE8DAE2F06A12E) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_fil_vent", og, angles);
  }

  foreach(struct in _id_CA2FA8C0BC8196C7) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("boss1_fil_tripwire", og, angles);
  }

  foreach(struct in _id_3F96611EFB37E7AA) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("b1_p1", og, angles);
  }

  foreach(struct in _id_3F96601EFB37E577) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("b1_p2", og, angles);
  }

  foreach(struct in _id_3F965F1EFB37E344) {
    og = struct.origin;
    angles = scripts\engine\utility::ter_op(isDefined(struct.angles), struct.angles, (0, 0, 0));
    spawnpoints[spawnpoints.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("b1_p3", og, angles);
  }

  return spawnpoints;
}

checkpoint_carepkg_spawns() {
  return [];
}

_id_51EBD0D840C931AC() {
  level.default_player_spawns = "b1_silo_checkpoint_playerstart";
  _id_13FFCCF97A3E3294::_id_7D4126296031DE02();
}

_id_13C49206ACB76C7B() {
  level.default_player_spawns = "b1_silo_2nd_stop_playerstart";
  _id_13FFCCF97A3E3294::_id_3A2450AF7E20A08C();
}

_id_40EE6CA243652C78() {
  level.default_player_spawns = "b1_silo_2nd_power_playerstart";
  _id_13FFCCF97A3E3294::_id_14FCE377A543D48D();
}

_id_331B35503051EA80() {
  level.default_player_spawns = "b1_silo_end_playerstart";
  _id_13FFCCF97A3E3294::_id_ED342BB672D2B406();
}

_id_AA20177B8222D97B() {
  level.default_player_spawns = "fil_playerstart";
  _id_13FFCCF97A3E3294::_id_065CD87C519857A8();
}

_id_4185C675DC8FD3A3() {
  level.default_player_spawns = "b1_fil_power_players";
  _id_13FFCCF97A3E3294::_id_9687F16772093008();
}

_id_5D55766BAE355051() {
  level.default_player_spawns = "b1_fil_end_players";
  _id_13FFCCF97A3E3294::_id_9F0486282F27E5FA();
}

_id_03E92897AFFC94AD() {
  level.default_player_spawns = "b1_fil_vent_players";
  _id_13FFCCF97A3E3294::_id_C4ACB631CECF956E();
}

_id_71E2EAF4754AF6BA() {
  level.default_player_spawns = "b1_fil_tripwire_players";
  _id_13FFCCF97A3E3294::_id_C4ACB631CECF956E();
}

_id_A420D6ED641BE150() {
  level.default_player_spawns = "b1_p0_playerstart";
  _id_13FFCCF97A3E3294::_id_A7CD25832CBE97B9();
}

_id_70C9A125D9A99A6D() {
  level.default_player_spawns = "b1_p1_playerstart";
  level._id_D92FC0A030677D28 = 1;
  _id_13FFCCF97A3E3294::_id_36C7891014DB2455();
  _id_13FFCCF97A3E3294::_id_A7CD24832CBE9586();
}

_id_05B45E647EDD745E() {
  level.default_player_spawns = "b1_p2_playerstart";
  level._id_D92FC0A030677D28 = 2;
  _id_13FFCCF97A3E3294::_id_36C7891014DB2455();
  _id_13FFCCF97A3E3294::_id_A7CD23832CBE9353();
}

_id_65E889D5B8A6BB3B() {
  level.default_player_spawns = "b1_p3_playerstart";
  level._id_D92FC0A030677D28 = 3;
  _id_13FFCCF97A3E3294::_id_36C7891014DB2455();
  _id_13FFCCF97A3E3294::_id_A7CD22832CBE9120();
}