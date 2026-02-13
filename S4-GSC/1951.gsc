/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1951.gsc
*************************************************/

_id_CF68() {
  var_0 = undefined;
  var_1 = "scripted_widgets_" + getDvar("#x376847958d67972ef");

  if(tablelookuprownum("scripted_widget_list_assets.csv", 0, var_1) != -1) {
    var_0 = _func_0393("scriptedwidgetslist:scripted_widgets_" + getDvar("#x376847958d67972ef"));
  }

  if(!isDefined(var_0) && isDefined(level.gametype)) {
    var_1 = "scripted_widgets_" + level.gametype;

    if(tablelookuprownum("scripted_widget_list_assets.csv", 0, var_1) != -1) {
      var_0 = _func_0393("scriptedwidgetslist:scripted_widgets_" + level.gametype);
    }
  }

  if(!isDefined(var_0)) {
    var_2 = "mp";

    if(scripts\common\utility::iscp()) {
      var_2 = "cp";
    } else if(scripts\common\utility::issp()) {
      var_2 = "sp";
    }

    var_1 = "scripted_widgets_" + var_2;

    if(tablelookuprownum("scripted_widget_list_assets.csv", 0, var_1) != -1) {
      var_0 = _func_0393("scriptedwidgetslist:scripted_widgets_" + var_2);
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_7B3E)) {
    level._id_7B3E = spawnStruct();
  }

  if(!isDefined(level._id_7B3E._id_CF67)) {
    level._id_7B3E._id_CF67 = spawnStruct();
  }

  var_3 = level._id_7B3E._id_CF67;
  var_3._id_9C44 = var_0.max_scripted_widgets;
  var_3._id_10E1A = [];
  var_3.anchor_types = [];
  var_3._id_1A3D = [];
  var_3.list_widget_data = spawnStruct();

  if(isDefined(var_0._id_1A3D)) {
    foreach(var_16, var_5 in var_0._id_1A3D) {
      var_6 = _func_0393("scriptedwidgetarchetype:" + var_5._id_1A35);

      if(isDefined(var_6)) {
        var_7 = tolower(var_5._id_1A35);
        var_3._id_1A3D[var_7] = [];
        var_8 = 0;

        foreach(var_10 in var_6.fields) {
          var_11 = tolower(var_10.field_name);
          var_12 = var_10._id_9C3C;
          var_13 = var_10._id_E838;
          var_12 = max(var_12, var_13);
          var_14 = int(_func_0037(_func_013F(var_12 / var_13 + 1) / _func_013F(2)));
          var_3._id_1A3D[var_7][var_11] = spawnStruct();
          var_3._id_1A3D[var_7][var_11]._id_2530 = var_14;
          var_3._id_1A3D[var_7][var_11]._id_9C3C = var_12;
          var_3._id_1A3D[var_7][var_11]._id_E838 = var_13;
          var_3._id_1A3D[var_7][var_11]._id_D9DD = var_8;
          var_8 = var_8 + var_14;
        }
      }
    }
  }

  if(isDefined(var_0.anchors)) {
    foreach(var_21, var_18 in var_0.anchors) {
      var_19 = _func_0393("scriptedwidgetanchorsettings:" + var_18._id_1772);

      if(isDefined(var_19)) {
        var_20 = tolower(var_18._id_1772);
        var_3.anchor_types[var_20] = var_21;
      }
    }
  }

  foreach(var_32, var_23 in var_0._id_CF67) {
    var_24 = _func_0393("scriptedwidget:" + var_23.scripted_widget);

    if(isDefined(var_24)) {
      var_25 = tolower(var_23.scripted_widget);
      var_3._id_10E1A[var_25] = spawnStruct();
      var_3._id_10E1A[var_25].index = var_32 + 1;

      if(isDefined(var_24._id_1A35)) {
        var_5 = _func_0393("scriptedwidgetarchetype:" + var_24._id_1A35);
        var_7 = tolower(var_24._id_1A35);

        if(isDefined(var_5) && isDefined(var_3._id_1A3D[var_7])) {
          var_3._id_10E1A[var_25]._id_1A35 = var_7;
        }
      }

      var_3._id_10E1A[var_25].parameters = [];

      if(isDefined(var_24.parameters)) {
        foreach(var_28, var_27 in var_24.parameters) {
          if(var_27.name != "") {
            var_3._id_10E1A[var_25].parameters[tolower(var_27.name)] = var_28;
          }
        }
      }

      var_3._id_10E1A[var_25]._id_E75E = [];

      if(isDefined(var_24._id_E75E)) {
        foreach(var_31, var_30 in var_24._id_E75E) {
          if(var_30.name != "") {
            var_3._id_10E1A[var_25]._id_E75E[tolower(var_30.name)] = var_31;
          }
        }
      }
    }
  }

  if(isDefined(var_0.max_scripted_list_items) && var_0.max_scripted_list_items > 0) {
    var_3.list_widget_data._id_9C26 = var_0.max_scripted_list_items;
    var_3.list_widget_data.num_groups = _func_0037(var_3.list_widget_data._id_9C26 / 15);
    var_3.list_widget_data.group_mask = 0;
    var_3.list_widget_data.group_shift = 0;

    if(var_3.list_widget_data.num_groups > 1) {
      var_3.list_widget_data.group_mask = 15;
      var_3.list_widget_data.group_shift = int(28);
    }
  }
}

