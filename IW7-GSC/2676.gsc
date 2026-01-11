/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2676.gsc
***************************************/

init() {
  level._effect["candypile_fire"] = loadfx("vfx\iw7\_requests\coop\zmb_candypile_fire.vfx");
  level._effect["candypile_idle"] = loadfx("vfx\iw7\_requests\coop\zmb_candypile_idle.vfx");
  level.func_47AF = [];
  level.func_47AF["crafted_gascan"] = spawnStruct();
  level.func_47AF["crafted_gascan"].timeout = 180;
  level.func_47AF["crafted_gascan"].modelbase = "zmb_candybox_crafted_lod0";
  level.func_47AF["crafted_gascan"].modelplacement = "zmb_candybox_crafted_lod0";
  level.func_47AF["crafted_gascan"].modelplacementfailed = "zmb_candybox_crafted_lod0";
  level.func_47AF["crafted_gascan"].placedmodel = "zmb_candybox_crafted_lod0";
}

give_crafted_gascan(var_00, var_01) {
  var_01 thread watch_dpad();
  var_01 notify("new_power", "crafted_gascan");
  var_01 setclientomnvar("zom_crafted_weapon", 7);
  var_01 thread scripts\cp\utility::usegrenadegesture(var_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_gascan", ::give_crafted_gascan, var_01);
}

watch_dpad() {
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self endon("death");
  self notifyonplayercommand("pullout_gascan", "+actionslot 3");

  for(;;) {
    self waittill("pullout_gascan");

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

  thread setdefaultdroppitch(1);
}

setdefaultdroppitch(var_00, var_01) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_02 = func_49CD(self);
  self.itemtype = var_2.name;
  removeperks();
  self.carriedsentry = var_02;
  var_03 = func_F683(var_02, var_00, var_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_02)) {
    return 1;
  } else {
    return 0;
  }
}

