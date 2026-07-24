/*********************************************************
 * Decompiled and Edited by SyndiShanX
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
}

setup_chemistry_lab_models_in_world() {
  var_0 = getEntArray("chemistry_set_parts", "script_noteworthy");

  foreach(var_3, var_2 in var_0) {
    var_2 hide();
    level.chemistry_set_parts[var_3] = var_2;
  }
}

setup_heat_pressure_buttons() {
  var_0 = scripts\engine\utility::getStructArray("h_p_button", "script_noteworthy");
  var_1 = getEnt("chem_computer", "targetname");

  foreach(var_6, var_3 in var_0) {
    var_4 = undefined;

    switch (var_3.name) {
      case "h_p_button_1":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_1"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_2":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_2"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_3":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_3"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_4":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_4"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_5":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_5"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_6":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_6"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_7":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_7"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_8":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_8"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_9":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_9"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      case "h_p_button_0":
        var_4 = spawn("script_model", var_1 gettagorigin("tag_button_0"));
        var_4 setModel("cp_town_chem_lab_computer_interactive_button");
        var_4.angles = var_3.angles;
        break;
      default:
    }

    var_5 = strtok(var_3.name, "_");
    var_3.numeric_value = int(var_5[3]);

    if(isDefined(var_4))
      var_3.model = var_4;

    var_3.model hide();
    level.h_p_button_objects[var_6] = var_3;
  }
}

update_player_monitor_buttons(var_0) {
  level endon("game_ended");

  for(;;) {
    foreach(var_2 in level.players)
    update_button_state_for_player(var_2, var_0);

    scripts\engine\utility::waitframe();
  }
}

update_button_state_for_player(var_0, var_1) {
  var_0 endon("disconnect");

  if(distance2dsquared(var_1.origin, var_0.origin) > 6400) {
    var_1.model hudoutlinedisableforclient(var_0);
    var_0 forceusehintoff();
    scripts\engine\utility::waitframe();
    return;
  }

  if(!var_0 worldpointinreticle_circle(var_1.origin, 15, 80)) {
    var_1.model hudoutlinedisableforclient(var_0);
    scripts\engine\utility::waitframe();
    return;
  }

  level thread show_hint_for_time(2, var_0);
  var_1.model hudoutlineenableforclient(var_0, 3, 1, 0);
}

show_hint_for_time(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 notify("end_thread_instance");
  var_1 endon("end_thread_instance");
  var_1 forceusehinton(&"CP_TOWN_INTERACTIONS_PUSH_BOMB");
  wait(var_0);
  var_1 forceusehintoff();
}

watch_for_input_entered_on_button(var_0) {
  self notifyonplayercommand("select_button", "+usereload");
  var_1 = "";

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("select_button");

    if(distance2dsquared(var_0.origin, self.origin) > 6400) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.origin, 15, 80)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_1)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::is_true(level.crafted_chem_set)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_0.model hudoutlineenableforclient(self, 3, 1, 0);

    if(var_1 == "select_button") {
      self playgestureviewmodel("ges_point_gun", var_0.model);
      add_button_value_to_list(var_0, self);
      scripts\engine\utility::play_sound_in_space("chemistry_machine_button_press", var_0.origin);
      wait 1;
      var_0.model hudoutlinedisableforclient(self);
    }
  }
}

add_button_value_to_list(var_0, var_1) {
  if(!isDefined(level.h_p_buttons_value))
    level.h_p_buttons_value = [];

  if(!isDefined(level.buttons_pointer))
    level.buttons_pointer = 0;

  if(level.buttons_pointer > 1) {
    level.buttons_pointer = 0;
    level.h_p_buttons_value = [];
    setomnvar("zm_chem_number_entry_1", -1);
  }

  level.h_p_buttons_value[level.buttons_pointer] = var_0.numeric_value;

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

  foreach(var_2, var_1 in level.elements) {
    if(var_2 == "animalfat" || var_2 == "silver" || var_2 == "copper" || var_2 == "chill") {
      continue;
    }
    if(level.elements[var_2].type == "componant" || level.elements[var_2].type == "final") {
      continue;
    }
    var_1.interaction = create_chemical_object_interaction(var_1);
  }
}

parse_compounds_table() {
  if(isDefined(level.compound_table))
    var_0 = level.compound_table;
  else
    var_0 = "cp/zombies/compounds.csv";

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 1);
    var_4 = tablelookupbyrow(var_0, var_1, 2);
    var_5 = tablelookupbyrow(var_0, var_1, 3);
    var_6 = tablelookupbyrow(var_0, var_1, 4);
    var_7 = tablelookupbyrow(var_0, var_1, 5);
    var_8 = tablelookupbyrow(var_0, var_1, 6);
    register_compound(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_1++;
  }
}

register_compound(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.displayname = var_1;
  var_7.type = var_2;

  if(var_7.type == "final")
    level.final_compounds[level.final_compounds.size] = var_0;

  var_7.parta = var_3;
  var_7.partb = var_4;
  var_7.partc = var_5;
  var_7.partd = var_6;
  level.compounds[var_0] = var_7;
}

parse_elements_table() {
  if(isDefined(level.element_table))
    var_0 = level.element_table;
  else
    var_0 = "cp/zombies/elements.csv";

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 0);
    var_4 = tablelookupbyrow(var_0, var_1, 2);
    var_5 = tablelookupbyrow(var_0, var_1, 3);
    var_6 = tablelookupbyrow(var_0, var_1, 4);
    var_7 = tablelookupbyrow(var_0, var_1, 6);
    var_8 = tablelookupbyrow(var_0, var_1, 7);
    var_9 = tablelookupbyrow(var_0, var_1, 8);
    var_10 = tablelookupbyrow(var_0, var_1, 9);
    var_11 = tablelookupbyrow(var_0, var_1, 10);
    var_12 = tablelookupbyrow(var_0, var_1, 11);
    var_13 = tablelookupbyrow(var_0, var_1, 12);
    var_14 = tablelookupbyrow(var_0, var_1, 13);
    var_15 = tablelookupbyrow(var_0, var_1, 14);
    var_16 = tablelookupbyrow(var_0, var_1, 15);
    var_17 = tablelookupbyrow(var_0, var_1, 16);
    var_18 = tablelookupbyrow(var_0, var_1, 17);
    var_19 = tablelookupbyrow(var_0, var_1, 18);
    var_20 = tablelookupbyrow(var_0, var_1, 19);
    var_21 = tablelookupbyrow(var_0, var_1, 32);
    var_22 = tablelookupbyrow(var_0, var_1, 33);
    var_23 = tablelookupbyrow(var_0, var_1, 34);
    register_element(var_3, var_2, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23);
    var_1++;
  }
}

register_element(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21) {
  var_22 = spawnStruct();
  var_22.omnvar = var_0;
  var_22.displayname = var_2;
  var_22.unique = var_4;
  var_22.model = var_5;
  var_22.type = var_3;
  var_22.slot = var_6;
  var_22.valuesets = spawnStruct();
  var_22.valuesets.choicea = spawnStruct();
  var_22.valuesets.choicea.heat = var_7;
  var_22.valuesets.choicea.pressure = var_8;
  var_22.valuesets.choiceb = spawnStruct();
  var_22.valuesets.choiceb.heat = var_9;
  var_22.valuesets.choiceb.pressure = var_10;
  var_22.valuesets.choicec = spawnStruct();
  var_22.valuesets.choicec.heat = var_11;
  var_22.valuesets.choicec.pressure = var_12;
  var_22.valuesets.choiced = spawnStruct();
  var_22.valuesets.choiced.heat = var_13;
  var_22.valuesets.choiced.pressure = var_14;
  var_22.valuesets.choicee = spawnStruct();
  var_22.valuesets.choicee.heat = var_15;
  var_22.valuesets.choicee.pressure = var_16;
  var_22.valuesets.choicef = spawnStruct();
  var_22.valuesets.choicef.heat = var_17;
  var_22.valuesets.choicef.pressure = var_18;
  var_22.model_coordinates = var_19;
  var_22.model_angles = var_20;
  var_22._id_10475 = var_21;

  if(var_3 == "componant" || var_3 == "final") {
    if(var_3 == "componant") {
      var_23 = scripts\engine\utility::random([level._effect["beaker_chem_blue"], level._effect["beaker_chem_orange"], level._effect["beaker_chem_pink"], level._effect["beaker_chem_purple"]]);
      var_22.fx_trigger = var_23;
    } else
      var_22.fx_trigger = level._effect["beaker_chem_red"];

    level.elements[var_1] = var_22;
  } else if(var_1 == "animalfat") {
    level.animalfat = [];
    var_24 = strtok(var_22.model_coordinates, ",");
    var_25 = scripts\engine\utility::getStruct("cp_town_animal_fat", "script_noteworthy");
    var_26 = spawn("script_model", var_25.origin);
    var_26 setModel("tag_origin_chemical");
    var_26.angles = (0, 0, 0);
    var_26 setCanDamage(1);
    var_26.maxhealth = 5;
    var_26.health = 5;
    var_25.model = var_26;
    var_25.chemical_object_name = var_1;
    level.animalfat[level.animalfat.size] = var_25.model;
    var_25 thread watch_for_melee_on_chemical_object();
    level.elements[var_1] = var_22;
  } else if(var_1 == "copper") {
    level.silver = [];
    var_27 = scripts\engine\utility::getStructArray("cp_town_pennies", "script_noteworthy");

    foreach(var_29 in var_27) {
      var_26 = spawn("script_model", var_29.origin);
      var_26 setModel("tag_origin_chemical");
      var_26.angles = var_29.angles;
      var_26 setCanDamage(1);
      var_26.maxhealth = 5;
      var_26.health = 5;
      var_29.model = var_26;
      var_29.chemical_object_name = var_1;
      level.silver[level.silver.size] = var_29.model;
      var_29 thread watch_for_melee_on_chemical_object();
    }

    level.elements[var_1] = var_22;
  } else if(var_1 == "silver") {
    level.copper = [];
    var_31 = scripts\engine\utility::getStructArray("cp_town_quarters", "script_noteworthy");
    var_32 = spawnStruct();
    var_32.origin = (5270, 1596, 387);
    var_32.angles = (10, 184, 0);
    var_33 = spawnStruct();
    var_33.origin = (5265, 1637, 387);
    var_33.angles = (10, 184, 0);
    var_31 = scripts\engine\utility::add_to_array(var_31, var_32);
    var_31 = scripts\engine\utility::add_to_array(var_31, var_33);

    foreach(var_29 in var_31) {
      var_26 = spawn("script_model", var_29.origin);
      var_26 setModel("tag_origin_chemical");
      var_26.angles = var_29.angles;
      var_26 setCanDamage(1);
      var_26.maxhealth = 5;
      var_26.health = 5;
      var_29.model = var_26;
      var_29.chemical_object_name = var_1;
      level.copper[level.copper.size] = var_29.model;
      var_29 thread watch_for_melee_on_chemical_object();
    }

    level.elements[var_1] = var_22;
  } else if(var_1 == "chill") {
    var_26 = undefined;
    level.chill = [];
    var_36 = scripts\engine\utility::getStructArray("cp_town_chill", "script_noteworthy");

    foreach(var_29 in var_36) {
      var_26 = spawn("script_model", var_29.origin);
      var_26 setModel("tag_origin_chemical");
      var_26.angles = var_29.angles;
      var_26 setCanDamage(1);
      var_26.maxhealth = 5;
      var_26.health = 5;
      var_29.model = var_26;
      var_29.chemical_object_name = var_1;
      level.chill[level.chill.size] = var_29.model;
      var_29 thread watch_for_melee_on_chemical_object();
    }

    level.elements[var_1] = var_22;
  } else {
    var_24 = strtok(var_22.model_coordinates, ",");
    var_22.chemical_model_object = spawn("script_model", (int(var_24[0]), int(var_24[1]), int(var_24[2])));
    var_22.chemical_model_object setModel(var_22.model);
    var_39 = strtok(var_22.model_angles, ",");
    var_22.chemical_model_object.angles = (int(var_39[0]), int(var_39[1]), int(var_39[2]));
    var_22.chemical_object_name = var_1;
    level.elements[var_1] = var_22;
  }
}

setup_radio_vo_from_elements() {
  if(isDefined(level.element_table))
    var_0 = level.element_table;
  else
    var_0 = "cp/zombies/elements.csv";

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 3);
    var_4 = tablelookupbyrow(var_0, var_1, 4);
    var_5 = tablelookupbyrow(var_0, var_1, 7);
    var_6 = tablelookupbyrow(var_0, var_1, 34);
    register_radio_vo(var_2, var_3, var_4, var_5, var_6);
    var_1++;
  }
}

register_radio_vo(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == "chill") {
    return;
  }
  switch (var_3) {
    case "5":
      var_5 = level.chem_radio_1_sounds.size;
      level.chem_radio_1_sounds[var_5] = var_4;
      break;
    case "2":
      var_5 = level.chem_radio_2_sounds.size;
      level.chem_radio_2_sounds[var_5] = var_4;
      break;
    case "3":
      var_5 = level.chem_radio_3_sounds.size;
      level.chem_radio_3_sounds[var_5] = var_4;
      break;
    case "4":
      var_5 = level.chem_radio_4_sounds.size;
      level.chem_radio_4_sounds[var_5] = var_4;
      break;
    case "1":
      var_5 = level.chem_radio_5_sounds.size;
      level.chem_radio_5_sounds[var_5] = var_4;
      break;
    case "6":
      var_5 = level.chem_radio_6_sounds.size;
      level.chem_radio_6_sounds[var_5] = var_4;
      break;
  }
}

watch_for_melee_on_chemical_object() {
  for(;;) {
    self.model waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(self.chemical_object_name == "animalfat" && !issubstr(var_9, "cleaver"))
      continue;
    else if(self.chemical_object_name == "silver" && !issubstr(var_9, "crowbar"))
      continue;
    else if(self.chemical_object_name == "copper" && !issubstr(var_9, "crowbar")) {
      continue;
    }
    playFX(level._effect["sb_quest_item_pickup"], var_3);
    var_10 = get_chemistry_object_value(self, 0);
    var_11 = get_chemical_carried_by_player(var_1);

    if(var_11 == "")
      set_chemical_carried_by_player(var_1, var_10);
    else
      set_chemical_carried_by_player(var_1, var_10);

    if(self.model.health < 0) {
      self.model.health = 5;
      self.model.maxhealth = 5;
    }
  }
}

create_chemical_object_interaction(var_0) {
  var_1 = spawnStruct();
  var_1.script_noteworthy = "element_pickup";

  if(var_0.chemical_object_name == "sulfuricacid")
    var_1.origin = var_0.chemical_model_object.origin + (60, -31, 21);
  else {
    var_1.origin = var_0.chemical_model_object.origin;
    var_1.angles = var_0.chemical_model_object.angles;
  }

  var_1.requires_power = 0;
  var_1.powered_on = 1;
  var_1.script_parameters = "element_pickup";
  var_1.name = "element_pickup";
  var_1.chemical_model_object = var_0.chemical_model_object;
  var_1.spend_type = undefined;
  var_1.cost = 0;
  var_1.chemical_object_name = var_0.chemical_object_name;
  var_1.hint_func = ::element_pickup_hint_func;
  var_1.activation_func = ::try_play_swap_vfx;
  var_1.enabled = 1;
  var_1.disable_guided_interactions = 1;
  level.interactions[var_1.name] = var_1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  return var_1;
}

setup_blackboards() {
  level.blackboard_array = getEntArray("blackboard_model", "script_noteworthy");
  level.blackboard_1_ent = undefined;
  level.blackboard_2_ent = undefined;
  level.blackboard_3_num = undefined;
  level.blackboard_4_ent = undefined;
  level.blackboard_5_ent = undefined;
  level.blackboard_6_ent = undefined;

  foreach(var_1 in level.blackboard_array) {
    switch (var_1.name) {
      case "blackboard_1":
        level.blackboard_1_ent = var_1;
        break;
      case "blackboard_2":
        level.blackboard_2_ent = var_1;
        break;
      case "blackboard_3":
        level.blackboard_3_ent = var_1;
        break;
      case "blackboard_4":
        level.blackboard_4_ent = var_1;
        break;
      case "blackboard_5":
        level.blackboard_5_ent = var_1;
        break;
      case "blackboard_6":
        level.blackboard_6_ent = var_1;
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

  foreach(var_1 in level.chem_compound_slot_array) {
    switch (var_1.name) {
      case "created_compound_name_1":
        level.chem_compound_slot_1_ent = var_1;
        break;
      case "created_compound_name_2":
        level.chem_compound_slot_2_ent = var_1;
        break;
      case "created_compound_name_3":
        level.chem_compound_slot_3_ent = var_1;
        break;
      case "created_compound_name_4":
        level.chem_compound_slot_4_ent = var_1;
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

  foreach(var_1 in level.constant_array) {
    switch (var_1.name) {
      case "chem_const_diamond_1":
        level.constant_1_ent = var_1;
        break;
      case "chem_const_diamond_2":
        level.constant_2_ent = var_1;
        break;
      case "chem_const_diamond_3":
        level.constant_3_ent = var_1;
        break;
      case "chem_const_diamond_4":
        level.constant_4_ent = var_1;
        break;
    }
  }
}

setup_diamond_constant_player_omnvars(var_0) {
  var_0 setclientomnvar("zm_ui_constant_1_ent", level.constant_1_ent);
  var_0 setclientomnvar("zm_ui_constant_2_ent", level.constant_2_ent);
  var_0 setclientomnvar("zm_ui_constant_3_ent", level.constant_3_ent);
  var_0 setclientomnvar("zm_ui_constant_4_ent", level.constant_4_ent);
}

setup_pi_constant() {
  level.pi_const = getEnt("chem_const_2", "script_noteworthy");
}

setup_eye_equation_constant() {
  level.eye_equation = getEnt("chem_const_3", "script_noteworthy");
}

setup_color_key_chart() {
  level.color_eye = getEnt("chem_const_tv_screen", "script_noteworthy");
}

setup_heat_pressure_equation_constant() {
  level.heat_pressure_eq = getEnt("chem_const_equation", "script_noteworthy");
}

setup_lab_screen() {
  level.lab_screen = getEnt("chem_const_lab_screen", "script_noteworthy");
}

init_chem_reaction_interactions() {
  init_beakers();
  init_compound_storage_objects();
  init_reaction_start_interactable_model();
  level.heat_pressure_machine_value = 0;
}

init_reaction_start_interactable_model() {
  var_0 = scripts\engine\utility::getStruct("reaction_start_model", "script_noteworthy");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_0.model = var_1;
  level.reaction_start_model = var_0;
  level.reaction_start_model thread watch_for_reaction_start_pressed(level.reaction_start_model);
  level.reaction_start_model thread update_player_monitor_reaction_start(level.reaction_start_model);
}

update_player_monitor_reaction_start(var_0) {
  level endon("game_ended");

  for(;;) {
    foreach(var_2 in level.players)
    update_reaction_button_state_for_player(var_2, var_0);

    scripts\engine\utility::waitframe();
  }
}

update_reaction_button_state_for_player(var_0, var_1) {
  if(distance2dsquared(var_1.origin, var_0.origin) > 6400) {
    scripts\engine\utility::waitframe();
    var_0 forceusehintoff();
    return;
  }

  if(!var_0 worldpointinreticle_circle(var_1.origin, 25, 80)) {
    scripts\engine\utility::waitframe();
    var_0 forceusehintoff();
    return;
  }

  level thread show_reaction_hint_for_time(2, var_0);
}

show_reaction_hint_for_time(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 notify("end_thread_instance");
  var_1 endon("end_thread_instance");
  var_1 forceusehinton(&"CP_TOWN_INTERACTIONS_START_REACTION");
  wait(var_0);
  var_1 forceusehintoff();
}

watch_for_reaction_start_pressed(var_0) {
  for(;;) {
    if(!isDefined(level.players)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    foreach(var_2 in level.players) {
      if(player_use_reaction_start_struct(var_0, var_2)) {
        reaction_activation(var_0, var_2);
        wait 0.5;
      }
    }

    wait 0.5;
  }
}

player_use_reaction_start_struct(var_0, var_1) {
  if(!isDefined(var_0.model))
    return 0;

  if(distance2dsquared(var_0.model.origin, var_1.origin) > 4900)
    return 0;

  if(!var_1 worldpointinreticle_circle(var_0.model.origin, 65, 70))
    return 0;

  if(!var_1 useButtonPressed())
    return 0;

  return 1;
}

play_failure_fx(var_0) {
  var_0 endon("disconnect");

  foreach(var_2 in level.chemical_containers)
  playFX(level._effect["fail_reaction_fx"], var_2.model.origin);

  scripts\engine\utility::waitframe();
  playfxontagforclients(level._effect["fail_reaction_screenfx"], var_0, "tag_eye", var_0);
  level.computer_model setscriptablepartstate("redlight", "on");
  level.computer_model setscriptablepartstate("yellowlight", "off");
  wait 6;
  stopfxontagforclients(level._effect["fail_reaction_screenfx"], var_0, "tag_eye", var_0);
  level.computer_model setscriptablepartstate("redlight", "off");
  level.computer_model setscriptablepartstate("yellowlight", "on");
}

play_success_fx(var_0) {
  var_0 endon("disconnect");
  playfxontagforclients(level._effect["success_reaction_screenfx"], var_0, "tag_eye", var_0);
  level.computer_model setscriptablepartstate("greenlight", "on");
  level.computer_model setscriptablepartstate("yellowlight", "off");
  wait 6;
  stopfxontagforclients(level._effect["success_reaction_screenfx"], var_0, "tag_eye", var_0);
  level.computer_model setscriptablepartstate("greenlight", "off");
  level.computer_model setscriptablepartstate("yellowlight", "on");
}

watch_for_player_interaction_with_reaction_storage(var_0) {
  for(;;) {
    if(!isDefined(level.players)) {
      wait 1;
      continue;
    } else
      break;
  }

  foreach(var_2 in level.players)
  var_2 thread watch_for_input_entered_on_reaction_storage(var_0);
}

watch_for_input_entered_on_reaction_storage(var_0) {
  self notifyonplayercommand("add_swap_compound", "+usereload");
  self notifyonplayercommand("discard_reaction", "+actionslot 4");
  var_1 = "";

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("add_swap_compound", "discard_reaction");

    if(distance2dsquared(var_0.model.origin, self.origin) > 6400) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.model.origin, 65, 80)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_1)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_1 == "add_swap_compound") {
      add_swap_compound(var_0, self);
      wait 1;
      continue;
    }

    if(var_1 == "discard_reaction") {
      discard_reaction_contents(var_0, self);
      wait 1;
    }
  }
}

discard_reaction_contents(var_0, var_1) {
  if(isDefined(var_0.compound_contained) && var_0.compound_contained != "") {
    var_0.compound_contained = "";

    if(isDefined(var_0.filled_fx))
      var_0.filled_fx delete();
  } else {}
}

add_swap_compound(var_0, var_1) {
  var_2 = get_compound_object_value(var_0);
  var_3 = get_chemical_carried_by_player(var_1);

  if(var_2 == "" && var_3 == "")
    return;
  else if(var_2 != "") {
    set_chemical_carried_by_player(var_1, var_2);

    if(var_2 == level.bomb_compound.name) {
      scripts\engine\utility::flag_set("chemistry_step3");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_mixture", "town_comment_vo");
    }

    playFX(level._effect["sb_quest_item_pickup"], var_0.model.origin);
  }
}

soundloop_bubbles() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level.chemical_compounds_created)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(level.chemical_compounds_created.size < 1) {
      scripts\engine\utility::waitframe();
      continue;
    }

    foreach(var_1 in level.chemical_compounds_created) {
      if(var_1.compound_contained != "" && !scripts\engine\utility::is_true(var_1.should_play_bubbles_sfx)) {
        if(!isDefined(var_1.soundent))
          var_1.soundent = spawn("script_origin", var_1.model.origin);

        var_1.model playSound("chemistry_final_yellow");
        var_1.should_play_bubbles_sfx = 1;
        continue;
      }

      if(isDefined(var_1.soundent))
        var_1.soundent delete();

      var_1.should_play_bubbles_sfx = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

reaction_activation(var_0, var_1) {
  var_2 = "";
  var_3 = 0;
  scripts\engine\utility::play_sound_in_space("chemistry_machine_button_press", var_0.origin);
  var_4 = level.constant_value;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  foreach(var_10, var_9 in level.chemical_containers) {
    if(var_9.chemical_contained == "") {
      continue;
    }
    switch (level.bomb_compound.choice) {
      case 1:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 8));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 9));
        break;
      case 2:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 10));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 11));
        break;
      case 3:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 12));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 13));
        break;
      case 4:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 14));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 15));
        break;
      case 5:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 16));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 17));
        break;
      case 6:
        var_5 = var_5 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 18));
        var_6 = var_6 + int(tablelookup("cp/zombies/elements.csv", 1, var_9.chemical_contained, 19));
        break;
    }

    var_7 = var_5 + var_6 - var_4;
  }

  if(level.heat_pressure_machine_value == var_7)
    setomnvar("zm_chem_number_entry_1", -1);
  else {
    scripts\engine\utility::play_sound_in_space("chemistry_reaction_failure", var_0.origin);
    var_1 thread play_failure_fx(var_1);
    var_1 thread chem_failure_debuff(var_0, var_1);
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_quest_failure", "rave_announcer_vo");
    setomnvar("zm_chem_number_entry_1", -1);
    return;
  }

  wait 0.2;
  earthquake(0.18, 3, var_0.origin, 784);
  wait 0.05;
  playrumbleonposition("artillery_rumble", var_0.origin);
  wait 2;
  var_11 = "";
  var_12 = "";
  var_13 = "";
  var_14 = "";
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  foreach(var_31, var_20 in level.compounds) {
    var_21 = var_31;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_11 = "";
    var_12 = "";
    var_13 = "";
    var_14 = "";

    if(var_20.parta != "")
      var_11 = var_20.parta;

    if(var_20.partb != "")
      var_12 = var_20.partb;

    if(var_20.partc != "")
      var_13 = var_20.partc;

    if(var_20.partd != "")
      var_14 = var_20.partd;

    if(isDefined(var_11) && var_11 != "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_11 == var_23.chemical_contained) {
          var_15 = 1;
          continue;
        }
      }
    } else if(isDefined(var_11) && var_11 == "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_23.chemical_contained != "") {
          var_15 = 0;
          continue;
        }
      }
    } else
      var_15 = 0;

    if(isDefined(var_12) && var_12 != "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_12 == var_23.chemical_contained) {
          var_16 = 1;
          continue;
        }
      }
    } else if(isDefined(var_12) && var_12 == "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_23.chemical_contained != "") {
          var_16 = 0;
          continue;
        }
      }
    } else
      var_16 = 0;

    if(isDefined(var_13) && var_13 != "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_13 == var_23.chemical_contained) {
          var_17 = 1;
          continue;
        }
      }
    } else if(isDefined(var_13) && var_13 == "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "" && (scripts\engine\utility::is_true(var_16) && scripts\engine\utility::is_true(var_15))) {
          var_17 = 1;
          continue;
        }

        if(var_23.chemical_contained != "") {
          var_17 = 0;
          continue;
        }
      }
    } else
      var_17 = 0;

    if(isDefined(var_14) && var_14 != "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "") {
          continue;
        }
        if(var_14 == var_23.chemical_contained) {
          var_18 = 1;
          continue;
        }
      }
    } else if(isDefined(var_14) && var_14 == "") {
      foreach(var_10, var_23 in level.chemical_containers) {
        if(var_23.chemical_contained == "" && (scripts\engine\utility::is_true(var_16) && scripts\engine\utility::is_true(var_15) && scripts\engine\utility::is_true(var_17))) {
          var_18 = 1;
          continue;
        }

        if(var_23.chemical_contained != "") {
          var_18 = 0;
          continue;
        }
      }
    } else
      var_18 = 0;

    if(var_15 && var_16 && var_17 && var_18) {
      var_11 = "";
      var_12 = "";
      var_13 = "";
      var_14 = "";
      var_2 = var_21;
      break;
    } else {}
  }

  if(var_2 == "") {
    var_1 thread play_failure_fx(var_1);
    scripts\engine\utility::play_sound_in_space("chemistry_reaction_failure", var_0.origin);
    var_1 thread chem_failure_debuff(var_0, var_1);
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_quest_failure", "rave_announcer_vo");
    return;
  }

  level thread play_success_fx(var_1);
  scripts\engine\utility::play_sound_in_space("chemistry_reaction_sucess", var_0.origin);

  for(var_32 = level.chemical_compounds_created.size - 1; var_32 >= 0; var_32--) {
    if(isDefined(level.chemical_compounds_created[var_32 + 1])) {
      level.chemical_compounds_created[var_32 + 1].compound_contained = level.chemical_compounds_created[var_32].compound_contained;

      if(level.chemical_compounds_created[var_32 + 1].compound_contained != "") {
        if(isDefined(level.chemical_compounds_created[var_32 + 1].filled_fx))
          level.chemical_compounds_created[var_32 + 1].filled_fx delete();

        foreach(var_31, var_34 in level.elements) {
          if(var_31 == level.chemical_compounds_created[var_32 + 1].compound_contained) {
            if(isDefined(var_34.fx_trigger)) {
              level.chemical_compounds_created[var_32 + 1].filled_fx = spawnfx(var_34.fx_trigger, level.chemical_compounds_created[var_32 + 1].model.origin);
              triggerfx(level.chemical_compounds_created[var_32 + 1].filled_fx);
            }
          }
        }

        continue;
      }

      if(isDefined(level.chemical_compounds_created[var_32 + 1].filled_fx))
        level.chemical_compounds_created[var_32 + 1].filled_fx delete();
    }
  }

  level.chemical_compounds_created[0].compound_contained = var_2;

  if(isDefined(level.chemical_compounds_created[0].filled_fx))
    level.chemical_compounds_created[0].filled_fx delete();

  foreach(var_31, var_36 in level.elements) {
    if(var_31 == level.chemical_compounds_created[0].compound_contained) {
      if(isDefined(var_36.fx_trigger)) {
        level.chemical_compounds_created[0].filled_fx = spawnfx(var_36.fx_trigger, level.chemical_compounds_created[0].model.origin);
        triggerfx(level.chemical_compounds_created[0].filled_fx);
      }
    }
  }

  if(level.chemical_compounds_created[0].compound_contained != "") {
    if(isDefined(level.chemical_compounds_created[0].filled_fx))
      triggerfx(level.chemical_compounds_created[0].filled_fx);
    else {
      level.chemical_compounds_created[0].filled_fx = spawnfx(level.chemical_compounds_created[0].fx_trigger, level.chemical_compounds_created[0].model.origin);
      triggerfx(level.chemical_compounds_created[0].filled_fx);
    }
  }

  level thread update_beaker_omnvars();

  foreach(var_38 in level.chemical_containers)
  discard_beaker_chemical(var_38, var_1);
}

update_beaker_omnvars() {
  if(level.chemical_compounds_created[0].compound_contained != "") {
    var_0 = level.chemical_compounds_created[0].compound_contained;
    var_1 = int(level.elements[var_0].omnvar);
    setomnvar("zm_chem_compound_slot_1_idx", var_1);
  } else
    setomnvar("zm_chem_compound_slot_1_idx", -1);

  if(level.chemical_compounds_created[1].compound_contained != "") {
    var_2 = level.chemical_compounds_created[1].compound_contained;
    var_3 = int(level.elements[var_2].omnvar);
    setomnvar("zm_chem_compound_slot_2_idx", var_3);
  } else
    setomnvar("zm_chem_compound_slot_2_idx", -1);

  if(level.chemical_compounds_created[2].compound_contained != "") {
    var_4 = level.chemical_compounds_created[2].compound_contained;
    var_5 = int(level.elements[var_4].omnvar);
    setomnvar("zm_chem_compound_slot_3_idx", var_5);
  } else
    setomnvar("zm_chem_compound_slot_3_idx", -1);

  if(level.chemical_compounds_created[3].compound_contained != "") {
    var_6 = level.chemical_compounds_created[3].compound_contained;
    var_7 = int(level.elements[var_6].omnvar);
    setomnvar("zm_chem_compound_slot_4_idx", var_7);
  } else
    setomnvar("zm_chem_compound_slot_4_idx", -1);
}

chem_failure_debuff(var_0, var_1) {
  var_1 dodamage(var_1.maxhealth * 0.95, var_1.origin);

  foreach(var_3 in level.chemical_containers)
  discard_beaker_chemical(var_3, var_1);
}

element_pickup_hint_func(var_0, var_1) {
  return "";
}

init_beakers() {
  level._effect["sb_quest_item_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
  var_0 = scripts\engine\utility::getStructArray("chemistry_container_model", "script_noteworthy");

  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;

    switch (var_2.name) {
      case "chem_container_01":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin");
        var_3.angles = var_2.angles;
        break;
      case "chem_container_02":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin");
        var_3.angles = var_2.angles;
        break;
      case "chem_container_03":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin");
        var_3.angles = var_2.angles;
        break;
      case "chem_container_04":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin");
        var_3.angles = var_2.angles;
        break;
      default:
    }

    var_3 hide();
    var_2.chemical_contained = "";

    if(isDefined(var_3))
      var_2.model = var_3;

    level.chemical_containers[var_4] = var_2;
  }
}

init_compound_storage_objects() {
  var_0 = scripts\engine\utility::getStructArray("compound_storage_model", "script_noteworthy");

  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;

    switch (var_2.name) {
      case "compound_storage_1":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("p7_chemistry_kit_beaker_lg");
        var_3.angles = var_2.angles;
        break;
      case "compound_storage_2":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("p7_chemistry_kit_beaker_lg");
        var_3.angles = var_2.angles;
        break;
      case "compound_storage_3":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("p7_chemistry_kit_beaker_lg");
        var_3.angles = var_2.angles;
        break;
      case "compound_storage_4":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("p7_chemistry_kit_beaker_lg");
        var_3.angles = var_2.angles;
        break;
      default:
    }

    var_3 hide();

    if(isDefined(var_3))
      var_2.model = var_3;

    var_2.compound_contained = "";
    var_2.compound_container_filled = 0;
    level.chemical_compounds_created[var_4] = var_2;
  }
}

watch_for_input_entered_on_compound(var_0) {
  self notifyonplayercommand("add_compound", "+usereload");
  self notifyonplayercommand("discard_compound", "+actionslot 4");
  var_1 = "";

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("add_compound", "discard_compound");

    if(distance2dsquared(var_0.origin, self.origin) > 8100) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.origin, 65, 90)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_1)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_1 == "add_compound") {
      add_compound_to_player(var_0, self);
      wait 1;
      continue;
    }

    if(var_1 == "discard_compound") {
      discard_compound(var_0, self);
      wait 1;
    }
  }
}

get_compound_object_value(var_0) {
  return var_0.compound_contained;
}

discard_compound(var_0, var_1) {
  if(isDefined(var_0.compound_contained) && var_0.compound_contained != "") {
    var_0.compound_contained = "";
    level thread update_beaker_omnvars();

    if(isDefined(var_0.filled_fx))
      var_0.filled_fx delete();
  } else {}
}

add_compound_to_player(var_0, var_1) {
  var_2 = get_compound_object_value(var_0);
  var_3 = get_chemical_carried_by_player(var_1);

  if(var_2 == "") {
    if(var_3 != "") {
      set_chemical_carried_by_player_after_beaker_deposit(var_1, "");
      level thread update_beaker_omnvars();
      playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
      return;
    }

    return;
  }

  set_chemical_carried_by_player(var_1, var_2);

  if(var_2 == level.bomb_compound.name) {
    scripts\engine\utility::flag_set("chemistry_step3");
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_mixture", "town_comment_vo");
  }

  playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
}

watch_for_input_entered_on_beaker(var_0) {
  self notifyonplayercommand("add_swap", "+usereload");
  self notifyonplayercommand("discard", "+actionslot 4");
  var_1 = "";

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("add_swap", "discard");

    if(distance2dsquared(var_0.origin, self.origin) > 6400) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.origin, 65, 80)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_1)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::is_true(level.crafted_chem_set)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_0.model hudoutlineenableforclient(self, 3, 1, 0);

    if(var_1 == "add_swap") {
      try_play_swap_vfx(var_0, self, 1);
      wait 1;
      var_0.model hudoutlinedisableforclient(self);
      continue;
    }

    if(var_1 == "discard") {
      discard_beaker_chemical(var_0, self);
      wait 1;
      var_0.model hudoutlinedisableforclient(self);
    }
  }
}

discard_beaker_chemical(var_0, var_1) {
  if(isDefined(var_0.chemical_contained) && var_0.chemical_contained != "") {
    if(isDefined(var_0.filled_fx))
      var_0.filled_fx delete();

    var_0.chemical_contained = "";
    var_0.model setModel("tag_origin");
  } else {}

  display_elements_in_beakers(var_0, -1, var_1);
}

get_chemistry_object_value(var_0, var_1) {
  if(scripts\engine\utility::is_true(var_1))
    return var_0.chemical_contained;
  else
    return var_0.chemical_object_name;
}

try_play_swap_vfx(var_0, var_1, var_2) {
  var_3 = get_chemistry_object_value(var_0, var_2);
  var_4 = get_chemical_carried_by_player(var_1);

  if(var_4 == "" && !scripts\engine\utility::is_true(var_2)) {
    playFX(level._effect["sb_quest_item_pickup"], var_0.chemical_model_object.origin);
    set_chemical_carried_by_player(var_1, var_3);
  } else if(var_4 == "" && scripts\engine\utility::is_true(var_2)) {
    if(var_3 == "") {
      var_1 playlocalsound("perk_machine_deny");
      return;
    } else {
      set_chemical_carried_by_player(var_1, var_3);
      discard_beaker_chemical(var_0, var_1);
    }

    return;
  } else if(scripts\engine\utility::is_true(var_2)) {
    playsoundatpos(var_0.model.origin, "chemistry_placement");

    if(var_3 == "") {
      foreach(var_7, var_6 in level.elements) {
        if(var_4 == var_7) {
          if(var_6.type == "componant" || var_6.type == "final") {
            if(isDefined(var_6.fx_trigger)) {
              var_0.filled_fx = spawnfx(var_6.fx_trigger, var_0.model.origin);
              triggerfx(var_0.filled_fx);
            }
          }

          var_0.model setModel(var_6.model);
        }
      }
    } else {
      foreach(var_7, var_9 in level.elements) {
        if(var_4 == var_7) {
          var_0.model setModel(var_9.model);

          if(var_9.type == "componant" || var_9.type == "final") {
            if(isDefined(var_0.filled_fx))
              var_0.filled_fx delete();

            if(isDefined(var_9.fx_trigger)) {
              var_0.filled_fx = spawnfx(var_9.fx_trigger, var_0.model.origin);
              triggerfx(var_0.filled_fx);
            }

            continue;
          }

          foreach(var_11 in level.chemical_containers) {
            foreach(var_14, var_13 in level.elements) {
              if(var_4 == var_14) {
                if(var_13.type != "componant" || var_13.type != "final") {
                  if(isDefined(var_11.filled_fx))
                    var_11.filled_fx delete();
                }
              }
            }
          }
        }
      }
    }

    var_16 = var_3;
    playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
    add_chemical_to_beaker(var_1, var_0);
    set_chemical_carried_by_player_after_beaker_deposit(var_1, var_16);
    display_elements_in_beakers(var_0, var_4, var_1);
  } else {
    set_chemical_carried_by_player(var_1, var_3);
    playFX(level._effect["sb_quest_item_pickup"], var_0.chemical_model_object.origin);
  }
}

add_chemical_to_beaker(var_0, var_1) {
  var_2 = get_chemistry_object_value(var_1, 1);
  var_3 = get_chemical_carried_by_player(var_0);

  if(var_2 != "") {}

  set_chemical_in_beaker(var_1, var_3, var_0);
  display_elements_in_beakers(var_1, var_3, var_0);
}

display_elements_in_beakers(var_0, var_1, var_2) {
  var_3 = tablelookup("cp/zombies/elements.csv", 1, var_1, 0);
  var_4 = "chem_container_01";

  switch (var_0.name) {
    case "chem_container_01":
      var_4 = "zm_lab_screen_beaker1";
      break;
    case "chem_container_02":
      var_4 = "zm_lab_screen_beaker2";
      break;
    case "chem_container_03":
      var_4 = "zm_lab_screen_beaker3";
      break;
    case "chem_container_04":
      var_4 = "zm_lab_screen_beaker4";
      break;
  }

  if(isDefined(var_3))
    setomnvar(var_4, int(var_3));
}

set_chemical_in_beaker(var_0, var_1, var_2) {
  if(!isDefined(var_0.chemical_contained)) {
    var_2 playlocalsound("perk_machine_deny");
    return;
  }

  var_3 = var_0.chemical_contained;
  var_0.chemical_contained = var_1;
}

swap_chemistry_object_with_player_chemical(var_0, var_1, var_2) {
  var_3 = get_chemistry_object_value(var_0);
  var_4 = get_chemical_carried_by_player(var_1);
  set_chemical_carried_by_player(var_1, var_3);
}

get_chemical_carried_by_player(var_0) {
  if(!isDefined(var_0.chemical_base_picked))
    var_0.chemical_base_picked = "";

  return var_0.chemical_base_picked;
}

set_chemical_carried_by_player(var_0, var_1) {
  var_0.chemical_base_picked = var_1;
  var_2 = int(level.elements[var_1].omnvar);
  var_0 setclientomnvar("zm_chem_element_index", var_2);
}

set_chemical_carried_by_player_after_beaker_deposit(var_0, var_1) {
  var_2 = int(level.elements[var_0.chemical_base_picked].omnvar);
  var_0 setclientomnvar("zm_chem_element_index", var_2);
  var_0.chemical_base_picked = var_1;

  if(isDefined(level.elements[var_0.chemical_base_picked])) {
    var_3 = int(level.elements[var_0.chemical_base_picked].omnvar);
    var_0 setclientomnvar("zm_chem_element_index", var_3);
  } else
    var_0 setclientomnvar("zm_chem_element_index", 0);
}

init_setup_radio_prefabs() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "chem_radio_interaction", undefined, undefined, ::radios_interaction_hint_func, ::radios_activation_function, 0, 0, ::init_chem_radios, undefined);
}

radios_interaction_hint_func(var_0, var_1) {
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
  var_0 = scripts\engine\utility::getStructArray("chem_radio_interaction", "script_noteworthy");

  foreach(var_4, var_2 in var_0) {
    var_2.radio = spawn("script_origin", var_2.origin);
    var_3 = undefined;

    if(isDefined(var_3))
      var_2.model = var_3;
  }

  setup_radio_vo_from_elements();
}

radios_activation_function(var_0, var_1) {
  var_2 = var_0.radio;
  var_3 = undefined;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);

  switch (var_0.name) {
    case "chem_radio_1":
      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_1_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_1_sounds, 0, 0);
        level.chem_radio_1_sounds = scripts\engine\utility::array_insert(level.chem_radio_1_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_1_current))
        level.chem_radio_1_current = 0;

      var_3 = level.chem_radio_1_sounds[level.chem_radio_1_current];
      var_2 playSound(var_3);
      level.chem_radio_1_current = level.chem_radio_1_current + 1;

      if(level.chem_radio_1_current == level.chem_radio_1_sounds.size)
        level.chem_radio_1_current = 0;

      break;
    case "chem_radio_2":
      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_2_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_2_sounds, 0, 0);
        level.chem_radio_2_sounds = scripts\engine\utility::array_insert(level.chem_radio_2_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_2_current))
        level.chem_radio_2_current = 0;

      var_3 = level.chem_radio_2_sounds[level.chem_radio_2_current];
      var_2 playSound(var_3);
      level.chem_radio_2_current = level.chem_radio_2_current + 1;

      if(level.chem_radio_2_current == level.chem_radio_2_sounds.size)
        level.chem_radio_2_current = 0;

      break;
    case "chem_radio_3":
      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_3_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_3_sounds, 0, 0);
        level.chem_radio_3_sounds = scripts\engine\utility::array_insert(level.chem_radio_3_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_3_current))
        level.chem_radio_3_current = 0;

      var_3 = level.chem_radio_3_sounds[level.chem_radio_3_current];
      var_2 playSound(var_3);
      level.chem_radio_3_current = level.chem_radio_3_current + 1;

      if(level.chem_radio_3_current == level.chem_radio_3_sounds.size)
        level.chem_radio_3_current = 0;

      break;
    case "chem_radio_4":
      if(!isDefined(level.element_intro_played)) {
        level.chem_radio_4_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_4_sounds, 0, 0);
        level.chem_radio_4_sounds = scripts\engine\utility::array_insert(level.chem_radio_4_sounds, "db_intro_1", 0);
        level.element_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_4_current))
        level.chem_radio_4_current = 0;

      var_3 = level.chem_radio_4_sounds[level.chem_radio_4_current];
      var_2 playSound(var_3);
      level.chem_radio_4_current = level.chem_radio_4_current + 1;

      if(level.chem_radio_4_current == level.chem_radio_4_sounds.size)
        level.chem_radio_4_current = 0;

      break;
    case "chem_radio_5":
      if(!isDefined(level.compound_intro_played)) {
        level.chem_radio_5_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_5_sounds, 0, 0);
        level.chem_radio_5_sounds = scripts\engine\utility::array_insert(level.chem_radio_5_sounds, "db_intro_3", 0);
        level.compound_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_5_current))
        level.chem_radio_5_current = 0;

      var_3 = level.chem_radio_5_sounds[level.chem_radio_5_current];
      var_2 playSound(var_3);
      level.chem_radio_5_current = level.chem_radio_5_current + 1;

      if(level.chem_radio_5_current == level.chem_radio_5_sounds.size)
        level.chem_radio_5_current = 0;

      break;
    case "chem_radio_6":
      if(!isDefined(level.compound_intro_played)) {
        level.chem_radio_6_sounds = scripts\cp\utility::array_remove_index(level.chem_radio_6_sounds, 0, 0);
        level.chem_radio_6_sounds = scripts\engine\utility::array_insert(level.chem_radio_6_sounds, "db_intro_3", 0);
        level.compound_intro_played = 1;
      }

      if(!isDefined(level.chem_radio_6_current))
        level.chem_radio_6_current = 0;

      var_3 = level.chem_radio_6_sounds[level.chem_radio_6_current];
      var_2 playSound(var_3);
      level.chem_radio_6_current = level.chem_radio_6_current + 1;

      if(level.chem_radio_6_current == level.chem_radio_6_sounds.size)
        level.chem_radio_6_current = 0;

      break;
    case "chem_radio_7":
      if(!isDefined(level.chem_radio_7_current))
        level.chem_radio_7_current = 0;

      if(scripts\engine\utility::is_true(level.radio_flip)) {
        var_3 = level.bomb_compound.radio2[level.chem_radio_7_current]._id_10475;
        var_2 playSound(var_3);
        level.chem_radio_7_current = level.chem_radio_7_current + 1;

        if(level.chem_radio_7_current == level.bomb_compound.radio2.size)
          level.chem_radio_7_current = 0;
      } else {
        var_3 = level.bomb_compound.radio1[level.chem_radio_7_current]._id_10475;
        var_2 playSound(var_3);
        level.chem_radio_7_current = level.chem_radio_7_current + 1;

        if(level.chem_radio_7_current == level.bomb_compound.radio1.size)
          level.chem_radio_7_current = 0;
      }

      break;
    case "chem_radio_8":
      if(!isDefined(level.chem_radio_8_current))
        level.chem_radio_8_current = 0;

      if(scripts\engine\utility::is_true(level.radio_flip)) {
        var_3 = level.bomb_compound.radio1[level.chem_radio_8_current]._id_10475;
        var_2 playSound(var_3);
        level.chem_radio_8_current = level.chem_radio_8_current + 1;

        if(level.chem_radio_8_current == level.bomb_compound.radio1.size)
          level.chem_radio_8_current = 0;
      } else {
        var_3 = level.bomb_compound.radio2[level.chem_radio_8_current]._id_10475;
        var_2 playSound(var_3);
        level.chem_radio_8_current = level.chem_radio_8_current + 1;

        if(level.chem_radio_8_current == level.bomb_compound.radio2.size)
          level.chem_radio_8_current = 0;
      }

      break;
  }

  var_4 = lookupsoundlength(var_3) / 1000;
  wait(var_4);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

setup_final_compound() {
  level.bomb_compound = spawnStruct();
  level.bomb_name_array = [];
  var_0 = randomintrange(0, level.final_compounds.size - 1);
  determine_proper_color();
  level.bomb_compound.name = level.final_compounds[var_0];

  if(!isDefined(level.bomb_compound.name)) {}

  select_heat_pressure_choice_values();
  select_constant_value();
}

determine_proper_color() {
  var_0 = randomintrange(1, 4);

  if(var_0 == 1)
    level.bomb_compound.color = "red";
  else if(var_0 == 2)
    level.bomb_compound.color = "green";
  else
    level.bomb_compound.color = "blue";

  setomnvar("zm_chem_correct_color", var_0);
}

select_heat_pressure_choice_values() {
  var_0 = randomintrange(1, 7);
  level.bomb_compound.choice = var_0;
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
  wait 5;
  setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_default);
}

select_constant_value() {
  var_0 = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("cp/zombies/diapi_table.csv", var_1, 1);

    if(var_2 == "") {
      break;
    }

    var_0[var_1] = int(var_2);
    var_1++;
  }

  var_3 = randomintrange(0, var_0.size);
  level.constant_value = var_0[var_3];
  var_4 = randomintrange(0, var_0.size);

  for(;;) {
    if(var_4 == var_3) {
      var_4 = randomintrange(0, var_0.size);
      continue;
    }

    break;
  }

  var_5 = randomintrange(0, var_0.size);

  for(;;) {
    if(var_5 == var_3 || var_5 == var_4) {
      var_5 = randomintrange(0, var_0.size);
      continue;
    }

    break;
  }

  var_6 = randomintrange(0, var_0.size);

  for(;;) {
    if(var_6 == var_3 || var_6 == var_4 || var_6 == var_5) {
      var_6 = randomintrange(0, var_0.size);
      continue;
    }

    break;
  }

  level.constant_bad_value_1 = var_0[var_4];
  level.constant_bad_value_2 = var_0[var_5];
  level.constant_bad_value_3 = var_0[var_6];
  choose_constant_locations();
}

choose_constant_locations() {
  level.correct_constant_loc = randomintrange(1, 5);
  var_0 = randomintrange(1, 5);

  for(;;) {
    if(var_0 == level.correct_constant_loc) {
      var_0 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  var_1 = randomintrange(1, 5);

  for(;;) {
    if(var_1 == level.correct_constant_loc || var_1 == var_0) {
      var_1 = randomintrange(1, 5);
      continue;
    }

    break;
  }

  var_2 = randomintrange(1, 5);

  for(;;) {
    if(var_2 == level.correct_constant_loc || var_2 == var_0 || var_2 == var_1) {
      var_2 = randomintrange(1, 5);
      continue;
    }

    break;
  }

  level.bad_constants_loc1 = spawnStruct();
  level.bad_constants_loc1.value = var_0;
  level.bad_constants_loc2 = spawnStruct();
  level.bad_constants_loc2.value = var_1;
  level.bad_constants_loc3 = spawnStruct();
  level.bad_constants_loc3.value = var_2;
  set_constant_omnvars(level.correct_constant_loc, level.constant_value);
  set_constant_omnvars(var_0, level.constant_bad_value_1);
  set_constant_omnvars(var_1, level.constant_bad_value_2);
  set_constant_omnvars(var_2, level.constant_bad_value_3);
  set_bad_loc_colors();

  if(level.bad_constants_loc1.value == 1)
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_1";
  else if(level.bad_constants_loc1.value == 2)
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_2";
  else if(level.bad_constants_loc1.value == 3)
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_3";
  else if(level.bad_constants_loc1.value == 4)
    level.bad_constants_loc1.omnvar = "zm_chem_const_bad_loc_4";

  if(level.bad_constants_loc2.value == 1)
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_1";
  else if(level.bad_constants_loc2.value == 2)
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_2";
  else if(level.bad_constants_loc2.value == 3)
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_3";
  else if(level.bad_constants_loc2.value == 4)
    level.bad_constants_loc2.omnvar = "zm_chem_const_bad_loc_4";

  if(level.bad_constants_loc3.value == 1)
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_1";
  else if(level.bad_constants_loc3.value == 2)
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_2";
  else if(level.bad_constants_loc3.value == 3)
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_3";
  else if(level.bad_constants_loc3.value == 4)
    level.bad_constants_loc3.omnvar = "zm_chem_const_bad_loc_4";

  select_pi_value();
}

set_constant_omnvars(var_0, var_1) {
  switch (var_0) {
    case 1:
      setomnvar("zm_chem_const_loc_1", var_1);
      break;
    case 2:
      setomnvar("zm_chem_const_loc_2", var_1);
      break;
    case 3:
      setomnvar("zm_chem_const_loc_3", var_1);
      break;
    case 4:
      setomnvar("zm_chem_const_loc_4", var_1);
      break;
  }
}

set_bad_loc_colors() {
  var_0 = randomintrange(1, 4);

  if(var_0 == 1)
    level.bad_constants_loc1.color = "red";
  else if(var_0 == 2)
    level.bad_constants_loc1.color = "green";
  else
    level.bad_constants_loc1.color = "blue";

  var_1 = randomintrange(1, 4);

  for(;;) {
    if(var_1 == var_0) {
      var_1 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  if(var_1 == 1)
    level.bad_constants_loc2.color = "red";
  else if(var_1 == 2)
    level.bad_constants_loc2.color = "green";
  else
    level.bad_constants_loc2.color = "blue";

  var_2 = randomintrange(1, 4);

  for(;;) {
    if(var_2 == var_0 || var_2 == var_1) {
      var_2 = randomintrange(1, 4);
      continue;
    }

    break;
  }

  if(var_2 == 1)
    level.bad_constants_loc3.color = "red";
  else if(var_2 == 2)
    level.bad_constants_loc3.color = "green";
  else
    level.bad_constants_loc3.color = "blue";
}

set_not_equal_constant(var_0) {
  if(level.bad_constants_loc1.color == var_0) {
    setomnvar(level.bad_constants_loc1.omnvar, 1);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
  } else if(level.bad_constants_loc2.color == var_0) {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 1);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
  } else if(level.bad_constants_loc3.color == var_0) {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 1);
  } else if(level.bad_constants_loc3.color == "full") {
    setomnvar(level.bad_constants_loc1.omnvar, 0);
    setomnvar(level.bad_constants_loc2.omnvar, 0);
    setomnvar(level.bad_constants_loc3.omnvar, 0);
  }
}

select_pi_value() {
  var_0 = randomintrange(2, 8);
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("cp/zombies/diapi_table.csv", var_1, 1);

    if(var_2 == "") {
      break;
    }

    if(int(var_2) == level.constant_value) {
      level.constant_pi_value = int(tablelookupbyrow("cp/zombies/diapi_table.csv", var_1, var_0));
      break;
    }

    var_1++;
  }

  setomnvar("zm_chem_pi_constant", level.constant_pi_value);
  setup_color_key();
}

setup_color_key() {
  level.color_key_value = int(level.constant_pi_value * level.constant_value);
  setomnvar("zm_chem_color_key_value", level.color_key_value);
  var_0 = randomintrange(1, 5);
  setomnvar("zm_chem_color_key_rnd", var_0);
  var_1 = randomintrange(1, 4);
  setomnvar("zm_chem_color_key_slot", var_1);
}

build_vo_clues_from_final_compound() {}

parse_compound_vo_table() {
  level.bomb_compound.radio1 = [];
  level.bomb_compound.radio2 = [];
  var_0 = randomintrange(1, 3);

  if(var_0 == 2)
    level.radio_flip = 1;

  if(isDefined(level.final_compound_vo_table))
    var_1 = level.final_compound_vo_table;
  else
    var_1 = "cp/zombies/chem_vo.csv";

  level.intro_chem_vo = [];
  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(var_1, var_2, 0);

    if(var_3 == "") {
      break;
    }

    if(var_3 == level.bomb_compound.name) {
      var_3 = tablelookupbyrow(var_1, var_2, 0);
      var_4 = tablelookupbyrow(var_1, var_2, 1);
      var_5 = tablelookupbyrow(var_1, var_2, 3);
      var_6 = tablelookupbyrow(var_1, var_2, 2);
      register_compound_vo(var_3, var_4, var_5, var_6);
    } else if(var_3 == "intro") {
      var_3 = tablelookupbyrow(var_1, var_2, 0);
      var_4 = tablelookupbyrow(var_1, var_2, 1);
      var_5 = tablelookupbyrow(var_1, var_2, 3);
      var_6 = tablelookupbyrow(var_1, var_2, 2);
      register_intro_chem_vo(var_3, var_4, var_5, var_6);
    }

    var_2++;
  }
}

register_compound_vo(var_0, var_1, var_2, var_3) {
  if(var_1 == "7") {
    var_4 = level.bomb_compound.radio1.size;
    level.bomb_compound.radio1[var_4] = spawnStruct();
    level.bomb_compound.radio1[var_4]._id_10475 = var_2;
    level.bomb_compound.radio1[var_4].radio = var_1;
    level.bomb_compound.radio1[var_4].tempstring = var_3;
  } else if(var_1 == "8") {
    var_4 = level.bomb_compound.radio2.size;
    level.bomb_compound.radio2[var_4] = spawnStruct();
    level.bomb_compound.radio2[var_4]._id_10475 = var_2;
    level.bomb_compound.radio2[var_4].radio = var_1;
    level.bomb_compound.radio2[var_4].tempstring = var_3;
  }
}

register_intro_chem_vo(var_0, var_1, var_2, var_3) {
  var_4 = level.intro_chem_vo.size;
  level.intro_chem_vo[var_4] = spawnStruct();
  level.intro_chem_vo[var_4]._id_10475 = var_2;
  level.intro_chem_vo[var_4].order = var_1;
  level.intro_chem_vo[var_4].tempstring = var_3;
}