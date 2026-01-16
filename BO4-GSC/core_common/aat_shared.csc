/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\aat_shared.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace aat;

autoexec __init__system__() {
  system::register(#"aat", &__init__, undefined, undefined);
}

private __init__() {
  level.aat_initializing = 1;
  level.aat_default_info_name = "none";
  level.aat_default_info_icon = "blacktransparent";
  level.aat = [];
  register("none", level.aat_default_info_name, level.aat_default_info_icon);
  callback::on_finalize_initialization(&finalize_clientfields);
}

register(name, localized_string, icon) {
  assert(isDefined(level.aat_initializing) && level.aat_initializing, "<dev string:x38>");
  assert(isDefined(name), "<dev string:xa5>");
  assert(!isDefined(level.aat[name]), "<dev string:xcd>" + name + "<dev string:xe6>");
  assert(isDefined(localized_string), "<dev string:x106>");
  assert(isDefined(icon), "<dev string:x13a>");
  level.aat[name] = spawnStruct();
  level.aat[name].name = name;
  level.aat[name].localized_string = localized_string;
  level.aat[name].icon = icon;
}

aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.update_aat_hud)) {
    [[level.update_aat_hud]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

finalize_clientfields() {
  println("<dev string:x162>");

  if(level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;

    foreach(aat in level.aat) {
      aat.n_index = i;
      i++;
      println("<dev string:x17e>" + aat.name);
    }

    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
  }

  level.aat_initializing = 0;
}

get_string(n_aat_index) {
  foreach(aat in level.aat) {
    if(aat.n_index == n_aat_index) {
      return aat.localized_string;
    }
  }

  return level.aat_default_info_name;
}

get_icon(n_aat_index) {
  foreach(aat in level.aat) {
    if(aat.n_index == n_aat_index) {
      return aat.icon;
    }
  }

  return level.aat_default_info_icon;
}