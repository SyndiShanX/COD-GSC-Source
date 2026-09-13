/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_41f1d2b91c165db8.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_trap", ::_id_34025989F3A3308F);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_town", ::_id_D8E45A5BF0559F24);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_farms", ::_id_89DA6A89B3CDF761);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_a", ::_id_34025989F3A3308F);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_b", ::_id_D8E45A5BF0559F24);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_c", ::_id_89DA6A89B3CDF761);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_exfil", ::_id_1B4A86201682F93C);
  scripts\cp\cp_checkpoint::checkpoint_register("checkpoint_start", ::_id_C6DAE80E14B5DA13);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  level thread _id_1290016C0ED16197();
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

checkpoint_player_spawns() {
  spawnpoints = [];
  _id_F1F44C1F8BFF22F7 = [];

  if(isDefined(level.pers) && isarray(level.pers) && level.pers.size > 0) {
    if(isDefined(level.pers["completed_hack_locations"]) && isarray(level.pers["completed_hack_locations"]) && level.pers["completed_hack_locations"].size > 0) {
      switch (level.pers["completed_hack_locations"].size) {
        case 1:
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52365.2, -17838.4, -225.338), (359.925, 96.1736, 1.89541));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52279, -17816.9, -225.3), (359.986, 91.2036, -1.05731));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52261.6, -18008.9, -225.292), (0, 64.0997, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52367.9, -17987.9, -225.34), (0, 90, 0));
          break;
        case 2:
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51360.2, -16325.8, -262.25), (357.98, 1.01, -0.23));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51525.9, -16244.1, -262.25), (0, 270, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51551.3, -16380.6, -261.54), (0, 270, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51424.3, -16228, -262.25), (0, 270, 0));
          break;
        case 3:
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46252.9, -12866.4, 88.75), (0, 90, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46334.1, -13001.9, 87.75), (0, 180, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46252.2, -13029.9, 88.46), (0, 90, 0));
          _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46350.3, -12900.3, 87.75), (0, 180, 0));
          break;
        default:
          break;
      }
    }
  } else {
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52365.2, -17838.4, -225.338), (359.925, 96.1736, 1.89541));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52279, -17816.9, -225.3), (359.986, 91.2036, -1.05731));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52261.6, -18008.9, -225.292), (0, 64.0997, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_trap", (52367.9, -17987.9, -225.34), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51360.2, -16325.8, -262.25), (357.98, 1.01, -0.23));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51525.9, -16244.1, -262.25), (0, 270, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51551.3, -16380.6, -261.54), (0, 270, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_town", (51424.3, -16228, -262.25), (0, 270, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46252.9, -12866.4, 88.75), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46334.1, -13001.9, 87.75), (0, 180, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46252.2, -13029.9, 88.46), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_farms", (46350.3, -12900.3, 87.75), (0, 180, 0));

    foreach(struct in scripts\engine\utility::getStructArray("checkpoint_spawner_a", "targetname"))
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_a", struct.origin, struct.angles);

    foreach(struct in scripts\engine\utility::getStructArray("checkpoint_spawner_b", "targetname"))
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_b", struct.origin, struct.angles);

    foreach(struct in scripts\engine\utility::getStructArray("checkpoint_spawner_c", "targetname"))
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_c", struct.origin, struct.angles);

    foreach(struct in scripts\engine\utility::getStructArray("checkpoint_spawner_exfil", "targetname"))
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_exfil", struct.origin, struct.angles);

    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_a", (48007, -23874.7, -206), (0, 360, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_a", (48186.8, -23949.6, -239.5), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_a", (48031, -23639.7, -210.55), (0, 360, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_a", (48223.4, -23557.8, -239.5), (0, 244.1, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_b", (56020.7, -21554.3, -365), (0, 360, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_b", (56371.6, -21354.7, -364.98), (0, 206.6, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_b", (56283.8, -21462.5, -361), (0, 171.37, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_b", (56245.3, -21358.8, -365), (0, 270.12, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_c", (47094.5, -10544.1, 211.22), (0, 270, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_c", (47172, -10736, 209.64), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_c", (47369.1, -10531.5, 210.84), (0, 360, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_c", (47578.8, -10529.8, 213.47), (0, 154.1, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_exfil", (47094.5, -10544.1, 211.22), (0, 270, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_exfil", (47172, -10736, 209.64), (0, 90, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_exfil", (47369.1, -10531.5, 210.84), (0, 360, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_exfil", (47578.8, -10529.8, 213.47), (0, 154.1, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_start", (-8446.13, 3124.48, 512.5), (359.99, 265.535, 1.23333));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_start", (-8512.74, 3021.76, 512), (358.15, 339.106, -1.89548));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_start", (-8498.54, 2976.65, 512), (0, 0, 0));
    _id_F1F44C1F8BFF22F7[_id_F1F44C1F8BFF22F7.size] = scripts\cp\cp_checkpoint::checkpoint_add_spawnpoint("checkpoint_start", (-8452.77, 2938.39, 511.5), (0.318647, 64.629, -1.8303));
  }

  spawnpoints = _id_F1F44C1F8BFF22F7;
  return spawnpoints;
}

checkpoint_carepkg_spawns() {
  _id_20C5609F18D45157 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage_munitions("checkpoint_trap", (-4170, 33407, 206), (0, 60.096, 0));
  _id_20C55F9F18D44F24 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage("checkpoint_trap", (9797.73, 29319.9, 1176.06), (1.08426, 209.978, -1.1709));
  _id_E66090E39AEA56F2 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage_munitions("checkpoint_trap", (9695.73, 29341.9, 1170.06), (354.438, 337.89, 2.255));
  return [_id_20C5609F18D45157, _id_20C55F9F18D44F24, _id_E66090E39AEA56F2];
}

_id_285F6CC4C95E7B36(_id_DD343F254671B3DF) {
  if(!isDefined(level.pers))
    level.pers = [];

  if(getdvarint("dvar_36D93A5CBE94A8DF", 0) != 0) {
    if(!isDefined(level.pers["completed_hack_locations"]))
      level.pers["completed_hack_locations"] = [];

    switch (_id_DD343F254671B3DF) {
      case 1:
        break;
      case 2:
        level.pers["completed_hack_locations"][0] = "barn_hack";
        level._id_4CC283D9F7D02582 = 1;
        break;
      case 3:
        level.pers["completed_hack_locations"][0] = "barn_hack";
        level.pers["completed_hack_locations"][1] = "town_hack";
        level._id_4CC283D9F7D02582 = 2;
        break;
      default:
        break;
    }
  } else {
    foreach(player in level.players) {
      player scripts\cp\equipment\nvg::runnvg();

      if(isDefined(player.pers["intel"])) {
        if(player _id_3858411D0B73D352::_id_B447727705929B4F(0)) {
          if(getdvarint("dvar_55028DECF032124F", 0) != 0)
            thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
          else
            thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");

          return;
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(8)) {
          level._id_F17CE687610CC159 = 1;

          if(player _id_3858411D0B73D352::_id_B447727705929B4F(4) && player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
            thread scripts\cp\cp_objectives::run_objective("exfil_stealth", "primary");
            return;
          } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(2))
            level._id_D0ADA23E81337306 = ["barn"];
          else if(player _id_3858411D0B73D352::_id_B447727705929B4F(4))
            level._id_D0ADA23E81337306 = ["town"];
          else {}
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
          if(player _id_3858411D0B73D352::_id_B447727705929B4F(4))
            level._id_D0ADA23E81337306 = ["barn", "town"];
          else
            level._id_D0ADA23E81337306 = ["barn"];
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(4))
          level._id_D0ADA23E81337306 = ["town"];

        if(getdvarint("dvar_55028DECF032124F", 0) != 0)
          thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
        else
          thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");

        return;
      }
    }

    if(getdvarint("dvar_55028DECF032124F", 0) != 0)
      thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
    else
      thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");
  }
}

ml_p1_func() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36(1);

  if(getdvarint("dvar_36D93A5CBE94A8DF", 0) != 0) {
    if(getdvarint("dvar_55028DECF032124F", 0) != 0)
      thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
    else
      thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");
  }
}

ml_p2_func() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36(2);

  if(getdvarint("dvar_36D93A5CBE94A8DF", 0) != 0) {
    if(getdvarint("dvar_55028DECF032124F", 0) != 0)
      thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
    else
      thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");
  }
}