_id_78B9(var_0, var_1) {
  if(!isDefined(level._id_7B3E)) {
    level._id_7B3E = spawnStruct();
  }

  if(!isDefined(level._id_7B3E._id_78E1)) {
    level._id_7B3E._id_78E1 = spawnStruct();
  }

  var_2 = level._id_7B3E._id_78E1;
  var_2._id_AA3E = var_0;
  var_2._id_10E1B = [];

  if(isDefined(var_1) && _func_0221(var_1)) {
    var_3 = tablelookupgetnumrows(var_1);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tablelookupbyrow(var_1, var_4, 0);

      if(var_5 != "") {
        var_2._id_10E1B[tolower(var_5)] = var_4;
      }
    }
  }
}

_id_78B8(var_0, var_1) {
  var_2 = level._id_7B3E._id_78E1;

  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    var_4 = tolower(var_4);
    var_1 = _id_0CFA(var_4, var_1);
    self _meth_82F8(var_2._id_AA3E, var_2._id_10E1B[var_4], var_1);
  }
}

_id_CF62(var_0, var_1, var_2) {
  var_3 = level._id_7B3E._id_CF67;
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);

  if(_id_CF64(var_0)) {
    return;
  }
  var_4 = _id_0CDC(var_0, var_1);

  if(isDefined(var_4)) {
    if(isDefined(var_2)) {
      if(isDefined(var_2._id_AE3F)) {
        _widget_set_omnvar(var_2._id_AE3F, "ui_scripted_widget_param_" + var_4, var_3._id_10E1A[var_1].parameters);
      }

      if(isDefined(var_2._id_4350)) {
        _widget_set_omnvar(var_2._id_4350, "ui_scripted_widget_data_" + var_4);
      }

      if(isDefined(var_2._id_E747)) {
        _widget_set_omnvar(var_2._id_E747, "ui_scripted_widget_state_" + var_4, var_3._id_10E1A[var_1]._id_E75E);
      }

      if(isDefined(var_2._id_BD27)) {
        _widget_set_omnvar(var_2._id_BD27, "ui_scripted_widget_priority_" + var_4);
      }

      if(isent(var_2._id_5469)) {
        scripted_widget_anchor_to_ent(var_0, var_2._id_5469, var_2.anchor_type);
      }

      if(isDefined(var_2._id_033E)) {
        scripted_widget_set_position(var_0, var_2._id_033E._id_0274, var_2._id_033E._id_0495, var_2._id_033E.horizontal_anchor, var_2._id_033E.vertical_anchor);
      }
    }

    self setclientomnvar("ui_scripted_widget_type_" + var_4, var_3._id_10E1A[var_1].index);
    thread _id_0CDA(var_0, var_4);
  } else {}
}

scripted_widget_get_param_property(var_0, var_1, var_2) {
  var_3 = _func_0393("scriptedwidget:" + var_0);
  var_4 = scripted_widget_get_param_index(var_0, var_1);

  if(isDefined(var_4)) {
    var_2 = tolower(var_2);

    foreach(var_6 in var_3.parameters[var_4].properties) {
      if(var_6.property == var_2) {
        return var_6._id_04CB;
      }
    }
  }

  return undefined;
}

scripted_widget_get_param_index(var_0, var_1) {
  var_1 = tolower(var_1);
  return level._id_7B3E._id_CF67._id_10E1A[var_0].parameters[var_1];
}

scripted_widget_set_param(var_0, var_1) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = level._id_7B3E._id_CF67;
  var_3 = self._id_0F2B[var_0];
  var_4 = "ui_scripted_widget_param_" + var_3.index;
  var_5 = var_2._id_10E1A[var_3._id_10E19].parameters;
  _widget_set_omnvar(var_1, var_4, var_5);
}

_id_CF65(var_0, var_1) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = level._id_7B3E._id_CF67;
  var_3 = self._id_0F2B[var_0];
  var_4 = "ui_scripted_widget_data_" + var_3.index;
  _widget_set_omnvar(var_1, var_4);
}

_id_CF66(var_0, var_1) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = level._id_7B3E._id_CF67;
  var_3 = self._id_0F2B[var_0];
  var_4 = "ui_scripted_widget_state_" + var_3.index;
  var_5 = var_2._id_10E1A[var_3._id_10E19]._id_E75E;
  _widget_set_omnvar(var_1, var_4, var_5);
}

