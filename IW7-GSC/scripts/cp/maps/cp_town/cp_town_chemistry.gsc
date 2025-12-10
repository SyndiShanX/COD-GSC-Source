/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_chemistry.gsc
*********************************************************/

init() {
  level.final_compounds = [];
  level.compounds = [];
  level.elements = [];
  level.radios = [];
  parse_compounds_table();
  setup_final_compound();
  parse_elements_table();
  parse_compound_vo_table();
  setup_blackboards();
  setup_constants();
  setup_eye_equation_constant();
  setup_pi_constant();
  setup_color_key_chart();
  setup_heat_pressure_equation_constant();
  setup_lab_screen();
  setup_chem_compound_slot_world_lua();
  setup_in_world_lua();
  level thread setup_chemical_object_interactions();
  level thread setup_heat_pressure_buttons();
  level thread setup_chemistry_lab_models_in_world();
  level thread setup_beaker_and_compounds();
  level thread setup_discard_player_chemical_interaction();
  level.quest_pillage_give_func = ::chem_radio_battery_pickup;
}

setup_beaker_and_compounds() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait(10);
  foreach(var_01 in level.chemical_containers) {
    var_01.interaction = create_beaker_interaction(var_01);
  }

  foreach(var_04 in level.chemical_compounds_created) {
    var_04.interaction = create_compound_interaction(var_04);
  }
}

create_beaker_interaction(param_00) {
  var_01 = spawnStruct();
  var_01.script_noteworthy = param_00.name;
  var_01.origin = param_00.model.origin;
  var_01.angles = param_00.model.angles;
  var_01.requires_power = 0;
  var_01.powered_on = 1;
  var_01.script_parameters = "beaker_interactions";
  var_01.name = param_00.name;
  var_01.spend_type = undefined;
  var_01.cost = 0;
  var_01.chemical_contained = param_00.chemical_contained;
  var_01.model = param_00.model;
  var_01.hint_func = ::beaker_hint_func;
  var_01.activation_func = ::add_element_to_beaker_interaction;
  var_01.enabled = 1;
  var_01.disable_guided_interactions = 1;
  level.interactions[var_01.name] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  return var_01;
}

setup_discard_player_chemical_interaction() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait(10);
  var_00 = spawnStruct();
  var_00.script_noteworthy = "discard_chem_interaction";
  var_00.origin = (4617.5, 1510.5, 336);
  var_00.angles = (0, 0, 0);
  var_00.requires_power = 0;
  var_00.powered_on = 1;
  var_00.script_parameters = "discard_chem_interaction";
  var_00.name = "discard_chem_interaction";
  var_00.spend_type = undefined;
  var_00.cost = 0;
  var_00.hint_func = ::discard_hint_func;
  var_00.activation_func = ::discard_chemical_from_player;
  var_00.enabled = 1;
  var_00.disable_guided_interactions = 1;
  level.interactions[var_00.name] = var_00;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_00);
  level.discard_chem_interaction = var_00;
}

discard_chemical_from_player(param_00, param_01) {
  set_chemical_carried_by_player_after_beaker_deposit(param_01, "");
}

discard_hint_func(param_00, param_01) {
  if(isDefined(param_01.chemical_base_picked) && param_01.chemical_base_picked != "") {
    return &"CP_TOWN_DISCARD_ONLY";
  }

  return "";
}

beaker_hint_func(param_00, param_01) {
  if(isDefined(param_01.chemical_base_picked) && param_01.chemical_base_picked != "") {
    if(param_00.chemical_contained == "") {
      return &"CP_TOWN_CHEM_PLACE_DISCARD";
    }

    return &"CP_TOWN_SWAP_DISCARD";
  }

  return "";
}

compound_hint_func(param_00, param_01) {
  if(param_00.compound_contained != "") {
    return &"CP_TOWN_ADD_COMPOUND";
  }

  return "";
}

create_compound_interaction(param_00) {
  var_01 = spawnStruct();
  var_01.script_noteworthy = param_00.name;
  var_01.origin = param_00.model.origin;
  var_01.angles = param_00.model.angles;
  var_01.compound_contained = param_00.compound_contained;
  var_01.compound_container_filled = param_00.compound_container_filled;
  var_01.model = param_00.model;
  var_01.requires_power = 0;
  var_01.powered_on = 1;
  var_01.script_parameters = "compound_interactions";
  var_01.name = param_00.name;
  var_01.spend_type = undefined;
  var_01.cost = 0;
  var_01.hint_func = ::compound_hint_func;
  var_01.activation_func = ::add_compounds_interaction;
  var_01.enabled = 1;
  var_01.disable_guided_interactions = 1;
  level.interactions[var_01.name] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  return var_01;
}

chem_radio_battery_pickup(param_00) {
  param_00 setclientomnvar("zm_nag_text", 1);
  param_00.has_battery = 1;
}

setup_chemistry_lab_models_in_world() {
  var_00 = getEntArray("chemistry_set_parts", "script_noteworthy");
  foreach(var_03, var_02 in var_00) {
    var_02 hide();
    level.chemistry_set_parts[var_03] = var_02;
  }
}

setup_heat_pressure_buttons() {
  var_00 = scripts\engine\utility::getstructarray("h_p_button", "script_noteworthy");
  var_01 = getent("chem_computer", "targetname");
  foreach(var_06, var_03 in var_00) {
    var_04 = undefined;
    switch (var_03.name) {
      case "h_p_button_1":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_1"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_2":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_2"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_3":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_3"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_4":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_4"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_5":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_5"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_6":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_6"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_7":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_7"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_8":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_8"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_9":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_9"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      case "h_p_button_0":
        var_04 = spawn("script_model", var_01 gettagorigin("tag_button_0"));
        var_04 setModel("cp_town_chem_lab_computer_interactive_button");
        var_04.angles = var_03.angles;
        break;

      default:
        break;
    }

    var_05 = strtok(var_03.name, "_");
    var_03.numeric_value = int(var_05[3]);
    if(isDefined(var_04)) {
      var_03.model = var_04;
    }

    var_03.model hide();
    level.h_p_button_objects[var_06] = var_03;
  }
}

update_player_monitor_buttons(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    scripts\engine\utility::waitframe();
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(distancesquared(self.origin, (4760, 1546, 336)) > 5184) {
      continue;
    }

    update_button_state_for_player(self, param_00);
  }
}

update_button_state_for_player(param_00, param_01) {
  param_00 endon("disconnect");
  if(distance2dsquared(param_01.origin, param_00.origin) > 6400) {
    param_01.model hudoutlinedisableforclient(param_00);
    return;
  }

  if(!param_00 worldpointinreticle_circle(param_01.origin, 15, 80)) {
    param_01.model hudoutlinedisableforclient(param_00);
    scripts\engine\utility::waitframe();
    return;
  }

  level thread show_hint_for_time(2, param_00);
  param_01.model hudoutlineenableforclient(param_00, 3, 1, 0);
}

show_hint_for_time(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 notify("end_thread_instance");
  param_01 endon("end_thread_instance");
  param_01 forceusehinton(&"CP_TOWN_INTERACTIONS_PUSH_BOMB");
  wait(param_00);
  param_01 getrigindexfromarchetyperef();
}

watch_for_input_entered_on_button(param_00) {
  self endon("disconnect");
  self notifyonplayercommand("select_button", "+usereload");
  self notifyonplayercommand("select_button", "+activate");
  var_01 = "";
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("select_button");
    if(distance2dsquared(param_00.origin, self.origin) > 6400) {
      param_00.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(param_00.origin, 15, 80)) {
      param_00.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_01)) {
      param_00.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::istrue(level.crafted_chem_set)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    param_00.model hudoutlineenableforclient(self, 3, 1, 0);
    if(var_01 == "select_button") {
      self playgestureviewmodel("ges_point_gun", param_00.model);
      add_button_value_to_list(param_00, self);
      scripts\engine\utility::play_sound_in_space("chemistry_machine_button_press", param_00.origin);
      wait(1);
      param_00.model hudoutlinedisableforclient(self);
    }
  }
}

add_button_value_to_list(param_00, param_01) {
  if(!isDefined(level.h_p_buttons_value)) {
    level.h_p_buttons_value = [];
  }

  if(!isDefined(level.buttons_pointer)) {
    level.buttons_pointer = 0;
  }

  if(level.buttons_pointer > 1) {
    level.buttons_pointer = 0;
    level.h_p_buttons_value = [];
    setomnvar("zm_chem_number_entry_1", -1);
  }

  level.h_p_buttons_value[level.buttons_pointer] = param_00.numeric_value;
  if(isDefined(level.h_p_buttons_value[1])) {
    level.heat_pressure_machine_value = 10 * level.h_p_buttons_value[0] + level.h_p_buttons_value[1];
    setomnvar("zm_chem_number_entry_2", 2);
  } else {
    level.heat_pressure_machine_value = level.h_p_buttons_value[0];
    setomnvar("zm_chem_number_entry_2", 1);
  }

  setomnvar("zm_chem_number_entry_1", level.heat_pressure_machine_value);
  level.buttons_pointer++;
}

setup_chemical_object_interactions() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  foreach(var_02, var_01 in level.elements) {
    if(var_02 == "animalfat" || var_02 == "silver" || var_02 == "copper" || var_02 == "chill") {
      continue;
    }

    if(level.elements[var_02].type == "componant" || level.elements[var_02].type == "final") {
      continue;
    }

    var_01.interaction = create_chemical_object_interaction(var_01);
  }
}