ml_p3_func() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_285F6CC4C95E7B36(3);

  if(getdvarint("dvar_36D93A5CBE94A8DF", 0) != 0) {
    if(getdvarint("dvar_55028DECF032124F", 0) != 0)
      thread scripts\cp\cp_objectives::run_objective("stealth_b", "primary");
    else
      thread scripts\cp\cp_objectives::run_objective("stealth_nuke", "primary");
  }
}

_id_1B4A86201682F93C() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  if(istrue(level._id_17181EDC5477DDEE)) {
    return;
  }
  level._id_D0ADA23E81337306 = ["a", "b", "c"];
  _id_858E3643E93B1A35(2);
  thread _id_31B15538260E6EB2("exfil");
  thread _id_31B15538260E6EB2("c");
  level._id_17181EDC5477DDEE = 1;
}

_id_1290016C0ED16197() {
  level._id_02E1F9827C692A1F = [];
  level._id_02E1F9827C692A1F["usb"] = 0;
  level._id_02E1F9827C692A1F["nuke"] = 0;
  level._id_BB07CFB91B5A51E8 = [];
  level._id_BB07CFB91B5A51E8["a"] = 0;
  level._id_BB07CFB91B5A51E8["b"] = 0;
  level._id_BB07CFB91B5A51E8["c"] = 0;

  for(;;) {
    level waittill("checkpoint_update", stringref, location);
    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");

    if(isDefined(objname) && (objname == "stealth_b" || objname == "stealth_a" || objname == "stealth_c")) {
      return;
    }
    if(!isDefined(level._id_02E1F9827C692A1F))
      level._id_02E1F9827C692A1F[stringref] = 0;

    level._id_02E1F9827C692A1F[stringref]++;

    if(stringref == "usb") {
      switch (level._id_02E1F9827C692A1F["usb"]) {
        case 1:
          if(location == "a")
            _id_7EC4BA6F43AE77C9("a", "checkpoint_a");
          else if(location == "b")
            _id_7EC4BA6F43AE77C9("b", "checkpoint_b");
          else if(location == "c")
            _id_7EC4BA6F43AE77C9("c", "checkpoint_c");
          else if(location == "barn")
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_trap");
          else
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_town");

          break;
        case 2:
          if(location == "a")
            _id_7EC4BA6F43AE77C9("a", "checkpoint_a");
          else if(location == "b")
            _id_7EC4BA6F43AE77C9("b", "checkpoint_b");
          else if(location == "c")
            _id_7EC4BA6F43AE77C9("c", "checkpoint_c");
          else if(location == "barn")
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_trap");
          else
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_town");

          break;
        case 3:
          if(getdvarint("dvar_B9C3785AEA951E72", 0) != 0) {
            foreach(player in level.players)
            player.pers["intel"] = 0;

            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_start");
          } else
            scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_exfil");

          break;
      }

      _id_742F61B6768A1AAB::_id_6643E94DC5217B92(location);
      continue;
    }

    if(stringref == "nuke") {
      scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_farms");

      switch (level._id_02E1F9827C692A1F["usb"]) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    }
  }
}

