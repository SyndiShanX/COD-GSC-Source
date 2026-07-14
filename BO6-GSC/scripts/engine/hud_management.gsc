/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\hud_management.gsc
*********************************************/

#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace hud_management;

function private function_2d20c0dad32ec5b7() {
  if(!isDefined(level.hud_management)) {
    level.hud_management = spawnStruct();
  }

  if(!isDefined(level.hud_management.scripted_widgets)) {
    level.hud_management.scripted_widgets = spawnStruct();
  }

  function_133c4012464712af();
  function_57e4f7fc5f4843d1();
  ui::lui_registercallback("/\x88WY\xb9\xce\x96\x16`\nt\xba\x96\xdd\xe0\x7f\x17\xa0\xdb\f\x1b\xda", &scripted_widget_closed);
  level utility::flag_set("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  level thread function_8cc8282adf04ed07();
}

function private function_133c4012464712af() {
  scripted_widgets = getscriptbundlenames("N\xc9u\x06\x8eP\x83\x94>\xc4\r\x92\x94\xb1");
  archetypes = getscriptbundlenames("\xce\xc8v\x8a^5&E\xcf<?%\xf65,^\xb6>\x17~V\xad$");
  anchors = getscriptbundlenames("\b\x11\xe6\x88W4\xe7T\xc3\x87\x1d>9V\x8d]-\"d\xa4\xd6\xa8\x18L\xef=5\xe2");
  data = level.hud_management.scripted_widgets;
  data.widget_types = [];
  data.anchor_types = [];
  data.archetypes = [];
  data.var_added61db3cfe2ee = spawnStruct();
  project_bundle = getprojectscriptbundle();
  var_b3a89a684bcb5b5 = getgamemodescriptbundle();
  var_9a8a95b35eff4a94 = getgametypescriptbundle();
  var_87f68b92f16e6d6e = function_cbe75068ad1ba418();

  if(!isDefined(var_87f68b92f16e6d6e)) {
    var_87f68b92f16e6d6e = getmapinfobundle(getDvar(@ "ui_mapname"));
  }

  if(isDefined(var_87f68b92f16e6d6e) && isDefined(var_87f68b92f16e6d6e.scriptedwidgetsmax) && var_87f68b92f16e6d6e.scriptedwidgetsmax > 0) {
    data.max_widgets = var_87f68b92f16e6d6e.scriptedwidgetsmax;
  } else if(isDefined(var_9a8a95b35eff4a94) && isDefined(var_9a8a95b35eff4a94.scriptedwidgetsmax) && var_9a8a95b35eff4a94.scriptedwidgetsmax > 0) {
    data.max_widgets = var_9a8a95b35eff4a94.scriptedwidgetsmax;
  } else if(isDefined(var_b3a89a684bcb5b5) && isDefined(var_b3a89a684bcb5b5.scriptedwidgetsmax) && var_b3a89a684bcb5b5.scriptedwidgetsmax > 0) {
    data.max_widgets = var_b3a89a684bcb5b5.scriptedwidgetsmax;
  } else if(isDefined(project_bundle) && isDefined(project_bundle.scriptedwidgetsmax) && project_bundle.scriptedwidgetsmax > 0) {
    data.max_widgets = project_bundle.scriptedwidgetsmax;
  }

  var_31716a5f18bb49f = 0;

  if(isDefined(var_87f68b92f16e6d6e) && isDefined(var_87f68b92f16e6d6e.var_8085f521a767ad40) && var_87f68b92f16e6d6e.var_8085f521a767ad40 > 0) {
    var_31716a5f18bb49f = var_87f68b92f16e6d6e.var_8085f521a767ad40;
  } else if(isDefined(var_9a8a95b35eff4a94) && isDefined(var_9a8a95b35eff4a94.var_8085f521a767ad40) && var_9a8a95b35eff4a94.var_8085f521a767ad40 > 0) {
    var_31716a5f18bb49f = var_9a8a95b35eff4a94.var_8085f521a767ad40;
  } else if(isDefined(var_b3a89a684bcb5b5) && isDefined(var_b3a89a684bcb5b5.var_8085f521a767ad40) && var_b3a89a684bcb5b5.var_8085f521a767ad40 > 0) {
    var_31716a5f18bb49f = var_b3a89a684bcb5b5.var_8085f521a767ad40;
  } else if(isDefined(project_bundle) && isDefined(project_bundle.var_8085f521a767ad40) && project_bundle.var_8085f521a767ad40 > 0) {
    var_31716a5f18bb49f = project_bundle.var_8085f521a767ad40;
  }

  if(isDefined(archetypes)) {
    foreach(archetype in archetypes) {
      archetype_data = getscriptbundle(archetype);

      if(isDefined(archetype_data) && !isDefined(data.archetypes[archetype])) {
        data.archetypes[archetype] = [];
        shift = 0;

        foreach(field_data in archetype_data.fields) {
          field = tolower(field_data.field_name);
          max_value = field_data.max_value ?? 0;
          step_increment = field_data.step_increment ?? 0;

          if(istrue(field_data.datasource_only)) {
            continue;
          }

          assert(step_increment > 0, "<dev string:x24>" + getxhashsourcename(archetype) + "<dev string:x4d>");
          assert(max_value >= step_increment, "<dev string:x69>" + max_value + "<dev string:x7c>" + getxhashsourcename(archetype) + "<dev string:x98>" + field + "<dev string:xa6>" + step_increment + "<dev string:xca>" + step_increment);

          max_value = max(max_value, step_increment);
          bits = int(ceil(log(max_value / step_increment + 1) / log(2)));
          data.archetypes[archetype][field] = spawnStruct();
          data.archetypes[archetype][field].bits = bits;
          data.archetypes[archetype][field].max_value = max_value;
          data.archetypes[archetype][field].step_increment = step_increment;
          data.archetypes[archetype][field].shift = shift;
          data.archetypes[archetype][field].mask = (1 << bits) - 1 << shift;
          shift += bits;
          assert(shift <= 32, "<dev string:xe6>" + getxhashsourcename(archetype) + "<dev string:xfb>" + getxhashsourcename(archetype) + "<dev string:x158>");
        }
      }
    }
  }

  if(isDefined(anchors)) {
    sorted_anchors = tablesort(anchors, "\xf3\xf2");

    foreach(index in sorted_anchors) {
      anchor = anchors[index];
      anchor_data = getscriptbundle(anchor);

      if(isDefined(anchor_data) && !isDefined(data.anchor_types[anchor])) {
        data.anchor_types[anchor] = data.anchor_types.size;
      }
    }
  }

  if(isDefined(scripted_widgets)) {
    sorted_widgets = tablesort(scripted_widgets, "\xf3\xf2");

    foreach(index in sorted_widgets) {
      widget = scripted_widgets[index];
      function_ca129f06335769a9(widget);
    }
  }

  if(var_31716a5f18bb49f > 0) {
    data.var_added61db3cfe2ee.max_items = var_31716a5f18bb49f;
    data.var_added61db3cfe2ee.num_groups = ceil(data.var_added61db3cfe2ee.max_items / 8);
    data.var_added61db3cfe2ee.group_mask = 0;
    data.var_added61db3cfe2ee.group_shift = 0;

    if(data.var_added61db3cfe2ee.num_groups > 1) {
      data.var_added61db3cfe2ee.group_mask = 8;
      data.var_added61db3cfe2ee.group_shift = int(28);
    }
  }
}

function private function_ecdaed975ae82b38(var_7348e0a29b80faf1) {
  array = [];

  if(isDefined(var_7348e0a29b80faf1)) {
    foreach(misc_data in var_7348e0a29b80faf1) {
      misc_data = misc_data.variant_object;

      if(isDefined(misc_data.property) && misc_data.property != "") {
        value = undefined;

        switch (misc_data.type) {
          case #"hash_120af2941803a2b":
            value = misc_data.value ?? 0;
            break;
          case #"hash_455ccc950900cae8":
            value = misc_data.value ?? 0;
            break;
          case #"hash_87ced1a3afbc3ba1":
            value = misc_data.value ?? #;
            break;
          case #"hash_8ef77f2da495e04f":
            value = misc_data.value ?? % "";
            break;
          case #"hash_25635f2a80ce6a01":
            value = misc_data.value ?? "\"\xbc\xbbv\xeb(T";
            break;
          case #"hash_9ce7ad58b9823a18":
            value = (misc_data.x ?? 0, misc_data.y ?? 0, 0);
            break;
          case #"hash_10697103af7d0577":
            value = (misc_data.x ?? 0, misc_data.y ?? 0, misc_data.z ?? 0);
            break;
          case #"hash_c276b9a9063829a2":
            value = misc_data.value ?? % "";
            break;
          case #"hash_5b9df8c05b775dc0":
            value = misc_data.value ?? 0;
            break;
          case #"hash_379c3f7bd8753e3d":
          case #"hash_feddb7e37b672d56":
            value = misc_data.value ?? "";
            break;
        }

        if(isDefined(value)) {
          array[tolower(misc_data.property)] = {
            #value: value, #index: index
          };
        }
      }
    }
  }

  return array;
}

function private function_ca129f06335769a9(widget) {
  data = level.hud_management.scripted_widgets;

  if(!isxhashasset(widget)) {
    widget = hashcat(%"scriptedwidget:", widget);
  }

  widget_data = getscriptbundle(widget);

  if(isDefined(widget_data) && !isDefined(data.widget_types[widget])) {
    widget_struct = spawnStruct();
    data.widget_types[widget] = widget_struct;
    widget_struct.index = data.widget_types.size;

    if(isDefined(widget_data.archetype)) {
      widget_struct.archetype = widget_data.archetype;
    }

    widget_struct.parameters = [];

    if(isDefined(widget_data.parameters)) {
      foreach(param in widget_data.parameters) {
        if(isDefined(param.name) && param.name != "") {
          widget_struct.parameters[tolower(param.name)] = param_index;
        }
      }
    }

    widget_struct.states = [];

    if(isDefined(widget_data.states)) {
      foreach(state in widget_data.states) {
        if(isDefined(state.name) && state.name != "") {
          widget_struct.states[tolower(state.name)] = state_index;
        }
      }
    }

    widget_struct.children = [];

    if(isDefined(widget_data.children)) {
      foreach(child in widget_data.children) {
        if(isDefined(child.name) && child.name != "") {
          child_struct = spawnStruct();
          child_name = tolower(child.name);
          widget_struct.children[child_name] = child_struct;
          child_struct.omnvar_sets = [];
          child_struct.widgets = [];

          foreach(omnvar_set in child.omnvarsets) {
            if(isDefined(omnvar_set.name)) {
              var_229eeb93477476ea = spawnStruct();
              var_51c570d3e7502b38 = tolower(omnvar_set.name);
              child_struct.omnvar_sets[var_51c570d3e7502b38] = var_229eeb93477476ea;
              var_229eeb93477476ea.set_num = omnvar_set.setnum;
              var_229eeb93477476ea.omnvars = [];

              foreach(omnvar_data in omnvar_set.omnvars) {
                omnvar_data = omnvar_data.variant_object;

                if(isDefined(omnvar_data.ref) && omnvar_data.ref != "") {
                  var_229eeb93477476ea.omnvars[omnvar_data.ref] = {
                    #max_value: omnvar_data.max_value ?? 0, #min_value: omnvar_data.minvalue ?? 0, #default_value: omnvar_data.value ?? 0, #name: omnvar_data.name
                  };
                }
              }

              var_229eeb93477476ea.misc_data = function_ecdaed975ae82b38(omnvar_set.miscdata);
            }
          }

          foreach(child_widget in child.widgets) {
            if(isDefined(child_widget.name)) {
              var_6352a4da6d00b27f = spawnStruct();
              var_210c3faf177c3819 = tolower(child_widget.name);
              child_struct.widgets[var_210c3faf177c3819] = var_6352a4da6d00b27f;
              var_6352a4da6d00b27f.index = var_a1b995c9fc3a6790 + 1;
              var_6352a4da6d00b27f.widget = child_widget.scriptedwidget;
              function_ca129f06335769a9(child_widget.scriptedwidget);
            }
          }

          child_struct.misc_data = function_ecdaed975ae82b38(child.miscdata);
        }
      }
    }
  }
}

function function_6b541ec4e8abf983(widget_name, child_name, var_210c3faf177c3819) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");

  if(!isxhashasset(widget_name)) {
    widget_name = hashcat(%"scriptedwidget:", widget_name);
  }

  child_name = tolower(child_name);
  var_210c3faf177c3819 = tolower(var_210c3faf177c3819);

  if(isDefined(level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].widgets[var_210c3faf177c3819])) {
    return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].widgets[var_210c3faf177c3819].widget;
  }

  return undefined;
}

