/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2677.gsc
***************************************/

init() {
  level._effect["revocator_idle"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_revocator_idle.vfx");
  level._effect["revocator_activate"] = loadfx("vfx\iw7\_requests\coop\vfx_revocator_use.vfx");
  var_00 = spawnStruct();
  var_0.timeout = 30.0;
  var_0.modelbase = "revocator";
  var_0.modelplacement = "revocator";
  var_0.modelplacementfailed = "revocator_bad";
  var_0.placedmodel = "revocator";
  var_0.hintstring = & "COOP_CRAFTABLES_PICKUP";
  var_0.placestring = & "COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = & "COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 24.0;
  var_0.carriedtrapoffset = (0, 0, 25);
  var_0.carriedtrapangles = (0, 0, 0);
  level.func_47B1 = [];
  level.func_47B1["crafted_revocator"] = var_00;
}

give_crafted_revocator(var_00, var_01) {
  var_01 thread watch_dpad();
  var_01 notify("new_power", "crafted_revocator");
  var_01 setclientomnvar("zom_crafted_weapon", 6);
  var_01 thread scripts\cp\utility::usegrenadegesture(var_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_revocator", ::give_crafted_revocator, var_01);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_revocator", "+actionslot 3");

  for(;;) {
    self waittill("pullout_revocator");

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

  thread _meth_8329(1);
}

_meth_8329(var_00, var_01, var_02) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_03 = func_4A08(self, var_02);
  self.itemtype = var_3.name;
  removeperks();
  self.carriedsentry = var_03;

  if(var_00)
    var_3.firstplacement = 1;

  var_04 = func_F687(var_03, var_00, var_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_03))
    return 1;
  else
    return 0;
}