parse_compounds_table() {
  if(isDefined(level.compound_table)) {
    var_00 = level.compound_table;
  } else {
    var_00 = "cp\zombies\compounds.csv";
  }

  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 0);
    if(var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_00, var_01, 1);
    var_04 = tablelookupbyrow(var_00, var_01, 2);
    var_05 = tablelookupbyrow(var_00, var_01, 3);
    var_06 = tablelookupbyrow(var_00, var_01, 4);
    var_07 = tablelookupbyrow(var_00, var_01, 5);
    var_08 = tablelookupbyrow(var_00, var_01, 6);
    register_compound(var_02, var_03, var_04, var_05, var_06, var_07, var_08);
    var_01++;
  }
}

register_compound(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.displayname = param_01;
  var_07.type = param_02;
  if(var_07.type == "final") {
    level.final_compounds[level.final_compounds.size] = param_00;
  }

  var_07.parta = param_03;
  var_07.partb = param_04;
  var_07.partc = param_05;
  var_07.partd = param_06;
  level.compounds[param_00] = var_07;
}

parse_elements_table() {
  if(isDefined(level.element_table)) {
    var_00 = level.element_table;
  } else {
    var_00 = "cp\zombies\elements.csv";
  }

  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 1);
    if(var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_00, var_01, 0);
    var_04 = tablelookupbyrow(var_00, var_01, 2);
    var_05 = tablelookupbyrow(var_00, var_01, 3);
    var_06 = tablelookupbyrow(var_00, var_01, 4);
    var_07 = tablelookupbyrow(var_00, var_01, 6);
    var_08 = tablelookupbyrow(var_00, var_01, 7);
    var_09 = tablelookupbyrow(var_00, var_01, 8);
    var_0A = tablelookupbyrow(var_00, var_01, 9);
    var_0B = tablelookupbyrow(var_00, var_01, 10);
    var_0C = tablelookupbyrow(var_00, var_01, 11);
    var_0D = tablelookupbyrow(var_00, var_01, 12);
    var_0E = tablelookupbyrow(var_00, var_01, 13);
    var_0F = tablelookupbyrow(var_00, var_01, 14);
    var_10 = tablelookupbyrow(var_00, var_01, 15);
    var_11 = tablelookupbyrow(var_00, var_01, 16);
    var_12 = tablelookupbyrow(var_00, var_01, 17);
    var_13 = tablelookupbyrow(var_00, var_01, 18);
    var_14 = tablelookupbyrow(var_00, var_01, 19);
    var_15 = tablelookupbyrow(var_00, var_01, 32);
    var_16 = tablelookupbyrow(var_00, var_01, 33);
    var_17 = tablelookupbyrow(var_00, var_01, 34);
    register_element(var_03, var_02, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);
    var_01++;
  }
}

register_element(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10, param_11, param_12, param_13, param_14, param_15) {
  var_16 = spawnStruct();
  var_16.omnvar = param_00;
  var_16.displayname = param_02;
  var_16.unique = param_04;
  var_16.model = param_05;
  var_16.type = param_03;
  var_16.slot = param_06;
  var_16.valuesets = spawnStruct();
  var_16.valuesets.choicea = spawnStruct();
  var_16.valuesets.choicea.heat = param_07;
  var_16.valuesets.choicea.pressure = param_08;
  var_16.valuesets.choiceb = spawnStruct();
  var_16.valuesets.choiceb.heat = param_09;
  var_16.valuesets.choiceb.pressure = param_0A;
  var_16.valuesets.choicec = spawnStruct();
  var_16.valuesets.choicec.heat = param_0B;
  var_16.valuesets.choicec.pressure = param_0C;
  var_16.valuesets.choiced = spawnStruct();
  var_16.valuesets.choiced.heat = param_0D;
  var_16.valuesets.choiced.pressure = param_0E;
  var_16.valuesets.choicee = spawnStruct();
  var_16.valuesets.choicee.heat = param_0F;
  var_16.valuesets.choicee.pressure = param_10;
  var_16.valuesets.choicef = spawnStruct();
  var_16.valuesets.choicef.heat = param_11;
  var_16.valuesets.choicef.pressure = param_12;
  var_16.model_coordinates = param_13;
  var_16.model_angles = param_14;
  var_16.var_10475 = param_15;
  if(param_03 == "componant" || param_03 == "final") {
    if(param_03 == "componant") {
      var_17 = scripts\engine\utility::random([level._effect["beaker_chem_blue"], level._effect["beaker_chem_orange"], level._effect["beaker_chem_pink"], level._effect["beaker_chem_purple"]]);
      var_16.fx_trigger = var_17;
    } else {
      var_16.fx_trigger = level._effect["beaker_chem_red"];
    }

    level.elements[param_01] = var_16;
    return;
  }

  if(param_01 == "animalfat") {
    level.animalfat = [];
    var_18 = strtok(var_16.model_coordinates, ",");
    var_19 = scripts\engine\utility::getstruct("cp_town_animal_fat", "script_noteworthy");
    var_1A = spawn("script_model", var_19.origin);
    var_1A setModel("tag_origin_chemical");
    var_1A.angles = (0, 0, 0);
    var_1A setCanDamage(1);
    var_1A.maxhealth = 5;
    var_1A.health = 5;
    var_19.model = var_1A;
    var_19.chemical_object_name = param_01;
    level.animalfat[level.animalfat.size] = var_19.model;
    var_19 thread watch_for_melee_on_chemical_object();
    level.elements[param_01] = var_16;
    return;
  }

  if(param_01 == "copper") {
    level.silver = [];
    var_1B = scripts\engine\utility::getstructarray("cp_town_pennies", "script_noteworthy");
    foreach(var_1D in var_1B) {
      var_1A = spawn("script_model", var_1D.origin);
      var_1A setModel("tag_origin_chemical");
      var_1A.angles = var_1D.angles;
      var_1A setCanDamage(1);
      var_1A.maxhealth = 5;
      var_1A.health = 5;
      var_1D.model = var_1A;
      var_1D.chemical_object_name = param_01;
      level.silver[level.silver.size] = var_1D.model;
      var_1D thread watch_for_melee_on_chemical_object();
    }

    level.elements[param_01] = var_16;
    return;
  }

  if(param_01 == "silver") {
    level.copper = [];
    var_1F = scripts\engine\utility::getstructarray("cp_town_quarters", "script_noteworthy");
    var_20 = spawnStruct();
    var_20.origin = (5270, 1596, 387);
    var_20.angles = (10, 184, 0);
    var_21 = spawnStruct();
    var_21.origin = (5265, 1637, 387);
    var_21.angles = (10, 184, 0);
    var_1F = scripts\engine\utility::array_add_safe(var_1F, var_20);
    var_1F = scripts\engine\utility::array_add_safe(var_1F, var_21);
    foreach(var_1D in var_1F) {
      var_1A = spawn("script_model", var_1D.origin);
      var_1A setModel("tag_origin_chemical");
      var_1A.angles = var_1D.angles;
      var_1A setCanDamage(1);
      var_1A.maxhealth = 5;
      var_1A.health = 5;
      var_1D.model = var_1A;
      var_1D.chemical_object_name = param_01;
      level.copper[level.copper.size] = var_1D.model;
      var_1D thread watch_for_melee_on_chemical_object();
    }

    level.elements[param_01] = var_16;
    return;
  }

  if(param_01 == "chill") {
    var_1A = undefined;
    level.chill = [];
    var_24 = scripts\engine\utility::getstructarray("cp_town_chill", "script_noteworthy");
    foreach(var_1D in var_24) {
      var_1A = spawn("script_model", var_1D.origin);
      var_1A setModel("tag_origin_chemical");
      var_1A.angles = var_1D.angles;
      var_1A setCanDamage(1);
      var_1A.maxhealth = 5;
      var_1A.health = 5;
      var_1D.model = var_1A;
      var_1D.chemical_object_name = param_01;
      level.chill[level.chill.size] = var_1D.model;
      var_1D thread watch_for_melee_on_chemical_object();
    }

    level.elements[param_01] = var_16;
    return;
  }

  var_18 = strtok(var_16.model_coordinates, ",");
  var_16.chemical_model_object = spawn("script_model", (int(var_18[0]), int(var_18[1]), int(var_18[2])));
  var_16.chemical_model_object setModel(var_16.model);
  var_27 = strtok(var_16.model_angles, ",");
  var_16.chemical_model_object.angles = (int(var_27[0]), int(var_27[1]), int(var_27[2]));
  var_16.chemical_object_name = param_01;
  level.elements[param_01] = var_16;
}

setup_radio_vo_from_elements() {
  if(isDefined(level.element_table)) {
    var_00 = level.element_table;
  } else {
    var_00 = "cp\zombies\elements.csv";
  }

  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 1);
    if(var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_00, var_01, 3);
    var_04 = tablelookupbyrow(var_00, var_01, 4);
    var_05 = tablelookupbyrow(var_00, var_01, 7);
    var_06 = tablelookupbyrow(var_00, var_01, 34);
    register_radio_vo(var_02, var_03, var_04, var_05, var_06);
    var_01++;
  }
}

register_radio_vo(param_00, param_01, param_02, param_03, param_04) {
  if(param_00 == "chill") {
    return;
  }

  switch (param_03) {
    case "5":
      var_05 = level.chem_radio_1_sounds.size;
      level.chem_radio_1_sounds[var_05] = param_04;
      break;

    case "2":
      var_05 = level.chem_radio_2_sounds.size;
      level.chem_radio_2_sounds[var_05] = param_04;
      break;

    case "3":
      var_05 = level.chem_radio_3_sounds.size;
      level.chem_radio_3_sounds[var_05] = param_04;
      break;

    case "4":
      var_05 = level.chem_radio_4_sounds.size;
      level.chem_radio_4_sounds[var_05] = param_04;
      break;

    case "1":
      var_05 = level.chem_radio_5_sounds.size;
      level.chem_radio_5_sounds[var_05] = param_04;
      break;

    case "6":
      var_05 = level.chem_radio_6_sounds.size;
      level.chem_radio_6_sounds[var_05] = param_04;
      break;
  }
}

