/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\createfx.gsc
***********************************************/

createeffect(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  if(!isDefined(var_2))
    level.createfxent[level.createfxent.size] = var_3;

  var_3.v = [];
  var_3.v["_encstr_81EF05D197C12B"] = var_0;
  var_3.v["_encstr_95780526F31FA7"] = var_1;
  var_3.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);
  var_3.v["_encstr_97FE07DE392D76D2CD"] = (0, 0, 0);
  return var_3;
}

getloopeffectdelaydefault() {
  return 0.5;
}

getoneshoteffectdelaydefault() {
  return -4;
}

getexploderdelaydefault() {
  return 0;
}

getintervalsounddelaymindefault() {
  return 0.75;
}

getintervalsounddelaymaxdefault() {
  return 2;
}

createloopsound() {
  var_0 = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = var_0;
  var_0.v = [];
  var_0.v["_encstr_81EF05D197C12B"] = "_encstr_A35408BE67DFC0D98F9B";
  var_0.v["_encstr_95780526F31FA7"] = "_encstr_A67306780FE2ADD9";
  var_0.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] = "_encstr_BA19049E7739";
  var_0.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);
  var_0.v["_encstr_97FE07DE392D76D2CD"] = (0, 0, 0);
  var_0.v["_encstr_8F9F0EC3D815737FAB70BBA5F13027BF"] = 1;

  if(getDvar("_encstr_A9080B558F61CA1F822721394F") != "_encstr_A34C02BB")
    var_0.v["_encstr_8F9F0EC3D815737FAB70BBA5F13027BF"] = 0;

  return var_0;
}

createintervalsound() {
  var_0 = createloopsound();
  var_0.v["_encstr_81EF05D197C12B"] = "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1";
  var_0.v["_encstr_AB9A0AC80DCBE9A137FDD988"] = getintervalsounddelaymindefault();
  var_0.v["_encstr_A59A0AB1672C48FBB9E79B91"] = getintervalsounddelaymaxdefault();
  return var_0;
}

createnewexploder() {
  if(!isDefined(level.createfxent))
    level.createfxent = [];

  var_0 = createnewexploder_internal();
  level.createfxent[level.createfxent.size] = var_0;
  return var_0;
}

add_exploder(var_0, var_1) {
  var_2 = [];

  if(isDefined(level.createfxexploders[var_0]))
    var_2 = level.createfxexploders[var_0];

  var_2[var_2.size] = var_1;
  level.createfxexploders[var_0] = var_2;
}

createnewexploder_internal(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.v = [];
  }

  var_0.v["_encstr_81EF05D197C12B"] = "_encstr_A63B09CA3CE01B7B8C2B27";
  var_0.v["_encstr_81470E2588617828C789CD1F8B8A438A"] = "_encstr_820E07FAE8780B3A4C";

  if(!isDefined(var_0.v["_encstr_95780526F31FA7"]))
    var_0.v["_encstr_95780526F31FA7"] = "_encstr_A67306780FE2ADD9";

  if(!isDefined(var_0.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]))
    var_0.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] = "_encstr_BA19049E7739";

  if(!isDefined(var_0.v["_encstr_A7DC0A731F08BBCBC8033D87"]))
    var_0.v["_encstr_A7DC0A731F08BBCBC8033D87"] = "_encstr_BA19049E7739";

  if(!isDefined(var_0.v["_encstr_A7610758E6CED8569B"]))
    var_0.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);

  if(!isDefined(var_0.v["_encstr_97FE07DE392D76D2CD"]))
    var_0.v["_encstr_97FE07DE392D76D2CD"] = (0, 0, 0);

  if(!isDefined(var_0.v["_encstr_A63B09CA3CE01B7B8C2B27"]))
    var_0.v["_encstr_A63B09CA3CE01B7B8C2B27"] = 1;

  if(!isDefined(var_0.v["_encstr_8F7905C4EDE23F"]))
    var_0.v["_encstr_8F7905C4EDE23F"] = "_encstr_BA19049E7739";

  if(!isDefined(var_0.v["_encstr_96750613A808E91B"]) || var_0.v["_encstr_96750613A808E91B"] < 0)
    var_0.v["_encstr_96750613A808E91B"] = getexploderdelaydefault();

  return var_0;
}

createexploderex(var_0, var_1) {
  var_2 = scripts\engine\utility::createexploder(var_0);
  var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"] = var_1;
  return var_2;
}

createreactiveent(var_0) {
  var_1 = spawnStruct();

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  level.createfxent[level.createfxent.size] = var_1;
  var_1.v = [];
  var_1.v["_encstr_97FE07DE392D76D2CD"] = (0, 0, 0);
  var_1.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"] = 350;

  if(isDefined(var_0))
    var_1.v["_encstr_95780526F31FA7"] = var_0;
  else
    var_1.v["_encstr_95780526F31FA7"] = "_encstr_A67306780FE2ADD9";

  var_1.v["_encstr_81EF05D197C12B"] = "_encstr_82510C0E3347CF308B935DA7A8D8";
  var_1.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] = "_encstr_BA19049E7739";
  return var_1;
}

set_origin_and_angles(var_0, var_1) {
  if(isDefined(level.createfx_offset))
    var_0 = var_0 + level.createfx_offset;

  self.v["_encstr_97FE07DE392D76D2CD"] = var_0;
  self.v["_encstr_A7610758E6CED8569B"] = var_1;
}

set_forward_and_up_vectors() {
  self.v["_encstr_87070365F7"] = anglestoup(self.v["_encstr_A7610758E6CED8569B"]);
  self.v["_encstr_B42E085325A82CB3F221"] = anglesToForward(self.v["_encstr_A7610758E6CED8569B"]);
}

createfx_common() {
  precacheshader("_encstr_83AB065EE1391A7B");
  level._createfx = spawnStruct();
  level._createfx.grenade = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  level._createfx.grenade.fx = loadfx("_encstr_8AF621C466E3E0CFD533305A7A28A1C0E60F4E35F62F311BBF7B90D10207B5B967BCD5");
  level._createfx.grenade.sound = "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632";
  level._createfx.grenade.radius = 256;
  precachemodel("_encstr_9B0C18C21ED2CDD79DBA963295FA3639562C1DCA331EEB39ED1D");
  precachemodel("_encstr_93D61448619F177E38B020E1953E4E7380C943701321");
  scripts\engine\utility::flag_init("_encstr_8719101B9395163AAC330FD7370B3BD29BCE");
  scripts\engine\utility::flag_init("_encstr_82B111B335F88E0B6D296B01933D978288F32C");

  if(!isDefined(level.createfx))
    level.createfx = [];

  level.createfx_loopcounter = 0;
  waitframe();
  level notify("_encstr_A1B815C22301C210705918EF66C8A3BF2D78275D6F6257");
}

init_level_variables() {
  level._createfx.selectedmove_up = 0;
  level._createfx.selectedmove_forward = 0;
  level._createfx.selectedmove_right = 0;
  level._createfx.selectedrotate_pitch = 0;
  level._createfx.selectedrotate_roll = 0;
  level._createfx.selectedrotate_yaw = 0;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  level._createfx.rate = 1;
  level._createfx.snap2normal = 0;
  level._createfx.snap2angle = 0;
  level._createfx.snap2anglesnaps = [0, 90, 45, 15];
  level._createfx.axismode = 0;
  level._createfx.select_by_name = 0;
  level._createfx.drawaxis = 1;
  level._createfx.player_speed = getdvarfloat("_encstr_81DE0B2EC7F1722F48FC4960E4");
  set_player_speed_hud();
}

init_locked_list() {
  level._createfx.lockedlist = [];
  level._createfx.lockedlist["_encstr_B84407FD927A8B4B25"] = 1;
  level._createfx.lockedlist["_encstr_BE700E48AAA2A8F472F598A642C42294"] = 1;
  level._createfx.lockedlist["_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471"] = 1;
  level._createfx.lockedlist["_encstr_99A907CD283357CFF3"] = 1;
  level._createfx.lockedlist["_encstr_92DA066A207B669C"] = 1;
  level._createfx.lockedlist["_encstr_992206E4D8D19C1B"] = 1;
}

