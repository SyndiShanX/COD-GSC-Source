/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3391.gsc
*********************************************/

init_arcade_counter_ammo_slot() {
  var_0 = scripts\engine\utility::getstructarray("arcade_counter_ammo", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9593();
  }
}

init_arcade_grenade_slot() {
  var_0 = scripts\engine\utility::getstructarray("arcade_counter_grenade", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9593();
  }
}

init_small_counter_slot() {
  level thread func_3E93();
  var_0 = scripts\engine\utility::getstructarray("small_ticket_prize", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9593();
    wait(0.05);
  }
}

init_medium_counter_slot() {
  var_0 = scripts\engine\utility::getstructarray("medium_ticket_prize", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9593();
    wait(0.05);
  }
}

init_large_counter_slot() {
  level.var_A857 = ["attachment_zmb_arcane_muzzlebrake_wm"];
  var_0 = scripts\engine\utility::getstructarray("large_ticket_prize", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_9593();
  }
}

func_136DE(var_0) {
  for(;;) {
    level notify("ticket_counter_choose_power", var_0);
    wait(0.25);
    level waittill("prize_restock");
  }
}

func_9593() {
  if(self.script_noteworthy == "small_ticket_prize" || self.script_noteworthy == "medium_ticket_prize") {
    thread func_136DE(self);
    wait(0.25);
  }

  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0);
  self.randomintrange = spawn("script_model", var_1.origin);
  self.randomintrange.angles = var_1.angles;
  var_2 = func_7CF9(self.script_noteworthy);
  self.randomintrange setModel(var_2);
  var_3 = func_7CFB(var_2);
  self.randomintrange.origin = self.randomintrange.origin + var_3;
  var_4 = func_7CFA(self, var_2);
  self.randomintrange.angles = self.randomintrange.angles + var_4;
  self.randomintrange.hint_string = func_7CF8(self, var_2);
  var_5 = getEntArray(self.target, "targetname");
  if(var_5.size > 0) {
    self.setminimap = scripts\engine\utility::getclosest(self.origin, var_5);
    thread func_12988();
  }
}

func_3E93() {
  var_0 = ["power_rewind", "power_transponder", "power_tripMine", "power_blackholeGrenade"];
  if(scripts\cp\utility::is_codxp()) {
    var_0 = ["power_rewind", "power_tripMine", "power_blackholeGrenade"];
  }

  level.var_1033F = var_0;
  var_1 = ["power_armageddon", "power_portalGenerator", "power_repulsor"];
  level.var_B534 = var_1;
  for(;;) {
    level waittill("ticket_counter_choose_power", var_2);
    if(var_2.script_noteworthy == "small_ticket_prize") {
      if(level.var_1033F.size < 1) {
        level.var_1033F = var_0;
      }

      var_2.power = scripts\engine\utility::random(level.var_1033F);
      level.var_1033F = scripts\engine\utility::array_remove(level.var_1033F, var_2.power);
      if(isDefined(var_2.randomintrange)) {
        var_3 = func_7CF9(var_2.script_noteworthy);
        var_2.randomintrange.hint_string = func_7CF8(var_2, var_3);
      }

      continue;
    }

    if(var_2.script_noteworthy == "medium_ticket_prize") {
      if(level.var_B534.size < 1) {
        level.var_B534 = var_1;
      }

      var_2.power = scripts\engine\utility::random(level.var_B534);
      level.var_B534 = scripts\engine\utility::array_remove(level.var_B534, var_2.power);
      if(isDefined(var_2.randomintrange)) {
        var_3 = func_7CF9(var_2.script_noteworthy);
        var_2.randomintrange.hint_string = func_7CF8(var_2, var_3);
      }
    }
  }
}

func_12988() {
  wait(10);
  for(var_0 = 0; var_0 < 4; var_0++) {
    self.setminimap setlightintensity(65);
    wait(randomfloat(1));
    self.setminimap setlightintensity(0);
    wait(randomfloat(1));
  }

  self.setminimap setlightintensity(100);
  self.powered_on = 1;
}

