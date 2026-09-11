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
  var0 = [];
  GscBinSkip0(0x2e, "prone", 400);
}

function init_event_distances() {
  GscBinSkip1(0x45, "ai_eventDistDeath", "spotted", getdvarint("ai_eventDistDeath"));
}

function set_event_distances(var0) {
  foreach(var2 in var0) {
    foreach(var4 in var2) {
      level.stealth.ai_event[var6][var5] = var4;
    }
  }
}

function set_custom_distances(var0) {
  foreach(var7, var2 in var0) {
    foreach(var6, var4 in var2) {
      level.stealth.ai_event[var7][var6] = var4;

      if(level.stealth.detect.state == var6) {
        setsaveddvar(var7, var4);
        var5 = "ai_busyEvent" + getsubstr(var7, 8);
        setsaveddvar(var5, var4);
      }
    }
  }
}

function set_detect_ranges_internal(var0, var1) {
  var2 = 0.25;

  if(isDefined(var0)) {
    level.stealth.detect.range["hidden"]["prone"] = var0["prone"];
    level.stealth.detect.range["hidden"]["crouch"] = var0["crouch"];
    level.stealth.detect.range["hidden"]["stand"] = var0["stand"];

    if(!isDefined(var0["shadow"])) {
      var0 = var2;
    }

    level.stealth.detect.range["hidden"]["shadow"] = var0["shadow"];
  }

  if(isDefined(var1)) {
    level.stealth.detect.range["spotted"]["prone"] = var1["prone"];
    level.stealth.detect.range["spotted"]["crouch"] = var1["crouch"];
    level.stealth.detect.range["spotted"]["stand"] = var1["stand"];

    if(!isDefined(var1["shadow"])) {
      var1 = var2;
    }

    level.stealth.detect.range["spotted"]["shadow"] = var1["shadow"];
    return;
  }
}

function manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\stealth\threat_sight::threat_sight_set_dvar(1);

    if(!playerlootenabled()) {
      setsaveddvar("MQSNSOSMPN", 1);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");

    if(!playerlootenabled()) {
      setsaveddvar("MQSNSOSMPN", 0);
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
    foreach(var1 in level.stealth.groupdata.groups) {
      if(scripts\stealth\group::group_anyoneincombat(var1.name)) {
        return true;
      }
    }
  }

  var3 = getaiunittypearray("bad_guys", "all");

  foreach(var5 in var3) {
    if(!isDefined(var5.stealth) && isDefined(var5.enemy) && var5.enemy == self) {
      return true;
    }
  }

  return false;
}

function update_stealth_spotted_thread() {
  waitframe();
  var0 = 0;

  for(;;) {
    var1 = anyone_in_combat();

    if(var1) {
      if(!var0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait level.stealth.stealth_spotted_delay;

        if(!anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        if(isDefined(self.stealth)) {
          var2 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_set(var2);
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      if(isDefined(self.stealth)) {
        var2 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
        scripts\engine\utility::flag_clear(var2);
      }
    }

    var0 = var1;
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
      foreach(var1 in level.stealth.hunt_stealth_group_region_sets) {
        scripts\stealth\clear_regions::huntcomputeaiindependentregionscores(var2, var1);
        wait 0.2;
      }

      continue;
    }

    wait 0.5;
  }
}

function event_change(var0) {
  level.stealth.detect.state = var0;

  foreach(var2 in level.stealth.ai_event) {
    setsaveddvar(var4, var2[var0]);
    var3 = "ai_busyEvent" + getsubstr(var4, 8);
    setsaveddvar(var3, var2[var0]);
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
    self waittill("grenade_fire", var0);
    thread player_grenade_check_dieout(var0);
  }
}

function player_grenade_check_dieout(var0) {
  level.stealth.save.player_nades++;
  var0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
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
  var0 = getEntArray("info_volume_stealth_all", "classname");
  var1 = getEntArray("info_volume_stealth_combat", "classname");
  var1 = scripts\engine\utility::array_combine(var1, var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var4 = strtok(var3.script_stealthgroup, " ");

      foreach(var6 in var4) {
        level.stealth.combat_volumes[var6] = var3;
      }
    }
  }

  var1 = getEntArray("info_volume_stealth_hunt", "classname");
  var1 = scripts\engine\utility::array_combine(var1, var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var4 = strtok(var3.script_stealthgroup, " ");

      foreach(var6 in var4) {
        level.stealth.hunt_volumes[var6] = var3;
      }
    }
  }

  var1 = getEntArray("info_volume_stealth_investigate", "classname");
  var1 = scripts\engine\utility::array_combine(var1, var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var4 = strtok(var3.script_stealthgroup, " ");

      foreach(var6 in var4) {
        level.stealth.investigate_volumes[var6] = var3;
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