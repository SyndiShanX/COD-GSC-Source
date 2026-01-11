/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_sentry.gsc
**************************************/

main() {
  setup_sentry_globals();
  setup_sentry_minigun();
  setup_sentry_grenade_launcher();

  if(common_scripts\utility::issp_towerdefense()) {
    setup_sentry_minigun_weak();
    setup_sentry_grenade_launcher_weak();
  }
}

setup_sentry_globals() {
  if(common_scripts\utility::issp()) {
    precachestring(&"SENTRY_MOVE");
    precachestring(&"SENTRY_PICKUP");
    precachestring(&"SENTRY_PLACE");
    precachestring(&"SENTRY_CANNOT_PLACE");
  }

  precachemodel("tag_laser");
  level.placed_sentry = [];
  level.sentry_settings = [];
  level.sentryturretsettings = [];
  level.sentryturretsettings["easy"] = [];
  level.sentryturretsettings["easy"]["convergencePitchTime"] = 2.5;
  level.sentryturretsettings["easy"]["convergenceYawTime"] = 2.5;
  level.sentryturretsettings["easy"]["suppressionTime"] = 3.0;
  level.sentryturretsettings["easy"]["aiSpread"] = 2.0;
  level.sentryturretsettings["easy"]["playerSpread"] = 0.5;
  level._effect["sentry_turret_overheat_smoke_sp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_turret_explode"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_turret_explode_smoke"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");
}

setup_sentry_minigun() {
  precachemodel("sentry_minigun");
  precachemodel("sentry_minigun_obj");
  precachemodel("sentry_minigun_obj_red");
  precachemodel("sentry_minigun_folded_obj");
  precachemodel("sentry_minigun_destroyed");

  if(common_scripts\utility::issp() && !is_specialop()) {
    precacheturret("sentry_minigun");
    precacheturret("sentry_minigun_enemy");
  } else if(is_specialop())
    precacheturret("sentry_minigun_so");
  else {
    precacheturret("sentry_minigun_mp");
  }

  level.sentry_settings["sentry_minigun"] = spawnStruct();
  sentry_minigun_default_settings("sentry_minigun");
  init_placed_sentries("sentry_minigun");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_minigun", "classname"), ::sentry_pickup_init, "sentry_minigun");
}

setup_sentry_minigun_weak() {
  precachemodel("sentry_minigun_weak");
  precachemodel("sentry_minigun_weak_destroyed");
  precachemodel("sentry_minigun_weak_obj");
  precachemodel("sentry_minigun_weak_obj_red");
  precachemodel("sentry_minigun_weak_folded_obj");
  precacheturret("sentry_minigun_weak");
  level.sentry_settings["sentry_minigun_weak"] = spawnStruct();
  sentry_minigun_weak_settings("sentry_minigun_weak");
  init_placed_sentries("sentry_minigun_weak");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_minigun_weak", "classname"), ::sentry_pickup_init, "sentry_minigun_weak");
}

setup_sentry_grenade_launcher() {
  precachemodel("sentry_grenade_launcher_upgrade");
  precachemodel("sentry_grenade_launcher_upgrade_destroyed");
  precachemodel("sentry_grenade_launcher_upgrade_obj");
  precachemodel("sentry_grenade_launcher_upgrade_obj_red");
  precachemodel("sentry_grenade_launcher_upgrade_folded_obj");

  if(common_scripts\utility::issp() && !is_specialop()) {
    precacheturret("sentry_gun");
  }
  else if(is_specialop()) {
    precacheturret("sentry_gun_so");
  }
  else {
    precacheturret("sentry_gun_mp");
  }

  level.sentry_settings["sentry_gun"] = spawnStruct();
  sentry_gun_default_settings("sentry_gun");
  init_placed_sentries("sentry_gun");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_gun", "classname"), ::sentry_pickup_init, "sentry_gun");
}

setup_sentry_grenade_launcher_weak() {
  precachemodel("sentry_grenade_launcher");
  precachemodel("sentry_grenade_launcher_destroyed");
  precachemodel("sentry_grenade_launcher_obj");
  precachemodel("sentry_grenade_launcher_obj_red");
  precachemodel("sentry_grenade_launcher_folded_obj");
  precacheturret("sentry_gun_weak");
  level.sentry_settings["sentry_gun_weak"] = spawnStruct();
  sentry_gun_weak_settings("sentry_gun_weak");
  init_placed_sentries("sentry_gun_weak");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_gun_weak", "classname"), ::sentry_pickup_init, "sentry_gun_weak");
}

setup_sentry_smg() {
  precachemodel("weapon_sentry_smg");
  precachemodel("weapon_sentry_smg_obj");
  precachemodel("weapon_sentry_smg_obj_red");
  precachemodel("weapon_sentry_smg_animated");
  precachemodel("weapon_sentry_smg_animated_obj");
  precachemodel("weapon_sentry_smg_destroyed");
  precacheturret("sentry_smg");
  level.sentry_settings["sentry_smg"] = spawnStruct();
  sentry_smg_default_settings("sentry_smg");
  init_placed_sentries("sentry_smg");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_smg", "classname"), ::sentry_pickup_init, "sentry_smg");
}

init_placed_sentries(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
  var_3 sentry_init(undefined, var_0);
  }
}