turn_on_light() {
  if(isDefined(self.setminimap)) {
    for(;;) {
      var_0 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", "power_off");
      if(var_0 == "power_off") {
        self.setminimap setlightintensity(0);
        self.powered_on = 0;
        continue;
      }

      for(var_1 = 0; var_1 < 4; var_1++) {
        self.setminimap setlightintensity(65);
        wait(randomfloat(1));
        self.setminimap setlightintensity(0);
        wait(randomfloat(1));
      }

      self.setminimap setlightintensity(100);
      self.powered_on = 1;
    }
  }
}

ticket_counter_slot_activation(var_0, var_1) {
  if(var_0.script_noteworthy == "small_ticket_prize" || var_0.script_noteworthy == "medium_ticket_prize") {
    var_2 = var_0.power;
    if(isDefined(level.powers[var_2].defaultslot)) {
      var_3 = level.powers[var_2].defaultslot;
    } else {
      var_3 = "secondary";
    }

    var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
    thread deactivate_ticket_counter_slot(var_0, var_1, 1);
    return;
  }

  if(var_0[[func_77CB(var_0)]](var_0, var_1)) {
    thread deactivate_ticket_counter_slot(var_0, var_1);
  }
}

deactivate_ticket_counter_slot(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 notify("deactivated");
  if(scripts\engine\utility::istrue(var_2)) {
    var_0.randomintrange hide();
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  } else {
    if(isDefined(var_0.randomintrange)) {
      var_0.randomintrange hidefromplayer(var_1);
    }

    if(isDefined(var_0.trigger)) {
      var_0.trigger hidefromplayer(var_1);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }

  thread func_10149(var_0, var_1, var_2);
}

func_10149(var_0, var_1, var_2) {
  level endon("game_ended");
  level waittill("prize_restock");
  if(isDefined(var_0.randomintrange)) {
    playsoundatpos(var_0.randomintrange.origin, "zmb_prize_restock");
    playFX(level._effect["booth_respawn"], var_0.randomintrange.origin);
  } else {
    playsoundatpos(var_0.origin, "zmb_prize_restock");
    playFX(level._effect["booth_respawn"], var_0.origin);
  }

  if(scripts\engine\utility::istrue(var_2)) {
    var_0.randomintrange show();
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_0.randomintrange)) {
      var_0.randomintrange showtoplayer(var_1);
    }

    if(isDefined(var_0.trigger)) {
      var_0.trigger showtoplayer(var_1);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_1);
  }
}

func_7CF9(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "small_ticket_prize":
      var_1 = "foam_grenade_vm";
      break;

    case "arcade_counter_ammo":
      var_1 = "food_trash_bag_paper_01";
      break;

    case "arcade_counter_grenade":
      var_1 = "grenade_bag";
      break;

    case "medium_ticket_prize":
      var_1 = "equipment_oxygen_tank_01";
      break;

    case "large_ticket_prize":
      if(!isDefined(level.var_A857) || level.var_A857.size < 1) {
        level.var_A857 = ["attachment_zmb_arcane_muzzlebrake_wm"];
      }

      var_1 = scripts\engine\utility::random(level.var_A857);
      level.var_A857 = scripts\engine\utility::array_remove(level.var_A857, var_1);
      break;

    default:
      break;
  }

  return var_1;
}

func_7CFB(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "equipment_oxygen_tank_01":
      var_1 = (0, 0, 0);
      break;

    case "food_trash_bag_paper_01":
      var_1 = (0, 0, 0);
      break;

    case "grenade_bag":
      var_1 = (0, 0, 0);
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_1 = (0, 0, 0);
      break;

    case "foam_grenade_vm":
      var_1 = (0, 0, 0);
      break;

    default:
      break;
  }

  return var_1;
}

func_7CFA(var_0, var_1) {
  var_2 = undefined;
  switch (var_1) {
    case "equipment_oxygen_tank_01":
      var_2 = (0, 0, 0);
      break;

    case "food_trash_bag_paper_01":
      var_2 = (0, -90, 0);
      break;

    case "grenade_bag":
      var_2 = (360, 270, 0);
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_2 = (0, 0, 0);
      break;

    case "foam_grenade_vm":
      var_2 = (0, 0, 0);
      break;

    default:
      break;
  }

  return var_2;
}