init_colors() {
  var_0 = [];
  var_0["_encstr_BE7F073BF060E0F269"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_BE7F073BF060E0F269"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.4, 0.95, 1);
  var_0["_encstr_BE7F073BF060E0F269"]["_encstr_8B1608EC43B8D647A113"] = (0.3, 0.8, 1);
  var_0["_encstr_B6480A92880DD02267293B7B"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_B6480A92880DD02267293B7B"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.4, 0.95, 1);
  var_0["_encstr_B6480A92880DD02267293B7B"]["_encstr_8B1608EC43B8D647A113"] = (0.3, 0.8, 1);
  var_0["_encstr_A63B09CA3CE01B7B8C2B27"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_A63B09CA3CE01B7B8C2B27"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (1, 0.2, 0.2);
  var_0["_encstr_A63B09CA3CE01B7B8C2B27"]["_encstr_8B1608EC43B8D647A113"] = (1, 0.1, 0.1);
  var_0["_encstr_992E0795F7E24048F8"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_992E0795F7E24048F8"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.95, 0.4, 0.95);
  var_0["_encstr_992E0795F7E24048F8"]["_encstr_8B1608EC43B8D647A113"] = (0.78, 0, 0.73);
  var_0["_encstr_A35408BE67DFC0D98F9B"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_A35408BE67DFC0D98F9B"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.5, 1, 0.75);
  var_0["_encstr_A35408BE67DFC0D98F9B"]["_encstr_8B1608EC43B8D647A113"] = (0.2, 0.9, 0.2);
  var_0["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.5, 1, 0.75);
  var_0["_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1"]["_encstr_8B1608EC43B8D647A113"] = (0.2, 0.9, 0.2);
  var_0["_encstr_82510C0E3347CF308B935DA7A8D8"]["_encstr_9B5A0916F76A63C9D40FB0"] = (1, 1, 0.2);
  var_0["_encstr_82510C0E3347CF308B935DA7A8D8"]["_encstr_ADEF0C29297F03A08B28F8431F73"] = (0.5, 1, 0.75);
  var_0["_encstr_82510C0E3347CF308B935DA7A8D8"]["_encstr_8B1608EC43B8D647A113"] = (0.2, 0.9, 0.2);
  level._createfx.colors = var_0;
}

createfxlogic() {
  waittillframeend;
  waitframe();

  if(!isDefined(level._effect))
    level._effect = [];

  if(getDvar("_encstr_99A90DC3A6311F8B5BB8038918AB42") == "_encstr_B40101") {} else if(getDvar("_encstr_99A90DC3A6311F8B5BB8038918AB42") == level.script)
    [[level.func_position_player]]();

  init_crosshair();
  scripts\common\createfxmenu::init_menu();
  init_huds();
  init_tool_hud();
  init_level_variables();
  init_locked_list();
  init_colors();
  level.player setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  setdvarifuninitialized("_encstr_BDEA10D636DB026CB110CB4F08683C1BA34E", "_encstr_B40101");
  setdvarifuninitialized("_encstr_9A80117A751591F5ED95A1D116F1C34F23C5A7", "_encstr_934C0218");

  if(getDvar("_encstr_B6F3108B9ABF974B484893290B03E1F98B8A") == "_encstr_B40101") {}

  if(getDvar("_encstr_95870B418B0459E9FBD1379F18") == "_encstr_B40101") {}

  level.createfx_draw_enabled = 1;
  level.last_displayed_ent = undefined;
  level.buttonisheld = [];
  var_0 = (0, 0, 0);
  scripts\engine\utility::flag_set("_encstr_82B111B335F88E0B6D296B01933D978288F32C");

  if(!level.mp_createfx)
    var_0 = level.player.origin;

  var_1 = undefined;
  level.fx_rotating = 0;
  scripts\common\createfxmenu::setmenu("_encstr_8BBA05185F8B99");
  level.createfx_selecting = 0;
  level.createfx_inputlocked = 0;

  foreach(var_3 in level.createfxent)
  var_3 post_entity_creation_function();

  thread draw_distance();
  var_5 = undefined;
  thread createfx_autosave();

  for(;;) {
    var_6 = 0;
    var_7 = anglestoright(level.player getplayerangles());
    var_8 = anglesToForward(level.player getplayerangles());
    var_9 = anglestoup(level.player getplayerangles());
    var_10 = 0.85;
    var_11 = var_8 * 750;
    level.createfxcursor = scripts\engine\trace::_bullet_trace(level.player getEye(), level.player getEye() + var_11, 0, undefined);
    var_12 = undefined;
    level.buttonclick = [];
    level.button_is_kb = [];
    process_button_held_and_clicked();
    var_13 = button_is_held("_encstr_92DA066A207B669C", "_encstr_992206E4D8D19C1B", "_encstr_BE700E48AAA2A8F472F598A642C42294");
    var_14 = button_is_held("_encstr_B8D9071C678074D789", "_encstr_AC810768CBE4D3C9DB");
    var_15 = button_is_clicked("_encstr_99A907CD283357CFF3", "_encstr_87D60912AA4545F493D728");
    var_16 = button_is_held("_encstr_99A907CD283357CFF3", "_encstr_87D60912AA4545F493D728");
    scripts\common\createfxmenu::create_fx_menu();
    var_17 = "_encstr_9A070391A9";

    if(getdvarint("_encstr_B6F3108B9ABF974B484893290B03E1F98B8A"))
      var_17 = "_encstr_8C07033E11";

    if(button_is_clicked(var_17)) {}

    if(getdvarint("_encstr_829712CF5E2031D960278BF871ED20BEA3A55052"))
      generate_fx_log();

    if(button_is_clicked("_encstr_AF0703FDBA"))
      toggle_createfx_drawing();

    if(button_is_clicked("_encstr_964C02E5"))
      toggle_createfx_axis();

    if(button_is_clicked("_encstr_B81904B4CD9B"))
      insert_effect();

    if(button_is_clicked("_encstr_8218041D77EA"))
      delete_pressed();

    if(button_is_clicked("_encstr_B84407FD927A8B4B25"))
      clear_settable_fx();

    if(button_is_clicked("_encstr_AF8A061B6A1960CD"))
      set_off_exploders();

    if(button_is_clicked("_encstr_B14C02D5"))
      select_by_name_list();

    modify_player_speed();

    if(!var_13 && !var_14 && button_is_clicked("_encstr_A74C0277")) {
      select_all_exploders_of_currently_selected("_encstr_A63B09CA3CE01B7B8C2B27");
      select_all_exploders_of_currently_selected("_encstr_8F7905C4EDE23F");
    }

    if(var_14) {
      if(button_is_clicked("_encstr_A74C0277"))
        goto_selected();
    }

    if(button_is_held("_encstr_8C4C025A", "_encstr_8607038D31") && !level.mp_createfx) {
      show_help();
      waitframe();
      continue;
    }

    if(button_is_clicked("_encstr_B6C90E84AAA82A3D9CF56235A8290D2D"))
      copy_ents();

    if(button_is_clicked("_encstr_B1550ECD1F09652916892F0763C99132"))
      paste_ents();

    if(var_13) {
      if(button_is_clicked("_encstr_834C02D8"))
        copy_ents();

      if(button_is_clicked("_encstr_B44C022E"))
        paste_ents();

      if(button_is_clicked("_encstr_A74C0277"))
        spawn_grenade();
    }

    if(isDefined(level._createfx.selected_fx_option_index))
      scripts\common\createfxmenu::menu_fx_option_set();

    for(var_18 = 0; var_18 < level.createfxent.size; var_18++) {
      var_3 = level.createfxent[var_18];
      var_19 = vectorNormalize(var_3.v["_encstr_97FE07DE392D76D2CD"] - (level.player.origin + (0, 0, 55)));
      var_20 = vectordot(var_8, var_19);

      if(var_20 < var_10) {
        continue;
      }
      var_10 = var_20;
      var_12 = var_3;
    }

    level.fx_highlightedent = var_12;

    if(isDefined(var_12)) {
      if(isDefined(var_1)) {
        if(var_1 != var_12) {
          if(!ent_is_selected(var_1))
            var_1 thread entity_highlight_disable();

          if(!ent_is_selected(var_12))
            var_12 thread entity_highlight_enable();
        }
      } else if(!ent_is_selected(var_12))
        var_12 thread entity_highlight_enable();
    }

    manipulate_createfx_ents(var_12, var_15, var_16, var_13, var_7);
    var_6 = handle_selected_ents(var_6);
    waitframe();

    if(var_6)
      update_selected_entities();

    if(!level.mp_createfx)
      var_0 = [[level.func_position_player_get]](var_0);

    var_1 = var_12;

    if(last_selected_entity_has_changed(var_5)) {
      level.effect_list_offset = 0;
      clear_settable_fx();
      scripts\common\createfxmenu::setmenu("_encstr_8BBA05185F8B99");
    }

    if(level._createfx.selected_fx_ents.size) {
      var_5 = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
      continue;
    }

    var_5 = undefined;
  }
}

modify_player_speed() {
  var_0 = 0;
  var_1 = button_is_held("_encstr_92DA066A207B669C", "_encstr_992206E4D8D19C1B");

  if(button_is_held("_encstr_BD4C024E")) {
    if(var_1) {
      if(level._createfx.player_speed < 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed + 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed + 5;

    var_0 = 1;
  } else if(button_is_held("_encstr_964C0249")) {
    if(var_1) {
      if(level._createfx.player_speed > 190)
        level._createfx.player_speed = 190;
      else
        level._createfx.player_speed = level._createfx.player_speed - 10;
    } else
      level._createfx.player_speed = level._createfx.player_speed - 5;

    var_0 = 1;
  }

  if(var_0) {
    level._createfx.player_speed = clamp(level._createfx.player_speed, 5, 500);
    [[level.func_player_speed]]();
    set_player_speed_hud();
  }
}

set_player_speed_hud() {
  if(level.mp_createfx) {
    return;
  }
  if(!isDefined(level._createfx.player_speed_hud)) {
    var_0 = newhudelem();
    var_0.alignx = "_encstr_8253060E2B5FE330";
    var_0.foreground = 1;
    var_0.fontscale = 1.2;
    var_0.alpha = 0.2;
    var_0.x = 320;
    var_0.y = 420;
    var_1 = newhudelem();
    var_1.alignx = "_encstr_A5AD056A019C63";
    var_1.foreground = 1;
    var_1.fontscale = 1.2;
    var_1.alpha = 0.2;
    var_1.x = 320;
    var_1.y = 420;
    var_0.hud_value = var_1;
    level._createfx.player_speed_hud = var_0;
  }

  level._createfx.player_speed_hud.hud_value setvalue(level._createfx.player_speed);
}

toggle_createfx_drawing() {
  level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

insert_effect() {
  scripts\common\createfxmenu::setmenu("_encstr_975A097AC54301413F1808");
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  set_fx_hudelement("_encstr_8FA71C11178202BAA55F0179069CF2C59BDBE3799BAA7F98EAF7E953AF2A");
  set_fx_hudelement("_encstr_836E0F8B52C2D9259D1AC7E2A0B160E9F0");

  if(!level.mp_createfx) {
    set_fx_hudelement("_encstr_B8F10EC2B65EC1B0DF18DB40E70A5D11");
    set_fx_hudelement("_encstr_83CB111396F24910BD108B8D2F36A890CFEA71");
    set_fx_hudelement("_encstr_91F30C3C100117E019901AA2F035");
    set_fx_hudelement("_encstr_B4D2129AE204A737CA049A437BD1044D7BEADC23");
    set_fx_hudelement("_encstr_A5BD0F43A86AD2CF02CBDCD83D7BEF47A6");
  } else {
    set_fx_hudelement("_encstr_AD601192A836C00ACF984915A7196ACDC3A01F");
    set_fx_hudelement("_encstr_82720C368AF94583E939CD0795D5");
    set_fx_hudelement("_encstr_B4BA12868B40A7B9CA80A943B73A019A7B5DE623");
    set_fx_hudelement("_encstr_8E460FD4C54094B22C36D196672B088CC2");
  }

  set_fx_hudelement("_encstr_968E0DA06CA408862C9BB159C602E3");
  set_fx_hudelement("_encstr_83110B05F04901A21E9647027C");
}

is_ent_filtered_out(var_0, var_1) {
  if(var_1 != "_encstr_B40101") {
    if(isDefined(var_0.v["_encstr_81EF05D197C12B"]) && issubstr(var_0.v["_encstr_81EF05D197C12B"], var_1))
      return 0;
    else if(isDefined(var_0.v["_encstr_95780526F31FA7"]) && issubstr(var_0.v["_encstr_95780526F31FA7"], var_1))
      return 0;
    else if(isDefined(var_0.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]) && issubstr(var_0.v["_encstr_8D760BA3EF33C54D42B1B4A19B"], var_1))
      return 0;

    return 1;
  }

  return 0;
}

manipulate_createfx_ents(var_0, var_1, var_2, var_3, var_4) {
  if(!level.createfx_draw_enabled) {
    return;
  }
  if(level._createfx.select_by_name) {
    level._createfx.select_by_name = 0;
    var_0 = undefined;
  } else if(select_by_substring())
    var_0 = undefined;

  for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
    var_6 = level.createfxent[var_5];

    if(!var_6.drawn) {
      continue;
    }
    if(is_ent_filtered_out(var_6, getDvar("_encstr_BDEA10D636DB026CB110CB4F08683C1BA34E"))) {
      continue;
    }
    var_7 = getdvarfloat("_encstr_9179111B39CAB0A3CA99F0D7DC36853659B423");

    if(isDefined(var_0) && var_6 == var_0) {
      if(!scripts\common\createfxmenu::entities_are_selected())
        scripts\common\createfxmenu::display_fx_info(var_6);

      if(var_1) {
        var_8 = index_is_selected(var_5);
        level.createfx_selecting = !var_8;

        if(!var_3) {
          var_9 = level._createfx.selected_fx_ents.size;
          clear_entity_selection();

          if(var_8 && var_9 == 1)
            select_entity(var_5, var_6);
        }

        toggle_entity_selection(var_5, var_6);
      } else if(var_2) {
        if(var_3) {
          if(level.createfx_selecting)
            select_entity(var_5, var_6);

          if(!level.createfx_selecting)
            deselect_entity(var_5, var_6);
        }
      }

      var_10 = "_encstr_ADEF0C29297F03A08B28F8431F73";
    } else
      var_10 = "_encstr_8B1608EC43B8D647A113";

    if(index_is_selected(var_5))
      var_10 = "_encstr_9B5A0916F76A63C9D40FB0";

    var_6 createfx_print3d(var_10, var_7, var_4);
  }
}

draw_origin(var_0, var_1) {
  var_2 = level.player getvieworigin();
  var_3 = level.player getplayerangles();
  var_4 = level._createfx.colors[self.v["_encstr_81EF05D197C12B"]][var_1];
  var_5 = 0;
  var_6 = 1;
  var_7 = (0, 0, 0);
  var_8 = distancesquared(var_2, self.v["_encstr_97FE07DE392D76D2CD"]) < 36864;

  if(var_8) {
    var_9 = distance(var_2, self.v["_encstr_97FE07DE392D76D2CD"]);
    var_10 = var_9 / 176;
    var_5 = 1 - clamp(var_10, 0.0, 1.0);
    var_6 = clamp(var_10, 0.333, 1.0);
    var_11 = anglestoright(var_3) * -4;
    var_12 = anglestoup(var_3) * -4.666;
    var_7 = var_11 + var_12;
  }

  if(var_5 > 0) {
    var_13 = scripts\engine\utility::within_fov(var_2, var_3, self.v["_encstr_97FE07DE392D76D2CD"], 0.422618);

    if(var_13) {
      var_14 = 2.0;
      var_15 = 4.0;
      var_16 = anglesToForward(self.v["_encstr_A7610758E6CED8569B"]);
      var_16 = var_16 * (var_15 * var_0);
      var_17 = anglestoright(self.v["_encstr_A7610758E6CED8569B"]) * -1;
      var_17 = var_17 * (var_15 * var_0);
      var_18 = anglestoup(self.v["_encstr_A7610758E6CED8569B"]);
      var_18 = var_18 * (var_15 * var_0);
    }
  }
}

createfx_print3d(var_0, var_1, var_2) {
  draw_origin(var_1, var_0);

  if(self.textalpha > 0) {
    var_3 = get_print3d_text();
    var_4 = var_2 * (var_3[0].size * -2.93);
    var_5 = level._createfx.colors[self.v["_encstr_81EF05D197C12B"]][var_0];

    if(isDefined(self.is_playing))
      var_5 = (1, 0.5, 0);

    var_6 = 15;

    foreach(var_8 in var_3)
    var_6 = var_6 - 13;

    if(isDefined(self.v["_encstr_B65410F0F70131B1C2D3F590AA3AE9387D37"])) {
      if(self.v["_encstr_95780526F31FA7"] == "_encstr_A67306780FE2ADD9" && !getdvarint("_encstr_9A80117A751591F5ED95A1D116F1C34F23C5A7"))
        return;
    }
  }
}

get_print3d_text() {
  switch (self.v["_encstr_81EF05D197C12B"]) {
    case "_encstr_82510C0E3347CF308B935DA7A8D8":
      var_0[0] = "_encstr_A77511A340411333AB44DF862E7FFBD6490262" + self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"];

      if(!level.mp_createfx)
        var_0[1] = "_encstr_BAEC0ECE9D7F91E95C6B381A40384D41" + self.v["_encstr_95780526F31FA7"];

      return var_0;
    case "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1":
    case "_encstr_A35408BE67DFC0D98F9B":
      return [self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]];
    default:
      return [self.v["_encstr_95780526F31FA7"]];
  }
}

select_by_name_list() {
  level.effect_list_offset = 0;
  clear_fx_hudelements();
  scripts\common\createfxmenu::setmenu("_encstr_86030F37D0706532E1A08E4088ED2A25F9");
  scripts\common\createfxmenu::draw_effects_list();
}

handle_selected_ents(var_0) {
  if(level._createfx.selected_fx_ents.size > 0) {
    var_0 = selected_ent_buttons(var_0);

    if(!current_mode_hud("_encstr_A2EE0E2827DC016FE3C7A520DF9A990B")) {
      new_tool_hud("_encstr_A2EE0E2827DC016FE3C7A520DF9A990B");
      set_tool_hudelem("_encstr_AC4B12D7B010C592411DAFB6650D9BC85C7883B7");
      set_tool_hudelem("_encstr_A59306204004FA7A", "_encstr_ACA20538F84D39");
      set_tool_hudelem("_encstr_87110649161DB21D", level._createfx.rate);
      set_tool_hudelem("_encstr_BD1A0DEB65B0A20AE020F30AC9D912", level._createfx.snap2normal);
      set_tool_hudelem("_encstr_93210CB6850AF95351B3389867D2", level._createfx.snap2anglesnaps[level._createfx.snap2angle]);
    }

    if(level._createfx.axismode && level._createfx.selected_fx_ents.size > 0) {
      set_tool_hudelem("_encstr_A59306204004FA7A", "_encstr_B4F507E4BD4785E856");
      thread[[level.func_process_fx_rotater]]();

      if(button_is_clicked("_encstr_99BF0603D0C4979A", "_encstr_A64C0223"))
        reset_axis_of_selected_ents();

      if(button_is_clicked("_encstr_B44C022E"))
        copy_angles_of_selected_ents();

      for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++)
        level._createfx.selected_fx_ents[var_1] draw_axis();

      if(level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0)
        var_0 = 1;
    } else {
      set_tool_hudelem("_encstr_A59306204004FA7A", "_encstr_ACA20538F84D39");
      var_2 = get_selected_move_vector();

      for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
        var_3 = level._createfx.selected_fx_ents[var_1];

        if(isDefined(var_3.model)) {
          continue;
        }
        var_3 draw_cross();
        var_3.v["_encstr_97FE07DE392D76D2CD"] = var_3.v["_encstr_97FE07DE392D76D2CD"] + var_2;
      }

      if(distance((0, 0, 0), var_2) > 0)
        var_0 = 1;
    }
  } else
    clear_tool_hud();

  return var_0;
}

selected_ent_buttons(var_0) {
  if(button_is_clicked("_encstr_B8D9071C678074D789", "_encstr_AC810768CBE4D3C9DB", "_encstr_ACD6096A8DAF73CD85E989"))
    toggle_axismode();

  modify_rate();

  if(button_is_clicked("_encstr_B24C02EF"))
    toggle_snap2normal();

  if(button_is_clicked("_encstr_844C029C"))
    toggle_snap2angle();

  if(button_is_clicked("_encstr_961804BD954A", "_encstr_A54C0259")) {
    drop_selection_to_ground();
    var_0 = 1;
  }

  if(button_is_clicked("_encstr_A9190429A126", "_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471")) {
    move_selection_to_cursor();
    var_0 = 1;
  }

  if(button_is_clicked("_encstr_934C02B2")) {
    convert_selection_to_exploder();
    var_0 = 1;
  }

  return var_0;
}

modify_rate() {
  var_0 = button_is_held("_encstr_B8D9071C678074D789", "_encstr_AC810768CBE4D3C9DB");
  var_1 = button_is_held("_encstr_92DA066A207B669C", "_encstr_992206E4D8D19C1B");

  if(button_is_clicked("_encstr_AB4C0246")) {
    if(var_0)
      level._createfx.rate = level._createfx.rate + 1;
    else if(var_1) {
      if(level._createfx.rate < 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = level._createfx.rate + 10;
    } else
      level._createfx.rate = level._createfx.rate + 0.1;
  } else if(button_is_clicked("_encstr_884C0296")) {
    if(var_0)
      level._createfx.rate = level._createfx.rate - 1;
    else if(var_1) {
      if(level._createfx.rate > 1)
        level._createfx.rate = 1;
      else
        level._createfx.rate = 0.1;
    } else
      level._createfx.rate = level._createfx.rate - 0.1;
  }

  level._createfx.rate = clamp(level._createfx.rate, 0.1, 100);
  set_tool_hudelem("_encstr_87110649161DB21D", level._createfx.rate);
}

toggle_axismode() {
  level._createfx.axismode = !level._createfx.axismode;
}

toggle_snap2normal() {
  level._createfx.snap2normal = !level._createfx.snap2normal;
  set_tool_hudelem("_encstr_BD1A0DEB65B0A20AE020F30AC9D912", level._createfx.snap2normal);
}

toggle_snap2angle() {
  level._createfx.snap2angle = level._createfx.snap2angle + 1;

  if(level._createfx.snap2angle >= level._createfx.snap2anglesnaps.size)
    level._createfx.snap2angle = 0;

  set_tool_hudelem("_encstr_93210CB6850AF95351B3389867D2", level._createfx.snap2anglesnaps[level._createfx.snap2angle]);
}

copy_angles_of_selected_ents() {
  level notify("_encstr_B41E1223B073FFF27595616275098A8B7B48AF9B");

  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["_encstr_A7610758E6CED8569B"] = level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1].v["_encstr_A7610758E6CED8569B"];
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

reset_axis_of_selected_ents() {
  level notify("_encstr_B41E1223B073FFF27595616275098A8B7B48AF9B");

  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_1.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);
    var_1 set_forward_and_up_vectors();
  }

  update_selected_entities();
}

last_selected_entity_has_changed(var_0) {
  if(isDefined(var_0)) {
    if(!scripts\common\createfxmenu::entities_are_selected())
      return 1;
  } else
    return scripts\common\createfxmenu::entities_are_selected();

  return var_0 != level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size - 1];
}

drop_selection_to_ground() {
  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    var_1 = level._createfx.selected_fx_ents[var_0];
    var_2 = scripts\engine\trace::_bullet_trace(var_1.v["_encstr_97FE07DE392D76D2CD"], var_1.v["_encstr_97FE07DE392D76D2CD"] + (0, 0, -2048), 0, undefined);
    var_1.v["_encstr_97FE07DE392D76D2CD"] = var_2["_encstr_BD260953AA97E3F014279D"];
  }
}

set_off_exploders() {
  level notify("_encstr_B462181AB8E37EF3B12468574DFA2BC50FE0E28369653797E915");
  var_0 = [];

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(isDefined(var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"]))
      var_0[var_2.v["_encstr_A63B09CA3CE01B7B8C2B27"]] = 1;
  }

  foreach(var_6, var_5 in var_0)
  scripts\engine\utility::exploder(var_6);
}

draw_distance() {
  var_0 = 0;

  if(getdvarint("_encstr_9B780B3DC967E1A95461274361") == 0) {}

  for(;;) {
    var_1 = getdvarint("_encstr_9B780B3DC967E1A95461274361");
    var_1 = var_1 * var_1;

    for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];
      var_3.drawn = distancesquared(level.player.origin, var_3.v["_encstr_97FE07DE392D76D2CD"]) <= var_1;
      var_0++;

      if(var_0 > 100) {
        var_0 = 0;
        waitframe();
      }
    }

    if(level.createfxent.size == 0)
      waitframe();
  }
}