watch_for_melee_on_chemical_object() {
  for(;;) {
    self.model waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isplayer(var_01)) {
      continue;
    }

    if(self.chemical_object_name == "animalfat" && !issubstr(var_09, "cleaver")) {
      continue;
    } else if(self.chemical_object_name == "silver" && !issubstr(var_09, "crowbar")) {
      continue;
    } else if(self.chemical_object_name == "copper" && !issubstr(var_09, "crowbar")) {
      continue;
    }

    playFX(level._effect["sb_quest_item_pickup"], var_03);
    var_0A = get_chemistry_object_value(self, 0);
    var_0B = get_chemical_carried_by_player(var_01);
    if(var_0B == "") {
      set_chemical_carried_by_player(var_01, var_0A);
    } else {
      set_chemical_carried_by_player(var_01, var_0A);
    }

    if(self.model.health < 0) {
      self.model.health = 5;
      self.model.maxhealth = 5;
    }
  }
}

create_chemical_object_interaction(param_00) {
  var_01 = spawnStruct();
  var_01.script_noteworthy = "element_pickup";
  if(param_00.chemical_object_name == "sulfuricacid") {
    var_01.origin = param_00.chemical_model_object.origin + (60, -31, 21);
  } else {
    var_01.origin = param_00.chemical_model_object.origin;
    var_01.angles = param_00.chemical_model_object.angles;
  }

  var_01.requires_power = 0;
  var_01.powered_on = 1;
  var_01.script_parameters = "element_pickup";
  var_01.name = "element_pickup";
  var_01.chemical_model_object = param_00.chemical_model_object;
  var_01.spend_type = undefined;
  var_01.cost = 0;
  var_01.chemical_object_name = param_00.chemical_object_name;
  var_01.hint_func = ::element_pickup_hint_func;
  var_01.activation_func = ::try_play_swap_vfx;
  var_01.enabled = 1;
  var_01.disable_guided_interactions = 1;
  level.interactions[var_01.name] = var_01;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  return var_01;
}

setup_blackboards() {
  level.blackboard_array = getEntArray("blackboard_model", "script_noteworthy");
  level.blackboard_1_ent = undefined;
  level.blackboard_2_ent = undefined;
  level.blackboard_3_num = undefined;
  level.blackboard_4_ent = undefined;
  level.blackboard_5_ent = undefined;
  level.blackboard_6_ent = undefined;
  foreach(var_01 in level.blackboard_array) {
    switch (var_01.name) {
      case "blackboard_1":
        level.blackboard_1_ent = var_01;
        break;

      case "blackboard_2":
        level.blackboard_2_ent = var_01;
        break;

      case "blackboard_3":
        level.blackboard_3_ent = var_01;
        break;

      case "blackboard_4":
        level.blackboard_4_ent = var_01;
        break;

      case "blackboard_5":
        level.blackboard_5_ent = var_01;
        break;

      case "blackboard_6":
        level.blackboard_6_ent = var_01;
        break;
    }
  }
}

setup_in_world_lua() {
  setomnvar("zm_ui_blackboard_1_ent", level.blackboard_1_ent);
  setomnvar("zm_ui_blackboard_2_ent", level.blackboard_2_ent);
  setomnvar("zm_ui_blackboard_3_ent", level.blackboard_3_ent);
  setomnvar("zm_ui_blackboard_4_ent", level.blackboard_4_ent);
  setomnvar("zm_ui_blackboard_5_ent", level.blackboard_5_ent);
  setomnvar("zm_ui_blackboard_6_ent", level.blackboard_6_ent);
  setomnvar("zm_ui_constant_1_ent", level.constant_1_ent);
  setomnvar("zm_ui_constant_2_ent", level.constant_2_ent);
  setomnvar("zm_ui_constant_3_ent", level.constant_3_ent);
  setomnvar("zm_ui_constant_4_ent", level.constant_4_ent);
  setomnvar("zm_ui_pi_ent", level.pi_const);
  setomnvar("zm_ui_eye_equation_ent", level.eye_equation);
  setomnvar("zm_ui_reaction_equation_ent", level.heat_pressure_eq);
  setomnvar("zm_chem_compound_slot_1_ent", level.chem_compound_slot_1_ent);
  setomnvar("zm_chem_compound_slot_2_ent", level.chem_compound_slot_2_ent);
  setomnvar("zm_chem_compound_slot_3_ent", level.chem_compound_slot_3_ent);
  setomnvar("zm_chem_compound_slot_4_ent", level.chem_compound_slot_4_ent);
}

setup_chem_compound_slot_world_lua() {
  level.chem_compound_slot_array = getEntArray("created_compound_name", "script_noteworthy");
  level.chem_compound_slot_1_ent = undefined;
  level.chem_compound_slot_2_ent = undefined;
  level.chem_compound_slot_3_ent = undefined;
  level.chem_compound_slot_4_ent = undefined;
  foreach(var_01 in level.chem_compound_slot_array) {
    switch (var_01.name) {
      case "created_compound_name_1":
        level.chem_compound_slot_1_ent = var_01;
        break;

      case "created_compound_name_2":
        level.chem_compound_slot_2_ent = var_01;
        break;

      case "created_compound_name_3":
        level.chem_compound_slot_3_ent = var_01;
        break;

      case "created_compound_name_4":
        level.chem_compound_slot_4_ent = var_01;
        break;
    }
  }
}

setup_constants() {
  level.constant_array = getEntArray("chem_const_1", "script_noteworthy");
  level.constant_1_ent = undefined;
  level.constant_2_ent = undefined;
  level.constant_3_num = undefined;
  level.constant_4_ent = undefined;
  foreach(var_01 in level.constant_array) {
    switch (var_01.name) {
      case "chem_const_diamond_1":
        level.constant_1_ent = var_01;
        break;

      case "chem_const_diamond_2":
        level.constant_2_ent = var_01;
        break;

      case "chem_const_diamond_3":
        level.constant_3_ent = var_01;
        break;

      case "chem_const_diamond_4":
        level.constant_4_ent = var_01;
        break;
    }
  }
}

setup_diamond_constant_player_omnvars(param_00) {
  param_00 setclientomnvar("zm_ui_constant_1_ent", level.constant_1_ent);
  param_00 setclientomnvar("zm_ui_constant_2_ent", level.constant_2_ent);
  param_00 setclientomnvar("zm_ui_constant_3_ent", level.constant_3_ent);
  param_00 setclientomnvar("zm_ui_constant_4_ent", level.constant_4_ent);
}

setup_pi_constant() {
  level.pi_const = getent("chem_const_2", "script_noteworthy");
}

setup_eye_equation_constant() {
  level.eye_equation = getent("chem_const_3", "script_noteworthy");
}

setup_color_key_chart() {
  level.color_eye = getent("chem_const_tv_screen", "script_noteworthy");
}

setup_heat_pressure_equation_constant() {
  level.heat_pressure_eq = getent("chem_const_equation", "script_noteworthy");
}

setup_lab_screen() {
  level.lab_screen = getent("chem_const_lab_screen", "script_noteworthy");
}

init_chem_reaction_interactions() {
  init_beakers();
  init_compound_storage_objects();
  init_reaction_start_interactable_model();
  level.heat_pressure_machine_value = 0;
}

init_reaction_start_interactable_model() {
  var_00 = scripts\engine\utility::getstruct("reaction_start_model", "script_noteworthy");
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("tag_origin");
  var_00.model = var_01;
  level.reaction_start_model = var_00;
}

update_player_monitor_reaction_start(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    if(distance2dsquared(param_00.origin, self.origin) > 6400) {
      wait(0.05);
      continue;
    } else {
      update_reaction_button_state_for_player(self, param_00);
    }

    scripts\engine\utility::waitframe();
  }
}

update_reaction_button_state_for_player(param_00, param_01) {
  if(distance2dsquared(param_01.origin, param_00.origin) > 6400) {
    return;
  }

  if(!param_00 worldpointinreticle_circle(param_01.origin, 25, 80)) {
    return;
  }

  show_reaction_hint_for_time(2, param_00);
}

show_reaction_hint_for_time(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 notify("end_thread_instance");
  param_01 endon("end_thread_instance");
  param_01 forceusehinton(&"CP_TOWN_INTERACTIONS_START_REACTION");
  wait(param_00);
  param_01 getrigindexfromarchetyperef();
}

watch_for_reaction_start_pressed(param_00) {
  self endon("disconnect");
  for(;;) {
    if(!self usebuttonpressed()) {
      wait(0.05);
      continue;
    }

    if(player_use_reaction_start_struct(param_00, self)) {
      reaction_activation(param_00, self);
      wait(0.5);
    }

    wait(0.5);
  }
}

player_use_reaction_start_struct(param_00, param_01) {
  if(!isDefined(param_00.model)) {
    return 0;
  }

  if(distance2dsquared(param_00.model.origin, param_01.origin) > 4900) {
    return 0;
  }

  if(!param_01 worldpointinreticle_circle(param_00.model.origin, 65, 70)) {
    return 0;
  }

  return 1;
}

play_failure_fx(param_00) {
  param_00 thread watch_for_disconnect_player();
  param_00 endon("disconnect");
  foreach(var_02 in level.chemical_containers) {
    playFX(level._effect["fail_reaction_fx"], var_02.interaction.model.origin);
  }

  scripts\engine\utility::waitframe();
  playfxontagforclients(level._effect["fail_reaction_screenfx"], param_00, "tag_eye", param_00);
  level.computer_model setscriptablepartstate("redlight", "on");
  level.computer_model setscriptablepartstate("yellowlight", "off");
  wait(6);
  stopfxontagforclients(level._effect["fail_reaction_screenfx"], param_00, "tag_eye", param_00);
  level.computer_model setscriptablepartstate("redlight", "off");
  level.computer_model setscriptablepartstate("yellowlight", "on");
}

