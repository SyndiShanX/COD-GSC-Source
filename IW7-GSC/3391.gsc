/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3391.gsc
************************/

init_arcade_counter_ammo_slot() {
  var_00 = scripts\engine\utility::getstructarray("arcade_counter_ammo", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_9593();
  }
}

init_arcade_grenade_slot() {
  var_00 = scripts\engine\utility::getstructarray("arcade_counter_grenade", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_9593();
  }
}

init_small_counter_slot() {
  level thread func_3E93();
  var_00 = scripts\engine\utility::getstructarray("small_ticket_prize", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_9593();
    wait(0.05);
  }
}

init_medium_counter_slot() {
  var_00 = scripts\engine\utility::getstructarray("medium_ticket_prize", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_9593();
    wait(0.05);
  }
}

init_large_counter_slot() {
  level.var_A857 = ["attachment_zmb_arcane_muzzlebrake_wm"];
  var_00 = scripts\engine\utility::getstructarray("large_ticket_prize", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_9593();
  }
}

func_136DE(param_00) {
  for(;;) {
    level notify("ticket_counter_choose_power", param_00);
    wait(0.25);
    level waittill("prize_restock");
  }
}

func_9593() {
  if(self.script_noteworthy == "small_ticket_prize" || self.script_noteworthy == "medium_ticket_prize") {
    thread func_136DE(self);
    wait(0.25);
  }

  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_01 = scripts\engine\utility::getclosest(self.origin, var_00);
  self.randomintrange = spawn("script_model", var_01.origin);
  self.randomintrange.angles = var_01.angles;
  var_02 = func_7CF9(self.script_noteworthy);
  self.randomintrange setModel(var_02);
  var_03 = func_7CFB(var_02);
  self.randomintrange.origin = self.randomintrange.origin + var_03;
  var_04 = func_7CFA(self, var_02);
  self.randomintrange.angles = self.randomintrange.angles + var_04;
  self.randomintrange.hint_string = func_7CF8(self, var_02);
  var_05 = getEntArray(self.target, "targetname");
  if(var_05.size > 0) {
    self.setminimap = scripts\engine\utility::getclosest(self.origin, var_05);
    thread func_12988();
  }
}

func_3E93() {
  var_00 = ["power_rewind", "power_transponder", "power_tripMine", "power_blackholeGrenade"];
  if(scripts\cp\utility::is_codxp()) {
    var_00 = ["power_rewind", "power_tripMine", "power_blackholeGrenade"];
  }

  level.var_1033F = var_00;
  var_01 = ["power_armageddon", "power_portalGenerator", "power_repulsor"];
  level.var_B534 = var_01;
  for(;;) {
    level waittill("ticket_counter_choose_power", var_02);
    if(var_02.script_noteworthy == "small_ticket_prize") {
      if(level.var_1033F.size < 1) {
        level.var_1033F = var_00;
      }

      var_02.power = scripts\engine\utility::random(level.var_1033F);
      level.var_1033F = scripts\engine\utility::array_remove(level.var_1033F, var_02.power);
      if(isDefined(var_02.randomintrange)) {
        var_03 = func_7CF9(var_02.script_noteworthy);
        var_02.randomintrange.hint_string = func_7CF8(var_02, var_03);
      }

      continue;
    }

    if(var_02.script_noteworthy == "medium_ticket_prize") {
      if(level.var_B534.size < 1) {
        level.var_B534 = var_01;
      }

      var_02.power = scripts\engine\utility::random(level.var_B534);
      level.var_B534 = scripts\engine\utility::array_remove(level.var_B534, var_02.power);
      if(isDefined(var_02.randomintrange)) {
        var_03 = func_7CF9(var_02.script_noteworthy);
        var_02.randomintrange.hint_string = func_7CF8(var_02, var_03);
      }
    }
  }
}

