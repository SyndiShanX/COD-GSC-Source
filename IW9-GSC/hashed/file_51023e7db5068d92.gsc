/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_51023e7db5068d92.gsc
***********************************************/

main() {
  setDvar("dvar_F94319AFACA59ED6", 1);
  level._id_EF796AC0B0326726 = ::_id_5D07E8092CB10167;
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");
  level._id_6C5A3DD9183FA65E = ::_id_6C5A3DD9183FA65E;
  level._id_06B67B924A327783 = ::_id_27C39909E6A63240;
  level._id_8332A0D90935D5E8 = [];
  level._id_8332A0D90935D5E8["stealth_a"] = 0;
  level._id_8332A0D90935D5E8["stealth_b"] = 0;
  level._id_8332A0D90935D5E8["stealth_c"] = 0;
  level._id_8332A0D90935D5E8["exfil_area"] = 0;
  thread _id_DDA2189B7EC82975();
}

_id_DDA2189B7EC82975() {
  wait 30;
  _id_4EECDCB9F4EFE6EF = scripts\engine\utility::getStructArray("door_close", "script_noteworthy");

  foreach(struct in _id_4EECDCB9F4EFE6EF) {
    _id_4FFC8A24C8B56841 = _id_7E1A468DA43087E3::_id_F0AACBE05ACE1594(struct.origin, 500)[0];
    scripts\asm\asm_mp::doorclose(_id_4FFC8A24C8B56841);
    _id_4FFC8A24C8B56841 scriptabledoorfreeze(1);
  }
}

spawn_claymore_group(_id_9EA7808F138295B7) {
  if(getdvarint("dvar_0E87416769ABD9B7", 0) != 0) {
    return;
  }
  _id_C4EA99FA46D27C12 = scripts\engine\utility::getStructArray(_id_9EA7808F138295B7, "targetname");

  foreach(spawner in _id_C4EA99FA46D27C12)
  thread spawn_enemy_claymore(spawner.origin, spawner.angles);
}

#using_animtree("script_model");

_id_1BB3F8A02C699C93() {
  _id_4B02400DAD63CAFB::_id_E7A64DF827074B05();
  level.sentrysettings["incursion_sentry"].maxrange = 44475561;
  level.sentrysettings["incursion_sentry"]._id_947AF351CE904AA5 = 44475561;
  _id_70DAB3207FB65169 = scripts\engine\utility::getStructArray("enemy_sentry_objB", "targetname");
  level._id_828450D6FB8CAE84 = [];

  foreach(struct in _id_70DAB3207FB65169) {
    turret = _id_4B02400DAD63CAFB::setup_enemy_sentry(struct, "rpg", "weapon_wm_mg_mobile_turret");
    turret _id_4B02400DAD63CAFB::_id_A08BB096BB00739A();
    _id_43113A01E4BF9DCD = getEnt(struct.target, "targetname");
    _id_43113A01E4BF9DCD linkTo(turret);
    _id_43113A01E4BF9DCD useanimtree(#animtree);
    _id_43113A01E4BF9DCD scriptmodelplayanim("reb_com_veh8_decho_turret_aim_5");
    _id_43113A01E4BF9DCD thread _id_69F6FAB5C2C08714();
    turret._id_43113A01E4BF9DCD = _id_43113A01E4BF9DCD;
    level._id_828450D6FB8CAE84 = scripts\engine\utility::array_add(level._id_828450D6FB8CAE84, turret);
  }
}

_id_69F6FAB5C2C08714() {
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
  self delete();
}

_id_5D07E8092CB10167(stealth_group, _id_65661AE3A873C9AE) {
  if(isDefined(stealth_group) && isstring(stealth_group)) {
    if(!isDefined(level._id_72069798E35CC6BC[stealth_group]))
      level._id_72069798E35CC6BC[stealth_group] = 0;

    level._id_72069798E35CC6BC[stealth_group]++;
    level._id_892990D1B2DA4A65 = 4000000;

    switch (stealth_group) {
      default:
        level thread _id_4E0244F0C1AB5067(1, stealth_group);
        break;
    }
  } else
    level thread _id_4E0244F0C1AB5067(_id_65661AE3A873C9AE);
}

_id_62B762D8A739DE9E(_id_65661AE3A873C9AE, _id_C8FCFEAE020541D9) {
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");
  _id_E61AF03C9E384F0F = 0;
  _id_E7758D1CEF59FBF6 = 0;
  _id_E4189F6142F280F1 = 0;
  _id_2795910EA142BEBD = 0;
  _id_5EAD7CD5BD2A23C3 = getEnt("reinforcement_spawn_trigger_objA", "targetname");
  _id_E44B7DA0B5A8631B = getEnt("exterior_ai_chase_trigger_objA", "targetname");
  _id_046CF58102043E30 = getEnt("reinforcement_spawn_trigger_objB", "targetname");
  _id_867B6418DD3354E1 = getEnt("reinforcement_spawn_trigger_objC", "targetname");
  _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");
  _id_8F67C225DF2DBBB2 = 0;

  foreach(player in level.players) {
    if(player istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(player istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(player istouching(_id_867B6418DD3354E1))
      _id_E4189F6142F280F1 = 1;

    if(player istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;
  }

  if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1 && !_id_2795910EA142BEBD && getdvarint("dvar_C29BAFB99CEFBCEB", 0) != 0) {
    _id_55704503DCF364A1 = scripts\cp\utility\entity::getaverageorigin(level.players);

    if(!isDefined(_id_55704503DCF364A1) || _id_55704503DCF364A1 == (0, 0, 0)) {
      return;
    }
    _id_C837AD627899C30C = scripts\engine\utility::getclosest(_id_55704503DCF364A1, getEntArray("objective_trigger", "targetname"));

    if(!isDefined(_id_C837AD627899C30C)) {
      return;
    }
    objname = _id_C837AD627899C30C.script_noteworthy;
  } else {
    if(_id_E61AF03C9E384F0F)
      objname = "stealth_a";

    if(_id_E7758D1CEF59FBF6)
      objname = "stealth_b";

    if(_id_E4189F6142F280F1)
      objname = "stealth_c";

    if(_id_2795910EA142BEBD)
      objname = "exfil_area";

    foreach(player in level.players) {
      if(player istouching(_id_E44B7DA0B5A8631B)) {
        objname = "stealth_a";
        _id_8F67C225DF2DBBB2 = 1;

        if(istrue(level._id_29496147124CF052))
          _id_8F67C225DF2DBBB2 = 0;
      }
    }
  }

  if(!istrue(_id_C8FCFEAE020541D9)) {
    if(_func_EAC0CD99C9C6D8EE() != "spotted" && !istrue(_id_65661AE3A873C9AE)) {
      if(objname != "exfil_area")
        return;
    }
  }

  if(objname == "stealth_a") {
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(isDefined(checkpoint) && checkpoint == "checkpoint_a") {
      return;
    }
    level notify("unload_spawners_for_obj", "a");
    _id_073BA254E44EB0CC = 0;
    ai_spawned = [];

    if(!istrue(_id_8F67C225DF2DBBB2)) {
      if(level._id_A359CB3E2BFA1964[objname] < 1 && level._id_9EEAB63C54988C55[objname] < 1 && level._id_359C318944444B78[objname] < 1) {
        thread _id_922DE60337409A17(objname);
        return;
      } else {
        wait 2;

        if(_func_EAC0CD99C9C6D8EE() != "spotted")
          return;
      }
    } else {
      _id_41ABE0908B86B235 = ["spawner_obj_a_exterior_", "spawner_obj_a_exterior_patrol_"];
      ai_spawned = [];

      foreach(group_name in _id_41ABE0908B86B235) {
        _id_63EBA43A116802D9 = group_name + _id_742F61B6768A1AAB::_id_D70F981E9EBE2A90();
        _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

        if(isDefined(_id_5571AE8A9C277A18)) {
          ai_spawned = scripts\engine\utility::array_combine(ai_spawned, _id_5571AE8A9C277A18.ai_spawned);
          ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
        }
      }

      if(ai_spawned.size > 0)
        _id_073BA254E44EB0CC = 1;
    }

    if(istrue(_id_073BA254E44EB0CC)) {
      _id_8A176FD9598627C0 = 0;

      if(!istrue(level._id_29496147124CF052)) {
        ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
        level._id_2BD31BDC94B899B0 = ai_spawned;

        foreach(ai in ai_spawned)
        ai thread _id_742F61B6768A1AAB::_id_D24590F588A71CA2();

        level._id_29496147124CF052 = 1;
      } else {
        _id_6FE6E110D672C87A = ["spawner_obj_a_interior_smg_", "spawner_obj_a_interior_upstairs_smg_", "spawner_obj_a_upstairs_ambush_"];
        _id_D8C114EDA2DADB41 = [];

        foreach(group_name in _id_6FE6E110D672C87A) {
          _id_63EBA43A116802D9 = group_name + _id_742F61B6768A1AAB::_id_D70F981E9EBE2A90();
          _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

          if(isDefined(_id_5571AE8A9C277A18)) {
            _id_D8C114EDA2DADB41 = scripts\engine\utility::array_combine(_id_D8C114EDA2DADB41, _id_5571AE8A9C277A18.ai_spawned);
            _id_D8C114EDA2DADB41 = scripts\engine\utility::array_removedead_or_dying(_id_D8C114EDA2DADB41);
          }
        }

        if(_id_D8C114EDA2DADB41.size > 0)
          _id_8A176FD9598627C0 = 1;
      }

      if(getdvarint("dvar_69C827C83111595E", 0) != 0) {
        iprintln(" EXTERIOR AI STILL ALIVE!! ");

        foreach(ai in ai_spawned)
        scripts\cp\cp_outline::enable_outline_for_players(ai, level.players, "outline_nodepth_red");
      }

      if(!istrue(_id_8A176FD9598627C0))
        return;
    }

    if(getdvarint("dvar_E637894E145488A7", 0) != 0) {
      if(!istrue(level._id_8332A0D90935D5E8[objname])) {
        if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
          _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_shotgun", "stealth_container");
          _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
        } else {
          _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_smg", "stealth_container");
          _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_smg", "stealth_container");
        }

        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_upstairs_ambush", "stealth_container");
        level._id_8332A0D90935D5E8[objname] = 1;
        level notify("obj_a_interior_spawned");
        level notify("kill_upstairs_thread");
      }
    }

    if(!isDefined(level._id_F75A58E27E264659))
      level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

    if(!istrue(level._id_B4987EEEBA421B86)) {
      level._id_B4987EEEBA421B86 = 1;

      foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659) {
        if(isDefined(_id_CDCD3C78F5177DB6.struct.script_label) && _id_CDCD3C78F5177DB6.struct.script_label == objname)
          thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1, 3);
      }
    }

    if(!istrue(level._id_37DBED10A6D2831C)) {
      foreach(volume in level._id_E603A83D83B0080D) {
        foreach(player in level.players) {
          if(player istouching(volume)) {
            if(!istrue(level._id_37DBED10A6D2831C)) {
              if(_func_EAC0CD99C9C6D8EE() == "spotted") {
                spawn_group = _id_742F61B6768A1AAB::_id_B69E8D7955DFB262(undefined, "stealth_a");

                if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group)) {
                  _id_18A73A64992DD07D::run_spawn_module(spawn_group);
                  level._id_37DBED10A6D2831C = 1;
                  level notify("kill_barracks_reinforcements_check_thread");
                  level notify("reinforcements_spawned_for_obj" + objname);
                }
              }
            }
          }
        }
      }
    }
  }

  if(objname == "stealth_b") {
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(isDefined(checkpoint) && checkpoint == "checkpoint_b") {
      return;
    }
    level notify("unload_spawners_for_obj", "b");

    if(level._id_A359CB3E2BFA1964[objname] < 1 && level._id_9EEAB63C54988C55[objname] < 1 && level._id_359C318944444B78[objname] < 1) {
      thread _id_922DE60337409A17(objname);
      return;
    } else {
      wait 2;

      if(_func_EAC0CD99C9C6D8EE() != "spotted")
        return;
    }

    if(!isDefined(level._id_F75A58E27E264659))
      level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

    if(!istrue(level._id_F6F2A8878CAC1484)) {
      level._id_F6F2A8878CAC1484 = 1;

      foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659) {
        if(isDefined(_id_CDCD3C78F5177DB6.struct.script_label) && _id_CDCD3C78F5177DB6.struct.script_label == objname)
          thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1, 3);
      }
    }

    if(getdvarint("dvar_E9B58655E7876F05") != 0) {
      level notify("reinforcements_spawned_for_obj" + objname);
      level thread _id_86FED6BE9B334E59();
      return;
    }

    spawn_group = _id_742F61B6768A1AAB::_id_B69E8D7955DFB262(undefined, objname);

    if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group))
      _id_18A73A64992DD07D::run_spawn_module(spawn_group);

    level notify("reinforcements_spawned_for_obj" + objname);
  }

  if(objname == "stealth_c") {
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(isDefined(checkpoint) && checkpoint == "checkpoint_c") {
      return;
    }
    level notify("unload_spawners_for_obj", "c");

    if(!istrue(_id_C8FCFEAE020541D9)) {
      if(level._id_A359CB3E2BFA1964[objname] < 1 && level._id_9EEAB63C54988C55[objname] < 1 && level._id_359C318944444B78[objname] < 1) {
        thread _id_922DE60337409A17(objname);
        return;
      } else {
        wait 2;

        if(_func_EAC0CD99C9C6D8EE() != "spotted")
          return;
      }
    } else
      wait 2;

    if(getdvarint("dvar_E637894E145488A7", 0) != 0) {
      if(!istrue(level._id_8332A0D90935D5E8[objname])) {
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_interior", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_interior_upstairs", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_upstairs_ambush", "stealth_container");
        level._id_8332A0D90935D5E8[objname] = 1;
        level notify("kill_objC_spawner_thread");
      }
    }

    if(!isDefined(level._id_F75A58E27E264659))
      level._id_F75A58E27E264659 = getEntArray("pa_system", "targetname");

    if(!istrue(level._id_F9580383F29FDD61)) {
      level._id_F9580383F29FDD61 = 1;

      foreach(_id_CDCD3C78F5177DB6 in level._id_F75A58E27E264659) {
        if(isDefined(_id_CDCD3C78F5177DB6.struct.script_label) && _id_CDCD3C78F5177DB6.struct.script_label == objname)
          thread scripts\cp\coop_stealth::_id_C72B7181608C8607(_id_CDCD3C78F5177DB6, 1, 3);
      }
    }

    _id_A7365947A0A87DDA = 0;

    foreach(player in level.players) {
      if(isDefined(level._id_B39EB382281F2D25)) {
        if(player istouching(level._id_B39EB382281F2D25))
          _id_A7365947A0A87DDA = 1;
      }
    }

    if(istrue(_id_A7365947A0A87DDA)) {
      if(_id_978DDF8D9DACEF1D()) {
        level._id_903BC17EF2825BAB = 1;
        spawn_group = _id_742F61B6768A1AAB::_id_B69E8D7955DFB262(undefined, objname);

        if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group)) {
          _id_18A73A64992DD07D::run_spawn_module(spawn_group);
          level notify("reinforcements_spawned_for_obj" + objname);
        } else {
          ai_spawned = [];
          _id_63EBA43A116802D9 = spawn_group;
          _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

          if(isDefined(_id_5571AE8A9C277A18)) {
            ai_spawned = scripts\engine\utility::array_combine(ai_spawned, _id_5571AE8A9C277A18.ai_spawned);
            ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
          }

          if(ai_spawned.size == 0) {
            _id_18A73A64992DD07D::run_spawn_module(spawn_group);
            level notify("reinforcements_spawned_for_obj" + objname);
          }
        }
      }
    } else if(!istrue(level._id_903BC17EF2825BAB)) {
      spawn_group = _id_742F61B6768A1AAB::_id_B69E8D7955DFB262(undefined, objname);

      if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group)) {
        _id_18A73A64992DD07D::run_spawn_module(spawn_group);
        level notify("reinforcements_spawned_for_obj" + objname);
      } else {
        ai_spawned = [];
        _id_63EBA43A116802D9 = spawn_group;
        _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

        if(isDefined(_id_5571AE8A9C277A18)) {
          ai_spawned = scripts\engine\utility::array_combine(ai_spawned, _id_5571AE8A9C277A18.ai_spawned);
          ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
        }

        if(ai_spawned.size == 0) {
          _id_18A73A64992DD07D::run_spawn_module(spawn_group);
          level notify("reinforcements_spawned_for_obj" + objname);
        }
      }
    }
  }

  if(objname == "exfil_area") {
    if(scripts\cp\cp_objectives::is_objective_active("stealth_container")) {
      return;
    }
    if(istrue(level._id_346468EE3644046F)) {
      return;
    }
    spawn_group = _id_742F61B6768A1AAB::_id_B69E8D7955DFB262(undefined, objname);

    if(!scripts\engine\utility::array_contains(level.active_spawn_modules, spawn_group))
      _id_18A73A64992DD07D::run_spawn_module(spawn_group);
  }

  if(getdvarint("dvar_4A73004069F6F88C", 1) != 0) {
    foreach(ai in getaiarray("axis")) {
      foreach(player in level.players) {
        if(!istrue(player.inlaststand))
          ai scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
      }
    }
  }

  if(getdvarint("dvar_880405187E0BD323", 0) != 0)
    level._id_84B6EFB0B4CDABD5 = 1;
}