watch_for_disconnect_player() {
  self waittill("disconnect");
  stopfxontagforclients(level._effect["fail_reaction_screenfx"], self, "tag_eye", self);
  level.computer_model setscriptablepartstate("redlight", "off");
  level.computer_model setscriptablepartstate("yellowlight", "on");
}

play_success_fx(param_00) {
  param_00 endon("disconnect");
  playfxontagforclients(level._effect["success_reaction_screenfx"], param_00, "tag_eye", param_00);
  level.computer_model setscriptablepartstate("greenlight", "on");
  level.computer_model setscriptablepartstate("yellowlight", "off");
  wait(6);
  stopfxontagforclients(level._effect["success_reaction_screenfx"], param_00, "tag_eye", param_00);
  level.computer_model setscriptablepartstate("greenlight", "off");
  level.computer_model setscriptablepartstate("yellowlight", "on");
}

watch_for_player_interaction_with_reaction_storage(param_00) {
  for(;;) {
    if(!isDefined(level.players)) {
      wait(1);
      continue;
    } else {
      break;
    }
  }

  foreach(var_02 in level.players) {
    var_02 thread watch_for_input_entered_on_reaction_storage(param_00);
  }
}

watch_for_input_entered_on_reaction_storage(param_00) {
  self notifyonplayercommand("add_swap_compound", "+usereload");
  self notifyonplayercommand("discard_reaction", "+actionslot 4");
  var_01 = "";
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("add_swap_compound", "discard_reaction");
    if(distance2dsquared(param_00.model.origin, self.origin) > 6400) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(param_00.model.origin, 65, 80)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_01)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_01 == "add_swap_compound") {
      add_swap_compound(param_00, self);
      wait(1);
      continue;
    }

    if(var_01 == "discard_reaction") {
      discard_reaction_contents(param_00, self);
      wait(1);
    }
  }
}

discard_reaction_contents(param_00, param_01) {
  if(isDefined(param_00.compound_contained) && param_00.compound_contained != "") {
    param_00.compound_contained = "";
    if(isDefined(param_00.filled_fx)) {
      param_00.filled_fx delete();
      return;
    }
  }
}

add_swap_compound(param_00, param_01) {
  var_02 = get_compound_object_value(param_00);
  var_03 = get_chemical_carried_by_player(param_01);
  if(var_02 == "" && var_03 == "") {
    return;
  }

  if(var_02 != "") {
    set_chemical_carried_by_player(param_01, var_02);
    if(var_02 == level.bomb_compound.name) {
      scripts\engine\utility::flag_set("chemistry_step3");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_mixture", "town_comment_vo");
    }

    playFX(level._effect["sb_quest_item_pickup"], param_00.model.origin);
  }
}

reaction_activation(param_00, param_01) {
  var_02 = "";
  var_03 = 0;
  scripts\engine\utility::play_sound_in_space("chemistry_machine_button_press", param_00.origin);
  var_04 = level.constant_value;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  foreach(var_09 in level.chemical_containers) {
    if(var_09.interaction.chemical_contained == "") {
      continue;
    }

    if(var_09.interaction.chemical_contained == level.bomb_compound.name) {
      var_05 = var_05 + -100;
      var_06 = var_06 + -100;
    }

    switch (level.bomb_compound.choice) {
      case 1:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 8));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 9));
        break;

      case 2:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 10));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 11));
        break;

      case 3:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 12));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 13));
        break;

      case 4:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 14));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 15));
        break;

      case 5:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 16));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 17));
        break;

      case 6:
        var_05 = var_05 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 18));
        var_06 = var_06 + int(tablelookup("cp\zombies\elements.csv", 1, var_09.interaction.chemical_contained, 19));
        break;
    }

    var_07 = var_05 + var_06 - var_04;
  }

  if(level.heat_pressure_machine_value == var_07) {
    setomnvar("zm_chem_number_entry_1", -1);
  } else {
    scripts\engine\utility::play_sound_in_space("chemistry_reaction_failure", param_00.origin);
    param_01 thread play_failure_fx(param_01);
    param_01 thread chem_failure_debuff(param_00, param_01);
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_quest_failure", "rave_announcer_vo");
    setomnvar("zm_chem_number_entry_1", -1);
    return;
  }

  wait(0.2);
  earthquake(0.18, 3, param_00.origin, 784);
  wait(0.05);
  playrumbleonposition("artillery_rumble", param_00.origin);
  wait(2);
  var_0B = "";
  var_0C = "";
  var_0D = "";
  var_0E = "";
  var_0F = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  foreach(var_25, var_14 in level.compounds) {
    var_15 = var_25;
    var_0F = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_0B = "";
    var_0C = "";
    var_0D = "";
    var_0E = "";
    if(var_14.parta != "") {
      var_0B = var_14.parta;
    }

    if(var_14.partb != "") {
      var_0C = var_14.partb;
    }

    if(var_14.partc != "") {
      var_0D = var_14.partc;
    }

    if(var_14.partd != "") {
      var_0E = var_14.partd;
    }

    if(isDefined(var_0B) && var_0B != "") {
      foreach(var_17 in level.chemical_containers) {
        if(var_17.interaction.chemical_contained == "") {
          continue;
        }

        if(var_0B == var_17.interaction.chemical_contained) {
          var_0F = 1;
          var_17.interaction.checked_in_reaction = 1;
          continue;
        }
      }
    } else if(isDefined(var_0B) && var_0B == "") {
      var_18 = 0;
      var_19 = 0;
      foreach(var_17 in level.chemical_containers) {
        if(scripts\engine\utility::istrue(var_17.interaction.checked_in_reaction)) {
          continue;
        }

        if(var_17.interaction.chemical_contained == "") {
          if(!var_18) {
            var_0F = 1;
            var_17.interaction.checked_in_reaction = 1;
            var_18 = 1;
            continue;
          }

          continue;
        }

        var_0F = 0;
        continue;
      }
    } else {
      var_0F = 0;
    }

    if(var_0F == 0) {
      continue;
    }

    if(isDefined(var_0C) && var_0C != "") {
      foreach(var_17 in level.chemical_containers) {
        if(var_17.interaction.chemical_contained == "") {
          continue;
        }

        if(var_0C == var_17.interaction.chemical_contained) {
          var_10 = 1;
          var_17.interaction.checked_in_reaction = 1;
          continue;
        }
      }
    } else if(isDefined(var_0C) && var_0C == "") {
      var_1C = 0;
      var_1D = 0;
      foreach(var_17 in level.chemical_containers) {
        if(scripts\engine\utility::istrue(var_17.interaction.checked_in_reaction)) {
          continue;
        }

        if(var_17.interaction.chemical_contained == "") {
          if(!var_1C) {
            var_10 = 1;
            var_17.interaction.checked_in_reaction = 1;
            var_1C = 1;
            continue;
          }

          continue;
        }

        var_10 = 0;
        continue;
      }
    } else {
      var_10 = 0;
    }

    if(var_10 == 0) {
      continue;
    }

    if(isDefined(var_0D) && var_0D != "") {
      foreach(var_17 in level.chemical_containers) {
        if(var_17.interaction.chemical_contained == "") {
          continue;
        }

        if(var_0D == var_17.interaction.chemical_contained) {
          var_11 = 1;
          continue;
        }
      }
    } else if(isDefined(var_0D) && var_0D == "") {
      var_20 = 0;
      var_21 = 0;
      foreach(var_17 in level.chemical_containers) {
        if(scripts\engine\utility::istrue(var_17.interaction.checked_in_reaction)) {
          continue;
        }

        if(scripts\engine\utility::istrue(var_10) && scripts\engine\utility::istrue(var_0F)) {
          if(var_17.interaction.chemical_contained == "") {
            if(!var_20) {
              var_11 = 1;
              var_17.interaction.checked_in_reaction = 1;
              var_20 = 1;
              continue;
            }
          } else {
            var_11 = 0;
            continue;
          }

          continue;
        }

        var_11 = 0;
        continue;
      }
    } else {
      var_11 = 0;
    }

    if(isDefined(var_0E) && var_0E != "") {
      foreach(var_17 in level.chemical_containers) {
        if(var_17.interaction.chemical_contained == "") {
          continue;
        }

        if(var_0E == var_17.interaction.chemical_contained) {
          var_12 = 1;
          continue;
        }
      }
    } else if(isDefined(var_0E) && var_0E == "") {
      if(scripts\engine\utility::istrue(var_10) && scripts\engine\utility::istrue(var_0F) && scripts\engine\utility::istrue(var_11)) {
        foreach(var_17 in level.chemical_containers) {
          if(scripts\engine\utility::istrue(var_17.interaction.checked_in_reaction)) {
            continue;
          }

          if(var_17.interaction.chemical_contained == "") {
            var_12 = 1;
            break;
          } else {
            var_12 = 0;
            continue;
          }
        }
      } else {
        var_14 = 0;
        continue;
      }
    } else {
      var_12 = 0;
    }

    if(var_0F && var_10 && var_11 && var_12) {
      var_0B = "";
      var_0C = "";
      var_0D = "";
      var_0E = "";
      var_02 = var_15;
      level thread clear_check_status_beakers();
      break;
    } else {
      continue;
    }
  }

  if(var_02 == "") {
    param_01 thread play_failure_fx(param_01);
    level thread clear_check_status_beakers();
    scripts\engine\utility::play_sound_in_space("chemistry_reaction_failure", param_00.origin);
    param_01 thread chem_failure_debuff(param_00, param_01);
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_quest_failure", "rave_announcer_vo");
    return;
  }

  level thread clear_check_status_beakers();
  level thread play_success_fx(param_01);
  scripts\engine\utility::play_sound_in_space("chemistry_reaction_sucess", param_00.origin);
  for(var_26 = level.chemical_compounds_created.size - 1; var_26 >= 0; var_26--) {
    if(isDefined(level.chemical_compounds_created[var_26 + 1])) {
      level.chemical_compounds_created[var_26 + 1].interaction.compound_contained = level.chemical_compounds_created[var_26].interaction.compound_contained;
      if(level.chemical_compounds_created[var_26 + 1].interaction.compound_contained != "") {
        if(isDefined(level.chemical_compounds_created[var_26 + 1].interaction.filled_fx)) {
          level.chemical_compounds_created[var_26 + 1].interaction.filled_fx delete();
        }

        foreach(var_25, var_28 in level.elements) {
          if(var_25 == level.chemical_compounds_created[var_26 + 1].interaction.compound_contained) {
            if(isDefined(var_28.fx_trigger)) {
              level.chemical_compounds_created[var_26 + 1].interaction.filled_fx = spawnfx(var_28.fx_trigger, level.chemical_compounds_created[var_26 + 1].interaction.model.origin);
              triggerfx(level.chemical_compounds_created[var_26 + 1].interaction.filled_fx);
            }
          }
        }

        continue;
      }

      if(isDefined(level.chemical_compounds_created[var_26 + 1].interaction.filled_fx)) {
        level.chemical_compounds_created[var_26 + 1].interaction.filled_fx delete();
      }
    }
  }

  level.chemical_compounds_created[0].interaction.compound_contained = var_02;
  if(isDefined(level.chemical_compounds_created[0].interaction.filled_fx)) {
    level.chemical_compounds_created[0].interaction.filled_fx delete();
  }

  foreach(var_25, var_2A in level.elements) {
    if(var_25 == level.chemical_compounds_created[0].interaction.compound_contained) {
      if(isDefined(var_2A.fx_trigger)) {
        level.chemical_compounds_created[0].interaction.filled_fx = spawnfx(var_2A.fx_trigger, level.chemical_compounds_created[0].interaction.model.origin);
        triggerfx(level.chemical_compounds_created[0].interaction.filled_fx);
      }
    }
  }

  if(level.chemical_compounds_created[0].interaction.compound_contained != "") {
    if(isDefined(level.chemical_compounds_created[0].interaction.filled_fx)) {
      triggerfx(level.chemical_compounds_created[0].interaction.filled_fx);
    } else {
      level.chemical_compounds_created[0].interaction.filled_fx = spawnfx(level.chemical_compounds_created[0].interaction.fx_trigger, level.chemical_compounds_created[0].interaction.model.origin);
      triggerfx(level.chemical_compounds_created[0].interaction.filled_fx);
    }
  }

  level thread update_beaker_omnvars();
  foreach(var_2C in level.chemical_containers) {
    discard_beaker_chemical(var_2C.interaction, param_01);
  }
}