func_77CB(var_0) {
  var_1 = undefined;
  switch (var_0.script_noteworthy) {
    case "arcade_counter_ammo":
      var_1 = ::func_2761;
      break;

    case "arcade_counter_grenade":
      var_1 = ::func_857F;
      break;

    case "large_ticket_prize":
      var_1 = ::func_10931;
      break;

    default:
      break;
  }

  return var_1;
}

func_2761(var_0, var_1) {
  var_1 playlocalsound("purchase_ticket");
  var_2 = var_1 getweaponslistprimaries();
  foreach(var_4 in var_2) {
    var_1 givemaxammo(var_4);
    if(weaponmaxammo(var_4) == weaponclipsize(var_4)) {
      var_1 setweaponammoclip(var_4, weaponclipsize(var_4));
    }
  }

  return 1;
}

func_857F(var_0, var_1) {
  var_1 playlocalsound("purchase_ticket");
  scripts\cp\gametypes\zombie::replace_grenades_on_player(var_1);
  return 1;
}

func_10931(var_0, var_1) {
  var_2 = scripts\cp\utility::get_attachment_from_interaction(var_0);
  var_3 = var_1 getcurrentweapon();
  if(var_1 scripts\cp\utility::weaponhasattachment(var_3, var_2)) {
    return 0;
  }

  if(!var_1 scripts\cp\cp_weapon::can_use_attachment(var_2, var_3)) {
    return 0;
  }

  thread deactivate_ticket_counter_slot(var_0, var_1, 1);
  var_4 = var_1 scripts\cp\cp_weapon::add_attachment_to_weapon(var_2, var_3, 1);
  if(var_4) {
    var_1 notify("weapon_purchased");
  }

  if(var_2 == "arcane_base" && var_4 == 1) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("part_collect_arcane", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
  }

  return var_4;
}

func_E193(var_0, var_1) {
  wait(120);
  var_0.randomintrange show();
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

func_7CF8(var_0, var_1) {
  var_2 = undefined;
  switch (var_1) {
    case "foam_grenade_vm":
      if(var_0.power == "power_phaseShift") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_PHASESHIFT";
      } else if(var_0.power == "power_kineticPulse") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_KINETICPULSE";
      } else if(var_0.power == "power_rewind") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_REWIND";
      } else if(var_0.power == "power_transponder") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_TRANSPONDER";
      } else if(var_0.power == "power_tripMine") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_TRIPMINE";
      } else if(var_0.power == "power_blackholeGrenade") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_BHGRENADE";
      } else if(var_0.power == "power_repulsor") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_REPULSOR";
      }
      break;

    case "equipment_oxygen_tank_01":
      if(var_0.power == "power_armageddon") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_ARMAGEDDON";
      } else if(var_0.power == "power_microTurret") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_MICROTURRRET";
      } else if(var_0.power == "power_portalGenerator") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_PORTALGENERATOR";
      } else if(var_0.power == "power_deployableCover") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_DEPLOYABLECOVER";
      } else if(var_0.power == "power_repulsor") {
        var_2 = &"CP_ZMB_INTERACTIONS_TICKET_REPULSOR";
      }
      break;

    case "food_trash_bag_paper_01":
      var_2 = &"CP_ZMB_INTERACTIONS_BAG_O_BULLETS";
      break;

    case "grenade_bag":
      var_2 = &"CP_ZMB_INTERACTIONS_GRENADE_POUCH";
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_2 = &"CP_ZMB_INTERACTIONS_BUY_ARCANE_CORE";
      break;

    default:
      break;
  }

  return var_2;
}

ticket_counter_slot_hint_func(var_0, var_1) {
  if(!isDefined(var_1.ticket_item_outlined)) {
    var_1.ticket_item_outlined = var_0.randomintrange;
    if(self.num_tickets >= level.interactions[var_0.script_noteworthy].cost) {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 3, 1, 0);
    } else {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 1, 1, 0);
    }
  } else if(var_1.ticket_item_outlined != var_0.randomintrange) {
    var_1.ticket_item_outlined hudoutlinedisableforclient(var_1);
    var_1.ticket_item_outlined = var_0.randomintrange;
    if(self.num_tickets >= level.interactions[var_0.script_noteworthy].cost) {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 3, 1, 0);
    } else {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 1, 1, 0);
    }
  }

  return var_0.randomintrange.hint_string;
}