createfx_autosave() {
  setdvarifuninitialized("_encstr_84EF0BD09CBE37CC5189646ADB", "_encstr_AC1804F7A082");

  for(;;) {
    wait(getdvarint("_encstr_84EF0BD09CBE37CC5189646ADB"));
    scripts\engine\utility::flag_waitopen("_encstr_8719101B9395163AAC330FD7370B3BD29BCE");

    if(getdvarint("_encstr_95870B418B0459E9FBD1379F18")) {
      continue;
    }
    generate_fx_log(1);
  }
}

rotate_over_time(var_0, var_1) {
  level endon("_encstr_B41E1223B073FFF27595616275098A8B7B48AF9B");
  var_2 = 0.1;

  for(var_3 = 0; var_3 < var_2 * 20; var_3++) {
    if(level.selectedrotate_pitch != 0)
      var_0 addpitch(level.selectedrotate_pitch);
    else if(level.selectedrotate_yaw != 0)
      var_0 addyaw(level.selectedrotate_yaw);
    else
      var_0 addroll(level.selectedrotate_roll);

    waitframe();
    var_0 draw_axis();

    for(var_4 = 0; var_4 < level._createfx.selected_fx_ents.size; var_4++) {
      var_5 = level._createfx.selected_fx_ents[var_4];

      if(isDefined(var_5.model)) {
        continue;
      }
      var_5.v["_encstr_97FE07DE392D76D2CD"] = var_1[var_4].origin;
      var_5.v["_encstr_A7610758E6CED8569B"] = var_1[var_4].angles;
    }
  }
}