clear_check_status_beakers() {
  foreach(var_01 in level.chemical_containers) {
    var_01.interaction.checked_in_reaction = 0;
  }
}

update_beaker_omnvars() {
  if(level.chemical_compounds_created[0].interaction.compound_contained != "") {
    var_00 = level.chemical_compounds_created[0].interaction.compound_contained;
    var_01 = int(level.elements[var_00].omnvar);
    setomnvar("zm_chem_compound_slot_1_idx", var_01);
  } else {
    setomnvar("zm_chem_compound_slot_1_idx", -1);
  }

  if(level.chemical_compounds_created[1].interaction.compound_contained != "") {
    var_02 = level.chemical_compounds_created[1].interaction.compound_contained;
    var_03 = int(level.elements[var_02].omnvar);
    setomnvar("zm_chem_compound_slot_2_idx", var_03);
  } else {
    setomnvar("zm_chem_compound_slot_2_idx", -1);
  }

  if(level.chemical_compounds_created[2].interaction.compound_contained != "") {
    var_04 = level.chemical_compounds_created[2].interaction.compound_contained;
    var_05 = int(level.elements[var_04].omnvar);
    setomnvar("zm_chem_compound_slot_3_idx", var_05);
  } else {
    setomnvar("zm_chem_compound_slot_3_idx", -1);
  }

  if(level.chemical_compounds_created[3].interaction.compound_contained != "") {
    var_06 = level.chemical_compounds_created[3].interaction.compound_contained;
    var_07 = int(level.elements[var_06].omnvar);
    setomnvar("zm_chem_compound_slot_4_idx", var_07);
    return;
  }

  setomnvar("zm_chem_compound_slot_4_idx", -1);
}

chem_failure_debuff(param_00, param_01) {
  param_01 dodamage(param_01.maxhealth * 0.95, param_01.origin);
  foreach(var_03 in level.chemical_containers) {
    discard_beaker_chemical(var_03.interaction, param_01);
  }
}

element_pickup_hint_func(param_00, param_01) {
  return "";
}

init_beakers() {
  level._effect["sb_quest_item_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
  var_00 = scripts\engine\utility::getstructarray("chemistry_container_model", "script_noteworthy");
  foreach(var_04, var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "chem_container_01":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin");
        var_03.angles = var_02.angles;
        break;

      case "chem_container_02":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin");
        var_03.angles = var_02.angles;
        break;

      case "chem_container_03":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin");
        var_03.angles = var_02.angles;
        break;

      case "chem_container_04":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin");
        var_03.angles = var_02.angles;
        break;

      default:
        break;
    }

    var_03 hide();
    var_02.chemical_contained = "";
    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    level.chemical_containers[var_04] = var_02;
  }
}

init_compound_storage_objects() {
  var_00 = scripts\engine\utility::getstructarray("compound_storage_model", "script_noteworthy");
  foreach(var_04, var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "compound_storage_1":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("p7_chemistry_kit_beaker_lg");
        var_03.angles = var_02.angles;
        break;

      case "compound_storage_2":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("p7_chemistry_kit_beaker_lg");
        var_03.angles = var_02.angles;
        break;

      case "compound_storage_3":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("p7_chemistry_kit_beaker_lg");
        var_03.angles = var_02.angles;
        break;

      case "compound_storage_4":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("p7_chemistry_kit_beaker_lg");
        var_03.angles = var_02.angles;
        break;

      default:
        break;
    }

    var_03 hide();
    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    var_02.compound_contained = "";
    var_02.compound_container_filled = 0;
    level.chemical_compounds_created[var_04] = var_02;
  }
}

watch_for_input_entered_on_compound(param_00) {
  self notifyonplayercommand("add_compound", "+usereload");
  self notifyonplayercommand("add_compound", "+activate");
  self notifyonplayercommand("discard_compound", "+actionslot 4");
  var_01 = "";
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("add_compound", "discard_compound");
    if(distance2dsquared(param_00.origin, self.origin) > 8100) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(param_00.origin, 65, 90)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_01)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_01 == "add_compound") {
      add_compound_to_player(param_00, self);
      wait(1);
      continue;
    }

    if(var_01 == "discard_compound") {
      discard_compound(param_00, self);
      wait(1);
    }
  }
}

get_compound_object_value(param_00) {
  return param_00.compound_contained;
}

discard_compound(param_00, param_01) {
  if(isDefined(param_00.compound_contained) && param_00.compound_contained != "") {
    param_00.compound_contained = "";
    level thread update_beaker_omnvars();
    if(isDefined(param_00.filled_fx)) {
      param_00.filled_fx delete();
    }

    playsoundatpos(param_00.origin, "chemistry_placement");
  }
}

add_compound_to_player(param_00, param_01) {
  var_02 = get_compound_object_value(param_00);
  var_03 = get_chemical_carried_by_player(param_01);
  playsoundatpos(param_00.model.origin, "chemistry_placement");
  if(var_02 == "") {
    if(var_03 != "") {
      set_chemical_carried_by_player_after_beaker_deposit(param_01, "");
      level thread update_beaker_omnvars();
      playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
      return;
    }

    return;
  }

  set_chemical_carried_by_player(param_01, var_02);
  if(var_02 == level.bomb_compound.name) {
    scripts\engine\utility::flag_set("chemistry_step3");
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_mixture", "town_comment_vo");
  }

  playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
}

discard_beaker_chemical(param_00, param_01) {
  if(isDefined(param_00.chemical_contained) && param_00.chemical_contained != "") {
    if(isDefined(param_00.filled_fx)) {
      param_00.filled_fx delete();
    }

    param_00.chemical_contained = "";
    param_00.model setModel("tag_origin");
  } else {}

  display_elements_in_beakers(param_00, -1, param_01);
}

get_chemistry_object_value(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    return param_00.chemical_contained;
  }

  return param_00.chemical_object_name;
}

