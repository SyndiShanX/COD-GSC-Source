/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_72ef6b9f0cf1f55a.gsc
*************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_6917e6eed10cfc44;

function private autoexec __init__system__() {
  system::register(#"hash_58f5dc856591d010", undefined, &pre_main, undefined);
}

function private pre_main() {
  if(!isDefined(level.player)) {
    level.player = getEntArray("player", "classname")[0];
  }

  if(!isDefined(level.var_6917e6eed10cfc44)) {
    level.var_6917e6eed10cfc44 = spawnStruct();
  }

  if(!isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d)) {
    level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d = spawnStruct();
  }

  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  data.widget_types = [];
  data.anchor_types = [];
  data.archetypes = [];
  data.var_56a961d04403887 = spawnStruct();
  function_ce0d74e919485109(function_fac756723bad75d7());
  function_ce0d74e919485109(function_f47d44a82f05a2bd());
  function_ce0d74e919485109(function_ac835b45b726185c());
  function_ce0d74e919485109(function_1e95884aa052ae3e());
  scripts\common\ui::lui_registercallback("scripted_widget_closed", &scripted_widget_closed);
}

function private function_ce0d74e919485109(var_44c1d0100b18dd6d) {
  if(!isDefined(var_44c1d0100b18dd6d)) {
    return;
  }

  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  data.var_4dc78c94cd673b03 = var_44c1d0100b18dd6d.var_348f35d05ac9a37e;

  if(isDefined(var_44c1d0100b18dd6d.archetypes)) {
    foreach(archetype in var_44c1d0100b18dd6d.archetypes) {
      archetype_data = getscriptbundle("scriptedwidgetarchetype:" + archetype.archetype);
      archetype_name = tolower(archetype.archetype);

      if(isDefined(archetype_data) && !isDefined(data.archetypes[archetype_name])) {
        data.archetypes[archetype_name] = [];
        shift = 0;

        foreach(field_data in archetype_data.fields) {
          field = tolower(field_data.field_name);
          max_value = field_data.max_value;
          step_increment = field_data.step_increment;
          assertex(max_value >= step_increment, "The max value (" + max_value + ") for widget archetype <" + archetype_name + ">, field <" + field + "> exceeds the step increment of " + step_increment + ". Clamping max value to " + step_increment);
          max_value = max(max_value, step_increment);
          bits = int(ceil(log(max_value / step_increment + 1) / log(2)));
          data.archetypes[archetype_name][field] = spawnStruct();
          data.archetypes[archetype_name][field].bits = bits;
          data.archetypes[archetype_name][field].max_value = max_value;
          data.archetypes[archetype_name][field].step_increment = step_increment;
          data.archetypes[archetype_name][field].shift = shift;
          data.archetypes[archetype_name][field].mask = int(pow(2, bits) - 1) << shift;
          shift += bits;
          assertex(shift <= 32, "Widget archetype " + archetype_name + "'s fields exceeds the maximum 32 bits of the omnvar.Please adjust the field values for " + archetype_name + " and ensure the bits used by all fields do not exceed 32.");
        }
      }
    }
  }

  if(isDefined(var_44c1d0100b18dd6d.anchors)) {
    foreach(anchor in var_44c1d0100b18dd6d.anchors) {
      anchor_data = getscriptbundle("scriptedwidgetanchorsettings:" + anchor.anchor);
      anchor_name = tolower(anchor.anchor);

      if(isDefined(anchor_data) && !isDefined(data.anchor_types[anchor_name])) {
        data.anchor_types[anchor_name] = data.anchor_types.size;
      }
    }
  }

  foreach(widget in var_44c1d0100b18dd6d.var_44c1d0100b18dd6d) {
    function_26f299852d555394(widget.scripted_widget);
  }

  if(isDefined(var_44c1d0100b18dd6d.var_fe35ca9b37873aa2) && var_44c1d0100b18dd6d.var_fe35ca9b37873aa2 > 0) {
    data.var_56a961d04403887.max_items = var_44c1d0100b18dd6d.var_fe35ca9b37873aa2;
    data.var_56a961d04403887.num_groups = ceil(data.var_56a961d04403887.max_items / 8);
    data.var_56a961d04403887.group_mask = 0;
    data.var_56a961d04403887.group_shift = 0;

    if(data.var_56a961d04403887.num_groups > 1) {
      data.var_56a961d04403887.group_mask = 8;
      data.var_56a961d04403887.group_shift = int(28);
    }
  }
}

function private function_26f299852d555394(widget_name) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_data = getscriptbundle("scriptedwidget:" + widget_name);
  widget_name = tolower(widget_name);

  if(isDefined(widget_data) && !isDefined(data.widget_types[widget_name])) {
    data.widget_types[widget_name] = spawnStruct();
    data.widget_types[widget_name].index = data.widget_types.size;

    if(isDefined(widget_data.archetype) && widget_data.archetype != "") {
      archetype = getscriptbundle("scriptedwidgetarchetype:" + widget_data.archetype);
      archetype_name = tolower(widget_data.archetype);
      assertex(isDefined(data.archetypes[archetype_name]), "Attempting to use scripted widget " + widget_name + " but the archetype " + archetype_name + " was not added to the archetypes array in the appropriate scriptedwidgetslist asset");

      if(isDefined(archetype) && isDefined(data.archetypes[archetype_name])) {
        data.widget_types[widget_name].archetype = archetype_name;
      }
    }

    data.widget_types[widget_name].parameters = [];

    if(isDefined(widget_data.parameters)) {
      foreach(param in widget_data.parameters) {
        if(isDefined(param.name) && param.name != "") {
          data.widget_types[widget_name].parameters[tolower(param.name)] = param_index;
        }
      }
    }

    data.widget_types[widget_name].states = [];

    if(isDefined(widget_data.states)) {
      foreach(state in widget_data.states) {
        if(isDefined(state.name) && state.name != "") {
          data.widget_types[widget_name].states[tolower(state.name)] = state_index;
        }
      }
    }

    data.widget_types[widget_name].children = [];

    if(isDefined(widget_data.children)) {
      foreach(child in widget_data.children) {
        if(isDefined(child.name) && child.name != "") {
          child_name = tolower(child.name);
          data.widget_types[widget_name].children[child_name] = [];

          foreach(child_widget in child.widgets) {
            if(isDefined(child_widget.name)) {
              var_35de4a7a76aee370 = tolower(child_widget.name);
              data.widget_types[widget_name].children[child_name][var_35de4a7a76aee370] = spawnStruct();
              data.widget_types[widget_name].children[child_name][var_35de4a7a76aee370].index = var_f5de074125c2d341 + 1;
              data.widget_types[widget_name].children[child_name][var_35de4a7a76aee370].widget = child_widget.scriptedwidget;
              function_26f299852d555394(child_widget.scriptedwidget);
            }
          }
        }
      }
    }
  }
}

function function_efa7d98eea1fb836(widget_name, child_name, var_35de4a7a76aee370) {
  widget_name = tolower(widget_name);
  child_name = tolower(child_name);
  var_35de4a7a76aee370 = tolower(var_35de4a7a76aee370);

  if(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name]) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name]) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name][var_35de4a7a76aee370])) {
    return level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name][var_35de4a7a76aee370].widget;
  }

  return undefined;
}

function function_ade28fda795d5664(widget_name, child_name, var_35de4a7a76aee370) {
  widget_name = tolower(widget_name);
  child_name = tolower(child_name);
  var_35de4a7a76aee370 = tolower(var_35de4a7a76aee370);

  if(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name]) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name]) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name][var_35de4a7a76aee370])) {
    return level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_name].children[child_name][var_35de4a7a76aee370].index;
  }

  return undefined;
}