sentry_gun_default_settings(var_0) {
  level.sentry_settings[var_0].ammo = 100;
  level.sentry_settings[var_0].use_laser = 1;
  level.sentry_settings[var_0].burst_shots_min = 1;
  level.sentry_settings[var_0].burst_shots_max = 2;
  level.sentry_settings[var_0].burst_pause_min = 1;
  level.sentry_settings[var_0].burst_pause_max = 1.5;
  level.sentry_settings[var_0].fire_only_on_target = 1;
  level.sentry_settings[var_0].model = "sentry_grenade_launcher_upgrade";
  level.sentry_settings[var_0].destroyedmodel = "sentry_grenade_launcher_upgrade_destroyed";
  level.sentry_settings[var_0].pickupmodel = "sentry_grenade_launcher_upgrade_folded";
  level.sentry_settings[var_0].pickupmodelobj = "sentry_grenade_launcher_upgrade_folded_obj";
  level.sentry_settings[var_0].placementmodel = "sentry_grenade_launcher_upgrade_obj";
  level.sentry_settings[var_0].placementmodelfail = "sentry_grenade_launcher_upgrade_obj_red";
  level.sentry_settings[var_0].health = 350;

  if(common_scripts\utility::issp() && !is_specialop()) {
    level.sentry_settings[var_0].damage_smoke_time = 15;
    level.sentry_settings[var_0].weaponinfo = "sentry_gun";
    level.sentry_settings[var_0].targetname = "sentry_gun";
  } else if(is_specialop()) {
    level.sentry_settings[var_0].ammo = 50;
    level.sentry_settings[var_0].damage_smoke_time = 8;
    level.sentry_settings[var_0].weaponinfo = "sentry_gun_so";
    level.sentry_settings[var_0].targetname = "sentry_gun_so";
    level.sentry_settings[var_0].health = 1200;
  } else {
    level.sentry_settings[var_0].damage_smoke_time = 5;
    level.sentry_settings[var_0].weaponinfo = "sentry_gun_mp";
    level.sentry_settings[var_0].targetname = "sentry_gun_mp";
  }
}

sentry_gun_weak_settings(var_0) {
  level.sentry_settings[var_0].use_laser = 0;
  level.sentry_settings[var_0].burst_shots_min = 1;
  level.sentry_settings[var_0].burst_shots_max = 2;
  level.sentry_settings[var_0].burst_pause_min = 1;
  level.sentry_settings[var_0].burst_pause_max = 1.5;
  level.sentry_settings[var_0].fire_only_on_target = 1;
  level.sentry_settings[var_0].model = "sentry_grenade_launcher";
  level.sentry_settings[var_0].destroyedmodel = "sentry_grenade_launcher_destroyed";
  level.sentry_settings[var_0].pickupmodel = "sentry_grenade_launcher_folded";
  level.sentry_settings[var_0].pickupmodelobj = "sentry_grenade_launcher_folded_obj";
  level.sentry_settings[var_0].placementmodel = "sentry_grenade_launcher_obj";
  level.sentry_settings[var_0].placementmodelfail = "sentry_grenade_launcher_obj_red";
  level.sentry_settings[var_0].health = int(175.0);

  if(common_scripts\utility::issp()) {
    level.sentry_settings[var_0].damage_smoke_time = 15;
    level.sentry_settings[var_0].weaponinfo = "sentry_gun_weak";
    level.sentry_settings[var_0].targetname = "sentry_gun_weak";
  } else {
    level.sentry_settings[var_0].damage_smoke_time = 5;
    level.sentry_settings[var_0].weaponinfo = "sentry_gun_mp";
    level.sentry_settings[var_0].targetname = "sentry_gun_mp";
  }
}

#using_animtree("sentry_gun");

sentry_minigun_default_settings(var_0) {
  level.sentry_settings[var_0].ammo = 1000;
  level.sentry_settings[var_0].use_laser = 1;
  level.sentry_settings[var_0].burst_shots_min = 20;
  level.sentry_settings[var_0].burst_shots_max = 60;
  level.sentry_settings[var_0].burst_pause_min = 0.5;
  level.sentry_settings[var_0].burst_pause_max = 1.3;
  level.sentry_settings[var_0].fire_only_on_target = 0;
  level.sentry_settings[var_0].model = "sentry_minigun";
  level.sentry_settings[var_0].destroyedmodel = "sentry_minigun_destroyed";
  level.sentry_settings[var_0].pickupmodel = "sentry_minigun_folded";
  level.sentry_settings[var_0].pickupmodelobj = "sentry_minigun_folded_obj";
  level.sentry_settings[var_0].placementmodel = "sentry_minigun_obj";
  level.sentry_settings[var_0].placementmodelfail = "sentry_minigun_obj_red";
  level.sentry_settings[var_0].health = 190;

  if(common_scripts\utility::issp() && !is_specialop()) {
    level.sentry_settings[var_0].damage_smoke_time = 15;
    level.sentry_settings[var_0].anim_loop = % minigun_spin_loop;
    level.sentry_settings[var_0].weaponinfo = "sentry_minigun";
    level.sentry_settings[var_0].targetname = "sentry_minigun";
  } else if(is_specialop()) {
    level.sentry_settings[var_0].ammo = 800;
    level.sentry_settings[var_0].damage_smoke_time = 8;
    level.sentry_settings[var_0].anim_loop = % minigun_spin_loop;
    level.sentry_settings[var_0].weaponinfo = "sentry_minigun_so";
    level.sentry_settings[var_0].targetname = "sentry_minigun_so";
    level.sentry_settings[var_0].health = 800;
  } else {
    level.sentry_settings[var_0].damage_smoke_time = 5;
    level.sentry_settings[var_0].weaponinfo = "sentry_minigun_mp";
    level.sentry_settings[var_0].targetname = "sentry_minigun_mp";
  }
}

sentry_minigun_weak_settings(var_0) {
  level.sentry_settings[var_0].ammo = 800;
  level.sentry_settings[var_0].use_laser = 0;
  level.sentry_settings[var_0].burst_shots_min = 10;
  level.sentry_settings[var_0].burst_shots_max = 30;
  level.sentry_settings[var_0].burst_pause_min = 1.0;
  level.sentry_settings[var_0].burst_pause_max = 2.6;
  level.sentry_settings[var_0].fire_only_on_target = 0;
  level.sentry_settings[var_0].model = "sentry_minigun_weak";
  level.sentry_settings[var_0].destroyedmodel = "sentry_minigun_weak_destroyed";
  level.sentry_settings[var_0].pickupmodel = "sentry_minigun_weak_folded";
  level.sentry_settings[var_0].pickupmodelobj = "sentry_minigun_weak_folded_obj";
  level.sentry_settings[var_0].placementmodel = "sentry_minigun_weak_obj";
  level.sentry_settings[var_0].placementmodelfail = "sentry_minigun_weak_obj_red";
  level.sentry_settings[var_0].health = int(95.0);

  if(common_scripts\utility::issp()) {
    level.sentry_settings[var_0].damage_smoke_time = 15;
    level.sentry_settings[var_0].anim_loop = % minigun_spin_loop;
    level.sentry_settings[var_0].weaponinfo = "sentry_minigun_weak";
    level.sentry_settings[var_0].targetname = "sentry_minigun_weak";
  } else {
    level.sentry_settings[var_0].damage_smoke_time = 5;
    level.sentry_settings[var_0].weaponinfo = "sentry_minigun_mp";
    level.sentry_settings[var_0].targetname = "sentry_minigun_mp";
  }
}