function function_82bc555407efe4fd(widget_name, child_name, var_210c3faf177c3819) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");

  if(!isxhashasset(widget_name)) {
    widget_name = hashcat(%"scriptedwidget:", widget_name);
  }

  child_name = tolower(child_name);
  var_210c3faf177c3819 = tolower(var_210c3faf177c3819);

  if(isDefined(level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].widgets[var_210c3faf177c3819])) {
    return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].widgets[var_210c3faf177c3819].index;
  }

  return undefined;
}

function function_387c7ccb924458e5(widget_name, child_name, var_51c570d3e7502b38) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");

  if(!isxhashasset(widget_name)) {
    widget_name = hashcat(%"scriptedwidget:", widget_name);
  }

  child_name = tolower(child_name);

  if(isDefined(var_51c570d3e7502b38)) {
    var_51c570d3e7502b38 = tolower(var_51c570d3e7502b38);
  }

  if(isDefined(level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name])) {
    if(isDefined(var_51c570d3e7502b38)) {
      return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].omnvar_sets[var_51c570d3e7502b38];
    } else {
      return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].omnvar_sets;
    }
  }

  return undefined;
}

function function_a6d447d45572370d(widget_name, child_name, var_51c570d3e7502b38) {
  var_9729ee0c534cc927 = function_387c7ccb924458e5(widget_name, child_name, var_51c570d3e7502b38);

  if(isDefined(var_9729ee0c534cc927)) {
    return (var_9729ee0c534cc927.set_num ?? 1);
  }

  return undefined;
}

function function_2d30d3e4449a6631(widget_name, child_name, var_51c570d3e7502b38, omnvar_name) {
  var_9729ee0c534cc927 = function_387c7ccb924458e5(widget_name, child_name, var_51c570d3e7502b38);

  if(isDefined(var_9729ee0c534cc927) && (isarray(var_9729ee0c534cc927) || isDefined(var_9729ee0c534cc927.omnvars))) {
    if(isarray(var_9729ee0c534cc927)) {
      return var_9729ee0c534cc927;
    } else if(isDefined(omnvar_name) && omnvar_name != "") {
      return var_9729ee0c534cc927.omnvars[omnvar_name];
    } else {
      return var_9729ee0c534cc927.omnvars;
    }
  }

  return undefined;
}

function function_7172f6b48dd096ec(widget_name, child_name, var_51c570d3e7502b38, misc_property) {
  var_9729ee0c534cc927 = function_387c7ccb924458e5(widget_name, child_name, var_51c570d3e7502b38);

  if(isDefined(var_9729ee0c534cc927) && isDefined(var_9729ee0c534cc927.misc_data)) {
    if(isDefined(misc_property) && misc_property != "") {
      return var_9729ee0c534cc927.misc_data[misc_property];
    } else {
      return var_9729ee0c534cc927.misc_data;
    }
  }

  return undefined;
}

function function_746f27d6042f857d(widget_name, child_name, misc_property) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");

  if(!isxhashasset(widget_name)) {
    widget_name = hashcat(%"scriptedwidget:", widget_name);
  }

  child_name = tolower(child_name);

  if(isDefined(level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].misc_data)) {
    if(isDefined(misc_property) && misc_property != "") {
      return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].misc_data[misc_property];
    } else {
      return level.hud_management.scripted_widgets.widget_types[widget_name].children[child_name].misc_data;
    }
  }

  return undefined;
}

function private function_57e4f7fc5f4843d1() {
  var_b3a89a684bcb5b5 = getgamemodescriptbundle();

  if(!isDefined(level.hud_management)) {
    level.hud_management = spawnStruct();
  }

  if(!isDefined(level.hud_management.var_47490eb996283abd)) {
    level.hud_management.var_47490eb996283abd = spawnStruct();
  }

  data = level.hud_management.var_47490eb996283abd;
  data.omnvar = var_b3a89a684bcb5b5.var_ac70f49ace9c5b4;
  data.widgetsets = [];

  if(isDefined(var_b3a89a684bcb5b5.hidewidgets)) {
    hide_widgets = getscriptbundle(var_b3a89a684bcb5b5.hidewidgets);

    if(isDefined(hide_widgets) && isDefined(hide_widgets.widgetsets)) {
      foreach(widgetset in hide_widgets.widgetsets) {
        if(isDefined(widgetset.name) && widgetset.name != "") {
          data.widgetsets[tolower(widgetset.name)] = index;
        }
      }
    }
  }
}

function function_170c03b36bf19328(ref, widgetsets, shouldhide = 1, suppressasserts) {
  if(!istrue(suppressasserts)) {
    assert(isDefined(level.hud_management), "<dev string:x265>");
    assert(isDefined(level.hud_management.var_47490eb996283abd), "<dev string:x265>");
    assert(isDefined(level.hud_management.var_47490eb996283abd.widgetsets), "<dev string:x265>");
    assert(isDefined(level.hud_management.var_47490eb996283abd.omnvar), "<dev string:x2b1>");
  } else if(!isDefined(level.hud_management.var_47490eb996283abd.omnvar)) {
    return;
  }

  data = level.hud_management.var_47490eb996283abd;

  if(!isarray(widgetsets)) {
    widgetsets = [widgetsets];
  }

  foreach(widgetset in widgetsets) {
    widgetset = tolower(widgetset);

    if(istrue(suppressasserts)) {
      if(!isDefined(data.widgetsets[widgetset])) {
        continue;
      }
    } else {
      assert(isDefined(data.widgetsets[widgetset]), "<dev string:x315>" + getxhashsourcename(widgetset) + "<dev string:x33a>");
    }

    shouldhide = function_f0e7115779ab8fc8(ref, widgetset, shouldhide);
    self setclientomnvarbit(data.omnvar, data.widgetsets[widgetset], shouldhide);
  }
}

function function_a4b07de99918f624(ref) {
  if(isDefined(self.var_c79636d568137625)) {
    data = level.hud_management.var_47490eb996283abd;
    keys = getarraykeys(self.var_c79636d568137625);

    foreach(widgetsetkey in keys) {
      if(isDefined(self.var_c79636d568137625[widgetsetkey][ref])) {
        self.var_c79636d568137625[widgetsetkey][ref] = undefined;

        if(self.var_c79636d568137625[widgetsetkey].size == 0) {
          self.var_c79636d568137625[widgetsetkey] = undefined;
          self setclientomnvarbit(data.omnvar, data.widgetsets[widgetsetkey], 0);
        }
      }
    }
  }
}

function function_35924dfcb78711f4(widget_ref, widget_type, widget_struct) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x39f>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x39f>");
  data = level.hud_management.scripted_widgets;
  widget_ref = tolower(widget_ref);

  if(!isxhashasset(widget_type)) {
    widget_type = hashcat(%"scriptedwidget:", widget_type);
  }

  if(function_48c98ea9a4f0da89(widget_ref)) {
    assert("<dev string:x3ec>" + widget_ref + "<dev string:x40f>");
    return;
  }

  index = function_6b10f6ec0da98ed2(widget_ref, widget_type);

  if(isDefined(index)) {
    if(isDefined(widget_struct)) {
      if(isDefined(widget_struct.param)) {
        function_527ee94bd3d858e5(widget_struct.param, "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xa3\xaf\xb7.p\xf2" + index, data.widget_types[widget_type].parameters);
      }

      if(isDefined(widget_struct.data)) {
        function_527ee94bd3d858e5(widget_struct.data, "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xf6\xb5\x953\xe1" + index);
      }

      if(isDefined(widget_struct.state)) {
        function_527ee94bd3d858e5(widget_struct.state, "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\x01\x14}IQw" + index, data.widget_types[widget_type].states);
      }

      if(isDefined(widget_struct.priority)) {
        function_527ee94bd3d858e5(widget_struct.priority, "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xae_t\xe7wF^\xbd\xff" + index);
      }

      if(istrue(widget_struct.under_hud)) {
        function_527ee94bd3d858e5(1, "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "Mj'\xdc^\xba\x14\xd0\xce&" + index);
      }

      if(isent(widget_struct.ent)) {
        assert(isDefined(widget_struct.anchor_type), "<dev string:x437>");
        function_7b7d992c0de840f(widget_ref, widget_struct.ent, widget_struct.anchor_type);
      }

      if(isDefined(widget_struct.position)) {
        function_85d8a0ba2e35b6f2(widget_ref, widget_struct.position.left, widget_struct.position.top, widget_struct.position.horizontal_anchor, widget_struct.position.vertical_anchor, widget_struct.position.var_ffb4c7f1639c871d);
      }

      if(isDefined(widget_struct.remove_on_death)) {
        function_9a0e442e98243dd8(widget_ref, widget_struct.remove_on_death);
      }
    }

    self setclientomnvar("\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\x18G\x15\xd3s" + index, data.widget_types[widget_type].index);
    return;
  }

  assert("<dev string:x48b>");
}