add_element_to_beaker_interaction(param_00, param_01) {
  var_02 = param_00.chemical_contained;
  if(!isDefined(param_01.chemical_base_picked)) {
    param_01.chemical_base_picked = "";
  }

  var_03 = param_01.chemical_base_picked;
  if(var_03 == "") {
    if(var_02 == "") {
      param_01 playlocalsound("perk_machine_deny");
      return;
    } else {
      set_chemical_carried_by_player(param_01, var_02);
      discard_beaker_chemical(param_00, param_01);
      playsoundatpos(param_00.model.origin, "chemistry_placement");
    }

    return;
  } else {
    playsoundatpos(param_00.model.origin, "chemistry_placement");
    if(var_02 == "") {
      foreach(var_06, var_05 in level.elements) {
        if(var_03 == var_06) {
          if(var_05.type == "componant" || var_05.type == "final") {
            if(isDefined(var_05.fx_trigger)) {
              param_00.filled_fx = spawnfx(var_05.fx_trigger, param_00.model.origin);
              triggerfx(param_00.filled_fx);
            }
          }

          param_00.model setModel(var_05.model);
        }
      }
    } else {
      playsoundatpos(param_01.model.origin, "chemistry_placement");
      foreach(var_06, var_08 in level.elements) {
        if(var_03 == var_06) {
          param_00.model setModel(var_08.model);
          if(var_08.type == "componant" || var_08.type == "final") {
            if(isDefined(param_00.filled_fx)) {
              param_00.filled_fx delete();
            }

            if(isDefined(var_08.fx_trigger)) {
              param_00.filled_fx = spawnfx(var_08.fx_trigger, param_00.model.origin);
              triggerfx(param_00.filled_fx);
            }

            continue;
          }

          if(isDefined(param_00.filled_fx)) {
            param_00.filled_fx delete();
          }
        }
      }
    }
  }

  var_09 = var_02;
  playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
  add_chemical_to_beaker(param_01, param_00);
  set_chemical_carried_by_player_after_beaker_deposit(param_01, var_09);
  display_elements_in_beakers(param_00, var_03, param_01);
}

add_compounds_interaction(param_00, param_01) {
  var_02 = get_compound_object_value(param_00);
  var_03 = get_chemical_carried_by_player(param_01);
  playsoundatpos(param_00.model.origin, "chemistry_placement");
  if(var_02 == "") {
    if(var_03 != "") {
      set_chemical_carried_by_player_after_beaker_deposit(param_01, "");
      level thread update_beaker_omnvars();
      playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
      return;
    }

    return;
  }

  set_chemical_carried_by_player(param_01, var_02);
  if(var_02 == level.bomb_compound.name) {
    scripts\engine\utility::flag_set("chemistry_step3");
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_mixture", "town_comment_vo");
  }

  playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
}

try_play_swap_vfx(param_00, param_01, param_02) {
  var_03 = get_chemistry_object_value(param_00, param_02);
  var_04 = get_chemical_carried_by_player(param_01);
  if(var_04 == "" && !scripts\engine\utility::istrue(param_02)) {
    playFX(level._effect["sb_quest_item_pickup"], param_00.chemical_model_object.origin);
    set_chemical_carried_by_player(param_01, var_03);
    return;
  }

  if(var_04 == "" && scripts\engine\utility::istrue(param_02)) {
    if(var_03 == "") {
      param_01 playlocalsound("perk_machine_deny");
      return;
    } else {
      set_chemical_carried_by_player(param_01, var_03);
      discard_beaker_chemical(param_00, param_01);
      playsoundatpos(param_00.model.origin, "chemistry_placement");
    }

    return;
  }

  if(scripts\engine\utility::istrue(param_02)) {
    playsoundatpos(param_00.model.origin, "chemistry_placement");
    if(var_03 == "") {
      foreach(var_07, var_06 in level.elements) {
        if(var_04 == var_07) {
          if(var_06.type == "componant" || var_06.type == "final") {
            if(isDefined(var_06.fx_trigger)) {
              param_00.filled_fx = spawnfx(var_06.fx_trigger, param_00.model.origin);
              triggerfx(param_00.filled_fx);
            }
          }

          param_00.model setModel(var_06.model);
        }
      }
    } else {
      playsoundatpos(param_01.model.origin, "chemistry_placement");
      foreach(var_07, var_09 in level.elements) {
        if(var_04 == var_07) {
          param_00.model setModel(var_09.model);
          if(var_09.type == "componant" || var_09.type == "final") {
            if(isDefined(param_00.filled_fx)) {
              param_00.filled_fx delete();
            }

            if(isDefined(var_09.fx_trigger)) {
              param_00.filled_fx = spawnfx(var_09.fx_trigger, param_00.model.origin);
              triggerfx(param_00.filled_fx);
            }

            continue;
          }

          foreach(var_0B in level.chemical_containers) {
            foreach(var_0E, var_0D in level.elements) {
              if(var_04 == var_0E) {
                if(var_0D.type != "componant" || var_0D.type != "final") {
                  if(isDefined(var_0B.filled_fx)) {
                    var_0B.filled_fx delete();
                  }
                }
              }
            }
          }
        }
      }
    }

    var_10 = var_03;
    playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
    add_chemical_to_beaker(param_01, param_00);
    set_chemical_carried_by_player_after_beaker_deposit(param_01, var_10);
    display_elements_in_beakers(param_00, var_04, param_01);
    return;
  }

  set_chemical_carried_by_player(param_01, var_03);
  playFX(level._effect["sb_quest_item_pickup"], param_00.chemical_model_object.origin);
}

add_chemical_to_beaker(param_00, param_01) {
  var_02 = get_chemistry_object_value(param_01, 1);
  var_03 = get_chemical_carried_by_player(param_00);
  if(var_02 != "") {}

  set_chemical_in_beaker(param_01, var_03, param_00);
  display_elements_in_beakers(param_01, var_03, param_00);
}

display_elements_in_beakers(param_00, param_01, param_02) {
  var_03 = tablelookup("cp\zombies\elements.csv", 1, param_01, 0);
  var_04 = "chem_container_01";
  switch (param_00.name) {
    case "chem_container_01":
      var_04 = "zm_lab_screen_beaker1";
      break;

    case "chem_container_02":
      var_04 = "zm_lab_screen_beaker2";
      break;

    case "chem_container_03":
      var_04 = "zm_lab_screen_beaker3";
      break;

    case "chem_container_04":
      var_04 = "zm_lab_screen_beaker4";
      break;
  }

  if(isDefined(var_03)) {
    setomnvar(var_04, int(var_03));
  }
}

set_chemical_in_beaker(param_00, param_01, param_02) {
  if(!isDefined(param_00.chemical_contained)) {
    param_02 playlocalsound("perk_machine_deny");
    return;
  }

  var_03 = param_00.chemical_contained;
  param_00.chemical_contained = param_01;
}

swap_chemistry_object_with_player_chemical(param_00, param_01, param_02) {
  var_03 = get_chemistry_object_value(param_00);
  var_04 = get_chemical_carried_by_player(param_01);
  set_chemical_carried_by_player(param_01, var_03);
}

get_chemical_carried_by_player(param_00) {
  if(!isDefined(param_00.chemical_base_picked)) {
    param_00.chemical_base_picked = "";
  }

  return param_00.chemical_base_picked;
}

set_chemical_carried_by_player(param_00, param_01) {
  param_00.chemical_base_picked = param_01;
  var_02 = int(level.elements[param_01].omnvar);
  param_00 setclientomnvar("zm_chem_element_index", var_02);
  param_00 playlocalsound("zmb_item_pickup");
}

set_chemical_carried_by_player_after_beaker_deposit(param_00, param_01) {
  var_02 = int(level.elements[param_00.chemical_base_picked].omnvar);
  param_00 setclientomnvar("zm_chem_element_index", var_02);
  param_00.chemical_base_picked = param_01;
  if(isDefined(level.elements[param_00.chemical_base_picked])) {
    var_03 = int(level.elements[param_00.chemical_base_picked].omnvar);
    param_00 setclientomnvar("zm_chem_element_index", var_03);
    return;
  }

  param_00 setclientomnvar("zm_chem_element_index", 0);
}

init_setup_radio_prefabs() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "chem_radio_interaction", undefined, undefined, ::radios_interaction_hint_func, ::radios_activation_function, 0, 0, ::init_chem_radios, undefined);
}

radios_interaction_hint_func(param_00, param_01) {
  return "";
}

init_chem_radios() {
  level.chem_radio_1_sounds = [];
  level.chem_radio_1_sounds[0] = "db_day_2";
  level.chem_radio_2_sounds = [];
  level.chem_radio_2_sounds[0] = "db_day_3";
  level.chem_radio_3_sounds = [];
  level.chem_radio_3_sounds[0] = "db_day_5";
  level.chem_radio_4_sounds = [];
  level.chem_radio_4_sounds[0] = "db_day_6";
  level.chem_radio_5_sounds = [];
  level.chem_radio_5_sounds[0] = "db_day_7";
  level.chem_radio_6_sounds = [];
  level.chem_radio_6_sounds[0] = "db_day_8";
  var_00 = scripts\engine\utility::getstructarray("chem_radio_interaction", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.radio = spawn("script_origin", var_02.origin);
    var_03 = undefined;
    if(isDefined(var_03)) {
      var_02.model = var_03;
    }
  }

  setup_radio_vo_from_elements();
}

