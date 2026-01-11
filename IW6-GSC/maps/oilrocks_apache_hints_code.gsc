/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_hints_code.gsc
***********************************************/

apache_hints_move() {
  return common_scripts\utility::flag("FLAG_apache_tut_fly_stop_control_hint");
}

apache_hints_break_ads() {
  if(apache_player_dead()) {
    return 1;
  }

  return self adsbuttonpressed();
}

apache_hints_break_mg() {
  if(apache_player_dead()) {
    return 1;
  }

  return self attackbuttonpressed();
}

apache_hints_break_flares() {
  if(apache_player_dead()) {
    return 1;
  }

  return self secondaryoffhandbuttonpressed();
}

apache_hints_break_missile_straight() {
  if(apache_player_dead()) {
    return 1;
  }

  return self fragbuttonpressed();
}

apache_hints_break_missile_lockon() {
  var_0 = get_players_apache_weapon();

  if(!isDefined(var_0)) {
    return 1;
  }

  return isDefined(var_0.targets_tracking) && var_0.targets_tracking.size;
}

get_players_apache_weapon() {
  if(!isDefined(level.player.riding_heli)) {
    return;
  }
  var_0 = level.player.riding_heli;

  if(!isDefined(var_0.heli)) {
    return;
  }
  var_1 = var_0.heli;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_1.pilot)) {
    return;
  }
  var_2 = var_1.pilot;

  if(!isDefined(var_2.weapon)) {
    return;
  }
  return var_2.weapon["hydra_lockOn_missile"];
}

apache_hints_released_homing() {
  return !level.player fragbuttonpressed();
}

apache_player_dead() {
  if(!isDefined(level.player.riding_heli)) {
    return 0;
  }

  var_0 = level.player.riding_heli;

  if(var_0 maps\_utility::ent_flag_exist("ENT_FLAG_heli_destroyed")) {
    return var_0 maps\_utility::ent_flag("ENT_FLAG_heli_destroyed");
  }
}