func_F683(var_00, var_01, var_02) {
  self endon("disconnect");
  var_00 func_76CA(self, var_01);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_gascan", "+attack");
  self notifyonplayercommand("place_gascan", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_gascan", "+actionslot 3");

  if(!level.console) {
    self notifyonplayercommand("cancel_gascan", "+actionslot 5");
    self notifyonplayercommand("cancel_gascan", "+actionslot 6");
    self notifyonplayercommand("cancel_gascan", "+actionslot 7");
  }

  for(;;) {
    var_03 = scripts\engine\utility::waittill_any_return("place_gascan", "cancel_gascan", "force_cancel_placement");

    if(!isDefined(var_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_gascan" || var_03 == "force_cancel_placement") {
      if(!var_01 && var_03 == "cancel_gascan") {
        continue;
      }
      scripts\engine\utility::allow_weapon(1);
      var_00 func_76C9();

      if(var_03 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(var_01) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    if(var_01) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_00 thread func_76C8(var_02, self);
    self waittill("gas_poured");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self.hasriotshield) {
    var_00 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_00;
    self.riotshieldammo = self getammocount(var_00);
    self giveuponsuppressiontime(var_00);
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
  wait 0.05;
  restoreperks();
}

func_49CD(var_00) {
  var_01 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.owner = var_00;
  var_1.name = "crafted_gascan";
  var_1.carriedgascan = spawn("script_model", var_1.origin);
  var_1.carriedgascan.angles = var_0.angles;
  var_01 maketurretinoperable();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(var_00);
  var_01 func_76C7(var_00);
  var_01 setcontents(0);
  var_1.carriedgascan setcontents(0);
  return var_01;
}

func_76C7(var_00) {
  self.canbeplaced = 1;
}

func_76C8(var_00, var_01) {
  var_01 endon("disconnect");
  self.func_9F05 = 1;

  if(!isDefined(level.func_38B3)) {
    level.func_38B3 = [];
  }

  var_02 = 0;

  for(;;) {
    while(var_01 attackbuttonpressed() && var_02 <= 4) {
      if(!self.canbeplaced) {
        wait 0.05;
        continue;
      }

      if(!isDefined(self.func_8C16)) {
        self.func_8C16 = 0;
      }

      var_01 playSound("trap_kindle_pops_pour");
      self.func_9F05 = 1;
      func_1070D(var_01, self);
      self.func_8C16++;
      self.func_BE9C = 1;
      wait 0.35;
      var_2++;
    }

    if(var_02 > 4) {
      break;
    }
    self.func_9F05 = undefined;
    wait 0.05;
  }

  self.func_9F05 = undefined;
  var_01 notify("gas_poured");
  var_03 = spawn("script_model", self.carriedgascan.origin);
  var_3.angles = self.carriedgascan.angles;
  var_03 setModel(level.func_47AF["crafted_gascan"].placedmodel);
  var_03 physicslaunchserver(var_3.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0), (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 10));
  var_03 playSound("trap_kindle_pops_can_drop");
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  self notify("placed");
  self.carriedgascan delete();
  self delete();
  wait 1;
  var_01 scripts\cp\utility::setlowermessage("candy_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_SHOOT_TO_IGNITE", 4);
  wait 15;
  var_03 delete();
}

func_135B5(var_00) {
  thread func_92DF();
  thread func_76C2();
  thread func_76C3(level.func_47AF["crafted_gascan"].timeout);
  self waittill("gas_spot_damaged");
  self playSound("trap_kindle_pops_ignite");
  var_01 = gettime() + 40000;
  self notify("damage_monitor");
  thread func_76C0(var_01, var_00);
}

func_92DF() {
  self endon("gas_spot_damaged");
  self.fx = spawnfx(level._effect["candypile_idle"], self.origin);
  scripts\engine\utility::waitframe();
  triggerfx(self.fx);
}

func_76C3(var_00) {
  self endon("gas_spot_damaged");
  wait(var_00);
  self notify("damage_monitor");
  level.func_38B3 = scripts\engine\utility::array_remove(level.func_38B3, self);
  self.fx delete();
  scripts\cp\utility::removefromtraplist();
  self delete();
}

func_76C2() {
  self endon("damage_monitor");
  var_00 = 9216;

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);

    if(isplayer(var_02) && isDefined(var_10) && var_05 != "MOD_MELEE") {
      self notify("gas_spot_damaged");

      foreach(var_12 in level.func_38B3) {
        if(var_12 == self) {
          continue;
        }
        if(distancesquared(var_12.origin, self.origin) > var_00) {
          continue;
        } else {
          var_12 notify("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
        }
      }

      return;
    }
  }
}

func_76C0(var_00, var_01) {
  self.fx delete();
  scripts\engine\utility::waitframe();
  self playLoopSound("trap_kindle_pops_fire_lp");
  self.fx = spawnfx(level._effect["candypile_fire"], self.origin);
  scripts\engine\utility::waitframe();
  triggerfx(self.fx);
  self.func_4D27 = spawn("trigger_radius", self.origin, 1, 64, 32);
  self.func_4D27.targetname = "kindlepops_trig";
  self.func_4D27.owner = var_01;
  thread func_76C1();

  while(gettime() < var_00) {
    wait 0.1;
  }

  playLoopSound(self.origin, "trap_kindle_pops_fire_end");
  self stoploopsound();
  self.func_4D27 delete();
  self.fx delete();
  level.func_38B3 = scripts\engine\utility::array_remove(level.func_38B3, self);
  self delete();
}

func_76C1() {
  self.func_4D27 endon("death");

  for(;;) {
    self.func_4D27 waittill("trigger", var_00);

    if(isplayer(var_00) && isalive(var_00) && !scripts\cp\cp_laststand::player_in_laststand(var_00) && !isDefined(var_0.padding_damage)) {
      var_0.padding_damage = 1;
      var_00 getrandomarmkillstreak(15, var_0.origin);
      var_00 thread remove_padding_damage();
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_00)) {
      continue;
    }
    var_00 func_3B25(2, var_0.health + 5, self.func_4D27);
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait 0.5;
  self.padding_damage = undefined;
}

func_3B25(var_00, var_01, var_02) {
  if(isalive(self) && !scripts\engine\utility::is_true(self.marked_for_death) && !scripts\engine\utility::is_true(self.is_chem_burning)) {
    thread scripts\cp\utility::damage_over_time(self, var_02, var_00, var_01, undefined, "iw7_kindlepops_zm", undefined, "chemBurn");
  }
}

func_1070D(var_00, var_01) {
  var_02 = ["zmb_candy_pile_01", "zmb_candy_pile_02"];
  var_03 = spawn("script_model", var_1.origin + (0, 0, 5));
  var_3.angles = self.angles;
  var_03 setModel(scripts\engine\utility::random(var_02));
  var_04 = 100;
  var_05 = getgroundposition(var_1.origin, 4);
  var_03 moveto(var_05 + (0, 0, 1), 0.25);

  foreach(var_07 in level.func_38B3) {
    if(distancesquared(var_7.origin, var_3.origin) < 100) {
      var_03 delete();
      break;
    }
  }

  if(!isDefined(var_03)) {
    return;
  }
  var_03 setCanDamage(1);
  var_3.health = 10000;
  var_3.owner = var_00;
  var_3.name = "crafted_gascan";
  var_0.itemtype = var_3.name;
  level.func_38B3[level.func_38B3.size] = var_03;
  var_03 scripts\cp\utility::addtotraplist();
  var_03 thread func_135B5(var_00);
}

func_76C9() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self.carriedgascan delete();
  self delete();
}

func_76CA(var_00, var_01) {
  if(isDefined(self.originalowner)) {} else {}

  self setModel(level.func_47AF["crafted_gascan"].modelplacement);
  self hide();
  self setsentrycarrier(var_00);
  self setCanDamage(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread func_12EA0(self, var_01);
  thread scripts\cp\utility::item_oncarrierdeath(var_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_00);
  thread scripts\cp\utility::item_ongameended(var_00);
  self notify("carried");
}

func_12EA0(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_02 = -1;
  var_0.func_BE9C = 0;

  for(;;) {
    var_0.canbeplaced = func_3831(var_00);

    if(var_0.canbeplaced != var_02 || var_0.func_BE9C) {
      var_0.func_BE9C = 0;

      if(var_0.canbeplaced) {
        var_0.carriedgascan setModel(level.func_47AF["crafted_gascan"].modelplacement);

        if(!isDefined(var_0.func_8C16)) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_CANCELABLE");
        } else if(var_0.func_8C16 == 1) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_80");
        } else if(var_0.func_8C16 == 2) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_60");
        } else if(var_0.func_8C16 == 3) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_40");
        } else if(var_0.func_8C16 == 4) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_20");
        }
      } else {
        var_0.carriedgascan setModel(level.func_47AF["crafted_gascan"].modelplacementfailed);
        self forceusehinton(&"COOP_CRAFTABLES_CANNOT_PLACE");
      }
    }

    var_02 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_3831(var_00) {
  var_01 = self canplayerplacesentry();
  var_0.origin = var_1["origin"];
  var_0.angles = var_1["angles"];
  var_0.carriedgascan.origin = var_1["origin"] + (0, 0, 35);
  var_0.name = "crafted_gascan";
  var_0.carriedgascan.name = "crafted_gascan";

  if(isDefined(var_0.func_9F05)) {
    var_0.carriedgascan.angles = var_1["angles"] + (35, 0, 0);
  } else {
    var_0.carriedgascan.angles = var_1["angles"];
  }

  return self isonground() && var_1["result"] && abs(var_1["origin"][2] - self.origin[2]) < 30;
}