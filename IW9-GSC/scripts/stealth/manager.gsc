/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\manager.gsc
***********************************************/

main() {
  if(isDefined(level.stealth)) {
    return;
  }
  init();
  level thread teams_thread();
}

init() {
  scripts\engine\utility::flag_set("stealth_enabled");
  level.stealth = spawnStruct();
  level.stealth.fov = spawnStruct();
  level.stealth.save = spawnStruct();
  level.stealth.funcs = [];
  _func_AB26892D96278702("hidden");
  scripts\stealth\corpse::corpse_init_level();
  scripts\stealth\event::event_init_level();
  level.stealth.next_sound_wait = 3000;
  level.stealth.head_shot_dist = 8;
  level.stealth._id_E012FD4F27172998 = 5;
  level.stealth.group = spawnStruct();
  level.stealth.group.flags = [];
  level.stealth.group.groups = [];
  level.stealth.group.ally_groups = [];
  level.stealth.group.death_alert_timeout = [];
  level.stealth.hunting_groups = [];
  set_default_settings();
  init_stealth_volumes();
  scripts\smartobjects\utility::init_smartobjects();
  init_save();
  level.stealth.min_alert_level_duration = 1;
  level.stealth._id_3495E2E91301FEBD = [];
  level.stealth._id_3495E2E91301FEBD["idle"] = "mp_stealth";
  level.stealth._id_3495E2E91301FEBD["investigate"] = "mp_stealth";
  level.stealth._id_3495E2E91301FEBD["hunt"] = "mp_stealth";
  setup_stealth_funcs();

  if(!isDefined(anim.smartobjects["hunt_point"]))
    _id_2AF9B954E1DB92D0::main();

  if(!isDefined(anim.smartobjects["hunt_checkin"]))
    _id_3433999DC639C4C5::main();

  level._id_0504C141FF7393C0 = spawnStruct();
  level._id_0504C141FF7393C0.instancedata = [];
}

_id_DC19EA08106CA928(state) {
  if(!isDefined(self.stealth)) {
    return;
  }
  if(isDefined(self.stealth._id_3495E2E91301FEBD) && isDefined(self.stealth._id_3495E2E91301FEBD[state]))
    return self.stealth._id_3495E2E91301FEBD[state];

  if(isDefined(level.stealth._id_3495E2E91301FEBD) && isDefined(level.stealth._id_3495E2E91301FEBD[state]))
    return level.stealth._id_3495E2E91301FEBD[state];

  defaults = [];
  defaults["idle"] = "mp_stealth";
  defaults["investigate"] = "mp_stealth";
  defaults["hunt"] = "mp_stealth";
  defaults["combat"] = "default";
  return defaults[state];
}

_id_EF72C03CBCB43194(state, _id_B8F2440E43198535) {
  if(!isDefined(self.stealth)) {
    return;
  }
  if(!isDefined(self.stealth._id_3495E2E91301FEBD))
    self.stealth._id_3495E2E91301FEBD = [];

  self.stealth._id_3495E2E91301FEBD[state] = _id_B8F2440E43198535;
}

setup_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("do_stealth", scripts\stealth\utility::do_stealth);
  scripts\stealth\enemy::set_default_stealth_funcs();
  level.stealth.fngroupspottedflag = scripts\stealth\utility::group_spotted_flag;
  level.stealth.fninitenemygame = undefined;
  level.stealth._id_E376D807BB8CE93B = scripts\stealth\callbacks::stealth_call_thread;
}