function function_63d35b39e955e65c(var_fee88e2c79edd2f, var_1212b8095077474c) {
  if(!isDefined(level.var_6917e6eed10cfc44)) {
    level.var_6917e6eed10cfc44 = spawnStruct();
  }

  if(!isDefined(level.var_6917e6eed10cfc44.var_f212ecf957ec73f0)) {
    level.var_6917e6eed10cfc44.var_f212ecf957ec73f0 = spawnStruct();
  }

  data = level.var_6917e6eed10cfc44.var_f212ecf957ec73f0;
  data.omnvar = var_fee88e2c79edd2f;
  data.widgets = [];

  if(isDefined(var_1212b8095077474c) && tableexists(var_1212b8095077474c)) {
    rows = tablelookupgetnumrows(var_1212b8095077474c);

    for(row = 0; row < rows; row++) {
      script_name = tablelookupbyrow(var_1212b8095077474c, row, 0);

      if(script_name != "") {
        data.widgets[tolower(script_name)] = row;
      }
    }
  }
}

function function_5c5dd45babfb8d7d(widgets, shouldhide) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to hide or show widgets before hide_hud_widgets_init() was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_f212ecf957ec73f0), "Tried to hide or show widgets before hide_hud_widgets_init() was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_f212ecf957ec73f0.widgets), "Tried to hide or show widgets before hide_hud_widgets_init() was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_f212ecf957ec73f0.omnvar), "No omnvar specified for hiding hud widgets.Call hide_hud_widgets_init() and pass in an omnvar.");
  data = level.var_6917e6eed10cfc44.var_f212ecf957ec73f0;

  if(!isarray(widgets)) {
    widgets = [widgets];
  }

  foreach(widget in widgets) {
    widget = tolower(widget);
    assertex(isDefined(data.widgets[widget]), "Tried to hide or show widget " + widget + ", but that widget is not registered in hide_hud_widgets_init()");
    shouldhide = function_f801c3e967c7768a(widget, shouldhide);
    self setclientomnvarbit(data.omnvar, data.widgets[widget], shouldhide);
  }
}

function function_90de31b2cbef19f9(widget_ref, widget_type, widget_struct) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to create scripted widgets before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to create scripted widgets before scripted_widgets_init was called.");
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_ref = tolower(widget_ref);
  widget_type = tolower(widget_type);

  if(function_ada0825249682644(widget_ref)) {
    assert("Cannot create scripted widget: " + widget_ref + ".That reference is already active.");
    return;
  }

  index = function_f94203b920f0ba27(widget_ref, widget_type);

  if(isDefined(index)) {
    if(isDefined(widget_struct)) {
      if(isDefined(widget_struct.param)) {
        function_cc46ab20b75d5c58(widget_struct.param, "ui_scripted_widget_" + "param_" + index, data.widget_types[widget_type].parameters);
      }

      if(isDefined(widget_struct.data)) {
        function_cc46ab20b75d5c58(widget_struct.data, "ui_scripted_widget_" + "data_" + index);
      }

      if(isDefined(widget_struct.state)) {
        function_cc46ab20b75d5c58(widget_struct.state, "ui_scripted_widget_" + "state_" + index, data.widget_types[widget_type].states);
      }

      if(isDefined(widget_struct.priority)) {
        function_cc46ab20b75d5c58(widget_struct.priority, "ui_scripted_widget_" + "priority_" + index);
      }

      if(istrue(widget_struct.under_hud)) {
        function_cc46ab20b75d5c58(1, "ui_scripted_widget_" + "under_hud_" + index);
      }

      if(isent(widget_struct.ent)) {
        assertex(isDefined(widget_struct.anchor_type), "Must define <anchor_type> in the widget struct if specifying an ent to anchor to");
        function_7a82d07837107ae6(widget_ref, widget_struct.ent, widget_struct.anchor_type);
      }

      if(isDefined(widget_struct.position)) {
        function_f4c37324750dc183(widget_ref, widget_struct.position.left, widget_struct.position.top, widget_struct.position.horizontal_anchor, widget_struct.position.vertical_anchor, widget_struct.position.var_5bf6089ef591d224);
      }
    }

    self setclientomnvar("ui_scripted_widget_" + "type_" + index, data.widget_types[widget_type].index);
    return;
  }

  assert("Cannot create more scripted widgets until one is removed");
}

function function_6cd0a8e23ff14e13(widget_prefix) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(widget_prefix), "Tried to get a widget name without providing a prefix as defined in APE");
  widget = function_6627dd3016f3d63f(widget_prefix, getDvar(@ "g_mapname"));

  if(isDefined(widget)) {
    return widget;
  }

  widget = function_6627dd3016f3d63f(widget_prefix, [function_3cb5da19764baa3(), level.gametype]);

  if(isDefined(widget)) {
    return widget;
  }

  mode = "mp";

  if(utility::iscp()) {
    mode = "cp";
  } else if(utility::issp()) {
    mode = "sp";
  }

  widget = function_6627dd3016f3d63f(widget_prefix, [function_3cb5da19764baa3(), mode]);

  if(isDefined(widget)) {
    return widget;
  }

  widget = function_6627dd3016f3d63f(widget_prefix, function_3cb5da19764baa3());

  if(isDefined(widget)) {
    return widget;
  }

  if(isDefined(level.gametype)) {
    widget = function_6627dd3016f3d63f(widget_prefix, level.gametype);

    if(isDefined(widget)) {
      return widget;
    }
  }

  widget = function_6627dd3016f3d63f(widget_prefix, mode);

  if(isDefined(widget)) {
    return widget;
  }

  if(function_a0ae4b54aa48ade2(widget_prefix)) {
    return widget_prefix;
  }

  return undefined;
}

function function_6627dd3016f3d63f(widget_prefix, params) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(widget_prefix), "Tried to get a widget name without providing a prefix as defined in APE");
  assertex(isDefined(params) && (isstring(params) || isarray(params)), "Tried to get a widget name without providing a string or table of params. Use scripted_widget_get_name_by_asset_prefix instead.");
  var_25f11f8236d36f82 = "";

  if(isstring(params)) {
    var_25f11f8236d36f82 = widget_prefix + "_" + params;
  } else if(isarray(params)) {
    for(i = 0; i < params.size; i++) {
      if(!isDefined(params[i])) {
        return undefined;
      }

      var_25f11f8236d36f82 += params[i];

      if(i + 1 < params.size) {
        var_25f11f8236d36f82 += "_";
      }
    }

    var_25f11f8236d36f82 = widget_prefix + "_" + var_25f11f8236d36f82;
  } else {
    var_25f11f8236d36f82 = widget_prefix;
  }

  if(function_a0ae4b54aa48ade2(var_25f11f8236d36f82)) {
    return tolower(var_25f11f8236d36f82);
  }

  return undefined;
}

function function_a0ae4b54aa48ade2(widget_type) {
  widget_type = tolower(widget_type);
  return isDefined(level.var_6917e6eed10cfc44) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d) && isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_type]);
}

function function_956ab5009d077253(widget_asset, param_name, var_a66ee63570312822) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to get the params of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to get the params of a scripted widget before scripted_widgets_init was called.");
  widget_data = getscriptbundle("scriptedwidget:" + widget_asset);
  param_index = function_7be2b65191088c8a(widget_asset, param_name);

  if(isDefined(param_index)) {
    var_a66ee63570312822 = tolower(var_a66ee63570312822);

    foreach(property in widget_data.parameters[param_index].properties) {
      if(property.variant_object.property == var_a66ee63570312822) {
        return property.variant_object.value;
      }
    }
  }

  return undefined;
}

function function_7be2b65191088c8a(widget_asset, param_name) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to get the param index of a scripted widget before scripted_widgets_init was called.");
  widget_asset = tolower(widget_asset);
  param_name = tolower(param_name);
  return level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_asset].parameters[param_name];
}