delete_pressed() {
  if(level.createfx_inputlocked) {
    remove_selected_option();
    return;
  }

  delete_selection();
}

remove_selected_option() {
  if(!isDefined(level._createfx.selected_fx_option_index)) {
    return;
  }
  var_0 = level._createfx.options[level._createfx.selected_fx_option_index]["_encstr_84BA05A8CA852B"];

  for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(!ent_is_selected(var_2)) {
      continue;
    }
    var_2 remove_option(var_0);
  }

  update_selected_entities();
  clear_settable_fx();
}

remove_option(var_0) {
  self.v[var_0] = undefined;
}

delete_selection() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(ent_is_selected(var_2)) {
      if(isDefined(var_2.loopsound_ent)) {
        var_2.loopsound_ent stoploopsound();
        var_2.loopsound_ent delete();
      }

      if(isDefined(var_2.looper))
        var_2.looper delete();

      var_2 notify("_encstr_8B2D0AD00B95B1BEEB0FD057");
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  level.createfxent = var_0;
  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
  clear_fx_hudelements();
  remove_axis_model();
}

move_selection_to_cursor() {
  var_0 = level.createfxcursor["_encstr_BD260953AA97E3F014279D"];

  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  var_1 = get_center_of_array(level._createfx.selected_fx_ents);
  var_2 = var_1 - var_0;

  for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    var_4 = level._createfx.selected_fx_ents[var_3];

    if(isDefined(var_4.model)) {
      continue;
    }
    var_4.v["_encstr_97FE07DE392D76D2CD"] = var_4.v["_encstr_97FE07DE392D76D2CD"] - var_2;

    if(level._createfx.snap2normal) {
      if(isDefined(level.createfxcursor["_encstr_820E07FAE8780B3A4C"]))
        var_4.v["_encstr_A7610758E6CED8569B"] = vectortoangles(level.createfxcursor["_encstr_820E07FAE8780B3A4C"]);
    }
  }
}

convert_selection_to_exploder() {
  if(level._createfx.selected_fx_ents.size < 1) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(var_2.v["_encstr_81EF05D197C12B"] == "_encstr_B6480A92880DD02267293B7B") {
      var_0 = 1;
      createnewexploder_internal(var_2);
      continue;
    }
  }

  if(var_0) {
    scripts\common\createfxmenu::setmenu("_encstr_8BBA05185F8B99");
    scripts\common\createfxmenu::display_fx_info(scripts\common\createfxmenu::get_last_selected_ent());
  }
}

select_last_entity() {
  select_entity(level.createfxent.size - 1, level.createfxent[level.createfxent.size - 1]);
}

select_all_exploders_of_currently_selected(var_0) {
  var_1 = [];

  foreach(var_3 in level._createfx.selected_fx_ents) {
    if(!isDefined(var_3.v[var_0])) {
      continue;
    }
    var_4 = var_3.v[var_0];
    var_1[var_4] = 1;
  }

  foreach(var_4, var_7 in var_1) {
    foreach(var_9, var_3 in level.createfxent) {
      if(index_is_selected(var_9)) {
        continue;
      }
      if(!isDefined(var_3.v[var_0])) {
        continue;
      }
      if(var_3.v[var_0] != var_4) {
        continue;
      }
      select_entity(var_9, var_3);
    }
  }

  update_selected_entities();
}

copy_ents() {
  if(level._createfx.selected_fx_ents.size <= 0) {
    return;
  }
  var_0 = [];

  for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    var_2 = level._createfx.selected_fx_ents[var_1];
    var_3 = spawnStruct();
    var_3.v = var_2.v;
    var_3 post_entity_creation_function();
    var_0[var_0.size] = var_3;
  }

  level.stored_ents = var_0;
}

post_entity_creation_function() {
  self.textalpha = 0;
  self.drawn = 1;
}

paste_ents() {
  if(!isDefined(level.stored_ents)) {
    return;
  }
  clear_entity_selection();

  for(var_0 = 0; var_0 < level.stored_ents.size; var_0++)
    add_and_select_entity(level.stored_ents[var_0]);

  move_selection_to_cursor();
  update_selected_entities();
  level.stored_ents = [];
  copy_ents();
}

add_and_select_entity(var_0) {
  level.createfxent[level.createfxent.size] = var_0;
  select_last_entity();
}

get_center_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = (var_1[0] + var_0[var_2].v["_encstr_97FE07DE392D76D2CD"][0], var_1[1] + var_0[var_2].v["_encstr_97FE07DE392D76D2CD"][1], var_1[2] + var_0[var_2].v["_encstr_97FE07DE392D76D2CD"][2]);

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

goto_selected() {
  var_0 = undefined;

  if(level._createfx.selected_fx_ents.size > 0)
    var_0 = get_center_of_array(level._createfx.selected_fx_ents);
  else if(isDefined(level.fx_highlightedent))
    var_0 = level.fx_highlightedent.v["_encstr_97FE07DE392D76D2CD"];

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = vectortoangles(level.player.origin - var_0);
  var_2 = var_0 + anglesToForward(var_1) * 200;
  level.player setOrigin(var_2 + (0, 0, -60));
  level.player setplayerangles(vectortoangles(var_0 - var_2));
}

ent_draw_axis() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    draw_axis();
    waitframe();
  }
}

rotation_is_occuring() {
  if(level.selectedrotate_roll != 0)
    return 1;

  if(level.selectedrotate_pitch != 0)
    return 1;

  return level.selectedrotate_yaw != 0;
}