set_default_settings() {
  _id_837590C56A1C2441 = [];
  _id_837590C56A1C2441["prone"] = 400;
  _id_837590C56A1C2441["crouch"] = 800;
  _id_837590C56A1C2441["stand"] = 1500;
  _id_6CBBAFD9FF4B4702 = [];
  _id_6CBBAFD9FF4B4702["prone"] = 800;
  _id_6CBBAFD9FF4B4702["crouch"] = 1500;
  _id_6CBBAFD9FF4B4702["stand"] = 3000;
  scripts\stealth\utility::set_detect_ranges(_id_837590C56A1C2441, _id_6CBBAFD9FF4B4702);
  _id_CA02517E3AEB3B5C = [];
  _id_CA02517E3AEB3B5C["prone"] = 130;
  _id_CA02517E3AEB3B5C["crouch"] = 215;
  _id_CA02517E3AEB3B5C["stand"] = 300;
  _id_42470406AE5786DD = [];
  _id_42470406AE5786DD["prone"] = 300;
  _id_42470406AE5786DD["crouch"] = 375;
  _id_42470406AE5786DD["stand"] = 450;
  scripts\stealth\utility::set_min_detect_range_darkness(_id_CA02517E3AEB3B5C, _id_42470406AE5786DD);
  _id_C53B4C55BD88F6D5 = [];
  _id_C53B4C55BD88F6D5["prone"] = 130;
  _id_C53B4C55BD88F6D5["crouch"] = 215;
  _id_C53B4C55BD88F6D5["stand"] = 300;
  _id_FA836DFCDBED1FA6 = [];
  _id_FA836DFCDBED1FA6["prone"] = 300;
  _id_FA836DFCDBED1FA6["crouch"] = 375;
  _id_FA836DFCDBED1FA6["stand"] = 450;
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_CA02517E3AEB3B5C, _id_42470406AE5786DD);
  level.stealth.fov.cosine["blind"] = 0.98;
  level.stealth.fov._id_4B1C8BD8C8D29D03["blind"] = 0.98;
  level.stealth.fov._id_CEA2DF14AC0BF8C4["blind"] = 0;
  level.stealth.fov._id_E5403EB19D281362["blind"] = 0;
  level.stealth.fov.cosine["hidden"] = 0.7;
  level.stealth.fov._id_4B1C8BD8C8D29D03["hidden"] = 0.86;
  level.stealth.fov._id_CEA2DF14AC0BF8C4["hidden"] = 0.97;
  level.stealth.fov._id_E5403EB19D281362["hidden"] = 1;
  level.stealth.fov.cosine["investigate"] = 0.7;
  level.stealth.fov._id_4B1C8BD8C8D29D03["investigate"] = 0.86;
  level.stealth.fov._id_CEA2DF14AC0BF8C4["investigate"] = 0.97;
  level.stealth.fov._id_E5403EB19D281362["investigate"] = 1;
  level.stealth.fov.cosine["combat_hunt"] = 0.7;
  level.stealth.fov._id_4B1C8BD8C8D29D03["combat_hunt"] = 0.86;
  level.stealth.fov._id_CEA2DF14AC0BF8C4["combat_hunt"] = 0.97;
  level.stealth.fov._id_E5403EB19D281362["combat_hunt"] = 1;
  level.stealth.fov.cosine["spotted"] = 0.01;
  level.stealth.fov._id_4B1C8BD8C8D29D03["spotted"] = 0.574;
  level.stealth.fov._id_CEA2DF14AC0BF8C4["spotted"] = 0;
  level.stealth.fov._id_E5403EB19D281362["spotted"] = 0;
  scripts\stealth\corpse::set_corpse_ranges_default();
  init_event_distances();
  event_change("hidden");
}

init_event_distances() {
  array["spotted"]["death"] = _func_9D30FD63965BAFA9("death");
  array["hidden"]["death"] = 512;
  array["spotted"]["pain"] = _func_9D30FD63965BAFA9("pain");
  array["hidden"]["pain"] = 256;
  array["spotted"]["explosion"] = _func_9D30FD63965BAFA9("explosion");
  array["hidden"]["explosion"] = 2048;
  array["spotted"]["bullet"] = _func_9D30FD63965BAFA9("bullet");
  array["hidden"]["bullet"] = 64;
  array["spotted"]["footstep_walk"] = _func_9D30FD63965BAFA9("footstep_walk");
  array["hidden"]["footstep_walk"] = 50;
  array["spotted"]["footstep"] = _func_9D30FD63965BAFA9("footstep");
  array["hidden"]["footstep"] = 100;
  array["spotted"]["footstep_sprint"] = _func_9D30FD63965BAFA9("footstep_sprint");
  array["hidden"]["footstep_sprint"] = 400;
  array["spotted"]["gunshot"] = _func_9D30FD63965BAFA9("gunshot");
  array["hidden"]["gunshot"] = 1500;
  array["spotted"]["silenced_shot"] = _func_9D30FD63965BAFA9("silenced_shot");
  array["hidden"]["silenced_shot"] = 180;
  array["spotted"]["glass_destroyed"] = _func_9D30FD63965BAFA9("glass_destroyed");
  array["hidden"]["glass_destroyed"] = 384;
  array["spotted"]["gunshot_teammate"] = _func_9D30FD63965BAFA9("gunshot_teammate");
  array["hidden"]["gunshot_teammate"] = 1500;
  array["spotted"]["new_enemy"] = 128;
  array["hidden"]["new_enemy"] = 128;
  set_event_distances(array);
}