function private function_95809d3a84b2020b(widget_ref, var_a79e2ddd22fbba9a, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  var_b8868bce74340be6 = spawnStruct();
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_ref = tolower(widget_ref);

  if(isDefined(var_54a61fbefc52eb7f)) {
    var_b8868bce74340be6.omnvar = var_54a61fbefc52eb7f;
    var_b8868bce74340be6.type = widget_ref;
    var_b8868bce74340be6.var_26595f30949d77ee = var_5a4ed2926457d0b;
    assert(isDefined(data.widget_types[widget_ref]));
  } else {
    if(!function_ada0825249682644(widget_ref)) {
      return undefined;
    }

    active_widget = self.var_a14cb42739301f30[widget_ref];
    var_b8868bce74340be6.omnvar = "ui_scripted_widget_" + var_a79e2ddd22fbba9a + active_widget.index;
    var_b8868bce74340be6.type = active_widget.widget_type;
    var_b8868bce74340be6.var_26595f30949d77ee = "ui_scripted_widget_" + "time_" + active_widget.index;
  }

  return var_b8868bce74340be6;
}

function function_af4f62f0f944a8f1(widget_ref, param_ref, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the param of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the param of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "param_", var_54a61fbefc52eb7f);

  if(isDefined(data)) {
    parameters = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[data.type].parameters;
    function_cc46ab20b75d5c58(param_ref, data.omnvar, parameters);
  }
}

function function_b52897e8afbb0968(widget_ref, data_val, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the data of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the data of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(isDefined(data)) {
    function_cc46ab20b75d5c58(data_val, data.omnvar);
  }
}

function function_daff24f3e11825ae(widget_asset, state_name) {
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to get the state index of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to get the state index of a scripted widget before scripted_widgets_init was called.");
  state_name = tolower(state_name);
  return level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[widget_asset].states[state_name];
}

function function_d28fa5295a04d555(widget_ref, state, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the state of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the state of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "state_", var_54a61fbefc52eb7f);

  if(isDefined(data)) {
    states = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.widget_types[data.type].states;
    function_cc46ab20b75d5c58(state, data.omnvar, states);
  }
}

function function_7a82d07837107ae6(widget_ref, anchor_ent, anchor_type) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref);

  if(!function_ada0825249682644(widget_ref)) {
    return;
  }

  anchor_type = tolower(anchor_type);
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  assertex(isDefined(data.anchor_types) && isDefined(data.anchor_types[anchor_type]), "Anchor type " + anchor_type + " does not exist. Ensure that the anchor table has been registered in scripted_widgets_init(), it's included in a csv, and the entry exists within the table");

  if(!isDefined(self.var_414b9a0d57c1e081)) {
    self.var_414b9a0d57c1e081 = [];
  }

  ent_num = anchor_ent getentitynumber();

  if(!isDefined(self.var_414b9a0d57c1e081[ent_num])) {
    self.var_414b9a0d57c1e081[ent_num] = [];
  }

  active_widget = self.var_a14cb42739301f30[widget_ref];

  if(isDefined(active_widget.ent_num)) {
    self.var_414b9a0d57c1e081[active_widget.ent_num][widget_ref] = undefined;

    if(self.var_414b9a0d57c1e081[active_widget.ent_num].size == 0) {
      self.var_414b9a0d57c1e081[active_widget.ent_num] = undefined;
      self notify("_automatic_remove_anchored_widget_" + active_widget.ent_num);
    }
  }

  active_widget.ent_num = ent_num;
  self.var_414b9a0d57c1e081[ent_num][widget_ref] = active_widget.index;
  var_2486ed5c4df7182c = "ui_scripted_widget_" + "ent_" + active_widget.index;
  self setclientomnvar(var_2486ed5c4df7182c, anchor_ent);
  function_cc46ab20b75d5c58(data.anchor_types[anchor_type], "ui_scripted_widget_" + "position_" + active_widget.index);
  thread function_583777ac2b762d3(anchor_ent);
}

function function_f4c37324750dc183(widget_ref, x_pos, y_pos, horizontal_anchor, vertical_anchor, var_5bf6089ef591d224, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  data = function_95809d3a84b2020b(widget_ref, "position_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  if(!isDefined(var_5bf6089ef591d224)) {
    var_5bf6089ef591d224 = 1;
  }

  x_pos = int(x_pos);
  y_pos = int(y_pos);

  switch (horizontal_anchor) {
    case 0:
      assertex(x_pos >= -63 && x_pos <= 1984, "<scripted_widget_set_position>, 'x_pos' parameter must be between " + -63 + " and " + 1984 + " for left alignment");
      x_pos -= -63;
      break;
    case 1:
    case 3:
      assertex(x_pos >= -1023 && x_pos <= 1024, "<scripted_widget_set_position>, 'x_pos' parameter must be between " + -1023 + " and " + 1024 + " for center alignment");
      x_pos -= -1023;
      break;
    case 2:
      assertex(x_pos >= -1984 && x_pos <= 0 - -63, "<scripted_widget_set_position>, 'x_pos' parameter must be between " + -1984 + " and " + 0 - -63 + " for right alignment");
      x_pos += 1984;
      break;
  }

  switch (vertical_anchor) {
    case 0:
      assertex(y_pos >= -483 && y_pos <= 1564, "<scripted_widget_set_position>, 'y_pos' parameter must be between " + -483 + " and " + 1564 + " for top alignment");
      y_pos -= -483;
      break;
    case 1:
    case 3:
      assertex(y_pos >= -1023 && y_pos <= 1024, "<scripted_widget_set_position>, 'y_pos' parameter must be between " + -1023 + " and " + 1024 + " for middle alignment");
      y_pos -= -1023;
      break;
    case 2:
      assertex(y_pos >= -1564 && y_pos <= 0 - -483, "<scripted_widget_set_position>, 'y_pos' parameter must be between " + -1564 + " and " + 0 - -483 + " for bottom alignment");
      y_pos += 1564;
      break;
  }

  y_bits = y_pos << 11;
  var_f7e258d3c20bfb80 = horizontal_anchor << 22;
  var_91800f6a184e5dca = vertical_anchor << 22 + 2;
  var_b086c1951a364c8d = ter_op(var_5bf6089ef591d224, 1, 0) << 22 + 2 + 2;
  packed_position = x_pos + y_bits + var_f7e258d3c20bfb80 + var_91800f6a184e5dca + var_b086c1951a364c8d;
  self setclientomnvar(data.omnvar, packed_position);
}

function function_f845164fd6027e79(datatype) {
  if(!isDefined(datatype)) {
    return 0;
  }

  switch (datatype) {
    case #"hash_a653d8ebf51ebac4":
      return 1;
    case #"hash_5b6fb3c943bab625":
      return 2;
    case #"hash_175a301ae8d1236a":
      return 3;
    default:
      return 0;
  }
}

function function_863b22a1564f8eb(datatype) {
  if(!isDefined(datatype)) {
    return 0;
  }

  switch (datatype) {
    case #"hash_4fdc8686e8ea358":
      return 1;
    case #"hash_62df33229372c36a":
      return 2;
    case #"hash_175a301ae8d1236a":
      return 3;
    default:
      return 0;
  }
}

