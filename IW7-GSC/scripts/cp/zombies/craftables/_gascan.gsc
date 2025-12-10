/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\craftables\_gascan.gsc
*****************************************************/

init() {
  level._effect["candypile_fire"] = loadfx("vfx\iw7\_requests\coop\zmb_candypile_fire.vfx");
  level._effect["candypile_idle"] = loadfx("vfx\iw7\_requests\coop\zmb_candypile_idle.vfx");
  level.var_47AF = [];
  level.var_47AF["crafted_gascan"] = spawnStruct();
  level.var_47AF["crafted_gascan"].timeout = 180;
  level.var_47AF["crafted_gascan"].modelbase = "zmb_candybox_crafted_lod0";
  level.var_47AF["crafted_gascan"].modelplacement = "zmb_candybox_crafted_lod0";
  level.var_47AF["crafted_gascan"].modelplacementfailed = "zmb_candybox_crafted_lod0";
  level.var_47AF["crafted_gascan"].placedmodel = "zmb_candybox_crafted_lod0";
}

give_crafted_gascan(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_gascan");
  param_01 setclientomnvar("zom_crafted_weapon", 7);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_gascan", ::give_crafted_gascan, param_01);
}

watch_dpad() {
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self endon("death");
  self notifyonplayercommand("pullout_gascan", "+actionslot 3");
  for(;;) {
    self waittill("pullout_gascan");
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

  thread setdefaultdroppitch(1);
}

setdefaultdroppitch(param_00, param_01) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_02 = func_49CD(self);
  self.itemtype = var_02.name;
  removeperks();
  self.carriedsentry = var_02;
  var_03 = func_F683(var_02, param_00, param_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_02)) {
    return 1;
  }

  return 0;
}

func_F683(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 func_76CA(self, param_01);
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
    if(!isDefined(param_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_gascan" || var_03 == "force_cancel_placement") {
      if(!param_01 && var_03 == "cancel_gascan") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      param_00 func_76C9();
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

    param_00 thread func_76C8(param_02, self);
    self waittill("gas_poured");
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

func_49CD(param_00) {
  var_01 = spawnturret("misc_turret", param_00.origin + (0, 0, 25), "sentry_minigun_mp");
  var_01.angles = param_00.angles;
  var_01.triggerportableradarping = param_00;
  var_01.name = "crafted_gascan";
  var_01.carriedgascan = spawn("script_model", var_01.origin);
  var_01.carriedgascan.angles = param_00.angles;
  var_01 getvalidattachments();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(param_00);
  var_01 func_76C7(param_00);
  var_01 setcontents(0);
  var_01.carriedgascan setcontents(0);
  return var_01;
}

func_76C7(param_00) {
  self.canbeplaced = 1;
}

func_76C8(param_00, param_01) {
  param_01 endon("disconnect");
  self.var_9F05 = 1;
  if(!isDefined(level.var_38B3)) {
    level.var_38B3 = [];
  }

  for(;;) {
    for(var_02 = 0; param_01 attackbuttonpressed() && var_02 <= 4; var_02++) {
      if(!self.canbeplaced) {
        wait(0.05);
        continue;
      }

      if(!isDefined(self.var_8C16)) {
        self.var_8C16 = 0;
      }

      param_01 playSound("trap_kindle_pops_pour");
      self.var_9F05 = 1;
      func_1070D(param_01, self);
      self.var_8C16++;
      self.var_BE9C = 1;
      wait(0.35);
    }

    if(var_02 > 4) {
      break;
    }

    self.var_9F05 = undefined;
    wait(0.05);
  }

  self.var_9F05 = undefined;
  param_01 notify("gas_poured");
  var_03 = spawn("script_model", self.carriedgascan.origin);
  var_03.angles = self.carriedgascan.angles;
  var_03 setModel(level.var_47AF["crafted_gascan"].placedmodel);
  var_03 physicslaunchserver(var_03.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0), (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 10));
  var_03 playSound("trap_kindle_pops_can_drop");
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  param_01.iscarrying = 0;
  self notify("placed");
  self.carriedgascan delete();
  self delete();
  wait(1);
  param_01 scripts\cp\utility::setlowermessage("candy_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_SHOOT_TO_IGNITE", 4);
  wait(15);
  var_03 delete();
}

func_135B5(param_00) {
  thread func_92DF();
  thread func_76C2();
  thread func_76C3(level.var_47AF["crafted_gascan"].timeout);
  self waittill("gas_spot_damaged");
  self playSound("trap_kindle_pops_ignite");
  var_01 = gettime() + -25536;
  self notify("damage_monitor");
  thread func_76C0(var_01, param_00);
}

func_92DF() {
  self endon("gas_spot_damaged");
  self.fx = spawnfx(level._effect["candypile_idle"], self.origin);
  scripts\engine\utility::waitframe();
  triggerfx(self.fx);
}

func_76C3(param_00) {
  self endon("gas_spot_damaged");
  wait(param_00);
  self notify("damage_monitor");
  level.var_38B3 = scripts\engine\utility::array_remove(level.var_38B3, self);
  self.fx delete();
  scripts\cp\utility::removefromtraplist();
  self delete();
}

func_76C2() {
  self endon("damage_monitor");
  var_00 = 9216;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isplayer(var_02) && isDefined(var_0A) && var_05 != "MOD_MELEE") {
      self notify("gas_spot_damaged");
      foreach(var_0C in level.var_38B3) {
        if(var_0C == self) {
          continue;
        }

        if(distancesquared(var_0C.origin, self.origin) > var_00) {
          continue;
        } else {
          var_0C notify("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
        }
      }

      return;
    }
  }
}

func_76C0(param_00, param_01) {
  self.fx delete();
  scripts\engine\utility::waitframe();
  self playLoopSound("trap_kindle_pops_fire_lp");
  self.fx = spawnfx(level._effect["candypile_fire"], self.origin);
  scripts\engine\utility::waitframe();
  triggerfx(self.fx);
  self.var_4D27 = spawn("trigger_radius", self.origin, 1, 64, 32);
  self.var_4D27.var_336 = "kindlepops_trig";
  self.var_4D27.triggerportableradarping = param_01;
  thread func_76C1();
  while(gettime() < param_00) {
    wait(0.1);
  }

  playsoundatpos(self.origin, "trap_kindle_pops_fire_end");
  self stoploopsound();
  self.var_4D27 delete();
  self.fx delete();
  level.var_38B3 = scripts\engine\utility::array_remove(level.var_38B3, self);
  self delete();
}

func_76C1() {
  self.var_4D27 endon("death");
  for(;;) {
    self.var_4D27 waittill("trigger", var_00);
    if(isplayer(var_00) && isalive(var_00) && !scripts\cp\cp_laststand::player_in_laststand(var_00) && !isDefined(var_00.padding_damage)) {
      var_00.padding_damage = 1;
      var_00 dodamage(15, var_00.origin);
      var_00 thread remove_padding_damage();
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_00)) {
      continue;
    }

    var_00 func_3B25(2, var_00.health + 5, self.var_4D27);
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}

func_3B25(param_00, param_01, param_02) {
  if(isalive(self) && !scripts\engine\utility::istrue(self.marked_for_death) && !scripts\engine\utility::istrue(self.is_chem_burning)) {
    thread scripts\cp\utility::damage_over_time(self, param_02, param_00, param_01, undefined, "iw7_kindlepops_zm", undefined, "chemBurn");
  }
}

func_1070D(param_00, param_01) {
  var_02 = ["zmb_candy_pile_01", "zmb_candy_pile_02"];
  var_03 = spawn("script_model", param_01.origin + (0, 0, 5));
  var_03.angles = self.angles;
  var_03 setModel(scripts\engine\utility::random(var_02));
  var_04 = 100;
  var_05 = getgroundposition(param_01.origin, 4);
  var_03 moveto(var_05 + (0, 0, 1), 0.25);
  foreach(var_07 in level.var_38B3) {
    if(distancesquared(var_07.origin, var_03.origin) < 100) {
      var_03 delete();
      break;
    }
  }

  if(!isDefined(var_03)) {
    return;
  }

  var_03 setCanDamage(1);
  var_03.health = 10000;
  var_03.triggerportableradarping = param_00;
  var_03.name = "crafted_gascan";
  param_00.itemtype = var_03.name;
  level.var_38B3[level.var_38B3.size] = var_03;
  var_03 scripts\cp\utility::addtotraplist();
  var_03 thread func_135B5(param_00);
}

func_76C9() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedgascan delete();
  self delete();
}