radios_activation_function(param_00, param_01) {
  var_02 = param_00.radio;
  var_03 = undefined;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  switch (param_00.name) {
    case "chem_radio_1":
      if(isDefined(level.chem_radio_1_wave)) {
        if(level.chem_radio_1_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_1_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_1_sounds, 0, 0);
        level.chem_radio_1_sounds = scripts\engine\utility::array_insert(level.chem_radio_1_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_1_current)) {
        level.chem_radio_1_current = 0;
      }

      var_03 = level.chem_radio_1_sounds[level.chem_radio_1_current];
      var_02 playSound(var_03);
      level.chem_radio_1_current = level.chem_radio_1_current + 1;
      if(level.chem_radio_1_current == level.chem_radio_1_sounds.size) {
        level.chem_radio_1_current = 0;
        level.chem_radio_1_wave = level.wave_num;
      }
      break;

    case "chem_radio_2":
      if(isDefined(level.chem_radio_2_wave)) {
        if(level.chem_radio_2_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_2_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_2_sounds, 0, 0);
        level.chem_radio_2_sounds = scripts\engine\utility::array_insert(level.chem_radio_2_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_2_current)) {
        level.chem_radio_2_current = 0;
      }

      var_03 = level.chem_radio_2_sounds[level.chem_radio_2_current];
      var_02 playSound(var_03);
      level.chem_radio_2_current = level.chem_radio_2_current + 1;
      if(level.chem_radio_2_current == level.chem_radio_2_sounds.size) {
        level.chem_radio_2_wave = level.wave_num;
        level.chem_radio_2_current = 0;
      }
      break;

    case "chem_radio_3":
      if(isDefined(level.chem_radio_3_wave)) {
        if(level.chem_radio_3_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_3_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_3_sounds, 0, 0);
        level.chem_radio_3_sounds = scripts\engine\utility::array_insert(level.chem_radio_3_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_3_current)) {
        level.chem_radio_3_current = 0;
      }

      var_03 = level.chem_radio_3_sounds[level.chem_radio_3_current];
      var_02 playSound(var_03);
      level.chem_radio_3_current = level.chem_radio_3_current + 1;
      if(level.chem_radio_3_current == level.chem_radio_3_sounds.size) {
        level.chem_radio_3_wave = level.wave_num;
        level.chem_radio_3_current = 0;
      }
      break;

    case "chem_radio_4":
      if(isDefined(level.chem_radio_4_wave)) {
        if(level.chem_radio_4_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_4_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_4_sounds, 0, 0);
        level.chem_radio_4_sounds = scripts\engine\utility::array_insert(level.chem_radio_4_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_4_current)) {
        level.chem_radio_4_current = 0;
      }

      var_03 = level.chem_radio_4_sounds[level.chem_radio_4_current];
      var_02 playSound(var_03);
      level.chem_radio_4_current = level.chem_radio_4_current + 1;
      if(level.chem_radio_4_current == level.chem_radio_4_sounds.size) {
        level.chem_radio_4_wave = level.wave_num;
        level.chem_radio_4_current = 0;
      }
      break;

    case "chem_radio_5":
      if(isDefined(level.chem_radio_5_wave)) {
        if(level.chem_radio_5_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.compound_intro_played)) {
        level.chem_radio_5_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_5_sounds, 0, 0);
        level.chem_radio_5_sounds = scripts\engine\utility::array_insert(level.chem_radio_5_sounds, "db_intro_3", 0);
        level.compound_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_5_current)) {
        level.chem_radio_5_current = 0;
      }

      var_03 = level.chem_radio_5_sounds[level.chem_radio_5_current];
      var_02 playSound(var_03);
      level.chem_radio_5_current = level.chem_radio_5_current + 1;
      if(level.chem_radio_5_current == level.chem_radio_5_sounds.size) {
        level.chem_radio_5_wave = level.wave_num;
        level.chem_radio_5_current = 0;
      }
      break;

    case "chem_radio_6":
      if(isDefined(level.chem_radio_6_wave)) {
        if(level.chem_radio_6_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!isDefined(level.compound_intro_played)) {
        level.chem_radio_6_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_6_sounds, 0, 0);
        level.chem_radio_6_sounds = scripts\engine\utility::array_insert(level.chem_radio_6_sounds, "db_intro_3", 0);
        level.compound_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_6_current)) {
        level.chem_radio_6_current = 0;
      }

      var_03 = level.chem_radio_6_sounds[level.chem_radio_6_current];
      var_02 playSound(var_03);
      level.chem_radio_6_current = level.chem_radio_6_current + 1;
      if(level.chem_radio_6_current == level.chem_radio_6_sounds.size) {
        level.chem_radio_6_wave = level.wave_num;
        level.chem_radio_6_current = 0;
      }
      break;

    case "chem_radio_7":
      if(isDefined(level.chem_radio_7_wave)) {
        if(level.chem_radio_7_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!scripts\engine\utility::istrue(level.chem_radio_7_fixed)) {
        if(!scripts\engine\utility::istrue(param_01.has_battery)) {
          param_01 scripts\cp\utility::setlowermessage("needs_battery", &"CP_TOWN_NEED_BATTERY", 4);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        } else {
          param_01 scripts\cp\utility::setlowermessage("insert_battery", &"CP_TOWN_INSERT_BATTERY", 4);
          level.chem_radio_7_fixed = 1;
          param_01.has_battery = 0;
          level.chem_radios_fixed = level.chem_radios_fixed + 1;
          level notify("radio_fixed");
          param_01 setclientomnvar("zm_nag_text", 0);
        }
      }

      if(!isDefined(level.chem_radio_7_current)) {
        level.chem_radio_7_current = 0;
      }

      if(scripts\engine\utility::istrue(level.radio_flip)) {
        var_03 = level.bomb_compound.radio2[level.chem_radio_7_current].var_10475;
        var_02 playSound(var_03);
        level.chem_radio_7_current = level.chem_radio_7_current + 1;
        if(level.chem_radio_7_current == level.bomb_compound.radio2.size) {
          level.chem_radio_7_wave = level.wave_num;
          level.chem_radio_7_current = 0;
        }
      } else {
        var_03 = level.bomb_compound.radio1[level.chem_radio_7_current].var_10475;
        var_02 playSound(var_03);
        level.chem_radio_7_current = level.chem_radio_7_current + 1;
        if(level.chem_radio_7_current == level.bomb_compound.radio1.size) {
          level.chem_radio_7_wave = level.wave_num;
          level.chem_radio_7_current = 0;
        }
      }

      param_01 getrigindexfromarchetyperef(&"CP_TOWN_INSERT_BATTERY");
      break;

    case "chem_radio_8":
      if(isDefined(level.chem_radio_8_wave)) {
        if(level.chem_radio_8_wave >= level.wave_num) {
          param_01 scripts\cp\utility::setlowermessage("rewinding_tape", &"CP_TOWN_TAPE_REWINDING", 3);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        }
      }

      if(!scripts\engine\utility::istrue(level.chem_radio_8_fixed)) {
        if(!scripts\engine\utility::istrue(param_01.has_battery)) {
          param_01 scripts\cp\utility::setlowermessage("needs_battery", &"CP_TOWN_NEED_BATTERY", 4);
          scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
          return;
        } else {
          param_01 scripts\cp\utility::setlowermessage("insert_battery", &"CP_TOWN_INSERT_BATTERY", 4);
          level.chem_radio_8_fixed = 1;
          param_01.has_battery = 0;
          level.chem_radios_fixed = level.chem_radios_fixed + 1;
          level notify("radio_fixed");
          param_01 setclientomnvar("zm_nag_text", 0);
        }
      }

      if(!isDefined(level.chem_radio_8_current)) {
        level.chem_radio_8_current = 0;
      }

      if(scripts\engine\utility::istrue(level.radio_flip)) {
        var_03 = level.bomb_compound.radio1[level.chem_radio_8_current].var_10475;
        var_02 playSound(var_03);
        level.chem_radio_8_current = level.chem_radio_8_current + 1;
        if(level.chem_radio_8_current == level.bomb_compound.radio1.size) {
          level.chem_radio_8_wave = level.wave_num;
          level.chem_radio_8_current = 0;
        }
      } else {
        var_03 = level.bomb_compound.radio2[level.chem_radio_8_current].var_10475;
        var_02 playSound(var_03);
        level.chem_radio_8_current = level.chem_radio_8_current + 1;
        if(level.chem_radio_8_current == level.bomb_compound.radio2.size) {
          level.chem_radio_8_wave = level.wave_num;
          level.chem_radio_8_current = 0;
        }
      }
      break;
  }

  var_04 = lookupsoundlength(var_03) / 1000;
  wait(var_04);
  if(var_03 == "db_hmx_4_clue") {
    var_02 playSound("db_hmx_4_append_clue");
    var_04 = lookupsoundlength("db_hmx_4_append_clue") / 1000;
    wait(var_04);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

setup_final_compound() {
  level.bomb_compound = spawnStruct();
  level.bomb_name_array = [];
  var_00 = randomintrange(0, level.final_compounds.size - 1);
  determine_proper_color();
  level.bomb_compound.name = level.final_compounds[var_00];
  if(!isDefined(level.bomb_compound.name)) {}

  select_heat_pressure_choice_values();
  select_constant_value();
}

determine_proper_color() {
  var_00 = randomintrange(1, 4);
  if(var_00 == 1) {
    level.bomb_compound.color = "red";
  } else if(var_00 == 2) {
    level.bomb_compound.color = "green";
  } else {
    level.bomb_compound.color = "blue";
  }

  setomnvar("zm_chem_correct_color", var_00);
}

select_heat_pressure_choice_values() {
  var_00 = randomintrange(1, 7);
  level.bomb_compound.choice = var_00;
  level.bad_choice_index_default = randomintrange(1, 7);
  for(;;) {
    if(level.bad_choice_index_default == level.bomb_compound.choice) {
      level.bad_choice_index_default = randomintrange(1, 7);
      continue;
    }

    break;
  }

  level.bad_choice_index_color_red = randomintrange(1, 7);
  for(;;) {
    if(level.bad_choice_index_color_red == level.bomb_compound.choice || level.bad_choice_index_color_red == level.bad_choice_index_default) {
      level.bad_choice_index_color_red = randomintrange(1, 7);
      continue;
    }

    break;
  }

  level.bad_choice_index_color_green = randomintrange(1, 7);
  for(;;) {
    if(level.bad_choice_index_color_green == level.bomb_compound.choice || level.bad_choice_index_color_green == level.bad_choice_index_default || level.bad_choice_index_color_green == level.bad_choice_index_color_red) {
      level.bad_choice_index_color_green = randomintrange(1, 7);
      continue;
    }

    break;
  }

  level.bad_choice_index_color_blue = randomintrange(1, 7);
  for(;;) {
    if(level.bad_choice_index_color_blue == level.bomb_compound.choice || level.bad_choice_index_color_blue == level.bad_choice_index_default || level.bad_choice_index_color_blue == level.bad_choice_index_color_red || level.bad_choice_index_color_blue == level.bad_choice_index_color_green) {
      level.bad_choice_index_color_blue = randomintrange(1, 7);
      continue;
    }

    break;
  }

  thread set_blackboard_initial_omnvar();
}

set_blackboard_initial_omnvar() {
  wait(5);
  setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_default);
}