function function_d2da2b563383891f(widget_ref, var_d66aa55144b09de9, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  data = function_95809d3a84b2020b(widget_ref, "position_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return undefined;
  }

  position_data = self getclientomnvar(data.omnvar);
  x_pos = (position_data &int(pow(2, 11) - 1)) >> 0;
  y_pos = (position_data &int(pow(2, 11) - 1)) >> 11;
  vertical_anchor = (position_data &int(pow(2, 2) - 1)) >> 22;
  horizontal_anchor = (position_data &int(pow(2, 2) - 1)) >> 22 + 2;

  switch (horizontal_anchor) {
    case 0:
      x_pos += -63;
      break;
    case 1:
    case 3:
      x_pos += -1023;
      break;
    case 2:
      x_pos -= 1984;
      break;
  }

  switch (vertical_anchor) {
    case 0:
      y_pos += -483;
      break;
    case 1:
    case 3:
      y_pos += -1023;
      break;
    case 2:
      y_pos -= 1564;
      break;
  }

  if(istrue(var_d66aa55144b09de9)) {
    x_pos = (x_pos - -63) / (1984 - -63);
    y_pos = (y_pos - -483) / (1564 - -483);
  }

  return (x_pos, y_pos, 0);
}

function function_1ec2f3bcef4a8818(widget_ref, priority, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  data = function_95809d3a84b2020b(widget_ref, "priority_", var_54a61fbefc52eb7f);

  if(isDefined(data)) {
    self setclientomnvar(data.omnvar, priority);
  }
}

function function_14a0ee2aaf9128c3(widget_ref, field_values, no_timestamp, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f, var_5a4ed2926457d0b);

  if(!isDefined(data)) {
    return;
  }

  function_e375e5ca24ea7bf4(data.type, data.omnvar, field_values, data.var_26595f30949d77ee);
}

function function_6e45b720d0914f42(widget_ref, field, value, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_e6df6627eb26284f(data.type, data.omnvar, field, value);
}

function function_2d3bf675525ba34c(widget_ref, field, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  value = function_61dda643ffbb43a0(data.type, data.omnvar, [field]);
  function_e6df6627eb26284f(data.type, data.omnvar, field, !value[field]);
}

function function_ddc9d8c3b0ef6b87(widget_ref, current_pct, target_pct, time, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the progress of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the progress of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_ab8c8292f0d469c4(data.type, data.omnvar, current_pct, target_pct, time, data.var_26595f30949d77ee);
}

function function_315df71064cc10b8(widget_ref, current_pct, bool, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the progress bool of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the progress bool of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_42866bf1e84c1d21(data.type, data.omnvar, current_pct, bool, data.var_26595f30949d77ee);
}

function function_a435f7db4b861f0c(widget_ref, current_pct, current_alpha, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the progress alpha of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the progress alpha of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_7db1020b4d70e9e7(data.type, data.omnvar, current_pct, current_alpha, data.var_26595f30949d77ee);
}

function function_2181b4358a46aab3(widget_ref, count, max_count, time, var_54a61fbefc52eb7f, var_5a4ed2926457d0b) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the count of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the count of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_99bfbb496e5ac12a(data.type, data.omnvar, count, max_count, time, data.var_26595f30949d77ee);
}

function function_b93f1b828644c021(widget_ref, horizontal_alignment, vertical_alignment, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the list item alignment of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the list item alignment of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  function_36bba30ae80af891(data.type, data.omnvar, horizontal_alignment, vertical_alignment);
}

function function_1f51eabeded054f0(widget_ref, timestamp, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the timestamp of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the timestamp of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "time_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  self setclientomnvar(data.omnvar, timestamp);
}

function function_1f1c11d26b17770f(widget_ref, fields, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to set the field values of a scripted widget before scripted_widgets_init was called.");
  data = function_95809d3a84b2020b(widget_ref, "data_", var_54a61fbefc52eb7f);

  if(!isDefined(data)) {
    return;
  }

  return function_61dda643ffbb43a0(data.type, data.omnvar, fields);
}

function function_fb3c9a259f146781(widget_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  assertex(isDefined(level.var_6917e6eed10cfc44), "Tried to destroy scripted widgets before scripted_widgets_init was called.");
  assertex(isDefined(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d), "Tried to destroy scripted widgets before scripted_widgets_init was called.");
  widget_ref = tolower(widget_ref);

  if(!function_ada0825249682644(widget_ref)) {
    return;
  }

  index = function_cca9604860a60e2a(widget_ref);

  if(isDefined(index)) {
    data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
    var_94a50c0a0059e601 = "ui_scripted_widget_" + "type_" + index;
    self setclientomnvar(var_94a50c0a0059e601, 0);
    self notify("scripted_widget_destroyed_" + widget_ref);
  }
}

function function_ada0825249682644(widget_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref);
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  return isDefined(self.var_a14cb42739301f30) && isDefined(self.var_a14cb42739301f30[widget_ref]);
}

function function_114fb9814c0b068d() {
  assertex(isPlayer(self), "Must be called on a player.");
  return !isDefined(self.var_a219288779b991ce) || self.var_a219288779b991ce.size > 0;
}

function function_440f285bc17a2787(list_ref, widget_type, list_items) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  function_90de31b2cbef19f9(list_ref, widget_type);
  self.var_a14cb42739301f30[list_ref].list = [];

  if(isDefined(list_items)) {
    function_c9e5319d68e22011(list_ref, list_items);
  }
}

function function_cf43a9641fd024af(list_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  function_fb3c9a259f146781(list_ref);
  function_b267732c9e92f306(list_ref);
}

function function_872bbb1fa784b8d8(list_ref, item_ref, item_type, var_3cefc2b0c7f6f3ec) {
  assertex(isPlayer(self), "Must be called on a player.");
  items = [];
  items[item_ref] = item_type;
  function_c9e5319d68e22011(list_ref, items, var_3cefc2b0c7f6f3ec);
}

function function_c9e5319d68e22011(list_ref, list_items, var_3cefc2b0c7f6f3ec) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  items = [];
  omnvars = [];

  foreach(item_type in list_items) {
    item_type = tolower(item_type);
    var_3de03bfa4e76b915 = function_eabc5d231d49caab(list_ref, tolower(item_ref), item_type);
    assertex(isDefined(var_3de03bfa4e76b915), "Tried to allocate list item in scripted_widget_list_add_items(), but there are no more omnvars in reserve");

    if(isDefined(var_3de03bfa4e76b915)) {
      items[items.size] = item_type;
      omnvars[omnvars.size] = var_3de03bfa4e76b915;
    }
  }

  function_5afd39d9a06be177(list_ref, items, omnvars, var_3cefc2b0c7f6f3ec);
}

function function_1114ac444eb63515(list_ref, items) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  assertex(self.var_a14cb42739301f30[list_ref].list.size == items.size, "Trying to reorder items in the list, but the list sizes don't match");
  self.var_a14cb42739301f30[list_ref].list = [];

  foreach(item_ref in items) {
    item_data = function_9cee54c391590f92(list_ref, item_ref);
    assertex(isDefined(item_data), "Trying to reorder list items for an item that does not currently exist: <" + item_ref + ">");
    self.var_a14cb42739301f30[list_ref].list[index] = item_data.var_3de03bfa4e76b915;
  }

  function_989fbe51aaf74cb(list_ref);
}

function function_5270193c147bd4f(list_ref, var_e9648468480b0e14, var_e9648768480b14ad) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  var_8ad345cd8693672b = function_9cee54c391590f92(list_ref, var_e9648468480b0e14);
  var_8ad346cd8693695e = function_9cee54c391590f92(list_ref, var_e9648768480b14ad);
  assertex(isDefined(var_8ad345cd8693672b), "Trying to swap list items but <" + var_e9648468480b0e14 + "> does not exist in the list");
  assertex(isDefined(var_8ad346cd8693695e), "Trying to swap list items but <" + var_e9648768480b14ad + "> does not exist in the list");
  index_1 = undefined;
  index_2 = undefined;
  var_ee925786ed8c373f = var_8ad345cd8693672b.var_3de03bfa4e76b915;
  var_ee925886ed8c3972 = var_8ad346cd8693695e.var_3de03bfa4e76b915;

  foreach(index, var_3de03bfa4e76b915 in self.var_a14cb42739301f30[list_ref].list) {
    if(var_3de03bfa4e76b915 == var_ee925786ed8c373f) {
      index_1 = index;
    }

    if(var_3de03bfa4e76b915 == var_ee925886ed8c3972) {
      index_2 = index;
    }
  }

  self.var_a14cb42739301f30[list_ref].list[index_1] = var_8ad346cd8693695e.var_3de03bfa4e76b915;
  self.var_a14cb42739301f30[list_ref].list[index_2] = var_8ad345cd8693672b.var_3de03bfa4e76b915;
  function_989fbe51aaf74cb(list_ref);
}