print_fx_options(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level._createfx.options.size; var_3++) {
    var_4 = level._createfx.options[var_3];
    var_5 = var_4["_encstr_84BA05A8CA852B"];

    if(!isDefined(var_0.v[var_5])) {
      continue;
    }
    if(!scripts\common\createfxmenu::mask(var_4["_encstr_87A205AF10734B"], var_0.v["_encstr_81EF05D197C12B"])) {
      continue;
    }
    if(!level.mp_createfx) {
      if(scripts\common\createfxmenu::mask("_encstr_840703F23B", var_0.v["_encstr_81EF05D197C12B"]) && var_5 == "_encstr_95780526F31FA7") {
        continue;
      }
      if(var_0.v["_encstr_81EF05D197C12B"] == "_encstr_A63B09CA3CE01B7B8C2B27" && var_5 == "_encstr_A63B09CA3CE01B7B8C2B27") {
        continue;
      }
      var_6 = var_0.v["_encstr_81EF05D197C12B"] + "_encstr_874C029E" + var_5;

      if(isDefined(level._createfx.defaults[var_6]) && level._createfx.defaults[var_6] == var_0.v[var_5])
        continue;
    }

    if(var_4["_encstr_81EF05D197C12B"] == "_encstr_A1D80717112333A5D4") {
      var_7 = var_0.v[var_5] + "_encstr_B40101";

      if(var_7 == "_encstr_BA19049E7739") {
        continue;
      }
      cfxprintln(var_1 + "_encstr_97BE09B2E6A38BD9D68088" + var_5 + "_encstr_B45B084221896E9E7F31" + var_0.v[var_5] + "_encstr_8807037EA0");
      continue;
    }

    cfxprintln(var_1 + "_encstr_97BE09B2E6A38BD9D68088" + var_5 + "_encstr_A3D7071140EA104F04" + var_0.v[var_5] + "_encstr_A54C02F2");
  }
}

entity_highlight_disable() {
  self notify("_encstr_AF731168B319396A872A13E50890F8E98647ED");
  self endon("_encstr_AF731168B319396A872A13E50890F8E98647ED");

  for(;;) {
    self.textalpha = self.textalpha * 0.85;
    self.textalpha = self.textalpha - 0.05;

    if(self.textalpha < 0) {
      break;
    }

    wait 0.05;
  }

  self.textalpha = 0;
}

entity_highlight_enable() {
  self notify("_encstr_AF731168B319396A872A13E50890F8E98647ED");
  self endon("_encstr_AF731168B319396A872A13E50890F8E98647ED");

  for(;;) {
    self.textalpha = self.textalpha + 0.05;
    self.textalpha = self.textalpha * 1.25;

    if(self.textalpha > 1) {
      break;
    }

    waitframe();
  }

  self.textalpha = 1;
}

clear_settable_fx() {
  level.createfx_inputlocked = 0;
  level._createfx.selected_fx_option_index = undefined;
  reset_fx_hud_colors();
}

reset_fx_hud_colors() {
  for(var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++)
    level._createfx.hudelems[var_0][0].color = (1, 1, 1);
}

toggle_entity_selection(var_0, var_1) {
  if(isDefined(level._createfx.selected_fx[var_0]))
    deselect_entity(var_0, var_1);
  else
    select_entity(var_0, var_1);
}

select_entity(var_0, var_1) {
  if(isDefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("_encstr_B41E1223B073FFF27595616275098A8B7B48AF9B");
  var_1 thread entity_highlight_enable();
  level._createfx.selected_fx[var_0] = 1;
  level._createfx.selected_fx_ents[level._createfx.selected_fx_ents.size] = var_1;
}

ent_is_highlighted(var_0) {
  if(!isDefined(level.fx_highlightedent))
    return 0;

  return var_0 == level.fx_highlightedent;
}

deselect_entity(var_0, var_1) {
  if(!isDefined(level._createfx.selected_fx[var_0])) {
    return;
  }
  clear_settable_fx();
  level notify("_encstr_B41E1223B073FFF27595616275098A8B7B48AF9B");
  level._createfx.selected_fx[var_0] = undefined;

  if(!ent_is_highlighted(var_1))
    var_1 thread entity_highlight_disable();

  var_2 = [];

  for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
    if(level._createfx.selected_fx_ents[var_3] != var_1)
      var_2[var_2.size] = level._createfx.selected_fx_ents[var_3];
  }

  level._createfx.selected_fx_ents = var_2;
}

index_is_selected(var_0) {
  return isDefined(level._createfx.selected_fx[var_0]);
}

ent_is_selected(var_0) {
  for(var_1 = 0; var_1 < level._createfx.selected_fx_ents.size; var_1++) {
    if(level._createfx.selected_fx_ents[var_1] == var_0)
      return 1;
  }

  return 0;
}

clear_entity_selection() {
  for(var_0 = 0; var_0 < level._createfx.selected_fx_ents.size; var_0++) {
    if(!ent_is_highlighted(level._createfx.selected_fx_ents[var_0]))
      level._createfx.selected_fx_ents[var_0] thread entity_highlight_disable();
  }

  level._createfx.selected_fx = [];
  level._createfx.selected_fx_ents = [];
}

draw_axis() {}

set_axis_model(var_0) {
  if(!isDefined(level._createfx.axis))
    level._createfx.axis = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  else if(level._createfx.axis.model != var_0)
    level._createfx.axis setModel(var_0);
}

remove_axis_model() {
  if(!isDefined(level._createfx.axis)) {
    return;
  }
  level._createfx.axis delete();
}

draw_cross() {}

toggle_createfx_axis() {
  level._createfx.drawaxis++;

  if(level._createfx.drawaxis > 2)
    level._createfx.drawaxis = 0;

  if(level._createfx.drawaxis != 1)
    remove_axis_model();
}

createfx_centerprint(var_0) {
  thread createfx_centerprint_thread(var_0);
}

createfx_centerprint_thread(var_0) {
  level notify("_encstr_815719D5F53F971F526AAEC3AFF60B9E29E740EBCD3EF07A84485B");
  level endon("_encstr_815719D5F53F971F526AAEC3AFF60B9E29E740EBCD3EF07A84485B");
  wait 4.5;
}