func_76CA(param_00, param_01) {
  if(isDefined(self.originalowner)) {} else {}

  self setModel(level.var_47AF["crafted_gascan"].modelplacement);
  self hide();
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread func_12EA0(self, param_01);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  self notify("carried");
}

func_12EA0(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  param_00.canbeplaced = 1;
  var_02 = -1;
  param_00.var_BE9C = 0;
  for(;;) {
    param_00.canbeplaced = func_3831(param_00);
    if(param_00.canbeplaced != var_02 || param_00.var_BE9C) {
      param_00.var_BE9C = 0;
      if(param_00.canbeplaced) {
        param_00.carriedgascan setModel(level.var_47AF["crafted_gascan"].modelplacement);
        if(!isDefined(param_00.var_8C16)) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_CANCELABLE");
        } else if(param_00.var_8C16 == 1) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_80");
        } else if(param_00.var_8C16 == 2) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_60");
        } else if(param_00.var_8C16 == 3) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_40");
        } else if(param_00.var_8C16 == 4) {
          self forceusehinton(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_20");
        }
      } else {
        param_00.carriedgascan setModel(level.var_47AF["crafted_gascan"].modelplacementfailed);
        self forceusehinton(&"COOP_CRAFTABLES_CANNOT_PLACE");
      }
    }

    var_02 = param_00.canbeplaced;
    wait(0.05);
  }
}

func_3831(param_00) {
  var_01 = self canplayerplacesentry();
  param_00.origin = var_01["origin"];
  param_00.angles = var_01["angles"];
  param_00.carriedgascan.origin = var_01["origin"] + (0, 0, 35);
  param_00.name = "crafted_gascan";
  param_00.carriedgascan.name = "crafted_gascan";
  if(isDefined(param_00.var_9F05)) {
    param_00.carriedgascan.angles = var_01["angles"] + (35, 0, 0);
  } else {
    param_00.carriedgascan.angles = var_01["angles"];
  }

  return self isonground() && var_01["result"] && abs(var_01["origin"][2] - self.origin[2]) < 30;
}