function function_a1a13273e72bfe46(widget_prefix) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x4c7>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x4c7>");
  assert(isDefined(widget_prefix), "<dev string:x525>");
  widget = function_5558a20db205336(widget_prefix, getDvar(@ "g_mapname"));

  if(isDefined(widget)) {
    return widget;
  }

  widget = function_5558a20db205336(widget_prefix, [getprojectname(), level.gametype]);

  if(isDefined(widget)) {
    return widget;
  }

  mode = "\xc3\xf2";

  if(utility::issp()) {
    mode = "X\xc3";
  }

  widget = function_5558a20db205336(widget_prefix, [getprojectname(), mode]);

  if(isDefined(widget)) {
    return widget;
  }

  widget = function_5558a20db205336(widget_prefix, getprojectname());

  if(isDefined(widget)) {
    return widget;
  }

  if(isDefined(level.gametype)) {
    widget = function_5558a20db205336(widget_prefix, level.gametype);

    if(isDefined(widget)) {
      return widget;
    }
  }

  widget = function_5558a20db205336(widget_prefix, mode);

  if(isDefined(widget)) {
    return widget;
  }

  if(function_73ac92d48ae2a07f(widget_prefix)) {
    return hashcat(%"scriptedwidget:", widget_prefix);
  }

  return undefined;
}

function function_5558a20db205336(widget_prefix, params) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x4c7>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x4c7>");
  assert(isDefined(widget_prefix), "<dev string:x525>");
  assert(isDefined(params) && (isstring(params) || isarray(params)), "<dev string:x570>");
  var_9ee27e78fa6bd8b = "";

  if(isstring(params)) {
    var_9ee27e78fa6bd8b = widget_prefix + "w" + params;
  } else if(isarray(params)) {
    for(i = 0; i < params.size; i++) {
      if(!isDefined(params[i])) {
        return undefined;
      }

      var_9ee27e78fa6bd8b += params[i];

      if(i + 1 < params.size) {
        var_9ee27e78fa6bd8b += "w";
      }
    }

    var_9ee27e78fa6bd8b = widget_prefix + "w" + var_9ee27e78fa6bd8b;
  } else {
    var_9ee27e78fa6bd8b = widget_prefix;
  }

  if(function_73ac92d48ae2a07f(var_9ee27e78fa6bd8b)) {
    return hashcat(%"scriptedwidget:", var_9ee27e78fa6bd8b);
  }

  return undefined;
}

function function_73ac92d48ae2a07f(widget_type) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");

  if(!isxhashasset(widget_type)) {
    widget_type = hashcat(%"scriptedwidget:", widget_type);
  }

  return isDefined(level.hud_management.scripted_widgets) && isDefined(level.hud_management) && isDefined(level.hud_management.scripted_widgets.widget_types[widget_type]);
}

function function_f7788e5b5434e49e(widget_asset, param_name, property_name) {
  assert(isDefined(level.hud_management), "<dev string:x5f3>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x5f3>");

  if(!isxhashasset(widget_asset)) {
    widget_asset = hashcat(%"scriptedwidget:", widget_asset);
  }

  widget_data = getscriptbundle(widget_asset);
  param_index = function_b584f43317b07b57(widget_asset, param_name);

  if(isDefined(param_index)) {
    property_name = tolower(property_name);

    foreach(property in widget_data.parameters[param_index].properties) {
      if(property.variant_object.property == property_name) {
        return property.variant_object.value;
      }
    }
  }

  return undefined;
}

function function_b584f43317b07b57(widget_asset, param_name) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x4c7>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x4c7>");

  if(!isxhashasset(widget_asset)) {
    widget_asset = hashcat(%"scriptedwidget:", widget_asset);
  }

  param_name = tolower(param_name);
  return level.hud_management.scripted_widgets.widget_types[widget_asset].parameters[param_name];
}

function private function_7d4c6b543c8fff02(widget_ref, omnvar_suffix, omnvar_override, var_698d10c4fc4872ae) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  var_1f6f6402ca4c125f = spawnStruct();
  data = level.hud_management.scripted_widgets;

  if(isDefined(omnvar_override)) {
    if(!isxhashasset(widget_ref)) {
      widget_ref = hashcat(%"scriptedwidget:", widget_ref);
    }

    var_1f6f6402ca4c125f.omnvar = omnvar_override;
    var_1f6f6402ca4c125f.type = widget_ref;
    var_1f6f6402ca4c125f.time_omnvar = var_698d10c4fc4872ae;
    assert(isDefined(data.widget_types[widget_ref]));
  } else {
    widget_ref = tolower(widget_ref);

    if(!function_48c98ea9a4f0da89(widget_ref)) {
      return undefined;
    }

    active_widget = self.var_e8099bc588744e49[widget_ref];
    var_1f6f6402ca4c125f.omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + omnvar_suffix + active_widget.index;
    var_1f6f6402ca4c125f.type = active_widget.widget_type;
    var_1f6f6402ca4c125f.time_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xf3\xc4\x824R" + active_widget.index;
  }

  return var_1f6f6402ca4c125f;
}

function function_b683400f784cb7dc(widget_ref, param_ref, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x64c>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x64c>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xa3\xaf\xb7.p\xf2", omnvar_override);

  if(isDefined(data)) {
    parameters = level.hud_management.scripted_widgets.widget_types[data.type].parameters;
    function_527ee94bd3d858e5(param_ref, data.omnvar, parameters);
  }
}

function function_e1c7789812cc6311(widget_ref, data_val, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x6a4>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x6a4>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(isDefined(data)) {
    function_527ee94bd3d858e5(data_val, data.omnvar);
  }
}

function function_8bf9383f77c82a9b(widget_asset, state_name) {
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x6fb>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x6fb>");

  if(!isxhashasset(widget_asset)) {
    widget_asset = hashcat(%"scriptedwidget:", widget_asset);
  }

  state_name = tolower(state_name);
  return level.hud_management.scripted_widgets.widget_types[widget_asset].states[state_name];
}

function function_d8d634ceece460(widget_ref, state, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x759>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x759>");
  data = function_7d4c6b543c8fff02(widget_ref, "\x01\x14}IQw", omnvar_override);

  if(isDefined(data)) {
    states = level.hud_management.scripted_widgets.widget_types[data.type].states;
    function_527ee94bd3d858e5(state, data.omnvar, states);
  }
}

function function_7b7d992c0de840f(widget_ref, anchor_ent, anchor_type) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref);

  if(!function_48c98ea9a4f0da89(widget_ref)) {
    return;
  }

  anchor_type = hashcat(%"scriptedwidgetanchorsettings:", anchor_type);
  data = level.hud_management.scripted_widgets;
  assert(isDefined(data.anchor_types) && isDefined(data.anchor_types[anchor_type]), "<dev string:x7b1>" + getxhashsourcename(anchor_type) + "<dev string:x7c1>");

  if(!isDefined(self.var_3a97f8b9cd9467cc)) {
    self.var_3a97f8b9cd9467cc = [];
  }

  ent_num = anchor_ent getentitynumber();

  if(!isDefined(self.var_3a97f8b9cd9467cc[ent_num])) {
    self.var_3a97f8b9cd9467cc[ent_num] = [];
  }

  active_widget = self.var_e8099bc588744e49[widget_ref];

  if(isDefined(active_widget.ent_num)) {
    self.var_3a97f8b9cd9467cc[active_widget.ent_num][widget_ref] = undefined;

    if(self.var_3a97f8b9cd9467cc[active_widget.ent_num].size == 0) {
      self.var_3a97f8b9cd9467cc[active_widget.ent_num] = undefined;
      self notify("\xf7\xf6 q8J\xaf8\xf2<\x88\xae\xf5Z\x0f\x9dU\x80\x80k\xf0\xafz\xd5}\x19\x19_Zb\\\xaa\xbc[" + active_widget.ent_num);
    }
  }

  active_widget.ent_num = ent_num;
  self.var_3a97f8b9cd9467cc[ent_num][widget_ref] = active_widget.index;
  ent_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "Yn\xa3\xeb" + active_widget.index;
  self setclientomnvar(ent_omnvar, anchor_ent);
  function_527ee94bd3d858e5(data.anchor_types[anchor_type], "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "'\xa8\xa7t;t\x87+\xfe" + active_widget.index);
  thread function_49067e3c7e55c6de(anchor_ent);
}

function function_9a0e442e98243dd8(widget_ref, var_e248bd7b1ff17be5 = 1) {
  assert(isPlayer(self), "<dev string:x380>");
  widget_ref = tolower(widget_ref);

  if(!function_48c98ea9a4f0da89(widget_ref)) {
    return;
  }

  self.var_e8099bc588744e49[widget_ref].remove_on_death = var_e248bd7b1ff17be5;
}