func_F687(var_00, var_01, var_02) {
  self endon("disconnect");
  var_00 func_E4B7(self, var_01);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_revocator", "+attack");
  self notifyonplayercommand("place_revocator", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_revocator", "+actionslot 3");

  if(!level.console) {
    self notifyonplayercommand("cancel_revocator", "+actionslot 5");
    self notifyonplayercommand("cancel_revocator", "+actionslot 6");
    self notifyonplayercommand("cancel_revocator", "+actionslot 7");
  }

  for(;;) {
    var_03 = scripts\engine\utility::waittill_any_return("place_revocator", "cancel_revocator", "force_cancel_placement");

    if(!isDefined(var_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03))
      var_03 = "force_cancel_placement";

    if(var_03 == "cancel_revocator" || var_03 == "force_cancel_placement") {
      if(!var_01 && var_03 == "cancel_revocator") {
        continue;
      }
      scripts\engine\utility::allow_weapon(1);
      var_00 func_E4B6();

      if(var_03 != "force_cancel_placement")
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

    var_00 func_E4B9(var_02, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeperks() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
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

func_4A08(var_00, var_01) {
  var_02 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_0.angles;
  var_2.owner = var_00;
  var_2.name = "crafted_revocator";
  var_2.carriedrevocator = spawn("script_model", var_2.origin);
  var_2.carriedrevocator.angles = var_0.angles;
  var_02 maketurretinoperable();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(var_00);

  if(!isDefined(var_01))
    var_2.func_130D2 = 1;
  else
    var_2.func_130D2 = var_01;

  var_02 func_E4B4(var_00);
  return var_02;
}

func_E4B4(var_00) {
  self.canbeplaced = 1;
  func_E4B8();
}

func_E4B1(var_00) {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  func_E4B8();
  playLoopSound(self.origin, "trap_revocator_deactivate");

  if(isDefined(self.charge_fx))
    self.charge_fx delete();

  if(isDefined(self.zap_model))
    self.zap_model delete();

  scripts\cp\utility::removefromtraplist();

  if(isDefined(self))
    self delete();
}

func_E4B9(var_00, var_01) {
  var_02 = spawn("script_model", self.origin + (0, 0, 1));
  var_2.angles = self.angles;
  var_02 solid();
  var_02 setModel(level.func_47B1["crafted_revocator"].placedmodel);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  var_2.owner = var_01;
  var_2.func_130D2 = self.func_130D2;
  var_2.name = "crafted_revocator";
  var_02 thread func_E4B5(var_00);
  var_02 playSound("trap_revocator_activate");
  self notify("placed");
  self.carriedrevocator delete();
  self delete();
}

func_E4B6() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner))
    self.owner.iscarrying = 0;

  self.carriedrevocator delete();
  self delete();
}

func_E4B7(var_00, var_01) {
  self setModel(level.func_47B1["crafted_revocator"].modelplacement);
  self hide();
  self setsentrycarrier(var_00);
  self setCanDamage(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedrevocator, level.func_47B1["crafted_revocator"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_00);
  thread scripts\cp\utility::item_ongameended(var_00);
  func_E4B8();
  self notify("carried");
}

func_E4B5(var_00) {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.func_47B1["crafted_revocator"].hintstring);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_E4B1(self.owner);
  thread scripts\cp\utility::item_handleownerdisconnect("elecrevocator_handleOwner");
  thread scripts\cp\utility::item_timeout(var_00, level.func_47B1["crafted_revocator"].timeout);
  thread func_E4B2();
  thread func_E4BA();
  scripts\cp\utility::addtotraplist();
  wait 1;
  self setscriptablepartstate("base", "idle");
}

func_E4B2() {
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
    self playSound("trap_revocator_pickup");
    var_00 thread _meth_8329(0, self.lifespan, self.func_130D2);

    if(isDefined(self.charge_fx))
      self.charge_fx delete();

    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_E4B8() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

func_E4BA() {
  self endon("death");
  var_00 = 0;
  var_01 = 1600;

  while(self.func_130D2 > 0) {
    var_02 = scripts\cp\cp_agent_utils::getaliveagents();
    var_02 = scripts\engine\utility::get_array_of_closest(self.origin, var_02);

    foreach(var_04 in var_02) {
      if(!isDefined(var_4.agent_type)) {
        continue;
      }
      if(var_4.agent_type == "superslasher" || var_4.agent_type == "slasher" || var_4.agent_type == "zombie_sasquatch" || var_4.agent_type == "lumberjack" || scripts\engine\utility::is_true(var_4.is_skeleton)) {
        continue;
      }
      if(!isDefined(var_04) || !isalive(var_04) || !var_4.entered_playspace || scripts\engine\utility::is_true(var_4.marked_for_death) || var_4.agent_type == "zombie_brute" || var_4.agent_type == "zombie_grey" || var_4.agent_type == "zombie_ghost" || var_4.team == "allies") {
        continue;
      }
      if(distancesquared(self.origin, var_4.origin) < var_01) {
        self setscriptablepartstate("base", "active");

        if(scripts\engine\utility::is_true(var_4.is_suicide_bomber) || scripts\engine\utility::is_true(var_4.is_dancing) || scripts\engine\utility::flag_exist("defense_sequence_active") && scripts\engine\utility::flag("defense_sequence_active"))
          var_04 getrandomarmkillstreak(var_4.health + 50, self.origin);
        else
          var_04 turn_zombie(self.owner);

        self.func_130D2--;
        wait 1;
        self setscriptablepartstate("base", "idle");

        if(self.func_130D2 <= 0) {
          break;
        }
      }
    }

    wait 0.1;
  }

  self notify("death");
}

turn_zombie(var_00) {
  var_01 = self;
  var_1.team = "allies";
  var_1.movemode = "sprint";
  var_1.is_reserved = 1;
  var_1.is_turned = 1;
  var_1.maxhealth = 900;
  var_1.health = 900;
  var_1.allowpain = 0;
  var_01 notify("turned");

  if(scripts\engine\utility::is_true(var_1.about_to_dance)) {
    if(isDefined(var_1.og_goalradius))
      var_1.goalradius = var_1.og_goalradius;

    var_1.og_goalradius = undefined;
    var_1.about_to_dance = 0;
    var_1.scripted_mode = 0;
  }

  var_1.melee_damage_amt = int(scripts\cp\zombies\zombies_spawning::calculatezombiehealth("generic_zombie") * 0.5);
  level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, var_01);
  level.current_enemy_deaths++;
  level.current_num_spawned_enemies--;
  var_01 setscriptablepartstate("eyes", "turned_eyes");
  var_01 setscriptablepartstate("pet", "active");
  var_01 thread kill_turned_zombie_after_time(180);
  var_01 thread remove_zombie_from_turned_list_on_death();

  if(isDefined(var_00))
    var_00 scripts\cp\cp_merits::processmerit("mt_turned_zombies");

  func_B2EB(var_01);
}

func_B2EB(var_00) {
  if(!isDefined(level.turned_zombies))
    level.turned_zombies = [];

  level.turned_zombies[level.turned_zombies.size] = var_00;

  if(level.turned_zombies.size > 6) {
    var_00 = level.turned_zombies[0];
    level.turned_zombies = scripts\engine\utility::array_remove(level.turned_zombies, var_00);
    var_00 getrandomarmkillstreak(var_0.health + 100, var_0.origin);
  }
}

kill_turned_zombie_after_time(var_00) {
  self endon("death");

  while(var_00 > 0) {
    wait 1;
    var_0--;
  }

  self getrandomarmkillstreak(self.health + 100, self.origin);
}

remove_zombie_from_turned_list_on_death() {
  self waittill("death");
  level.turned_zombies = scripts\engine\utility::array_remove(level.turned_zombies, self);
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}