set_event_distances(array) {
  foreach(state, _id_AECF66BDCFDCC264 in array) {
    foreach(event, value in _id_AECF66BDCFDCC264) {
      _func_20D5809A5332448F(state, event, value);

      if(_func_EAC0CD99C9C6D8EE() == state) {
        _func_7AFB89FC511BF315(event, value);
        _func_1A3DD0FBFE26893F(event, value);
      }
    }
  }
}

set_custom_distances(array) {
  set_event_distances(array);
}

set_detect_ranges_internal(hidden, spotted, _id_8F3F480583606401) {
  _id_4BEAF1E22C2142F6 = 0.25;

  if(isDefined(hidden)) {
    _func_3C1C3F98CD23089E("hidden", "prone", hidden["prone"]);
    _func_3C1C3F98CD23089E("hidden", "crouch", hidden["crouch"]);
    _func_3C1C3F98CD23089E("hidden", "stand", hidden["stand"]);

    if(!isDefined(hidden["shadow"]))
      hidden["shadow"] = _id_4BEAF1E22C2142F6;

    _func_3C1C3F98CD23089E("hidden", "shadow", hidden["shadow"]);
  }

  if(isDefined(spotted)) {
    _func_3C1C3F98CD23089E("spotted", "prone", spotted["prone"]);
    _func_3C1C3F98CD23089E("spotted", "crouch", spotted["crouch"]);
    _func_3C1C3F98CD23089E("spotted", "stand", spotted["stand"]);

    if(!isDefined(spotted["shadow"]))
      spotted["shadow"] = _id_4BEAF1E22C2142F6;

    _func_3C1C3F98CD23089E("spotted", "shadow", spotted["shadow"]);
  }

  if(isDefined(_id_8F3F480583606401)) {
    if(isDefined(_id_8F3F480583606401["prone"]))
      _func_C98DF02C041ADCCB("prone", _id_8F3F480583606401["prone"]);

    if(isDefined(_id_8F3F480583606401["crouch"]))
      _func_C98DF02C041ADCCB("crouch", _id_8F3F480583606401["crouch"]);

    if(isDefined(_id_8F3F480583606401["stand"]))
      _func_C98DF02C041ADCCB("stand", _id_8F3F480583606401["stand"]);
  }
}

manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\stealth\threat_sight::threat_sight_set_dvar(1);

    if(!playerlootenabled())
      setsaveddvar("ai_corpsesynch", 1);

    scripts\engine\utility::flag_wait("stealth_spotted");

    if(!playerlootenabled())
      setsaveddvar("ai_corpsesynch", 0);

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    event_change("spotted");
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }
    event_change("hidden");
    waittillframeend;
  }
}

anyone_in_combat() {
  if(!isDefined(level.stealth))
    return 0;

  if(_func_1BB1470F934A81EB())
    return 1;

  _id_8BAB3203A26744B8 = getaiunittypearray("bad_guys", "all");

  foreach(guy in _id_8BAB3203A26744B8) {
    if(!isDefined(guy.stealth) && isDefined(guy.enemy) && guy.enemy == self)
      return 1;
  }

  return 0;
}

_id_6C78F7F002B9D507() {
  if(isDefined(level.stealth.groupdata)) {
    foreach(group in level.stealth.groupdata.groups) {
      if(scripts\stealth\group::_id_624F57A99242F017(group.name))
        return 1;
    }
  }

  return 0;
}