function function_85d8a0ba2e35b6f2(widget_ref, x_pos, y_pos, horizontal_anchor, vertical_anchor, var_ffb4c7f1639c871d, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  data = function_7d4c6b543c8fff02(widget_ref, "'\xa8\xa7t;t\x87+\xfe", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  if(!isDefined(var_ffb4c7f1639c871d)) {
    var_ffb4c7f1639c871d = 1;
  }

  x_pos = int(x_pos);
  y_pos = int(y_pos);

  switch (horizontal_anchor) {
    case 0:
      assert(x_pos >= -63 && x_pos <= 1984, "<dev string:x860>" + -63 + "<dev string:x8a6>" + 1984 + "<dev string:x8af>");
      x_pos -= -63;
      break;
    case 1:
    case 3:
      assert(x_pos >= -1023 && x_pos <= 1024, "<dev string:x860>" + -1023 + "<dev string:x8a6>" + 1024 + "<dev string:x8c6>");
      x_pos -= -1023;
      break;
    case 2:
      assert(x_pos >= -1984 && x_pos <= 0 - -63, "<dev string:x860>" + -1984 + "<dev string:x8a6>" + 0 - -63 + "<dev string:x8df>");
      x_pos += 1984;
      break;
  }

  switch (vertical_anchor) {
    case 0:
      assert(y_pos >= -483 && y_pos <= 1564, "<dev string:x8f7>" + -483 + "<dev string:x8a6>" + 1564 + "<dev string:x93d>");
      y_pos -= -483;
      break;
    case 1:
    case 3:
      assert(y_pos >= -1023 && y_pos <= 1024, "<dev string:x8f7>" + -1023 + "<dev string:x8a6>" + 1024 + "<dev string:x953>");
      y_pos -= -1023;
      break;
    case 2:
      assert(y_pos >= -1564 && y_pos <= 0 - -483, "<dev string:x8f7>" + -1564 + "<dev string:x8a6>" + 0 - -483 + "<dev string:x96c>");
      y_pos += 1564;
      break;
  }

  y_bits = y_pos << 11;
  var_4587bc9003fd2309 = horizontal_anchor << 22;
  var_23986b2511d6e4cf = vertical_anchor << 22 + 2;
  var_fc16015c362a02b0 = (var_ffb4c7f1639c871d ? 1 : 0) << 22 + 2 + 2;
  packed_position = x_pos + y_bits + var_4587bc9003fd2309 + var_23986b2511d6e4cf + var_fc16015c362a02b0;
  self setclientomnvar(data.omnvar, packed_position);
}

function function_8c7cf24f0d9455e0(datatype) {
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

function function_3b1161c0877a7ebe(datatype) {
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

function function_bfde76710a7ecb8e(widget_ref, var_c0c7a5376fe9e2bc, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  data = function_7d4c6b543c8fff02(widget_ref, "'\xa8\xa7t;t\x87+\xfe", omnvar_override);

  if(!isDefined(data)) {
    return undefined;
  }

  position_data = self getclientomnvar(data.omnvar);
  x_pos = (position_data & 2048 - 1) >> 0;
  y_pos = (position_data & 2048 - 1) >> 11;
  vertical_anchor = (position_data & 4 - 1) >> 22;
  horizontal_anchor = (position_data & 4 - 1) >> 22 + 2;

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

  if(istrue(var_c0c7a5376fe9e2bc)) {
    x_pos = (x_pos - -63) / (1984 - -63);
    y_pos = (y_pos - -483) / (1564 - -483);
  }

  return (x_pos, y_pos, 0);
}

function function_aaab83e8c950f455(widget_ref, priority, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xae_t\xe7wF^\xbd\xff", omnvar_override);

  if(isDefined(data)) {
    self setclientomnvar(data.omnvar, priority);
  }
}

function function_41ff479ac45608d6(widget_ref, field_values, no_timestamp, omnvar_override, var_698d10c4fc4872ae) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x985>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x985>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override, var_698d10c4fc4872ae);

  if(!isDefined(data)) {
    return;
  }

  function_5c7e39388a8344a5(data.type, data.omnvar, field_values, data.time_omnvar);
}

function function_d3b457baa69dec73(widget_ref, field, value, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x985>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x985>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  function_fb190f7232ce3bc6(data.type, data.omnvar, field, value);
}

function function_c8363eb5a97e5d85(widget_ref, field, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x985>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x985>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  value = function_285cd6b8a545119(data.type, data.omnvar, [field]);
  function_fb190f7232ce3bc6(data.type, data.omnvar, field, !value[field]);
}

function function_8b5b451c000d6322(widget_ref, current_pct, target_pct, time, omnvar_override, var_698d10c4fc4872ae) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x9e4>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x9e4>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  function_b648e32a12726c7d(data.type, data.omnvar, current_pct, target_pct, time, data.time_omnvar);
}

function function_b1f96bda9ef06a99(widget_ref, current_pct, bool, omnvar_override, var_698d10c4fc4872ae) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xa3f>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xa3f>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  function_1bf1787f2a409a80(data.type, data.omnvar, current_pct, bool, data.time_omnvar);
}

function function_bd70f5138a4b092d(widget_ref, current_pct, current_alpha, omnvar_override, var_698d10c4fc4872ae) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xa9f>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xa9f>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  function_c3cf13b5276c614a(data.type, data.omnvar, current_pct, current_alpha, data.time_omnvar);
}

function function_7a623f7c93e16c6e(widget_ref, count, max_count, time, omnvar_override, var_698d10c4fc4872ae) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xb00>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xb00>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  function_699e8738bfafafc7(data.type, data.omnvar, count, max_count, time, data.time_omnvar);
}

function function_7327dfb1da700659(widget_ref, timestamp, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xb58>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xb58>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf3\xc4\x824R", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  self setclientomnvar(data.omnvar, timestamp);
}

function function_594f6081e9662d1a(widget_ref, fields, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:x985>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:x985>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  return function_285cd6b8a545119(data.type, data.omnvar, fields);
}

function function_5ed0d1cf9f8f801e(archetype, field) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;

  if(!isxhashasset(archetype)) {
    archetype = hashcat(%"scriptedwidgetarchetype:", archetype);
  }

  assert(isDefined(widget_archetypes[archetype]), "<dev string:xbb4>" + getxhashsourcename(archetype) + "<dev string:xbca>");
  assert(isDefined(widget_archetypes[archetype][field]), "<dev string:xc24>" + field + "<dev string:xc40>" + getxhashsourcename(archetype) + "<dev string:xc64>");

  if(isDefined(widget_archetypes[archetype]) && isDefined(widget_archetypes[archetype][field])) {
    return widget_archetypes[archetype][field].max_value;
  }

  return undefined;
}

function scripted_widget_destroy(widget_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xc7a>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xc7a>");
  widget_ref = tolower(widget_ref);

  if(!function_48c98ea9a4f0da89(widget_ref)) {
    return;
  }

  index = function_4ccbcffad1c26793(widget_ref);

  if(isDefined(index)) {
    type_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\x18G\x15\xd3s" + index;
    self setclientomnvar(type_omnvar, 0);
    self notify("\x15\xbcX\x19vI\x7f\\\xf7\xeb}l\x168vP\xe7:@\x04fg\xe8D\\\x91" + widget_ref);
  }
}

function function_48c98ea9a4f0da89(widget_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref);
  data = level.hud_management.scripted_widgets;
  return isDefined(self.var_e8099bc588744e49) && isDefined(self.var_e8099bc588744e49[widget_ref]);
}

function function_4fe26049f23ddf54(widget_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref);
  data = level.hud_management.scripted_widgets;

  if(isDefined(self.var_e8099bc588744e49) && isDefined(self.var_e8099bc588744e49[widget_ref])) {
    return self.var_e8099bc588744e49[widget_ref].index;
  }

  return undefined;
}

function function_1b4aca2f939c19a4() {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  return !isDefined(self.var_2ea02431b4626d97) || self.var_2ea02431b4626d97.size > 0;
}

function function_91ff36a22dc2c60e(list_ref, widget_type, list_items) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  function_35924dfcb78711f4(list_ref, widget_type);
  self.var_e8099bc588744e49[list_ref].list = [];

  if(isDefined(list_items)) {
    function_f46498fcba721ef0(list_ref, list_items);
  }
}

function function_995d1afc30296a16(list_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  function_7c53de746c7ff48b(list_ref);
  scripted_widget_destroy(list_ref);
}

function function_222841054993effd(list_ref, item_ref, item_type, var_9c2fdc5d306f5c3d) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  items = [];
  items[item_ref] = item_type;
  function_f46498fcba721ef0(list_ref, items, var_9c2fdc5d306f5c3d);
}

function function_f46498fcba721ef0(list_ref, list_items, var_9c2fdc5d306f5c3d) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  items = [];
  omnvars = [];

  foreach(item_type in list_items) {
    if(!isxhashasset(item_type)) {
      item_type = hashcat(%"scriptedwidget:", item_type);
    }

    omnvar_index = function_161f5590f398d0a6(list_ref, tolower(item_ref), item_type);
    assert(isDefined(omnvar_index), "<dev string:xcc8>");

    if(isDefined(omnvar_index)) {
      items[items.size] = item_type;
      omnvars[omnvars.size] = omnvar_index;
    }
  }

  function_197575b543804b2e(list_ref, items, omnvars, var_9c2fdc5d306f5c3d);
}

function function_71caa71a5ccc1f94(list_ref, items) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  assert(self.var_e8099bc588744e49[list_ref].list.size == items.size, "<dev string:xd35>");
  self.var_e8099bc588744e49[list_ref].list = [];

  foreach(item_ref in items) {
    item_data = function_d803f74229a5c387(list_ref, item_ref);
    assert(isDefined(item_data), "<dev string:xd7c>" + item_ref + "<dev string:xdc9>");
    self.var_e8099bc588744e49[list_ref].list[index] = item_data.omnvar_index;
  }

  function_382559870b15d426(list_ref);
}

function function_2493d7ba0db168a6(list_ref, var_3c3d425b27a4af59, var_487dc6b6a70782e0) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  var_4399fc6c2224938a = function_d803f74229a5c387(list_ref, var_3c3d425b27a4af59);
  var_d8465f135e03feb7 = function_d803f74229a5c387(list_ref, var_487dc6b6a70782e0);
  assert(isDefined(var_4399fc6c2224938a), "<dev string:xdce>" + var_3c3d425b27a4af59 + "<dev string:xdf1>");
  assert(isDefined(var_d8465f135e03feb7), "<dev string:xdce>" + var_487dc6b6a70782e0 + "<dev string:xdf1>");
  index_1 = undefined;
  index_2 = undefined;
  var_700588dc9b60ffd6 = var_4399fc6c2224938a.omnvar_index;
  var_af7f628ab8942e93 = var_d8465f135e03feb7.omnvar_index;

  foreach(index, omnvar_index in self.var_e8099bc588744e49[list_ref].list) {
    if(omnvar_index == var_700588dc9b60ffd6) {
      index_1 = index;
    }

    if(omnvar_index == var_af7f628ab8942e93) {
      index_2 = index;
    }
  }

  self.var_e8099bc588744e49[list_ref].list[index_1] = var_d8465f135e03feb7.omnvar_index;
  self.var_e8099bc588744e49[list_ref].list[index_2] = var_4399fc6c2224938a.omnvar_index;
  function_382559870b15d426(list_ref);
}

function function_9561a0c8f2f87773(list_ref, shift_amount) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  list_size = self.var_e8099bc588744e49[list_ref].list.size;
  assert(list_size >= abs(shift_amount), "<dev string:xe11>" + list_ref + "<dev string:xe2f>" + shift_amount + "<dev string:xe38>" + list_size + "<dev string:xe46>");
  shift_index = shift_amount;

  if(shift_amount < 0) {
    shift_index += list_size;
  }

  var_836ef8e97c5cb350 = utility::array_slice(self.var_e8099bc588744e49[list_ref].list, 0, shift_index);
  var_4f65eb2067efd5c9 = utility::array_slice(self.var_e8099bc588744e49[list_ref].list, shift_index, list_size);
  self.var_e8099bc588744e49[list_ref].list = utility::array_combine(var_4f65eb2067efd5c9, var_836ef8e97c5cb350);
  function_382559870b15d426(list_ref);
}

function function_71e7b79cba82ca25(list_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  self.var_e8099bc588744e49[list_ref].list = utility::array_reverse(self.var_e8099bc588744e49[list_ref].list);
  function_382559870b15d426(list_ref);
}