_id_978DDF8D9DACEF1D() {
  if(istrue(level._id_903BC17EF2825BAB))
    return 0;

  foreach(player in level.players) {
    if(isDefined(level._id_B39EB382281F2D25)) {
      if(player istouching(level._id_B39EB382281F2D25))
        return 1;
    }
  }

  return 0;
}

_id_86FED6BE9B334E59() {
  if(!istrue(level._id_B681A67C472F3E22)) {
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior", "stealth_container");
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior_patrol", "stealth_container");
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior_roof", "stealth_container");
  }

  _id_41ABE0908B86B235 = ["spawner_obj_b_exterior_", "spawner_obj_b_exterior_patrol_", "spawner_obj_b_exterior_roof_"];
  ai_spawned = [];

  foreach(group_name in _id_41ABE0908B86B235) {
    _id_63EBA43A116802D9 = group_name + _id_742F61B6768A1AAB::_id_D70F981E9EBE2A90();
    _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_63EBA43A116802D9, 1)[0];

    if(isDefined(_id_5571AE8A9C277A18)) {
      ai_spawned = scripts\engine\utility::array_combine(ai_spawned, _id_5571AE8A9C277A18.ai_spawned);
      ai_spawned = scripts\engine\utility::array_removedead_or_dying(ai_spawned);
    }
  }

  if(ai_spawned.size > 0) {
    foreach(ai in ai_spawned) {
      ai.script_stealthgroup = undefined;
      ai thread _id_742F61B6768A1AAB::_id_D24590F588A71CA2();
    }
  }
}

_id_922DE60337409A17(objective) {
  level endon("reinforcements_spawned_for_obj" + objective);
  level notify("reinforcements_spawnReinforcementsIfWorldIsStillInCombat" + objective);
  level endon("reinforcements_spawnReinforcementsIfWorldIsStillInCombat" + objective);
  wait 5;

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    if(objective != "exfil_area")
      return;
  }

  _id_62B762D8A739DE9E(1);
}

