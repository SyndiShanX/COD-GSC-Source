/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\nuke_cp.gsc
***********************************************/

init_script_triggers() {
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "_encstr_AC110A7F14873B5B3D073009");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B", "_encstr_AC110A7F14873B5B3D073009");
  var_7 = getEntArray("_encstr_956B0F193B6244C0659AE65B464C78857B", "_encstr_AC110A7F14873B5B3D073009");
  var_4 = scripts\cp\utility::array_merge(var_6, var_7);
  var_8 = getEntArray("_encstr_A2990D2BD8035F3AFF63F1CAFAABC7", "_encstr_AC110A7F14873B5B3D073009");
  var_4 = scripts\cp\utility::array_merge(var_4, var_8);
  var_9 = getEntArray("_encstr_B1F70D1B2D73B2A790FB797D5088ED", "_encstr_AC110A7F14873B5B3D073009");
  var_4 = scripts\cp\utility::array_merge(var_4, var_9);

  foreach(var_11 in var_4) {
    if(var_11.spawnflags & 32)
      thread trigger_spawner(var_4);
  }

  var_13 = ["_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B", "_encstr_B1F70D1B2D73B2A790FB797D5088ED", "_encstr_AFF60C939B634707C80DAF8DE720", "_encstr_956B0F193B6244C0659AE65B464C78857B", "_encstr_B4E70FD303A4CF8F19BB6FA985B0AFB6DB", "_encstr_A2990D2BD8035F3AFF63F1CAFAABC7", "_encstr_A68E0FE89CB4ECCEACE4EB190BB52CB3B2", "_encstr_85FE0DD5727A27098513298817CA23"];

  foreach(var_15 in var_13) {
    var_4 = getEntArray(var_15, "_encstr_956D0F572FD22561C3BD81DB62A6D869BA");

    foreach(var_11 in var_4) {
      if(isDefined(var_11.script_exploder))
        level thread exploder_load(var_11);

      if(isDefined(var_11.targetname)) {
        var_17 = var_11.targetname;

        if(isDefined(var_1[var_17]))
          level thread[[var_1[var_17]]](var_11);
      }
    }
  }
}

get_load_trigger_classes() {
  var_0 = [];
  var_0["_encstr_A17F1AAC0D6227911B6037C2ED18ABAC10B11727B119E83F31BBEF23"] = ::trigger_flag_set;
  var_0["_encstr_AC4E189B936B7F3FC015A772CB3044FF8EAE32A25934E772E831"] = ::trigger_flag_set;
  var_0["_encstr_B12B1C189BE40F295FA278699D4373DB0AE218B9327DBB61DFDBF95561D3"] = ::trigger_flag_clear;
  var_0["_encstr_BEC11A403A346FE7B7F36942D8E1D3F3122EE75860D7DF8A3151EA80"] = ::trigger_flag_clear;
  var_0["_encstr_85E11547392DEC3B599C7DEACD59F533C6859DD79BB2E8"] = ::trigger_flag_set;
  var_0["_encstr_BD8917D19CD2EC76B293AFAB6E59BECC36B0D9FA8D1BAC0BE4"] = ::trigger_flag_clear;
  var_0["_encstr_8C5D233AE4D2B3D9AC9CD7D6BA63A3B4C136AC7D99B12CB37DB9958ED73AB7BA6C34969BEC"] = ::trigger_flag_set_touching;
  var_0["_encstr_85FE0DD5727A27098513298817CA23"] = ::_id_13DA6;
  return var_0;
}

get_load_trigger_funcs() {
  var_0 = [];
  var_0["_encstr_B26A10A36EF0EF9927329FCFA9010F50E1D0"] = ::trigger_spawner;
  var_0["_encstr_857C0EFB6388072ACFCE62DE3445F2C2"] = ::flood_trigger_think;
  var_0["_encstr_924E1DE82796D9EC95C9EB6756864B8DD8B2BE37C11B4BE6CAAFB9C10BEEB9"] = ::trigger_vehicle_spline_spawn;
  var_0["_encstr_8173165310A8EFFA5BAE493B1D6952B350C087C7980137B2"] = ::trigger_spawner;
  var_0["_encstr_97690B620FDBC9D7B27370386A"] = ::trigger_zone_spawn;
  var_0["_encstr_ADDC0995340E68E08712B3"] = ::trigger_flag_set;
  var_0["_encstr_B8B20B07A191CF89FBEEE352A9"] = ::trigger_flag_clear;
  var_0["_encstr_B26E0B1F0888E789C6A9FFE7BD"] = ::trigger_flag_clear;
  return var_0;
}