function function_52c3bc127d006d2a(list_ref, shift_amount) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  list_size = self.var_a14cb42739301f30[list_ref].list.size;
  assertex(list_size >= abs(shift_amount), "Attempting to shift list <" + list_ref + "> by " + shift_amount + "but, only " + list_size + " items exist in the list");
  shift_index = shift_amount;

  if(shift_amount < 0) {
    shift_index += list_size;
  }

  var_50bd74501466d521 = array_slice(self.var_a14cb42739301f30[list_ref].list, 0, shift_index);
  var_50bd71501466ce88 = array_slice(self.var_a14cb42739301f30[list_ref].list, shift_index, list_size);
  self.var_a14cb42739301f30[list_ref].list = array_combine(var_50bd71501466ce88, var_50bd74501466d521);
  function_989fbe51aaf74cb(list_ref);
}

function function_b33be752bae80ae0(list_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  self.var_a14cb42739301f30[list_ref].list = array_reverse(self.var_a14cb42739301f30[list_ref].list);
  function_989fbe51aaf74cb(list_ref);
}

function function_6e7b649d7feb6bb8(list_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  assertex(isDefined(self.var_5805a2cdb3ddbe56) && isDefined(self.var_5805a2cdb3ddbe56[list_ref]), "Tried to get list item refs, but the list <" + list_ref + "> does not currently exist");
  return getarraykeys(self.var_5805a2cdb3ddbe56[list_ref]);
}

function function_58cce4d095e706ab(list_ref, item_ref, var_7a0a75a3e70333fe) {
  assertex(isPlayer(self), "Must be called on a player.");
  function_31a20eb9ab140d08(list_ref, [item_ref], var_7a0a75a3e70333fe);
}

function function_31a20eb9ab140d08(list_ref, list_items, var_7a0a75a3e70333fe) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);

  if(!function_ada0825249682644(list_ref)) {
    return;
  }

  omnvars = [];

  foreach(item_ref in list_items) {
    item_ref = tolower(item_ref);
    var_3de03bfa4e76b915 = function_fbb932b933235b5e(list_ref, item_ref);

    if(isDefined(var_3de03bfa4e76b915)) {
      omnvars[omnvars.size - 1] = var_3de03bfa4e76b915;
    }
  }

  function_2654508daa8b0930(list_ref, omnvars);

  if(istrue(var_7a0a75a3e70333fe) && !function_714a8c636f582042(list_ref)) {
    function_cf43a9641fd024af(list_ref);
  }
}

function function_5df3186604c72b24(list_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);

  if(!function_ada0825249682644(list_ref)) {
    return;
  }

  function_b267732c9e92f306(list_ref);
  self.var_a14cb42739301f30[list_ref].list = [];
  function_b52897e8afbb0968(list_ref, 0);
}

function function_88f7dd62c7058ef5(list_ref, item_ref, param) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "param_");
    function_cc46ab20b75d5c58(param, omnvar, data.widget_types[item_data.widget_type].parameters);
  }
}

function function_1f9e6ee15b7f47c9(list_ref, item_ref, state) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "state_");
    function_cc46ab20b75d5c58(state, omnvar, data.widget_types[item_data.widget_type].states);
  }
}

function function_cee2207c6855e73c(list_ref, item_ref, data_val) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "data_");
    function_cc46ab20b75d5c58(data_val, omnvar);
  }
}

function function_3eec25a52a78f31f(list_ref, item_ref, field_values, no_timestamp) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "data_");
    var_26595f30949d77ee = undefined;

    if(!istrue(no_timestamp)) {
      var_26595f30949d77ee = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "time_");
    }

    function_e375e5ca24ea7bf4(item_data.widget_type, omnvar, field_values, var_26595f30949d77ee);
  }
}

function function_9d1591ce32fb0823(list_ref, item_ref, current_pct, target_pct, time) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "data_");
    var_26595f30949d77ee = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "time_");
    function_ab8c8292f0d469c4(item_data.widget_type, omnvar, current_pct, target_pct, time, var_26595f30949d77ee);
  }
}

function function_6f4f043fa2101c0f(list_ref, item_ref, count, max_count, time) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "data_");
    var_26595f30949d77ee = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "time_");
    function_99bfbb496e5ac12a(item_data.widget_type, omnvar, count, max_count, time, var_26595f30949d77ee);
  }
}

function function_f86a348db854d294(list_ref, item_ref, timestamp) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_9cee54c391590f92(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_a14cb42739301f30[list_ref].group;
    omnvar = function_e5a3c7e8ca795281(group, item_data.var_3de03bfa4e76b915, "time_");
    function_cc46ab20b75d5c58(timestamp, omnvar);
  }
}

function function_91fe3a20ea5f30c5(list_ref, item_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  return isDefined(self.var_5805a2cdb3ddbe56) && isDefined(self.var_5805a2cdb3ddbe56[list_ref]) && isDefined(self.var_5805a2cdb3ddbe56[list_ref][item_ref]);
}

function function_714a8c636f582042(list_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  list_ref = tolower(list_ref);
  return isDefined(self.var_5805a2cdb3ddbe56) && isDefined(self.var_5805a2cdb3ddbe56[list_ref]) && self.var_5805a2cdb3ddbe56[list_ref].size > 0;
}

function function_2acd5041c3f3305e(anchor_ent, widget_ref, widget_type, anchor_type, widget_struct) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();

  if(!isDefined(widget_struct)) {
    widget_struct = spawnStruct();
  }

  widget_struct.ent = anchor_ent;
  widget_struct.anchor_type = anchor_type;
  function_90de31b2cbef19f9(widget_ref, widget_type, widget_struct);
}

function function_d54d04e9ec5b38e3(anchor_ent, widget_ref, param) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_af4f62f0f944a8f1(widget_ref, param);
}

function function_1d125bd1128e9582(anchor_ent, widget_ref, data) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_b52897e8afbb0968(widget_ref, data);
}

function function_ad5527feaeffa977(anchor_ent, widget_ref, state) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_d28fa5295a04d555(widget_ref, state);
}

function function_e426dd1d2fd9f6b5(anchor_ent, widget_ref, field_values, var_54a61fbefc52eb7f) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  return function_1f1c11d26b17770f(widget_ref, field_values, var_54a61fbefc52eb7f);
}

function function_d0cd9bfbc5529d31(anchor_ent, widget_ref, field_values, no_timestamp) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_14a0ee2aaf9128c3(widget_ref, field_values, no_timestamp);
}

function function_7d0a2b811ae8aebd(anchor_ent, widget_ref, current_pct, target_pct, time) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_ddc9d8c3b0ef6b87(widget_ref, current_pct, target_pct, time);
}

function function_34831569ded8586a(anchor_ent, widget_ref, current_pct, bool) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_315df71064cc10b8(widget_ref, current_pct, bool);
}

function function_2b6611deface24de(anchor_ent, widget_ref, current_pct, current_alpha) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_a435f7db4b861f0c(widget_ref, current_pct, current_alpha);
}

function function_5c09e38e4b882a2a(anchor_ent, widget_ref, timestamp) {
  assertex(isPlayer(self), "Must be called on a player.");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_1f51eabeded054f0(widget_ref, timestamp);
}