_id_F469B6EB4DCD52CF(player) {
  _id_E61AF03C9E384F0F = 0;
  _id_E7758D1CEF59FBF6 = 0;
  _id_E4189F6142F280F1 = 0;
  _id_2795910EA142BEBD = 0;
  _id_5EAD7CD5BD2A23C3 = getEnt("interior_ai_spawn_trigger_objA", "targetname");
  _id_046CF58102043E30 = getEnt("interior_ai_spawn_trigger_objB", "targetname");
  _id_867B6418DD3354E1 = getEnt("interior_ai_spawn_trigger_objC", "targetname");
  _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");

  if(isDefined(player.recondronesuper) || isDefined(player.drone)) {
    if(player.recondronesuper istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(player.recondronesuper istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(player.recondronesuper istouching(_id_867B6418DD3354E1))
      _id_E4189F6142F280F1 = 1;

    if(player.recondronesuper istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;
  }

  if(isDefined(player.vehicle)) {
    if(player.vehicle istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(player.vehicle istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(player.vehicle istouching(_id_867B6418DD3354E1))
      _id_E4189F6142F280F1 = 1;

    if(player.vehicle istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;
  }

  if(player istouching(_id_5EAD7CD5BD2A23C3))
    _id_E61AF03C9E384F0F = 1;

  if(player istouching(_id_046CF58102043E30))
    _id_E7758D1CEF59FBF6 = 1;

  if(player istouching(_id_867B6418DD3354E1))
    _id_E4189F6142F280F1 = 1;

  if(player istouching(_id_A5AE61DD930BF2A5))
    _id_2795910EA142BEBD = 1;

  if(_id_E61AF03C9E384F0F)
    return "stealth_a";

  if(_id_E7758D1CEF59FBF6)
    return "stealth_b";

  if(_id_E4189F6142F280F1)
    return "stealth_c";

  if(_id_2795910EA142BEBD)
    return "exfil_area";

  return "";
}

_id_A565F7E6BB57FB0F() {
  _id_CD5E9D1ECB0BCBD3 = "";

  foreach(player in level.players) {
    _id_CD5E9D1ECB0BCBD3 = _id_F469B6EB4DCD52CF(player);

    switch (_id_CD5E9D1ECB0BCBD3) {
      case "stealth_a":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "stealth_b":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "stealth_c":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "exfil_area":
        break;
      default:
        break;
    }
  }

  return 1;
}

_id_4E0244F0C1AB5067(_id_65661AE3A873C9AE, stealth_group) {
  if(scripts\cp\cp_objectives::is_objective_active("stealth_container") || scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    _id_62B762D8A739DE9E(_id_65661AE3A873C9AE);
    return;
  }

  if(getdvarint("dvar_880405187E0BD323", 0) != 0)
    level._id_84B6EFB0B4CDABD5 = 1;
}

_id_D9E51CD42D6791F7() {
  if(istrue(level._id_66AE399A49ACC469)) {
    return;
  }
  level._id_66AE399A49ACC469 = 1;
  level._id_41543DD7848ADA95 = getdvarint("dvar_1B8014A11247469F", 4);

  if(isDefined(level.drone_turrets)) {
    if(level.drone_turrets.size > level._id_41543DD7848ADA95)
      return;
  }

  level._id_892990D1B2DA4A65 = 4000000;
  level._id_8C0C40822E2C4024 = 1;
  _id_26312840E0E05273 = scripts\engine\utility::getStructArray("drone_spawn_obj_b", "targetname");
  counter = 0;

  foreach(spawnpoint in _id_26312840E0E05273) {
    if(counter > level._id_41543DD7848ADA95) {
      return;
    }
    _id_021787630BBEE2A4::_id_CB2C1DF00BD5E191(spawnpoint, "drone_grid_b");
    counter++;
  }

  level._id_66AE399A49ACC469 = undefined;
}

spawn_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
  _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 10));
  _id_656F0AE440B1B5D5 childthread plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A);
  return _id_656F0AE440B1B5D5;
}

plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = angles;
  self.owner = spawnStruct();
  self.owner.angles = angles;
  self.owner.team = "neutral";
  self.team = "neutral";
  owner = self.owner;
  self.weapon_object = makeweapon("claymore_mp");
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread minedamagemonitor();
  thread _id_5AB46177C0225D0A();
  thread scripts\cp\cp_claymore::claymore_explodeonnotify();
  thread scripts\cp\cp_claymore::claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  wait 0.1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  self.equipmentref = "equip_claymore";
  self._id_3DBA99677FD840CD = ::_id_16B65EE43D765196;
  _id_6159D9FD44490F13::_hacksetup();
  thread custom_explode_mine(origin);
  thread scripts\cp\cp_claymore::enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A);
}

_id_16B65EE43D765196() {
  self notify("clean_custom_explode");

  if(isDefined(self.useobj))
    self.useobj delete();

  thread _id_74502A9E0EF1F19C::deleteexplosive();
}

_id_5AB46177C0225D0A() {
  self endon("death");
  self waittill("hacked");
  self playSound("cp_claymore_disable");
}

makeexplosiveusabletag(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;

  if(!isDefined(isgrenade))
    isgrenade = 0;

  self makeusable();

  if(isgrenade)
    self enablemissilehint(1);
  else
    self setCursorHint("HINT_NOICON");

  self sethinttag(tagname);
  self setuserange(72);
  _id_1DB8D0E02A99C5E2::setexplosiveusablehintstring(self.weapon_name);
  self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player _id_3B64EB40368C1450::set("show_claymore", "weapon_switch", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "mantle", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "prone", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "melee", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "offhand_weapons", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "weapon_pickup", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "usability", 0);
    player _id_3B64EB40368C1450::set("show_claymore", "vehicle_use", 0);
    self setscriptablepartstate("hacked", "active", 0);
    self playSound("cp_claymore_disable");
    wait 0.25;
    currentweapon = player getcurrentweapon();
    _id_2FAA2C4B7D9E16E4 = makeweapon("pickup_claymore");
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_2FAA2C4B7D9E16E4);
    player switchtoweapon(_id_2FAA2C4B7D9E16E4);
    self hide();
    wait 1.25;
    player takeweapon(_id_2FAA2C4B7D9E16E4);
    player switchtoweapon(currentweapon);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("show_claymore");

    if(!player _id_7EF95BBA57DC4B82::hasequipment("equip_claymore"))
      player thread _id_7EF95BBA57DC4B82::giveequipment("equip_claymore", "primary");
    else
      player _id_7EF95BBA57DC4B82::incrementequipmentammo("equip_claymore");

    self notify("clean_custom_explode");

    if(isDefined(self.useobj))
      self.useobj delete();

    thread _id_74502A9E0EF1F19C::deleteexplosive();
    return;
  }
}

custom_explode_mine(origin) {
  self endon("clean_custom_explode");
  _id_B9CE53DAD043E9E4 = origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  attacker = getaiarray("axis")[0];
  radiusdamage(_id_419BFD33C72E7EF9, 30, 1000, 200, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(_id_B9CE53DAD043E9E4, 75, 1000, 20, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(istrue(self.isbeingused)) {
      continue;
    }
    self notify("mine_destroyed");

    if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
      self.waschained = 1;

    if(isDefined(idflags) && idflags &level.idflags_penetration)
      self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;

    if(isDefined(attacker))
      self.damagedby = attacker;

    self notify("detonateExplosive", attacker);
    return;
  }
}

enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("hacked");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    _id_00AF3B9624C6AB60 = level.players;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    _id_2CC97E113610CA14 = self.origin + up * 0;
    ignorelist = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(struct in level.dynamicladders)
      ignorelist[ignorelist.size] = struct.ents[0];
    }

    if(istrue(_id_F8F2EBF05B9AF55A))
      _id_00AF3B9624C6AB60 = scripts\engine\utility::array_combine(_id_00AF3B9624C6AB60, getaiarray("allies"));

    foreach(_id_548B9F6609CE3883 in _id_00AF3B9624C6AB60) {
      if(!isDefined(_id_548B9F6609CE3883)) {
        continue;
      }
      if(isPlayer(_id_548B9F6609CE3883) && _id_0AFB7E332AEE4BF2::player_in_laststand(_id_548B9F6609CE3883) || isagent(_id_548B9F6609CE3883) && !isalive(_id_548B9F6609CE3883)) {
        continue;
      }
      if(lengthsquared(_id_548B9F6609CE3883 getentityvelocity()) < 10) {
        continue;
      }
      binvehicle = 0;

      if(distance2dsquared(_id_548B9F6609CE3883.origin, self.origin) > 50625) {
        continue;
      }
      if(isDefined(_id_548B9F6609CE3883.vehicle))
        binvehicle = 1;

      _id_AD283A45677A1EA3 = _id_548B9F6609CE3883 gettagorigin("j_mainroot");

      if(istrue(binvehicle))
        _id_AD283A45677A1EA3 = _id_548B9F6609CE3883.vehicle.origin;

      _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
      _id_340D59422336E85A = _id_2CC97E113610CA14 - _id_AD283A45677A1EA3;

      if(vectordot(_id_340D59422336E85A, (0, 0, 1)) >= 0)
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883 gettagorigin("j_spineupper");
      else
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883.origin;

      foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
        _id_340D59422336E85A = _id_A00164B06F60F5E6 - self.origin;
        _id_CC00B910BD1D69C8 = vectordot(_id_340D59422336E85A, forward);

        if(_id_CC00B910BD1D69C8 > 192 || _id_CC00B910BD1D69C8 < 20) {
          continue;
        }
        _id_69211973F7D7BBD6 = vectordot(_id_340D59422336E85A, up);

        if(abs(_id_69211973F7D7BBD6) > 32) {
          continue;
        }
        _id_A3D051EF761EFD24 = vectorNormalize(_id_340D59422336E85A);
        _id_74876E67651C79A6 = vectordot(_id_A3D051EF761EFD24, forward);

        if(_id_74876E67651C79A6 < 0.86602) {
          continue;
        }
        _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_A00164B06F60F5E6, contents, ignorelist, 0, "physicsquery_closest", 1);

        if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
          continue;
        }
        thread scripts\cp\cp_claymore::claymore_trigger(_id_548B9F6609CE3883);
      }
    }

    wait 0.05;
  }
}

_id_DD58FE315B085D35(_id_9B993EC50CE8B654) {
  self notify("trigger_alarm");
  _id_9B993EC50CE8B654.shouldskipdeathsshield = 1;
  _id_9B993EC50CE8B654 _id_3AE866A6DD08DAF9::push_players_back_and_deal_damage(_id_9B993EC50CE8B654);
  _id_9B993EC50CE8B654 dodamage(_id_9B993EC50CE8B654.health + 10000, _id_9B993EC50CE8B654.origin);
}