scripted_widget_anchor_to_ent(var_0, var_1, var_2) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = tolower(var_2);
  var_3 = level._id_7B3E._id_CF67;

  if(!isDefined(self.scripted_widget_anchors)) {
    self.scripted_widget_anchors = [];
  }

  var_4 = var_1 getentitynumber();

  if(!isDefined(self.scripted_widget_anchors[var_4])) {
    self.scripted_widget_anchors[var_4] = [];
  }

  var_5 = self._id_0F2B[var_0];

  if(isDefined(var_5.ent_num)) {
    self.scripted_widget_anchors[var_5.ent_num][var_0] = undefined;

    if(self.scripted_widget_anchors[var_5.ent_num].size == 0) {
      self.scripted_widget_anchors[var_5.ent_num] = undefined;
      self notify("_automatic_remove_anchored_widget_" + var_5.ent_num);
    }
  }

  var_5.ent_num = var_4;
  self.scripted_widget_anchors[var_4][var_0] = var_5.index;
  var_6 = "ui_scripted_widget_ent_" + var_5.index;
  self setclientomnvar(var_6, var_1);
  _widget_set_omnvar(var_3.anchor_types[var_2], "ui_scripted_widget_position_" + var_5.index);
  thread _id_0B5F(var_1);
}

scripted_widget_set_position(var_0, var_1, var_2, var_3, var_4) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  switch (var_3) {
    case 0:
      var_1 = var_1 - -63;
      break;
    case 3:
    case 1:
      var_1 = var_1 - -1023;
      break;
    case 2:
      var_1 = var_1 + 1984;
      break;
  }

  switch (var_4) {
    case 0:
      var_2 = var_2 - -483;
      break;
    case 3:
    case 1:
      var_2 = var_2 - -1023;
      break;
    case 2:
      var_2 = var_2 + 1564;
      break;
  }

  var_5 = var_2 << 11;
  var_6 = var_3 << 22;
  var_7 = var_4 << 24;
  var_8 = var_1 + var_5 + var_6 + var_7;
  var_9 = level._id_7B3E._id_CF67;
  var_10 = self._id_0F2B[var_0];
  var_11 = "ui_scripted_widget_position_" + var_10.index;
  self setclientomnvar(var_11, var_8);
}

scripted_widget_set_priority(var_0, var_1) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = level._id_7B3E._id_CF67;
  var_3 = self._id_0F2B[var_0];
  var_4 = "ui_scripted_widget_priority_" + var_3.index;
  self setclientomnvar(var_4, var_1);
}

scripted_widget_archetype_set_field_values(var_0, var_1, var_2) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_3 = level._id_7B3E._id_CF67;
  var_4 = self._id_0F2B[var_0];
  var_5 = "ui_scripted_widget_data_" + var_4.index;
  var_6 = undefined;

  if(!istrue(var_2)) {
    var_6 = "ui_scripted_widget_time_" + var_4.index;
  }

  _widget_archetype_set_field_values(var_4._id_10E19, var_5, var_1, var_6);
}

scripted_widget_archetype_set_progress(var_0, var_1, var_2, var_3) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_4 = level._id_7B3E._id_CF67;
  var_5 = self._id_0F2B[var_0];
  var_6 = "ui_scripted_widget_data_" + var_5.index;
  var_7 = "ui_scripted_widget_time_" + var_5.index;
  _widget_archetype_set_progress(var_5._id_10E19, var_6, var_1, var_2, var_3, var_7);
}

scripted_widget_archetype_set_progress_bool(var_0, var_1, var_2) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_3 = level._id_7B3E._id_CF67;
  var_4 = self._id_0F2B[var_0];
  var_5 = "ui_scripted_widget_data_" + var_4.index;
  var_6 = "ui_scripted_widget_time_" + var_4.index;
  _widget_archetype_set_progress_bool(var_4._id_10E19, var_5, var_1, var_2, var_6);
}

scripted_widget_archetype_set_progress_alpha(var_0, var_1, var_2) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_3 = level._id_7B3E._id_CF67;
  var_4 = self._id_0F2B[var_0];
  var_5 = "ui_scripted_widget_data_" + var_4.index;
  var_6 = "ui_scripted_widget_time_" + var_4.index;
  _widget_archetype_set_progress_alpha(var_4._id_10E19, var_5, var_1, var_2, var_6);
}

scripted_widget_archetype_set_count(var_0, var_1, var_2, var_3) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_4 = level._id_7B3E._id_CF67;
  var_5 = self._id_0F2B[var_0];
  var_6 = "ui_scripted_widget_data_" + var_5.index;
  var_7 = "ui_scripted_widget_time_" + var_5.index;
  _widget_archetype_set_progress(var_5._id_10E19, var_6, var_1, var_2, var_3, var_7);
}

scripted_widget_set_timestamp(var_0, var_1) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_2 = level._id_7B3E._id_CF67;
  var_3 = self._id_0F2B[var_0];
  var_4 = "ui_scripted_widget_time_" + var_3.index;
  self setclientomnvar(var_4, var_1);
}

_id_CF63(var_0) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_1 = _id_0CDB(var_0);

  if(isDefined(var_1)) {
    var_2 = level._id_7B3E._id_CF67;
    var_3 = "ui_scripted_widget_type_" + var_1;
    self setclientomnvar(var_3, 0);
    self notify("scripted_widget_destroyed_" + var_0);
  }
}