function function_aae81ea024d45e77(anchor_ent, widget_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  ent_num = anchor_ent getentitynumber();
  widget_ref = tolower(widget_ref) + ent_num;
  function_bb8cf49fbbe8c0d8(widget_ref, ent_num);
}

function function_bb17fbfad71dc49b(anchor_ent) {
  assertex(isPlayer(self), "Must be called on a player.");
  function_984451ca1b1af664(anchor_ent getentitynumber());
}

function function_b76083c9909e209a(anchor_ent, widget_ref) {
  assertex(isPlayer(self), "Must be called on a player.");
  ent_num = anchor_ent getentitynumber();
  widget_ref = tolower(widget_ref) + ent_num;
  return isDefined(self.var_414b9a0d57c1e081) && isDefined(self.var_414b9a0d57c1e081[ent_num]) && isDefined(self.var_414b9a0d57c1e081[ent_num][widget_ref]);
}

function private function_bb8cf49fbbe8c0d8(widget_ref, ent_num) {
  if(isDefined(self.var_414b9a0d57c1e081[ent_num])) {
    if(isDefined(self.var_414b9a0d57c1e081[ent_num][widget_ref])) {
      function_fb3c9a259f146781(widget_ref);
    }

    self.var_414b9a0d57c1e081[ent_num][widget_ref] = undefined;

    if(self.var_414b9a0d57c1e081[ent_num].size == 0) {
      self.var_414b9a0d57c1e081[ent_num] = undefined;
      self notify("_automatic_remove_anchored_widget_" + ent_num);
    }
  }
}

function private function_984451ca1b1af664(ent_num) {
  if(isDefined(self.var_414b9a0d57c1e081) && isDefined(self.var_414b9a0d57c1e081[ent_num])) {
    foreach(index in self.var_414b9a0d57c1e081[ent_num]) {
      function_fb3c9a259f146781(widget_ref);
    }

    self.var_414b9a0d57c1e081[ent_num] = undefined;
    self notify("_automatic_remove_anchored_widget_" + ent_num);
  }
}

function private function_583777ac2b762d3(ent) {
  if(isPlayer(self)) {
    self endon("disconnected");
  }

  ent_num = ent getentitynumber();
  self notify("_automatic_remove_anchored_widget_" + ent_num);
  self endon("_automatic_remove_anchored_widget_" + ent_num);
  ent waittill_any("death", "disconnected", "deleted");
  thread function_984451ca1b1af664(ent_num);
}

function private function_b36e048ccaca2da4(value, archetype, field, packed_value, clear) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  assertex(isDefined(data[archetype]), "Trying to set anchored widget archetype field values for archetype <" + archetype + "> which does not exist.");
  assertex(isDefined(data[archetype][field]), "Trying to set anchored widget archetype field value for archetype < " + archetype + "> when field <" + field + "> does not exist.");

  if(value > data[archetype][field].max_value) {
    assert("Max value for widget archetype <" + archetype + ">, field <" + field + "> exceeded.Value is " + value + ".Max value is " + data[archetype][field].max_value + ".Clamping to max value.");
    value = data[archetype][field].max_value;
  }

  value /= data[archetype][field].step_increment;
  value = int(value);

  if(istrue(clear)) {
    packed_value &= ~data[archetype][field].mask;
  }

  packed_value |= value << data[archetype][field].shift;
  return packed_value;
}

function private function_f58cb12303817e47(value, archetype, field) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  assertex(isDefined(data[archetype]), "Trying to set anchored widget archetype field values for archetype <" + archetype + "> which does not exist.");
  assertex(isDefined(data[archetype][field]), "Trying to set anchored widget archetype field value for archetype < " + archetype + "> when field <" + field + "> does not exist.");
  value = (value &data[archetype][field].mask) >> data[archetype][field].shift;
  value *= data[archetype][field].step_increment;
  return value;
}

function private function_e375e5ca24ea7bf4(widget_type, omnvar, field_values, var_26595f30949d77ee) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  assertex(isDefined(data.widget_types[widget_type]), "Widget type <" + widget_type + "> does not exist.");
  archetype = data.widget_types[widget_type].archetype;
  assertex(isDefined(archetype), "Widget type <" + widget_type + "> is not an archetype.");
  packed_value = 0;

  foreach(field, value in field_values) {
    assertex(isDefined(widget_archetypes[archetype][field]), "Field <" + field + "> is not a valid field for archetype <" + archetype + ">.");
    value = clamp(value, 0, widget_archetypes[archetype][field].max_value);
    packed_value = function_b36e048ccaca2da4(value, archetype, field, packed_value);
  }

  self setclientomnvar(omnvar, packed_value);

  if(isDefined(var_26595f30949d77ee)) {
    self setclientomnvar(var_26595f30949d77ee, gettime());
  }
}

function private function_e6df6627eb26284f(widget_type, omnvar, field, value) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  assertex(isDefined(data.widget_types[widget_type]), "Widget type <" + widget_type + "> does not exist.");
  archetype = data.widget_types[widget_type].archetype;
  assertex(isDefined(archetype), "Widget type <" + widget_type + "> is not an archetype.");
  packed_value = self getclientomnvar(omnvar);
  assertex(isDefined(widget_archetypes[archetype][field]), "Field <" + field + "> is not a valid field for archetype <" + archetype + ">.");
  value = clamp(value, 0, widget_archetypes[archetype][field].max_value);
  packed_value = function_b36e048ccaca2da4(value, archetype, field, packed_value, 1);
  self setclientomnvar(omnvar, packed_value);
}

function private function_61dda643ffbb43a0(widget_type, omnvar, fields) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  assertex(isDefined(data.widget_types[widget_type]), "Widget type <" + widget_type + "> does not exist.");
  archetype = data.widget_types[widget_type].archetype;
  assertex(isDefined(archetype), "Widget type <" + widget_type + "> is not an archetype.");
  value = self getclientomnvar(omnvar);
  ret_fields = [];

  if(isDefined(fields)) {
    foreach(field in fields) {
      assertex(isDefined(widget_archetypes[archetype][field]), "Field <" + field + "> is not a valid field for archetype <" + archetype + ">.");
      ret_fields[field] = function_f58cb12303817e47(value, archetype, field);
    }
  } else {
    foreach(field, unused in widget_archetypes[archetype]) {
      ret_fields[field] = function_f58cb12303817e47(value, archetype, field);
    }
  }

  return ret_fields;
}

function private function_ab8c8292f0d469c4(widget_type, omnvar, current_pct, target_pct, time, var_26595f30949d77ee) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  archetype = "scripted_widget_archetype_progress";
  assertex(data.widget_types[widget_type].archetype == archetype, "Widget type <" + widget_type + "> is not a <" + archetype + "> archetype widget");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["current_pct"].max_value);
  target_pct = clamp(target_pct, 0, widget_archetypes[archetype]["target_pct"].max_value);
  packed_value = 0;
  packed_value = function_b36e048ccaca2da4(current_pct, archetype, "current_pct", packed_value);
  packed_value = function_b36e048ccaca2da4(target_pct, archetype, "target_pct", packed_value);
  packed_value = function_b36e048ccaca2da4(time, archetype, "time", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(var_26595f30949d77ee, gettime());
}

function private function_42866bf1e84c1d21(widget_type, omnvar, current_pct, bool, var_26595f30949d77ee) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  archetype = "scripted_widget_archetype_progress_bool";
  assertex(data.widget_types[widget_type].archetype == archetype, "Widget type <" + widget_type + "> is not a <" + archetype + "> archetype widget");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["current_pct"].max_value);
  packed_value = 0;
  packed_value = function_b36e048ccaca2da4(current_pct, archetype, "current_pct", packed_value);
  packed_value = function_b36e048ccaca2da4(bool, archetype, "bool", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(var_26595f30949d77ee, gettime());
}

