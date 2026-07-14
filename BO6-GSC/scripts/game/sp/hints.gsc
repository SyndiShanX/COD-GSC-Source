/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\hints.gsc
**************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace hints;

function private autoexec __init__system__() {
  system::register(#"hints", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_d596b87170a22e50();
}

function private function_6cc85c6fa344e5d2(hint_widget) {
  level.hint_widget = hint_widget;
  data = getscriptbundle(hint_widget);
  assert(isDefined(data), "<dev string:x24>");
  data.hints = [];

  foreach(param in data.parameters) {
    foreach(property in param.properties) {
      if(property.variant_object.property == "[\xd3ENr\xef[\xa1k\x95\xd8") {
        object_array = strtok(property.variant_object.value, "\x93");
        object_name = object_array[0];
        bundle = object_array[1] + "\xb0" + object_name;
        data.hints[param.name] = getscriptbundle(bundle);
        break;
      }
    }
  }

  level.var_d8fa225e600aaf8f = data;
}

function private function_d596b87170a22e50() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  utility::registersharedfunc(#"hint", #"add", &hint_add);
  utility::registersharedfunc(#"hint", #"add_action", &function_1e2f5b6b3cf70316);
  utility::registersharedfunc(#"hint", #"add_simple", &function_5a014227dcf6b296);
  utility::registersharedfunc(#"hint", #"add_wait", &function_b5bf049516f74cc9);
  utility::registersharedfunc(#"hint", #"hash_2b2f91f1c8e68e05", &function_8d2f04d53d477578);
  utility::registersharedfunc(#"hint", #"hash_cd4214fe09883c15", &function_704ff287999613f8);
  utility::registersharedfunc(#"hint", #"close", &hint_close);
  ui::lui_registercallback("x|\xfc}\xd6\xbe,g}\f\xa1\xb5\xd4>,O\xb3\xa4=Ee/Pk", &hint_close_anim_complete);
  ui::lui_registercallback("\x8d\xac\xca\x88K\xb0\xac\x0f\x87M\x80\xa8I", &hint_interact);
  level utility::flag_set("\x9e'\xc8\x8f<KZ\xc4\xbb\t\xf7Ul\xb4\x83\xd6\xd2");
}

function private hint_interact(val) {
  if(isDefined(self.hints.interacts[val - 1]) && isDefined(self.hints.interacts) && isDefined(self.hints.interacts[val - 1].script_notify)) {
    self notify(self.hints.interacts[val - 1].script_notify);
  }
}

function private function_6ad638c58ca59362() {
  if(!isDefined(self.hints)) {
    self.hints = spawnStruct();
    self.hints.hint_queue = [];
    self.hints.hint_ref = undefined;
    self.hints.hint_paused = 0;
    self.hints.var_b28312194afb47e6 = 0;
  }
}

function private function_c7adece5f9460e28(hint_ref, var_df96be775521d9e1) {
  hint_widget = undefined;

  if(isstring(var_df96be775521d9e1)) {
    hint_widget = hashcat(%"scriptedwidget:", var_df96be775521d9e1);
  } else {
    hint_widget = hud_management::function_a1a13273e72bfe46("\xe3\x82~\xa4\x9d\x19\x80V'\x1c\x9c\xde\x86\x95\xbe\x10\x02&\xe8\xe3\xa6");
  }

  if(isDefined(hint_widget)) {
    data = getscriptbundle(hint_widget);

    if(isDefined(data.parameters)) {
      foreach(param in data.parameters) {
        if(param.name == hint_ref) {
          foreach(property in param.properties) {
            if(property.variant_object.property == "[\xd3ENr\xef[\xa1k\x95\xd8") {
              object_array = strtok(property.variant_object.value, "\x93");
              object_name = object_array[0];
              bundle = object_array[1] + "\xb0" + object_name;
              return getscriptbundle(bundle);
            }
          }
        }
      }
    }
  }
}

function private skip_tutorial(hint_ref, var_df96be775521d9e1) {
  object_data = function_c7adece5f9460e28(hint_ref, var_df96be775521d9e1);

  if(isDefined(object_data.interactions)) {
    foreach(interaction in object_data.interactions) {
      if(isDefined(interaction.script_notify)) {
        self notify(interaction.script_notify);
      }
    }
  }

  self notify(hint_ref + "\xf5\x8d\xd8\xf6\xe6\xac\x91");

  if(!isDefined(self.hints.hint_ref) || self.hints.hint_ref == hint_ref) {
    self notify("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");
  }
}

function is_tutorial(hint_ref, var_df96be775521d9e1) {
  object_data = function_c7adece5f9460e28(hint_ref, var_df96be775521d9e1);
  return isDefined(object_data) && istrue(object_data.istutorial);
}

function hint_add(hint_ref, timeout, breakfunc, var_9c9f91706d6a026f, var_dd22d559d89cdbf8 = 1, var_df96be775521d9e1, var_53d8f247f2dc823f = 1) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\x9e'\xc8\x8f<KZ\xc4\xbb\t\xf7Ul\xb4\x83\xd6\xd2");
  is_tutorial = is_tutorial(hint_ref, var_df96be775521d9e1);

  if(is_tutorial && utility::callsharedfunc(#"game", #"getplayerprofiledata", "\xbd\x87w\xc0\xadQ\x1bq\v]V\xed\xcbd\xc4\x1d") != 1) {
    utility::delaythread(level.framedurationseconds, &skip_tutorial, hint_ref, var_df96be775521d9e1);
    return;
  }

  if(!var_53d8f247f2dc823f && istrue(utility::callsharedfunc(#"save", #"hash_216b53601f207a16", "N\xfb\xa8\xed\xdd*z+\rO" + hint_ref))) {
    utility::delaythread(level.framedurationseconds, &skip_tutorial, hint_ref, var_df96be775521d9e1);
    return;
  }

  function_6ad638c58ca59362();

  if(!function_16114a9dd4f720e7(hint_ref)) {
    return;
  }

  self notify("\x86Z\xdc\xe8}\xb0#\xc8");

  if(isDefined(self.hints.hint_ref) || istrue(self.hints.hint_paused) || hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    next_hint = spawnStruct();
    next_hint.hint_ref = hint_ref;
    next_hint.timeout = timeout;
    next_hint.breakfunc = breakfunc;
    next_hint.var_9c9f91706d6a026f = var_9c9f91706d6a026f;
    next_hint.var_dd22d559d89cdbf8 = var_dd22d559d89cdbf8;

    if(is_tutorial && (!isDefined(self.hints.hint_ref) || !is_tutorial(self.hints.hint_ref))) {
      self.hints.hint_queue = utility::function_f2d532fb3f4b0273(self.hints.hint_queue, next_hint);
      hint_close(undefined, 1);
    } else {
      self.hints.hint_queue[self.hints.hint_queue.size] = next_hint;
    }

    return;
  }

  hint_open(hint_ref, timeout, breakfunc, var_9c9f91706d6a026f, var_dd22d559d89cdbf8, var_df96be775521d9e1);
}

function private function_16114a9dd4f720e7(hint_ref) {
  if(self.hints.hint_ref == hint_ref || self.hints.hiding_hint == hint_ref) {
    return false;
  }

  foreach(hint_data in self.hints.hint_queue) {
    if(hint_data.hint_ref == hint_ref) {
      return false;
    }
  }

  return true;
}

function function_b5bf049516f74cc9(hint_ref, timeout, breakfunc, var_9c9f91706d6a026f, var_dd22d559d89cdbf8, var_df96be775521d9e1, var_53d8f247f2dc823f) {
  thread hint_add(hint_ref, timeout, breakfunc, var_9c9f91706d6a026f, var_dd22d559d89cdbf8, var_df96be775521d9e1, var_53d8f247f2dc823f);
  self waittill(hint_ref + "\xf5\x8d\xd8\xf6\xe6\xac\x91");
}

function private function_540abb30e8740492(hint_ref, var_68f062defd0a0d3f, timeout = 0, breakfunc = undefined, var_9c9f91706d6a026f = undefined, delay = 0, var_dd22d559d89cdbf8 = 1, var_e4fdb7f805849eeb = 0) {
  assert(isDefined(hint_ref));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\x9e'\xc8\x8f<KZ\xc4\xbb\t\xf7Ul\xb4\x83\xd6\xd2");
  function_6ad638c58ca59362();

  if(!function_16114a9dd4f720e7(hint_ref)) {
    return;
  }

  self notify("\x86Z\xdc\xe8}\xb0#\xc8");

  if(!var_e4fdb7f805849eeb && (isDefined(self.hints.hint_ref) || istrue(self.hints.hint_paused) || hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb"))) {
    next_hint = spawnStruct();
    next_hint.hint_ref = hint_ref;
    next_hint.var_68f062defd0a0d3f = var_68f062defd0a0d3f;
    next_hint.timeout = timeout;
    next_hint.breakfunc = breakfunc;
    next_hint.var_9c9f91706d6a026f = var_9c9f91706d6a026f;
    next_hint.delay = delay;
    next_hint.var_e4fdb7f805849eeb = var_e4fdb7f805849eeb;
    next_hint.var_dd22d559d89cdbf8 = var_dd22d559d89cdbf8;

    if(is_tutorial(hint_ref) && (!isDefined(self.hints.hint_ref) || !is_tutorial(self.hints.hint_ref))) {
      self.hints.hint_queue = utility::function_f2d532fb3f4b0273(self.hints.hint_queue, next_hint);
      hint_close(undefined, 1);
    } else {
      self.hints.hint_queue[self.hints.hint_queue.size] = next_hint;
    }

    return;
  }

  function_d7148837f9f85e31(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8, var_e4fdb7f805849eeb);
}

function function_1e2f5b6b3cf70316(hint_ref, var_68f062defd0a0d3f, timeout = 0, breakfunc, var_9c9f91706d6a026f, delay = 0, var_dd22d559d89cdbf8 = 1, var_53d8f247f2dc823f = 1) {
  if(is_tutorial(hint_ref) && utility::callsharedfunc(#"game", #"getplayerprofiledata", "\xbd\x87w\xc0\xadQ\x1bq\v]V\xed\xcbd\xc4\x1d") != 1) {
    utility::delaythread(level.framedurationseconds, &skip_tutorial, hint_ref);
    return;
  }

  if(!var_53d8f247f2dc823f && istrue(utility::callsharedfunc(#"save", #"hash_216b53601f207a16", "N\xfb\xa8\xed\xdd*z+\rO" + hint_ref))) {
    utility::delaythread(level.framedurationseconds, &skip_tutorial, hint_ref);
    return;
  }

  function_540abb30e8740492(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8, 1);
}

function function_8d2f04d53d477578(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8, var_53d8f247f2dc823f) {
  thread function_1e2f5b6b3cf70316(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8, var_53d8f247f2dc823f);
  self waittill(hint_ref + "\xf5\x8d\xd8\xf6\xe6\xac\x91");
}

function function_5a014227dcf6b296(hint_ref, var_68f062defd0a0d3f, timeout = 0, breakfunc, var_9c9f91706d6a026f, delay = 0, var_dd22d559d89cdbf8 = 1) {
  function_540abb30e8740492(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8);
}

function function_704ff287999613f8(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8) {
  thread function_5a014227dcf6b296(hint_ref, var_68f062defd0a0d3f, timeout, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8);
  self waittill(hint_ref + "\xf5\x8d\xd8\xf6\xe6\xac\x91");
}

function private function_d7148837f9f85e31(hint_ref, var_68f062defd0a0d3f, timeout = 0, breakfunc, var_9c9f91706d6a026f, delay, var_dd22d559d89cdbf8, var_e4fdb7f805849eeb) {
  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    hud_management::scripted_widget_destroy("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb");
  }

  var_e11a82e99c7a716 = hud_management::function_a1a13273e72bfe46("\xa3 4\xce\xd9A\\\x97g\x9d11?\xe4W\x1d\x94\xc3\x15\n|\x05BT\x0e\x8d\v");
  assert(isDefined(var_e11a82e99c7a716));
  level.hint_widget = var_e11a82e99c7a716;
  hud_management::function_35924dfcb78711f4("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", level.hint_widget);
  hud_management::function_85d8a0ba2e35b6f2("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", 0, 0, 3, 3);
  hud_management::function_aaab83e8c950f455("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", 6);
  hud_management::function_41ff479ac45608d6("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", function_59b75a8ab4e012cd(var_68f062defd0a0d3f), 1);

  if(var_e4fdb7f805849eeb) {
    hud_management::function_d8d634ceece460("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\xcf\xd5!\xe8\xd4\x9d");
    waitframe();
  }

  if(delay > 0) {
    wait delay;
  }

  hint_show();
  function_6ad638c58ca59362();
  self.hints.hint_ref = hint_ref;
  self notify(self.hints.hint_ref + "g\xcfefz\xd5");

  if(isDefined(var_9c9f91706d6a026f)) {
    thread function_d22488b80737728b(var_9c9f91706d6a026f, var_dd22d559d89cdbf8);
  }

  if(isDefined(breakfunc)) {
    thread function_a3374971d47b22f7(breakfunc, var_dd22d559d89cdbf8);
  }

  if(timeout > 0) {
    thread function_45f5a3dc6f31d0f2(timeout, var_dd22d559d89cdbf8);
  }
}

function private function_d22488b80737728b(notify_str, var_dd22d559d89cdbf8 = 1) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");
  self waittill(notify_str);
  thread hint_close(undefined, !var_dd22d559d89cdbf8);
}

function private hint_close_anim_complete(val) {
  if(self.hints.hiding_hint == self.hints.hint_ref) {
    hint_close(undefined, 1);
  }
}

function private hint_open(hint_ref, timeout, breakfunc, var_9c9f91706d6a026f, var_dd22d559d89cdbf8, var_df96be775521d9e1) {
  if(isDefined(var_df96be775521d9e1) && isstring(var_df96be775521d9e1)) {
    function_6cc85c6fa344e5d2(hashcat(%"scriptedwidget:", var_df96be775521d9e1));
  } else {
    hint_widget = hud_management::function_a1a13273e72bfe46("\xe3\x82~\xa4\x9d\x19\x80V'\x1c\x9c\xde\x86\x95\xbe\x10\x02&\xe8\xe3\xa6");
    assert(isDefined(hint_widget));
    function_6cc85c6fa344e5d2(hint_widget);
  }

  widgetstruct = spawnStruct();
  widgetstruct.param = hint_ref;
  assert(isDefined(hint_ref));

  foreach(param in level.var_d8fa225e600aaf8f.parameters) {
    if(param.name == hint_ref) {
      foreach(property in param.properties) {
        if(property.variant_object.property == "[\xd3ENr\xef[\xa1k\x95\xd8") {
          object_name = strtok(property.variant_object.value, "\x93");
          object_data = getscriptbundle(object_name[1] + "\xb0" + object_name[0]);
          widgetstruct.object_data = object_data;
          break;
        }
      }

      break;
    }
  }

  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    hud_management::scripted_widget_destroy("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb");
  }

  hud_management::function_35924dfcb78711f4("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", level.hint_widget, widgetstruct);
  hud_management::function_85d8a0ba2e35b6f2("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", 0, 0, 3, 3);

  if(istrue(widgetstruct.object_data.hideshud)) {
    val::set("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
    val::set("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\xa8Jl\x84\xb3b\x95o", 0);
  }

  hud_management::function_aaab83e8c950f455("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", 6);
  hint_show();
  self.hints.hint_ref = hint_ref;

  if(isDefined(self.hints.hint_ref)) {
    self notify(self.hints.hint_ref + "g\xcfefz\xd5");
  }

  if(isDefined(widgetstruct.object_data)) {
    if(isDefined(widgetstruct.object_data.timescale) && widgetstruct.object_data.timescale < 0) {
      self.hints.var_b28312194afb47e6 = 1;
      utility_sp::function_712369ee845f814c("a;;e\xca\x8bsC\x16\x17>\xa2\xd8\xad", widgetstruct.object_data.timescale, 0);
    }

    if(isDefined(widgetstruct.object_data.var_aaac32b2ef7f41c4)) {
      val::set("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
      val::set("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
    }

    self.hints.interacts = widgetstruct.object_data.interactions;
  }

  if(isDefined(var_9c9f91706d6a026f)) {
    thread function_d22488b80737728b(var_9c9f91706d6a026f, var_dd22d559d89cdbf8);
  }

  if(isDefined(breakfunc)) {
    thread function_a3374971d47b22f7(breakfunc, var_dd22d559d89cdbf8);
  }

  if(isDefined(timeout)) {
    thread function_45f5a3dc6f31d0f2(timeout, var_dd22d559d89cdbf8);
  }

  thread function_22a26a79e20d79d1();
}

function hint_show() {
  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    hud_management::function_d8d634ceece460("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\xf1\xba\x8f\x9d");
  }
}

function hint_hide() {
  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    self.hints.hiding_hint = self.hints.hint_ref;
    hud_management::function_d8d634ceece460("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb", "\x19b\xc2y");
  }
}

function hint_close(hint_ref = undefined, immediate = 0) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_c12d2ee016749c84 = !isDefined(hint_ref) || hint_ref == self.hints.hint_ref;

  if(!istrue(immediate) && var_c12d2ee016749c84) {
    hint_hide();
    return;
  }

  if(var_c12d2ee016749c84) {
    self.hints.hiding_hint = undefined;

    if(istrue(self.hints.var_b28312194afb47e6)) {
      utility_sp::function_2853d8d2bf2b2f5("a;;e\xca\x8bsC\x16\x17>\xa2\xd8\xad", 0);
      self.hints.var_b28312194afb47e6 = 0;
    }

    val::reset_all("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb");
    self notify("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");

    while(istrue(self.hints.hint_paused)) {
      waitframe();
    }

    if(isDefined(self.hints)) {
      if(isDefined(self.hints.hint_ref)) {
        if(utility::issharedfuncdefined(#"save", #"set_player_data")) {
          utility::callsharedfunc(#"save", #"set_player_data", "N\xfb\xa8\xed\xdd*z+\rO" + self.hints.hint_ref, 1);
        }

        self notify(self.hints.hint_ref + "\xf5\x8d\xd8\xf6\xe6\xac\x91");
        self.hints.hint_ref = undefined;
      }

      while(self.hints.hint_queue.size > 0) {
        next_hint = self.hints.hint_queue[0];
        self.hints.hint_queue = utility::array_remove_index(self.hints.hint_queue, 0);

        if(isDefined(next_hint.var_68f062defd0a0d3f)) {
          if(!isDefined(next_hint.breakfunc) || !self[[next_hint.breakfunc]]()) {
            thread function_d7148837f9f85e31(next_hint.hint_ref, next_hint.var_68f062defd0a0d3f, next_hint.timeout, next_hint.breakfunc, next_hint.var_9c9f91706d6a026f, next_hint.delay, next_hint.var_dd22d559d89cdbf8, next_hint.var_e4fdb7f805849eeb);
            return;
          }

          continue;
        }

        if(!isDefined(next_hint.breakfunc) || !self[[next_hint.breakfunc]]()) {
          thread hint_open(next_hint.hint_ref, next_hint.timeout, next_hint.breakfunc, next_hint.var_9c9f91706d6a026f, next_hint.var_dd22d559d89cdbf8);
          return;
        }
      }
    }

    hint_remove();
    return;
  }

  if(isDefined(self.hints) && isDefined(self.hints.hint_queue)) {
    foreach(hint_data in self.hints.hint_queue) {
      if(hint_data.hint_ref == hint_ref) {
        self.hints.hint_queue = utility::array_remove_index(self.hints.hint_queue, index);
      }
    }
  }
}

function function_a3374971d47b22f7(breakfunc, var_ec23e3c97e959a14 = 1) {
  self endon("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");

  while(!self[[breakfunc]]() || istrue(self.hints.hint_paused)) {
    waitframe();
  }

  thread hint_close(undefined, !var_ec23e3c97e959a14);
}

function function_45f5a3dc6f31d0f2(timeout, var_910415d5c0830867 = 1) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");
  start_time = gettime();
  wait timeout;

  while(istrue(self.hints.hint_paused)) {
    waitframe();
  }

  if(isDefined(self.hints.var_6b2db1136c41fe69) && self.hints.var_6b2db1136c41fe69 >= start_time) {
    thread function_45f5a3dc6f31d0f2(timeout - (self.hints.var_6b2db1136c41fe69 - start_time) / 1000);
    return;
  }

  thread hint_close(undefined, !var_910415d5c0830867);
}

function function_568b1bf7d22b9c7d() {
  self.hints.hint_paused = 1;
  self.hints.var_6b2db1136c41fe69 = gettime();
  thread hint_hide();
}

function function_9247a1cbc5c96b4b() {
  self.hints.hint_paused = 0;

  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    thread hint_show();
    return;
  }

  if(level.hint_queue.size > 0) {
    next_hint = self.hints.hint_queue[0];
    thread hint_open(next_hint.hint_ref, next_hint.timeout, next_hint.breakfunc);
    self.hints.hint_queue = utility::array_remove_index(self.hints.hint_queue, 0);
  }
}

function private hint_remove() {
  if(hud_management::function_48c98ea9a4f0da89("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb")) {
    self.hints = undefined;
    hud_management::scripted_widget_destroy("X\xbc\xbbQ7\xf79\xb7\xc5\xadEb");
  }
}

function private function_59b75a8ab4e012cd(var_cd188f37b7176224) {
  fields = [];
  fields["\xed\x0f\xb6\xb1\xb6\x82\xd2\x1b,8\xa3Z|k\xcb\x05\xee\x93:\xd3\xa9"] = function_30e4f86dded0873(var_cd188f37b7176224);
  return fields;
}

function private function_22a26a79e20d79d1() {
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  self endon("\xa1\xd2\xcd\xe8\xafl6o\xe6\xb2");
  self waittill("\x1e\xfd\xd1\xa2\a");
  thread hint_close();
}