_id_CF64(var_0) {
  var_0 = tolower(var_0);
  var_1 = level._id_7B3E._id_CF67;
  return isDefined(self._id_0F2B) && isDefined(self._id_0F2B[var_0]);
}

scripted_widgets_available() {
  return !isDefined(self._id_1F8D) || self._id_1F8D.size > 0;
}

_id_9527(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  _id_CF62(var_0, var_1);
  self._id_0F2B[var_0]._id_951C = [];

  if(isDefined(var_2)) {
    _id_9526(var_0, var_2);
  }
}

_id_9528(var_0) {
  var_0 = tolower(var_0);
  _id_CF63(var_0);
  _id_0C4F(var_0);
}

_id_9525(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[var_1] = var_2;
  _id_9526(var_0, var_4, var_3);
}

_id_9526(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_3 = [];
  var_4 = [];

  foreach(var_8, var_6 in var_1) {
    var_6 = tolower(var_6);
    var_7 = _id_0C50(var_0, tolower(var_8), var_6);

    if(isDefined(var_7)) {
      var_3[var_3.size] = var_6;
      var_4[var_4.size] = var_7;
    }
  }

  _list_widget_add_items(var_0, var_3, var_4, var_2);
}

list_widget_reorder_items(var_0, var_1) {
  var_0 = tolower(var_0);
  self._id_0F2B[var_0]._id_951C = [];

  foreach(var_5, var_3 in var_1) {
    var_4 = _list_widget_get_item_data(var_0, var_3);
    self._id_0F2B[var_0]._id_951C[var_5] = var_4.omnvar_index;
  }

  _list_widget_update_list(var_0);
}

list_widget_swap_items(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_3 = _list_widget_get_item_data(var_0, var_1);
  var_4 = _list_widget_get_item_data(var_0, var_2);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = var_3.omnvar_index;
  var_8 = var_4.omnvar_index;

  foreach(var_11, var_10 in self._id_0F2B[var_0]._id_951C) {
    if(var_10 == var_7) {
      var_5 = var_11;
    }

    if(var_10 == var_8) {
      var_6 = var_11;
    }
  }

  self._id_0F2B[var_0]._id_951C[var_5] = var_4.omnvar_index;
  self._id_0F2B[var_0]._id_951C[var_6] = var_3.omnvar_index;
  _list_widget_update_list(var_0);
}

list_widget_shift_items(var_0, var_1) {
  var_0 = tolower(var_0);
  var_2 = self._id_0F2B[var_0]._id_951C.size;
  var_3 = var_1;

  if(var_1 < 0) {
    var_3 = var_3 + var_2;
  }

  var_4 = scripts\engine\utility::_id_1BD4(self._id_0F2B[var_0]._id_951C, 0, var_3);
  var_5 = scripts\engine\utility::_id_1BD4(self._id_0F2B[var_0]._id_951C, var_3, var_2);
  self._id_0F2B[var_0]._id_951C = scripts\engine\utility::array_combine(var_5, var_4);
  _list_widget_update_list(var_0);
}

list_widget_reverse_items(var_0) {
  var_0 = tolower(var_0);
  self._id_0F2B[var_0]._id_951C = scripts\engine\utility::_id_1BD2(self._id_0F2B[var_0]._id_951C);
  _list_widget_update_list(var_0);
}

list_wiget_get_item_refs(var_0) {
  var_0 = tolower(var_0);
  return getarraykeys(self._id_0F21[var_0]);
}

_id_9533(var_0, var_1, var_2) {
  _id_9534(var_0, [var_1], var_2);
}

_id_9534(var_0, var_1, var_2) {
  var_0 = tolower(var_0);

  if(!_id_CF64(var_0)) {
    return;
  }
  var_3 = [];

  foreach(var_5 in var_1) {
    var_5 = tolower(var_5);
    var_6 = _id_0C4E(var_0, var_5);

    if(isDefined(var_6)) {
      var_3[var_3.size - 1] = var_6;
    }
  }

  _list_widget_remove_items(var_0, var_3);

  if(istrue(var_2) && !_id_952A(var_0)) {
    _id_9528(var_0);
  }
}

_id_952F(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_3 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = level._id_7B3E._id_CF67;
    var_5 = self._id_0F2B[var_0]._id_71F4;
    var_6 = _list_widget_get_omnvar_name(var_5, var_3.omnvar_index, "param_");
    _widget_set_omnvar(var_2, var_6, var_4._id_10E1A[var_3._id_10E19].parameters);
  }
}

list_widget_item_set_state(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_3 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = level._id_7B3E._id_CF67;
    var_5 = self._id_0F2B[var_0]._id_71F4;
    var_6 = _list_widget_get_omnvar_name(var_5, var_3.omnvar_index, "state_");
    _widget_set_omnvar(var_2, var_6, var_4._id_10E1A[var_3._id_10E19]._id_E75E);
  }
}