sentry_smg_default_settings(var_0) {
  level.sentry_settings[var_0].ammo = 100;
  level.sentry_settings[var_0].use_laser = 1;
  level.sentry_settings[var_0].burst_shots_min = 10;
  level.sentry_settings[var_0].burst_shots_max = 30;
  level.sentry_settings[var_0].burst_pause_min = 0.5;
  level.sentry_settings[var_0].burst_pause_max = 1.5;
  level.sentry_settings[var_0].fire_only_on_target = 1;
  level.sentry_settings[var_0].model = "weapon_sentry_smg";
  level.sentry_settings[var_0].destroyedmodel = "weapon_sentry_smg_destroyed";
  level.sentry_settings[var_0].pickupmodel = "weapon_sentry_smg_animated";
  level.sentry_settings[var_0].pickupmodelobj = "weapon_sentry_smg_animated_obj";
  level.sentry_settings[var_0].placementmodel = "weapon_sentry_smg_obj";
  level.sentry_settings[var_0].placementmodelfail = "weapon_sentry_smg_obj_red";
  level.sentry_settings[var_0].health = 350;
  level.sentry_settings[var_0].no_steam = 1;
  level.sentry_settings[var_0].damage_smoke_time = 0;
  level.sentry_settings[var_0].weaponinfo = "sentry_smg";
  level.sentry_settings[var_0].targetname = "sentry_smg";
}

sentry_pickup_init(var_0) {
  self setModel(self.model);
  self.sentrytype = var_0;
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"SENTRY_PICKUP");
  self makeusable();
  thread folded_sentry_use_wait(var_0);
}

givesentry(var_0) {
  self.last_sentry = var_0;
  thread spawn_and_place_sentry(var_0);
}

sentry_init(var_0, var_1, var_2) {
  if(common_scripts\utility::issp()) {
    level.sentry_overheating_speed = 1;
    level.sentry_cooling_speed = 1;

    if(!isDefined(level.sentry_fire_time)) {
      level.sentry_fire_time = 5;
    }

    if(!isDefined(level.sentry_cooldown_time)) {
      level.sentry_cooldown_time = 2;
    }
  }

  if(!isDefined(var_0)) {
    if(!isDefined(self.script_team)) {
      self.script_team = "axis";
    }

    var_0 = self.script_team;
  }

  self setturretmodechangewait(1);
  makesentrysolid();
  self maketurretinoperable();
  sentrypoweron();
  self setCanDamage(1);
  self setdefaultdroppitch(-89.0);

  if(common_scripts\utility::issp() || level.teambased || is_survival()) {
    self setturretteam(var_0);
  }

  self.sentrytype = var_1;
  self.issentrygun = 1;
  self.kill_reward_money = 350;
  self.kill_melee_reward_money = 400;
  self.sentry_battery_timer = 60;
  self.sentry_ammo = level.sentry_settings[self.sentrytype].ammo;

  if(common_scripts\utility::issp()) {
    if(isDefined(level.sentry_settings) && isDefined(level.sentry_settings["sentry_minigun"]) && isDefined(level.sentry_settings["sentry_minigun"].bullet_armor)) {
      self.bullet_armor = level.sentry_settings["sentry_minigun"].bullet_armor;
    }
    else if(self.weaponinfo == "sentry_gun") {
      self.bullet_armor = 2000;
    }
    else {
      self.bullet_armor = 1200;
    }
  } else if(self.weaponinfo == "sentry_gun")
    self.bullet_armor = 300;
  else {
    self.bullet_armor = 300;
  }

  if(common_scripts\utility::issp()) {
    self call[[level.makeentitysentient_func]](var_0);
    common_scripts\utility::self_func("useanimtree", #animtree);

    if(isDefined(self.script_team) && self.script_team == "axis") {
      thread enemy_sentry_difficulty_settings();
    }
  }

  self.health = level.sentry_settings[var_1].health;
  sentry_badplace_create();
  thread sentry_beep_sounds();
  thread sentry_enemy_wait();
  thread sentry_death_wait();

  if(!common_scripts\utility::issp()) {
    thread sentry_emp_wait();
    thread sentry_emp_damage_wait();
  }

  thread sentry_health_monitor();
  thread sentry_player_use_wait();

  if(!isDefined(var_2)) {
    if(common_scripts\utility::issp()) {
      var_2 = level.player;
    }
  }

  sentry_set_owner(var_2);
  thread sentry_destroy_on_owner_leave(var_2);

  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }
}