_id_7EC4BA6F43AE77C9(obj, _id_10211CAA50DDBA2D) {
  level._id_BB07CFB91B5A51E8[obj] = 1;
  setDvar("dvar_9A8052AC099141AF", 0);
  game["objectives_completed"] = obj;
  scripts\cp\cp_checkpoint::checkpoint_set(_id_10211CAA50DDBA2D);
}

_id_34025989F3A3308F() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_858E3643E93B1A35(1);
  scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
  scripts\engine\utility::flag_set("laswell_intro_vo_done");
  scripts\engine\utility::flag_set("laswell_infil_briefing_done");
  _id_31B15538260E6EB2("a");
}

_id_D8E45A5BF0559F24() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_858E3643E93B1A35(2);
  scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
  scripts\engine\utility::flag_set("laswell_intro_vo_done");
  scripts\engine\utility::flag_set("laswell_infil_briefing_done");
  _id_31B15538260E6EB2("b");
}

_id_89DA6A89B3CDF761() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_858E3643E93B1A35(3);
  scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
  scripts\engine\utility::flag_set("laswell_intro_vo_done");
  scripts\engine\utility::flag_set("laswell_infil_briefing_done");
  _id_31B15538260E6EB2("c");
}

_id_C6DAE80E14B5DA13() {
  level.skip_nav_check_on_spectate_respawn = 1;

  if(scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(scripts\engine\utility::flag_exist("objectives_registered"))
    scripts\engine\utility::flag_wait("objectives_registered");

  _id_858E3643E93B1A35(3);
  _id_4BABF1F5FAC3C4E2 = scripts\engine\utility::getStructArray("level_crate_spawn_struct", "targetname");
  _id_7E1A468DA43087E3::level_offhand_spawn(_id_4BABF1F5FAC3C4E2);
}

_id_858E3643E93B1A35(_id_DD343F254671B3DF) {
  if(!isDefined(level.pers))
    level.pers = [];

  if(!isDefined(level._id_D0ADA23E81337306))
    level._id_D0ADA23E81337306 = [];

  foreach(player in level.players) {
    player scripts\cp\equipment\nvg::runnvg();

    if(isDefined(player.pers["intel"])) {
      if(player _id_3858411D0B73D352::_id_B447727705929B4F(8)) {
        level._id_F17CE687610CC159 = 1;
        level._id_D0ADA23E81337306 = ["c"];

        if(player _id_3858411D0B73D352::_id_B447727705929B4F(4) && player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
          if(getdvarint("dvar_B9C3785AEA951E72", 0) != 0) {
            level._id_D0ADA23E81337306 = [];
            thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
            return;
          }

          level._id_D0ADA23E81337306 = ["a", "b", "c"];

          if(istrue(level._id_AC775ED66AAEB771)) {
            return;
          }
          thread scripts\cp\cp_objectives::run_objective("exfil_area", "primary");
          return;
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "a");
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(4)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "b");
        } else
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(2);
      } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(4)) {
        level._id_D0ADA23E81337306 = ["b"];

        if(player _id_3858411D0B73D352::_id_B447727705929B4F(8) && player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
          if(getdvarint("dvar_B9C3785AEA951E72", 0) != 0) {
            level._id_D0ADA23E81337306 = [];
            thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
            return;
          }

          level._id_D0ADA23E81337306 = ["a", "b", "c"];

          if(istrue(level._id_AC775ED66AAEB771)) {
            return;
          }
          thread scripts\cp\cp_objectives::run_objective("exfil_area", "primary");
          return;
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(8)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "c");
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "a");
        } else
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(2);
      } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(2)) {
        level._id_D0ADA23E81337306 = ["a"];

        if(player _id_3858411D0B73D352::_id_B447727705929B4F(8) && player _id_3858411D0B73D352::_id_B447727705929B4F(4)) {
          if(getdvarint("dvar_B9C3785AEA951E72", 0) != 0) {
            level._id_D0ADA23E81337306 = [];
            thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
            return;
          }

          level._id_D0ADA23E81337306 = ["a", "b", "c"];

          if(istrue(level._id_AC775ED66AAEB771)) {
            return;
          }
          thread scripts\cp\cp_objectives::run_objective("exfil_area", "primary");
          return;
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(8)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "c");
        } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(4)) {
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
          level._id_D0ADA23E81337306 = scripts\engine\utility::array_add(level._id_D0ADA23E81337306, "b");
        } else
          _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(2);
      } else if(player _id_3858411D0B73D352::_id_B447727705929B4F(0)) {
        thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
        return;
      }

      if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size >= 3) {
        if(istrue(level._id_AC775ED66AAEB771)) {
          return;
        }
        thread scripts\cp\cp_objectives::run_objective("exfil_area", "primary");
      } else
        thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");

      return;
    }
  }

  scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
}

_id_31B15538260E6EB2(obj) {
  _id_4BABF1F5FAC3C4E2 = scripts\engine\utility::getStructArray("level_crate_spawn_struct", "targetname");
  _id_7E1A468DA43087E3::level_offhand_spawn(_id_4BABF1F5FAC3C4E2);
  _id_4BABF1F5FAC3C4E2 = scripts\engine\utility::getStructArray("level_crate_spawn_struct_" + obj, "targetname");
  _id_7E1A468DA43087E3::level_offhand_spawn(_id_4BABF1F5FAC3C4E2);
}