_id_952E(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_3 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = level._id_7B3E._id_CF67;
    var_5 = self._id_0F2B[var_0]._id_71F4;
    var_6 = _list_widget_get_omnvar_name(var_5, var_3.omnvar_index, "data_");
    _widget_set_omnvar(var_2, var_6);
  }
}

_id_952C(var_0, var_1, var_2, var_3) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_4 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_4)) {
    var_5 = self._id_0F2B[var_0]._id_71F4;
    var_6 = _list_widget_get_omnvar_name(var_5, var_4.omnvar_index, "data_");
    var_7 = undefined;

    if(!istrue(var_3)) {
      var_7 = _list_widget_get_omnvar_name(var_5, var_4.omnvar_index, "time_");
    }

    _widget_archetype_set_field_values(var_4._id_10E19, var_6, var_2, var_7);
  }
}

_id_952D(var_0, var_1, var_2, var_3, var_4) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_5 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_5)) {
    var_6 = self._id_0F2B[var_0]._id_71F4;
    var_7 = _list_widget_get_omnvar_name(var_6, var_5.omnvar_index, "data_");
    var_8 = _list_widget_get_omnvar_name(var_6, var_5.omnvar_index, "time_");
    _widget_archetype_set_progress(var_5._id_10E19, var_7, var_2, var_3, var_4, var_8);
  }
}

_id_952B(var_0, var_1, var_2, var_3, var_4) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_5 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_5)) {
    var_6 = self._id_0F2B[var_0]._id_71F4;
    var_7 = _list_widget_get_omnvar_name(var_6, var_5.omnvar_index, "data_");
    var_8 = _list_widget_get_omnvar_name(var_6, var_5.omnvar_index, "time_");
    _widget_archetype_set_count(var_5._id_10E19, var_7, var_2, var_3, var_4, var_8);
  }
}

_id_9530(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_3 = _list_widget_get_item_data(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = self._id_0F2B[var_0]._id_71F4;
    var_5 = _list_widget_get_omnvar_name(var_4, var_3.omnvar_index, "time_");
    _widget_set_omnvar(var_2, var_5);
  }
}

_id_9529(var_0, var_1) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  return isDefined(self._id_0F21) && isDefined(self._id_0F21[var_0]) && isDefined(self._id_0F21[var_0][var_1]);
}

_id_952A(var_0) {
  var_0 = tolower(var_0);
  return isDefined(self._id_0F21) && isDefined(self._id_0F21[var_0]) && self._id_0F21[var_0].size > 0;
}

_id_1774(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1) + var_0 getentitynumber();

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
  }

  var_4._id_5469 = var_0;
  var_4.anchor_type = var_3;
  _id_CF62(var_1, var_2, var_4);
}

_id_177C(var_0, var_1, var_2) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_set_param(var_1, var_2);
}

_id_177B(var_0, var_1, var_2) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  _id_CF65(var_1, var_2);
}

_id_1775(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_archetype_set_field_values(var_1, var_2, var_3);
}

_id_1776(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_archetype_set_progress(var_1, var_2, var_3, var_4);
}

_id_1777(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_archetype_set_progress_bool(var_1, var_2, var_3);
}

anchored_widget_archetype_set_progress_alpha(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_archetype_set_progress_alpha(var_1, var_2, var_3);
}

_id_177D(var_0, var_1, var_2) {
  var_1 = tolower(var_1) + var_0 getentitynumber();
  scripted_widget_set_timestamp(var_1, var_2);
}

_id_1779(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_1 = tolower(var_1) + var_2;
  _id_0B2A(var_1, var_2);
}

_id_177A(var_0) {
  _id_0B2B(var_0 getentitynumber());
}

anchored_widget_is_active(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_1 = tolower(var_1) + var_2;
  return isDefined(self.scripted_widget_anchors) && isDefined(self.scripted_widget_anchors[var_2]) && isDefined(self.scripted_widget_anchors[var_2][var_1]);
}

_id_0B2A(var_0, var_1) {
  if(isDefined(self.scripted_widget_anchors[var_1])) {
    if(isDefined(self.scripted_widget_anchors[var_1][var_0])) {
      _id_CF63(var_0);
    }

    self.scripted_widget_anchors[var_1][var_0] = undefined;

    if(self.scripted_widget_anchors[var_1].size == 0) {
      self.scripted_widget_anchors[var_1] = undefined;
      self notify("_automatic_remove_anchored_widget_" + var_1);
    }
  }
}

_id_0B2B(var_0) {
  if(isDefined(self.scripted_widget_anchors) && isDefined(self.scripted_widget_anchors[var_0])) {
    foreach(var_3, var_2 in self.scripted_widget_anchors[var_0]) {
      _id_CF63(var_3);
    }

    self.scripted_widget_anchors[var_0] = undefined;
    self notify("_automatic_remove_anchored_widget_" + var_0);
  }
}