sentry_death_wait() {
  self endon("deleted");
  self waittill("death", var_0, var_1, var_2);
  level notify("a_sentry_died");

  if(isDefined(var_0) && isDefined(var_0.team) && self.team != var_0.team && isDefined(level.stat_track_kill_func)) {
    var_0[[level.stat_track_kill_func]](self, var_1, var_2);
  }

  if(!common_scripts\utility::issp()) {
    removefromturretlist();
    thread sentry_place_mode_reset();
  }

  thread sentry_burst_fire_stop();
  thread sentry_turn_laser_off();
  self setModel(level.sentry_settings[self.sentrytype].destroyedmodel);
  sentrypoweroff();

  if(common_scripts\utility::issp()) {
    self call[[level.freeentitysentient_func]]();
  }

  if(!common_scripts\utility::issp() && isDefined(var_0) && isplayer(var_0)) {
    if(isDefined(self.owner)) {
      self.owner thread[[level.leaderdialogonplayer_func]]("destroy_sentry", "sentry_status");
    }

    var_0 thread[[level.onxpevent]]("kill");
  }

  self setsentrycarrier(undefined);
  self.carrier = undefined;
  self setCanDamage(1);
  self.ignoreme = 1;
  self makeunusable();
  self setsentryowner(undefined);
  self setturretminimapvisible(0);
  self playSound("sentry_explode");
  playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");

  if(common_scripts\utility::issp() && (!isDefined(self.stay_solid_on_death) || !self.stay_solid_on_death)) {
    self setcontents(0);
  }

  wait 1.5;
  self playSound("sentry_explode_smoke");
  var_3 = level.sentry_settings[self.sentrytype].damage_smoke_time * 1000;
  var_4 = gettime();

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode_smoke"), self, "tag_aim");
    wait 0.4;

    if(gettime() - var_4 > var_3) {
      break;
    }
  }

  level.placed_sentry = common_scripts\utility::array_remove(level.placed_sentry, self);

  if(!common_scripts\utility::issp() || getdvar("specialops") == "1") {
    thread removedeadsentry();
  }
}

handle_sentry_on_carrier_death(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("death");

  if(common_scripts\utility::issp()) {
    var_0 notify("death");
    return;
  }

  if(!self.canplaceentity) {
    var_0 sentry_place_mode_reset();
    var_0 notify("deleted");
    waittillframeend;
    var_0 delete();
    return;
  }

  if(!common_scripts\utility::issp()) {
    thread place_sentry(var_0);
  }
}

kill_sentry_on_carrier_disconnect(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("disconnect");
  var_0 notify("death");
}

handle_sentry_placement_failed(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("sentry_placement_canceled");
  var_0 sentry_place_mode_reset();
  sentry_placement_hint_hide();
  var_0 notify("death");
}

sentry_player_use_wait() {
  level endon("game_ended");
  self endon("death");

  if(self.health <= 0) {
    return;
  }
  self makeusable();

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0.placingsentry)) {
      continue;
    }
    if(!common_scripts\utility::issp()) {
      var_0 playlocalsound("sentry_pickup");
    }
    else {
      var_0 playSound("sentry_pickup");
    }

    break;
  }

  var_0 thread handle_sentry_placement_failed(self);
  var_0 thread handle_sentry_on_carrier_death(self);
  var_0 thread kill_sentry_on_carrier_disconnect(self);
  var_0 thread sentry_placement_endoflevel_cancel_monitor(self);

  if(!common_scripts\utility::issp() && !isalive(var_0)) {
    return;
  }
  if(!common_scripts\utility::issp()) {
    sentry_team_hide_icon();
  }

  sentrypoweroff();
  var_0.placingsentry = self;
  self setsentrycarrier(var_0);
  self.carrier = var_0;
  self.ignoreme = 1;
  self setCanDamage(0);

  if(isDefined(self.carrier) && isplayer(self.carrier)) {
    self.carrier allowlean(0);
  }

  self makeunusable();
  var_0 common_scripts\utility::_disableweapon();
  makesentrynotsolid();
  sentry_badplace_delete();
  var_0 thread move_sentry_wait(self);
  var_0 thread updatesentrypositionthread(self);
}

sentry_badplace_create() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  self.badplace_name = "" + gettime();
  call[[level.badplace_cylinder_func]](self.badplace_name, 0, self.origin, 32, 128, self.team, "neutral");
}

sentry_badplace_delete() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  call[[level.badplace_delete_func]](self.badplace_name);
  self.badplace_name = undefined;
}

move_sentry_wait(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("deleted");
  self endon("death");
  self endon("disconnect");
  var_0 notify("sentry_move_started", self);
  self.carrying_pickedup_sentry = 1;

  for(;;) {
    waitactivatebutton(0);
    waitactivatebutton(1);
    updatesentryposition(var_0);

    if(self.canplaceentity) {
      break;
    }
  }

  var_0 notify("sentry_move_finished", self);
  self.carrying_pickedup_sentry = 0;
  place_sentry(var_0);
}

place_sentry(var_0) {
  if(!common_scripts\utility::issp()) {
    self endon("death");
    level endon("end_game");
  }

  if(isDefined(var_0.carrier) && isplayer(var_0.carrier)) {
    var_0.carrier allowlean(1);
  }

  self.placingsentry = undefined;
  var_0 setsentrycarrier(undefined);
  var_0.carrier = undefined;
  var_0 setCanDamage(1);
  var_0.ignoreme = 0;
  common_scripts\utility::_enableweapon();
  var_0 makesentrysolid();
  var_0 setModel(level.sentry_settings[var_0.sentrytype].model);
  var_0 sentry_badplace_create();
  var_0 setcontents(var_0.contents);
  var_0 sentry_set_owner(self);
  self notify("sentry_placement_finished", var_0);
  var_0 notify("sentry_carried");
  var_0.overheated = 0;
  sentry_placement_hint_hide();

  if(!common_scripts\utility::issp()) {
    var_0 sentry_team_show_icon();
  }

  var_0 sentrypoweron();
  thread common_scripts\utility::play_sound_in_space("sentry_gun_plant", var_0.origin);
  waitactivatebutton(0);
  var_0 thread sentry_player_use_wait();
}

sentry_enemy_wait() {
  level endon("game_ended");
  self endon("death");
  thread sentry_overheat_monitor();

  for(;;) {
    common_scripts\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      thread sentry_burst_fire_start();
      thread sentry_turn_laser_on();
      continue;
    }

    thread sentry_burst_fire_stop();
    thread sentry_turn_laser_off();
  }
}

