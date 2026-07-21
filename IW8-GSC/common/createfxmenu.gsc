/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\createfxmenu.gsc
***********************************************/

init_menu() {
  level._createfx.options = [];
  addoption("_encstr_A1D80717112333A5D4", "_encstr_95780526F31FA7", "_encstr_990106D508206815", "_encstr_BA19049E7739", "_encstr_840703F23B");
  addoption("_encstr_8AA9066663F62C3A", "_encstr_96750613A808E91B", "_encstr_B83A184B280B6D1AF907827E15F3B623D360B35B9A21A5122B43", 0.5, "_encstr_840703F23B");
  addoption("_encstr_A1D80717112333A5D4", "_encstr_8F7905C4EDE23F", "_encstr_8F7905D4EDE23F", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");

  if(!level.mp_createfx) {
    addoption("_encstr_A1D80717112333A5D4", "_encstr_BAD107D5718A383CEB", "_encstr_A7680AC8CD1910C8B002A519", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_8AA9066663F62C3A", "_encstr_A6450CCCD29CACCCC391B2B1C2CB", "_encstr_AFD8162373460191B0809691014EB283952CA30293161DAC", 0.5, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_8AA9066663F62C3A", "_encstr_A6800EF597DBFA2F2BB363F065450B98", "_encstr_8C1F0FCA70814E165E5AB3CF18D1E7C349", 5, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_A1D80717112333A5D4", "_encstr_B2500CF0E3F86547115B3A4F2D8F", "_encstr_B6AD128CCD3240328510CDBD5D73195863D20BB9", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_8AA9066663F62C3A", "_encstr_B2BE0788BAF573592F", "_encstr_A5300EE1C809E46FDBBFCCC121A11F2F", 150, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_8AA9066663F62C3A", "_encstr_A36A0EBC6778571703399BA28873CB47", "_encstr_9B9E18D35BA502E51081A5EF69F0390A8BDBEF92C95F0AA98831", 250, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_AD9B0589EDBDC6", "_encstr_979208AB0EC32060E3DB", "_encstr_AC8A178B2076FB9B1A40153842C36871A5BC37B38E4180A988", 0, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_AD9B0589EDBDC6", "_encstr_B49409B1CAEB0E38F64DC7", "_encstr_86FA103D8D361BABCD4B7BB91015E40B3656", 1, "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_A1D80717112333A5D4", "_encstr_97F90B95B04EA343E2ABC25B95", "_encstr_97F90B15B04EA343E2ABC25B95", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_A1D80717112333A5D4", "_encstr_82BE06497D8CC0D6", "_encstr_9BE21FE953735184609D2DBBF144990A01FFF39987606FD88847F932B84FBA3E89", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
  }

  addoption("_encstr_8AA9066663F62C3A", "_encstr_AB9A0AC80DCBE9A137FDD988", "_encstr_A19E1FDD3B4D02F5B0C87F07BA4BB90A23E79E4F1DD71A05B88A6B2F50416963A7", 1, "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1");
  addoption("_encstr_8AA9066663F62C3A", "_encstr_A59A0AB1672C48FBB9E79B91", "_encstr_A6271DA6B0F0D26BD5AD108ED2B6CA0231CAA3BB9556E60827560EAC16D1DC", 2, "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1");
  addoption("_encstr_921904C3DEF8", "_encstr_826407935938AC161D", "_encstr_A1C31A275D9F61FBAA3E38785643BBD817E38F95AF52AB33127230F0", 5, "_encstr_A63B09CA3CE01B7B8C2B27");
  addoption("_encstr_A1D80717112333A5D4", "_encstr_A63B09CA3CE01B7B8C2B27", "_encstr_A63B098A3CE01B7B8C2B27", "_encstr_A34C02BB", "_encstr_A63B09CA3CE01B7B8C2B27");
  addoption("_encstr_A1D80717112333A5D4", "_encstr_8D760BA3EF33C54D42B1B4A19B", "_encstr_8D760B83EF33C54D42B1B4A19B", "_encstr_BA19049E7739", "_encstr_AF1904A7F929");
  addoption("_encstr_A1D80717112333A5D4", "_encstr_A7DC0A731F08BBCBC8033D87", "_encstr_A7DC0AF31F08BBCBC8033D87", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
  addoption("_encstr_921904C3DEF8", "_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37", "_encstr_A1A0101A3D53A2ECB0103F3229E9B44A034E", 100, "_encstr_82510C0E3347CF308B935DA7A8D8", ::input_reactive_radius);

  if(!level.mp_createfx) {
    addoption("_encstr_A1D80717112333A5D4", "_encstr_816E079685517D0975", "_encstr_816E078685517D0975", "_encstr_BA19049E7739", "_encstr_A63B09CA3CE01B7B8C2B27");
    addoption("_encstr_921904C3DEF8", "_encstr_9B89096E1DDBE016981BAC", "_encstr_B19F1BD0C2DC0813CA80CD1DBD830795320133C9DB5B10CD6C9C961CA3", "_encstr_A34C02BB", "_encstr_AF1904A7F929");
  }

  level.effect_list_offset = 0;
  level.effect_list_offset_max = 10;

  if(level.mp_createfx)
    level.effect_list_offset_max = 6;

  level.createfxmasks = [];
  level.createfxmasks["_encstr_AF1904A7F929"] = [];
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_A63B09CA3CE01B7B8C2B27"] = 1;
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_B6480A92880DD02267293B7B"] = 1;
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_BE7F073BF060E0F269"] = 1;
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_A35408BE67DFC0D98F9B"] = 1;
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"] = 1;
  level.createfxmasks["_encstr_AF1904A7F929"]["_encstr_82510C0E3347CF308B935DA7A8D8"] = 1;
  level.createfxmasks["_encstr_840703F23B"] = [];
  level.createfxmasks["_encstr_840703F23B"]["_encstr_A63B09CA3CE01B7B8C2B27"] = 1;
  level.createfxmasks["_encstr_840703F23B"]["_encstr_B6480A92880DD02267293B7B"] = 1;
  level.createfxmasks["_encstr_840703F23B"]["_encstr_BE7F073BF060E0F269"] = 1;

  if(!level.mp_createfx)
    level.createfxmasks["_encstr_840703F23B"]["_encstr_82510C0E3347CF308B935DA7A8D8"] = 1;

  level.createfxmasks["_encstr_A63B09CA3CE01B7B8C2B27"] = [];
  level.createfxmasks["_encstr_A63B09CA3CE01B7B8C2B27"]["_encstr_A63B09CA3CE01B7B8C2B27"] = 1;
  level.createfxmasks["_encstr_BE7F073BF060E0F269"] = [];
  level.createfxmasks["_encstr_BE7F073BF060E0F269"]["_encstr_BE7F073BF060E0F269"] = 1;
  level.createfxmasks["_encstr_B6480A92880DD02267293B7B"] = [];
  level.createfxmasks["_encstr_B6480A92880DD02267293B7B"]["_encstr_B6480A92880DD02267293B7B"] = 1;
  level.createfxmasks["_encstr_A35408BE67DFC0D98F9B"] = [];
  level.createfxmasks["_encstr_A35408BE67DFC0D98F9B"]["_encstr_8D760BA3EF33C54D42B1B4A19B"] = 1;
  level.createfxmasks["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"] = [];
  level.createfxmasks["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"]["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"] = 1;
  level.createfxmasks["_encstr_82510C0E3347CF308B935DA7A8D8"] = [];
  level.createfxmasks["_encstr_82510C0E3347CF308B935DA7A8D8"]["_encstr_82510C0E3347CF308B935DA7A8D8"] = 1;
  var_0 = [];
  var_0["_encstr_975A097AC54301413F1808"] = ::menu_create_select;
  var_0["_encstr_92860FBAC33D178BB01FC7DE7358D467DD"] = ::menu_create;
  var_0["_encstr_88B60EB19CAC2C47AC7D1BEDF60ECC87"] = ::menu_create;
  var_0["_encstr_91990C2F80BE906C4F2101CA2A23"] = ::menu_create;
  var_0["_encstr_8BBA05185F8B99"] = ::menu_none;
  var_0["_encstr_B10D0C16198CBE7B383A4BEDB99B"] = ::menu_add_options;
  var_0["_encstr_86030F37D0706532E1A08E4088ED2A25F9"] = ::menu_select_by_name;
  level._createfx.menus = var_0;
}

menu(var_0) {
  return level.create_fx_menu == var_0;
}

setmenu(var_0) {
  level.create_fx_menu = var_0;
}

create_fx_menu() {
  if(scripts\common\createfx::button_is_clicked("_encstr_B84407FD927A8B4B25", "_encstr_814C02A2")) {
    exit_menu();
    return;
  }

  if(isDefined(level._createfx.menus[level.create_fx_menu]))
    [[level._createfx.menus[level.create_fx_menu]]]();
}

menu_create_select() {
  if(!isDefined(level._createfx.menu_create_select)) {
    level._createfx.menu_create_select = [];
    var_0 = [];
    var_0["_encstr_A34C02BB"] = ::buttonpress_create_oneshot;

    if(!level.mp_createfx) {
      var_0["_encstr_A74C0222"] = ::buttonpress_create_loopfx;
      var_0["_encstr_A14C023B"] = ::buttonpress_create_loopsound;
      var_0["_encstr_AC4C024A"] = ::buttonpress_create_exploder;
      var_0["_encstr_B84C027E"] = ::buttonpress_create_interval_sound;
      var_0["_encstr_8F4C026A"] = ::buttonpress_create_reactiveent;
    } else {
      var_0["_encstr_A74C0222"] = ::buttonpress_create_loopsound;
      var_0["_encstr_A14C023B"] = ::buttonpress_create_exploder;
      var_0["_encstr_AC4C024A"] = ::buttonpress_create_interval_sound;
      var_0["_encstr_B84C027E"] = ::buttonpress_create_reactiveent;
    }

    level._createfx.menu_create_select = var_0;
  }

  foreach(var_3, var_2 in level._createfx.menu_create_select) {
    if(scripts\common\createfx::button_is_clicked(var_3)) {
      [[var_2]]();
      return;
    }
  }
}

buttonpress_create_oneshot() {
  setmenu("_encstr_92860FBAC33D178BB01FC7DE7358D467DD");
  draw_effects_list();
}

buttonpress_create_loopfx() {
  setmenu("_encstr_88B60EB19CAC2C47AC7D1BEDF60ECC87");
  draw_effects_list();
}

buttonpress_create_loopsound() {
  setmenu("_encstr_A9A1116C93ACB0D1CABE36DEB71CB97B57CD32");
  var_0 = scripts\common\createfx::createloopsound();
  finish_creating_entity(var_0);
}

buttonpress_create_exploder() {
  setmenu("_encstr_A99910D61AFF41992F89A8489385773957A2");
  var_0 = scripts\common\createfx::createnewexploder();
  finish_creating_entity(var_0);
}

buttonpress_create_interval_sound() {
  setmenu("_encstr_8E601677108FB7659F21DF08E335538D8BE4A7EE65988D25");
  var_0 = scripts\common\createfx::createintervalsound();
  finish_creating_entity(var_0);
}

buttonpress_create_reactiveent() {
  var_0 = scripts\common\createfx::createreactiveent();
  finish_creating_entity(var_0);
}

menu_create() {
  if(next_button()) {
    increment_list_offset();
    draw_effects_list();
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list();
  }

  menu_fx_creation();
}

menu_none() {
  if(scripts\common\createfx::button_is_clicked("_encstr_864C0253"))
    increment_list_offset();

  menu_change_selected_fx();

  if(entities_are_selected()) {
    var_0 = get_last_selected_ent();

    if(!isDefined(level.last_displayed_ent) || var_0 != level.last_displayed_ent) {
      display_fx_info(var_0);
      level.last_displayed_ent = var_0;
    }

    if(scripts\common\createfx::button_is_clicked("_encstr_994C023A")) {
      scripts\common\createfx::clear_settable_fx();
      setmenu("_encstr_B10D0C16198CBE7B383A4BEDB99B");
      return;
    }
  } else
    level.last_displayed_ent = undefined;
}

menu_add_options() {
  if(!entities_are_selected()) {
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("_encstr_8BBA05185F8B99");
    return;
  }

  display_fx_add_options(get_last_selected_ent());

  if(next_button())
    increment_list_offset();
}

menu_select_by_name() {
  if(next_button()) {
    increment_list_offset();
    draw_effects_list("_encstr_B1A70F9A2B8D56B1D10898F20173B0B595");
  } else if(previous_button()) {
    decrement_list_offset();
    draw_effects_list("_encstr_B1A70F9A2B8D56B1D10898F20173B0B595");
  }

  select_by_name();
}

next_button() {
  return scripts\common\createfx::button_is_clicked("_encstr_A63C0B736427437D5A9BBDBFB7");
}

previous_button() {
  return scripts\common\createfx::button_is_clicked("_encstr_A95C0A1BB2CC8EC22793DBDD");
}

exit_menu() {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::update_selected_entities();
  setmenu("_encstr_8BBA05185F8B99");
}

menu_fx_creation() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = scripts\common\createfx::func_get_level_fx();

  for(var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(scripts\common\createfx::button_is_clicked(var_4 + "_encstr_B40101")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(menu("_encstr_91990C2F80BE906C4F2101CA2A23")) {
    apply_option_to_selected_fx(get_option("_encstr_95780526F31FA7"), var_1);
    level.effect_list_offset = 0;
    scripts\common\createfx::clear_fx_hudelements();
    setmenu("_encstr_8BBA05185F8B99");
    return;
  }

  var_5 = undefined;

  if(menu("_encstr_88B60EB19CAC2C47AC7D1BEDF60ECC87"))
    var_5 = scripts\engine\utility::createloopeffect(var_1);

  if(menu("_encstr_92860FBAC33D178BB01FC7DE7358D467DD"))
    var_5 = scripts\engine\utility::createoneshoteffect(var_1);

  finish_creating_entity(var_5);
}

finish_creating_entity(var_0) {
  var_0.v["_encstr_A7610758E6CED8569B"] = vectortoangles(var_0.v["_encstr_97FE07DE392D76D2CD"] + (0, 0, 100) - var_0.v["_encstr_97FE07DE392D76D2CD"]);

  if(isDefined(level._effect) && isDefined(level._effect[var_0.v["_encstr_95780526F31FA7"]]) && isvfxfile(level._effect[var_0.v["_encstr_95780526F31FA7"]]))
    var_0.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);

  var_0 scripts\common\createfx::post_entity_creation_function();
  scripts\common\createfx::clear_entity_selection();
  scripts\common\createfx::select_last_entity();
  scripts\common\createfx::move_selection_to_cursor();
  scripts\common\createfx::update_selected_entities();
  setmenu("_encstr_8BBA05185F8B99");
}

entities_are_selected() {
  return level._createfx.selected_fx_ents.size > 0;
}

menu_change_selected_fx() {
  if(!level._createfx.selected_fx_ents.size) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = get_last_selected_ent();

  for(var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];

    if(!isDefined(var_2.v[var_4["_encstr_84BA05A8CA852B"]])) {
      continue;
    }
    var_0++;

    if(var_0 < level.effect_list_offset) {
      continue;
    }
    var_1++;
    var_5 = var_1;

    if(var_5 == 10)
      var_5 = 0;

    if(scripts\common\createfx::button_is_clicked(var_5 + "_encstr_B40101")) {
      prepare_option_for_change(var_4, var_1);
      break;
    }

    if(var_1 > level.effect_list_offset_max) {
      var_6 = 1;
      break;
    }
  }
}

prepare_option_for_change(var_0, var_1) {
  if(var_0["_encstr_84BA05A8CA852B"] == "_encstr_95780526F31FA7") {
    setmenu("_encstr_91990C2F80BE906C4F2101CA2A23");
    draw_effects_list();
    return;
  }

  level.createfx_inputlocked = 1;
  level._createfx.hudelems[var_1 + 3][0].color = (1, 1, 0);

  if(isDefined(var_0["_encstr_B2790B3218137D542F32A56828"]))
    thread[[var_0["_encstr_B2790B3218137D542F32A56828"]]](var_1 + 3);
  else
    scripts\common\createfx::createfx_centerprint("_encstr_8D130B194AB607C84FBE646DC8" + var_0["_encstr_A6700C553F53A7133193E808875E"] + "_encstr_A6A52904B77301E62B63AC36E8B2918095DCA32D3A9659B916028E5E0E5608F2CCF0029B597767C236AECA");

  set_option_index(var_0["_encstr_84BA05A8CA852B"]);
  setDvar("_encstr_840703F23B", "_encstr_BA19049E7739");
}

menu_fx_option_set() {
  if(getDvar("_encstr_840703F23B") == "_encstr_BA19049E7739") {
    return;
  }
  var_0 = get_selected_option();
  var_1 = undefined;

  if(var_0["_encstr_81EF05D197C12B"] == "_encstr_A1D80717112333A5D4")
    var_1 = getDvar("_encstr_840703F23B");

  if(var_0["_encstr_81EF05D197C12B"] == "_encstr_921904C3DEF8")
    var_1 = getdvarint("_encstr_840703F23B");

  if(var_0["_encstr_81EF05D197C12B"] == "_encstr_8AA9066663F62C3A")
    var_1 = getdvarfloat("_encstr_840703F23B");

  if(var_0["_encstr_81EF05D197C12B"] == "_encstr_AD9B0589EDBDC6") {
    var_1 = getDvar("_encstr_840703F23B");

    if(var_1 == "_encstr_934C0218" || var_1 == "_encstr_B6C106D7FF89633D")
      var_1 = 0;
    else
      var_1 = 1;
  }

  apply_option_to_selected_fx(var_0, var_1);
}

apply_option_to_selected_fx(var_0, var_1) {
  for(var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["_encstr_87A205AF10734B"], var_3.v["_encstr_81EF05D197C12B"]))
      var_3.v[var_0["_encstr_84BA05A8CA852B"]] = var_1;
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

set_option_index(var_0) {
  for(var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["_encstr_84BA05A8CA852B"] != var_0) {
      continue;
    }
    level._createfx.selected_fx_option_index = var_1;
    return;
  }
}

get_selected_option() {
  return level._createfx.options[level._createfx.selected_fx_option_index];
}

mask(var_0, var_1) {
  return isDefined(level.createfxmasks[var_0][var_1]);
}

addoption(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["_encstr_81EF05D197C12B"] = var_0;
  var_6["_encstr_84BA05A8CA852B"] = var_1;
  var_6["_encstr_A6700C553F53A7133193E808875E"] = var_2;
  var_6["_encstr_8B1608EC43B8D647A113"] = var_3;
  var_6["_encstr_87A205AF10734B"] = var_4;

  if(isDefined(var_5))
    var_6["_encstr_B2790B3218137D542F32A56828"] = var_5;

  level._createfx.options[level._createfx.options.size] = var_6;
}

get_option(var_0) {
  for(var_1 = 0; var_1 < level._createfx.options.size; var_1++) {
    if(level._createfx.options[var_1]["_encstr_84BA05A8CA852B"] == var_0)
      return level._createfx.options[var_1];
  }
}

input_reactive_radius(var_0) {
  for(;;) {
    waitframe();

    if(level.player buttonPressed("_encstr_B84407FD927A8B4B25") || level.player buttonPressed("_encstr_814C02A2")) {
      break;
    }

    var_1 = 0;

    if(level.player buttonPressed("_encstr_884C0296"))
      var_1 = -10;
    else if(level.player buttonPressed("_encstr_AB4C0246"))
      var_1 = 10;

    if(var_1 != 0) {
      foreach(var_3 in level._createfx.selected_fx_ents) {
        if(isDefined(var_3.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"])) {
          var_3.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"] = var_3.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"] + var_1;
          var_3.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"] = clamp(var_3.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"], 10, 1000);
        }
      }
    }
  }

  level.last_displayed_ent = undefined;
  scripts\common\createfx::update_selected_entities();
  scripts\common\createfx::clear_settable_fx();
}