function private function_7db1020b4d70e9e7(widget_type, omnvar, current_pct, current_alpha, var_26595f30949d77ee) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  archetype = "scripted_widget_archetype_progress_alpha";
  assertex(data.widget_types[widget_type].archetype == archetype, "Widget type <" + widget_type + "> is not a <" + archetype + "> archetype widget");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["current_pct"].max_value);
  current_alpha = clamp(current_alpha, 0, widget_archetypes[archetype]["current_alpha"].max_value);
  packed_value = 0;
  packed_value = function_b36e048ccaca2da4(current_pct, archetype, "current_pct", packed_value);
  packed_value = function_b36e048ccaca2da4(current_alpha, archetype, "current_alpha", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(var_26595f30949d77ee, gettime());
}

function private function_99bfbb496e5ac12a(widget_type, omnvar, count, max_count, time, var_26595f30949d77ee) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  archetype = "scripted_widget_archetype_count";
  assertex(data.widget_types[widget_type].archetype == archetype, "Widget type <" + widget_type + "> is not a <" + archetype + "> archetype widget");
  count = clamp(count, 0, widget_archetypes[archetype]["count"].max_value);

  if(isDefined(max_count)) {
    max_count = clamp(max_count, 0, widget_archetypes[archetype]["max_count"].max_value);
  } else {
    max_count = 0;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  packed_value = 0;
  packed_value = function_b36e048ccaca2da4(count, archetype, "count", packed_value);
  packed_value = function_b36e048ccaca2da4(max_count, archetype, "max_count", packed_value);
  packed_value = function_b36e048ccaca2da4(time, archetype, "time", packed_value);
  self setclientomnvar(omnvar, packed_value);

  if(time > 0 && isDefined(var_26595f30949d77ee)) {
    self setclientomnvar(var_26595f30949d77ee, gettime());
  }
}

function private function_36bba30ae80af891(widget_type, omnvar, horizontal_alignment, vertical_alignment) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  widget_archetypes = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.archetypes;
  archetype = "scripted_widget_archetype_list_item_alignment";
  assertex(data.widget_types[widget_type].archetype == archetype, "Widget type <" + widget_type + "> is not a <" + archetype + "> archetype widget");
  horizontal_alignment = clamp(horizontal_alignment, 0, widget_archetypes[archetype]["horizontal_alignment"].max_value);
  vertical_alignment = clamp(vertical_alignment, 0, widget_archetypes[archetype]["vertical_alignment"].max_value);
  packed_value = 0;
  packed_value = function_b36e048ccaca2da4(horizontal_alignment, archetype, "horizontal_alignment", packed_value);
  packed_value = function_b36e048ccaca2da4(vertical_alignment, archetype, "vertical_alignment", packed_value);
  self setclientomnvar(omnvar, packed_value);
}

function private function_cc46ab20b75d5c58(value, omnvar, ref_table, mask, shift) {
  if(isint(value)) {
    value = value;
  } else if(isDefined(ref_table)) {
    value = ref_table[tolower(value)];
  }

  if(isint(value)) {
    if(isDefined(shift)) {
      value <<= shift;
    }

    if(isDefined(mask)) {
      var_24db96216c5f6124 = self getclientomnvar(omnvar);
      var_24db96216c5f6124 &= ~mask;
      value |= var_24db96216c5f6124;
    }

    self setclientomnvar(omnvar, value);
  }
}

function private function_f801c3e967c7768a(widget, shouldhide) {
  if(!isDefined(self.var_5b0479a29905e04d)) {
    self.var_5b0479a29905e04d = [];
  }

  if(!isDefined(self.var_5b0479a29905e04d[widget])) {
    self.var_5b0479a29905e04d[widget] = 0;
  }

  if(!shouldhide) {
    if(self.var_5b0479a29905e04d[widget] > 0) {
      self.var_5b0479a29905e04d[widget]--;
    }
  } else {
    self.var_5b0479a29905e04d[widget]++;
  }

  return self.var_5b0479a29905e04d[widget] > 0;
}

function private function_f94203b920f0ba27(widget_ref, widget_type) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  index = undefined;
  assertex(isPlayer(self), "Hud management functions other than init must be called on a player");

  if(!isDefined(self.var_a219288779b991ce)) {
    self.var_a219288779b991ce = [];

    for(i = 0; i < data.var_4dc78c94cd673b03; i++) {
      self.var_a219288779b991ce[i] = i;
    }
  }

  if(!isDefined(self.var_a14cb42739301f30)) {
    self.var_a14cb42739301f30 = [];
  }

  if(self.var_a219288779b991ce.size > 0) {
    index = self.var_a219288779b991ce[0];
    self.var_a219288779b991ce = array_remove_index(self.var_a219288779b991ce, 0);
    self.var_a14cb42739301f30[widget_ref] = spawnStruct();
    self.var_a14cb42739301f30[widget_ref].index = index;
    self.var_a14cb42739301f30[widget_ref].widget_type = widget_type;
    function_f77df8178a108beb(index);
  }

  return index;
}

function private function_cca9604860a60e2a(widget_ref) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  index = undefined;
  assertex(isPlayer(self), "Hud management functions other than init must be called on a player");

  if(isDefined(self.var_a14cb42739301f30[widget_ref])) {
    index = self.var_a14cb42739301f30[widget_ref].index;
  }

  if(isDefined(index)) {
    self.var_a219288779b991ce[self.var_a219288779b991ce.size] = index;
    self.var_a14cb42739301f30[widget_ref] = undefined;
  }

  return index;
}

function private scripted_widget_closed(index) {
  foreach(data in self.var_a14cb42739301f30) {
    if(data.index == index) {
      thread function_fb3c9a259f146781(widget_ref);
      return;
    }
  }
}

function private function_f77df8178a108beb(index) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;
  var_94a50c0a0059e601 = "ui_scripted_widget_" + "type_" + index;
  var_418596c509f2b084 = "ui_scripted_widget_" + "param_" + index;
  var_fb6072b6259477f9 = "ui_scripted_widget_" + "data_" + index;
  var_8b4b1b0e9bbc298 = "ui_scripted_widget_" + "state_" + index;
  var_26595f30949d77ee = "ui_scripted_widget_" + "time_" + index;
  var_6a79480548de351c = "ui_scripted_widget_" + "position_" + index;
  var_25bcde66ae59b81d = "ui_scripted_widget_" + "priority_" + index;
  var_2486ed5c4df7182c = "ui_scripted_widget_" + "ent_" + index;
  var_5410df86be1ea9f = "ui_scripted_widget_" + "under_hud_" + index;
  self setclientomnvar(var_94a50c0a0059e601, 0);
  self setclientomnvar(var_418596c509f2b084, 0);
  self setclientomnvar(var_fb6072b6259477f9, 0);
  self setclientomnvar(var_8b4b1b0e9bbc298, 0);
  self setclientomnvar(var_26595f30949d77ee, 0);
  self setclientomnvar(var_6a79480548de351c, 0);
  self setclientomnvar(var_25bcde66ae59b81d, 0);
  self setclientomnvar(var_2486ed5c4df7182c, undefined);
  self setclientomnvar(var_5410df86be1ea9f, 0);
}

