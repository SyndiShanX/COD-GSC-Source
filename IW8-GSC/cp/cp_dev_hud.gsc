/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_dev_hud.gsc
***********************************************/

init_dev_hud() {
  if(istrue(level.dev_debug_menus)) {
    return;
  }
  level.dev_debug_menus = 1;
  level.hudelems = [];
  level.hudelem_count = 16;
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

  for(var_2 = 0; var_2 < level.hudelem_count; var_2++) {
    var_3 = [];

    for(var_4 = 0; var_4 < 1; var_4++) {
      var_5 = newhudelem();
      var_5.alignx = "_encstr_A5AD056A019C63";
      var_5.aligny = "_encstr_8F8D07BB035BDAD5CD";
      var_5.archived = 0;
      var_5.location = 0;
      var_5.foreground = 1;
      var_5.fontscale = 0.75;
      var_5.sort = 20 - var_4;
      var_5.alpha = 1;
      var_5.x = -70 + var_0[var_4];
      var_5.y = 30 + var_1[var_4] + var_2 * 10;

      if(var_4 > 0)
        var_5.color = (0, 0, 0);

      var_3[var_3.size] = var_5;
    }

    level.hudelems[var_2] = var_3;
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
  level.centerprint = var_6;
}

highlight_current_selection(var_0, var_1) {
  var_0 notify("_encstr_A1C61C24103B50F29BE783CBAFB6AB8270795DAB4E08E5AAE587FBB727E8");
  var_0 endon("_encstr_A1C61C24103B50F29BE783CBAFB6AB8270795DAB4E08E5AAE587FBB727E8");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.slot))
    level.slot = 0;

  if(!isDefined(level.slot_cap))
    level.slot_cap = 14;

  setDvar("_encstr_957C17339F73695A409DABFE87B2F8ED81A813308003DBE517", "_encstr_B40101");
  var_0 notifyonplayercommand("_encstr_8B4C0248", "_encstr_A6E308B2DCE8B0B936B2");
  var_0 notifyonplayercommand("_encstr_8D07038951", "_encstr_97120D65B983599519EB1D86C9B7EE");
  var_0 notifyonplayercommand("_encstr_994C0238", "_encstr_B44609DFE7078F394E1651");
  var_0 notifyonplayercommand("_encstr_814C02A6", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_814C02A6", "_encstr_B4C60AD707B2BDC0E6CE1309");
  var_0 notifyonplayercommand("_encstr_AB0703944D", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
  var_0 notifyonplayercommand("_encstr_AB0703134D", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
  var_0 notifyonplayercommand("_encstr_8F07035989", "_encstr_A9E60828803C73F11780");
  var_0 notifyonplayercommand("_encstr_B6070389A8", "_encstr_9B0D065699E485D9");
  var_0 notifyonplayercommand("_encstr_960703D1C1", "_encstr_8E5F0795E6AD7BAD2B");
  var_0 notifyonplayercommand("_encstr_AA4C0259", "_encstr_A6E60A229B175A3B48A543AB");
  var_0 notifyonplayercommand("_encstr_87070345E7", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  var_0 notifyonplayercommand("_encstr_9767057D2F3FAC", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  var_0 notifyonplayercommand("_encstr_A5AD0568058CE3", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  var_0 notifyonplayercommand("_encstr_8253061E6BDF6331", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  var_0 notifyonplayercommand("_encstr_B69B05098234B4", "_encstr_8D9D07AC99F68DD5E6");
  var_0 notifyonplayercommand("_encstr_99AD06F3B5B5D383", "_encstr_8CA706B310FB034F");
  level thread show_selection_menu(level.slot, var_1);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["_encstr_994C0238", "_encstr_8B4C0248", "_encstr_AA4C0259", "_encstr_814C02A6", "_encstr_960703D1C1", "_encstr_B6070389A8", "_encstr_8F07035989", "_encstr_8D07038951", "_encstr_AB0703944D", "_encstr_AB0703134D", "_encstr_87070345E7", "_encstr_9767057D2F3FAC", "_encstr_A5AD0568058CE3", "_encstr_8253061E6BDF6331", "_encstr_B69B05098234B4"]);

    if(!isDefined(var_2)) {
      continue;
    }
    switch (var_2) {
      case "_encstr_AA4C0259":
      case "_encstr_8B4C0248":
        clear_hud_elements();
        return;
      case "_encstr_994C0238":
        clear_hud_elements();
        return level.menu_current_selection;
      case "_encstr_9767057D2F3FAC":
        level.slot++;
        level.slot = scripts\engine\math::wrap(0, var_1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var_1);
        break;
      case "_encstr_87070345E7":
        level.slot--;
        level.slot = scripts\engine\math::wrap(0, var_1.size - 1, level.slot);
        thread show_selection_menu(level.slot, var_1);
        break;
      case "_encstr_8253061E6BDF6331":
        break;
      case "_encstr_A5AD0568058CE3":
        break;
    }
  }
}

show_selection_menu(var_0, var_1) {
  clear_hud_elements();
  var_2 = [];
  var_3 = clamp(var_1.size, 0, level.slot_cap);
  var_4 = var_1.size - 1;
  var_5 = scripts\engine\math::wrap(0, var_4, var_0);
  var_6 = var_1[var_5];
  var_7 = min(level.slot_cap, var_1.size);
  var_8 = int(var_7 / 2);
  var_9 = var_0 - var_8;
  var_9 = scripts\engine\math::wrap(0, var_4, var_9);

  for(var_10 = 0; var_10 < var_7; var_10++) {
    if(!isDefined(var_1[var_9])) {
      continue;
    }
    var_2[var_2.size] = var_1[var_9];
    var_9++;
    var_9 = scripts\engine\math::wrap(0, var_4, var_9);
  }

  for(var_10 = 0; var_10 < var_2.size; var_10++) {
    var_11 = var_2[var_10];

    if(var_10 == var_8) {
      level.menu_current_selection = var_11;
      var_11 = "_encstr_8C07035505" + var_11;
      var_12 = (1, 1, 0);
    } else
      var_12 = (1, 1, 1);

    set_hud_element(var_11, var_12);
  }
}

set_hud_element(var_0, var_1) {
  for(var_2 = 0; var_2 < 1; var_2++) {
    if(isDefined(var_1))
      level.hudelems[level.placementhudelements][var_2].color = var_1;
  }

  level.placementhudelements++;
}

clear_hud_elements() {
  level.cleartextmarker clearalltextafterhudelem();

  for(var_0 = 0; var_0 < level.hudelem_count; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++)
      level.hudelems[var_0][var_1].color = (1, 1, 1);
  }

  level.placementhudelements = 0;
}