function function_df75afbce41341f9(widget_ref, horizontal_alignment, vertical_alignment, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  assert(isDefined(level.hud_management), "<dev string:xe62>");
  assert(isDefined(level.hud_management.scripted_widgets), "<dev string:xe62>");
  data = function_7d4c6b543c8fff02(widget_ref, "\xf6\xb5\x953\xe1", omnvar_override);

  if(!isDefined(data)) {
    return;
  }

  alignment = "";

  switch (vertical_alignment) {
    case 0:
      alignment = "\x1c Q";
      break;
    case 1:
      alignment = "c\xb8\xfd\xf5\x1a@";
      break;
    case 2:
      alignment = "T#\x01\x89\f\x81";
      break;
  }

  switch (horizontal_alignment) {
    case 0:
      alignment += "\x1d\xff0b";
      break;
    case 1:
      alignment += "\xcf\xd5!\xe8\xd4\x9d";
      break;
    case 2:
      alignment += "g0\xee\xc1\x8c";
      break;
  }

  function_d8d634ceece460(widget_ref, alignment, omnvar_override);
}

function function_ad26621c71c2ca39(list_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  assert(isDefined(self.var_86009c0e7ec94c63) && isDefined(self.var_86009c0e7ec94c63[list_ref]), "<dev string:xec8>" + list_ref + "<dev string:xef7>");
  return getarraykeys(self.var_86009c0e7ec94c63[list_ref]);
}

function function_699c996caa7bb53e(list_ref, item_ref, var_1c87b863b2d0490b) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  function_c158c1239732d44d(list_ref, [item_ref], var_1c87b863b2d0490b);
}

function function_c158c1239732d44d(list_ref, list_items, var_1c87b863b2d0490b) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);

  if(!function_48c98ea9a4f0da89(list_ref)) {
    return;
  }

  omnvars = [];

  foreach(item_ref in list_items) {
    item_ref = tolower(item_ref);
    omnvar_index = function_72cb23bebd6dcf37(list_ref, item_ref);

    if(isDefined(omnvar_index)) {
      omnvars[omnvars.size - 1] = omnvar_index;
    }
  }

  function_b5843b4b6bfff411(list_ref, omnvars);

  if(istrue(var_1c87b863b2d0490b) && !function_25fe468093322f2f(list_ref)) {
    function_995d1afc30296a16(list_ref);
  }
}

function function_908e2205a6516f5d(list_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);

  if(!function_48c98ea9a4f0da89(list_ref)) {
    return;
  }

  function_7c53de746c7ff48b(list_ref);
  self.var_e8099bc588744e49[list_ref].list = [];
  function_e1c7789812cc6311(list_ref, 0);
}

function function_eeded2ac210fa100(list_ref, item_ref, param) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.hud_management.scripted_widgets;
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xa3\xaf\xb7.p\xf2");
    function_527ee94bd3d858e5(param, omnvar, data.widget_types[item_data.widget_type].parameters);
  }
}

function function_54a35c35697bfbc4(list_ref, item_ref, state) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.hud_management.scripted_widgets;
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\x01\x14}IQw");
    function_527ee94bd3d858e5(state, omnvar, data.widget_types[item_data.widget_type].states);
  }
}

function function_479ab24f5baa1da5(list_ref, item_ref, data_val) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    data = level.hud_management.scripted_widgets;
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf6\xb5\x953\xe1");
    function_527ee94bd3d858e5(data_val, omnvar);
  }
}

function function_f5104e32d4bc69f2(list_ref, item_ref, field_values, no_timestamp) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf6\xb5\x953\xe1");
    time_omnvar = undefined;

    if(!istrue(no_timestamp)) {
      time_omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf3\xc4\x824R");
    }

    function_5c7e39388a8344a5(item_data.widget_type, omnvar, field_values, time_omnvar);
  }
}

function function_bad8975c9b6b18b7(list_ref, item_ref, field, value) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf6\xb5\x953\xe1");
    function_fb190f7232ce3bc6(item_data.widget_type, omnvar, field, value);
  }
}

function function_dc3c21ebba4c0f7e(list_ref, item_ref, current_pct, target_pct, time) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf6\xb5\x953\xe1");
    time_omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf3\xc4\x824R");
    function_b648e32a12726c7d(item_data.widget_type, omnvar, current_pct, target_pct, time, time_omnvar);
  }
}

function function_822915d5d634104a(list_ref, item_ref, count, max_count, time) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf6\xb5\x953\xe1");
    time_omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf3\xc4\x824R");
    function_699e8738bfafafc7(item_data.widget_type, omnvar, count, max_count, time, time_omnvar);
  }
}

function function_41477c414b969e8d(list_ref, item_ref, timestamp) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  item_data = function_d803f74229a5c387(list_ref, item_ref);

  if(isDefined(item_data)) {
    group = self.var_e8099bc588744e49[list_ref].group;
    omnvar = function_4f4701f0439f26c8(group, item_data.omnvar_index, "\xf3\xc4\x824R");
    function_527ee94bd3d858e5(timestamp, omnvar);
  }
}

function function_f5acbf99bab0dc68(list_ref, item_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);
  return isDefined(self.var_86009c0e7ec94c63[list_ref]) && isDefined(self.var_86009c0e7ec94c63) && isDefined(self.var_86009c0e7ec94c63[list_ref][item_ref]);
}

function function_25fe468093322f2f(list_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  return isDefined(self.var_86009c0e7ec94c63) && isDefined(self.var_86009c0e7ec94c63[list_ref]) && self.var_86009c0e7ec94c63[list_ref].size > 0;
}

function function_79735b461f0a5aeb(list_ref, item_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  list_ref = tolower(list_ref);
  item_ref = tolower(item_ref);

  if(isDefined(self.var_86009c0e7ec94c63[list_ref]) && isDefined(self.var_86009c0e7ec94c63) && isDefined(self.var_86009c0e7ec94c63[list_ref][item_ref])) {
    return self.var_86009c0e7ec94c63[list_ref][item_ref].omnvar_index;
  }

  return undefined;
}

function function_f084d4c0fc5a8b4b(anchor_ent, widget_ref, widget_type, anchor_type, widget_struct) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();

  if(!isDefined(widget_struct)) {
    widget_struct = spawnStruct();
  }

  widget_struct.ent = anchor_ent;
  widget_struct.anchor_type = anchor_type;
  function_35924dfcb78711f4(widget_ref, widget_type, widget_struct);
}

function function_49b5521a196149d6(anchor_ent, widget_ref, param) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_b683400f784cb7dc(widget_ref, param);
}

function function_54d7740a67d2b463(anchor_ent, widget_ref, data) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_e1c7789812cc6311(widget_ref, data);
}

function function_583d46528b2c47a(anchor_ent, widget_ref, state) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_d8d634ceece460(widget_ref, state);
}

function function_638b83fff5251e78(anchor_ent, widget_ref, field_values, omnvar_override) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  return function_594f6081e9662d1a(widget_ref, field_values, omnvar_override);
}

function function_282d7915f90d757c(anchor_ent, widget_ref, field_values, no_timestamp) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_41ff479ac45608d6(widget_ref, field_values, no_timestamp);
}

function function_cb63a58d4c3ada30(anchor_ent, widget_ref, current_pct, target_pct, time) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_8b5b451c000d6322(widget_ref, current_pct, target_pct, time);
}

function function_8a9fa4d97c8852f3(anchor_ent, widget_ref, current_pct, bool) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_b1f96bda9ef06a99(widget_ref, current_pct, bool);
}

function function_d71f09bf6468c377(anchor_ent, widget_ref, current_pct, current_alpha) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_bd70f5138a4b092d(widget_ref, current_pct, current_alpha);
}

function function_68d51ba3256b990b(anchor_ent, widget_ref, timestamp) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  widget_ref = tolower(widget_ref) + anchor_ent getentitynumber();
  function_7327dfb1da700659(widget_ref, timestamp);
}

function function_5e19eeec60f33c1e(anchor_ent, widget_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  ent_num = anchor_ent getentitynumber();
  widget_ref = tolower(widget_ref) + ent_num;
  function_adbd9f649f9fcb59(widget_ref, ent_num);
}

function function_3f1b5295108139ee(anchor_ent) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  function_70cb176d0e59c7a9(anchor_ent getentitynumber());
}

function function_4ffc48758feae6cf(anchor_ent, widget_ref) {
  assert(isPlayer(self), "<dev string:x380>");
  assert(level utility::flag("<dev string:x195>"), "<dev string:x1b5>");
  ent_num = anchor_ent getentitynumber();
  widget_ref = tolower(widget_ref) + ent_num;
  return isDefined(self.var_3a97f8b9cd9467cc[ent_num]) && isDefined(self.var_3a97f8b9cd9467cc) && isDefined(self.var_3a97f8b9cd9467cc[ent_num][widget_ref]);
}

function private function_adbd9f649f9fcb59(widget_ref, ent_num) {
  if(isDefined(self.var_3a97f8b9cd9467cc[ent_num])) {
    if(isDefined(self.var_3a97f8b9cd9467cc[ent_num][widget_ref])) {
      scripted_widget_destroy(widget_ref);
    }

    self.var_3a97f8b9cd9467cc[ent_num][widget_ref] = undefined;

    if(self.var_3a97f8b9cd9467cc[ent_num].size == 0) {
      self.var_3a97f8b9cd9467cc[ent_num] = undefined;
      self notify("\xf7\xf6 q8J\xaf8\xf2<\x88\xae\xf5Z\x0f\x9dU\x80\x80k\xf0\xafz\xd5}\x19\x19_Zb\\\xaa\xbc[" + ent_num);
    }
  }
}

function private function_70cb176d0e59c7a9(ent_num, reason) {
  if(isDefined(self.var_3a97f8b9cd9467cc[ent_num])) {
    reasonisdeath = isDefined(reason) && reason == "\x1e\xfd\xd1\xa2\a";

    foreach(widget_ref, index in self.var_3a97f8b9cd9467cc[ent_num]) {
      if(!function_48c98ea9a4f0da89(widget_ref)) {
        continue;
      }

      active_widget = self.var_e8099bc588744e49[widget_ref];
      var_3acc7b511699434e = active_widget.remove_on_death ?? 1;

      if(reasonisdeath && !var_3acc7b511699434e) {
        active_widget.ent_num = undefined;
        continue;
      }

      scripted_widget_destroy(widget_ref);
    }

    self.var_3a97f8b9cd9467cc[ent_num] = undefined;
    self notify("\xf7\xf6 q8J\xaf8\xf2<\x88\xae\xf5Z\x0f\x9dU\x80\x80k\xf0\xafz\xd5}\x19\x19_Zb\\\xaa\xbc[" + ent_num);
  }
}

function private function_49067e3c7e55c6de(ent) {
  if(isPlayer(self)) {
    self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  }

  ent_num = ent getentitynumber();
  self notify("\xf7\xf6 q8J\xaf8\xf2<\x88\xae\xf5Z\x0f\x9dU\x80\x80k\xf0\xafz\xd5}\x19\x19_Zb\\\xaa\xbc[" + ent_num);
  self endon("\xf7\xf6 q8J\xaf8\xf2<\x88\xae\xf5Z\x0f\x9dU\x80\x80k\xf0\xafz\xd5}\x19\x19_Zb\\\xaa\xbc[" + ent_num);
  msg = ent utility::waittill_any_return("\x1e\xfd\xd1\xa2\a", "F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2", "\x83d\x9a\x12\xb9\x93B");
  thread function_70cb176d0e59c7a9(ent_num, msg);
}