function private function_eabc5d231d49caab(list_ref, item_ref, widget_type) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887;
  var_3de03bfa4e76b915 = undefined;

  if(!isDefined(self.var_1dcdf3ab55136138)) {
    self.var_1dcdf3ab55136138 = [];
    var_73e244a1fc96fa27 = 8;

    if(data.num_groups > 1) {
      var_73e244a1fc96fa27 -= 1;
    }

    for(i = 0; i < data.max_items; i++) {
      group = int(floor(i / var_73e244a1fc96fa27));
      index = i % var_73e244a1fc96fa27;

      if(!isDefined(self.var_1dcdf3ab55136138[group])) {
        self.var_1dcdf3ab55136138[group] = [];
      }

      self.var_1dcdf3ab55136138[group][index] = index + 1;
    }
  }

  if(!isDefined(self.var_5805a2cdb3ddbe56)) {
    self.var_5805a2cdb3ddbe56 = [];
  }

  if(!isDefined(self.var_a14cb42739301f30[list_ref].group)) {
    best_group = undefined;
    var_74a5ab73c5ee76c9 = 0;

    for(i = 0; i < data.num_groups; i++) {
      group_size = self.var_1dcdf3ab55136138[i].size;

      if(group_size > var_74a5ab73c5ee76c9) {
        best_group = i;
        var_74a5ab73c5ee76c9 = group_size;
      }
    }

    if(!isDefined(best_group)) {
      return undefined;
    }

    function_91905deae6454c5d(list_ref, best_group);
  }

  group = self.var_a14cb42739301f30[list_ref].group;
  array_index = self.var_1dcdf3ab55136138[group].size - 1;

  if(array_index >= 0) {
    var_3de03bfa4e76b915 = self.var_1dcdf3ab55136138[group][array_index];
    self.var_1dcdf3ab55136138[group][array_index] = undefined;

    if(!isDefined(self.var_5805a2cdb3ddbe56[list_ref])) {
      self.var_5805a2cdb3ddbe56[list_ref] = [];
    }

    self.var_5805a2cdb3ddbe56[list_ref][item_ref] = spawnStruct();
    self.var_5805a2cdb3ddbe56[list_ref][item_ref].var_3de03bfa4e76b915 = var_3de03bfa4e76b915;
    self.var_5805a2cdb3ddbe56[list_ref][item_ref].widget_type = widget_type;
    function_496f711a9ab7a47f(group, var_3de03bfa4e76b915);
  }

  return var_3de03bfa4e76b915;
}

function private function_91905deae6454c5d(list_ref, group_index) {
  group_mask = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887.group_mask;
  group_shift = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887.group_shift;

  if(isDefined(group_mask) && isDefined(group_shift)) {
    omnvar = "ui_scripted_widget_" + "data_" + self.var_a14cb42739301f30[list_ref].index;
    function_cc46ab20b75d5c58(group_index, omnvar, undefined, group_mask, group_shift);
  }

  self.var_a14cb42739301f30[list_ref].group = group_index;
}

function private function_fbb932b933235b5e(list_ref, item_ref) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887;
  var_3de03bfa4e76b915 = undefined;

  if(isDefined(self.var_5805a2cdb3ddbe56[list_ref]) && isDefined(self.var_5805a2cdb3ddbe56[list_ref][item_ref])) {
    var_3de03bfa4e76b915 = self.var_5805a2cdb3ddbe56[list_ref][item_ref].var_3de03bfa4e76b915;

    if(isDefined(var_3de03bfa4e76b915)) {
      group = self.var_a14cb42739301f30[list_ref].group;
      self.var_1dcdf3ab55136138[group][self.var_1dcdf3ab55136138[group].size] = var_3de03bfa4e76b915;
      self.var_5805a2cdb3ddbe56[list_ref][item_ref] = undefined;

      if(self.var_5805a2cdb3ddbe56[list_ref].size == 0) {
        self.var_5805a2cdb3ddbe56[list_ref] = undefined;
      }
    }
  }

  return var_3de03bfa4e76b915;
}

function private function_b267732c9e92f306(list_ref) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887;

  if(isDefined(self.var_5805a2cdb3ddbe56[list_ref])) {
    if(self.var_5805a2cdb3ddbe56[list_ref].size > 0) {
      group = self.var_a14cb42739301f30[list_ref].group;

      foreach(item_data in self.var_5805a2cdb3ddbe56[list_ref]) {
        self.var_1dcdf3ab55136138[group][self.var_1dcdf3ab55136138[group].size] = item_data.var_3de03bfa4e76b915;
      }
    }

    self.var_5805a2cdb3ddbe56[list_ref] = undefined;
  }
}

function private function_5afd39d9a06be177(list_ref, items, omnvars, var_3cefc2b0c7f6f3ec) {
  if(istrue(var_3cefc2b0c7f6f3ec)) {
    self.var_a14cb42739301f30[list_ref].list = array_combine(omnvars, self.var_a14cb42739301f30[list_ref].list);
  } else {
    self.var_a14cb42739301f30[list_ref].list = array_combine(self.var_a14cb42739301f30[list_ref].list, omnvars);
  }

  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d;

  foreach(item in items) {
    var_94a50c0a0059e601 = function_e5a3c7e8ca795281(self.var_a14cb42739301f30[list_ref].group, omnvars[index], "type_");
    self setclientomnvar(var_94a50c0a0059e601, data.widget_types[item].index);
  }

  function_989fbe51aaf74cb(list_ref);
}

function private function_2654508daa8b0930(list_ref, items) {
  self.var_a14cb42739301f30[list_ref].list = array_remove_array(self.var_a14cb42739301f30[list_ref].list, items);
  function_989fbe51aaf74cb(list_ref);
}

function private function_989fbe51aaf74cb(list_ref) {
  max_items = 8;
  value = 0;

  if(level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887.num_groups > 1) {
    max_items -= 1;
    value = self.var_a14cb42739301f30[list_ref].group << level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887.group_shift;
  }

  list = self.var_a14cb42739301f30[list_ref].list;

  for(i = 0; i < max_items; i++) {
    if(isDefined(list[i])) {
      value |= list[i] << 4 * i;
    }
  }

  function_b52897e8afbb0968(list_ref, value);
}

function private function_496f711a9ab7a47f(group, var_3de03bfa4e76b915) {
  var_3de03bfa4e76b915 = function_3e551e16074e030e(group, var_3de03bfa4e76b915);
  var_94a50c0a0059e601 = "ui_scripted_list_item_" + "type_" + var_3de03bfa4e76b915;
  var_418596c509f2b084 = "ui_scripted_list_item_" + "param_" + var_3de03bfa4e76b915;
  var_fb6072b6259477f9 = "ui_scripted_list_item_" + "data_" + var_3de03bfa4e76b915;
  var_8b4b1b0e9bbc298 = "ui_scripted_list_item_" + "state_" + var_3de03bfa4e76b915;
  var_26595f30949d77ee = "ui_scripted_list_item_" + "time_" + var_3de03bfa4e76b915;
  self setclientomnvar(var_94a50c0a0059e601, 0);
  self setclientomnvar(var_418596c509f2b084, 0);
  self setclientomnvar(var_fb6072b6259477f9, 0);
  self setclientomnvar(var_8b4b1b0e9bbc298, 0);
  self setclientomnvar(var_26595f30949d77ee, 0);
}

function private function_3e551e16074e030e(group, index) {
  return index + group * 8;
}

function private function_e5a3c7e8ca795281(group, var_3de03bfa4e76b915, var_a79e2ddd22fbba9a) {
  var_3de03bfa4e76b915 = function_3e551e16074e030e(group, var_3de03bfa4e76b915);
  return "ui_scripted_list_item_" + var_a79e2ddd22fbba9a + var_3de03bfa4e76b915;
}

function private function_9cee54c391590f92(list_ref, item_ref) {
  data = level.var_6917e6eed10cfc44.var_44c1d0100b18dd6d.var_56a961d04403887;

  if(isDefined(self.var_5805a2cdb3ddbe56) && isDefined(self.var_5805a2cdb3ddbe56[list_ref]) && isDefined(self.var_5805a2cdb3ddbe56[list_ref][item_ref])) {
    return self.var_5805a2cdb3ddbe56[list_ref][item_ref];
  }

  return undefined;
}