_id_DF3AD2237853744A() {
  self.trigger notify("disable_trap_no_alarm");
  iprintln("^6 Disabled Alarm!! ");
  return 1;
}

_id_27C39909E6A63240(_id_B46496BA73DC641B) {
  if(!isDefined(level.activequests)) {
    return;
  }
  if(level.activequests.size <= 0) {
    return;
  }
  if(scripts\cp\cp_objectives::is_objective_active("stealth_a") || scripts\cp\cp_objectives::is_objective_active("stealth_b") || scripts\cp\cp_objectives::is_objective_active("stealth_c")) {
    return;
  }
  switch (_id_B46496BA73DC641B) {
    case "stealth_a":
      if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
        return;
      }
      if(istrue(level._id_E73F4670FAC3BB99)) {
        return;
      }
      level._id_E73F4670FAC3BB99 = 1;
      level thread _id_3F36F922FAC89B88::_id_94F6A7A616983A99();
      break;
    case "stealth_b":
      if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
        return;
      }
      if(istrue(level._id_800C60CFEEAF3222)) {
        return;
      }
      level._id_800C60CFEEAF3222 = 1;
      level thread _id_3F36F922FAC89B88::_id_9B4E08F8DE0B4636();
      break;
    case "stealth_c":
      if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
        return;
      }
      if(istrue(level._id_4714D3781E8C366B)) {
        return;
      }
      level._id_4714D3781E8C366B = 1;
      level thread _id_3F36F922FAC89B88::_id_971BE1A4E2A8013B();
      break;
    case "exfil_area":
      if(istrue(level._id_0E7E708854355FF7)) {
        return;
      }
      level._id_0E7E708854355FF7 = 1;
      level thread _id_3F36F922FAC89B88::_id_6FA1D65707713DF4();
      break;
  }
}

_id_1BA5516CB29B671F() {
  _id_B272B0FF03EF37D6 = 6.0;
  _id_AAFB47C968E733BC = 0.5;
  _id_AAD835C968C0C46E = 1.0;
  _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30) {
    magicgrenademanual("smoke_grenade_mp", _id_D0697AF2ECA83D63.origin, (0, 0, 4), 0.05);
    _id_3D5486C42744F400 = randomfloatrange(_id_AAFB47C968E733BC, _id_AAD835C968C0C46E);
    wait(_id_3D5486C42744F400);
  }

  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_riotshield");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_rpg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_lmg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_shotgun");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_jugg");
}

_id_0BE65C33F980FE0B() {
  _id_D2F151404CD811A3 = scripts\engine\utility::getStructArray("door_open", "script_noteworthy");

  foreach(struct in _id_D2F151404CD811A3) {
    _id_4FFC8A24C8B56841 = _id_7E1A468DA43087E3::_id_F0AACBE05ACE1594(struct.origin, 32)[0];
    _id_4FFC8A24C8B56841 scriptabledooropen("away", struct.origin);
  }
}

_id_721A895516840749() {
  wait 8;

  if(level.players.size < 2) {
    if(istrue(level._id_27856C6130F4DDCA))
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/NIKOLAI_STEALTH_RESP_1_1");
    else
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/ISKRA_STEALTH_SOLO");

    return;
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/OW_INTRO_2");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/OW_INTRO_3");
  wait 5;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/NIKOLAI_STEALTH_RESP_1_1");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/ISKRA_STEALTH_RESP_1_3");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/NIKOLAI_STEALTH_RESP_1_4");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BAD_SITUATION_OBJ/ISKRA_STEALTH_RESP_1_5");
  wait 3;
}

_id_94F6A7A616983A99() {
  wait 10;
  _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_exterior");
  _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_exterior_patrol");
  level thread _id_3E993095709797BD();
  level thread _id_5D96D5ED2C4E7AA9();
  level thread _id_B1D0E7C28EA91BC7();
}

_id_5D96D5ED2C4E7AA9() {
  level endon("obj_a_interior_spawned");

  for(;;) {
    level waittill("door_event", origin, _id_EEE718E33217DC9E);
    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(origin, getEnt("interior_ai_spawn_trigger_objA", "targetname").origin) <= 90000) {
      if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_shotgun");
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_shotgun");
      } else {
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_smg");
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_smg");
      }

      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_upstairs_ambush");
      level._id_8332A0D90935D5E8[objname] = 1;
      level notify("kill_upstairs_thread");
      level notify("obj_a_interior_spawned");
    }
  }
}

_id_3E993095709797BD() {
  level endon("obj_a_interior_spawned");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger_objA", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_shotgun");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_shotgun");
    } else {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_smg");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_smg");
    }

    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_upstairs_ambush");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_upstairs_thread");
    level notify("obj_a_interior_spawned");
    break;
  }
}

_id_B1D0E7C28EA91BC7() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_upstairs_objA", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_22FEDCD8701E4DD7();
}

_id_22FEDCD8701E4DD7() {
  level endon("kill_upstairs_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_shotgun");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_shotgun");
    } else {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_smg");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_interior_upstairs_smg");
    }

    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_a_upstairs_ambush");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("obj_a_interior_spawned");
    level notify("kill_upstairs_thread");
    break;
  }
}

_id_AA69B2F90D1FBC52(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_71F7A07481B495BC(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_7E1A468DA43087E3::_id_7CD97A856163B260);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_stealth_spawn_a", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_6875A994E7665716(objectivestruct, _id_5DCDFD3A4EFF9961) {
  spawn_claymore_group("obj_b_claymores");
  level thread _id_1B883233216DE750();
  thread scripts\cp\cp_snakecam::enable_snake_cams();

  foreach(struct in scripts\engine\utility::getStructArray("spawner_obj_b_sniper", "targetname")) {
    radiusdamage(struct.origin, 333, 500, 500);
    waitframe();
  }
}

_id_1B883233216DE750() {}

_id_DB3A84DB2F2EF16F(objectiveindex) {
  level._id_A9B2958FE504A4E6 = getEntArray("intel_loc", "targetname");

  if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size > 0)
    level._id_324A6E68A953D960 = 0;
  else {
    level._id_324A6E68A953D960 = 0;
    level._id_D0ADA23E81337306 = [];
  }

  level._id_E7B157FD6CF95460 = [];

  foreach(index, _id_96477DA1695E035B in level._id_A9B2958FE504A4E6) {
    if(_id_96477DA1695E035B.script_noteworthy == "b" || _id_96477DA1695E035B.script_noteworthy == "a" || _id_96477DA1695E035B.script_noteworthy == "c") {
      if(scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, _id_96477DA1695E035B.script_noteworthy)) {
        _id_96477DA1695E035B delete();
        continue;
      }

      _id_96477DA1695E035B _id_6AF7472ED306D1E5();
      objindex = scripts\cp\cp_objectives::requestworldid("intel_obj" + index, 3 + int(index));
      _id_96477DA1695E035B thread _id_3858411D0B73D352::_id_ABD47CB8E8E2A6D0("intel_obj" + index);
      objective_setplayintro(objindex, 0);
      objective_setplayoutro(objindex, 0);

      foreach(struct in scripts\engine\utility::getStructArray("objective_location", "targetname")) {
        if(_id_96477DA1695E035B.script_noteworthy == struct.script_noteworthy) {
          objective_setlocation(objindex, 0, struct.origin);
          objective_state(objindex, "current");
          _id_96477DA1695E035B scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Bad_Situation_Cp", struct.origin, 2048);
          _id_96477DA1695E035B scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
          scripts\cp\cp_objectives::objective_minimapupdate(objindex);
          _id_96477DA1695E035B._id_5F2112921F67C9CE = struct;
        }
      }

      objective_state(objindex, "current");

      if(_id_96477DA1695E035B.script_noteworthy == "a") {
        objective_icon(objindex, "icon_waypoint_dom_b");
        objective_setlabel(objindex, &"CP_BAD_SITUATION_OBJ/INTEL_B");
      }

      if(_id_96477DA1695E035B.script_noteworthy == "b") {
        objective_icon(objindex, "icon_waypoint_dom_c");
        objective_setlabel(objindex, &"CP_BAD_SITUATION_OBJ/INTEL_A");
      }

      if(_id_96477DA1695E035B.script_noteworthy == "c") {
        objective_icon(objindex, "icon_waypoint_dom_a");
        objective_setlabel(objindex, &"CP_BAD_SITUATION_OBJ/INTEL_C");
      }

      objective_setminimapiconsize(objindex, "icon_regular");
      objective_setshowdistance(objindex, 1);
      _id_96477DA1695E035B.objectiveindex = objindex;
      level._id_F30F234DCD5FE40B = scripts\engine\utility::array_add(level._id_F30F234DCD5FE40B, _id_96477DA1695E035B);

      if(!scripts\engine\utility::flag("cleared_to_play_intro_vo"))
        objective_removeallfrommask(_id_96477DA1695E035B.objectiveindex);
      else
        objective_addalltomask(_id_96477DA1695E035B.objectiveindex);
    }
  }
}

_id_F7F781BE810D09F2() {
  foreach(_id_CC4B9CFA93202799 in level._id_F30F234DCD5FE40B)
  objective_addalltomask(_id_CC4B9CFA93202799.objectiveindex);
}

_id_6AF7472ED306D1E5() {
  if(getdvarint("dvar_EB2F6D009F65CB77", 0) != 0) {
    if(isDefined(self.target)) {
      _id_0BAE65FF0227A539 = scripts\engine\utility::getStructArray(self.target, "targetname");
      _id_97F1BD927537DDFD = getdvarint("dvar_EB2F6D009F65CB77", 0);

      switch (_id_97F1BD927537DDFD) {
        case 1:
          _id_98C2A96E308A4CC9 = scripts\engine\utility::random(_id_0BAE65FF0227A539);
          self.origin = _id_98C2A96E308A4CC9.origin;
          self.angles = _id_98C2A96E308A4CC9.angles;
          break;
        case 2:
          self.origin = _id_0BAE65FF0227A539[0].origin;
          self.angles = _id_0BAE65FF0227A539[0].angles;
          break;
        case 3:
          self.origin = _id_0BAE65FF0227A539[1].origin;
          self.angles = _id_0BAE65FF0227A539[1].angles;
          break;
        case 4:
          self.origin = _id_0BAE65FF0227A539[2].origin;
          self.angles = _id_0BAE65FF0227A539[2].angles;
          break;
      }
    }
  }
}