function private function_e9726cee4fcb576d(value, archetype, field, packed_value, clear) {
  data = level.hud_management.scripted_widgets.archetypes;
  assert(isDefined(data[archetype]), "<dev string:xf15>" + getxhashsourcename(archetype) + "<dev string:xf5d>");
  assert(isDefined(data[archetype][field]), "<dev string:xf78>" + getxhashsourcename(archetype) + "<dev string:xfc0>" + field + "<dev string:xfd2>");

  if(value > data[archetype][field].max_value) {
    assert("<dev string:xfe7>" + getxhashsourcename(archetype) + "<dev string:x98>" + field + "<dev string:x100b>" + value + "<dev string:x1025>" + data[archetype][field].max_value + "<dev string:x1039>");
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

function private function_e72a10e7514ce362(value, archetype, field) {
  data = level.hud_management.scripted_widgets.archetypes;
  assert(isDefined(data[archetype]), "<dev string:xf15>" + getxhashsourcename(archetype) + "<dev string:xf5d>");
  assert(isDefined(data[archetype][field]), "<dev string:xf78>" + getxhashsourcename(archetype) + "<dev string:xfc0>" + field + "<dev string:xfd2>");
  value = (value &data[archetype][field].mask) >> data[archetype][field].shift;
  value *= data[archetype][field].step_increment;
  return value;
}

function private function_5c7e39388a8344a5(widget_type, omnvar, field_values, time_omnvar) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  assert(isDefined(data.widget_types[widget_type]), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:xfd2>");
  archetype = data.widget_types[widget_type].archetype;
  assert(isDefined(archetype), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x1067>");
  packed_value = 0;

  foreach(field, value in field_values) {
    assert(isDefined(widget_archetypes[archetype][field]), "<dev string:x1081>" + field + "<dev string:x108c>" + getxhashsourcename(archetype) + "<dev string:x10b6>");
    value = clamp(value, 0, widget_archetypes[archetype][field].max_value);
    packed_value = function_e9726cee4fcb576d(value, archetype, field, packed_value);
  }

  self setclientomnvar(omnvar, packed_value);

  if(isDefined(time_omnvar)) {
    self setclientomnvar(time_omnvar, gettime());
  }
}

function private function_fb190f7232ce3bc6(widget_type, omnvar, field, value) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  assert(isDefined(data.widget_types[widget_type]), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:xfd2>");
  archetype = data.widget_types[widget_type].archetype;
  assert(isDefined(archetype), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x1067>");
  packed_value = self getclientomnvar(omnvar);
  assert(isDefined(widget_archetypes[archetype][field]), "<dev string:x1081>" + field + "<dev string:x108c>" + getxhashsourcename(archetype) + "<dev string:x10b6>");
  value = clamp(value, 0, widget_archetypes[archetype][field].max_value);
  packed_value = function_e9726cee4fcb576d(value, archetype, field, packed_value, 1);
  self setclientomnvar(omnvar, packed_value);
}

function private function_285cd6b8a545119(widget_type, omnvar, fields) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  assert(isDefined(data.widget_types[widget_type]), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:xfd2>");
  archetype = data.widget_types[widget_type].archetype;
  assert(isDefined(archetype), "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x1067>");
  value = self getclientomnvar(omnvar);
  ret_fields = [];

  if(isDefined(fields)) {
    foreach(field in fields) {
      assert(isDefined(widget_archetypes[archetype][field]), "<dev string:x1081>" + field + "<dev string:x108c>" + getxhashsourcename(archetype) + "<dev string:x10b6>");
      ret_fields[field] = function_e72a10e7514ce362(value, archetype, field);
    }
  } else {
    foreach(field, unused in widget_archetypes[archetype]) {
      ret_fields[field] = function_e72a10e7514ce362(value, archetype, field);
    }
  }

  return ret_fields;
}

function private function_b648e32a12726c7d(widget_type, omnvar, current_pct, target_pct, time, time_omnvar) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  archetype = % "hash_30fb60496773b970";
  assert(data.widget_types[widget_type].archetype == archetype, "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x10bc>" + getxhashsourcename(archetype) + "<dev string:x10cc>");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["\x80O\xea\xdb[j\x9b\xd0O\xb6#"].max_value);
  target_pct = clamp(target_pct, 0, widget_archetypes[archetype]["P\xf6fx\xd7\b\x01\xecu\x9d"].max_value);
  packed_value = 0;
  packed_value = function_e9726cee4fcb576d(current_pct, archetype, "\x80O\xea\xdb[j\x9b\xd0O\xb6#", packed_value);
  packed_value = function_e9726cee4fcb576d(target_pct, archetype, "P\xf6fx\xd7\b\x01\xecu\x9d", packed_value);
  packed_value = function_e9726cee4fcb576d(time, archetype, "\x92\xd3\x9f\xbb", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(time_omnvar, gettime());
}

function private function_1bf1787f2a409a80(widget_type, omnvar, current_pct, bool, time_omnvar) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  archetype = % "hash_5f97da188cc7b7e5";
  assert(data.widget_types[widget_type].archetype == archetype, "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x10bc>" + getxhashsourcename(archetype) + "<dev string:x10cc>");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["\x80O\xea\xdb[j\x9b\xd0O\xb6#"].max_value);
  packed_value = 0;
  packed_value = function_e9726cee4fcb576d(current_pct, archetype, "\x80O\xea\xdb[j\x9b\xd0O\xb6#", packed_value);
  packed_value = function_e9726cee4fcb576d(bool, archetype, "\x1dH\x80\xa0", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(time_omnvar, gettime());
}

function private function_c3cf13b5276c614a(widget_type, omnvar, current_pct, current_alpha, time_omnvar) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  archetype = % "hash_11e4e971f1764713";
  assert(data.widget_types[widget_type].archetype == archetype, "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x10bc>" + getxhashsourcename(archetype) + "<dev string:x10cc>");
  current_pct = clamp(current_pct, 0, widget_archetypes[archetype]["\x80O\xea\xdb[j\x9b\xd0O\xb6#"].max_value);
  current_alpha = clamp(current_alpha, 0, widget_archetypes[archetype]["9}8\x91\xdf\xb6\xb7\\\xe7\xad\x01@*"].max_value);
  packed_value = 0;
  packed_value = function_e9726cee4fcb576d(current_pct, archetype, "\x80O\xea\xdb[j\x9b\xd0O\xb6#", packed_value);
  packed_value = function_e9726cee4fcb576d(current_alpha, archetype, "9}8\x91\xdf\xb6\xb7\\\xe7\xad\x01@*", packed_value);
  self setclientomnvar(omnvar, packed_value);
  self setclientomnvar(time_omnvar, gettime());
}

function private function_699e8738bfafafc7(widget_type, omnvar, count, max_count, time, time_omnvar) {
  data = level.hud_management.scripted_widgets;
  widget_archetypes = level.hud_management.scripted_widgets.archetypes;
  archetype = % "hash_4be23b86080cdcf6";
  assert(data.widget_types[widget_type].archetype == archetype, "<dev string:x1056>" + getxhashsourcename(widget_type) + "<dev string:x10bc>" + getxhashsourcename(archetype) + "<dev string:x10cc>");
  count = clamp(count, 0, widget_archetypes[archetype][":\xc9\xf3\xb9\x0f"].max_value);

  if(isDefined(max_count)) {
    max_count = clamp(max_count, 0, widget_archetypes[archetype]["\xb6\xc2<\xbe\xc6\xb7\xab\xcd\xa3"].max_value);
  } else {
    max_count = 0;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  packed_value = 0;
  packed_value = function_e9726cee4fcb576d(count, archetype, ":\xc9\xf3\xb9\x0f", packed_value);
  packed_value = function_e9726cee4fcb576d(max_count, archetype, "\xb6\xc2<\xbe\xc6\xb7\xab\xcd\xa3", packed_value);
  packed_value = function_e9726cee4fcb576d(time, archetype, "\x92\xd3\x9f\xbb", packed_value);
  self setclientomnvar(omnvar, packed_value);

  if(time > 0 && isDefined(time_omnvar)) {
    self setclientomnvar(time_omnvar, gettime());
  }
}

function private function_527ee94bd3d858e5(value, omnvar, ref_table, mask, shift) {
  if(!isint(value) && isDefined(ref_table)) {
    value = ref_table[tolower(value)];
  }

  if(isint(value)) {
    if(isDefined(shift)) {
      value <<= shift;
    }

    if(isDefined(mask)) {
      omnvar_value = self getclientomnvar(omnvar);
      omnvar_value &= ~mask;
      value |= omnvar_value;
    }

    self setclientomnvar(omnvar, value);
  }
}

function private function_f0e7115779ab8fc8(ref, widgetset, shouldhide) {
  if(!isDefined(self.var_c79636d568137625)) {
    self.var_c79636d568137625 = [];
  }

  if(!isDefined(self.var_c79636d568137625[widgetset])) {
    self.var_c79636d568137625[widgetset] = [];
  }

  if(shouldhide) {
    self.var_c79636d568137625[widgetset][ref] = 1;
  } else {
    self.var_c79636d568137625[widgetset][ref] = undefined;
  }

  return self.var_c79636d568137625[widgetset].size > 0;
}

function private function_6b10f6ec0da98ed2(widget_ref, widget_type) {
  data = level.hud_management.scripted_widgets;
  index = undefined;
  assert(isPlayer(self), "<dev string:x10e2>");

  if(!isDefined(self.var_2ea02431b4626d97)) {
    self.var_2ea02431b4626d97 = [];

    for(i = 0; i < data.max_widgets; i++) {
      self.var_2ea02431b4626d97[i] = i;
    }
  }

  if(!isDefined(self.var_e8099bc588744e49)) {
    self.var_e8099bc588744e49 = [];
  }

  if(self.var_2ea02431b4626d97.size > 0) {
    index = self.var_2ea02431b4626d97[0];
    self.var_2ea02431b4626d97 = utility::array_remove_index(self.var_2ea02431b4626d97, 0);
    self.var_e8099bc588744e49[widget_ref] = spawnStruct();
    self.var_e8099bc588744e49[widget_ref].index = index;
    self.var_e8099bc588744e49[widget_ref].widget_type = widget_type;
    function_ef4577eca6b7cece(index);
  }

  return index;
}

function private function_4ccbcffad1c26793(widget_ref) {
  data = level.hud_management.scripted_widgets;
  index = undefined;
  assert(isPlayer(self), "<dev string:x10e2>");

  if(isDefined(self.var_e8099bc588744e49[widget_ref])) {
    index = self.var_e8099bc588744e49[widget_ref].index;
  }

  if(isDefined(index)) {
    self.var_2ea02431b4626d97[self.var_2ea02431b4626d97.size] = index;
    self.var_e8099bc588744e49[widget_ref] = undefined;
  }

  return index;
}

function private scripted_widget_closed(index) {
  if(isDefined(self.var_e8099bc588744e49)) {
    foreach(data in self.var_e8099bc588744e49) {
      if(data.index == index) {
        thread scripted_widget_destroy(widget_ref);
        return;
      }
    }
  }
}

function private function_ef4577eca6b7cece(index) {
  data = level.hud_management.scripted_widgets;
  type_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\x18G\x15\xd3s" + index;
  param_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xa3\xaf\xb7.p\xf2" + index;
  data_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xf6\xb5\x953\xe1" + index;
  state_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\x01\x14}IQw" + index;
  time_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xf3\xc4\x824R" + index;
  position_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "'\xa8\xa7t;t\x87+\xfe" + index;
  priority_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xae_t\xe7wF^\xbd\xff" + index;
  ent_omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "Yn\xa3\xeb" + index;
  var_f66173ca59f71b92 = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "Mj'\xdc^\xba\x14\xd0\xce&" + index;
  self setclientomnvar(type_omnvar, 0);
  self setclientomnvar(param_omnvar, 0);
  self setclientomnvar(data_omnvar, 0);
  self setclientomnvar(state_omnvar, 0);
  self setclientomnvar(time_omnvar, 0);
  self setclientomnvar(position_omnvar, 0);
  self setclientomnvar(priority_omnvar, 0);
  self setclientomnvar(ent_omnvar, undefined);
  self setclientomnvar(var_f66173ca59f71b92, 0);
}

function private function_161f5590f398d0a6(list_ref, item_ref, widget_type) {
  data = level.hud_management.scripted_widgets.var_added61db3cfe2ee;
  omnvar_index = undefined;

  if(!isDefined(self.var_e893f13df351f73d)) {
    self.var_e893f13df351f73d = [];
    var_d1c34762db79b6f2 = 8;

    if(data.num_groups > 1) {
      var_d1c34762db79b6f2 -= 1;
    }

    for(i = 0; i < data.max_items; i++) {
      group = int(floor(i / var_d1c34762db79b6f2));
      index = i % var_d1c34762db79b6f2;

      if(!isDefined(self.var_e893f13df351f73d[group])) {
        self.var_e893f13df351f73d[group] = [];
      }

      self.var_e893f13df351f73d[group][index] = index + 1;
    }
  }

  if(!isDefined(self.var_86009c0e7ec94c63)) {
    self.var_86009c0e7ec94c63 = [];
  }

  if(!isDefined(self.var_e8099bc588744e49[list_ref].group)) {
    best_group = undefined;
    var_8882e0129632c128 = 0;

    for(i = 0; i < data.num_groups; i++) {
      group_size = self.var_e893f13df351f73d[i].size;

      if(group_size > var_8882e0129632c128) {
        best_group = i;
        var_8882e0129632c128 = group_size;
      }
    }

    if(!isDefined(best_group)) {
      return undefined;
    }

    function_34fa411bc0628eec(list_ref, best_group);
  }

  group = self.var_e8099bc588744e49[list_ref].group;
  array_index = self.var_e893f13df351f73d[group].size - 1;

  if(array_index >= 0) {
    omnvar_index = self.var_e893f13df351f73d[group][array_index];
    self.var_e893f13df351f73d[group][array_index] = undefined;

    if(!isDefined(self.var_86009c0e7ec94c63[list_ref])) {
      self.var_86009c0e7ec94c63[list_ref] = [];
    }

    self.var_86009c0e7ec94c63[list_ref][item_ref] = spawnStruct();
    self.var_86009c0e7ec94c63[list_ref][item_ref].omnvar_index = omnvar_index;
    self.var_86009c0e7ec94c63[list_ref][item_ref].widget_type = widget_type;
    function_87d86fa57c18db62(group, omnvar_index);
  }

  return omnvar_index;
}

function private function_34fa411bc0628eec(list_ref, group_index) {
  group_mask = level.hud_management.scripted_widgets.var_added61db3cfe2ee.group_mask;
  group_shift = level.hud_management.scripted_widgets.var_added61db3cfe2ee.group_shift;

  if(isDefined(group_mask) && isDefined(group_shift)) {
    omnvar = "\xda+{Z;\xd2\xebY\xdaJ3\xa8t\xfa\xc95\xa5\xda>" + "\xf6\xb5\x953\xe1" + self.var_e8099bc588744e49[list_ref].index;
    function_527ee94bd3d858e5(group_index, omnvar, undefined, group_mask, group_shift);
  }

  self.var_e8099bc588744e49[list_ref].group = group_index;
}

function private function_72cb23bebd6dcf37(list_ref, item_ref) {
  data = level.hud_management.scripted_widgets.var_added61db3cfe2ee;
  omnvar_index = undefined;

  if(isDefined(self.var_86009c0e7ec94c63[list_ref]) && isDefined(self.var_86009c0e7ec94c63[list_ref][item_ref])) {
    omnvar_index = self.var_86009c0e7ec94c63[list_ref][item_ref].omnvar_index;

    if(isDefined(omnvar_index)) {
      group = self.var_e8099bc588744e49[list_ref].group;
      self.var_e893f13df351f73d[group][self.var_e893f13df351f73d[group].size] = omnvar_index;
      self.var_86009c0e7ec94c63[list_ref][item_ref] = undefined;

      if(self.var_86009c0e7ec94c63[list_ref].size == 0) {
        self.var_86009c0e7ec94c63[list_ref] = undefined;
      }
    }
  }

  return omnvar_index;
}

function private function_7c53de746c7ff48b(list_ref) {
  data = level.hud_management.scripted_widgets.var_added61db3cfe2ee;

  if(isDefined(self.var_86009c0e7ec94c63[list_ref])) {
    if(self.var_86009c0e7ec94c63[list_ref].size > 0) {
      group = self.var_e8099bc588744e49[list_ref].group;

      foreach(item_data in self.var_86009c0e7ec94c63[list_ref]) {
        self.var_e893f13df351f73d[group][self.var_e893f13df351f73d[group].size] = item_data.omnvar_index;
      }
    }

    self.var_86009c0e7ec94c63[list_ref] = undefined;
  }
}

function private function_197575b543804b2e(list_ref, items, omnvars, var_9c2fdc5d306f5c3d) {
  if(istrue(var_9c2fdc5d306f5c3d)) {
    self.var_e8099bc588744e49[list_ref].list = utility::array_combine(omnvars, self.var_e8099bc588744e49[list_ref].list);
  } else {
    self.var_e8099bc588744e49[list_ref].list = utility::array_combine(self.var_e8099bc588744e49[list_ref].list, omnvars);
  }

  data = level.hud_management.scripted_widgets;

  foreach(item in items) {
    type_omnvar = function_4f4701f0439f26c8(self.var_e8099bc588744e49[list_ref].group, omnvars[index], "\x18G\x15\xd3s");
    self setclientomnvar(type_omnvar, data.widget_types[item].index);
  }

  function_382559870b15d426(list_ref);
}

function private function_b5843b4b6bfff411(list_ref, items) {
  self.var_e8099bc588744e49[list_ref].list = utility::array_remove_array(self.var_e8099bc588744e49[list_ref].list, items);
  function_382559870b15d426(list_ref);
}

function private function_382559870b15d426(list_ref) {
  max_items = 8;
  value = 0;

  if(level.hud_management.scripted_widgets.var_added61db3cfe2ee.num_groups > 1) {
    max_items -= 1;
    value = self.var_e8099bc588744e49[list_ref].group << level.hud_management.scripted_widgets.var_added61db3cfe2ee.group_shift;
  }

  list = self.var_e8099bc588744e49[list_ref].list;

  for(i = 0; i < max_items; i++) {
    if(isDefined(list[i])) {
      value |= list[i] << 4 * i;
    }
  }

  function_e1c7789812cc6311(list_ref, value);
}

function private function_87d86fa57c18db62(group, omnvar_index) {
  omnvar_index = function_43d6fe8ec4ed65b(group, omnvar_index);
  type_omnvar = "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + "\x18G\x15\xd3s" + omnvar_index;
  param_omnvar = "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + "\xa3\xaf\xb7.p\xf2" + omnvar_index;
  data_omnvar = "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + "\xf6\xb5\x953\xe1" + omnvar_index;
  state_omnvar = "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + "\x01\x14}IQw" + omnvar_index;
  time_omnvar = "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + "\xf3\xc4\x824R" + omnvar_index;
  self setclientomnvar(type_omnvar, 0);
  self setclientomnvar(param_omnvar, 0);
  self setclientomnvar(data_omnvar, 0);
  self setclientomnvar(state_omnvar, 0);
  self setclientomnvar(time_omnvar, 0);
}