_id_0B5F(var_0) {
  if(isPlayer(self)) {
    self endon("disconnect");
  }

  var_1 = var_0 getentitynumber();
  self notify("_automatic_remove_anchored_widget_" + var_1);
  self endon("_automatic_remove_anchored_widget_" + var_1);
  var_0 scripts\engine\utility::_id_1087F("death", "disconnect", "deleted");
  thread _id_0B2B(var_1);
}

_id_0DD9(var_0, var_1, var_2, var_3) {
  var_4 = level._id_7B3E._id_CF67._id_1A3D;

  if(var_0 > var_4[var_1][var_2]._id_9C3C) {
    var_0 = var_4[var_1][var_2]._id_9C3C;
  }

  var_0 = var_0 / var_4[var_1][var_2]._id_E838;
  var_0 = int(var_0);
  var_3 = var_3 | var_0 << var_4[var_1][var_2]._id_D9DD;
  return var_3;
}

_widget_archetype_set_field_values(var_0, var_1, var_2, var_3) {
  var_4 = level._id_7B3E._id_CF67;
  var_5 = level._id_7B3E._id_CF67._id_1A3D;
  var_6 = var_4._id_10E1A[var_0]._id_1A35;
  var_7 = 0;

  foreach(var_10, var_9 in var_2) {
    var_9 = clamp(var_9, 0.0, var_5[var_6][var_10]._id_9C3C);
    var_7 = _id_0DD9(var_9, var_6, var_10, var_7);
  }

  self setclientomnvar(var_1, var_7);

  if(isDefined(var_3)) {
    self setclientomnvar(var_3, gettime());
  }
}

_widget_archetype_set_progress(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_7B3E._id_CF67;
  var_7 = level._id_7B3E._id_CF67._id_1A3D;
  var_8 = "scripted_widget_archetype_progress";
  var_2 = clamp(var_2, 0.0, var_7[var_8]["current_pct"]._id_9C3C);
  var_3 = clamp(var_3, 0.0, var_7[var_8]["target_pct"]._id_9C3C);
  var_9 = 0;
  var_9 = _id_0DD9(var_2, var_8, "current_pct", var_9);
  var_9 = _id_0DD9(var_3, var_8, "target_pct", var_9);
  var_9 = _id_0DD9(var_4, var_8, "time", var_9);
  self setclientomnvar(var_1, var_9);
  self setclientomnvar(var_5, gettime());
}

_widget_archetype_set_progress_bool(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_7B3E._id_CF67;
  var_6 = level._id_7B3E._id_CF67._id_1A3D;
  var_7 = "scripted_widget_archetype_progress_bool";
  var_2 = clamp(var_2, 0.0, var_6[var_7]["current_pct"]._id_9C3C);
  var_8 = 0;
  var_8 = _id_0DD9(var_2, var_7, "current_pct", var_8);
  var_8 = _id_0DD9(var_3, var_7, "bool", var_8);
  self setclientomnvar(var_1, var_8);
  self setclientomnvar(var_4, gettime());
}

_widget_archetype_set_progress_alpha(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_7B3E._id_CF67;
  var_6 = level._id_7B3E._id_CF67._id_1A3D;
  var_7 = "scripted_widget_archetype_progress_alpha";
  var_2 = clamp(var_2, 0.0, var_6[var_7]["current_pct"]._id_9C3C);
  var_3 = clamp(var_3, 0.0, var_6[var_7]["current_alpha"]._id_9C3C);
  var_8 = 0;
  var_8 = _id_0DD9(var_2, var_7, "current_pct", var_8);
  var_8 = _id_0DD9(var_3, var_7, "current_alpha", var_8);
  self setclientomnvar(var_1, var_8);
  self setclientomnvar(var_4, gettime());
}

_widget_archetype_set_count(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_7B3E._id_CF67;
  var_7 = level._id_7B3E._id_CF67._id_1A3D;
  var_8 = "scripted_widget_archetype_count";
  var_2 = clamp(var_2, 0.0, var_7[var_8]["count"]._id_9C3C);

  if(isDefined(var_3)) {
    var_3 = clamp(var_3, 0.0, var_7[var_8]["max_count"]._id_9C3C);
  } else {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.0;
  }

  var_9 = 0;
  var_9 = _id_0DD9(var_2, var_8, "count", var_9);
  var_9 = _id_0DD9(var_3, var_8, "max_count", var_9);
  var_9 = _id_0DD9(var_4, var_8, "time", var_9);
  self setclientomnvar(var_1, var_9);

  if(var_4 > 0.0 && isDefined(var_5)) {
    self setclientomnvar(var_5, gettime());
  }
}

_widget_set_omnvar(var_0, var_1, var_2, var_3, var_4) {
  if(isint(var_0)) {
    var_0 = var_0;
  } else if(isDefined(var_2)) {
    var_0 = var_2[tolower(var_0)];
  }

  if(isint(var_0)) {
    if(isDefined(var_4)) {
      var_0 = var_0 << var_4;
    }

    if(isDefined(var_3)) {
      var_5 = self _meth_876E(var_1);
      var_5 = var_5 &~var_3;
      var_0 = var_0 | var_5;
    }

    self setclientomnvar(var_1, var_0);
  }
}