_id_9B4E08F8DE0B4636() {
  wait 10;

  if(getdvarint("dvar_F94319AFACA59ED6", 0) == 0)
    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_sniper");

  _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_exterior");
  _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_exterior_patrol");
  level thread _id_F6B56FD3E2C0C02C();
  level thread _id_5D96D2ED2C4E7410();
}

_id_5D96D2ED2C4E7410() {
  level endon("obj_b_interior_spawned");

  for(;;) {
    level waittill("door_event", origin, _id_EEE718E33217DC9E);
    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(origin, getEnt("interior_ai_spawn_trigger", "targetname").origin) <= 90000) {
      if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_interior_shotgun");
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_ambush_shotgun");
      } else {
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_interior_smg");
        _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_ambush_smg");
      }

      level._id_8332A0D90935D5E8[objname] = 1;
      level notify("kill_objb_spawner_thread");
      level notify("obj_b_interior_spawned");
    }
  }
}

_id_F6B56FD3E2C0C02C() {
  level notify("kill_objb_spawner_thread");
  level endon("kill_objb_spawner_thread");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_interior_shotgun");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_ambush_shotgun");
    } else {
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_interior_smg");
      _id_18A73A64992DD07D::run_spawn_module("spawner_obj_b_ambush_smg");
    }

    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objb_spawner_thread");
    break;
  }
}

_id_AA69B1F90D1FBA1F(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_71F7A37481B49C55(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_7E1A468DA43087E3::_id_7CD97A856163B260);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_stealth_spawn", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_6875AA94E7665949(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level.hvts_identified = 1;
  thread scripts\cp\cp_snakecam::enable_snake_cams();
  level thread _id_AD620C1E7115446B();
}

_id_AD620C1E7115446B() {
  level endon("game_ended");
  scripts\engine\utility::array_call(getEntArray("barn_door_collision", "targetname"), ::disconnectpaths);
  scripts\engine\utility::array_call(getEntArray("barn_doors", "targetname"), ::disconnectpaths);
  level waittill("c4_exploded", origin, _id_741F82E1A668A329);
  _id_DA96C8943126A950 = getaiarrayinradius(origin, 2048);

  foreach(ai in _id_DA96C8943126A950)
  ai aieventlistenerevent("explosion", _id_741F82E1A668A329, origin);

  scripts\engine\utility::array_call(getEntArray("barn_door_collision", "targetname"), ::connectpaths);
  scripts\engine\utility::array_call(getEntArray("barn_door_collision", "targetname"), ::delete);
  scripts\engine\utility::array_call(getEntArray("barn_doors", "targetname"), ::delete);
}

_id_B1D0E9C28EA9202D() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_objC", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_50C7F174DAE1AEEA();
}

_id_50C7F174DAE1AEEA() {
  level endon("kill_objC_spawner_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

    if(scripts\cp\cp_objectives::is_objective_active("stealth_a"))
      objname = "stealth_a";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_b"))
      objname = "stealth_b";
    else if(scripts\cp\cp_objectives::is_objective_active("stealth_c"))
      objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_c_interior");
    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_c_interior_upstairs");
    _id_18A73A64992DD07D::run_spawn_module("spawner_obj_c_upstairs_ambush");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objC_spawner_thread");
    break;
  }
}

_id_AA69B0F90D1FB7EC(objectivestruct, _id_5DCDFD3A4EFF9961) {}

_id_71F7A27481B49A22(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_bs_cs_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_7E1A468DA43087E3::_id_7CD97A856163B260);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "bs_stealth_spawn_c", 1);

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_FAF6D0CBA73888AC() {
  level endon("game_ended");
  tag = "tag_light_1";
  tag_origin = self gettagorigin(tag);
  _id_DE5BCE61D0970048 = self gettagangles(tag);
  turret = spawnturret("misc_turret", tag_origin, "spotlight_turret", 0);
  turret linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  turret setModel("tag_turret");
  playFXOnTag(scripts\engine\utility::getfx("chopper_spotlight"), turret, "tag_flash");
  self.spotlight = turret;
  turret thread _id_B45E28959B7CC1B9();
  _id_E158BFBAB3D9C7DE = scripts\cp\coop_stealth::get_players_not_in_laststand();

  if(_id_E158BFBAB3D9C7DE.size == 0)
    _id_E158BFBAB3D9C7DE = level.players;

  targetent = scripts\engine\utility::spawn_script_origin(_id_E158BFBAB3D9C7DE[0].origin);
  self._id_E97B659354339F4F = level.players;
  turret setmode("manual");
  turret setleftarc(180);
  turret setrightarc(180);
  turret settoparc(180);
  turret setbottomarc(180);
  turret makeunusable();
  turret settargetentity(targetent);
  turret.targetent = targetent;
  speed = 200;
  _id_09381CA324B30F76 = 500;
  _id_84156A78FD675BA1 = -30;
  _id_4287F086E67F8E0F = 30;
  _id_C96F5672121DC008 = -60;
  _id_EE3E6EF05030FD26 = 60;
  _id_999DBF0D920FE642 = (0, 0, 0);

  while(isDefined(self._id_E97B659354339F4F)) {
    self._id_E97B659354339F4F = scripts\engine\utility::array_removeundefined(self._id_E97B659354339F4F);

    if(self._id_E97B659354339F4F.size > 0) {
      targetpos = scripts\common\createfx::get_center_of_array(self._id_E97B659354339F4F) + (0, 0, 0);
      _id_999DBF0D920FE642 = targetpos;
    } else
      targetpos = _id_999DBF0D920FE642;

    targetpos = targetpos + (randomfloatrange(_id_C96F5672121DC008, _id_EE3E6EF05030FD26), randomfloatrange(_id_C96F5672121DC008, _id_EE3E6EF05030FD26), 0);
    dist = distance(targetpos, targetent.origin);

    if(dist > 500)
      time = dist / (_id_09381CA324B30F76 + randomfloatrange(_id_84156A78FD675BA1, _id_4287F086E67F8E0F));
    else
      time = dist / (speed + randomfloatrange(_id_84156A78FD675BA1, _id_4287F086E67F8E0F));

    targetent moveTo(targetpos, time, time * 0.5, time * 0.5);
    targetent waittill("movedone");
  }
}

_id_B45E28959B7CC1B9() {
  self endon("death");

  for(;;) {
    forward = anglesToForward(self gettagangles("tag_flash"));
    waitframe();
  }
}

delay_activate_laser(sniper) {
  sniper endon("death");
  sniper scripts\engine\utility::waittill_any_timeout_2(5, "goal", "goal_reached");
  sniper.gunposeoverride = "ads";
  _id_FBC73A3AAC841ADA(sniper);
  sniper thread _id_4C99439A8325BFD1();
}

_id_A201BDAF56F81440(_id_4055F938BEE2503A) {
  self endon("death");
  _id_4055F938BEE2503A endon("death");
  _id_4055F938BEE2503A endon("disconnect");
  self endon("force_clear_all_threads");
  thread enemy_sniper_player_monitor(_id_4055F938BEE2503A, self);
  thread sniper_target_think(self, _id_4055F938BEE2503A);
  thread _id_F28361FFE9F43CF9(self, _id_4055F938BEE2503A);
  _id_4055F938BEE2503A thread _id_ABD987606C3483BD(self);
  self waittill("return_to_search");
  iprintln(" LOST PLAYER - ^1" + _id_4055F938BEE2503A.name);
  _id_4055F938BEE2503A scripts\engine\utility::ent_flag_clear("laser_spotted_player");
  scripts\engine\utility::array_thread(level._id_828450D6FB8CAE84, _id_4B02400DAD63CAFB::_id_A08BB096BB00739A);
  thread _id_4C99439A8325BFD1();
  _id_4055F938BEE2503A notify("clean_spotted_player_threads");
}

_id_ABD987606C3483BD(sniper) {
  sniper endon("death");
  self endon("clean_spotted_player_threads");
  sniper endon("force_clear_all_threads");
  scripts\engine\utility::waittill_2("death", "disconnect");
  sniper thread _id_4C99439A8325BFD1();
  scripts\engine\utility::array_thread(level._id_828450D6FB8CAE84, _id_4B02400DAD63CAFB::_id_A08BB096BB00739A);
}

_id_4C99439A8325BFD1() {
  self endon("death");
  self endon("spotted_player");
  self notify("sniper_laser_ambient");
  self endon("sniper_laser_ambient");
  self endon("force_clear_all_threads");
  _id_742F61B6768A1AAB::_id_BC62CC1ADFB69F41();
  _id_A66BA9B157533F5A = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "left", "right");
  array = self._id_51AF9D68ABAA12AF[_id_A66BA9B157533F5A];
  array = scripts\engine\utility::array_randomize(array);
  _id_C0A590ED14F737C6 = array[randomint(array.size)];
  wait 1;

  for(;;) {
    if(array.size == 0) {
      _id_A66BA9B157533F5A = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "left", "right");
      array = self._id_51AF9D68ABAA12AF[_id_A66BA9B157533F5A];
      array = scripts\engine\utility::array_randomize(array);
      _id_C0A590ED14F737C6 = array[randomint(array.size)];
      wait 1;
    }

    array = sortbydistance(array, _id_C0A590ED14F737C6.origin);
    _id_5FF31D70B5B91505 = array[array.size - 1];
    array = scripts\engine\utility::array_remove(array, _id_5FF31D70B5B91505);
    self.laser_end_ent _id_7CAA16DC3E64F485(_id_C0A590ED14F737C6, _id_5FF31D70B5B91505, self);

    if(randomint(100) < 66) {
      holdtime = 1.4 + randomfloat(2);
      wait(holdtime);
    }
  }
}

