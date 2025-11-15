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
  var_00 = spawnStruct();
  var_00.timeout = 90;
  var_00.modelbase = "cp_rave_equipment_lawnmower_01";
  var_00.modelplacement = "tag_origin";
  var_00.modelplacementfailed = "tag_origin";
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.var_9F43 = 0;
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.placestring = & "CP_RAVE_MOWER_PLACEMENT";
  var_00.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = & "CP_RAVE_PLACE_CANCELABLE";
  var_00.placementheighttolerance = 48;
  var_00.placementradius = 32;
  var_00.carriedtrapoffset = (0, 0, 35);
  var_00.carriedtrapangles = (90, 270, 90);
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_trap_mower"] = var_00;
}

give_crafted_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_trap_mower");
  param_01 setclientomnvar("zom_crafted_weapon", 10);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_trap_mower", ::give_crafted_trap, param_01);
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

setsuppressiontime(param_00, param_01) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_02 = func_4A2A(self);
  self.itemtype = var_02.name;
  removeperks();
  self.carriedsentry = var_02;
  if(param_00) {
    var_02.firstplacement = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = level.var_47B3["crafted_trap_mower"].timeout;
  }

  var_03 = func_F68A(var_02, param_00, param_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_02)) {
    return 1;
  }

  return 0;
}

