/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_balloons.gsc
************************************************/

init() {
  level._effect["balloon_death"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_exp.vfx");
  var_0 = spawnStruct();
  var_0.timeout = 60;
  var_0.modelbase = "equipment_tank_nitrogen_zmb";
  var_0.modelplacement = "equipment_tank_nitrogen_zmb";
  var_0.modelplacementfailed = "equipment_tank_nitrogen_zmb";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.var_9F43 = 0;
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 48;
  var_0.placementradius = 32;
  var_0.carriedtrapoffset = (0, 0, 10);
  var_0.carriedtrapangles = (0, 0, 0);
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_trap_balloon"] = var_0;
}

give_crafted_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_trap_balloon");
  var_1 setclientomnvar("zom_crafted_weapon", 9);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_trap_balloon", ::give_crafted_trap, var_1);
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
    var_1 = level.var_47B3["crafted_trap_balloon"].timeout;
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
    var_3 = scripts\engine\utility::waittill_any_return("place_trap", "cancel_trap", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_trap" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_trap") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
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
    scripts\engine\utility::allow_weapon(1);
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
  var_1.owner = var_0;
  var_1.name = "crafted_trap_balloon";
  var_1.carried_trap = spawn("script_model", var_1.origin);
  var_1.carried_trap.angles = var_0.angles;
  var_1.carried_trap setcontents(0);
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

    self.balloons delete();
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_126AA(var_0, var_1) {
  var_2 = spawn("script_model", self.origin + (0, 0, 1));
  var_2 setModel(level.var_47B3["crafted_trap_balloon"].modelbase);
  var_2 notsolid();
  var_3 = (0, 0, 60);
  var_4 = (0, 0, 350) - var_3;
  var_5 = var_2.origin;
  var_6 = var_2.origin + var_3;
  var_7 = bulletTrace(var_6, var_6 + var_4, 0, var_2);
  var_8 = var_7;
  var_2.detonate_height = var_8["position"] - (0, 0, 60) - self.origin;
  var_2.balloons = spawn("script_model", var_2.origin + (0, 0, 62));
  var_2.balloons setModel("decor_balloon_bunch_01");
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_2.repulsor = createnavrepulsor("mower_repulsor", 0, var_2.origin, 8, 1);
  var_1.iscarrying = 0;
  var_2.owner = var_1;
  var_2.name = "crafted_trap_balloon";
  var_2 thread func_126A6(var_0);
  self notify("placed");
  self.carried_trap delete();
  self delete();
}

func_126A7() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
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
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_trap, level.var_47B3["crafted_trap_balloon"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  func_126A9();
  self notify("carried");
}

func_126A6(var_0) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_47B3["crafted_trap_balloon"].hintstring);
  self makeusable();
  self func_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_126A0(self.owner);
  thread scripts\cp\utility::item_handleownerdisconnect("electrap_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.var_47B3["crafted_trap_balloon"].timeout);
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
    self.dmg_trigger waittill("trigger", var_0);
    if(isplayer(var_0)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_0) || var_0.about_to_dance || var_0.scripted_mode) {
      continue;
    }

    if(var_0.agent_type == "slasher" || var_0.agent_type == "superslasher" || var_0.agent_type == "lumberjack" || var_0.agent_type == "zombie_sasquatch") {
      continue;
    }

    if(isDefined(var_0.is_skeleton)) {
      continue;
    }

    var_0 thread go_to_balloons(self);
    var_0 thread release_zombie_on_trap_death(self);
  }
}

go_to_balloons(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("turned");
  self.disablearrivals = 1;
  self.scripted_mode = 1;
  self.og_goalradius = 4;
  self ghostskulls_complete_status(var_0.origin);
  self ghostskulls_total_waves(60);
  var_1 = var_0.detonate_height[2];
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  thread balloon_death(var_1);
}

balloon_death(var_0) {
  self.detonate_height = var_0;
  self.shared_damage_points = 1;
  self.var_55CF = 1;
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "balloon_trap");
  scripts\asm\asm::asm_setstate("balloon_grab");
  self playsoundonmovingent("craftable_balloon_zmb_grab");
  self waittill("reached_end");
  self stopsounds();
}

release_zombie_on_trap_death(var_0) {
  self endon("death");
  var_0 waittill("death");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
  self.disablearrivals = 0;
}