display_fx_add_options(var_0) {
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("_encstr_84E80761977DA17D06" + var_0.v["_encstr_95780526F31FA7"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_963F075181EAD8F26A" + var_0.v["_encstr_81EF05D197C12B"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_AA2D09EC9A6130BBF2F261" + var_0.v["_encstr_97FE07DE392D76D2CD"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_8B810905E6B36359DCD180" + var_0.v["_encstr_A7610758E6CED8569B"]);
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(level.effect_list_offset >= level._createfx.options.size)
    level.effect_list_offset = 0;

  for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
    var_5 = level._createfx.options[var_4];

    if(isDefined(var_0.v[var_5["_encstr_84BA05A8CA852B"]])) {
      continue;
    }
    if(!mask(var_5["_encstr_87A205AF10734B"], var_0.v["_encstr_81EF05D197C12B"])) {
      continue;
    }
    var_1++;

    if(var_1 < level.effect_list_offset) {
      continue;
    }
    if(var_2 >= level.effect_list_offset_max) {
      continue;
    }
    var_2++;
    var_6 = var_2;

    if(var_6 == 10)
      var_6 = 0;

    if(scripts\common\createfx::button_is_clicked(var_6 + "_encstr_B40101")) {
      add_option_to_selected_entities(var_5);
      menunone();
      level.last_displayed_ent = undefined;
      return;
    }

    scripts\common\createfx::set_fx_hudelement(var_6 + "_encstr_8507038279" + var_5["_encstr_A6700C553F53A7133193E808875E"]);
  }

  if(var_1 > level.effect_list_offset_max)
    scripts\common\createfx::set_fx_hudelement("_encstr_951F0C7B5D8A50392D7218B89E29");

  scripts\common\createfx::set_fx_hudelement("_encstr_83110B05F04901A21E9647027C");
}

add_option_to_selected_entities(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < level._createfx.selected_fx_ents.size; var_2++) {
    var_3 = level._createfx.selected_fx_ents[var_2];

    if(mask(var_0["_encstr_87A205AF10734B"], var_3.v["_encstr_81EF05D197C12B"]))
      var_3.v[var_0["_encstr_84BA05A8CA852B"]] = var_0["_encstr_8B1608EC43B8D647A113"];
  }
}

menunone() {
  level.effect_list_offset = 0;
  scripts\common\createfx::clear_fx_hudelements();
  setmenu("_encstr_8BBA05185F8B99");
}

display_fx_info(var_0) {
  if(!menu("_encstr_8BBA05185F8B99")) {
    return;
  }
  scripts\common\createfx::clear_fx_hudelements();
  scripts\common\createfx::set_fx_hudelement("_encstr_84E80761977DA17D06" + var_0.v["_encstr_95780526F31FA7"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_963F075181EAD8F26A" + var_0.v["_encstr_81EF05D197C12B"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_AA2D09EC9A6130BBF2F261" + var_0.v["_encstr_97FE07DE392D76D2CD"]);
  scripts\common\createfx::set_fx_hudelement("_encstr_8B810905E6B36359DCD180" + var_0.v["_encstr_A7610758E6CED8569B"]);

  if(entities_are_selected()) {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isDefined(var_0.v[var_5["_encstr_84BA05A8CA852B"]])) {
        continue;
      }
      var_1++;

      if(var_1 < level.effect_list_offset) {
        continue;
      }
      var_2++;
      scripts\common\createfx::set_fx_hudelement(var_2 + "_encstr_8507038279" + var_5["_encstr_A6700C553F53A7133193E808875E"] + "_encstr_AC0703C532" + var_0.v[var_5["_encstr_84BA05A8CA852B"]]);

      if(var_2 > level.effect_list_offset_max) {
        var_3 = 1;
        break;
      }
    }

    if(var_1 > level.effect_list_offset_max)
      scripts\common\createfx::set_fx_hudelement("_encstr_951F0C7B5D8A50392D7218B89E29");

    scripts\common\createfx::set_fx_hudelement("_encstr_8DAD0A1CF986279F5B6CA7F7");
    scripts\common\createfx::set_fx_hudelement("_encstr_83110B05F04901A21E9647027C");
  } else {
    var_1 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._createfx.options.size; var_4++) {
      var_5 = level._createfx.options[var_4];

      if(!isDefined(var_0.v[var_5["_encstr_84BA05A8CA852B"]])) {
        continue;
      }
      var_1++;
      scripts\common\createfx::set_fx_hudelement(var_5["_encstr_A6700C553F53A7133193E808875E"] + "_encstr_AC0703C532" + var_0.v[var_5["_encstr_84BA05A8CA852B"]]);

      if(var_1 > level._createfx.hudelem_count) {
        break;
      }
    }
  }
}