_id_7CAA16DC3E64F485(_id_C0A590ED14F737C6, _id_5FF31D70B5B91505, ai) {
  ai endon("spotted_player");
  targetangles = vectortoangles(_id_5FF31D70B5B91505.origin - self.origin);
  movetime = _id_7E1A468DA43087E3::mph_travel_time(randomintrange(9, 13), distance(_id_C0A590ED14F737C6.origin, _id_5FF31D70B5B91505.origin));
  movetime = int(movetime);
  movetime = scripts\engine\utility::ter_op(movetime <= 0, 1, movetime);
  _id_B5EE5C3A1C45A91F = randomintrange(4, 8);
  accel = movetime / _id_B5EE5C3A1C45A91F;
  decel = movetime - accel;

  if(isDefined(ai.laser_end_ent))
    ai.laser_end_ent moveTo(_id_5FF31D70B5B91505.origin, movetime, accel, decel);

  contents = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  level thread _id_D8637F123DB0824C(ai, contents, float(movetime));
  wait(movetime);
}

_id_D8637F123DB0824C(ai, contents, movetime) {
  ai endon("spotted_player");
  ai endon("death");
  t = 0.0;

  if(movetime <= 0)
    movetime = 1.0;

  while(t < movetime) {
    trace = scripts\engine\trace::ray_trace(ai.laser_start_ent.origin, ai.laser_end_ent.origin, [ai.laser_start_ent, ai.laser_end_ent, ai], contents);

    if(isDefined(trace["entity"]) && isPlayer(trace["entity"]))
      trace["entity"] thread _id_B287795C124D321E(ai);

    t = t + level.framedurationseconds;
    waitframe();
  }
}

_id_B287795C124D321E(sniper) {
  sniper endon("death");
  self endon("death");
  self endon("disconnect");
  self notify("player_spotted");
  self endon("player_spotted");
  self notify("new_laser_hit");
  self endon("new_laser_hit");
  scripts\engine\utility::ent_flag_set("laser_spotted_player");
  sniper notify("spotted_player");
  iprintln(" FOUND PLAYER - ^1" + self.name);
  sniper _id_A201BDAF56F81440(self);
}

sniper_player_monitor(sniper) {
  foreach(player in level.players)
  player thread enemy_sniper_player_monitor(player, sniper);

  level thread sniper_players_connect_monitor(sniper);
}

sniper_players_connect_monitor(sniper) {
  level endon("game_ended");
  sniper endon("death");

  for(;;) {
    level waittill("connected", player);
    player thread enemy_sniper_player_monitor(player, sniper);
  }
}

enemy_sniper_player_monitor(player, sniper) {
  player thread exposure_to_sniper_monitor(player, sniper);
}

exposure_to_sniper_monitor(player, sniper) {
  player endon("disconnect");
  sniper endon("death");
  sniper endon("clean_spotted_player_threads");
  sniper endon("force_clear_all_threads");

  if(!isDefined(sniper.player_exposure_data))
    sniper.player_exposure_data = [];

  _id_6698924DFF3AA2FC = player getentitynumber();
  _id_A678DD0BFDE22149 = spawnStruct();
  contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
  _id_A678DD0BFDE22149.exposed_to_enemy_sniper_time = 0;

  for(;;) {
    _id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper = [];

    if(scripts\engine\trace::ray_trace_passed(player.origin, sniper getEye(), [sniper], contents))
      _id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper[_id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper.size] = "origin";

    if(scripts\engine\trace::ray_trace_passed(player getEye(), sniper getEye(), [sniper], contents))
      _id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper[_id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper.size] = "eye";

    if(scripts\engine\trace::ray_trace_passed(player gettagorigin("j_spineupper"), sniper getEye(), [sniper], contents))
      _id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper[_id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper.size] = "chest";

    if(_id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper.size > 0)
      _id_A678DD0BFDE22149.exposed_to_enemy_sniper_time = _id_A678DD0BFDE22149.exposed_to_enemy_sniper_time + 0.05;
    else
      _id_A678DD0BFDE22149.exposed_to_enemy_sniper_time = 0;

    sniper.player_exposure_data[_id_6698924DFF3AA2FC] = _id_A678DD0BFDE22149;
    waitframe();
  }
}

sniper_target_think(sniper, _id_4055F938BEE2503A) {
  sniper endon("death");
  sniper endon("stop_trying_to_attack_player");

  if(isDefined(_id_4055F938BEE2503A))
    _id_4055F938BEE2503A endon("clean_spotted_player_threads");

  sniper endon("force_clear_all_threads");
  sniper notify("sniper_target_think");
  sniper endon("sniper_target_think");
  sniper.current_target = undefined;
  sniper._id_870A849563876043 = 0;

  for(;;) {
    _id_E158BFBAB3D9C7DE = [];

    if(isDefined(_id_4055F938BEE2503A) && isPlayer(_id_4055F938BEE2503A)) {
      if(!istrue(_id_4055F938BEE2503A.inlaststand))
        _id_E158BFBAB3D9C7DE = [_id_4055F938BEE2503A];
    } else
      _id_E158BFBAB3D9C7DE = scripts\cp\coop_stealth::get_players_not_in_laststand();

    _id_47777ECED9BF103C = 9;
    _id_871576A479986687 = undefined;

    foreach(player in _id_E158BFBAB3D9C7DE) {
      if(!isDefined(player.num_sniper_covering_me))
        player.num_snipers_covering_me = 0;

      target_score = get_player_target_score_for_sniper(player, sniper);

      if(target_score > _id_47777ECED9BF103C) {
        _id_47777ECED9BF103C = target_score;
        _id_871576A479986687 = player;
      }
    }

    if(isDefined(_id_871576A479986687) && is_new_target(_id_871576A479986687, sniper)) {
      if(has_current_target(sniper)) {
        wait(randomfloatrange(0.5, 1));
        unmark_player_as_sniper_target(sniper.current_target);
      }

      mark_player_as_sniper_target(sniper, _id_871576A479986687);
      _id_871576A479986687 thread sniper_death_monitor(_id_871576A479986687, sniper);
      result = _id_871576A479986687 scripts\engine\utility::waittill_any_timeout_1(randomfloatrange(1.5, 2), "last_stand");

      if(result == "last_stand") {
        unmark_player_as_sniper_target(_id_871576A479986687);
        wait 1.5;
      }
    } else if(has_current_target(sniper) && !sniper cansee(sniper.current_target)) {
      sniper._id_870A849563876043 = sniper._id_870A849563876043 + level.framedurationseconds;

      if(sniper._id_870A849563876043 >= 5) {
        unmark_player_as_sniper_target(sniper.current_target);
        sniper._id_870A849563876043 = 0;
        sniper notify("return_to_search");
      }
    }

    wait 0.05;
  }
}

has_current_target(sniper) {
  return isDefined(sniper.current_target);
}

is_new_target(_id_E909CCCBA8E3153B, sniper) {
  if(!has_current_target(sniper))
    return 1;

  return sniper.current_target != _id_E909CCCBA8E3153B;
}

mark_player_as_sniper_target(sniper, player) {
  sniper.current_target = player;
  sniper getenemyinfo(player);
  sniper setlookatentity(player);
  sniper.favoriteenemy = player;
  player.num_snipers_covering_me = player.num_snipers_covering_me + 1;
}

unmark_player_as_sniper_target(player) {
  player.num_snipers_covering_me = player.num_snipers_covering_me - 1;
}

sniper_death_monitor(player, sniper) {
  player endon("disconnect");
  sniper notify("sniper_death_monitor");
  sniper endon("sniper_death_monitor");
  sniper waittill("death");
  unmark_player_as_sniper_target(player);
}

get_player_target_score_for_sniper(player, sniper) {
  _id_151DA0F72F4FB947 = 25000000;
  score = 0;

  if(is_player_part_exposed_to_sniper(player, sniper, "eye"))
    score = score + 45;

  if(is_player_part_exposed_to_sniper(player, sniper, "origin"))
    score = score + 45;

  if(player_is_in_killzone(player))
    score = score + 200;

  _id_F427DD746D586DC3 = get_player_expose_time_to_sniper(player, sniper);
  score = score + _id_F427DD746D586DC3 * 10;
  score = int(max(0, score + player.num_snipers_covering_me * -45));
  _id_7DC715DD1053266B = distance2dsquared(player.origin, sniper.origin);
  score = score + 9 * (1 - clamp(_id_7DC715DD1053266B / _id_151DA0F72F4FB947, 0, 1));
  score = score + randomfloat(18);
  return score;
}

is_player_part_exposed_to_sniper(player, sniper, _id_1080D6BB12D6A0D6) {
  _id_A678DD0BFDE22149 = sniper.player_exposure_data[player getentitynumber()];
  return scripts\engine\utility::array_contains(_id_A678DD0BFDE22149.loc_exposed_to_enemy_sniper, _id_1080D6BB12D6A0D6);
}

get_player_expose_time_to_sniper(player, sniper) {
  _id_A678DD0BFDE22149 = sniper.player_exposure_data[player getentitynumber()];
  return _id_A678DD0BFDE22149.exposed_to_enemy_sniper_time;
}

_id_FBC73A3AAC841ADA(sniper) {
  sniper endon("death");
  spawn_pos = sniper gettagorigin("tag_laser_attach");
  spawn_pos = sniper getmuzzlepos();
  laser_start_ent = create_tag_origin(spawn_pos, sniper);
  laser_start_ent thread follow_tag_laser_attach(sniper, laser_start_ent);
  laser_end_ent = create_tag_origin(spawn_pos, sniper);
  sniper.laser_start_ent = laser_start_ent;
  sniper.laser_end_ent = laser_end_ent;
  turn_on_sniper_laser(sniper);
}

