/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_chopper_player_missile_defense.gsc
***************************************************************/

_precache() {
  precachemodel("angel_flare_rig");
  precacheshader("heli_warning_missile_red");
  precacheshader("apache_flare_back");
  precacheshader("apache_ammo");
  precacheshader("apache_warn_incoming_left");
  precacheshader("apache_warn_incoming_right");
  precacheshader("apache_warn_lock_left");
  precacheshader("apache_warn_lock_right");
  precachestring(&"CHOPPERHUD_ENEMY_LOCK");
  precachestring(&"CHOPPERHUD_INCOMING");
  _fx();
  flare_rig_anims();
  evad_anims();
}

_fx() {
  level._effect["FX_chopper_flare"] = loadfx("fx/_requests/apache/apache_flare");
  level._effect["FX_chopper_flare_explosion"] = loadfx("fx/_requests/apache/apache_trophy_explosion");
}

#using_animtree("vehicles");

evad_anims() {
  maps\_anim::create_anim_scene(#animtree, "apache_evade_right", % apache_break_r, "generic");
  maps\_anim::create_anim_scene(#animtree, "apache_evade_left", % apache_break_l, "generic");
  maps\_anim::create_anim_scene(#animtree, "battlehind_evade_right", % battlehind_break_r, "generic");
  maps\_anim::create_anim_scene(#animtree, "battlehind_evade_left", % battlehind_break_l, "generic");
}

#using_animtree("script_model");

flare_rig_anims() {
  level.scr_animtree["flare_rig"] = #animtree;
  level.scr_model["flare_rig"] = "angel_flare_rig";
  level.scr_anim["flare_rig"]["flare"][0] = % ac130_angel_flares01;
  level.scr_anim["flare_rig"]["flare"][1] = % ac130_angel_flares02;
}

_init(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = var_1;
  var_3.vehicle = var_0;
  var_3.vehicle.missile_defense = var_3;
  var_3.type = "missile_defense";
  var_3.lockedontome = [];
  var_3.firedonme = [];
  var_3.flareindex = 0;
  var_3.flares = [];
  var_3.flarenumpairs = 2;
  var_3.flarecooldown = common_scripts\utility::ter_op(var_2, 5, 1);
  var_3.flarereloadtime = 8.0;
  var_3.flareactiveradius = 4000;
  var_3.flarefx = common_scripts\utility::getfx("FX_chopper_flare");
  var_3.flarefxexplode = common_scripts\utility::getfx("FX_chopper_flare_explosion");
  var_3.missiletargetflareradius = 2000;
  var_3.flaredestroymissileradius = 192;
  var_3.flarespawnmaxpitchoffset = 20;
  var_3.flarespawnminpitchoffset = 10;
  var_3.flarespawnmaxyawoffset = 80;
  var_3.flarespawnminyawoffset = 55;
  var_3.flarespawnoffsetright = 104;
  var_3.flarerig_name = "flare_rig";
  var_3.flarerig_animrate = 3;
  var_3.flarerig_link = 1;
  var_3.flarerig_tagorigin = undefined;
  var_3.flarerig_tagangles = undefined;
  var_3.flaresound = "chopper_flare_fire";
  var_3.targeting = var_0.heli.targeting;
  var_3.hud_currentstate = "none";
  var_3.hud_laststate = "none";
  var_3.flareauto = var_2;
  var_3 hud_init();
  return var_3;
}

hud_init() {
  var_0 = self.owner;
  var_1 = self.vehicle.heli.pilot.hud;
  var_2 = [];
  var_2["warning"] = [];
  var_2["warning"]["bg_lock_left"] = var_0 maps\_hud_util::createclienticon("apache_warn_lock_left", 128, 128);
  var_2["warning"]["bg_lock_left"] maps\_hud_util::setpoint("CENTER", "CENTER", -185, 0);
  var_2["warning"]["bg_lock_left"].alpha = 1.0;
  var_2["warning"]["bg_lock_right"] = var_0 maps\_hud_util::createclienticon("apache_warn_lock_right", 128, 128);
  var_2["warning"]["bg_lock_right"] maps\_hud_util::setpoint("CENTER", "CENTER", 185, 0);
  var_2["warning"]["bg_lock_right"].alpha = 1.0;
  var_2["warning"]["bg_inc_left"] = var_0 maps\_hud_util::createclienticon("apache_warn_incoming_left", 128, 128);
  var_2["warning"]["bg_inc_left"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_2["warning"]["bg_inc_left"].alpha = 1.0;
  var_2["warning"]["bg_inc_left"] maps\_hud_util::setparent(var_2["warning"]["bg_lock_left"]);
  var_2["warning"]["bg_inc_right"] = var_0 maps\_hud_util::createclienticon("apache_warn_incoming_right", 128, 128);
  var_2["warning"]["bg_inc_right"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_2["warning"]["bg_inc_right"].alpha = 1.0;
  var_2["warning"]["bg_inc_right"] maps\_hud_util::setparent(var_2["warning"]["bg_lock_right"]);
  var_2["warning"]["msg_left"] = var_0 maps\_hud_util::createclientfontstring("objective", 0.8);
  var_2["warning"]["msg_left"] maps\_hud_util::setpoint("CENTER", "CENTER", 4, 0);
  var_2["warning"]["msg_left"] settext(&"CHOPPERHUD_ENEMY_LOCK");
  var_2["warning"]["msg_left"].alpha = 0.0;
  var_2["warning"]["msg_left"] maps\_hud_util::setparent(var_2["warning"]["bg_lock_left"]);
  var_2["warning"]["msg_right"] = var_0 maps\_hud_util::createclientfontstring("objective", 0.8);
  var_2["warning"]["msg_right"] maps\_hud_util::setpoint("CENTER", "CENTER", -4, 0);
  var_2["warning"]["msg_right"] settext(&"CHOPPERHUD_ENEMY_LOCK");
  var_2["warning"]["msg_right"].alpha = 0.0;
  var_2["warning"]["msg_right"] maps\_hud_util::setparent(var_2["warning"]["bg_lock_right"]);
  var_3 = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, -180, -90);
  var_2["flares"] = [];
  var_2["flares"]["back"] = var_0 maps\_hud_util::createclienticon("apache_flare_back", 64, 32);
  var_2["flares"]["back"] maps\_hud_util::setpoint("CENTER", "CENTER", var_3, 76);
  var_2["flares"]["back"].alpha = 1.0;
  var_2["flares"]["ammo"] = [];

  for(var_4 = 0; var_4 < 2; var_4++) {
    var_5 = var_0 maps\_hud_util::createclienticon("apache_ammo", 16, 16);
    var_5 maps\_hud_util::setpoint("RIGHT", "CENTER", 20, -4 + var_4 * 8);
    var_5.alpha = 1.0;
    var_5.isavailable = 1;
    var_5 maps\_hud_util::setparent(var_2["flares"]["back"]);
    var_2["flares"]["ammo"][var_4] = var_5;
  }

  self.hud = var_2;
}

hud_update() {
  var_0 = self.vehicle.heli;

  if(var_0 maps\_utility::ent_flag("FLAG_pilot_active")) {
    switch (self.hud_currentstate) {
      case "none":
        self.hud["warning"]["msg_left"].alpha = 0.0;
        self.hud["warning"]["msg_right"].alpha = 0.0;
        self.hud["warning"]["bg_lock_left"].alpha = 0.0;
        self.hud["warning"]["bg_lock_right"].alpha = 0.0;
        self.hud["warning"]["bg_inc_left"].alpha = 0.0;
        self.hud["warning"]["bg_inc_right"].alpha = 0.0;
        break;
      case "warning":
      case "incoming":
        self.hud["warning"]["msg_left"].alpha = 1.0;
        self.hud["warning"]["msg_right"].alpha = 1.0;

        if(self.hud_currentstate == "warning") {
          self.hud["warning"]["bg_lock_left"].alpha = 1.0;
          self.hud["warning"]["bg_lock_right"].alpha = 1.0;
          self.hud["warning"]["bg_inc_left"].alpha = 0.0;
          self.hud["warning"]["bg_inc_right"].alpha = 0.0;
        } else {
          self.hud["warning"]["bg_lock_left"].alpha = 0.0;
          self.hud["warning"]["bg_lock_right"].alpha = 0.0;
          self.hud["warning"]["bg_inc_left"].alpha = 1.0;
          self.hud["warning"]["bg_inc_right"].alpha = 1.0;
        }

        break;
    }
  }
}

_start() {
  var_0 = self.owner;
  var_0 endon("LISTEN_end_missile_defense");
  hud_start();
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorenemymissilelockon(::hud_enemy_missile_lockon);
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorenemymissilefire();

  if(!isDefined(self.flareauto) || self.flareauto) {
    childthread vehicle_scripts\_chopper_missile_defense_utility::monitorflarerelease_auto(::hud_makeused_flares, ::hud_makefree_flares);
  } else {
    childthread vehicle_scripts\_chopper_missile_defense_utility::monitorflarerelease_input(::hud_makeused_flares, ::hud_makefree_flares);
  }

  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorflares();
  childthread monitorstateshud();
}

hud_start() {
  var_0 = self.vehicle.heli;

  if(var_0 maps\_utility::ent_flag("FLAG_pilot_active")) {
    self.hud["warning"]["msg_left"].alpha = 0.0;
    self.hud["warning"]["msg_right"].alpha = 0.0;
    self.hud["warning"]["bg_lock_left"].alpha = 0.0;
    self.hud["warning"]["bg_lock_right"].alpha = 0.0;
    self.hud["warning"]["bg_inc_left"].alpha = 0.0;
    self.hud["warning"]["bg_inc_right"].alpha = 0.0;
    self.hud["warning"]["msg_right"].alpha = 0.0;
  }
}

monitorstateshud() {
  var_0 = self.owner;

  for(;;) {
    waittillframeend;

    if(vehicle_scripts\_chopper_missile_defense_utility::isanymissilefiredonme()) {
      self.hud_currentstate = "incoming";
    } else if(vehicle_scripts\_chopper_missile_defense_utility::isanyenemylockedontome() && !vehicle_scripts\_chopper_missile_defense_utility::isanymissilefiredonme()) {
      self.hud_currentstate = "warning";
    } else {
      self.hud_currentstate = "none";
    }

    if(self.hud_currentstate != self.hud_laststate) {
      if(self.hud_laststate == "warning") {
        var_0 common_scripts\utility::stop_loop_sound_on_entity("missile_locking");
      } else if(self.hud_laststate == "incoming") {
        var_0 common_scripts\utility::stop_loop_sound_on_entity("missile_incoming");
      }

      if(self.hud_currentstate == "none") {
        if(self.hud_laststate == "warning") {
          var_0 thread maps\_utility::play_sound_on_entity("missile_locking_failed");
        }

        hud_turnoffmissilewarning();
      }

      if(self.hud_currentstate == "warning") {
        var_0 thread common_scripts\utility::play_loop_sound_on_entity("missile_locking");
        hud_missile_warning();
      } else if(self.hud_currentstate == "incoming") {
        var_0 thread common_scripts\utility::play_loop_sound_on_entity("missile_incoming");
        hud_missile_incoming();
      }
    }

    self.hud_laststate = self.hud_currentstate;
    wait 0.05;
  }
}

hud_enemy_missile_lockon(var_0) {
  var_1 = self.owner;
  var_0 common_scripts\utility::waittill_any("death", "deathspin", "LISTEN_missile_fire_self", "LISTEN_missile_lockOnFailed");
  self.lockedontome = common_scripts\utility::array_removeundefined(self.lockedontome);

  if(isDefined(var_0)) {
    self.lockedontome = common_scripts\utility::array_remove(self.lockedontome, var_0);
  }
}

hud_buttonhelp(var_0, var_1) {
  self endon("death");

  for(;;) {
    var_0.alpha = 0;
    var_1.alpha = 1;
    wait 0.15;
    var_0.alpha = 1;
    var_1.alpha = 0;
    wait 0.15;
  }
}

hud_flashalpha(var_0, var_1, var_2) {
  self endon("death");
  self.alpha = var_0;

  for(;;) {
    self fadeovertime(var_1);
    self.alpha = 0;
    wait(var_1);

    if(isDefined(var_2) && var_2 > 0) {
      wait(var_2);
    }

    self fadeovertime(var_1);
    self.alpha = var_0;
    wait(var_1);
  }
}

hud_missile_warning() {
  var_0 = self.vehicle.heli;

  if(var_0 maps\_utility::ent_flag("FLAG_pilot_active")) {
    self.hud["warning"]["msg_left"] settext(&"CHOPPERHUD_ENEMY_LOCK");
    self.hud["warning"]["msg_left"].color = (1, 1, 1);
    self.hud["warning"]["msg_right"] settext(&"CHOPPERHUD_ENEMY_LOCK");
    self.hud["warning"]["msg_right"].color = (1, 1, 1);
    self.hud["warning"]["msg_left"].alpha = 1.0;
    self.hud["warning"]["msg_right"].alpha = 1.0;
    self.hud["warning"]["bg_lock_left"].alpha = 1.0;
    self.hud["warning"]["bg_lock_right"].alpha = 1.0;
    self.hud["warning"]["bg_inc_left"].alpha = 0.0;
    self.hud["warning"]["bg_inc_right"].alpha = 0.0;
  }
}

hud_missile_incoming() {
  var_0 = self.vehicle.heli;

  if(var_0 maps\_utility::ent_flag("FLAG_pilot_active")) {
    self.hud["warning"]["msg_left"] settext(&"CHOPPERHUD_INCOMING");
    self.hud["warning"]["msg_left"].color = (1, 1, 1);
    self.hud["warning"]["msg_right"] settext(&"CHOPPERHUD_INCOMING");
    self.hud["warning"]["msg_right"].color = (1, 1, 1);
    self.hud["warning"]["msg_left"].alpha = 1.0;
    self.hud["warning"]["msg_right"].alpha = 1.0;
    self.hud["warning"]["bg_lock_left"].alpha = 0.0;
    self.hud["warning"]["bg_lock_right"].alpha = 0.0;
    self.hud["warning"]["bg_inc_left"].alpha = 1.0;
    self.hud["warning"]["bg_inc_right"].alpha = 1.0;
  }
}

hud_turnoffmissilewarning() {
  var_0 = self.vehicle.heli;

  if(var_0 maps\_utility::ent_flag("FLAG_pilot_active")) {
    self.hud["warning"]["msg_left"].alpha = 0.0;
    self.hud["warning"]["msg_right"].alpha = 0.0;
    self.hud["warning"]["bg_lock_left"].alpha = 0.0;
    self.hud["warning"]["bg_lock_right"].alpha = 0.0;
    self.hud["warning"]["bg_inc_left"].alpha = 0.0;
    self.hud["warning"]["bg_inc_right"].alpha = 0.0;
    self.hud["warning"]["msg_right"].alpha = 0.0;
  }
}

hud_makeused_flares() {
  var_0 = hud_countfree_flares();
  var_1 = var_0 > 0;

  if(var_1) {
    var_0--;
    hud_updateammo_flares(var_0);
  }

  return var_1;
}

hud_makefree_flares(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  var_1 = hud_countfree_flares();
  var_2 = var_1 < 2;

  if(var_2) {
    var_1++;
    hud_updateammo_flares(var_1);
  }

  return var_2;
}

hud_updateammo_flares(var_0) {
  foreach(var_3, var_2 in self.hud["flares"]["ammo"]) {
    if(var_3 + 1 <= var_0) {
      var_2.isavailable = 1;
      var_2.alpha = 1.0;
      continue;
    }

    var_2.isavailable = 0;
    var_2.alpha = 0.0;
  }
}

hud_countfree_flares() {
  var_0 = 0;

  foreach(var_2 in self.hud["flares"]["ammo"]) {
    if(var_2.isavailable) {
      var_0++;
    }
  }

  return var_0;
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_missile_defense");
  common_scripts\utility::array_thread(self.hud, ::set_key, [0, "alpha"]);
  var_0 common_scripts\utility::stop_loop_sound_on_entity("missile_locking");
  var_0 common_scripts\utility::stop_loop_sound_on_entity("missile_incoming");
}

set_key(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "alpha":
      self.alpha = var_0;
      break;
  }
}

_destroy() {
  _end();
  self.vehicle.missile_defense = undefined;
  maps\_utility::deep_array_call(self.hud, ::destroy);
}