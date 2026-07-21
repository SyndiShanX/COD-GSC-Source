/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\manager.gsc
***********************************************/

main() {
  if(isDefined(level.stealth)) {
    return;
  }
  init();

  if(scripts\common\utility::issp()) {
    level.player thread update_stealth_spotted_thread();
    level thread manager_thread();
    level thread teams_thread();
    level thread hunt_thread();

    if(getdvarint("_encstr_A38F1DA321187F3347E3EB505F11E7A5F64092C32226D0B4206F4FF59043D3"))
      stealth_suspicious_doors_init();
  } else
    level thread teams_thread();
}

init() {
  scripts\engine\utility::flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  level.stealth = spawnStruct();
  level.stealth.detect = spawnStruct();
  level.stealth.save = spawnStruct();
  level.stealth.ai_event = [];
  level.stealth.funcs = [];
  level.stealth.detect.state = "_encstr_95DF070DD22319CA9B";
  level.stealth.detect.range = [];
  level.stealth.detect.range["_encstr_95DF070DD22319CA9B"] = [];
  level.stealth.detect.range["_encstr_8ADA089BC1B78EE8B246"] = [];
  level.stealth.detect.minrangedarkness["_encstr_95DF070DD22319CA9B"] = [];
  level.stealth.detect.minrangedarkness["_encstr_8ADA089BC1B78EE8B246"] = [];
  level.stealth.detect.timeout = 5;
  scripts\stealth\corpse::corpse_init_level();
  scripts\stealth\event::event_init_level();
  level.stealth.next_sound_wait = 3000;
  level.stealth.head_shot_dist = 8;
  level.stealth.group = spawnStruct();
  level.stealth.group.flags = [];
  level.stealth.group.groups = [];
  level.stealth.group.ally_groups = [];
  level.stealth.group.death_alert_timeout = [];
  level.stealth.hunting_groups = [];
  set_default_settings();
  init_stealth_volumes();
  scripts\stealth\clear_regions::init_hunt_regions();
  init_save();
  scripts\stealth\utility::alertlevel_init_map();
  level.stealth.min_alert_level_duration = 1;
  setup_stealth_funcs();
}

setup_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("_encstr_85EB0B1CA781A25335A152DBA8", scripts\stealth\utility::do_stealth);
  scripts\stealth\enemy::set_default_stealth_funcs();
  level.stealth.fngroupspottedflag = scripts\stealth\utility::group_spotted_flag;
  level.stealth.fninitenemygame = undefined;
  level.stealth.fnsetdisguised = scripts\stealth\utility::set_disguised_default;
}

set_default_settings() {
  var_0 = [];
  var_0["_encstr_922406F1A6FD5E05"] = 400;
  var_0["_encstr_B13D076BED70539F23"] = 800;
  var_0["_encstr_A5AD069B231F0BAF"] = 1500;
  var_1 = [];
  var_1["_encstr_922406F1A6FD5E05"] = 800;
  var_1["_encstr_B13D076BED70539F23"] = 1500;
  var_1["_encstr_A5AD069B231F0BAF"] = 3000;
  scripts\stealth\utility::set_detect_ranges(var_0, var_1);
  var_2 = [];
  var_2["_encstr_922406F1A6FD5E05"] = 130;
  var_2["_encstr_B13D076BED70539F23"] = 215;
  var_2["_encstr_A5AD069B231F0BAF"] = 300;
  var_3 = [];
  var_3["_encstr_922406F1A6FD5E05"] = 300;
  var_3["_encstr_B13D076BED70539F23"] = 375;
  var_3["_encstr_A5AD069B231F0BAF"] = 450;
  scripts\stealth\utility::set_min_detect_range_darkness(var_2, var_3);
  scripts\stealth\corpse::set_corpse_ranges_default();
  init_event_distances();
  scripts\stealth\utility::set_disguised(0);
  event_change("_encstr_95DF070DD22319CA9B");
}