get_selected_move_vector() {
  var_0 = level.player getplayerangles()[1];
  var_1 = (0, var_0, 0);
  var_2 = anglestoright(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = 0;
  var_6 = level._createfx.rate;

  if(buttondown("_encstr_AF510B6D83F5AEE0C2C993F677", "_encstr_9AB208E598CF456F83D9")) {
    if(level.selectedmove_forward < 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward + var_6;
  } else if(buttondown("_encstr_AD840DDC0340B1A8D3EBFFDBB51A5F", "_encstr_9AD00ABF8733F0E735B997EB")) {
    if(level.selectedmove_forward > 0)
      level.selectedmove_forward = 0;

    level.selectedmove_forward = level.selectedmove_forward - var_6;
  } else
    level.selectedmove_forward = 0;

  if(buttondown("_encstr_8CDF0EF423D15AB2ACC9C38FE5CE1A97", "_encstr_A6270B22288288FA4929A309A8")) {
    if(level.selectedmove_right < 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right + var_6;
  } else if(buttondown("_encstr_A6640D9B1109ED6FCC8B1A335390EF", "_encstr_95110AD1296829B18B3FC473")) {
    if(level.selectedmove_right > 0)
      level.selectedmove_right = 0;

    level.selectedmove_right = level.selectedmove_right - var_6;
  } else
    level.selectedmove_right = 0;

  if(buttondown("_encstr_91D609E97F4BE94F26CF53")) {
    if(level.selectedmove_up < 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up + var_6;
  } else if(buttondown("_encstr_81D60948AAA22AF4E47D12")) {
    if(level.selectedmove_up > 0)
      level.selectedmove_up = 0;

    level.selectedmove_up = level.selectedmove_up - var_6;
  } else
    level.selectedmove_up = 0;

  var_7 = (0, 0, 0);
  var_7 = var_7 + var_3 * level.selectedmove_forward;
  var_7 = var_7 + var_2 * level.selectedmove_right;
  var_7 = var_7 + var_4 * level.selectedmove_up;
  return var_7;
}

set_anglemod_move_vector() {
  var_0 = level._createfx.rate;
  var_1 = level._createfx.snap2anglesnaps[level._createfx.snap2angle];

  if(var_1 != 0)
    var_0 = 0;

  if(buttondown("_encstr_AF510B6D83F5AEE0C2C993F677", "_encstr_9AB208E598CF456F83D9")) {
    if(level.selectedrotate_pitch < 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch + var_1 + var_0;
  } else if(buttondown("_encstr_AD840DDC0340B1A8D3EBFFDBB51A5F", "_encstr_9AD00ABF8733F0E735B997EB")) {
    if(level.selectedrotate_pitch > 0)
      level.selectedrotate_pitch = 0;

    level.selectedrotate_pitch = level.selectedrotate_pitch - var_1 - var_0;
  } else
    level.selectedrotate_pitch = 0;

  if(buttondown("_encstr_A6640D9B1109ED6FCC8B1A335390EF", "_encstr_95110AD1296829B18B3FC473")) {
    if(level.selectedrotate_yaw < 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw + var_1 + var_0;
  } else if(buttondown("_encstr_8CDF0EF423D15AB2ACC9C38FE5CE1A97", "_encstr_A6270B22288288FA4929A309A8")) {
    if(level.selectedrotate_yaw > 0)
      level.selectedrotate_yaw = 0;

    level.selectedrotate_yaw = level.selectedrotate_yaw - var_1 - var_0;
  } else
    level.selectedrotate_yaw = 0;

  if(buttondown("_encstr_91D609E97F4BE94F26CF53")) {
    if(level.selectedrotate_roll < 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll + var_1 + var_0;
  } else if(buttondown("_encstr_81D60948AAA22AF4E47D12")) {
    if(level.selectedrotate_roll > 0)
      level.selectedrotate_roll = 0;

    level.selectedrotate_roll = level.selectedrotate_roll - var_1 - var_0;
  } else
    level.selectedrotate_roll = 0;
}

update_selected_entities() {
  var_0 = 0;

  foreach(var_2 in level._createfx.selected_fx_ents) {
    if(var_2.v["_encstr_81EF05D197C12B"] == "_encstr_82510C0E3347CF308B935DA7A8D8")
      var_0 = 1;

    var_2[[level.func_updatefx]]();
  }

  if(var_0)
    refresh_reactive_fx_ents();
}

stop_fx_looper() {
  if(isDefined(self.looper))
    self.looper delete();

  stop_loopsound();
}

stop_loopsound() {
  self notify("_encstr_8B2D0AD00B95B1BEEB0FD057");
}

func_get_level_fx() {
  if(!isDefined(level._effect_keys))
    var_0 = getarraykeys(level._effect);
  else {
    var_0 = getarraykeys(level._effect);

    if(var_0.size == level._effect_keys.size)
      return level._effect_keys;
  }

  var_0 = scripts\engine\utility::alphabetize(var_0);
  level._effect_keys = var_0;
  return var_0;
}

restart_fx_looper() {
  stop_fx_looper();
  set_forward_and_up_vectors();

  switch (self.v["_encstr_81EF05D197C12B"]) {
    case "_encstr_B6480A92880DD02267293B7B":
      scripts\common\fx::create_triggerfx();
      break;
    case "_encstr_BE7F073BF060E0F269":
      scripts\common\fx::create_looper();
      break;
    case "_encstr_A35408BE67DFC0D98F9B":
      scripts\common\fx::create_loopsound();
      break;
    case "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1":
      scripts\common\fx::create_interval_sound();
      break;
  }
}

refresh_reactive_fx_ents() {
  level._fx.reactive_fx_ents = undefined;

  foreach(var_1 in level.createfxent) {
    if(var_1.v["_encstr_81EF05D197C12B"] == "_encstr_82510C0E3347CF308B935DA7A8D8") {
      var_1 set_forward_and_up_vectors();
      var_1 scripts\common\fx::add_reactive_fx();
    }
  }
}

process_fx_rotater() {
  if(level.fx_rotating) {
    return;
  }
  set_anglemod_move_vector();

  if(!rotation_is_occuring()) {
    return;
  }
  level.fx_rotating = 1;

  if(level._createfx.selected_fx_ents.size > 1) {
    var_0 = get_center_of_array(level._createfx.selected_fx_ents);
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
    var_1.v["_encstr_A7610758E6CED8569B"] = level._createfx.selected_fx_ents[0].v["_encstr_A7610758E6CED8569B"];
    var_1.v["_encstr_97FE07DE392D76D2CD"] = var_0;
    var_2 = [];

    for(var_3 = 0; var_3 < level._createfx.selected_fx_ents.size; var_3++) {
      var_2[var_3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level._createfx.selected_fx_ents[var_3].v["_encstr_97FE07DE392D76D2CD"]);
      var_2[var_3].angles = level._createfx.selected_fx_ents[var_3].v["_encstr_A7610758E6CED8569B"];
      var_2[var_3] linkTo(var_1);
    }

    rotate_over_time(var_1, var_2);
    var_1 delete();

    for(var_3 = 0; var_3 < var_2.size; var_3++)
      var_2[var_3] delete();
  } else if(level._createfx.selected_fx_ents.size == 1) {
    var_4 = level._createfx.selected_fx_ents[0];
    var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_2.angles = var_4.v["_encstr_A7610758E6CED8569B"];

    if(level.selectedrotate_pitch != 0)
      var_2 addpitch(level.selectedrotate_pitch);
    else if(level.selectedrotate_yaw != 0)
      var_2 addyaw(level.selectedrotate_yaw);
    else
      var_2 addroll(level.selectedrotate_roll);

    var_4.v["_encstr_A7610758E6CED8569B"] = var_2.angles;
    var_2 delete();
    waitframe();
  }

  level.fx_rotating = 0;
}

spawn_grenade() {
  playFX(level._createfx.grenade.fx, level.createfxcursor["_encstr_BD260953AA97E3F014279D"]);
  level._createfx.grenade playSound(level._createfx.grenade.sound);
  radiusdamage(level.createfxcursor["_encstr_BD260953AA97E3F014279D"], level._createfx.grenade.radius, 50, 5, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  level notify("_encstr_AFB012367B8CACBEC8C26BB03B95C9C23296AEDC", undefined, level._createfx.grenade.radius, level.createfxcursor["_encstr_BD260953AA97E3F014279D"]);
}

show_help() {
  clear_fx_hudelements();
  set_fx_hudelement("_encstr_8246067CBD39B82A");
  set_fx_hudelement("_encstr_BEFC1E5BA61AE8866BB6A9A19E12977A664011D35EC220CE33CE1950C3CF75F8");
  set_fx_hudelement("_encstr_8E843538FAB9FE72E9F7C0F8DFC13AA6E1928630F08F22AA7B4D84B50613177F092BEAAB8041DCF7530784A78FFBEB47B1F8B39298DDD7");
  set_fx_hudelement("_encstr_967C340502084004020808040208080404010414469180DE078E2DF6B9081DED108E0D5680DC2BB12B6CA3569140B2E6A3A547D2B2DC");
  set_fx_hudelement("_encstr_8EAC3C99183E323FAA2619110E82E7EAD6F08115C552505DD27B28A1F61308A3DE1C9BF766EEB8ACFA1320A9DE7F35387763396B143620E073FABBD09247");
  set_fx_hudelement("_encstr_87EE59FBA2A188AEF1A7B6CEDF99E6D0F90A9A274043197661ABEFC657DD6A54F9E8122B4018753E89B3F7DE49F763F4A9489FB74050A4C2CB7F7A87219BBABCA960025BC041E72AF9E096BE19A1C663F1C86FC73841249625031D");
  set_fx_hudelement("_encstr_8FB12B22CAD8ACE859084040101010081002809696C68D01A343B2049BB236CA368EB2C81056E6E82DD12DB2CD");
  set_fx_hudelement("_encstr_BA5749A24DD02882A808800202104004408080A10BDC1B59B101B757D180ED3340F683D14BDBE65ADAB7465A335EB4D6F619AC16045B5DCDD140342CCE59048DDE9BE6F6362B04DBC159B9");
  set_fx_hudelement("_encstr_A99715C61CA3E02BA67E828A9696E9B142F0CF4E6FD30A");
  set_fx_hudelement("_encstr_A97A16A7430A3045C99E568E7F89F9B9921939E0CA2E40CA");
  set_fx_hudelement("_encstr_BA1335CD8A280A1F169A6169B23E57524066790745D7F8E1BA82DFD5DF7245B0DEC8F199ED2C7A2F227B51D1F70B8DE274A24173946E08");
  set_fx_hudelement("_encstr_A5BC205F256AA09E168888F191F1EFDEA9721211604BD137779B17D02A880B6F12F3");
  set_fx_hudelement("_encstr_BA09429F8380EC866F39F2EA21474E6032211E551850B5BE1E5BCBF78F15429CDA110563709871C37DE93FE3712B2EE982B8BAFE8BE8143ACD0B0A93CBE5926852C2F6B3");
  set_fx_hudelement("_encstr_8C753B6E39284D7315F79B9A5117FED0E2D1CEA348A8E7AAE501FBB333CFF3CDE8C196332090A6A6C895B2DB31058E03984B4AFFB8E0308A90999FD33B");
  set_fx_hudelement("_encstr_A3A72C160489AB3AA3BDCD80080102024008802AEDB33BD8CA40CA9BA35AD1BC109CBDD1583A4BB7B902D6EDC8CA");
  set_fx_hudelement("_encstr_A748384951134BCB25C8CA363957D2566A39A8D5770897624EA1E26A39551FBFC22B6E5493C0DF67DF5B1B4680AE427260A119DC130AA2CF9150");
  set_fx_hudelement("_encstr_B1303AA0D78ACB2B83980822F960EE385A812A2497F33BD7D2EB0B0846332B49CF9128539B0BC7D361FD879BB5A7C8803FDBB7B8AF654897CB87944D");
  set_fx_hudelement("_encstr_8C61352540351AB7AE3632569C080880010108A9DEEC5640E65663ACD8472BC8402BDCD12D3AD2956E40D1DB08D10DAC40B1BA4E37F6C9");
  set_fx_hudelement("_encstr_ADB930415AE9EB989DF579519A301A3736C211F1CF42A5AAB40DE96B475478DECB2A1303BB6BFBF0F4E7E1A1AD14C08DB2DF");
  set_fx_hudelement("_encstr_AF2415593EAC9F6A473CE3EE03F279C99EA6B2D922FA0B");
  set_fx_hudelement("_encstr_B88016497EE345214E12778BA2213E06F679F9596FD3C54F");
  set_fx_hudelement("_encstr_BD891439084004021001100104084040101008AA19D3");
  set_fx_hudelement("_encstr_85CB26ADA80A89D19E9EA2AAB6B689D162D0EF254FAFA981378639F81ABFE771BF34C587FEDF9789");
  set_fx_hudelement("_encstr_86F82665800208018001018010084001020201A8DE9DD9B12B10A2A5D6CA9BD82C362B01D426D3BA");
  set_fx_hudelement("_encstr_A3DA25B5100440400240040402400101108001A2DE3B761B2B10328501B296E64BC496C6B4D197");
  set_fx_hudelement("_encstr_B6EA2071A1B72AA6B2F9E0E891DAEE72EF091E69D0FCFF6DA0E1EBB837B80BF3E31B");
  set_fx_hudelement("_encstr_997122ED2FAAF8FA213AC26972592982387A98519FE717487B9E159196F9D5C72C195053");
}

generate_fx_log(var_0) {}

write_log(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_844C0242";
  cfxprintlnstart();
  cfxprintln("_encstr_A5DA26F2CBD7369C2BB0D12B991E04ECB273B2C9C24795465C01887B10DCDE1D0447F6AB6C1A2442");
  cfxprintln("_encstr_8C872153DBA0E77D8B78024ED8FFB2871B3D8BB465082FC45558991388C3ED7F3323BB");
  cfxprintln("_encstr_B2C6213990DD9388FB93555173037BA333E38EBBF35D1AA8EF88E9D54B1480C46B9B32");
  cfxprintln("_encstr_AF822391B4B96CD8D532B201CDB1E4D2833ADC8B36DBDA6BF6B9716C9C59853A59CCF0D928");
  cfxprintln("_encstr_B40101");
  cfxprintln("_encstr_A273076BB05ACDA025");
  cfxprintln("_encstr_884C02BD");
  cfxprintln(var_4 + "_encstr_9BFF0D56FEAE064D4F29AB68512B08" + var_1 + "_encstr_AA3D1304CAB98E2D3AB4B26E041C63851BB2237440" + var_0.size);

  foreach(var_6 in var_0) {
    if(level.createfx_loopcounter > 16) {
      level.createfx_loopcounter = 0;
      wait 0.1;
    }

    level.createfx_loopcounter++;

    if(getdvarint("_encstr_AF4016AE3BEAC9A98949F93891132397E1125B015050F15B")) {
      if(!isDefined(var_6.model))
        continue;
    } else if(isDefined(var_6.model)) {
      continue;
    }
    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_B6480A92880DD02267293B7B")
      cfxprintln(var_4 + "_encstr_B16F1D27B0D858A77FAFABCF937D6A7F50B9DAEC087085CAA44BE783690F26" + var_6.v["_encstr_95780526F31FA7"] + "_encstr_A784058808A4B3");

    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_BE7F073BF060E0F269")
      cfxprintln(var_4 + "_encstr_97221ABD7E9BB9EFF8F763C716318975E8C8C025206EB817F06A4A3A" + var_6.v["_encstr_95780526F31FA7"] + "_encstr_A784058808A4B3");

    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_A63B09CA3CE01B7B8C2B27") {
      if(isDefined(var_6.v["_encstr_A63B09CA3CE01B7B8C2B27"]) && !level.mp_createfx)
        cfxprintln(var_4 + "_encstr_AFE91A2BE64740D3401B932B853ACA151E38C6DB4656938AF0A01044" + var_6.v["_encstr_95780526F31FA7"] + "_encstr_8E8405DE9AB97E" + var_6.v["_encstr_A63B09CA3CE01B7B8C2B27"] + "_encstr_A784058808A4B3");
      else
        cfxprintln(var_4 + "_encstr_B20F186BD83416718910439D17FDADF07A9BF49F28316B9BD946" + var_6.v["_encstr_95780526F31FA7"] + "_encstr_A784058808A4B3");
    }

    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_A35408BE67DFC0D98F9B")
      cfxprintln(var_4 + "_encstr_B451198F1870F01FD70773276BA5C2C47B80429AD0807642FB8B2E");

    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1")
      cfxprintln(var_4 + "_encstr_99D61DC53D55D28189E33BDD2A8BF5CFD0D8BDC6F3DF5186B223581B304EB7");

    if(var_6.v["_encstr_81EF05D197C12B"] == "_encstr_82510C0E3347CF308B935DA7A8D8") {
      if(var_1 == "_encstr_840703F23B" && var_6.v["_encstr_95780526F31FA7"] != "_encstr_A67306780FE2ADD9" && !level.mp_createfx)
        cfxprintln(var_4 + "_encstr_AD691B59E63A017A013693AC5847CA25952C8D8E2D9DCA519B470A0288" + var_6.v["_encstr_95780526F31FA7"] + "_encstr_A784058808A4B3");
      else if(var_1 == "_encstr_8260069BDBBACD46" && var_6.v["_encstr_95780526F31FA7"] == "_encstr_A67306780FE2ADD9")
        cfxprintln(var_4 + "_encstr_A7691B95CD1D10A74036C95985A3594A2B16B1A39667AC2A733A0549B3");
      else
        continue;
    }

    cfxprintln(var_4 + "_encstr_87D01C95B9E80137AC8ED7B793D276D237AF16738CBE85CDCEC6959B4140" + var_6.v["_encstr_97FE07DE392D76D2CD"] + "_encstr_BE0703F5EF" + var_6.v["_encstr_A7610758E6CED8569B"] + "_encstr_B117040852EC");
    print_fx_options(var_6, var_4, var_2);
    cfxprintln("_encstr_B40101");
  }

  cfxprintln("_encstr_8A4C025F");
  cfxprintln("_encstr_974C0246");
  cfxprintlnend(var_2, var_3, var_1);
}

createfx_adjust_array() {
  var_0 = 0.1;

  foreach(var_2 in level.createfxent) {
    var_3 = [];
    var_4 = [];

    for(var_5 = 0; var_5 < 3; var_5++) {
      var_3[var_5] = var_2.v["_encstr_97FE07DE392D76D2CD"][var_5];
      var_4[var_5] = var_2.v["_encstr_A7610758E6CED8569B"][var_5];

      if(var_3[var_5] < var_0 && var_3[var_5] > var_0 * -1)
        var_3[var_5] = 0;

      if(var_4[var_5] < var_0 && var_4[var_5] > var_0 * -1)
        var_4[var_5] = 0;
    }

    var_2.v["_encstr_97FE07DE392D76D2CD"] = (var_3[0], var_3[1], var_3[2]);
    var_2.v["_encstr_A7610758E6CED8569B"] = (var_4[0], var_4[1], var_4[2]);
  }
}

get_createfx_array(var_0) {
  var_1 = get_createfx_types(var_0);
  var_2 = [];

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = [];

  foreach(var_7 in level.createfxent) {
    var_8 = 0;

    foreach(var_5, var_0 in var_1) {
      if(var_7.v["_encstr_81EF05D197C12B"] != var_0) {
        continue;
      }
      var_8 = 1;
      var_2[var_5][var_2[var_5].size] = var_7;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_1.size; var_12++) {
    foreach(var_7 in var_2[var_12])
    var_11[var_11.size] = var_7;
  }

  return var_11;
}

get_createfx_types(var_0) {
  var_1 = [];

  if(var_0 == "_encstr_840703F23B") {
    var_1[0] = "_encstr_B6480A92880DD02267293B7B";
    var_1[1] = "_encstr_BE7F073BF060E0F269";
    var_1[2] = "_encstr_A63B09CA3CE01B7B8C2B27";
    var_1[3] = "_encstr_82510C0E3347CF308B935DA7A8D8";
  } else {
    var_1[0] = "_encstr_A35408BE67DFC0D98F9B";
    var_1[1] = "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1";
    var_1[2] = "_encstr_82510C0E3347CF308B935DA7A8D8";
  }

  return var_1;
}

check_reactive_fx_type(var_0, var_1) {
  if(var_0.v["_encstr_95780526F31FA7"] != "_encstr_A67306780FE2ADD9" && var_1 == "_encstr_840703F23B")
    return 1;

  if(var_0.v["_encstr_95780526F31FA7"] == "_encstr_A67306780FE2ADD9" && var_1 == "_encstr_8260069BDBBACD46")
    return 1;

  return 0;
}

is_createfx_type(var_0, var_1) {
  var_2 = get_createfx_types(var_1);

  if(var_0.v["_encstr_81EF05D197C12B"] == "_encstr_82510C0E3347CF308B935DA7A8D8") {
    if(check_reactive_fx_type(var_0, var_1))
      return 1;
    else
      return 0;
  }

  foreach(var_4 in var_2) {
    if(var_0.v["_encstr_81EF05D197C12B"] == var_4)
      return 1;
  }

  return 0;
}

createfx_filter_types() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_A35408BE67DFC0D98F9B";
  var_0[var_0.size] = "_encstr_B6480A92880DD02267293B7B";
  var_0[var_0.size] = "_encstr_A63B09CA3CE01B7B8C2B27";
  var_0[var_0.size] = "_encstr_8D4D11CDBD5DE64666C3AFD29B1DB24E3B2CB1";
  var_0[var_0.size] = "_encstr_82510C0E3347CF308B935DA7A8D8";

  if(!level.mp_createfx)
    var_0[var_0.size] = "_encstr_BE7F073BF060E0F269";

  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_4] = [];

  foreach(var_6 in level.createfxent) {
    var_7 = 0;

    foreach(var_4, var_9 in var_0) {
      if(var_6.v["_encstr_81EF05D197C12B"] != var_9) {
        continue;
      }
      var_7 = 1;
      var_1[var_4][var_1[var_4].size] = var_6;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_0.size; var_12++) {
    foreach(var_6 in var_1[var_12])
    var_11[var_11.size] = var_6;
  }

  level.createfxent = var_11;
}

cfxprintlnstart() {
  scripts\engine\utility:: fileprint_launcher_start_file();
}

cfxprintln(var_0) {
  scripts\engine\utility:: fileprint_launcher( var_0 );
}

cfxprintlnend(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_1 != "_encstr_B40101" || var_0)
    var_3 = 0;

  if(scripts\common\utility::issp()) {
    var_4 = level.script + var_1 + "_encstr_BA4C02DF" + var_2 + "_encstr_8CA70556203B01";

    if(var_0)
      var_4 = "_encstr_B2F508C9DEEBD03593E7" + var_2 + "_encstr_8CA70556203B01";
  } else {
    var_4 = level.script + var_1 + "_encstr_BA4C02DF" + var_2 + "_encstr_8CA70556203B01";

    if(var_0)
      var_4 = "_encstr_B29B0B50C72350D333A594A6CE";
  }

  var_5 = get_raw_or_devraw_subdir();
  var_6 = get_gamemode_subdir();
  scripts\engine\utility:: fileprint_launcher_end_file( "_encstr_AF32089F16A02F3A6BE2" + var_5 + "_encstr_8D6E0A1ACBAED64C0ABB2B8E" + var_6 + "_encstr_93C3077D017BBBB320" + level.script + "_encstr_B41206EAE2CF4578" + var_4, var_3 );
}

get_raw_or_devraw_subdir() {
  if(isDefined(level.createfx_devraw_map) && level.createfx_devraw_map)
    return "_encstr_A39007AB87763B313B";
  else
    return "_encstr_8419044EB0BB";
}

get_gamemode_subdir() {
  if(scripts\common\utility::iscp())
    return "_encstr_850703B7D9";
  else if(scripts\common\utility::issp())
    return "_encstr_8B07036EC1";
  else
    return "_encstr_8C07031599";
}

process_button_held_and_clicked() {
  add_button("_encstr_99A907CD283357CFF3");
  add_button("_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471");
  add_button("_encstr_BE700E48AAA2A8F472F598A642C42294");
  add_button("_encstr_B1550ECD1F09652916892F0763C99132");
  add_button("_encstr_B6C90E84AAA82A3D9CF56235A8290D2D");
  add_button("_encstr_87D60912AA4545F493D728");
  add_button("_encstr_81D60948AAA22AF4E47D12");
  add_button("_encstr_ACD6096A8DAF73CD85E989");
  add_button("_encstr_91D609E97F4BE94F26CF53");
  add_button("_encstr_9AB208E598CF456F83D9");
  add_button("_encstr_95110AD1296829B18B3FC473");
  add_button("_encstr_A6270B22288288FA4929A309A8");
  add_button("_encstr_9AD00ABF8733F0E735B997EB");
  add_kb_button("_encstr_B8D9071C678074D789");
  add_kb_button("_encstr_AC810768CBE4D3C9DB");
  add_kb_button("_encstr_92DA066A207B669C");
  add_kb_button("_encstr_992206E4D8D19C1B");
  add_kb_button("_encstr_B84407FD927A8B4B25");
  add_kb_button("_encstr_8607038D31");
  add_kb_button("_encstr_9A070391A9");
  add_kb_button("_encstr_8C07033E11");
  add_kb_button("_encstr_AF0703FDBA");
  add_kb_button("_encstr_994C023A");
  add_kb_button("_encstr_934C02B2");
  add_kb_button("_encstr_A74C0277");
  add_kb_button("_encstr_834C02D8");
  add_kb_button("_encstr_8C4C025A");
  add_kb_button("_encstr_9A4C0229");
  add_kb_button("_encstr_A94C02B6");
  add_kb_button("_encstr_A54C0259");
  add_kb_button("_encstr_864C0253");
  add_kb_button("_encstr_A64C0223");
  add_kb_button("_encstr_844C029C");
  add_kb_button("_encstr_B24C02EF");
  add_kb_button("_encstr_B14C02D5");
  add_kb_button("_encstr_B44C022E");
  add_kb_button("_encstr_814C02A2");
  add_kb_button("_encstr_964C02E5");
  add_kb_button("_encstr_8218041D77EA");
  add_kb_button("_encstr_961804BD954A");
  add_kb_button("_encstr_A9190429A126");
  add_kb_button("_encstr_B81904B4CD9B");
  add_kb_button("_encstr_931904467462");
  add_kb_button("_encstr_AF8A061B6A1960CD");
  add_kb_button("_encstr_99BF0603D0C4979A");
  add_kb_button("_encstr_A34C02BB");
  add_kb_button("_encstr_A74C0222");
  add_kb_button("_encstr_A14C023B");
  add_kb_button("_encstr_AC4C024A");
  add_kb_button("_encstr_B84C027E");
  add_kb_button("_encstr_8F4C026A");
  add_kb_button("_encstr_914C02DC");
  add_kb_button("_encstr_864C02F9");
  add_kb_button("_encstr_8B4C0227");
  add_kb_button("_encstr_934C0218");
  add_kb_button("_encstr_884C0296");
  add_kb_button("_encstr_AB4C0246");
  add_kb_button("_encstr_964C0249");
  add_kb_button("_encstr_BD4C024E");
  add_kb_button("_encstr_B44C0203");
  add_kb_button("_encstr_8C4C0209");
  add_kb_button("_encstr_A95C0A1BB2CC8EC22793DBDD");
  add_kb_button("_encstr_A63C0B736427437D5A9BBDBFB7");
  add_kb_button("_encstr_9A82081B7111F3F6E7B7");
  add_kb_button("_encstr_AC120ADC67BB2547FE8322AB");
}

locked(var_0) {
  if(isDefined(level._createfx.lockedlist[var_0]))
    return 0;

  return kb_locked(var_0);
}

kb_locked(var_0) {
  return level.createfx_inputlocked && isDefined(level.button_is_kb[var_0]);
}

add_button(var_0) {
  if(locked(var_0)) {
    return;
  }
  if(!isDefined(level.buttonisheld[var_0])) {
    if(level.player buttonPressed(var_0)) {
      level.buttonisheld[var_0] = 1;
      level.buttonclick[var_0] = 1;
    }
  } else if(!level.player buttonPressed(var_0))
    level.buttonisheld[var_0] = undefined;
}

add_kb_button(var_0) {
  level.button_is_kb[var_0] = 1;
  add_button(var_0);
}

buttondown(var_0, var_1) {
  return buttonpressed_internal(var_0) || buttonpressed_internal(var_1);
}

buttonpressed_internal(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(kb_locked(var_0))
    return 0;

  return level.player buttonPressed(var_0);
}

button_is_held(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(level.buttonisheld[var_2]))
      return 1;
  }

  if(isDefined(var_1)) {
    if(isDefined(level.buttonisheld[var_1]))
      return 1;
  }

  return isDefined(level.buttonisheld[var_0]);
}

button_is_clicked(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(level.buttonclick[var_2]))
      return 1;
  }

  if(isDefined(var_1)) {
    if(isDefined(level.buttonclick[var_1]))
      return 1;
  }

  return isDefined(level.buttonclick[var_0]);
}

init_huds() {
  level._createfx.hudelems = [];
  level._createfx.hudelem_count = 30;

  if(level.mp_createfx)
    level._createfx.hudelem_count = 16;

  var_0 = [];
  var_1 = [];
  var_0[0] = 0;
  var_1[0] = 0;
  var_0[1] = 1;
  var_1[1] = 1;
  var_0[2] = -2;
  var_1[2] = 1;
  var_0[3] = 1;
  var_1[3] = -1;
  var_0[4] = -2;
  var_1[4] = -1;
  level.cleartextmarker = newhudelem();
  level.cleartextmarker.alpha = 0;
  level.cleartextmarker.archived = 0;

  for(var_2 = 0; var_2 < level._createfx.hudelem_count; var_2++) {
    var_3 = [];

    for(var_4 = 0; var_4 < 1; var_4++) {
      var_5 = newhudelem();
      var_5.alignx = "_encstr_A5AD056A019C63";
      var_5.archived = 0;
      var_5.location = 0;
      var_5.foreground = 1;
      var_5.fontscale = 1.4;
      var_5.sort = 20 - var_4;
      var_5.alpha = 1;
      var_5.x = 0 + var_0[var_4];
      var_5.y = 60 + var_1[var_4] + var_2 * 15;

      if(var_4 > 0)
        var_5.color = (0, 0, 0);

      var_3[var_3.size] = var_5;
    }

    level._createfx.hudelems[var_2] = var_3;
  }

  var_6 = newhudelem();
  var_6.archived = 0;
  var_6.alignx = "_encstr_A5C407E1658D3339B3";
  var_6.location = 0;
  var_6.foreground = 1;
  var_6.fontscale = 1.4;
  var_6.sort = 20;
  var_6.alpha = 1;
  var_6.x = 320;
  var_6.y = 40;
  level.createfx_centerprint = var_6;
}

init_crosshair() {
  var_0 = newhudelem();
  var_0.archived = 0;
  var_0.location = 0;
  var_0.alignx = "_encstr_A5C407E1658D3339B3";
  var_0.aligny = "_encstr_8F8D07BB035BDAD5CD";
  var_0.foreground = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 1;
  var_0.x = 320;
  var_0.y = 233;
}

clear_fx_hudelements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(var_0 = 0; var_0 < level._createfx.hudelem_count; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++) {}
  }

  level.fxhudelements = 0;
}

