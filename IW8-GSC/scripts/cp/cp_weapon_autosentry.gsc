/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapon_autosentry.gsc
***********************************************/

function init() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level.sentrysettings["crafted_autosentry"] = spawnStruct();
  level.sentrysettings["crafted_autosentry"].health = 999999;
  level.sentrysettings["crafted_autosentry"].maxhealth = 300;
  level.sentrysettings["crafted_autosentry"].burstmin = 5;
  level.sentrysettings["crafted_autosentry"].burstmax = 10;
  level.sentrysettings["crafted_autosentry"].pausemin = 0.15;
  level.sentrysettings["crafted_autosentry"].pausemax = 0.25;
  level.sentrysettings["crafted_autosentry"].sentrymodeon = "sentry";
  level.sentrysettings["crafted_autosentry"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["crafted_autosentry"].timeout = 90;
  level.sentrysettings["crafted_autosentry"].spinuptime = 1;
  level.sentrysettings["crafted_autosentry"].overheattime = 15;
  level.sentrysettings["crafted_autosentry"].cooldowntime = 0.2;
  level.sentrysettings["crafted_autosentry"].fxtime = 0.3;
  level.sentrysettings["crafted_autosentry"].weaponinfo = "alien_sentry_minigun_4_mp";
  level.sentrysettings["crafted_autosentry"].modelbase = "weapon_sentry_chaingun";
  level.sentrysettings["crafted_autosentry"].modelplacement = "weapon_sentry_chaingun";
  level.sentrysettings["crafted_autosentry"].modelplacementfailed = "weapon_sentry_chaingun_obj_red";
  level.sentrysettings["crafted_autosentry"].modeldestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrysettings["crafted_autosentry"].hintstring = &"COOP_CRAFTABLES/PICKUP";
  level.sentrysettings["crafted_autosentry"].headicon = 1;
  level.sentrysettings["crafted_autosentry"].vodestroyed = "sentry_destroyed";
  level.sentrysettings["crafted_autosentry"].issentient = 0;
}

function test_ammo_crate(var0) {
  thread watch_dpad();
  var0 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_sentry, var0);
}

function test_crafted_sentry(var0) {
  thread watch_dpad();
  var0 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_sentry, var0);
}

function give_crafted_sentry(var0, var1) {
  thread watch_dpad();
  var1 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_sentry, var1);
}

function watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self endon("remove_sentry");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 1");

  for(;;) {
    var0 = scripts\engine\utility::ref_143ad("pullout_sentry", "pullout_ammocrate");

    if(!isDefined(var0)) {
      continue;
    }

    if(istrue(self.iscarrying)) {
      continue;
    }

    if(istrue(self.linked_to_coaster)) {
      continue;
    }

    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }

    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    switch (var0) {
      case "pullout_sentry":
        thread givesentry("crafted_autosentry");
        break;
      case "pullout_ammocrate":
        var1 = scripts\cp\cp_deployablebox::createboxforplayer("support_box", self.origin + (0, 5, 5), self);
        var2 = spawnStruct();
        var2.linkparent = self;

        if(isDefined(var2.linkparent) && isDefined(var2.linkparent.model) && var2.linkparent.model != "") {
          var1.origin = var2.linkparent.origin;
          var3 = var2.linkparent getlinkedparent();

          if(isDefined(var3)) {
            var2.linkparent = var3;
          } else {
            var2.linkparent = undefined;
          }
        }

        var2.deathoverridecallback = &scripts\cp\cp_deployablebox::override_box_moving_platform_death;
        var1.moving_platform = var2.linkparent;
        var1 setotherent(self);
        waitframe();
        var1 thread scripts\cp\cp_deployablebox::box_setactive(undefined, undefined, undefined);

        if(isDefined(var1) && var1 scripts\cp\utility::touchingbadtrigger()) {
          var1 notify("death");
        }

        break;
    }
  }
}

function givesentry(var0) {
  self endon("disconnect");
  self.last_sentry = var0;
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var1 = createsentryforplayer(var0, self);
  self.itemtype = var0;
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var1;
  var2 = setcarryingsentry(var1, 1);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;

  if(isDefined(var1)) {
    return 1;
  }

  return 0;
}

