/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\manager.gsc
***********************************************/

function main() {
  if(isDefined(level.stealth)) {
    return;
  }

  init();

  if(scripts\common\utility::issp()) {
    thread update_stealth_spotted_thread();
    thread manager_thread();
    thread teams_thread();
    thread hunt_thread();

    if(getdvarint("scr_suspicious_stealth_doors")) {
      stealth_suspicious_doors_init();
      return;
    }

    return;
  }

  thread teams_thread();
}

function init() {
  scripts\engine\utility::flag_set("stealth_enabled");
  level.stealth = spawnStruct();
  level.stealth.detect = spawnStruct();
  level.stealth.save = spawnStruct();
  level.stealth.ai_event = [];
  level.stealth.funcs = [];
  level.stealth.detect.state = "hidden";
  level.stealth.detect.range = [];
  level.stealth.detect.range["hidden"] = [];
  level.stealth.detect.range["spotted"] = [];
  level.stealth.detect.minrangedarkness["hidden"] = [];
  level.stealth.detect.minrangedarkness["spotted"] = [];
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

function setup_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("do_stealth", &scripts\stealth\utility::do_stealth);
  scripts\stealth\enemy::set_default_stealth_funcs();
  level.stealth.fngroupspottedflag = &scripts\stealth\utility::group_spotted_flag;
  level.stealth.fninitenemygame = undefined;
  level.stealth.fnsetdisguised = &scripts\stealth\utility::set_disguised_default;
}

function set_default_settings() {
  var_0 = [];
  GscBinSkip0(0x2e, "prone", 400);
}

function init_event_distances() {
  GscBinSkip1(0x45, "ai_eventDistDeath", "spotted", getdvarint("ai_eventDistDeath"));
}

function set_event_distances(var_0) {
  foreach(var_2 in var_0) {
    foreach(var_4 in var_2) {
      level.stealth.ai_event[var_6][var_5] = var_4;
    }
  }
}

function set_custom_distances(var_0) {
  foreach(var_7, var_2 in var_0) {
    foreach(var_6, var_4 in var_2) {
      level.stealth.ai_event[var_7][var_6] = var_4;

      if(level.stealth.detect.state == var_6) {
        setsaveddvar(var_7, var_4);
        var_5 = "ai_busyEvent" + getsubstr(var_7, 8);
        setsaveddvar(var_5, var_4);
      }
    }
  }
}

function set_detect_ranges_internal(var_0, var_1) {
  var_2 = 0.25;

  if(isDefined(var_0)) {
    level.stealth.detect.range["hidden"]["prone"] = var_0["prone"];
    level.stealth.detect.range["hidden"]["crouch"] = var_0["crouch"];
    level.stealth.detect.range["hidden"]["stand"] = var_0["stand"];

    if(!isDefined(var_0["shadow"])) {
      var_0 = var_2;
    }

    level.stealth.detect.range["hidden"]["shadow"] = var_0["shadow"];
  }

  if(isDefined(var_1)) {
    level.stealth.detect.range["spotted"]["prone"] = var_1["prone"];
    level.stealth.detect.range["spotted"]["crouch"] = var_1["crouch"];
    level.stealth.detect.range["spotted"]["stand"] = var_1["stand"];

    if(!isDefined(var_1["shadow"])) {
      var_1 = var_2;
    }

    level.stealth.detect.range["spotted"]["shadow"] = var_1["shadow"];
    return;
  }
}

function manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\stealth\threat_sight::threat_sight_set_dvar(1);

    if(!playerlootenabled()) {
      setsaveddvar("ai_corpseSynch", 1);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");

    if(!playerlootenabled()) {
      setsaveddvar("ai_corpseSynch", 0);
    }

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    event_change("spotted");
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    event_change("hidden");
    waittillframeend();
  }
}

function anyone_in_combat() {
  if(isDefined(level.stealth.groupdata)) {
    foreach(var_1 in level.stealth.groupdata.groups) {
      if(scripts\stealth\group::group_anyoneincombat(var_1.name)) {
        return true;
      }
    }
  }

  var_3 = getaiunittypearray("bad_guys", "all");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.stealth) && isDefined(var_5.enemy) && var_5.enemy == self) {
      return true;
    }
  }

  return false;
}

function update_stealth_spotted_thread() {
  waitframe();
  var_0 = 0;

  for(;;) {
    var_1 = anyone_in_combat();

    if(var_1) {
      if(!var_0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait level.stealth.stealth_spotted_delay;

        if(!anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        if(isDefined(self.stealth)) {
          var_2 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_set(var_2);
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      if(isDefined(self.stealth)) {
        var_2 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
        scripts\engine\utility::flag_clear(var_2);
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

function teams_thread() {
  level.stealth.enemies["axis"] = [];
  level.stealth.enemies["allies"] = [];

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    level.stealth.enemies["axis"] = level.players;
    level.stealth.enemies["allies"] = getaiarray("axis");
    wait 0.05;
  }
}

function hunt_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");

    if(isDefined(level.stealth.hunt_stealth_group_region_sets) && level.stealth.hunt_stealth_group_region_sets.size != 0) {
      foreach(var_1 in level.stealth.hunt_stealth_group_region_sets) {
        scripts\stealth\clear_regions::huntcomputeaiindependentregionscores(var_2, var_1);
        wait 0.2;
      }

      continue;
    }

    wait 0.5;
  }
}

function event_change(var_0) {
  level.stealth.detect.state = var_0;

  foreach(var_2 in level.stealth.ai_event) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = "ai_busyEvent" + getsubstr(var_4, 8);
    setsaveddvar(var_3, var_2[var_0]);
  }
}

function init_save() {
  scripts\engine\utility::flag_init("stealth_player_nade");
  level.stealth.save.player_nades = 0;
  scripts\engine\utility::array_thread(level.players, &player_grenade_check);
}

function player_grenade_check() {
  for(;;) {
    self waittill("grenade_pullback");
    scripts\engine\utility::flag_set("stealth_player_nade");
    self waittill("grenade_fire", var_0);
    thread player_grenade_check_dieout(var_0);
  }
}

function player_grenade_check_dieout(var_0) {
  level.stealth.save.player_nades++;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.stealth.save.player_nades--;
  waittillframeend();

  if(!level.stealth.save.player_nades) {
    scripts\engine\utility::flag_clear("stealth_player_nade");
    return;
  }
}

function stealth_suspicious_doors_init() {
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

    level scripts\stealth\utility::set_stealth_func("suspicious_door", &scripts\stealth\corpse::suspicious_door_found);
    level scripts\stealth\event::event_severity_set("investigate", "suspicious_door", 20);
    return;
  }
}

function init_stealth_volumes() {
  level.stealth.combat_volumes = [];
  level.stealth.hunt_volumes = [];
  level.stealth.investigate_volumes = [];
  var_0 = getEntArray("info_volume_stealth_all", "classname");
  var_1 = getEntArray("info_volume_stealth_combat", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, " ");

      foreach(var_6 in var_4) {
        level.stealth.combat_volumes[var_6] = var_3;
      }
    }
  }

  var_1 = getEntArray("info_volume_stealth_hunt", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, " ");

      foreach(var_6 in var_4) {
        level.stealth.hunt_volumes[var_6] = var_3;
      }
    }
  }

  var_1 = getEntArray("info_volume_stealth_investigate", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3.script_stealthgroup, " ");

      foreach(var_6 in var_4) {
        level.stealth.investigate_volumes[var_6] = var_3;
      }
    }

    return;
  }
}

function playerlootenabled() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnplayerlootenabled)) {
    return [[level.stealth.fnplayerlootenabled]]();
  }

  return 0;
}