/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6ec6fb09e17942a9.gsc
***********************************************/

setup_functions() {
  if(!scripts\engine\utility::flag_exist("checkpoints_initialized"))
    scripts\engine\utility::flag_init("checkpoints_initialized");

  scripts\cp\cp_checkpoint::checkpoint_register("gauntlet_intro_complete", ::_id_1C8293D147FFDB05);
  scripts\cp\cp_checkpoint::checkpoint_register("gauntlet_sam1destroyed", ::_id_2957CE9B885714F2);
  scripts\cp\cp_checkpoint::checkpoint_register("gauntlet_sam2destroyed", ::_id_2957CE9B885714F2);
  scripts\cp\cp_checkpoint::checkpoint_register("gauntlet_sam3destroyed", ::_id_2957CE9B885714F2);
  level.checkpoint_player_spawns_func = ::checkpoint_player_spawns;
  level.checkpoint_carepkg_spawns_func = ::checkpoint_carepkg_spawns;
  scripts\cp\cp_checkpoint::checkpoints_init();
  scripts\engine\utility::flag_set("checkpoints_initialized");
}

_id_7E889CDA221D6CE1() {
  _id_00C9452C7248BD6C = undefined;
  _id_A61C75B156FC1EE0 = 0;

  foreach(player in level.players) {
    if(isDefined(player.pers) && isDefined(player.pers["samsites_completed"])) {
      if(player.pers["samsites_completed"].size > _id_A61C75B156FC1EE0) {
        _id_00C9452C7248BD6C = player;
        _id_A61C75B156FC1EE0 = _id_A61C75B156FC1EE0;
      }
    }
  }

  return _id_00C9452C7248BD6C;
}