function private function_43d6fe8ec4ed65b(group, index) {
  return index + group * 8;
}

function private function_4f4701f0439f26c8(group, omnvar_index, omnvar_suffix) {
  omnvar_index = function_43d6fe8ec4ed65b(group, omnvar_index);
  return "{[0p\xa7pDP\xe2\x12\xa0NU}\xdb9=\xfcSU\x85)" + omnvar_suffix + omnvar_index;
}

function private function_d803f74229a5c387(list_ref, item_ref) {
  data = level.hud_management.scripted_widgets.var_added61db3cfe2ee;

  if(isDefined(self.var_86009c0e7ec94c63[list_ref]) && isDefined(self.var_86009c0e7ec94c63) && isDefined(self.var_86009c0e7ec94c63[list_ref][item_ref])) {
    return self.var_86009c0e7ec94c63[list_ref][item_ref];
  }

  return undefined;
}

function private function_8cc8282adf04ed07() {
  if(isDefined(level.player)) {
    level.player thread function_63dd03b8068ed757();
    return;
  }

  player_limit = 32;

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      if(index > player_limit) {
        break;
      }

      player thread function_63dd03b8068ed757();
    }
  }

  while(true) {
    level waittill("<dev string:x1129>", player);

    if(level.players.size <= player_limit) {
      player thread function_63dd03b8068ed757();
    }
  }
}