select_constant_value() {
  var_00 = [];
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow("cp\zombies\diapi_table.csv", var_01, 1);
    if(var_02 == "") {
      break;
    }

    var_00[var_01] = int(var_02);
    var_01++;
  }

  var_03 = randomintrange(0, var_00.size);
  level.constant_value = var_00[var_03];
  var_04 = randomintrange(0, var_00.size);
  for(;;) {
    if(var_04 == var_03) {
      var_04 = randomintrange(0, var_00.size);
      continue;
    }

    break;
  }

  var_05 = randomintrange(0, var_00.size);
  for(;;) {
    if(var_05 == var_03 || var_05 == var_04) {
      var_05 = randomintrange(0, var_00.size);
      continue;
    }

    break;
  }

  var_06 = randomintrange(0, var_00.size);
  for(;;) {
    if(var_06 == var_03 || var_06 == var_04 || var_06 == var_05) {
      var_06 = randomintrange(0, var_00.size);
      continue;
    }

    break;
  }

  level.constant_bad_value_1 = var_00[var_04];
  level.constant_bad_value_2 = var_00[var_05];
  level.constant_bad_value_3 = var_00[var_06];
  choose_constant_locations();
}

choose_constant_locations() {
  level.correct_constant_loc = randomintrange(1, 5);
  var_00 = randomintrange(1, 5);
  for(;;) {
    if(var_00 == level.correct_constant_loc) {
      var_00 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  var_01 = randomintrange(1, 5);
  for(;;) {
    if(var_01 == level.correct_constant_loc || var_01 == var_00) {
      var_01 = randomintrange(1, 5);
      continue;
    }

    break;
  }

  var_02 = randomintrange(1, 5);
  for(;;) {
    if(var_02 == level.correct_constant_loc || var_02 == var_00 || var_02 == var_01) {
      var_02 = randomintrange(1, 5);
      continue;
    }

    break;
  }

  level.bad_constants_loc1 = spawnStruct();
  level.bad_constants_loc1.value = var_00;
  level.bad_constants_loc2 = spawnStruct();
  level.bad_constants_loc2.value = var_01;
  level.bad_constants_loc3 = spawnStruct();
  level.bad_constants_loc3.value = var_02;
  set_constant_omnvars(level.correct_constant_loc, level.constant_value);
  set_constant_omnvars(var_00, level.constant_bad_value_1);
  set_constant_omnvars(var_01, level.constant_bad_value_2);
  set_constant_omnvars(var_02, level.constant_bad_value_3);
  set_bad_loc_colors();
  if(level.bad_constants_loc1.value == 1) {
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_1";
  } else if(level.bad_constants_loc1.value == 2) {
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_2";
  } else if(level.bad_constants_loc1.value == 3) {
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_3";
  } else if(level.bad_constants_loc1.value == 4) {
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_4";
  }

  if(level.bad_constants_loc2.value == 1) {
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_1";
  } else if(level.bad_constants_loc2.value == 2) {
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_2";
  } else if(level.bad_constants_loc2.value == 3) {
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_3";
  } else if(level.bad_constants_loc2.value == 4) {
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_4";
  }

  if(level.bad_constants_loc3.value == 1) {
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_1";
  } else if(level.bad_constants_loc3.value == 2) {
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_2";
  } else if(level.bad_constants_loc3.value == 3) {
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_3";
  } else if(level.bad_constants_loc3.value == 4) {
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_4";
  }

  select_pi_value();
}

set_constant_omnvars(param_00, param_01) {
  switch (param_00) {
    case 1:
      setomnvar("zm_chem_const_loc_1", param_01);
      break;

    case 2:
      setomnvar("zm_chem_const_loc_2", param_01);
      break;

    case 3:
      setomnvar("zm_chem_const_loc_3", param_01);
      break;

    case 4:
      setomnvar("zm_chem_const_loc_4", param_01);
      break;
  }
}

set_bad_loc_colors() {
  var_00 = randomintrange(1, 4);
  if(var_00 == 1) {
    level.bad_constants_loc1.color = "red";
  } else if(var_00 == 2) {
    level.bad_constants_loc1.color = "green";
  } else {
    level.bad_constants_loc1.color = "blue";
  }

  var_01 = randomintrange(1, 4);
  for(;;) {
    if(var_01 == var_00) {
      var_01 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  if(var_01 == 1) {
    level.bad_constants_loc2.color = "red";
  } else if(var_01 == 2) {
    level.bad_constants_loc2.color = "green";
  } else {
    level.bad_constants_loc2.color = "blue";
  }

  var_02 = randomintrange(1, 4);
  for(;;) {
    if(var_02 == var_00 || var_02 == var_01) {
      var_02 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  if(var_02 == 1) {
    level.bad_constants_loc3.color = "red";
    return;
  }

  if(var_02 == 2) {
    level.bad_constants_loc3.color = "green";
    return;
  }

  level.bad_constants_loc3.color = "blue";
}

set_not_equal_constant(param_00) {
  if(level.bad_constants_loc1.color == param_00) {
    setomnvar(level.bad_constants_loc1.omnvar, 1);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
    return;
  }

  if(level.bad_constants_loc2.color == param_00) {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 1);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
    return;
  }

  if(level.bad_constants_loc3.color == param_00) {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 1);
    return;
  }

  if(param_00 == "full") {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
    return;
  }
}

select_pi_value() {
  var_00 = randomintrange(2, 8);
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow("cp\zombies\diapi_table.csv", var_01, 1);
    if(var_02 == "") {
      break;
    }

    if(int(var_02) == level.constant_value) {
      level.constant_pi_value = int(tablelookupbyrow("cp\zombies\diapi_table.csv", var_01, var_00));
      break;
    }

    var_01++;
  }

  setomnvar("zm_chem_pi_constant", level.constant_pi_value);
  setup_color_key();
}

setup_color_key() {
  level.color_key_value = int(level.constant_pi_value * level.constant_value);
  setomnvar("zm_chem_color_key_value", level.color_key_value);
  var_00 = randomintrange(1, 5);
  setomnvar("zm_chem_color_key_rnd", var_00);
  var_01 = randomintrange(1, 4);
  setomnvar("zm_chem_color_key_slot", var_01);
}

build_vo_clues_from_final_compound() {}

parse_compound_vo_table() {
  level.bomb_compound.radio1 = [];
  level.bomb_compound.radio2 = [];
  var_00 = randomintrange(1, 3);
  if(var_00 == 2) {
    level.radio_flip = 1;
  }

  var_01 = randomintrange(4, 8);
  if(isDefined(level.final_compound_vo_table)) {
    var_02 = level.final_compound_vo_table;
  } else {
    var_02 = "cp\zombies\chem_vo.csv";
  }

  level.intro_chem_vo = [];
  var_03 = 0;
  for(;;) {
    var_04 = tablelookupbyrow(var_02, var_03, 0);
    if(var_04 == "") {
      break;
    }

    if(var_04 == level.bomb_compound.name) {
      var_04 = tablelookupbyrow(var_02, var_03, 0);
      var_05 = tablelookupbyrow(var_02, var_03, 1);
      var_06 = tablelookupbyrow(var_02, var_03, var_01);
      var_07 = tablelookupbyrow(var_02, var_03, 2);
      register_compound_vo(var_04, var_05, var_06, var_07);
    } else if(var_04 == "intro") {
      var_04 = tablelookupbyrow(var_02, var_03, 0);
      var_05 = tablelookupbyrow(var_02, var_03, 1);
      var_06 = tablelookupbyrow(var_02, var_03, var_01);
      var_07 = tablelookupbyrow(var_02, var_03, 2);
      register_intro_chem_vo(var_04, var_05, var_06, var_07);
    }

    var_03++;
  }

  level.bomb_compound.radio2 = scripts\engine\utility::array_randomize_objects(level.bomb_compound.radio2);
}

register_compound_vo(param_00, param_01, param_02, param_03) {
  if(param_01 == "7") {
    var_04 = level.bomb_compound.radio1.size;
    level.bomb_compound.radio1[var_04] = spawnStruct();
    level.bomb_compound.radio1[var_04].var_10475 = param_02;
    level.bomb_compound.radio1[var_04].radio = param_01;
    level.bomb_compound.radio1[var_04].tempstring = param_03;
    return;
  }

  if(param_01 == "8") {
    var_04 = level.bomb_compound.radio2.size;
    level.bomb_compound.radio2[var_04] = spawnStruct();
    level.bomb_compound.radio2[var_04].var_10475 = param_02;
    level.bomb_compound.radio2[var_04].radio = param_01;
    level.bomb_compound.radio2[var_04].tempstring = param_03;
  }
}

register_intro_chem_vo(param_00, param_01, param_02, param_03) {
  var_04 = level.intro_chem_vo.size;
  level.intro_chem_vo[var_04] = spawnStruct();
  level.intro_chem_vo[var_04].var_10475 = param_02;
  level.intro_chem_vo[var_04].order = param_01;
  level.intro_chem_vo[var_04].tempstring = param_03;
}