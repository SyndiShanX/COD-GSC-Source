/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_balloons.gsc
************************************************/

init() {
  level._effect["balloon_death"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_exp.vfx");
  var_00 = spawnStruct();
  var_00.timeout = 60;
  var_00.modelbase = "equipment_tank_nitrogen_zmb";
  var_00.modelplacement = "equipment_tank_nitrogen_zmb";
  var_00.modelplacementfailed = "equipment_tank_nitrogen_zmb";
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.var_9F43 = 0;
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.placestring = & "COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = & "COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.placementheighttolerance = 48;
  var_00.placementradius = 32;
  var_00.carriedtrapoffset = (0, 0, 10);
  var_00.carriedtrapangles = (0, 0, 0);
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_trap_balloon"] = var_00;
}

give_crafted_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_trap_balloon");
  param_01 setclientomnvar("zom_crafted_weapon", 9);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_trap_balloon", ::give_crafted_trap, param_01);
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
    param_01 = level.var_47B3["crafted_trap_balloon"].timeout;
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
  scripts\engine\utility::allow_weapon(0);
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
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_trap" || var_03 == "force_cancel_placement") {
      if(!param_01 && var_03 == "cancel_trap") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
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
    scripts\engine\utility::allow_weapon(1);
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
  var_01.name = "crafted_trap_balloon";
  var_01.carried_trap = spawn("script_model", var_01.origin);
  var_01.carried_trap.angles = param_00.angles;
  var_01.carried_trap setcontents(0);
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
  self.balloons delete();
  self playSound("sentry_explode");
  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
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

    self.balloons delete();
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_126AA(param_00, param_01) {
  var_02 = spawn("script_model", self.origin + (0, 0, 1));
  var_02 setModel(level.var_47B3["crafted_trap_balloon"].modelbase);
  var_02 notsolid();
  var_03 = (0, 0, 60);
  var_04 = (0, 0, 350) - var_03;
  var_05 = var_02.origin;
  var_06 = var_02.origin + var_03;
  var_07 = bulletTrace(var_06, var_06 + var_04, 0, var_02);
  var_08 = var_07;
  var_02.detonate_height = var_08["position"] - (0, 0, 60) - self.origin;
  var_02.balloons = spawn("script_model", var_02.origin + (0, 0, 62));
  var_02.balloons setModel("decor_balloon_bunch_01");
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_02.repulsor = createnavrepulsor("mower_repulsor", 0, var_02.origin, 8, 1);
  param_01.iscarrying = 0;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_trap_balloon";
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
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_trap, level.var_47B3["crafted_trap_balloon"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  func_126A9();
  self notify("carried");
}

func_126A6(param_00) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_47B3["crafted_trap_balloon"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_126A0(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("electrap_handleOwner");
  thread scripts\cp\utility::item_timeout(param_00, level.var_47B3["crafted_trap_balloon"].timeout);
  thread func_126A1();
  thread trap_wait_for_enemies();
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

trap_wait_for_enemies() {
  self endon("death");
  kill_zombies();
}

kill_zombies() {
  self.dmg_trigger = spawn("trigger_radius", self.origin + (0, 0, -20), 0, 256, 128);
  for(;;) {
    self.dmg_trigger waittill("trigger", var_00);
    if(isplayer(var_00)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_00) || var_00.about_to_dance || var_00.scripted_mode) {
      continue;
    }

    if(var_00.agent_type == "slasher" || var_00.agent_type == "superslasher" || var_00.agent_type == "lumberjack" || var_00.agent_type == "zombie_sasquatch") {
      continue;
    }

    if(isDefined(var_00.is_skeleton)) {
      continue;
    }

    var_00 thread go_to_balloons(self);
    var_00 thread release_zombie_on_trap_death(self);
  }
}

go_to_balloons(param_00) {
  param_00 endon("death");
  self endon("death");
  self endon("turned");
  self.disablearrivals = 1;
  self.scripted_mode = 1;
  self.og_goalradius = 4;
  self ghostskulls_complete_status(param_00.origin);
  self ghostskulls_total_waves(60);
  var_01 = param_00.detonate_height[2];
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  thread balloon_death(var_01);
}

balloon_death(param_00) {
  self.detonate_height = param_00;
  self.shared_damage_points = 1;
  self.var_55CF = 1;
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "balloon_trap");
  scripts\asm\asm::asm_setstate("balloon_grab");
  self playsoundonmovingent("craftable_balloon_zmb_grab");
  self waittill("reached_end");
  self stopsounds();
}

release_zombie_on_trap_death(param_00) {
  self endon("death");
  param_00 waittill("death");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
  self.disablearrivals = 0;
}