draw_effects_list(var_0) {
  scripts\common\createfx::clear_fx_hudelements();
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\common\createfx::func_get_level_fx();

  if(!isDefined(var_0))
    var_0 = "_encstr_A53A0F43D34E4AD8F820EE8719F8A5829D";

  scripts\common\createfx::set_fx_hudelement(var_0 + "_encstr_B20703A0D2" + level.effect_list_offset + "_encstr_8E170401D682" + var_3.size + "_encstr_A60703B92A");

  for(var_4 = level.effect_list_offset; var_4 < var_3.size; var_4++) {
    var_1 = var_1 + 1;
    scripts\common\createfx::set_fx_hudelement(var_1 + "_encstr_8507038279" + var_3[var_4]);

    if(var_1 >= level.effect_list_offset_max) {
      var_2 = 1;
      break;
    }
  }

  if(var_3.size > level.effect_list_offset_max) {
    scripts\common\createfx::set_fx_hudelement("_encstr_951F0C7B5D8A50392D7218B89E29");
    scripts\common\createfx::set_fx_hudelement("_encstr_96BD10C007762BBAA2C2634DF15528CEEABF");
  }
}

increment_list_offset() {
  var_0 = scripts\common\createfx::func_get_level_fx();

  if(level.effect_list_offset >= var_0.size - level.effect_list_offset_max)
    level.effect_list_offset = 0;
  else
    level.effect_list_offset = level.effect_list_offset + level.effect_list_offset_max;
}

decrement_list_offset() {
  level.effect_list_offset = level.effect_list_offset - level.effect_list_offset_max;

  if(level.effect_list_offset < 0) {
    var_0 = scripts\common\createfx::func_get_level_fx();
    level.effect_list_offset = var_0.size - level.effect_list_offset_max;
  }
}

select_by_name() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = scripts\common\createfx::func_get_level_fx();

  for(var_3 = level.effect_list_offset; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10)
      var_4 = 0;

    if(scripts\common\createfx::button_is_clicked(var_4 + "_encstr_B40101")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level.effect_list_offset_max) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_5 = [];

  foreach(var_3, var_7 in level.createfxent) {
    if(issubstr(var_7.v["_encstr_95780526F31FA7"], var_1))
      var_5[var_5.size] = var_3;
  }

  scripts\common\createfx::deselect_all_ents();
  scripts\common\createfx::select_index_array(var_5);
  level._createfx.select_by_name = 1;
}

get_last_selected_ent() {
  return level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}