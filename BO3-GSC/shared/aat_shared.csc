/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\aat_shared.csc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace aat;

function autoexec __init__sytem__() {
  system::register("aat", & __init__, undefined, undefined);
}

function private __init__() {
  level.aat_initializing = 1;
  level.aat_default_info_name = "none";
  level.aat_default_info_icon = "blacktransparent";
  level.aat = [];
  register("none", level.aat_default_info_name, level.aat_default_info_icon);
  callback::on_finalize_initialization( & finalize_clientfields);
}

function register(name, localized_string, icon) {
  assert(isDefined(level.aat_initializing) && level.aat_initializing, "");
  assert(isDefined(name), "");
  assert(!isDefined(level.aat[name]), ("" + name) + "");
  assert(isDefined(localized_string), "");
  assert(isDefined(icon), "");
  level.aat[name] = spawnStruct();
  level.aat[name].name = name;
  level.aat[name].localized_string = localized_string;
  level.aat[name].icon = icon;
}

function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.update_aat_hud)) {
    [[level.update_aat_hud]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function finalize_clientfields() {
  println("");
  if(level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;
    foreach(aat in level.aat) {
      aat.n_index = i;
      i++;
      println("" + aat.name);
    }
    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int", & aat_hud_manager, 0, 1);
  }
  level.aat_initializing = 0;
}

function get_string(n_aat_index) {
  foreach(aat in level.aat) {
    if(aat.n_index == n_aat_index) {
      return aat.localized_string;
    }
  }
  return level.aat_default_info_name;
}

function get_icon(n_aat_index) {
  foreach(aat in level.aat) {
    if(aat.n_index == n_aat_index) {
      return aat.icon;
    }
  }
  return level.aat_default_info_icon;
}