_id_0CFA(var_0, var_1) {
  if(!isDefined(self._id_7B38)) {
    self._id_7B38 = [];
  }

  if(!isDefined(self._id_7B38[var_0])) {
    self._id_7B38[var_0] = 0;
  }

  if(!var_1) {
    if(self._id_7B38[var_0] > 0) {
      self._id_7B38[var_0]--;
    }
  } else
    self._id_7B38[var_0]++;

  return self._id_7B38[var_0] > 0;
}

_id_0CDC(var_0, var_1) {
  var_2 = level._id_7B3E._id_CF67;
  var_3 = undefined;

  if(!isDefined(self._id_1F8D)) {
    self._id_1F8D = [];

    for(var_4 = 0; var_4 < var_2._id_9C44; var_4++) {
      self._id_1F8D[var_4] = var_4;
    }
  }

  if(!isDefined(self._id_0F2B)) {
    self._id_0F2B = [];
  }

  if(self._id_1F8D.size > 0) {
    var_3 = self._id_1F8D[0];
    self._id_1F8D = scripts\engine\utility::array_remove_index(self._id_1F8D, 0);
    self._id_0F2B[var_0] = spawnStruct();
    self._id_0F2B[var_0].index = var_3;
    self._id_0F2B[var_0]._id_10E19 = var_1;
    _scripted_widget_reset_omnvars(var_3);
  }

  return var_3;
}

_id_0CDB(var_0) {
  var_1 = level._id_7B3E._id_CF67;
  var_2 = undefined;

  if(isDefined(self._id_0F2B[var_0])) {
    var_2 = self._id_0F2B[var_0].index;
  }

  if(isDefined(var_2)) {
    self._id_1F8D[self._id_1F8D.size] = var_2;
    self._id_0F2B[var_0] = undefined;
  }

  return var_2;
}

_id_0CDA(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self notify("_scripted_widget_notify_closed_" + var_0);
  self endon("_scripted_widget_notify_closed_" + var_0);
  self endon("scripted_widget_destroyed_" + var_0);
  var_2 = level._id_7B3E._id_CF67;

  for(;;) {
    self waittill("luinotifyserver", var_3, var_4);

    if(var_3 == "scripted_widget_closed" && var_1 == var_4) {
      thread _id_CF63(var_0);
      return;
    }
  }
}

_scripted_widget_reset_omnvars(var_0) {
  var_1 = level._id_7B3E._id_CF67;
  var_2 = "ui_scripted_widget_type_" + var_0;
  var_3 = "ui_scripted_widget_param_" + var_0;
  var_4 = "ui_scripted_widget_data_" + var_0;
  var_5 = "ui_scripted_widget_state_" + var_0;
  var_6 = "ui_scripted_widget_time_" + var_0;
  var_7 = "ui_scripted_widget_position_" + var_0;
  var_8 = "ui_scripted_widget_priority_" + var_0;
  var_9 = "ui_scripted_widget_ent_" + var_0;
  self setclientomnvar(var_2, 0);
  self setclientomnvar(var_3, 0);
  self setclientomnvar(var_4, 0);
  self setclientomnvar(var_5, 0);
  self setclientomnvar(var_6, 0);
  self setclientomnvar(var_7, 0);
  self setclientomnvar(var_8, 0);
  self setclientomnvar(var_9, undefined);
}

_id_0C50(var_0, var_1, var_2) {
  var_3 = level._id_7B3E._id_CF67.list_widget_data;
  var_4 = undefined;

  if(!isDefined(self._id_1F8E)) {
    self._id_1F8E = [];
    var_5 = 15;

    if(var_3.num_groups > 1) {
      var_5 = var_5 - 1;
    }

    for(var_6 = 0; var_6 < var_3._id_9C26; var_6++) {
      var_7 = int(floor(var_6 / var_5));
      var_8 = var_6 % var_5;

      if(!isDefined(self._id_1F8E[var_7])) {
        self._id_1F8E[var_7] = [];
      }

      self._id_1F8E[var_7][var_8] = var_8 + 1;
    }
  }

  if(!isDefined(self._id_0F21)) {
    self._id_0F21 = [];
  }

  if(!isDefined(self._id_0F2B[var_0]._id_71F4)) {
    var_9 = undefined;
    var_10 = 0;

    for(var_6 = 0; var_6 < var_3.num_groups; var_6++) {
      var_11 = self._id_1F8E[var_6].size;

      if(var_11 > var_10) {
        var_9 = var_6;
        var_10 = var_11;
      }
    }

    if(!isDefined(var_9)) {
      return undefined;
    }

    _list_widget_group_reserve(var_0, var_9);
  }

  var_7 = self._id_0F2B[var_0]._id_71F4;
  var_12 = self._id_1F8E[var_7].size - 1;

  if(var_12 >= 0) {
    var_4 = self._id_1F8E[var_7][var_12];
    self._id_1F8E[var_7][var_12] = undefined;

    if(!isDefined(self._id_0F21[var_0])) {
      self._id_0F21[var_0] = [];
    }

    self._id_0F21[var_0][var_1] = spawnStruct();
    self._id_0F21[var_0][var_1].omnvar_index = var_4;
    self._id_0F21[var_0][var_1]._id_10E19 = var_2;
    _id_0C51(var_7, var_4);
  }

  return var_4;
}

