/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_mower.gsc
*********************************************/

init() {
  level._effect["electric_trap_idle"] = loadfx("vfx\iw7\_requests\coop\generator_idle.vfx");
  level._effect["electric_trap_attack"] = loadfx("vfx\iw7\core\zombie\vfx_electrap_shock_beam.vfx");
  level._effect["electric_trap_shock"] = loadfx("vfx\iw7\core\zombie\traps\electric_trap\vfx_zmb_hit_shock.vfx");
  level._effect["mower_spray"] = loadfx("vfx\iw7\core\zombie\rave\mower_spray.vfx");
  level._effect["mower_blade"] = loadfx("vfx\iw7\core\zombie\rave\mower_blade.vfx");
  var_0 = spawnStruct();
  var_0.timeout = 90;
  var_0.modelbase = "cp_rave_equipment_lawnmower_01";
  var_0.modelplacement = "tag_origin";
  var_0.modelplacementfailed = "tag_origin";
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.var_9F43 = 0;
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"CP_RAVE_MOWER_PLACEMENT";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"CP_RAVE_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 48;
  var_0.placementradius = 32;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (90, 270, 90);
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_trap_mower"] = var_0;
}

give_crafted_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_trap_mower");
  var_1 setclientomnvar("zom_crafted_weapon", 10);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_trap_mower", ::give_crafted_trap, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_trap", "+actionslot 3");
  for(;;) {
    self waittill("pullout_trap");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.linked_to_coaster)) {
      continue;
    }

    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread setsuppressiontime(1);
}

setsuppressiontime(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_2 = func_4A2A(self);
  self.itemtype = var_2.name;
  removeperks();
  self.carriedsentry = var_2;
  if(var_0) {
    var_2.firstplacement = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = level.var_47B3["crafted_trap_mower"].timeout;
  }

  var_3 = func_F68A(var_2, var_0, var_1);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_2)) {
    return 1;
  }

  return 0;
}

func_F68A(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 func_126A8(self, var_1, var_2);
  self.switch_to_weapon_after_mower = scripts\cp\utility::getvalidtakeweapon();
  self giveweapon("iw7_lawnmower_zm");
  self switchtoweapon("iw7_lawnmower_zm");
  scripts\engine\utility::allow_weapon_switch(0);
  self notifyonplayercommand("place_trap", "+attack");
  self notifyonplayercommand("place_trap", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_trap", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_trap", "+actionslot 5");
    self notifyonplayercommand("cancel_trap", "+actionslot 6");
    self notifyonplayercommand("cancel_trap", "+actionslot 7");
  }

  for(;;) {
    var_3 = scripts\engine\utility::waittill_any_return("place_trap", "cancel_trap", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon_switch(1);
      self takeweapon("iw7_lawnmower_zm");
      self switchtoweapon(self.switch_to_weapon_after_mower);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_trap" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_trap") {
        continue;
      }

      self takeweapon("iw7_lawnmower_zm");
      self.carriedsentry.carried_trap playSound("craftable_lawn_mower_end");
      scripts\engine\utility::allow_weapon_switch(1);
      if(!scripts\cp\cp_laststand::player_in_laststand(self)) {
        self switchtoweapon(self.switch_to_weapon_after_mower);
      }

      if(scripts\engine\utility::istrue(self.disabledsprint)) {
        scripts\engine\utility::allow_sprint(1);
      }

      self.customweaponspeedscalar = 1;
      scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
      var_0 func_126A7();
      if(var_3 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(var_1) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    if(var_1) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_0 func_126AA(var_2, self);
    if(scripts\engine\utility::istrue(self.disabledsprint)) {
      scripts\engine\utility::allow_sprint(1);
    }

    self.customweaponspeedscalar = 1;
    scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
    self takeweapon("iw7_lawnmower_zm");
    scripts\engine\utility::allow_weapon_switch(1);
    self switchtoweapon(self.switch_to_weapon_after_mower);
    return 1;
  }
}

removeweapons() {
  if(self.hasriotshield) {
    var_0 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_0;
    self.riotshieldammo = self getrunningforwardpainanim(var_0);
    self takeweapon(var_0);
  }
}

removeperks() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp\utility::_giveweapon(self.restoreweapon);
    if(self.hasriotshield) {
      var_0 = scripts\cp\utility::riotshieldname();
      self setweaponammoclip(var_0, self.riotshieldammo);
    }
  }

  self.restoreweapon = undefined;
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\cp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

func_4A2A(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 40), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.triggerportableradarping = var_0;
  var_1.name = "crafted_trap_mower";
  var_1.carried_trap = spawn("script_model", var_1.origin);
  var_1.carried_trap.angles = var_0.angles;
  var_1 getvalidattachments();
  var_1 setturretmodechangewait(1);
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 func_126A2(var_0);
  return var_1;
}

func_126A2(var_0) {
  self.canbeplaced = 1;
}