function setcarryingsentry(var0, var1) {
  self endon("disconnect");
  sentry_setcarried(var0, self, var1);
  scripts\common\utility::allow_weapon(0);
  self notifyonplayercommand("place_sentry", "+attack");
  self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_sentry_left", "+actionslot 3");
  self notifyonplayercommand("cancel_sentry_right", "+actionslot 4");
  self notifyonplayercommand("cancel_sentry_down", "+actionslot 2");
  jumpiftrue(self isconsoleplayer()) LOC_0000009a;
  self notifyonplayercommand("cancel_sentry", "+actionslot 5");
  self notifyonplayercommand("cancel_sentry", "+actionslot 6");
  self notifyonplayercommand("cancel_sentry", "+actionslot 7");

  for(;;) {
    var2 = scripts\engine\utility::ref_143b1("place_sentry", "cancel_sentry_left", "cancel_sentry_right", "cancel_sentry_down", "force_cancel_placement", "cancel_sentry");

    if(!isDefined(var0)) {
      scripts\common\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var2)) {
      var2 = "force_cancel_placement";
    }

    if(var2 == "cancel_sentry" || var2 == "force_cancel_placement" || var2 == "cancel_sentry_left" || var2 == "cancel_sentry_right" || var2 == "cancel_sentry_down") {
      if(!var1 && (var2 == "cancel_sentry" || var2 == "cancel_sentry_left" || var2 == "cancel_sentry_right" || var2 == "cancel_sentry_down")) {
        continue;
      }

      self.bgivensentry = 0;
      scripts\common\utility::allow_weapon(1);
      sentry_setcancelled(var0);

      if(var2 != "force_cancel_placement") {} else if(var1) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var0.canbeplaced) {
      continue;
    }

    if(var1) {
      self notify("remove_sentry");
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    sentry_setplaced(var0);
    scripts\common\utility::allow_weapon(1);
    return 1;
  }
}

function createsentryforplayer(var0, var1) {
  var2 = spawnturret("misc_turret", var1.origin, level.sentrysettings[var0].weaponinfo);
  var2.angles = var1.angles;
  var2.name = "crafted_autosentry";
  sentry_initsentry(var2, var0, var1);
  return var2;
}

function sentry_initsentry(var0, var1) {
  self.sentrytype = var0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[self.sentrytype].modelbase);
  self.shouldsplash = 1;
  self setCanDamage(1);

  switch (var0) {
    case "crafted_autosentry":
    default:
      self maketurretinoperable();
      self setleftarc(100);
      self setrightarc(100);
      self setbottomarc(90);
      self settoparc(60);
      self setconvergencetime(0.3, "pitch");
      self setconvergencetime(0.3, "yaw");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-89);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var1);
  thread sentry_handledeath(var1);
  thread scripts\cp\utility::item_timeout(undefined, level.sentrysettings[self.sentrytype].timeout);
  thread sentry_handleuse();
  thread sentry_attacktargets();
  thread sentry_beepsounds();
}

function sentry_handledeath(var0) {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  sentry_setinactive();
  self setdefaultdroppitch(40);

  if(isDefined(self.carriedby)) {
    self setsentrycarrier(undefined);
  }

  self setsentryowner(undefined);
  self playSound("sentry_explode");

  if(isDefined(self)) {
    thread sentry_deleteturret();
    return;
  }
}

function sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");

  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    self useby(self.inuseby);
    wait 1;
  } else {
    wait 1.5;
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    wait 0.1;
    self notify("deleting");
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function sentry_handleuse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var0.iscarrying)) {
      continue;
    }

    setcarryingsentry(var0, self, 0);
  }
}

function sentry_setowner(var0) {
  var0.current_sentry = self;
  self.owner = var0;
  self setsentryowner(self.owner);
  self.team = self.owner.team;
  self setturretteam(self.team);
  thread scripts\cp\utility::item_handleownerdisconnect("sentry_handleOwner");
}

function sentry_setplaced() {
  if(!istrue(self.firsttimeplace)) {
    self.owner scripts\cp\crafting_system::remove_crafted_item_from_slot(scripts\cp\crafting_system::getitemslot("sentry"));
    self.owner.bgivensentry = 0;
    var0 = "sentry";
    var1 = level.crafting_table_data[var0].metal;
    var2 = 0;

    if(self.owner scripts\cp\cp_persistence::try_take_player_currency(var1)) {}

    foreach(var4 in level.players) {
      var4 thread scripts\cp\cp_hud_message::showsplash("cp_sentry", undefined, self.owner);
    }

    self.firsttimeplace = 1;
    self.owner notify("munitions_used", "sentry");
  }

  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "manual") {
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  }

  self setsentrycarrier(undefined);
  sentry_makesolid();
  self.carriedby forceusehintoff();
  self.carriedby = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;

    if(level.sentrysettings[self.sentrytype].issentient) {
      scripts\cp\utility::make_entity_sentient_cp(self.owner.team);
    }

    self.owner notify("new_sentry", self);
  }

  sentry_setactive();
  self playSound("sentry_gun_plant");
  self laseron();
  self notify("placed");
}

function sentry_setcancelled() {
  self.carriedby forceusehintoff();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self delete();
}