set_fx_hudelement(var_0) {
  for(var_1 = 0; var_1 < 1; var_1++) {}

  level.fxhudelements++;
}

init_tool_hud() {
  if(!isDefined(level._createfx.tool_hudelems))
    level._createfx.tool_hudelems = [];

  if(!isDefined(level._createfx.tool_hud_visible))
    level._createfx.tool_hud_visible = 1;

  if(!isDefined(level._createfx.tool_hud))
    level._createfx.tool_hud = "_encstr_B40101";
}

new_tool_hud(var_0) {
  foreach(var_3, var_2 in level._createfx.tool_hudelems) {
    if(isDefined(var_2.value_hudelem))
      var_2.value_hudelem destroy();

    var_2 destroy();
    level._createfx.tool_hudelems[var_3] = undefined;
  }

  level._createfx.tool_hud = var_0;
}

current_mode_hud(var_0) {
  return level._createfx.tool_hud == var_0;
}

clear_tool_hud() {
  new_tool_hud("_encstr_B40101");
}

new_tool_hudelem(var_0) {
  var_1 = newhudelem();
  var_1.archived = 0;
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.location = 0;
  var_1.foreground = 1;
  var_1.fontscale = 1.2;
  var_1.alpha = 1;
  var_1.x = 0;
  var_1.y = 320 + var_0 * 15;
  return var_1;
}