func_126A0(var_0) {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  func_126A9();
  self playSound("sentry_explode");
  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    playFX(scripts\engine\utility::getfx("sentry_explode_mp"), self.origin);
    self playSound("sentry_explode_smoke");
    wait(0.1);
    if(isDefined(self)) {
      if(isDefined(self.carried_trap)) {
        self.carried_trap delete();
      }

      self delete();
    }
  }
}

func_126A1() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.iscarrying)) {
      continue;
    }

    var_0 thread setsuppressiontime(0, self.lifespan);
    if(isDefined(self.charge_fx)) {
      self.charge_fx delete();
    }

    playsoundatpos(self.origin, "craftable_lawn_mower_end");
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

delayfx() {
  self endon("death");
  wait(1);
  playFXOnTag(level._effect["mower_blade"], self, "tag_fx");
}

func_126AA(var_0, var_1) {
  var_2 = spawn("script_model", self.origin + (0, 0, 10));
  var_2.angles = self.angles + (0, 0, -15);
  var_2 solid();
  var_2 setModel(level.var_47B3["crafted_trap_mower"].modelbase);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_2.repulsor = createnavrepulsor("mower_repulsor", 0, var_2.origin, 32, 1);
  var_1.iscarrying = 0;
  var_2.triggerportableradarping = var_1;
  var_2.name = "crafted_trap_mower";
  var_2 thread delayfx();
  if(isDefined(self.carried_trap.timeused)) {
    if(isDefined(var_0)) {
      var_0 = var_0 - self.carried_trap.timeused;
      if(var_0 < 1) {
        var_0 = 1;
      }
    }
  }

  var_2 thread func_126A6(var_0);
  self notify("placed");
  self.carried_trap delete();
  self delete();
}

func_126A7() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  if(isDefined(self.repulsor)) {
    destroynavrepulsor(self.repulsor);
  }

  self.carried_trap delete();
  self delete();
}

func_126A8(var_0, var_1, var_2) {
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self stoploopsound();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_trap, level.var_47B3["crafted_trap_mower"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  var_0 thread adswatcher(self.carried_trap, var_2, var_1);
  func_126A9();
  self notify("carried");
}

adswatcher(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_3 = gettime();
  var_0.timeused = 0;
  var_4 = 0;
  if(scripts\engine\utility::istrue(var_2)) {
    var_0 playSound("craftable_lawn_mower_start");
  }

  var_0 playLoopSound("craftable_lawn_mower_lp");
  var_5 = gettime();
  for(;;) {
    wait(0.05);
    var_0.timeused = var_0.timeused + 0.05;
    if(self adsbuttonpressed(1)) {
      if(var_3 <= gettime()) {
        var_0 stoploopsound();
        self earthquakeforplayer(0.23, 1, self.origin, 128);
        self playrumbleonentity("heavy_3s");
        var_0 playSound("craftable_lawn_mower_high_start");
        var_0 playLoopSound("craftable_lawn_mower_high_lp");
        var_3 = gettime() + 30000;
        var_0.timeused = var_0.timeused + 0.05;
        if(isDefined(var_1)) {
          if(var_1 - var_0.timeused <= 0) {
            var_0 stopsounds();
            playFX(scripts\engine\utility::getfx("sentry_explode_mp"), var_0.origin);
            var_0 playSound("sentry_explode_smoke");
            wait(0.5);
            self notify("force_cancel_placement");
            return;
          }
        }
      } else {
        self earthquakeforplayer(0.23, 0.25, self.origin, 128);
        if(isDefined(var_1)) {
          var_0.timeused = var_0.timeused + 0.05;
          if(var_1 - var_0.timeused <= 0) {
            var_0 stopsounds();
            playFX(scripts\engine\utility::getfx("sentry_explode_mp"), var_0.origin);
            var_0 playSound("sentry_explode_smoke");
            wait(0.5);
            self notify("force_cancel_placement");
            return;
          }
        }
      }

      if(!var_4) {
        if(scripts\engine\utility::istrue(self.disabledsprint)) {
          scripts\engine\utility::allow_sprint(0);
        }

        self.customweaponspeedscalar = 0.5;
        scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
        var_4 = 1;
      }

      var_6 = scripts\engine\utility::getclosest(self.origin, level.spawned_enemies, 64);
      if(!isDefined(var_6)) {
        continue;
      }

      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, cos(75))) {
        var_6.nocorpse = 1;
        var_6.precacheleaderboards = 1;
        var_6.full_gib = 1;
        if(gettime() > var_5) {
          self earthquakeforplayer(0.35, 1.5, var_6.origin, 128);
          self playrumbleonentity("heavy_1s");
          self setscriptablepartstate("mower_death", "on");
          var_5 = gettime() + 1000;
        }

        var_6.disable_armor = 1;
        var_7 = var_6.health + 100;
        if(isDefined(var_6.is_skeleton)) {
          var_0.timeused = var_0.timeused + 15;
        } else if(isDefined(var_6.agent_type)) {
          if(var_6.agent_type == "zombie_sasquatch") {
            var_0.timeused = var_0.timeused + 15;
          } else if(var_6.agent_type == "lumberjack") {
            var_0.timeused = var_0.timeused + 20;
          } else if(var_6.agent_type == "slasher" || var_6.agent_type == "superslasher") {
            var_7 = 0;
          }
        }

        if(var_7 > 0) {
          var_6.shared_damage_points = 1;
          var_6 dodamage(var_6.health + 100, var_0.origin, self, self, "MOD_MELEE", "iw7_lawnmower_zm");
        }
      }

      continue;
    }

    if(!isDefined(var_1)) {
      var_1 = level.var_47B3["crafted_trap_mower"].lifespan;
    }

    if(var_1 - var_0.timeused <= 0) {
      var_0 stopsounds();
      playFX(scripts\engine\utility::getfx("sentry_explode_mp"), var_0.origin);
      var_0 playSound("sentry_explode_smoke");
      self notify("force_cancel_placement");
      wait(0.5);
      return;
    }

    var_3 = 0;
    if(var_4) {
      if(scripts\engine\utility::istrue(self.disabledsprint)) {
        scripts\engine\utility::allow_sprint(1);
      }

      self.customweaponspeedscalar = 1;
      scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
      var_4 = 0;
      var_0 playSound("craftable_lawn_mower_high_end");
      var_0 stoploopsound();
      var_0 playLoopSound("craftable_lawn_mower_lp");
    }
  }
}