sentry_overheat_monitor() {
  self endon("death");

  if(self.sentrytype != "sentry_minigun") {
    return;
  }
  if(!isDefined(level.sentry_overheating_speed)) {
    return;
  }
  self.overheat = 0;
  self.overheated = 0;

  if(getdvarint("sentry_overheat_debug") == 1) {
    thread sentry_overheat_debug();
  }

  for(;;) {
    if(self.overheat >= level.sentry_fire_time * 10) {
      thread sentry_overheat_deactivate();
      common_scripts\utility::waittill_either("cooled", "sentry_carried");
    }

    if(self isfiringturret()) {
      self.overheat = self.overheat + 1;
    }
    else if(self.overheat > 0) {
      self.overheat = self.overheat - 1;
    }

    wait(0.1 / level.sentry_overheating_speed);
  }
}

sentry_cooling() {
  self endon("death");

  while(self.overheated) {
    if(self.overheat > 0) {
      self.overheat = self.overheat - 1;
    }

    wait(0.1 / level.sentry_overheating_speed);
  }
}

sentry_overheat_debug() {
  self endon("death");

  for(;;) {
    var_0 = self.overheat / (level.sentry_fire_time * 10);
    var_1 = "[ ";
    var_2 = " ]";

    if(self.overheated) {
      var_1 = "{{{ ";
      var_2 = " }}}";
    }

    wait 0.2;
  }
}

sentry_overheat_deactivate() {
  self endon("death");
  self notify("overheated");
  self.overheated = 1;
  sentry_burst_fire_stop();
  thread sentry_overheat_reactivate();
}

sentry_overheat_reactivate() {
  self endon("death");
  self endon("sentry_carried");
  thread sentry_cooling();
  wait(level.sentry_cooldown_time);
  self notify("cooled");
  self.overheat = 0;
  self.overheated = 0;
}

sentry_burst_fire_start() {
  self endon("death");
  level endon("game_ended");

  if(level.sentry_settings[self.sentrytype].fire_only_on_target) {
    self waittill("turret_on_target");
  }

  if(isDefined(self.overheated) && self.overheated) {
    return;
  }
  thread fire_anim_start();
  self endon("stop_shooting");
  self notify("shooting");
  var_0 = weaponfiretime(self.weaponinfo);

  for(;;) {
    turret_start_anim_wait();
    var_1 = randomintrange(level.sentry_settings[self.sentrytype].burst_shots_min, level.sentry_settings[self.sentrytype].burst_shots_max);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      if(canfire()) {
        self shootturret();
      }

      self notify("bullet_fired");
      wait(var_0);
    }

    wait(randomfloatrange(level.sentry_settings[self.sentrytype].burst_pause_min, level.sentry_settings[self.sentrytype].burst_pause_max));
  }
}

sentry_allowfire(var_0, var_1) {
  self notify("allowFireThread");
  self endon("allowFireThread");
  self endon("death");
  self.taking_damage = var_0;

  if(isDefined(var_1) && !var_0) {
    wait(var_1);

    if(isDefined(self)) {
      thread sentry_allowfire(1);
    }
  }
}

canfire() {
  if(!isDefined(self.taking_damage)) {
    return 1;
  }

  return self.taking_damage;
}

sentry_burst_fire_stop() {
  thread fire_anim_stop();
  self notify("stop_shooting");

  if(isDefined(self.sentry_type) && (!isDefined(level.sentry_settings[self.sentry_type].no_steam) || !level.sentry_settings[self.sentry_type].no_steam)) {
    thread sentry_steam();
  }
}

sentry_steam() {
  self endon("shooting");
  self endon("deleted");
  wait(randomfloatrange(0.0, 1.0));
  var_0 = 6000;
  var_1 = gettime();

  if(isDefined(self)) {
    self playSound("sentry_steam");
  }

  while(isDefined(self)) {
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_overheat_smoke_sp"), self, "tag_flash");
    wait 0.3;

    if(gettime() - var_1 > var_0) {
      break;
    }
  }
}

turret_start_anim_wait() {
  if(isDefined(self.allow_fire) && self.allow_fire == 0) {
    self waittill("allow_fire");
  }
}

fire_anim_start() {
  self notify("anim_state_change");
  self endon("anim_state_change");
  self endon("stop_shooting");
  self endon("deleted");
  level endon("game_ended");
  self endon("death");

  if(!isDefined(level.sentry_settings[self.sentrytype].anim_loop)) {
    return;
  }
  self.allow_fire = 0;

  if(!isDefined(self.momentum)) {
    self.momentum = 0;
  }

  thread fire_sound_spinup();

  for(;;) {
    if(self.momentum >= 1.0) {
      break;
    }

    self.momentum = self.momentum + 0.1;
    self.momentum = clamp(self.momentum, 0.0, 1.0);

    if(common_scripts\utility::issp()) {
      common_scripts\utility::self_func("setanim", level.sentry_settings[self.sentrytype].anim_loop, 1.0, 0.2, self.momentum);
    }

    wait 0.2;
  }

  self.allow_fire = 1;
  self notify("allow_fire");
}

delete_sentry_turret() {
  self notify("deleted");
  wait 0.05;
  self notify("death");

  if(isDefined(self.obj_overlay)) {
    self.obj_overlay delete();
  }

  if(isDefined(self.cam)) {
    self.cam delete();
  }

  self delete();
}

fire_anim_stop() {
  self notify("anim_state_change");
  self endon("anim_state_change");

  if(!isDefined(level.sentry_settings[self.sentrytype].anim_loop)) {
    return;
  }
  thread fire_sound_spindown();
  self.allow_fire = 0;

  for(;;) {
    if(!isDefined(self.momentum)) {
      break;
    }

    if(self.momentum <= 0.0) {
      break;
    }

    self.momentum = self.momentum - 0.1;
    self.momentum = clamp(self.momentum, 0.0, 1.0);

    if(common_scripts\utility::issp()) {
      common_scripts\utility::self_func("setanim", level.sentry_settings[self.sentrytype].anim_loop, 1.0, 0.2, self.momentum);
    }

    wait 0.2;
  }
}