_id_F28361FFE9F43CF9(sniper, _id_4055F938BEE2503A) {
  sniper endon("death");
  _id_4055F938BEE2503A endon("clean_spotted_player_threads");
  sniper endon("force_clear_all_threads");
  sniper notify("sniper_laser_spotted_player_logic");
  sniper endon("sniper_laser_spotted_player_logic");
  scripts\engine\utility::array_thread(level._id_828450D6FB8CAE84, _id_4B02400DAD63CAFB::_id_978BB8252BD3ABCD, _id_4055F938BEE2503A);

  for(;;) {
    if(has_current_target(sniper)) {
      if(player_is_exposed_to_sniper(sniper.current_target, sniper)) {
        try_shoot_at_current_target(sniper, sniper.laser_start_ent);

        if(!istrue(sniper.laser_end_ent.is_linked_to_target)) {
          _id_027AB9C142F41152 = get_target_tag_to_link_to(sniper.current_target, sniper);
          _id_1E3F1FBA50BA6DA1 = sniper.current_target gettagorigin(_id_027AB9C142F41152);
          sniper.laser_end_ent.origin = _id_1E3F1FBA50BA6DA1;
          sniper.laser_end_ent linkTo(sniper.current_target, _id_027AB9C142F41152);
          sniper.laser_end_ent.is_linked_to_target = 1;
        }
      } else {
        sniper.laser_end_ent unlink();
        sniper.laser_end_ent.is_linked_to_target = 0;
        laser_end_pos = get_laser_end_pos(sniper.current_target, sniper.laser_start_ent);
        sniper.laser_end_ent moveTo(laser_end_pos, 0.25);
      }
    }

    wait 0.05;
  }
}

sniper_laser_think(sniper) {
  sniper endon("death");
  sniper notify("sniper_laser_think");
  sniper endon("sniper_laser_think");

  if(!isDefined(sniper.laser_start_ent)) {
    spawn_pos = sniper gettagorigin("tag_laser_attach");
    laser_start_ent = create_tag_origin(spawn_pos, sniper);
    laser_start_ent thread follow_tag_laser_attach(sniper, laser_start_ent);
    sniper.laser_start_ent = laser_start_ent;
  }

  if(!isDefined(sniper.laser_end_ent)) {
    spawn_pos = sniper gettagorigin("tag_laser_attach");
    laser_end_ent = create_tag_origin(spawn_pos, sniper);
    sniper.laser_end_ent = laser_end_ent;
  }

  sniper thread laser_vfx_think(sniper);

  for(;;) {
    if(has_current_target(sniper)) {
      if(player_is_exposed_to_sniper(sniper.current_target, sniper)) {
        try_shoot_at_current_target(sniper, sniper.laser_start_ent);

        if(!istrue(sniper.laser_end_ent.is_linked_to_target)) {
          _id_027AB9C142F41152 = get_target_tag_to_link_to(sniper.current_target, sniper);
          _id_1E3F1FBA50BA6DA1 = sniper.current_target gettagorigin(_id_027AB9C142F41152);
          sniper.laser_end_ent.origin = _id_1E3F1FBA50BA6DA1;
          sniper.laser_end_ent linkTo(sniper.current_target, _id_027AB9C142F41152);
          sniper.laser_end_ent.is_linked_to_target = 1;
        }
      } else {
        sniper.laser_end_ent unlink();
        sniper.laser_end_ent.is_linked_to_target = 0;
        laser_end_pos = get_laser_end_pos(sniper.current_target, sniper.laser_start_ent);
        sniper.laser_end_ent moveTo(laser_end_pos, 0.25);
      }
    }

    wait 0.05;
  }
}

laser_vfx_think(sniper) {
  sniper endon("death");
  sniper notify("laser_VFX_think");
  sniper endon("laser_VFX_think");
  turn_on_sniper_laser(sniper);

  for(;;) {
    if(!sniper_laser_is_on(sniper) && sniper_laser_should_turn_on(sniper))
      turn_on_sniper_laser(sniper);
    else if(sniper_laser_is_on(sniper) && !sniper_laser_should_turn_on(sniper))
      turn_off_sniper_laser(sniper);

    waitframe();
  }
}

turn_on_sniper_laser(sniper) {
  sniper_laser_vfx = playfxontagsbetweenclients(level._effect["sniper_red_laser_bright"], sniper.laser_start_ent, "tag_origin", sniper.laser_end_ent, "tag_origin");
  sniper.sniper_laser_vfx = sniper_laser_vfx;
}

turn_off_sniper_laser(sniper) {
  if(sniper_laser_is_on(sniper))
    sniper.sniper_laser_vfx delete();
}

sniper_laser_is_on(sniper) {
  return isDefined(sniper.sniper_laser_vfx);
}

sniper_laser_should_turn_on(sniper) {
  _id_847D0008C30D7EFF = 0.5;
  _id_BE40C12523194D34 = anglesToForward(sniper getplayerangles());
  _id_9634F27F4C1C2023 = vectorNormalize(sniper.laser_end_ent.origin - sniper.laser_start_ent.origin);
  _id_6BD958BBAA5FDFFE = vectordot(_id_9634F27F4C1C2023, _id_BE40C12523194D34);

  if(_id_6BD958BBAA5FDFFE < _id_847D0008C30D7EFF)
    return 0;

  _id_89162A7340BA32F3 = sniper getcurrentweapon();

  if(_id_89162A7340BA32F3.classname != "sniper")
    return 0;

  return 1;
}

get_target_tag_to_link_to(player, sniper) {
  if(is_player_part_exposed_to_sniper(player, sniper, "chest"))
    return "j_spineupper";
  else if(is_player_part_exposed_to_sniper(player, sniper, "eye"))
    return "tag_eye";
  else
    return "tag_origin";
}

follow_tag_laser_attach(sniper, laser_start_ent) {
  laser_start_ent endon("death");

  for(;;) {
    if(sniper tagexists("tag_laser_attach")) {
      _id_5638C3C19559C7F0 = sniper gettagorigin("tag_laser_attach");
      laser_start_ent.origin = _id_5638C3C19559C7F0;
    }

    waitframe();
  }
}

try_shoot_at_current_target(sniper, laser_start_ent) {
  player = sniper.current_target;

  if(!isDefined(player.time_stamp_can_be_damaged_by_sniper))
    player.time_stamp_can_be_damaged_by_sniper = 0;

  if(player_can_take_sniper_damage(player) && player_expose_to_sniper_long_enough(player, sniper)) {
    _id_C874F4FF3C8B2727 = player.origin - laser_start_ent.origin;
    playFX(level._effect["sniper_muzzle_flash"], laser_start_ent.origin, _id_C874F4FF3C8B2727);
    sniper playSound("sniper_impact_crack_highway");
    player playSound("sniper_impact_crack_highway");
    weapon = makeweapon("iw8_sn_alpha50_mp");
    _id_CAA0BC947A336661 = scripts\engine\utility::random(["j_head", "j_neck", "j_spineupper", "j_shoulder_ri", "j_shoulder_le"]);
    magicbullet(weapon, laser_start_ent.origin, player gettagorigin(_id_CAA0BC947A336661), sniper);
    guys = scripts\engine\utility::get_array_of_closest(player.origin, getaiarray("axis"), [sniper], undefined, 2500);

    foreach(guy in guys) {
      if(guy == sniper) {
        continue;
      }
      if(!guy[[guy.fnisinstealthcombat]]())
        guy aieventlistenerevent("gunshot", sniper, player.origin);
    }

    set_next_can_take_sniper_damage_time_stamp(player);
  }
}

player_can_take_sniper_damage(player) {
  current_time = gettime();
  return current_time > player.time_stamp_can_be_damaged_by_sniper;
}

set_next_can_take_sniper_damage_time_stamp(player) {
  current_time = gettime();
  player.time_stamp_can_be_damaged_by_sniper = current_time + randomfloatrange(2, 3) * 1000;
}

player_expose_to_sniper_long_enough(player, sniper) {
  return get_player_expose_time_to_sniper(player, sniper) >= 1;
}

mark_laser_end_ent(laser_end_ent) {
  laser_end_ent endon("death");

  for(;;)
    waitframe();
}

get_laser_end_pos(player, laser_start_ent) {
  _id_ABD758F8E0EC531D = 40;
  _id_D552D25C2A516D4A = 2;
  _id_A0613EA071DBFEFC = 40;
  _id_A6A586BB60189CA6 = 50;
  _id_5D567E2E0A477964 = 25;
  _id_BED3D02A059F155E = 35;
  _id_85C59891862F3573 = 10;
  _id_ED13C782F0D01DBB = 5;
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  end_pos = player getEye() + _id_70222FBC47330166 * _id_ABD758F8E0EC531D;
  end_pos = (end_pos[0] + randomfloatrange(_id_D552D25C2A516D4A * -1, _id_D552D25C2A516D4A), end_pos[1] + randomfloatrange(_id_D552D25C2A516D4A * -1, _id_D552D25C2A516D4A), end_pos[2]);
  end_pos = scripts\engine\utility::drop_to_ground(end_pos, 0, -500);
  _id_AA925129DED3BD11 = player getstance();

  switch (_id_AA925129DED3BD11) {
    case "stand":
      end_pos = (end_pos[0], end_pos[1], end_pos[2] + randomfloatrange(_id_A0613EA071DBFEFC, _id_A6A586BB60189CA6));
      break;
    case "prone":
    case "crouch":
      end_pos = (end_pos[0], end_pos[1], end_pos[2] + randomfloatrange(_id_5D567E2E0A477964, _id_BED3D02A059F155E));
      break;
  }

  _id_799F9BAA8717F283 = vectorNormalize(end_pos - laser_start_ent.origin);
  _id_F2C0CEDD1FFD7FA5 = laser_start_ent.origin + _id_799F9BAA8717F283 * 20000;
  contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
  end_pos = scripts\engine\trace::ray_trace(laser_start_ent.origin, _id_F2C0CEDD1FFD7FA5, undefined, contents);

  if(player_is_near_vehicle_to_push(player)) {
    if(player_is_facing_away_from_vehicle_to_push(player)) {
      _id_C9502AC20613171E = end_pos["position"] + (0, 0, 21);
      _id_E0D48F49E8898E42 = vectorNormalize(_id_C9502AC20613171E - laser_start_ent.origin);
      _id_D67BAC5307824983 = anglestoright(vectortoangles(_id_E0D48F49E8898E42));
      _id_C9502AC20613171E = _id_C9502AC20613171E + _id_D67BAC5307824983 * randomfloatrange(_id_85C59891862F3573 * -1, _id_85C59891862F3573);
      _id_E0D48F49E8898E42 = vectorNormalize(_id_C9502AC20613171E - laser_start_ent.origin);
      _id_F2C0CEDD1FFD7FA5 = laser_start_ent.origin + _id_E0D48F49E8898E42 * 20000;
      contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
      end_pos = scripts\engine\trace::ray_trace(laser_start_ent.origin, _id_F2C0CEDD1FFD7FA5, undefined, contents);
    } else if(player_is_facing_vehicle_to_push(player)) {
      _id_C9502AC20613171E = end_pos["position"] + (0, 0, 23);
      _id_E0D48F49E8898E42 = vectorNormalize(_id_C9502AC20613171E - laser_start_ent.origin);
      _id_D67BAC5307824983 = anglestoright(vectortoangles(_id_E0D48F49E8898E42));
      _id_C9502AC20613171E = _id_C9502AC20613171E + _id_D67BAC5307824983 * randomfloatrange(_id_ED13C782F0D01DBB * -1, _id_ED13C782F0D01DBB);
      _id_E0D48F49E8898E42 = vectorNormalize(_id_C9502AC20613171E - laser_start_ent.origin);
      _id_F2C0CEDD1FFD7FA5 = laser_start_ent.origin + _id_E0D48F49E8898E42 * 20000;
      contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
      end_pos = scripts\engine\trace::ray_trace(laser_start_ent.origin, _id_F2C0CEDD1FFD7FA5, undefined, contents);
    }
  }

  return end_pos["position"];
}