trigger_script_flag_false(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

trigger_script_flag_true(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

add_tokens_to_trigger_flags(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2]))
      level.trigger_flags[var_2] = [];

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

exploder_load(var_0) {
  level endon("_encstr_A52E1530D025BD154BEF787201EFEBED9DC0687C2B5372" + var_0.script_exploder);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isDefined(var_0.script_delay))
      wait(var_0.script_delay);
    else
      wait 4;

    level thread exploder_load(var_0);
    return;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("_encstr_A52E1530D025BD154BEF787201EFEBED9DC0687C2B5372" + var_0.script_exploder);
}

get_trigger_flag() {
  if(isDefined(self.script_flag))
    return self.script_flag;

  if(isDefined(self.script_noteworthy))
    return self.script_noteworthy;
}

trigger_flag_set(var_0) {
  var_1 = var_0 get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(var_0 getdropposition()) {
      var_0 scripts\engine\utility::script_delay();
      scripts\engine\utility::flag_set(var_1, var_2);

      if(!isDefined(var_0)) {
        break;
      }
    }
  }
}

getdropposition() {
  if(turret_has_target(self))
    return 1;

  if(self.spawnflags & 2) {
    var_0 = getaiarray("_encstr_8E8405EA382B2A");

    foreach(var_2 in var_0) {
      if(var_2 istouching(self))
        return 1;
    }
  }

  if(self.spawnflags & 4) {
    var_4 = getaiarray("_encstr_9A8507BA4040188D08");

    foreach(var_2 in var_4) {
      if(var_2 istouching(self))
        return 1;
    }
  }

  return 0;
}

trigger_flag_clear(var_0) {
  var_1 = var_0 get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

trigger_flag_set_touching(var_0) {
  var_1 = var_0 get_trigger_flag();

  if(!isDefined(level.flag[var_1]))
    scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0) && turret_has_target(var_0))
      scripts\engine\utility::flag_set(var_1);

    while(isDefined(var_0) && turret_has_target(var_0))
      wait 0.25;

    scripts\engine\utility::flag_clear(var_1);

    if(!isDefined(var_0)) {
      break;
    }
  }
}

turret_has_target(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

trigger_spawner(var_0) {
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 = var_0.target;
  var_0 scripts\engine\utility::script_delay();
  var_2 = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray(var_1, "_encstr_A6BF0ACD937E40A2F3F2275F"), getEntArray(var_1));

  foreach(var_4 in var_2) {
    if(isstruct(var_4)) {
      var_4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
      continue;
    }

    if(var_4.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      if(isDefined(var_4.script_moveoverride) && var_4.script_moveoverride == 1 || !isDefined(var_4.target)) {
        thread scripts\common\vehicle::vehicle_spawn(var_4);
        continue;
      }

      var_4 thread scripts\common\vehicle::spawn_vehicle_and_gopath();
    }
  }
}

flood_trigger_think(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_1, ::flood_spawner_init);
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_1, ::flood_spawner_think, var_0);
}

flood_spawner_init() {}

flood_spawner_think(var_0) {
  self notify("_encstr_8E501AB385507BBE77AB83BBB85563F2A9612757157BC3B637B0FAB3");
  self endon("_encstr_8E501AB385507BBE77AB83BBB85563F2A9612757157BC3B637B0FAB3");
  scripts\engine\utility::script_delay();

  while(self.count > 0) {
    var_1 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(!isDefined(var_1)) {
      wait 2;
      continue;
    }

    var_1 waittill("_encstr_AD75063D571AE108", var_2);

    if(!scripts\engine\utility::script_wait())
      wait(randomfloatrange(2, 5));
  }
}

trigger_zone_spawn(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_0 scripts\engine\utility::script_delay();
    var_2 = scripts\engine\utility::getStructArray(var_0.target);

    foreach(var_4 in var_2)
    var_4 thread scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    while(turret_has_target(var_0))
      wait 0.1;
  }
}

trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

_id_13DA6(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1) || isagent(var_1))
      var_1 kill();
  }
}