func_12988() {
  wait(10);
  for(var_00 = 0; var_00 < 4; var_00++) {
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
      var_00 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", "power_off");
      if(var_00 == "power_off") {
        self.setminimap setlightintensity(0);
        self.powered_on = 0;
        continue;
      }

      for(var_01 = 0; var_01 < 4; var_01++) {
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

ticket_counter_slot_activation(param_00, param_01) {
  if(param_00.script_noteworthy == "small_ticket_prize" || param_00.script_noteworthy == "medium_ticket_prize") {
    var_02 = param_00.power;
    if(isDefined(level.powers[var_02].defaultslot)) {
      var_03 = level.powers[var_02].defaultslot;
    } else {
      var_03 = "secondary";
    }

    param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
    thread deactivate_ticket_counter_slot(param_00, param_01, 1);
    return;
  }

  if(param_00[[func_77CB(param_00)]](param_00, param_01)) {
    thread deactivate_ticket_counter_slot(param_00, param_01);
  }
}

deactivate_ticket_counter_slot(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 notify("deactivated");
  if(scripts\engine\utility::istrue(param_02)) {
    param_00.randomintrange hide();
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  } else {
    if(isDefined(param_00.randomintrange)) {
      param_00.randomintrange hidefromplayer(param_01);
    }

    if(isDefined(param_00.trigger)) {
      param_00.trigger hidefromplayer(param_01);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  }

  thread func_10149(param_00, param_01, param_02);
}

func_10149(param_00, param_01, param_02) {
  level endon("game_ended");
  level waittill("prize_restock");
  if(isDefined(param_00.randomintrange)) {
    playsoundatpos(param_00.randomintrange.origin, "zmb_prize_restock");
    playFX(level._effect["booth_respawn"], param_00.randomintrange.origin);
  } else {
    playsoundatpos(param_00.origin, "zmb_prize_restock");
    playFX(level._effect["booth_respawn"], param_00.origin);
  }

  if(scripts\engine\utility::istrue(param_02)) {
    param_00.randomintrange show();
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    return;
  }

  if(isDefined(param_01)) {
    if(isDefined(param_00.randomintrange)) {
      param_00.randomintrange showtoplayer(param_01);
    }

    if(isDefined(param_00.trigger)) {
      param_00.trigger showtoplayer(param_01);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, param_01);
  }
}

func_7CF9(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "small_ticket_prize":
      var_01 = "foam_grenade_vm";
      break;

    case "arcade_counter_ammo":
      var_01 = "food_trash_bag_paper_01";
      break;

    case "arcade_counter_grenade":
      var_01 = "grenade_bag";
      break;

    case "medium_ticket_prize":
      var_01 = "equipment_oxygen_tank_01";
      break;

    case "large_ticket_prize":
      if(!isDefined(level.var_A857) || level.var_A857.size < 1) {
        level.var_A857 = ["attachment_zmb_arcane_muzzlebrake_wm"];
      }

      var_01 = scripts\engine\utility::random(level.var_A857);
      level.var_A857 = scripts\engine\utility::array_remove(level.var_A857, var_01);
      break;

    default:
      break;
  }

  return var_01;
}

func_7CFB(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "equipment_oxygen_tank_01":
      var_01 = (0, 0, 0);
      break;

    case "food_trash_bag_paper_01":
      var_01 = (0, 0, 0);
      break;

    case "grenade_bag":
      var_01 = (0, 0, 0);
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_01 = (0, 0, 0);
      break;

    case "foam_grenade_vm":
      var_01 = (0, 0, 0);
      break;

    default:
      break;
  }

  return var_01;
}

func_7CFA(param_00, param_01) {
  var_02 = undefined;
  switch (param_01) {
    case "equipment_oxygen_tank_01":
      var_02 = (0, 0, 0);
      break;

    case "food_trash_bag_paper_01":
      var_02 = (0, -90, 0);
      break;

    case "grenade_bag":
      var_02 = (360, 270, 0);
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_02 = (0, 0, 0);
      break;

    case "foam_grenade_vm":
      var_02 = (0, 0, 0);
      break;

    default:
      break;
  }

  return var_02;
}

func_77CB(param_00) {
  var_01 = undefined;
  switch (param_00.script_noteworthy) {
    case "arcade_counter_ammo":
      var_01 = ::func_2761;
      break;

    case "arcade_counter_grenade":
      var_01 = ::_meth_857F;
      break;

    case "large_ticket_prize":
      var_01 = ::func_10931;
      break;

    default:
      break;
  }

  return var_01;
}

func_2761(param_00, param_01) {
  param_01 playlocalsound("purchase_ticket");
  var_02 = param_01 getweaponslistprimaries();
  foreach(var_04 in var_02) {
    param_01 givemaxammo(var_04);
    if(weaponmaxammo(var_04) == weaponclipsize(var_04)) {
      param_01 setweaponammoclip(var_04, weaponclipsize(var_04));
    }
  }

  return 1;
}

_meth_857F(param_00, param_01) {
  param_01 playlocalsound("purchase_ticket");
  scripts\cp\gametypes\zombie::replace_grenades_on_player(param_01);
  return 1;
}

func_10931(param_00, param_01) {
  var_02 = scripts\cp\utility::get_attachment_from_interaction(param_00);
  var_03 = param_01 getcurrentweapon();
  if(param_01 scripts\cp\utility::weaponhasattachment(var_03, var_02)) {
    return 0;
  }

  if(!param_01 scripts\cp\cp_weapon::can_use_attachment(var_02, var_03)) {
    return 0;
  }

  thread deactivate_ticket_counter_slot(param_00, param_01, 1);
  var_04 = param_01 scripts\cp\cp_weapon::add_attachment_to_weapon(var_02, var_03, 1);
  if(var_04) {
    param_01 notify("weapon_purchased");
  }

  if(var_02 == "arcane_base" && var_04 == 1) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("part_collect_arcane", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
  }

  return var_04;
}

func_E193(param_00, param_01) {
  wait(120);
  param_00.randomintrange show();
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

func_7CF8(param_00, param_01) {
  var_02 = undefined;
  switch (param_01) {
    case "foam_grenade_vm":
      if(param_00.power == "power_phaseShift") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_PHASESHIFT";
      } else if(param_00.power == "power_kineticPulse") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_KINETICPULSE";
      } else if(param_00.power == "power_rewind") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_REWIND";
      } else if(param_00.power == "power_transponder") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_TRANSPONDER";
      } else if(param_00.power == "power_tripMine") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_TRIPMINE";
      } else if(param_00.power == "power_blackholeGrenade") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_BHGRENADE";
      } else if(param_00.power == "power_repulsor") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_REPULSOR";
      }
      break;

    case "equipment_oxygen_tank_01":
      if(param_00.power == "power_armageddon") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_ARMAGEDDON";
      } else if(param_00.power == "power_microTurret") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_MICROTURRRET";
      } else if(param_00.power == "power_portalGenerator") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_PORTALGENERATOR";
      } else if(param_00.power == "power_deployableCover") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_DEPLOYABLECOVER";
      } else if(param_00.power == "power_repulsor") {
        var_02 = &"CP_ZMB_INTERACTIONS_TICKET_REPULSOR";
      }
      break;

    case "food_trash_bag_paper_01":
      var_02 = &"CP_ZMB_INTERACTIONS_BAG_O_BULLETS";
      break;

    case "grenade_bag":
      var_02 = &"CP_ZMB_INTERACTIONS_GRENADE_POUCH";
      break;

    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_02 = &"CP_ZMB_INTERACTIONS_BUY_ARCANE_CORE";
      break;

    default:
      break;
  }

  return var_02;
}

ticket_counter_slot_hint_func(param_00, param_01) {
  if(!isDefined(param_01.ticket_item_outlined)) {
    param_01.ticket_item_outlined = param_00.randomintrange;
    if(self.num_tickets >= level.interactions[param_00.script_noteworthy].cost) {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 3, 1, 0);
    } else {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 1, 1, 0);
    }
  } else if(param_01.ticket_item_outlined != param_00.randomintrange) {
    param_01.ticket_item_outlined hudoutlinedisableforclient(param_01);
    param_01.ticket_item_outlined = param_00.randomintrange;
    if(self.num_tickets >= level.interactions[param_00.script_noteworthy].cost) {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 3, 1, 0);
    } else {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 1, 1, 0);
    }
  }

  return param_00.randomintrange.hint_string;
}