fire_sound_spinup() {
  self notify("sound_state_change");
  self endon("sound_state_change");
  self endon("deleted");

  if(self.momentum < 0.25) {
    self playSound("sentry_minigun_spinup1");
    wait 0.6;
    self playSound("sentry_minigun_spinup2");
    wait 0.5;
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 0.5) {
    self playSound("sentry_minigun_spinup2");
    wait 0.5;
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 0.75) {
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 1) {
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  }

  thread fire_sound_spinloop();
}

fire_sound_spinloop() {
  self endon("death");
  self notify("sound_state_change");
  self endon("sound_state_change");

  for(;;) {
    self playSound("sentry_minigun_spin");
    wait 2.5;
  }
}

fire_sound_spindown() {
  self notify("sound_state_change");
  self endon("sound_state_change");
  self endon("deleted");

  if(!isDefined(self.momentum)) {
    return;
  }
  if(self.momentum > 0.75) {
    self stopsounds();
    self playSound("sentry_minigun_spindown4");
    wait 0.5;
    self playSound("sentry_minigun_spindown3");
    wait 0.5;
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else if(self.momentum > 0.5) {
    self playSound("sentry_minigun_spindown3");
    wait 0.5;
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else if(self.momentum > 0.25) {
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else {
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  }
}

sentry_beep_sounds() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(3.5, 4.5));
    thread common_scripts\utility::play_sound_in_space("sentry_gun_beep", self.origin + (0, 0, 40));
  }
}

spawn_and_place_sentry(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(isDefined(self.placingsentry)) {
    return undefined;
  }

  common_scripts\utility::_disableweapon();
  self notify("placingSentry");
  self.sentry_placement_failed = undefined;

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = spawnturret("misc_turret", var_1, level.sentry_settings[var_0].weaponinfo);
  var_4 setModel(level.sentry_settings[var_0].placementmodel);
  var_4.weaponinfo = level.sentry_settings[var_0].weaponinfo;
  var_4.targetname = level.sentry_settings[var_0].targetname;
  var_4.weaponname = level.sentry_settings[var_0].weaponinfo;
  var_4.angles = var_2;
  var_4.team = self.team;
  var_4.attacker = self;
  var_4.sentrytype = var_0;
  var_4 maketurretinoperable();
  var_4 sentrypoweroff();
  var_4 setCanDamage(0);
  var_4 sentry_set_owner(self);
  var_4 setdefaultdroppitch(-89.0);
  self.placingsentry = var_4;
  var_4 setsentrycarrier(self);
  var_4.carrier = self;
  var_4 setCanDamage(0);
  var_4.ignoreme = 1;

  if(!common_scripts\utility::issp()) {
    var_4 addtoturretlist();
  }

  if(!var_3) {
    thread sentry_placement_cancel_monitor(var_4);
    thread sentry_placement_endoflevel_cancel_monitor(var_4);
  }

  thread sentry_placement_initial_wait(var_4, var_3);

  if(!var_3) {
    thread updatesentrypositionthread(var_4);

    if(!common_scripts\utility::issp()) {
      common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled", "death");
    }
    else {
      common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
    }
  }

  sentry_placement_hint_hide();
  common_scripts\utility::_enableweapon();
  self.placingsentry = undefined;
  self setCanDamage(1);
  var_4 setsentrycarrier(undefined);
  var_4.carrier = undefined;
  var_4.ignoreme = 0;

  if(is_survival()) {
    waittillframeend;

    if(isDefined(self.sentry_placement_failed) && self.sentry_placement_failed) {
      return undefined;
    }
  }

  level.placed_sentry[level.placed_sentry.size] = var_4;
  self notify("new_sentry", var_4);
  return var_4;
}

sentry_placement_cancel_monitor(var_0) {
  self endon("sentry_placement_finished");

  if(!common_scripts\utility::issp()) {
    common_scripts\utility::waittill_any("sentry_placement_canceled", "death", "disconnect");
  }
  else {
    common_scripts\utility::waittill_any("sentry_placement_canceled");
  }

  if(is_survival()) {
    self.sentry_placement_failed = 1;
  }

  waittillframeend;
  var_0 delete();
}

sentry_placement_endoflevel_cancel_monitor(var_0) {
  self endon("sentry_placement_finished");

  if(common_scripts\utility::issp()) {
    return;
  }
  level waittill("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  if(!self.canplaceentity) {
    var_0 notify("deleted");
    waittillframeend;
    var_0 delete();
    return;
  }

  thread place_sentry(var_0);
}

sentry_restock_wait() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("restock_reset");
  self notifyonplayercommand("cancel sentry", "+actionslot 4");
  common_scripts\utility::waittill_any("death", "cancel sentry");
  self notify("sentry_placement_canceled");
}

sentry_placement_initial_wait(var_0, var_1) {
  level endon("game_ended");
  self endon("sentry_placement_canceled");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!common_scripts\utility::issp()) {
    self endon("disconnect");
    var_0 thread sentry_reset_on_owner_death();
    thread sentry_restock_wait();
  }

  if(!var_1) {
    var_0 makeunusable();

    while(self usebuttonpressed()) {
      wait 0.05;
    }

    for(;;) {
      waitactivatebutton(0);
      waitactivatebutton(1);
      updatesentryposition(var_0);

      if(self.canplaceentity) {
        break;
      }
    }
  }

  if(!common_scripts\utility::issp()) {
    self notify("restock_reset");
  }

  if(!common_scripts\utility::issp()) {
    var_0.lifeid = self.lifeid;
    sentry_team_setup(var_0);
  }

  thread common_scripts\utility::play_sound_in_space("sentry_gun_plant", var_0.origin);
  var_0 setModel(level.sentry_settings[var_0.sentrytype].model);
  var_0 sentry_init(self.team, var_0.sentrytype, self);
  self notify("sentry_placement_finished", var_0);

  if(!var_1) {
    waittillframeend;
  }

  if(isDefined(level.sentry_ammo_enabled) && level.sentry_ammo_enabled) {
    var_0 thread sentry_die_on_ammoout();
  }

  if(!common_scripts\utility::issp()) {
    var_0 thread sentry_die_on_batteryout();
  }
}