function sentry_setcarried(var0, var1) {
  self setModel(level.sentrysettings[self.sentrytype].modelplacement);
  self setsentrycarrier(var0);
  self setCanDamage(0);
  self laseroff();
  sentry_makenotsolid();
  self.carriedby = var0;
  var0.iscarrying = 1;
  thread updatesentryplacement(var0, self);
  thread scripts\cp\utility::item_oncarrierdeath(var0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var0);
  thread scripts\cp\utility::item_ongameended(var0);
  self freeentitysentient();
  self setdefaultdroppitch(-89);
  sentry_setinactive();
  self notify("carried");
}

function updatesentryplacement(var0, var1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var0 endon("placed");
  var0 endon("death");
  var0.canbeplaced = 1;
  var2 = -1;

  for(;;) {
    var0.canbeplaced = can_place_sentry(var0);

    if(var0.canbeplaced != var2) {
      if(var0.canbeplaced) {
        var0 setModel(level.sentrysettings[var0.sentrytype].modelplacement);

        if(!var1) {
          self forceusehinton(&"COOP_CRAFTABLES/PLACE");
        } else {
          self forceusehinton(&"COOP_CRAFTABLES/PLACE_CANCELABLE");
        }
      } else {
        var0 setModel(level.sentrysettings[var0.sentrytype].modelplacementfailed);
        self forceusehinton(&"COOP_CRAFTABLES/CANNOT_PLACE");
      }
    }

    var2 = var0.canbeplaced;
    wait 0.05;
  }
}

function can_place_sentry(var0) {
  var1 = self canplayerplacesentry();
  var0.origin = var1["origin"];
  var0.angles = var1["angles"];

  if(scripts\cp\utility::ent_is_near_equipment(var0)) {
    return false;
  }

  return self isonground() && var1["result"] && abs(var0.origin[2] - self.origin[2]) < 10;
}

function sentry_setactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setCursorHint("HINT_NOICON");
  self setHintString(level.sentrysettings[self.sentrytype].hintstring);
  self makeusable();
  self setusefov(120);
  self setuserange(96);

  switch (self.sentrytype) {
    case "crafted_autosentry":
      addtoturretlist(self getentitynumber());
      break;
  }
}

function sentry_setinactive() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  removefromturretlist();
}

function sentry_makesolid() {
  self solid();
}

function sentry_makenotsolid() {
  self notsolid();
}

function addtoturretlist(var0) {
  if(!scripts\engine\utility::array_contains(level.turrets, self)) {
    level.turrets = scripts\engine\utility::array_add_safe(level.turrets, self);

    if(level.turrets.size > 4) {
      if(isDefined(level.turrets[0])) {
        level.turrets[0] notify("death");
        return;
      }

      return;
    }

    return;
  }
}

function removefromturretlist() {
  level.turrets = scripts\engine\utility::array_remove(level.turrets, self);
}

function sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = level.sentrysettings[self.sentrytype].burstmin;
  var2 = level.sentrysettings[self.sentrytype].burstmax;
  var3 = level.sentrysettings[self.sentrytype].pausemin;
  var4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var5 = randomintrange(var1, var2 + 1);

    for(var6 = 0; var6 < var5 && !self.overheated; var6++) {
      self shootturret("tag_flash");
      self notify("bullet_fired");
      self.heatlevel += var0;
      wait var0;
    }

    wait randomfloatrange(var3, var4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function turret_shotmonitor(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var0 endon("death");
  var0 endon("player_dismount");
  var1 = weaponfiretime(level.sentrysettings[var0.sentrytype].weaponinfo);

  for(;;) {
    var0 waittill("turret_fire");
    var0 getturretowner() notify("turret_fire");
    var0.heatlevel += var1;
    var0.cooldownwaittime = var1;
  }
}

function sentry_heatmonitor() {
  self endon("death");
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = 0;
  var2 = 0;
  var3 = level.sentrysettings[self.sentrytype].overheattime;
  var4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var1) {
      wait var0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var3) {
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

    var1 = self.heatlevel;
    wait 0.05;
  }
}

function turret_heatmonitor() {
  self endon("death");
  var0 = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > var0) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "gl_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

function turret_coolmonitor() {
  self endon("death");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0) {
        self.heatlevel = max(0, self.heatlevel - 0.05);
      } else {
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
      }
    }

    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function playsmokefx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }
}

function sentry_beepsounds() {
  self notify("sentry_beepSounds");
  self endon("sentry_beepSounds");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}

function remove_sentry_for_player(var0) {
  var0 notify("remove_sentry");
  var0 notify("force_cancel_placement");

  if(isDefined(var0.current_sentry)) {
    level.turrets = scripts\engine\utility::array_remove(level.turrets, var0.current_sentry);
    var0 forceusehintoff();
    var0.iscarrying = 0;
    var0.current_sentry delete();
    return;
  }
}