_list_widget_group_reserve(var_0, var_1) {
  var_2 = level._id_7B3E._id_CF67.list_widget_data.group_mask;
  var_3 = level._id_7B3E._id_CF67.list_widget_data.group_shift;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_4 = "ui_scripted_widget_data_" + self._id_0F2B[var_0].index;
    _widget_set_omnvar(var_1, var_4, undefined, var_2, var_3);
  }

  self._id_0F2B[var_0]._id_71F4 = var_1;
}

_id_0C4E(var_0, var_1) {
  var_2 = level._id_7B3E._id_CF67.list_widget_data;
  var_3 = undefined;

  if(isDefined(self._id_0F21[var_0]) && isDefined(self._id_0F21[var_0][var_1])) {
    var_3 = self._id_0F21[var_0][var_1].omnvar_index;

    if(isDefined(var_3)) {
      var_4 = self._id_0F2B[var_0]._id_71F4;
      self._id_1F8E[var_4][self._id_1F8E[var_4].size] = var_3;
      self._id_0F21[var_0][var_1] = undefined;

      if(self._id_0F21[var_0].size == 0) {
        self._id_0F21[var_0] = undefined;
      }
    }
  }

  return var_3;
}

_id_0C4F(var_0) {
  var_1 = level._id_7B3E._id_CF67.list_widget_data;

  if(isDefined(self._id_0F21[var_0])) {
    if(self._id_0F21[var_0].size > 0) {
      var_2 = self._id_0F2B[var_0]._id_71F4;

      foreach(var_4 in self._id_0F21[var_0]) {
        self._id_1F8E[var_2][self._id_1F8E[var_2].size] = var_4.omnvar_index;
      }
    }

    self._id_0F21[var_0] = undefined;
  }
}

_list_widget_add_items(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    self._id_0F2B[var_0]._id_951C = scripts\engine\utility::array_combine(var_2, self._id_0F2B[var_0]._id_951C);
  } else {
    self._id_0F2B[var_0]._id_951C = scripts\engine\utility::array_combine(self._id_0F2B[var_0]._id_951C, var_2);
  }

  var_4 = level._id_7B3E._id_CF67;

  foreach(var_8, var_6 in var_1) {
    var_7 = _list_widget_get_omnvar_name(self._id_0F2B[var_0]._id_71F4, var_2[var_8], "type_");
    self setclientomnvar(var_7, var_4._id_10E1A[var_6].index);
  }

  _list_widget_update_list(var_0);
}

_list_widget_remove_items(var_0, var_1) {
  self._id_0F2B[var_0]._id_951C = scripts\engine\utility::_id_1BBF(self._id_0F2B[var_0]._id_951C, var_1);
  _list_widget_update_list(var_0);
}

_list_widget_update_list(var_0) {
  var_1 = 8.0;
  var_2 = 0;

  if(level._id_7B3E._id_CF67.list_widget_data.num_groups > 1) {
    var_1 = var_1 - 1;
    var_2 = self._id_0F2B[var_0]._id_71F4 << level._id_7B3E._id_CF67.list_widget_data.group_shift;
  }

  var_3 = self._id_0F2B[var_0]._id_951C;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    if(isDefined(var_3[var_4])) {
      var_2 = var_2 | var_3[var_4] << 4 * var_4;
    }
  }

  _id_CF65(var_0, var_2);
}

_id_0C51(var_0, var_1) {
  var_1 = _list_widget_get_omnvar_index(var_0, var_1);
  var_2 = "ui_scripted_list_item_type_" + var_1;
  var_3 = "ui_scripted_list_item_param_" + var_1;
  var_4 = "ui_scripted_list_item_data_" + var_1;
  var_5 = "ui_scripted_list_item_state_" + var_1;
  var_6 = "ui_scripted_list_item_time_" + var_1;
  self setclientomnvar(var_2, 0);
  self setclientomnvar(var_3, 0);
  self setclientomnvar(var_4, 0);
  self setclientomnvar(var_5, 0);
  self setclientomnvar(var_6, 0);
}

_list_widget_get_omnvar_index(var_0, var_1) {
  return var_1 + var_0 * 15;
}

_list_widget_get_omnvar_name(var_0, var_1, var_2) {
  var_1 = _list_widget_get_omnvar_index(var_0, var_1);
  return "ui_scripted_list_item_" + var_2 + var_1;
}

_list_widget_get_item_data(var_0, var_1) {
  var_2 = level._id_7B3E._id_CF67.list_widget_data;

  if(isDefined(self._id_0F21) && isDefined(self._id_0F21[var_0]) && isDefined(self._id_0F21[var_0][var_1])) {
    return self._id_0F21[var_0][var_1];
  }

  return undefined;
}