func_126A6(var_0) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_47B3["crafted_trap_mower"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_126A0(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("electrap_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.var_47B3["crafted_trap_mower"].timeout);
  thread func_126A1();
  thread trap_grind_enemies();
  scripts\cp\utility::addtotraplist();
}

func_126A9() {
  self makeunusable();
  if(isDefined(self.repulsor)) {
    destroynavrepulsor(self.repulsor);
  }

  if(isDefined(self.dmg_trigger)) {
    self.dmg_trigger notify("stop_dmg");
    self.dmg_trigger delete();
  }

  if(isDefined(self.var_FB2F)) {
    self.var_FB2F stoploopsound();
    self.var_FB2F delete();
  }

  scripts\cp\utility::removefromtraplist();
}

trap_grind_enemies() {
  self endon("death");
  wait(1);
  var_0 = anglestoup(self.angles) * -1;
  self.dmg_trigger = spawn("trigger_radius", self.origin + var_0 * 35, 0, 35, 45);
  self.dmg_trigger.angles = var_0;
  self.dmg_trigger thread kill_zombies(self.triggerportableradarping, self);
}

kill_zombies(var_0, var_1) {
  self endon("stop_dmg");
  self endon("death");
  var_1 endon("death");
  for(;;) {
    self waittill("trigger", var_2);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_2) || isDefined(var_2.flung)) {
      continue;
    }

    if(var_2.agent_type == "slasher" || var_2.agent_type == "superslasher" || var_2.agent_type == "zombie_sasquatch" || var_2.agent_type == "zombie_lumberjack") {
      continue;
    }

    if(isDefined(var_2.is_skeleton)) {
      continue;
    }

    var_2.flung = 1;
    var_2 thread release_zombie_on_trap_death(var_1);
    level thread suck_zombie(var_2, var_0, var_1);
  }
}

release_zombie_on_trap_death(var_0) {
  self endon("death");
  var_0 waittill("death");
  self.scripted_mode = 0;
  self.nocorpse = undefined;
  self.flung = undefined;
  self.precacheleaderboards = 0;
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

suck_zombie(var_0, var_1, var_2) {
  var_0 endon("death");
  var_2 endon("death");
  var_0.scripted_mode = 1;
  var_0.nocorpse = 1;
  var_0.precacheleaderboards = 1;
  var_0.anchor = spawn("script_origin", var_0.origin);
  var_0.anchor.angles = var_0.angles;
  var_0 linkto(var_0.anchor);
  var_0.anchor moveto(var_2.origin + (0, 0, -10), 0.15);
  wait(0.15);
  playFX(level._effect["woodchipper_entry"], var_0.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  var_0.anchor delete();
  var_0.disable_armor = 1;
  level thread woodchipper_spray(var_2);
  if(isDefined(var_1)) {
    var_0 dodamage(var_0.health + 100, var_2.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_lawnmower_zm");
    return;
  }

  var_0 dodamage(var_0.health + 100, var_2.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_lawnmower_zm");
}

woodchipper_spray(var_0) {
  var_0 endon("death");
  if(scripts\engine\utility::istrue(var_0.spraying)) {
    return;
  }

  var_0.spraying = 1;
  var_0 setscriptablepartstate("guts", "grind");
  wait(3);
  if(isDefined(var_0)) {
    var_0.spraying = 0;
  }
}