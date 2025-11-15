/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2668.gsc
***************************************/

init() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level.sentrysettings = [];
  level.sentrysettings["crafted_autosentry"] = spawnStruct();
  level.sentrysettings["crafted_autosentry"].health = 999999;
  level.sentrysettings["crafted_autosentry"].maxhealth = 300;
  level.sentrysettings["crafted_autosentry"].burstmin = 20;
  level.sentrysettings["crafted_autosentry"].burstmax = 40;
  level.sentrysettings["crafted_autosentry"].pausemin = 0.15;
  level.sentrysettings["crafted_autosentry"].pausemax = 0.25;
  level.sentrysettings["crafted_autosentry"].sentrymodeon = "sentry";
  level.sentrysettings["crafted_autosentry"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["crafted_autosentry"].timeout = 90.0;
  level.sentrysettings["crafted_autosentry"].spinuptime = 1.0;
  level.sentrysettings["crafted_autosentry"].overheattime = 15.0;
  level.sentrysettings["crafted_autosentry"].cooldowntime = 0.2;
  level.sentrysettings["crafted_autosentry"].fxtime = 0.3;
  level.sentrysettings["crafted_autosentry"].weaponinfo = "alien_sentry_minigun_4_mp";
  level.sentrysettings["crafted_autosentry"].modelbase = "weapon_sentry_chaingun";
  level.sentrysettings["crafted_autosentry"].modelplacement = "weapon_sentry_chaingun";
  level.sentrysettings["crafted_autosentry"].modelplacementfailed = "weapon_sentry_chaingun_obj_red";
  level.sentrysettings["crafted_autosentry"].modeldestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrysettings["crafted_autosentry"].hintstring = & "COOP_CRAFTABLES_PICKUP";
  level.sentrysettings["crafted_autosentry"].headicon = 1;
  level.sentrysettings["crafted_autosentry"].vodestroyed = "sentry_destroyed";
  level.sentrysettings["crafted_autosentry"].func_9F43 = 0;
}

give_crafted_sentry(var_00, var_01) {
  var_01 thread watch_dpad();
  var_01 notify("new_power", "crafted_autosentry");
  var_01 setclientomnvar("zom_crafted_weapon", 1);
  var_01 thread scripts\cp\utility::usegrenadegesture(var_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", ::give_crafted_sentry, var_01);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 3");

  for(;;) {
    self waittill("pullout_sentry");

    if(scripts\engine\utility::is_true(self.iscarrying)) {
      continue;
    }
    if(scripts\engine\utility::is_true(self.linked_to_coaster)) {
      continue;
    }
    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }
    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread givesentry("crafted_autosentry");
}

givesentry(var_00) {
  self endon("disconnect");
  self.last_sentry = var_00;
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = createsentryforplayer(var_00, self);
  self.itemtype = var_00;
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var_01;
  var_02 = setcarryingsentry(var_01, 1);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;

  if(isDefined(var_01))
    return 1;
  else
    return 0;
}

setcarryingsentry(var_00, var_01) {
  self endon("disconnect");
  var_00 sentry_setcarried(self, var_01);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_sentry", "+attack");
  self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_sentry", "+actionslot 3");

  if(!level.console) {
    self notifyonplayercommand("cancel_sentry", "+actionslot 5");
    self notifyonplayercommand("cancel_sentry", "+actionslot 6");
    self notifyonplayercommand("cancel_sentry", "+actionslot 7");
  }

  for(;;) {
    var_02 = scripts\engine\utility::waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement");

    if(!isDefined(var_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_02))
      var_02 = "force_cancel_placement";

    if(var_02 == "cancel_sentry" || var_02 == "force_cancel_placement") {
      if(!var_01 && var_02 == "cancel_sentry") {
        continue;
      }
      scripts\engine\utility::allow_weapon(1);
      var_00 sentry_setcancelled();

      if(var_02 != "force_cancel_placement")
        thread watch_dpad();
      else if(var_01)
        scripts\cp\utility::remove_crafted_item_from_inventory(self);

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    if(var_01)
      scripts\cp\utility::remove_crafted_item_from_inventory(self);

    var_00 sentry_setplaced();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

createsentryforplayer(var_00, var_01) {
  var_02 = spawnturret("misc_turret", var_1.origin, level.sentrysettings[var_00].weaponinfo);
  var_2.angles = var_1.angles;
  var_2.name = "crafted_autosentry";
  var_02 sentry_initsentry(var_00, var_01);
  return var_02;
}

sentry_initsentry(var_00, var_01) {
  self.sentrytype = var_00;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[self.sentrytype].modelbase);
  self.shouldsplash = 1;
  self setCanDamage(1);

  switch (var_00) {
    case "crafted_autosentry":
    default:
      self maketurretinoperable();
      self setleftarc(100);
      self setrightarc(100);
      self give_crafted_gascan(90);
      self settoparc(60);
      self _meth_82C9(0.3, "pitch");
      self _meth_82C9(0.3, "yaw");
      self _meth_82C8(0.65);
      self setdefaultdroppitch(-89.0);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var_01);
  thread sentry_handledeath(var_01);
  thread scripts\cp\utility::item_timeout(undefined, level.sentrysettings[self.sentrytype].timeout);
  thread sentry_handleuse();
  thread sentry_attacktargets();
  thread sentry_beepsounds();
}

sentry_handledeath(var_00) {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  sentry_setinactive();
  self setdefaultdroppitch(40);

  if(isDefined(self.carriedby))
    self setsentrycarrier(undefined);

  self setsentryowner(undefined);
  self playSound("sentry_explode");

  if(isDefined(self))
    thread func_F23F();
}

func_F23F() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");

  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    self _meth_83D3(self.inuseby);
    wait 1.0;
  } else {
    wait 1.5;
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    wait 0.1;
    self notify("deleting");
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self))
    self delete();
}