func_F68A(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 func_126A8(self, param_01, param_02);
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
    var_03 = scripts\engine\utility::waittill_any_return("place_trap", "cancel_trap", "force_cancel_placement");
    if(!isDefined(param_00)) {
      scripts\engine\utility::allow_weapon_switch(1);
      self takeweapon("iw7_lawnmower_zm");
      self switchtoweapon(self.switch_to_weapon_after_mower);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_trap" || var_03 == "force_cancel_placement") {
      if(!param_01 && var_03 == "cancel_trap") {
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
      param_00 func_126A7();
      if(var_03 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(param_01) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    if(param_01) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    param_00 func_126AA(param_02, self);
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
    var_00 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_00;
    self.riotshieldammo = self getrunningforwardpainanim(var_00);
    self takeweapon(var_00);
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
      var_00 = scripts\cp\utility::riotshieldname();
      self setweaponammoclip(var_00, self.riotshieldammo);
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

func_4A2A(param_00) {
  var_01 = spawnturret("misc_turret", param_00.origin + (0, 0, 40), "sentry_minigun_mp");
  var_01.angles = param_00.angles;
  var_01.triggerportableradarping = param_00;
  var_01.name = "crafted_trap_mower";
  var_01.carried_trap = spawn("script_model", var_01.origin);
  var_01.carried_trap.angles = param_00.angles;
  var_01 getvalidattachments();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(param_00);
  var_01 func_126A2(param_00);
  return var_01;
}

func_126A2(param_00) {
  self.canbeplaced = 1;
}

func_126A0(param_00) {
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
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_00.iscarrying)) {
      continue;
    }

    var_00 thread setsuppressiontime(0, self.lifespan);
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

func_126AA(param_00, param_01) {
  var_02 = spawn("script_model", self.origin + (0, 0, 10));
  var_02.angles = self.angles + (0, 0, -15);
  var_02 solid();
  var_02 setModel(level.var_47B3["crafted_trap_mower"].modelbase);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_02.repulsor = createnavrepulsor("mower_repulsor", 0, var_02.origin, 32, 1);
  param_01.iscarrying = 0;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_trap_mower";
  var_02 thread delayfx();
  if(isDefined(self.carried_trap.timeused)) {
    if(isDefined(param_00)) {
      param_00 = param_00 - self.carried_trap.timeused;
      if(param_00 < 1) {
        param_00 = 1;
      }
    }
  }

  var_02 thread func_126A6(param_00);
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

func_126A8(param_00, param_01, param_02) {
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  self stoploopsound();
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_trap, level.var_47B3["crafted_trap_mower"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  param_00 thread adswatcher(self.carried_trap, param_02, param_01);
  func_126A9();
  self notify("carried");
}

adswatcher(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  var_03 = gettime();
  param_00.timeused = 0;
  var_04 = 0;
  if(scripts\engine\utility::istrue(param_02)) {
    param_00 playSound("craftable_lawn_mower_start");
  }

  param_00 playLoopSound("craftable_lawn_mower_lp");
  var_05 = gettime();
  for(;;) {
    wait(0.05);
    param_00.timeused = param_00.timeused + 0.05;
    if(self adsbuttonpressed(1)) {
      if(var_03 <= gettime()) {
        param_00 stoploopsound();
        self earthquakeforplayer(0.23, 1, self.origin, 128);
        self playrumbleonentity("heavy_3s");
        param_00 playSound("craftable_lawn_mower_high_start");
        param_00 playLoopSound("craftable_lawn_mower_high_lp");
        var_03 = gettime() + 30000;
        param_00.timeused = param_00.timeused + 0.05;
        if(isDefined(param_01)) {
          if(param_01 - param_00.timeused <= 0) {
            param_00 stopsounds();
            playFX(scripts\engine\utility::getfx("sentry_explode_mp"), param_00.origin);
            param_00 playSound("sentry_explode_smoke");
            wait(0.5);
            self notify("force_cancel_placement");
            return;
          }
        }
      } else {
        self earthquakeforplayer(0.23, 0.25, self.origin, 128);
        if(isDefined(param_01)) {
          param_00.timeused = param_00.timeused + 0.05;
          if(param_01 - param_00.timeused <= 0) {
            param_00 stopsounds();
            playFX(scripts\engine\utility::getfx("sentry_explode_mp"), param_00.origin);
            param_00 playSound("sentry_explode_smoke");
            wait(0.5);
            self notify("force_cancel_placement");
            return;
          }
        }
      }

      if(!var_04) {
        if(scripts\engine\utility::istrue(self.disabledsprint)) {
          scripts\engine\utility::allow_sprint(0);
        }

        self.customweaponspeedscalar = 0.5;
        scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
        var_04 = 1;
      }

      var_06 = scripts\engine\utility::getclosest(self.origin, level.spawned_enemies, 64);
      if(!isDefined(var_06)) {
        continue;
      }

      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_06.origin, cos(75))) {
        var_06.nocorpse = 1;
        var_06.precacheleaderboards = 1;
        var_06.full_gib = 1;
        if(gettime() > var_05) {
          self earthquakeforplayer(0.35, 1.5, var_06.origin, 128);
          self playrumbleonentity("heavy_1s");
          self setscriptablepartstate("mower_death", "on");
          var_05 = gettime() + 1000;
        }

        var_06.disable_armor = 1;
        var_07 = var_06.health + 100;
        if(isDefined(var_06.is_skeleton)) {
          param_00.timeused = param_00.timeused + 15;
        } else if(isDefined(var_06.agent_type)) {
          if(var_06.agent_type == "zombie_sasquatch") {
            param_00.timeused = param_00.timeused + 15;
          } else if(var_06.agent_type == "lumberjack") {
            param_00.timeused = param_00.timeused + 20;
          } else if(var_06.agent_type == "slasher" || var_06.agent_type == "superslasher") {
            var_07 = 0;
          }
        }

        if(var_07 > 0) {
          var_06.shared_damage_points = 1;
          var_06 dodamage(var_06.health + 100, param_00.origin, self, self, "MOD_MELEE", "iw7_lawnmower_zm");
        }
      }

      continue;
    }

    if(!isDefined(param_01)) {
      param_01 = level.var_47B3["crafted_trap_mower"].lifespan;
    }

    if(param_01 - param_00.timeused <= 0) {
      param_00 stopsounds();
      playFX(scripts\engine\utility::getfx("sentry_explode_mp"), param_00.origin);
      param_00 playSound("sentry_explode_smoke");
      self notify("force_cancel_placement");
      wait(0.5);
      return;
    }

    var_03 = 0;
    if(var_04) {
      if(scripts\engine\utility::istrue(self.disabledsprint)) {
        scripts\engine\utility::allow_sprint(1);
      }

      self.customweaponspeedscalar = 1;
      scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
      var_04 = 0;
      param_00 playSound("craftable_lawn_mower_high_end");
      param_00 stoploopsound();
      param_00 playLoopSound("craftable_lawn_mower_lp");
    }
  }
}

func_126A6(param_00) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_47B3["crafted_trap_mower"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_126A0(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("electrap_handleOwner");
  thread scripts\cp\utility::item_timeout(param_00, level.var_47B3["crafted_trap_mower"].timeout);
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
  var_00 = anglestoup(self.angles) * -1;
  self.dmg_trigger = spawn("trigger_radius", self.origin + var_00 * 35, 0, 35, 45);
  self.dmg_trigger.angles = var_00;
  self.dmg_trigger thread kill_zombies(self.triggerportableradarping, self);
}

kill_zombies(param_00, param_01) {
  self endon("stop_dmg");
  self endon("death");
  param_01 endon("death");
  for(;;) {
    self waittill("trigger", var_02);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_02) || isDefined(var_02.flung)) {
      continue;
    }

    if(var_02.agent_type == "slasher" || var_02.agent_type == "superslasher" || var_02.agent_type == "zombie_sasquatch" || var_02.agent_type == "zombie_lumberjack") {
      continue;
    }

    if(isDefined(var_02.is_skeleton)) {
      continue;
    }

    var_02.flung = 1;
    var_02 thread release_zombie_on_trap_death(param_01);
    level thread suck_zombie(var_02, param_00, param_01);
  }
}

release_zombie_on_trap_death(param_00) {
  self endon("death");
  param_00 waittill("death");
  self.scripted_mode = 0;
  self.nocorpse = undefined;
  self.flung = undefined;
  self.precacheleaderboards = 0;
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

suck_zombie(param_00, param_01, param_02) {
  param_00 endon("death");
  param_02 endon("death");
  param_00.scripted_mode = 1;
  param_00.nocorpse = 1;
  param_00.precacheleaderboards = 1;
  param_00.anchor = spawn("script_origin", param_00.origin);
  param_00.anchor.angles = param_00.angles;
  param_00 linkto(param_00.anchor);
  param_00.anchor moveto(param_02.origin + (0, 0, -10), 0.15);
  wait(0.15);
  playFX(level._effect["woodchipper_entry"], param_00.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  param_00.anchor delete();
  param_00.disable_armor = 1;
  level thread woodchipper_spray(param_02);
  if(isDefined(param_01)) {
    param_00 dodamage(param_00.health + 100, param_02.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_lawnmower_zm");
    return;
  }

  param_00 dodamage(param_00.health + 100, param_02.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_lawnmower_zm");
}

woodchipper_spray(param_00) {
  param_00 endon("death");
  if(scripts\engine\utility::istrue(param_00.spraying)) {
    return;
  }

  param_00.spraying = 1;
  param_00 setscriptablepartstate("guts", "grind");
  wait(3);
  if(isDefined(param_00)) {
    param_00.spraying = 0;
  }
}