function private function_63dd03b8068ed757() {
  if(isbot(self)) {
    return;
  }

  player_name = self.name ?? "<dev string:x1136>";

  foreach(widget_data in level.hud_management.scripted_widgets.widget_types) {
    widget_name = strtok(getxhashsourcename(widget_asset), "<dev string:x113a>")[1];

    if(isDefined(widget_name)) {
      devgui::function_fc97f67ff432e7de("<dev string:x113f>" + (player_name == "<dev string:x1136>" ? player_name : player_name + "<dev string:x1157>") + widget_name + "<dev string:x1157>");
      devgui::function_3ee29fdc6a8bf10("<dev string:x115c>", "<dev string:x1166>" + widget_name + "<dev string:x1171>" + player_name, &function_32ad4c4219e3a09, 0);

      if(isDefined(widget_data.archetype) && isDefined(level.hud_management.scripted_widgets.archetypes[widget_data.archetype])) {
        foreach(field, field_data in level.hud_management.scripted_widgets.archetypes[widget_data.archetype]) {
          dvar_name = widget_name + "<dev string:x1176>" + field + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);

          if(field_data.step_increment < 1) {
            setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 0, 0, field_data.max_value);
          } else {
            setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 0, 0, int(field_data.max_value));
          }

          devgui::function_2e6fe73522a718b0("<dev string:x117b>" + field, "<dev string:x1189>" + dvar_name);
        }
      }

      dvar_name = widget_name + "<dev string:x1193>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 0, -63, 1984);
      devgui::function_2e6fe73522a718b0("<dev string:x11a2>", "<dev string:x1189>" + dvar_name);
      dvar_name = widget_name + "<dev string:x11b0>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 0, -483, 1564);
      devgui::function_2e6fe73522a718b0("<dev string:x11bf>", "<dev string:x1189>" + dvar_name);
      dvar_name = widget_name + "<dev string:x11cd>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 1, 0, 3);
      devgui::function_2e6fe73522a718b0("<dev string:x11e3>", "<dev string:x1189>" + dvar_name);
      dvar_name = widget_name + "<dev string:x1201>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 1, 0, 3);
      devgui::function_2e6fe73522a718b0("<dev string:x1217>", "<dev string:x1189>" + dvar_name);
      dvar_name = widget_name + "<dev string:x1233>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), 1);
      devgui::function_2e6fe73522a718b0("<dev string:x1249>", "<dev string:x1189>" + dvar_name);

      foreach(param_name, param_index in widget_data.parameters) {
        devgui::function_3ee29fdc6a8bf10("<dev string:x1263>" + param_name, param_name + "<dev string:x1171>" + widget_name + "<dev string:x1171>" + param_name + "<dev string:x1171>" + player_name, &function_ca38970aae300533, 0);
      }

      dvar_name = widget_name + "<dev string:x1272>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), "<dev string:x1136>");

      foreach(state_name, state_index in widget_data.states) {
        devgui::function_3ee29fdc6a8bf10("<dev string:x127c>" + state_name, state_name + "<dev string:x1171>" + widget_name + "<dev string:x1171>" + state_name + "<dev string:x1171>" + player_name, &function_22d800f8348747e7, 0);
      }

      dvar_name = widget_name + "<dev string:x1287>" + (player_name == "<dev string:x1136>" ? "<dev string:x1136>" : "<dev string:x1176>" + player_name);
      setdevdvarifuninitialized(hashcat(@ "debug_", dvar_name), "<dev string:x1136>");
      devgui::function_3ee29fdc6a8bf10("<dev string:x1291>", "<dev string:x129c>" + widget_name + "<dev string:x1171>" + player_name, &function_2f592d237cd3b13b, 0);
      devgui::function_9c2be2438708a992();
    }
  }
}

function private function_c841dac9e61178e7(player_name) {
  if(isDefined(player_name) && player_name != "<dev string:x1136>") {
    foreach(player in level.players) {
      if(player.name == player_name) {
        return player;
      }
    }

    return;
  }

  return level.player;
}

function private function_f1fc9d743cdeff8c(widget_ref, widget_type) {
  self endon("<dev string:x12a8>");
  self endon("<dev string:x12bf>" + widget_ref);
  player = self;
  widget_data = level.hud_management.scripted_widgets.widget_types[hashcat(%"scriptedwidget:", widget_type)];
  dvar_x = widget_type + "<dev string:x1193>";
  dvar_y = widget_type + "<dev string:x11b0>";
  var_15908b905327be40 = widget_type + "<dev string:x11cd>";
  var_288f7c52e977954a = widget_type + "<dev string:x1201>";
  dvar_safearea = widget_type + "<dev string:x1233>";

  if(isDefined(player.name)) {
    dvar_x = dvar_x + "<dev string:x1176>" + player.name;
    dvar_y = dvar_y + "<dev string:x1176>" + player.name;
    var_15908b905327be40 = var_15908b905327be40 + "<dev string:x1176>" + player.name;
    var_288f7c52e977954a = var_288f7c52e977954a + "<dev string:x1176>" + player.name;
    dvar_safearea = dvar_safearea + "<dev string:x1176>" + player.name;
  }

  dvar_x = hashcat(@ "debug_", dvar_x);
  dvar_y = hashcat(@ "debug_", dvar_y);
  var_15908b905327be40 = hashcat(@ "debug_", var_15908b905327be40);
  var_288f7c52e977954a = hashcat(@ "debug_", var_288f7c52e977954a);
  dvar_safearea = hashcat(@ "debug_", dvar_safearea);
  field_dvars = [];

  if(isDefined(widget_data.archetype) && isDefined(level.hud_management.scripted_widgets.archetypes[widget_data.archetype])) {
    foreach(field, field_data in level.hud_management.scripted_widgets.archetypes[widget_data.archetype]) {
      dvar_name = widget_type + "<dev string:x1176>" + field;

      if(isDefined(player.name)) {
        dvar_name = dvar_name + "<dev string:x1176>" + player.name;
      }

      field_dvars[field] = hashcat(@ "debug_", dvar_name);
    }
  }

  while(true) {
    x_pos = getdvarint(dvar_x);
    y_pos = getdvarint(dvar_y);
    h_anchor = getdvarint(var_15908b905327be40);
    v_anchor = getdvarint(var_288f7c52e977954a);
    safe_area = getdvarint(dvar_safearea);
    player function_85d8a0ba2e35b6f2(widget_ref, x_pos, y_pos, h_anchor, v_anchor, safe_area != 0);

    if(isDefined(widget_data.archetype) && isDefined(level.hud_management.scripted_widgets.archetypes[widget_data.archetype])) {
      foreach(field, field_data in level.hud_management.scripted_widgets.archetypes[widget_data.archetype]) {
        field_value = getdvarfloat(field_dvars[field], 0);
        player function_d3b457baa69dec73(widget_ref, field, field_value);
      }
    }

    waitframe();
  }
}

function private function_32ad4c4219e3a09(params) {
  player = function_c841dac9e61178e7(params[1]);

  if(isDefined(player)) {
    widget_type = params[0];
    widget_ref = "<dev string:x12dd>" + widget_type;
    player function_35924dfcb78711f4(widget_ref, widget_type);
    dvar_x = widget_type + "<dev string:x1193>";
    dvar_y = widget_type + "<dev string:x11b0>";
    var_15908b905327be40 = widget_type + "<dev string:x11cd>";
    var_288f7c52e977954a = widget_type + "<dev string:x1201>";
    dvar_safearea = widget_type + "<dev string:x1233>";
    dvar_param = widget_type + "<dev string:x1272>";
    dvar_state = widget_type + "<dev string:x1287>";

    if(isDefined(player.name)) {
      dvar_x = dvar_x + "<dev string:x1176>" + player.name;
      dvar_y = dvar_y + "<dev string:x1176>" + player.name;
      var_15908b905327be40 = var_15908b905327be40 + "<dev string:x1176>" + player.name;
      var_288f7c52e977954a = var_288f7c52e977954a + "<dev string:x1176>" + player.name;
      dvar_safearea = dvar_safearea + "<dev string:x1176>" + player.name;
      dvar_param = dvar_param + "<dev string:x1176>" + player.name;
      dvar_state = dvar_state + "<dev string:x1176>" + player.name;
    }

    x_pos = getdvarint(hashcat(@ "debug_", dvar_x));
    y_pos = getdvarint(hashcat(@ "debug_", dvar_y));
    h_anchor = getdvarint(hashcat(@ "debug_", var_15908b905327be40));
    v_anchor = getdvarint(hashcat(@ "debug_", var_288f7c52e977954a));
    safe_area = getdvarint(hashcat(@ "debug_", dvar_safearea));
    player function_85d8a0ba2e35b6f2(widget_ref, x_pos, y_pos, h_anchor, v_anchor, safe_area != 0);
    parameter = getDvar(hashcat(@ "debug_", dvar_param), "<dev string:x1136>");

    if(parameter != "<dev string:x1136>") {
      player function_b683400f784cb7dc(widget_ref, parameter);
    }

    state = getDvar(hashcat(@ "debug_", dvar_state), "<dev string:x1136>");

    if(state != "<dev string:x1136>") {
      player function_b683400f784cb7dc(widget_ref, state);
    }

    widget_data = level.hud_management.scripted_widgets.widget_types[hashcat(%"scriptedwidget:", widget_type)];

    if(isDefined(widget_data.archetype) && isDefined(level.hud_management.scripted_widgets.archetypes[widget_data.archetype])) {
      foreach(field, field_data in level.hud_management.scripted_widgets.archetypes[widget_data.archetype]) {
        dvar_name = widget_type + "<dev string:x1176>" + field;

        if(isDefined(player.name)) {
          dvar_name = dvar_name + "<dev string:x1176>" + player.name;
        }

        field_value = getdvarfloat(hashcat(@ "debug_", dvar_name), 0);
        player function_d3b457baa69dec73(widget_ref, field, field_value);
      }
    }

    player function_7327dfb1da700659(widget_ref, gettime());
    player thread function_f1fc9d743cdeff8c(widget_ref, widget_type);
  }
}

function private function_ca38970aae300533(params) {
  player = function_c841dac9e61178e7(params[2]);

  if(isDefined(player)) {
    widget_ref = "<dev string:x12dd>" + params[0];

    if(player function_48c98ea9a4f0da89(widget_ref)) {
      player function_b683400f784cb7dc(widget_ref, params[1]);
    }

    dvar_name = params[0] + "<dev string:x1272>";

    if(isDefined(player.name)) {
      dvar_name = dvar_name + "<dev string:x1176>" + player.name;
    }

    setdevdvar(hashcat(@ "debug_", dvar_name), params[1]);
  }
}

function private function_22d800f8348747e7(params) {
  player = function_c841dac9e61178e7(params[2]);

  if(isDefined(player)) {
    widget_ref = "<dev string:x12dd>" + params[0];

    if(player function_48c98ea9a4f0da89(widget_ref)) {
      player function_d8d634ceece460(widget_ref, params[1]);
    }

    dvar_name = params[0] + "<dev string:x1287>";

    if(isDefined(player.name)) {
      dvar_name = dvar_name + "<dev string:x1176>" + player.name;
    }

    setdevdvar(hashcat(@ "debug_", dvar_name), params[1]);
  }
}

function private function_2f592d237cd3b13b(params) {
  player = function_c841dac9e61178e7(params[1]);

  if(isDefined(player)) {
    widget_ref = "<dev string:x12dd>" + params[0];
    player scripted_widget_destroy(widget_ref);
  }
}

# /