updatesentrypositionthread(var_0) {
  level endon("game_ended");
  var_0 notify("sentry_placement_started");
  self endon("sentry_placement_canceled");
  self endon("sentry_placement_finished");
  var_0 endon("death");
  var_0 endon("deleted");

  if(!common_scripts\utility::issp()) {
    self endon("disconnect");
    self endon("death");
  }

  for(;;) {
    updatesentryposition(var_0);
    wait 0.05;
  }
}

updatesentryposition(var_0) {
  if(isDefined(level.custom_sentry_position_func)) {
    [[level.custom_sentry_position_func]](var_0);
  }
  else {
    var_1 = self canplayerplacesentry();
    var_0.origin = var_1["origin"];
    var_0.angles = var_1["angles"];
    self.canplaceentity = self isonground() && var_1["result"];
    sentry_placement_hint_show(self.canplaceentity);

    if(self.canplaceentity) {
      var_0 setModel(level.sentry_settings[var_0.sentrytype].placementmodel);
      return;
    }

    var_0 setModel(level.sentry_settings[var_0.sentrytype].placementmodelfail);
  }
}

sentry_placement_hint_show(var_0) {
  if(isDefined(self.forced_hint) && self.forced_hint == var_0) {
    return;
  }
  self.forced_hint = var_0;

  if(self.forced_hint) {
    self forceusehinton(&"SENTRY_PLACE");
  }
  else {
    self forceusehinton(&"SENTRY_CANNOT_PLACE");
  }
}

sentry_placement_hint_hide() {
  if(!isDefined(self.forced_hint)) {
    return;
  }
  self forceusehintoff();
  self.forced_hint = undefined;
}

folded_sentry_use_wait(var_0) {
  self.obj_overlay = spawn("script_model", self.origin);
  self.obj_overlay.angles = self.angles;
  self.obj_overlay setModel(level.sentry_settings[var_0].pickupmodelobj);

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_1.placingsentry)) {
      continue;
    }
    if(!common_scripts\utility::issp()) {
      if(var_1 != self.owner) {
        continue;
      }
    }

    break;
  }

  self.obj_overlay delete();
  self delete();
  var_1 thread spawn_and_place_sentry(var_0);
}

sentry_health_monitor() {
  self.healthbuffer = 20000;
  self.health = self.health + self.healthbuffer;
  self.currenthealth = self.health;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;
  var_4 = gettime();

  while(self.health > 0) {
    self waittill("damage", var_5, var_0, var_6, var_7, var_1, var_8, var_9);

    if(isDefined(var_0) && !isplayer(var_0)) {
      var_2 = var_2 + var_5;
      var_3 = var_3 + (gettime() - var_4);
      var_4 = gettime();

      if(var_3 < 3000 && var_2 > 300) {
        var_10 = 0;

        foreach(var_12 in level.players) {
          if(distancesquared(var_12.origin, self.origin) <= squared(500)) {
            var_10 = 1;
          }
        }

        if(!var_10) {
          level notify("a_sentry_is_underattack");
        }

        var_2 = 0;
        var_3 = 0;
      }

      if(var_3 >= 3000) {
        var_2 = 0;
        var_3 = 0;
      }
    }

    if(!common_scripts\utility::issp() && isDefined(var_0) && isplayer(var_0) && var_0 sentry_attacker_is_friendly(self)) {
      self.health = self.currenthealth;
      return;
    }

    if(isDefined(level.stat_track_damage_func) && isDefined(var_0)) {
      var_0[[level.stat_track_damage_func]]();
    }

    if(isDefined(var_0) && isplayer(var_0)) {
      if(!common_scripts\utility::issp()) {
        var_0[[level.func["damagefeedback"]]]("false");
      }
      else if(is_specialop()) {
        var_0[[level.func["damagefeedback"]]](self);
      }

      thread sentry_allowfire(0, 2.0);
    }

    if(sentry_hit_bullet_armor(var_1, var_0)) {
      self.health = self.currenthealth;
      self.bullet_armor = self.bullet_armor - var_5;
    } else
      self.currenthealth = self.health;

    if(self.health < self.healthbuffer) {
      break;
    }
  }

  if(!common_scripts\utility::issp() && var_0 sentry_attacker_can_get_xp(self)) {
    var_0 thread[[level.onxpevent]]("kill");
  }

  self notify("death", var_0, var_1);
}

sentry_hit_bullet_armor(var_0, var_1) {
  if(isDefined(var_1) && isai(var_1) && isDefined(var_1.juggernaut) && var_1.juggernaut) {
    return 0;
  }

  if(self.bullet_armor <= 0) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!issubstr(var_0, "BULLET")) {
    return 0;
  }
  else {
    return 1;
  }
}

enemy_sentry_difficulty_settings() {
  var_0 = "easy";
  self setconvergencetime(level.sentryturretsettings[var_0]["convergencePitchTime"], "pitch");
  self setconvergencetime(level.sentryturretsettings[var_0]["convergenceYawTime"], "yaw");
  self setsuppressiontime(level.sentryturretsettings[var_0]["suppressionTime"]);
  self setaispread(level.sentryturretsettings[var_0]["aiSpread"]);
  self setplayerspread(level.sentryturretsettings[var_0]["playerSpread"]);
  self.maxrange = 1100;
  self.bullet_armor = 0;
}

waitactivatebutton(var_0) {
  if(!common_scripts\utility::issp()) {
    self endon("death");
    self endon("disconnect");
  }

  if(var_0 == 1) {
    while(!self attackbuttonpressed() && !self usebuttonpressed()) {
      wait 0.05;
    }
  } else if(var_0 == 0) {
    while(self attackbuttonpressed() || self usebuttonpressed()) {
      wait 0.05;
    }
  }
}

makesentrysolid() {
  self maketurretsolid();
}

