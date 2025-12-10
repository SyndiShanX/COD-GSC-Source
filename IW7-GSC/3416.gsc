/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3416.gsc
************************/

init_jaroslav() {
  var_00 = scripts\engine\utility::getstructarray("jaroslav_machine", "script_noteworthy");
  level.jaroslav_original_cost = level.interactions["jaroslav_machine"].cost;
  level.fortune_visit_cost_1 = 3000;
  level.fortune_visit_cost_2 = 6000;
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      if(var_05.script_noteworthy == "fnf_machine") {
        var_02.machine = var_05;
        continue;
      }

      if(var_05.script_noteworthy == "fnf_jaw") {
        var_02.jaw = var_05;
        continue;
      }

      if(var_05.script_noteworthy == "fnf_light") {
        if(!isDefined(var_02.lights)) {
          var_02.lights = [];
        }

        var_02.lights[var_02.lights.size] = var_05;
      }
    }

    var_02.machine setscriptablepartstate("teller", "safe_off");
    var_02.jaw setModel("zmb_fortune_teller_machine_jaw_01");
    var_02 thread power_on_func();
  }
}

should_use_alt_machine() {
  if(getdvarint("loc_language") != 15 && getdvarint("loc_language") != 1) {
    return 0;
  }

  return 0;
}

power_on_func() {
  foreach(var_01 in self.lights) {
    var_01 setlightintensity(0);
    if(scripts\engine\utility::istrue(self.requires_power)) {
      var_01 thread turn_on_light(self);
    }
  }
}

turn_on_light(param_00) {
  for(;;) {
    var_01 = level scripts\engine\utility::waittill_any_return("power_on", param_00.power_area + " power_on", "power_off");
    if(var_01 == "power_off") {
      self setlightintensity(0);
      param_00.powered_on = 0;
      continue;
    }

    self setlightintensity(0.65);
    param_00.machine setscriptablepartstate("machine", "default_on");
    param_00.machine setscriptablepartstate("teller", "safe_on");
    if(!param_00.powered_on) {
      level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue("jaroslav_anc_attract", param_00.jaw.origin, 120, 120, 250000, 100);
    }

    param_00.powered_on = 1;
  }
}

interaction_jaroslav(param_00, param_01) {
  level thread move_jaw(param_00, 3);
  param_01 notify("stop_interaction_logic");
  param_01.last_interaction_point = undefined;
  var_02 = getarraykeys(param_01.consumables);
  param_01 notify("cards_replenished");
  if(param_01 scripts\cp\utility::are_any_consumables_active()) {
    foreach(var_04 in var_02) {
      param_01 notify(var_04 + "_exited_early");
    }
  }

  wait(0.5);
  param_01 scripts\cp\zombies\zombies_consumables::reset_meter();
  param_01.card_refills = param_01.card_refills + 1;
  param_01 thread scripts\cp\zombies\zombies_consumables::turn_on_cards();
  param_01 thread scripts\cp\zombies\zombies_consumables::meter_fill_up();
  param_01 scripts\cp\cp_merits::processmerit("mt_faf_refill_deck");
  playsoundatpos(param_00.origin, "jaroslav_anc_activate_use");
  level thread jaroslav_interaction_vo(param_01);
  scripts\cp\zombies\zombie_analytics::log_fafrefill(1, level.wave_num, param_01);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_need_fateandfort");
  param_01 scripts\cp\cp_interaction::refresh_interaction();
}

jaroslav_interaction_vo(param_00) {
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  wait(2);
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("wonder_restock", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
}

move_jaw(param_00, param_01) {
  if(isDefined(param_00.jaw.moving)) {
    return;
  }

  if(!scripts\engine\utility::istrue(param_00.machine.hidden)) {
    param_00.machine setscriptablepartstate("mouth", "smoke");
  }

  for(var_02 = 0; var_02 < param_01; var_02++) {
    param_00.jaw.moving = 1;
    param_00.jaw movez(-1, 0.2);
    param_00.jaw waittill("movedone");
    wait(1);
    param_00.jaw movez(1, 0.2);
    param_00.jaw waittill("movedone");
  }

  param_00.jaw.moving = undefined;
}

jaroslav_hint_logic(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.machine.hidden)) {
    return "";
  }

  if(param_00.requires_power && !param_00.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  level thread move_jaw(param_00, 1);
  if(param_01 scripts\cp\utility::are_any_consumables_active()) {
    var_02 = &"COOP_INTERACTIONS_FNF_WHILE_ACTIVE";
  } else {
    var_02 = level.interaction_hintstrings[param_01.script_noteworthy];
  }

  if(scripts\engine\utility::istrue(level.meph_fight_started)) {
    return level.interaction_hintstrings[param_00.script_noteworthy];
  }

  if(scripts\engine\utility::istrue(level.unlimited_fnf)) {
    return var_02;
  }

  switch (param_01.card_refills) {
    case 1:
    case 0:
      return var_02;

    default:
      return &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED";
  }
}

player_init(param_00) {
  param_00.fortune_visit_this_round = 0;
  param_00.card_refills = 0;
}

register_interactions() {
  level.interaction_hintstrings["jaroslav_machine"] = &"COOP_INTERACTIONS_FNF";
  scripts\cp\cp_interaction::register_interaction("jaroslav_machine", "wondercard_machine", 1, ::jaroslav_hint_logic, ::interaction_jaroslav, 3000, 1, ::init_jaroslav);
}