init_event_distances() {
  var_0["_encstr_8D7F12E952BF0D08EFDE4129F1522055FF4AC330"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_8D7F12E952BF0D08EFDE4129F1522055FF4AC330");
  var_0["_encstr_8D7F12E952BF0D08EFDE4129F1522055FF4AC330"]["_encstr_95DF070DD22319CA9B"] = 512;
  var_0["_encstr_96231126CB3FD2FE21E04BB3E0DBB4C91B536D"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_96231126CB3FD2FE21E04BB3E0DBB4C91B536D");
  var_0["_encstr_96231126CB3FD2FE21E04BB3E0DBB4C91B536D"]["_encstr_95DF070DD22319CA9B"] = 256;
  var_0["_encstr_83C0162C4BFA2BCEAC733A88966EA315F00E1BB7B92DBDB9"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_83C0162C4BFA2BCEAC733A88966EA315F00E1BB7B92DBDB9");
  var_0["_encstr_83C0162C4BFA2BCEAC733A88966EA315F00E1BB7B92DBDB9"]["_encstr_95DF070DD22319CA9B"] = 2048;
  var_0["_encstr_A16F1341ABF68F8BDB7843B8B80FC3DB6B81C4FDBD"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_A16F1341ABF68F8BDB7843B8B80FC3DB6B81C4FDBD");
  var_0["_encstr_A16F1341ABF68F8BDB7843B8B80FC3DB6B81C4FDBD"]["_encstr_95DF070DD22319CA9B"] = 64;
  var_0["_encstr_966619F184BFC8DCBA4B1189AF232519579DDB0B6BED1804D26B27"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_966619F184BFC8DCBA4B1189AF232519579DDB0B6BED1804D26B27");
  var_0["_encstr_966619F184BFC8DCBA4B1189AF232519579DDB0B6BED1804D26B27"]["_encstr_95DF070DD22319CA9B"] = 50;
  var_0["_encstr_ABC015C2967D2B9D59DC3A222DE6D191F67B47B93AAC0E"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_ABC015C2967D2B9D59DC3A222DE6D191F67B47B93AAC0E");
  var_0["_encstr_ABC015C2967D2B9D59DC3A222DE6D191F67B47B93AAC0E"]["_encstr_95DF070DD22319CA9B"] = 100;
  var_0["_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888");
  var_0["_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888"]["_encstr_95DF070DD22319CA9B"] = 400;
  var_0["_encstr_8B4C142CB4F5AC6759E6D111969B4774D5E6A9A1EDD1"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_8B4C142CB4F5AC6759E6D111969B4774D5E6A9A1EDD1");
  var_0["_encstr_8B4C142CB4F5AC6759E6D111969B4774D5E6A9A1EDD1"]["_encstr_95DF070DD22319CA9B"] = 1500;
  var_0["_encstr_A5761971289F074C131554F1634083071781670D76E2626770882B"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_A5761971289F074C131554F1634083071781670D76E2626770882B");
  var_0["_encstr_A5761971289F074C131554F1634083071781670D76E2626770882B"]["_encstr_95DF070DD22319CA9B"] = 180;
  var_0["_encstr_92681B6F27989783B7D823C5C3FF7177C0930BF6DC0D280BC6FFBA1F30"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_92681B6F27989783B7D823C5C3FF7177C0930BF6DC0D280BC6FFBA1F30");
  var_0["_encstr_92681B6F27989783B7D823C5C3FF7177C0930BF6DC0D280BC6FFBA1F30"]["_encstr_95DF070DD22319CA9B"] = 384;

  if(getdvarint("_encstr_97980BDF5D90E77BF1E0A25A6B", 0)) {
    var_0["_encstr_AD9018772340BA9EC810CBDFE820C4D02D5537CB877D71450B58"]["_encstr_8ADA089BC1B78EE8B246"] = 256;
    var_0["_encstr_AD9018772340BA9EC810CBDFE820C4D02D5537CB877D71450B58"]["_encstr_95DF070DD22319CA9B"] = 256;
  } else {
    var_0["_encstr_AD9018772340BA9EC810CBDFE820C4D02D5537CB877D71450B58"]["_encstr_8ADA089BC1B78EE8B246"] = getdvarint("_encstr_AD9018772340BA9EC810CBDFE820C4D02D5537CB877D71450B58");
    var_0["_encstr_AD9018772340BA9EC810CBDFE820C4D02D5537CB877D71450B58"]["_encstr_95DF070DD22319CA9B"] = 750;
  }

  var_0["_encstr_97651519AB81275B3540D3D888166B55F80FB56EDB4868"]["_encstr_8ADA089BC1B78EE8B246"] = 128;
  var_0["_encstr_97651519AB81275B3540D3D888166B55F80FB56EDB4868"]["_encstr_95DF070DD22319CA9B"] = 128;
  set_event_distances(var_0);
}

set_event_distances(var_0) {
  foreach(var_6, var_2 in var_0) {
    foreach(var_5, var_4 in var_2)
    level.stealth.ai_event[var_6][var_5] = var_4;
  }
}

set_custom_distances(var_0) {
  foreach(var_7, var_2 in var_0) {
    foreach(var_6, var_4 in var_2) {
      level.stealth.ai_event[var_7][var_6] = var_4;

      if(level.stealth.detect.state == var_6) {
        setsaveddvar(var_7, var_4);
        var_5 = "_encstr_86420D85A5D7C4ABB9CBA2B3B2371D" + getsubstr(var_7, 8);
        setsaveddvar(var_5, var_4);
      }
    }
  }
}

set_detect_ranges_internal(var_0, var_1) {
  var_2 = 0.25;

  if(isDefined(var_0)) {
    level.stealth.detect.range["_encstr_95DF070DD22319CA9B"]["_encstr_922406F1A6FD5E05"] = var_0["_encstr_922406F1A6FD5E05"];
    level.stealth.detect.range["_encstr_95DF070DD22319CA9B"]["_encstr_B13D076BED70539F23"] = var_0["_encstr_B13D076BED70539F23"];
    level.stealth.detect.range["_encstr_95DF070DD22319CA9B"]["_encstr_A5AD069B231F0BAF"] = var_0["_encstr_A5AD069B231F0BAF"];

    if(!isDefined(var_0["_encstr_9B6E07DC34168CF6BB"]))
      var_0["_encstr_9B6E07DC34168CF6BB"] = var_2;

    level.stealth.detect.range["_encstr_95DF070DD22319CA9B"]["_encstr_9B6E07DC34168CF6BB"] = var_0["_encstr_9B6E07DC34168CF6BB"];
  }

  if(isDefined(var_1)) {
    level.stealth.detect.range["_encstr_8ADA089BC1B78EE8B246"]["_encstr_922406F1A6FD5E05"] = var_1["_encstr_922406F1A6FD5E05"];
    level.stealth.detect.range["_encstr_8ADA089BC1B78EE8B246"]["_encstr_B13D076BED70539F23"] = var_1["_encstr_B13D076BED70539F23"];
    level.stealth.detect.range["_encstr_8ADA089BC1B78EE8B246"]["_encstr_A5AD069B231F0BAF"] = var_1["_encstr_A5AD069B231F0BAF"];

    if(!isDefined(var_1["_encstr_9B6E07DC34168CF6BB"]))
      var_1["_encstr_9B6E07DC34168CF6BB"] = var_2;

    level.stealth.detect.range["_encstr_8ADA089BC1B78EE8B246"]["_encstr_9B6E07DC34168CF6BB"] = var_1["_encstr_9B6E07DC34168CF6BB"];
  }
}

manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    scripts\stealth\threat_sight::threat_sight_set_dvar(1);

    if(!playerlootenabled())
      setsaveddvar("_encstr_97C60B1CE2EBC91630874B79DB", 1);

    scripts\engine\utility::flag_wait("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!playerlootenabled())
      setsaveddvar("_encstr_97C60B1CE2EBC91630874B79DB", 0);

    if(!scripts\engine\utility::flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    event_change("_encstr_8ADA089BC1B78EE8B246");
    scripts\engine\utility::flag_waitopen("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!scripts\engine\utility::flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    event_change("_encstr_95DF070DD22319CA9B");
    waittillframeend;
  }
}

anyone_in_combat() {
  if(isDefined(level.stealth.groupdata)) {
    foreach(var_1 in level.stealth.groupdata.groups) {
      if(scripts\stealth\group::group_anyoneincombat(var_1.name))
        return 1;
    }
  }

  var_3 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.stealth) && isDefined(var_5.enemy) && var_5.enemy == self)
      return 1;
  }

  return 0;
}

update_stealth_spotted_thread() {
  waitframe();
  var_0 = 0;

  for(;;) {
    var_1 = anyone_in_combat();

    if(var_1) {
      if(!var_0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait(level.stealth.stealth_spotted_delay);

        if(!anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8")) {
        scripts\engine\utility::flag_set("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

        if(isDefined(self.stealth)) {
          var_2 = scripts\stealth\utility::get_group_flagname("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
          scripts\engine\utility::flag_set(var_2);
        }
      }
    } else if(scripts\engine\utility::flag("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8")) {
      scripts\engine\utility::flag_clear("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

      if(isDefined(self.stealth)) {
        var_2 = scripts\stealth\utility::get_group_flagname("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
        scripts\engine\utility::flag_clear(var_2);
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

teams_thread() {
  level.stealth.enemies["_encstr_8E8405EA382B2A"] = [];
  level.stealth.enemies["_encstr_9A8507BA4040188D08"] = [];

  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    level.stealth.enemies["_encstr_8E8405EA382B2A"] = level.players;
    level.stealth.enemies["_encstr_9A8507BA4040188D08"] = getaiarray("_encstr_8E8405EA382B2A");
    wait 0.05;
  }
}

hunt_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");

    if(isDefined(level.stealth.hunt_stealth_group_region_sets) && level.stealth.hunt_stealth_group_region_sets.size != 0) {
      foreach(var_2, var_1 in level.stealth.hunt_stealth_group_region_sets) {
        scripts\stealth\clear_regions::huntcomputeaiindependentregionscores(var_2, var_1);
        wait 0.2;
      }

      continue;
    }

    wait 0.5;
  }
}

event_change(var_0) {
  level.stealth.detect.state = var_0;

  foreach(var_4, var_2 in level.stealth.ai_event) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = "_encstr_86420D85A5D7C4ABB9CBA2B3B2371D" + getsubstr(var_4, 8);
    setsaveddvar(var_3, var_2[var_0]);
  }
}

init_save() {
  scripts\engine\utility::flag_init("_encstr_88371473DB68097071035138F12AFA8780B1C6C7998A");
  level.stealth.save.player_nades = 0;
  scripts\engine\utility::array_thread(level.players, ::player_grenade_check);
}

player_grenade_check() {
  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6");
    scripts\engine\utility::flag_set("_encstr_88371473DB68097071035138F12AFA8780B1C6C7998A");
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0);
    thread player_grenade_check_dieout(var_0);
  }
}

player_grenade_check_dieout(var_0) {
  level.stealth.save.player_nades++;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 10);
  level.stealth.save.player_nades--;
  waittillframeend;

  if(!level.stealth.save.player_nades)
    scripts\engine\utility::flag_clear("_encstr_88371473DB68097071035138F12AFA8780B1C6C7998A");
}

stealth_suspicious_doors_init() {
  if(istrue(level.ship_assault)) {
    return;
  }
  if(isDefined(level.stealth)) {
    if(!isDefined(level.stealth.suspicious_door)) {
      level.stealth.suspicious_door = spawnStruct();
      level.stealth.suspicious_door.doors = [];
      level.stealth.suspicious_door.reset_time = 30;
      level.stealth.suspicious_door.sight_distsqrd = squared(600);
      level.stealth.suspicious_door.detect_distsqrd = squared(500);
      level.stealth.suspicious_door.found_distsqrd = squared(300);
    }

    level scripts\stealth\utility::set_stealth_func("_encstr_85511026C3AB79B8F32FF8D0BF37D18FB2AA", scripts\stealth\corpse::suspicious_door_found);
    level scripts\stealth\event::event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_85511026C3AB79B8F32FF8D0BF37D18FB2AA", 20);
  }
}

init_stealth_volumes() {
  level.stealth.combat_volumes = [];
  level.stealth.hunt_volumes = [];
  level.stealth.investigate_volumes = [];
  var_0 = getEntArray("_encstr_97A4189637667BFAD9F68DBAB695FAE63A56851B1D347DC26363", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = getEntArray("_encstr_85ED1B11A548A5FFBC6052CB081DC71A702B916CF960E1C7E8D8AAB233", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, "_encstr_974C0246");

      foreach(var_6 in var_4)
      level.stealth.combat_volumes[var_6] = var_3;
    }
  }

  var_1 = getEntArray("_encstr_AFD019B4DC99DEF5D9ED1BD5B6CAF59B3A9516C68E0D7DD0AECD47", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, "_encstr_974C0246");

      foreach(var_6 in var_4)
      level.stealth.hunt_volumes[var_6] = var_3;
    }
  }

  var_1 = getEntArray("_encstr_A217206238C44729B0D77C6DFB2BE18F75F17ABA03ABCF9CA81D6D53D118B70F9D69", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, "_encstr_974C0246");

      foreach(var_6 in var_4)
      level.stealth.investigate_volumes[var_6] = var_3;
    }
  }
}

playerlootenabled() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnplayerlootenabled))
    return [[level.stealth.fnplayerlootenabled]]();

  return 0;
}