_id_2957CE9B885714F2() {
  level._id_E2EF6E27C8806484 = [];
  scripts\engine\utility::flag_set("pause_trigger_spawn");
  level._id_E2525C955D208FE5 = 1;
  level._id_8C876D36B2B7C949 = 1;
  locations = scripts\engine\utility::getStructArray("sam_site", "targetname");

  foreach(item in game["samsites_completed"]) {
    level._id_E2EF6E27C8806484[level._id_E2EF6E27C8806484.size] = item;

    switch (item) {
      case "a":
        _id_7EA61A73C7EE5FEC::_id_36AF28FBA4058B8B(scripts\engine\utility::getStruct("cleanup_samsite_a", "targetname"));
        y = 8378;
        _id_7EA61A73C7EE5FEC::_id_AF5F2033A9413E22(y);

        foreach(_id_AB3204C53E03B15E in locations) {
          name = _id_AB3204C53E03B15E _id_6AFE98B58D628734::_id_22CDC9BDD0A96C1E();

          if(name != "a") {
            continue;
          }
          _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(_id_AB3204C53E03B15E);
          waitframe();
          _id_C327ADFAD89EFC23 notify("stop_dmgmonitor");
          _id_C327ADFAD89EFC23 thread _id_2C17AA19D1E937B2::_id_6C86D07047FAE506();
        }

        break;
      case "b":
        _id_7EA61A73C7EE5FEC::_id_36AF28FBA4058B8B(scripts\engine\utility::getStruct("cleanup_samsite_b", "targetname"));
        y = 8378;
        _id_7EA61A73C7EE5FEC::_id_AF5F2033A9413E22(y);

        foreach(_id_AB3204C53E03B15E in locations) {
          name = _id_AB3204C53E03B15E _id_6AFE98B58D628734::_id_22CDC9BDD0A96C1E();

          if(name != "b") {
            continue;
          }
          _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(_id_AB3204C53E03B15E);
          waitframe();
          _id_C327ADFAD89EFC23 notify("stop_dmgmonitor");
          _id_C327ADFAD89EFC23 thread _id_2C17AA19D1E937B2::_id_6C86D07047FAE506();
        }

        break;
      case "c":
        _id_7EA61A73C7EE5FEC::_id_36AF28FBA4058B8B(scripts\engine\utility::getStruct("cleanup_samsite_c", "targetname"));
        y = 8378;
        _id_7EA61A73C7EE5FEC::_id_AF5F2033A9413E22(y);

        foreach(_id_AB3204C53E03B15E in locations) {
          name = _id_AB3204C53E03B15E _id_6AFE98B58D628734::_id_22CDC9BDD0A96C1E();

          if(name != "c") {
            continue;
          }
          _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(_id_AB3204C53E03B15E);
          waitframe();
          _id_C327ADFAD89EFC23 notify("stop_dmgmonitor");
          _id_C327ADFAD89EFC23 thread _id_2C17AA19D1E937B2::_id_6C86D07047FAE506();
        }

        break;
    }
  }

  _id_25E87B07ACDF985F = ["a", "b", "c"];

  foreach(site in _id_25E87B07ACDF985F) {
    if(scripts\engine\utility::array_contains(level._id_E2EF6E27C8806484, site)) {
      continue;
    }
    foreach(index, _id_AB3204C53E03B15E in locations) {
      name = _id_AB3204C53E03B15E _id_6AFE98B58D628734::_id_22CDC9BDD0A96C1E();

      if(name != site) {
        continue;
      }
      _id_C327ADFAD89EFC23 = _id_2C17AA19D1E937B2::_id_9933B3B407347038(_id_AB3204C53E03B15E);
      _id_C327ADFAD89EFC23 thread _id_6AFE98B58D628734::_id_52B931348EF23E0B(index);
      _id_AB3204C53E03B15E._id_C327ADFAD89EFC23 = _id_C327ADFAD89EFC23;
    }
  }

  level._id_358AB8DF65CBB5B4 = level._id_E2EF6E27C8806484.size;
  thread scripts\cp\cp_objectives::run_objective("gauntlet_samsites");
  wait 0.25;
  thread scripts\cp\utility::objective_update("gauntlet_samsites", undefined, undefined, undefined, undefined, 3 - level._id_E2EF6E27C8806484.size);
  wait 4;
  scripts\engine\utility::flag_clear("pause_trigger_spawn");
  level._id_E2525C955D208FE5 = undefined;
  level._id_8C876D36B2B7C949 = undefined;
  _id_3FEBF8EDDAEBAB55 = undefined;
  org = undefined;

  if(isDefined(game["startAtSamSite"])) {
    switch (game["startAtSamSite"]) {
      case "a":
        org = _id_6AFE98B58D628734::_id_E5E5AEF86B891977("a");
        break;
      case "b":
        org = _id_6AFE98B58D628734::_id_E5E5AEF86B891977("b");
        break;
      case "c":
        org = _id_6AFE98B58D628734::_id_E5E5AEF86B891977("c");
        break;
    }
  }

  if(level._id_358AB8DF65CBB5B4 == 1)
    _id_6AFE98B58D628734::_id_4A11A6476D7B00B0(org);
  else if(level._id_358AB8DF65CBB5B4 == 2)
    _id_6AFE98B58D628734::_id_9199A809FA26CF65(org);
  else if(level._id_358AB8DF65CBB5B4 == 3) {
    scripts\engine\utility::flag_set("sites_destroyed");
    scripts\engine\utility::flag_set("ready_to_escape");
    _id_6AFE98B58D628734::_id_6005F45F589CA8BE(org);
  }
}

checkpoint_player_spawns() {
  return [];
}

checkpoint_carepkg_spawns() {
  struct = scripts\engine\utility::getStruct("carepkg_introcomplete", "targetname");
  _id_E2421CF633DBD2B2 = scripts\cp\cp_checkpoint::checkpoint_add_carepackage("gauntlet_intro_complete", (-2524.59, 8544.08, 4660.74), (0, 0, 0));
  return [_id_E2421CF633DBD2B2];
}

_id_1C8293D147FFDB05() {
  scripts\engine\utility::flag_set("start_samsites");
  _id_6AFE98B58D628734::_id_4E26236569C2AE4A();
}