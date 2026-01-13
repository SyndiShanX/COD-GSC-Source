/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3416.gsc
*********************************************/

init_jaroslav() {
  var_0 = scripts\engine\utility::getstructarray("jaroslav_machine", "script_noteworthy");
  level.jaroslav_original_cost = level.interactions["jaroslav_machine"].cost;
  level.fortune_visit_cost_1 = 3000;
  level.fortune_visit_cost_2 = 6000;
  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      if(var_5.script_noteworthy == "fnf_machine") {
        var_2.machine = var_5;
        continue;
      }

      if(var_5.script_noteworthy == "fnf_jaw") {
        var_2.jaw = var_5;
        continue;
      }

      if(var_5.script_noteworthy == "fnf_light") {
        if(!isDefined(var_2.lights)) {
          var_2.lights = [];
        }

        var_2.lights[var_2.lights.size] = var_5;
      }
    }

    var_2.machine setscriptablepartstate("teller", "safe_off");
    var_2.jaw setModel("zmb_fortune_teller_machine_jaw_01");
    var_2 thread power_on_func();
  }
}

should_use_alt_machine() {
  if(getdvarint("loc_language") != 15 && getdvarint("loc_language") != 1) {
    return 0;
  }

  return 0;
}

power_on_func() {
  foreach(var_1 in self.lights) {
    var_1 setlightintensity(0);
    if(scripts\engine\utility::istrue(self.requires_power)) {
      var_1 thread turn_on_light(self);
    }
  }
}

turn_on_light(var_0) {
  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return("power_on", var_0.power_area + " power_on", "power_off");
    if(var_1 == "power_off") {
      self setlightintensity(0);
      var_0.powered_on = 0;
      continue;
    }

    self setlightintensity(0.65);
    var_0.machine setscriptablepartstate("machine", "default_on");
    var_0.machine setscriptablepartstate("teller", "safe_on");
    if(!var_0.powered_on) {
      level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue("jaroslav_anc_attract", var_0.jaw.origin, 120, 120, 250000, 100);
    }

    var_0.powered_on = 1;
  }
}

interaction_jaroslav(var_0, var_1) {
  level thread move_jaw(var_0, 3);
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  var_2 = getarraykeys(var_1.consumables);
  var_1 notify("cards_replenished");
  if(var_1 scripts\cp\utility::are_any_consumables_active()) {
    foreach(var_4 in var_2) {
      var_1 notify(var_4 + "_exited_early");
    }
  }

  wait(0.5);
  var_1 scripts\cp\zombies\zombies_consumables::reset_meter();
  var_1.card_refills = var_1.card_refills + 1;
  var_1 thread scripts\cp\zombies\zombies_consumables::turn_on_cards();
  var_1 thread scripts\cp\zombies\zombies_consumables::meter_fill_up();
  var_1 scripts\cp\cp_merits::processmerit("mt_faf_refill_deck");
  playsoundatpos(var_0.origin, "jaroslav_anc_activate_use");
  level thread jaroslav_interaction_vo(var_1);
  scripts\cp\zombies\zombie_analytics::log_fafrefill(1, level.wave_num, var_1);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_need_fateandfort");
  var_1 scripts\cp\cp_interaction::refresh_interaction();
}

jaroslav_interaction_vo(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  wait(2);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("wonder_restock", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
}

move_jaw(var_0, var_1) {
  if(isDefined(var_0.jaw.moving)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.machine.hidden)) {
    var_0.machine setscriptablepartstate("mouth", "smoke");
  }

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0.jaw.moving = 1;
    var_0.jaw movez(-1, 0.2);
    var_0.jaw waittill("movedone");
    wait(1);
    var_0.jaw movez(1, 0.2);
    var_0.jaw waittill("movedone");
  }

  var_0.jaw.moving = undefined;
}

jaroslav_hint_logic(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.machine.hidden)) {
    return "";
  }

  if(var_0.requires_power && !var_0.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  level thread move_jaw(var_0, 1);
  if(var_1 scripts\cp\utility::are_any_consumables_active()) {
    var_2 = &"COOP_INTERACTIONS_FNF_WHILE_ACTIVE";
  } else {
    var_2 = level.interaction_hintstrings[var_1.script_noteworthy];
  }

  if(scripts\engine\utility::istrue(level.meph_fight_started)) {
    return level.interaction_hintstrings[var_0.script_noteworthy];
  }

  if(scripts\engine\utility::istrue(level.unlimited_fnf)) {
    return var_2;
  }

  switch (var_1.card_refills) {
    case 1:
    case 0:
      return var_2;

    default:
      return &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED";
  }
}

player_init(var_0) {
  var_0.fortune_visit_this_round = 0;
  var_0.card_refills = 0;
}

register_interactions() {
  level.interaction_hintstrings["jaroslav_machine"] = &"COOP_INTERACTIONS_FNF";
  scripts\cp\cp_interaction::register_interaction("jaroslav_machine", "wondercard_machine", 1, ::jaroslav_hint_logic, ::interaction_jaroslav, 3000, 1, ::init_jaroslav);
}