get_tool_hudelem(var_0) {
  if(isDefined(level._createfx.tool_hudelems[var_0]))
    return level._createfx.tool_hudelems[var_0];

  return undefined;
}

set_tool_hudelem(var_0, var_1) {
  if(level.mp_createfx) {
    return;
  }
  var_2 = get_tool_hudelem(var_0);

  if(!isDefined(var_2)) {
    var_2 = new_tool_hudelem(level._createfx.tool_hudelems.size);
    level._createfx.tool_hudelems[var_0] = var_2;
    var_2.text = var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_2.value_hudelem))
      var_3 = var_2.value_hudelem;
    else {
      var_3 = new_tool_hudelem(level._createfx.tool_hudelems.size);
      var_3.x = var_3.x + 100;
      var_3.y = var_2.y;
      var_2.value_hudelem = var_3;
    }

    if(isDefined(var_3.text) && var_3.text == var_1) {
      return;
    }
    var_3.text = var_1;
  }
}

select_by_substring() {
  var_0 = getDvar("_encstr_991314DE03FAC52391802E087EEFF5BB5365820B3067");

  if(var_0 == "_encstr_B40101")
    return 0;

  setDvar("_encstr_991314DE03FAC52391802E087EEFF5BB5365820B3067", "_encstr_B40101");
  var_1 = [];

  foreach(var_4, var_3 in level.createfxent) {
    if(issubstr(var_3.v["_encstr_95780526F31FA7"], var_0))
      var_1[var_1.size] = var_4;
  }

  if(var_1.size == 0)
    return 0;

  deselect_all_ents();
  select_index_array(var_1);

  foreach(var_6 in var_1) {
    var_3 = level.createfxent[var_6];
    select_entity(var_6, var_3);
  }

  return 1;
}

select_index_array(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level.createfxent[var_2];
    select_entity(var_2, var_3);
  }
}

deselect_all_ents() {
  foreach(var_2, var_1 in level._createfx.selected_fx_ents)
  deselect_entity(var_2, var_1);
}