makesentrynotsolid() {
  self.contents = self setcontents(0);
}

sentrypoweron() {
  if(!issentient(self) && isDefined(self.owner) && isDefined(self.owner.team)) {
    self call[[level.makeentitysentient_func]](self.owner.team);
  }

  self setmode("sentry");
  self.battery_usage = 1;
}

sentrypoweroff() {
  if(issentient(self)) {
    self call[[level.freeentitysentient_func]]();
  }

  self setmode("sentry_offline");
  self.battery_usage = 0;
}

sentry_team_setup(var_0) {
  if(isDefined(self.pers["team"])) {
    var_0.pers["team"] = self.pers["team"];
  }

  var_0 sentry_team_show_icon();
}

sentry_team_show_icon() {
  var_0 = (0, 0, 65);

  if(self.sentrytype == "sentry_gun") {
    var_0 = (0, 0, 75);
  }

  self[[level.func["setTeamHeadIcon"]]](self.pers["team"], var_0);
}

sentry_team_hide_icon() {
  self[[level.func["setTeamHeadIcon"]]]("none", (0, 0, 0));
}

sentry_place_mode_reset() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier notify("sentry_placement_canceled");
  self.carrier common_scripts\utility::_enableweapon();
  self.carrier.placingsentry = undefined;
  self setsentrycarrier(undefined);
  self.carrier = undefined;
  self setCanDamage(1);
  self.ignoreme = 0;
}

sentry_set_owner(var_0) {
  if(isDefined(self.owner) && self.owner == var_0) {
    return;
  }
  var_0.debug_sentry = self;
  self.owner = var_0;
  self setsentryowner(var_0);
  self setturretminimapvisible(1);
}

sentry_destroy_on_owner_leave(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

sentry_die_on_batteryout() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self notify("battery_count_started");
  self endon("battery_count_started");

  while(self.sentry_battery_timer >= 0) {
    if(self.battery_usage) {
      self.sentry_battery_timer = self.sentry_battery_timer - 1;
    }

    wait 1;
  }

  self notify("death");
}

sentry_die_on_ammoout() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self notify("ammo_count_started");
  self endon("ammo_count_started");
  thread sentry_ammo_debug();

  while(self.sentry_ammo >= 0) {
    self waittill("bullet_fired");
    self.sentry_ammo = self.sentry_ammo - 1;
  }

  thread sentry_burst_fire_stop();
  thread sentry_turn_laser_off();
  wait 1;
  sentrypoweroff();
  wait 5;
  self notify("death");
}

sentry_ammo_debug() {
  self endon("death");

  for(;;) {
    var_0 = level.sentry_settings[self.sentrytype].ammo;
    var_1 = self.sentry_ammo;
    var_2 = var_1 / var_0;
    var_3 = "Ammo: " + var_1 + "/" + var_0;
    var_4 = level.sentry_settings[self.sentrytype].health;
    var_5 = self.health - self.healthbuffer;
    var_6 = var_5 / var_4;
    var_7 = "Health: " + var_5 + "/" + var_4;
    wait 0.05;
  }
}

removedeadsentry() {
  if(isDefined(self.keep_after_death) && self.keep_after_death) {
    return;
  }
  delete_sentry_turret();
}

sentry_reset_on_owner_death() {
  self endon("death");
  self endon("deleted");
  self.owner common_scripts\utility::waittill_any("death", "disconnect");

  if(isDefined(self.owner.placingsentry) && self.owner.placingsentry == self) {
    self.owner.placingsentry = undefined;
    self setsentrycarrier(undefined);
    self.carrier = undefined;
    self setCanDamage(1);
    self.ignoreme = 0;
    self notify("death");
  }
}

sentry_attacker_can_get_xp(var_0) {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isplayer(self)) {
    return 0;
  }

  if(!isDefined(level.onxpevent)) {
    return 0;
  }

  if(!isDefined(self.pers["team"])) {
    return 0;
  }

  if(!isDefined(var_0.team)) {
    return 0;
  }

  if(!level.teambased && self == var_0.owner) {
    return 0;
  }

  if(level.teambased && self.pers["team"] == var_0.team) {
    return 0;
  }

  return 1;
}

sentry_attacker_is_friendly(var_0) {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isplayer(self)) {
    return 0;
  }

  if(!level.teambased) {
    return 0;
  }

  if(self == var_0.owner) {
    return 0;
  }

  if(self.team != var_0.team) {
    return 0;
  }

  return 1;
}

sentry_emp_damage_wait() {
  self endon("deleted");
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    thread sentry_burst_fire_stop();
    thread sentry_turn_laser_off();
    sentrypoweroff();
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");
    wait(var_1);
    sentrypoweron();
  }
}

sentry_emp_wait() {
  self endon("deleted");
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(level.teamemped[self.team]) {
      thread sentry_burst_fire_stop();
      thread sentry_turn_laser_off();
      sentrypoweroff();
      playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");
      continue;
    }

    sentrypoweron();
  }
}

addtoturretlist() {
  level.turrets[self getentitynumber()] = self;
}

removefromturretlist() {
  level.turrets[self getentitynumber()] = undefined;
}

dual_waittill(var_0, var_1, var_2, var_3) {
  var_0 endon(var_1);
  var_2 endon(var_3);
  level waittill("hell_freezes_over_AND_THEN_thaws_out");
}

sentry_turn_laser_on() {
  if(!level.sentry_settings[self.sentrytype].use_laser) {
    return;
  }
  if(!isDefined(level.laseron_func)) {
    return;
  }
  self call[[level.laseron_func]]();
}

sentry_turn_laser_off() {
  if(!level.sentry_settings[self.sentrytype].use_laser) {
    return;
  }
  if(!isDefined(level.laseroff_func)) {
    return;
  }
  self call[[level.laseroff_func]]();
}

is_specialop() {
  return getdvarint("specialops") >= 1;
}

is_survival() {
  return is_specialop() && getdvarint("so_survival") > 0;
}