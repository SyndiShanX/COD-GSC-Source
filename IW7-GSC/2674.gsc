/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2674.gsc
**************************************/

init() {
  level._effect["electric_trap_idle"] = loadfx("vfx\iw7\_requests\coop\generator_idle.vfx");
  level._effect["electric_trap_attack"] = loadfx("vfx\iw7\core\zombie\vfx_electrap_shock_beam.vfx");
  level._effect["electric_trap_shock"] = loadfx("vfx\iw7\core\zombie\traps\electric_trap\vfx_zmb_hit_shock.vfx");
  var_0 = spawnStruct();
  var_0.timeout = 60.0;
  var_0.modelbase = "zom_machinery_generator_portable_01";
  var_0.modelplacement = "zom_machinery_generator_portable_01";
  var_0.modelplacementfailed = "zom_machinery_generator_portable_01_red";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.var_9F43 = 0;
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 32.0;
  var_0.carriedtrapoffset = (0, 0, 25);
  var_0.carriedtrapangles = (0, 0, 0);

  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_electric_trap"] = var_0;
}

give_crafted_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_electric_trap");
  var_1 setclientomnvar("zom_crafted_weapon", 4);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_electric_trap", ::give_crafted_trap, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_trap", "+actionslot 3");

  for(;;) {
    self waittill("pullout_trap");

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

  var_3 = func_F68A(var_2, var_0, var_1);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_2)) {
    return 1;
  } else {
    return 0;
  }
}

func_F68A(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 func_126A8(self, var_1);
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
    self.riotshieldammo = self getammocount(var_0);
    self giveuponsuppressiontime(var_0);
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
  wait 0.05;
  restoreperks();
}

func_4A2A(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 40), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.owner = var_0;
  var_1.name = "crafted_electric_trap";
  var_1.carried_trap = spawn("script_model", var_1.origin);
  var_1.carried_trap.angles = var_0.angles;
  var_1 maketurretinoperable();
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
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    self playSound("sentry_explode_smoke");
    wait 0.1;

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
    if(scripts\engine\utility::is_true(var_0.iscarrying)) {
      continue;
    }
    var_0 thread setsuppressiontime(0, self.lifespan);

    if(isDefined(self.charge_fx)) {
      self.charge_fx delete();
    }

    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_126AA(var_0, var_1) {
  var_2 = spawn("script_model", self.origin + (0, 0, 1.5));
  var_2.angles = self.angles;
  var_2 solid();
  var_2 setModel(level.var_47B3["crafted_electric_trap"].modelbase);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  var_2.owner = var_1;
  var_2.name = "crafted_electric_trap";
  var_2 thread func_126A6(var_0);
  var_2 playSound("sentry_gun_plant");
  self notify("placed");
  self.carried_trap delete();
  self delete();
}

func_126A7() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self.carried_trap delete();
  self delete();
}

func_126A8(var_0, var_1) {
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self stoploopsound();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_trap, level.var_47B3["crafted_electric_trap"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  func_126A9();
  self notify("carried");
}

func_126A6(var_0) {
  self setscriptablepartstate("fx", "on");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_47B3["crafted_electric_trap"].hintstring);
  self makeusable();
  self func_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_126A0(self.owner);
  thread scripts\cp\utility::item_handleownerdisconnect("electrap_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.var_47B3["crafted_electric_trap"].timeout);
  thread func_126A1();
  thread func_126AF();
  scripts\cp\utility::addtotraplist();
}

func_126A9() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

func_126AF() {
  self endon("death");
  var_0 = 36864;
  wait 1;

  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagents();
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);

    foreach(var_3 in var_1) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_3, undefined, 1) || scripts\engine\utility::is_true(var_3.is_electrified)) {
        continue;
      }
      if(distancesquared(self.origin + (0, 0, 20), var_3.origin + (0, 0, 20)) < var_0) {
        self playSound("trap_electric_shock");
        thread electrocute_zombie(var_3);

        if(scripts\engine\utility::is_true(var_3.dismember_crawl)) {
          var_3 thread scripts\cp\utility::damage_over_time(var_3, self, 1, var_3.health + 10, "MOD_RIFLE_BULLET", "zmb_imsprojectile_mp", undefined, "electrified");
        } else {
          var_3 thread scripts\cp\utility::damage_over_time(var_3, self, 3, var_3.health + 10, "MOD_RIFLE_BULLET", "zmb_imsprojectile_mp", undefined, "electrified");
        }

        wait 1.5;
      }
    }

    wait 0.1;
  }
}

electrocute_zombie(var_0) {
  var_0 endon("death");
  self endon("death");
  var_1 = ["J_Shoulder_LE", "J_Shoulder_RI", "J_Wrist_LE", "J_Wrist_RI", "J_Elbow_RI", "J_Elbow_LE"];
  var_2 = ["J_Hip_RI", "J_Hip_LE", "J_Knee_LE", "J_Ankle_LE", "J_Knee_RI", "J_Ankle_RI"];
  var_3 = ["J_SpineLower", "J_Chest", "J_Head", "J_Neck", "J_Crotch"];
  var_4 = [scripts\engine\utility::random(var_1), scripts\engine\utility::random(var_2), scripts\engine\utility::random(var_3)];

  foreach(var_6 in var_4) {
    if(!scripts\cp\utility::has_tag(var_0.model, var_6)) {
      continue;
    }
    var_7 = var_0 gettagorigin(var_6);
    playfxbetweenpoints(level._effect["electric_trap_attack"], self.origin + (0, 0, 24), vectortoangles(var_7 - self.origin + (0, 0, 24)), var_7);
    scripts\engine\utility::waitframe();
    playFXOnTag(level._effect["electric_trap_shock"], var_0, var_6);
    scripts\engine\utility::waitframe();
  }
}