sentry_handleuse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_00);

    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_0.iscarrying)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_0.kung_fu_mode)) {
      continue;
    }
    var_00 setcarryingsentry(self, 0);
  }
}

sentry_setowner(var_00) {
  var_0.func_4BAE = self;
  self.owner = var_00;
  self setsentryowner(self.owner);
  self.team = self.owner.team;
  self setturretteam(self.team);
  thread scripts\cp\utility::item_handleownerdisconnect("sentry_handleOwner");
}

sentry_setplaced() {
  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getspawnpoint_safeguard() == "manual")
    self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);

  self setsentrycarrier(undefined);
  sentry_makesolid();
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;

    if(level.sentrysettings[self.sentrytype].func_9F43)
      scripts\cp\utility::make_entity_sentient_cp(self.owner.team);

    self.owner notify("new_sentry", self);
  }

  sentry_setactive();
  self playSound("sentry_gun_plant");
  self laseron();
  self notify("placed");
}

sentry_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner))
    self.owner.iscarrying = 0;

  self delete();
}

sentry_setcarried(var_00, var_01) {
  self setModel(level.sentrysettings[self.sentrytype].modelplacement);
  self setsentrycarrier(var_00);
  self setCanDamage(0);
  self laseroff();
  sentry_makenotsolid();
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread updatesentryplacement(self, var_01);
  thread scripts\cp\utility::item_oncarrierdeath(var_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_00);
  thread scripts\cp\utility::item_ongameended(var_00);
  self freeentitysentient();
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();
  self notify("carried");
}

updatesentryplacement(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_02 = -1;

  for(;;) {
    var_0.canbeplaced = func_3834(var_00);

    if(var_0.canbeplaced != var_02) {
      if(var_0.canbeplaced) {
        var_00 setModel(level.sentrysettings[var_0.sentrytype].modelplacement);

        if(!var_01)
          self forceusehinton( & "COOP_CRAFTABLES_PLACE");
        else
          self forceusehinton( & "COOP_CRAFTABLES_PLACE_CANCELABLE");
      } else {
        var_00 setModel(level.sentrysettings[var_0.sentrytype].modelplacementfailed);
        self forceusehinton( & "COOP_CRAFTABLES_CANNOT_PLACE");
      }
    }

    var_02 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_3834(var_00) {
  var_01 = self canplayerplacesentry();
  var_0.origin = var_1["origin"];
  var_0.angles = var_1["angles"];

  if(scripts\cp\utility::ent_is_near_equipment(var_00))
    return 0;

  return self isonground() && var_1["result"] && abs(var_0.origin[2] - self.origin[2]) < 10;
}

sentry_setactive() {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
  self makeusable();
  self setusefov(120);
  self setuserange(96);

  foreach(var_01 in level.players) {
    switch (self.sentrytype) {
      case "crafted_autosentry":
        var_02 = self getentitynumber();
        func_1862(var_02, var_01);
        break;
    }
  }
}

sentry_setinactive() {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  var_00 = self getentitynumber();
  func_E11F(var_00);
}

sentry_makesolid() {
  self getvalidlocation();
}

sentry_makenotsolid() {
  self setcontents(0);
}

func_1862(var_00, var_01) {
  level.turrets = scripts\engine\utility::add_to_array(level.turrets, self);

  if(level.turrets.size > 4) {
    if(isDefined(level.turrets[0])) {
      level.turrets[0] notify("death");
      var_01 playlocalsound("ww_magicbox_laughter");
    }
  }
}

func_E11F(var_00) {
  level.turrets = scripts\engine\utility::array_remove(level.turrets, self);
}

sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self getteamarray()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_01 = level.sentrysettings[self.sentrytype].burstmin;
  var_02 = level.sentrysettings[self.sentrytype].burstmax;
  var_03 = level.sentrysettings[self.sentrytype].pausemin;
  var_04 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_05 = randomintrange(var_01, var_02 + 1);

    for(var_06 = 0; var_06 < var_05 && !self.overheated; var_6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + var_00;
      wait(var_00);
    }

    wait(randomfloatrange(var_03, var_04));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

turret_shotmonitor(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("player_dismount");
  var_01 = weaponfiretime(level.sentrysettings[var_0.sentrytype].weaponinfo);

  for(;;) {
    var_00 waittill("turret_fire");
    var_00 _meth_8165() notify("turret_fire");
    var_0.heatlevel = var_0.heatlevel + var_01;
    var_0.cooldownwaittime = var_01;
  }
}

sentry_heatmonitor() {
  self endon("death");
  var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_01 = 0;
  var_02 = 0;
  var_03 = level.sentrysettings[self.sentrytype].overheattime;
  var_04 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_01)
      wait(var_00);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > var_03) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "crafted_autosentry":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - 0.1);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_01 = self.heatlevel;
    wait 0.05;
  }
}

turret_heatmonitor() {
  self endon("death");
  var_00 = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > var_00) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "gl_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

turret_coolmonitor() {
  self endon("death");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

playsmokefx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("sentry_gun_beep");
  }
}