player_is_near_vehicle_to_push(player) {
  if(istrue(player.is_pushing_vehicle))
    return 1;

  if(!isDefined(level.vehicle_to_push))
    return 0;

  return distance2dsquared(player.origin, level.vehicle_to_push.origin) <= 40000;
}

player_is_facing_away_from_vehicle_to_push(player) {
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  _id_EEE689CD9A0FDC18 = anglesToForward(level.vehicle_to_push.angles);
  _id_4643A30CFBB982A6 = _id_EEE689CD9A0FDC18 * -1;
  _id_022E493B68AA12B6 = acos(vectordot(_id_70222FBC47330166, _id_4643A30CFBB982A6));
  return abs(_id_022E493B68AA12B6) < 75;
}

player_is_facing_vehicle_to_push(player) {
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  _id_EEE689CD9A0FDC18 = anglesToForward(level.vehicle_to_push.angles);
  _id_022E493B68AA12B6 = acos(vectordot(_id_70222FBC47330166, _id_EEE689CD9A0FDC18));
  return abs(_id_022E493B68AA12B6) < 80;
}

player_is_exposed_to_sniper(player, sniper) {
  _id_6698924DFF3AA2FC = player getentitynumber();
  return sniper.player_exposure_data[_id_6698924DFF3AA2FC].exposed_to_enemy_sniper_time > 0;
}

create_tag_origin(spawn_pos, sniper) {
  tag_origin = spawn("script_model", spawn_pos);
  tag_origin setModel("tag_origin");
  tag_origin thread clean_up_think(tag_origin, sniper);
  return tag_origin;
}

clean_up_think(tag_origin, sniper) {
  tag_origin endon("death");
  sniper waittill("death");
  tag_origin delete();
}

player_is_in_killzone(player) {
  _id_18FEC13F4763196B = getEnt("bridge_kill_zone", "targetname");

  if(isDefined(_id_18FEC13F4763196B)) {
    if(player istouching(_id_18FEC13F4763196B))
      return 1;
    else
      return 0;
  } else
    return 1;
}

_id_6C5A3DD9183FA65E(event) {
  if(!isDefined(level._id_72069798E35CC6BC[event.type]))
    level._id_72069798E35CC6BC[event.type] = 0;

  level._id_72069798E35CC6BC[event.type]++;

  if(isDefined(level._id_0DE285BCD7018AC7) && level._id_0DE285BCD7018AC7 == event.type) {
    return;
  }
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_a");

  if(_func_EAC0CD99C9C6D8EE() != "spotted") {
    return;
  }
  level._id_0DE285BCD7018AC7 = event.type;

  if(issubstr(event.type, "combat")) {
    if(isDefined(level._id_F81E56E009A2E2B2) && isarray(level._id_F81E56E009A2E2B2)) {
      foreach(sniper in level._id_F81E56E009A2E2B2) {
        sniper notify("force_clear_all_threads");
        sniper.gunposeoverride = "ads";
        sniper thread _id_AE11DCC86D260B7A(2.5);
      }
    }
  } else if(isDefined(level._id_F81E56E009A2E2B2) && isarray(level._id_F81E56E009A2E2B2)) {
    foreach(sniper in level._id_F81E56E009A2E2B2) {
      sniper notify("force_clear_all_threads");
      sniper thread _id_4C99439A8325BFD1();
    }
  }
}

_id_AE11DCC86D260B7A(delay) {
  self endon("death");
  self endon("force_clear_all_threads");
  wait(delay);
  player = level.players[0];

  for(;;) {
    player = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(player)) {
      waitframe();
      continue;
    }

    break;
  }

  player _id_B287795C124D321E(self);
}

_id_ED87C28AFFC92CCE() {
  self endon("force_clear_all_threads");
  self endon("death");
  self notify("return_to_search_if_no_player");
  self endon("return_to_search_if_no_player");
  self waittill("return_to_search");
  self notify("force_clear_all_threads");
  scripts\engine\utility::array_thread(level._id_828450D6FB8CAE84, _id_4B02400DAD63CAFB::_id_A08BB096BB00739A);
  thread _id_4C99439A8325BFD1();
}

_id_0C0B9633531D23BA() {
  self.scriptable = spawnscriptable("radioactive_object_interaction", self.origin + (0, 0, 8), self.angles);
  self.scriptable.parent = self;
}

_id_A6464C518CB4A509() {
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_40F7158BF8B473D2);
}

_id_40F7158BF8B473D2(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance)) {
    if(instance.type == "radioactive_object_interaction") {
      objectiveindex = instance.parent.objectiveindex;
      identifier = instance.parent.identifier;
      player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
      playsoundatpos(player.origin, "cp_hydro_rad_obj_pu");

      foreach(guy in level.players)
      guy thread scripts\cp\cp_hud_message::showsplash("cp_intel_mission_complete");

      if(getdvarint("dvar_3BD8C43F07F76C70", 0) != 0) {
        if(isDefined(level._id_F30F234DCD5FE40B)) {
          if(scripts\engine\utility::array_contains(level._id_F30F234DCD5FE40B, instance.parent))
            level._id_F30F234DCD5FE40B = scripts\engine\utility::array_remove(level._id_F30F234DCD5FE40B, instance.parent);

          thread scripts\cp\utility::objective_update("stealth_container", undefined, undefined, undefined, undefined, level._id_F30F234DCD5FE40B.size);
          _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(instance);

          if(istrue(player._id_9FC03D4C05F67987))
            level notify("radiation_objective_completed", "iskra", player);
          else
            level notify("radiation_objective_completed", "nikto", player);

          instance.parent scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

          if(level._id_F30F234DCD5FE40B.size == 0) {
            foreach(guy in level.players)
            guy notify("kill_nuke_thread");
          }
        }

        if(isDefined(player.windobject))
          player.windobject.state = "light";
      }

      instance.parent hide();

      if(isDefined(objectiveindex))
        objective_state(objectiveindex, "done");

      if(isDefined(instance.parent.objectiveindex))
        objective_state(instance.parent.objectiveindex, "done");

      scripts\cp\cp_objectives::freeworldid(identifier);
      _id_3858411D0B73D352::_id_E281027A9686A491("usb", instance.parent.script_noteworthy);
      level thread _id_613662165F17A93A::_id_7E77BB046BD77095();

      foreach(guy in level.players) {
        instance disablescriptableplayeruse(guy);
        guy setclientomnvar("ui_geigercounter_meter", 0);

        if(instance.parent.script_noteworthy == "a")
          guy _id_3858411D0B73D352::_id_3C26BBA307588EC3(2, 1);

        if(instance.parent.script_noteworthy == "b")
          guy _id_3858411D0B73D352::_id_3C26BBA307588EC3(4, 1);

        if(instance.parent.script_noteworthy == "c")
          guy _id_3858411D0B73D352::_id_3C26BBA307588EC3(8, 1);

        if(instance.parent.script_noteworthy == "barn") {
          guy _id_3858411D0B73D352::_id_3C26BBA307588EC3(2, 1);
          continue;
        }

        if(instance.parent.script_noteworthy == "town") {
          guy _id_3858411D0B73D352::_id_3C26BBA307588EC3(4, 1);
          continue;
        }
      }

      thread _id_3858411D0B73D352::_id_74EF78C75DC44055(instance.parent.script_noteworthy, player);
      instance.parent delete();
    }
  }
}

_id_C6477B99E150A457() {
  if(!istrue(level._id_C9FD08E82850DC3F)) {
    level._id_C9FD08E82850DC3F = 1;
    _id_62B762D8A739DE9E(1, 1);
    level._id_C9FD08E82850DC3F = undefined;
  }
}

_id_5E5D5AC433C8E1CA(name) {
  if(_id_C21568605A0EB71E(name)) {
    if(!scripts\engine\utility::array_contains(level.active_spawn_modules, name))
      _id_18A73A64992DD07D::run_spawn_module(name);
  }
}

_id_C21568605A0EB71E(group) {
  _id_7540B485C1A55040 = undefined;

  if(isarray(group))
    _id_7540B485C1A55040 = group;
  else
    _id_7540B485C1A55040 = [group];

  _id_D8C114EDA2DADB41 = [];

  foreach(group_name in _id_7540B485C1A55040) {
    _id_5571AE8A9C277A18 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name, 1)[0];

    if(isDefined(_id_5571AE8A9C277A18)) {
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_combine(_id_D8C114EDA2DADB41, _id_5571AE8A9C277A18.ai_spawned);
      _id_D8C114EDA2DADB41 = scripts\engine\utility::array_removedead_or_dying(_id_D8C114EDA2DADB41);
    }
  }

  if(_id_D8C114EDA2DADB41.size > 0)
    return 0;

  return 1;
}