anyone_in_hunt() {
  return 0;
}

update_stealth_spotted_thread() {
  waitframe();
  _id_5560C6A46094816F = 0;

  for(;;) {
    _id_65661AE3A873C9AE = anyone_in_combat();

    if(_id_65661AE3A873C9AE) {
      if(!_id_5560C6A46094816F && isDefined(level.stealth.stealth_spotted_delay)) {
        wait(level.stealth.stealth_spotted_delay);

        if(!anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        if(isDefined(self.stealth)) {
          _id_F950051ECB0CD613 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_set(_id_F950051ECB0CD613);
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      if(isDefined(self.stealth)) {
        _id_F950051ECB0CD613 = scripts\stealth\utility::get_group_flagname("stealth_spotted");
        scripts\engine\utility::flag_clear(_id_F950051ECB0CD613);
      }
    }

    _id_5560C6A46094816F = _id_65661AE3A873C9AE;
    waitframe();
  }
}

teams_thread() {
  level.stealth.enemies["axis"] = [];
  level.stealth.enemies["allies"] = [];

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    level.stealth.enemies["axis"] = level.players;
    level.stealth.enemies["allies"] = getaiarray("axis");
    wait 0.05;
  }
}

event_change(name) {
  _func_AB26892D96278702(name);
  ai_event = _func_373416B9EC7DD155();

  foreach(state, _id_AECF66BDCFDCC264 in ai_event) {
    if(state == name) {
      foreach(key, event in _id_AECF66BDCFDCC264) {
        _func_7AFB89FC511BF315(key, event);
        _func_1A3DD0FBFE26893F(key, event);
      }
    }
  }
}

init_save() {
  scripts\engine\utility::flag_init("stealth_player_nade");
  level.stealth.save.player_nades = 0;

  if(!scripts\common\utility::issp()) {
    return;
  }
  scripts\engine\utility::array_thread(level.players, ::player_grenade_check);
}

player_grenade_check() {
  for(;;) {
    self waittill("grenade_pullback");
    scripts\engine\utility::flag_set("stealth_player_nade");
    self waittill("grenade_fire", grenade);
    thread player_grenade_check_dieout(grenade);
  }
}

player_grenade_check_dieout(grenade) {
  level.stealth.save.player_nades++;
  grenade scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.stealth.save.player_nades--;
  waittillframeend;

  if(!level.stealth.save.player_nades)
    scripts\engine\utility::flag_clear("stealth_player_nade");
}

init_stealth_volumes() {
  level.stealth.combat_volumes = [];
  level.stealth.hunt_volumes = [];
  level.stealth.investigate_volumes = [];
  _id_6D476F1DEA7803BB = getEntArray("info_volume_stealth_all", "classname");
  volumes = getEntArray("info_volume_stealth_combat", "classname");
  volumes = scripts\engine\utility::array_combine(volumes, _id_6D476F1DEA7803BB);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "-1") {
        groups = strtok(vol.script_stealthgroup, " ");

        foreach(group in groups)
        level.stealth.combat_volumes[group] = vol;
      }
    }
  }

  volumes = getEntArray("info_volume_stealth_hunt", "classname");
  volumes = scripts\engine\utility::array_combine(volumes, _id_6D476F1DEA7803BB);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "-1") {
        groups = strtok(vol.script_stealthgroup, " ");

        foreach(group in groups)
        level.stealth.hunt_volumes[group] = vol;
      }
    }
  }

  volumes = getEntArray("info_volume_stealth_investigate", "classname");
  volumes = scripts\engine\utility::array_combine(volumes, _id_6D476F1DEA7803BB);

  if(isDefined(volumes)) {
    foreach(vol in volumes) {
      if(isDefined(vol.script_stealthgroup) && vol.script_stealthgroup != "-1") {
        groups = strtok(vol.script_stealthgroup, " ");

        foreach(group in groups)
        level.stealth.investigate_volumes[group] = vol;
      }
    }
  }
}

playerlootenabled() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnplayerlootenabled))
    return [[level.stealth.fnplayerlootenabled]]();

  return 0;
}