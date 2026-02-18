/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\aat_shared.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace aat;

function private autoexec __init__system__() {
  system::register(#"aat", &preinit, &finalize_clientfields, undefined, undefined);
}

function private preinit() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  clientfield::register("toplayer", "rob_ammo_mod_ready", 1, 1, "int", &rob_ammo_mod_ready, 0, 0);
  clientfield::register_clientuimodel("hud_items.gibDismembermentType", #"hud_items", #"gibdismembermenttype", 16000, 5, "int", undefined, 0, 0);
  level.aat_default_info_name = "none";
  level.aat_default_info_icon = "blacktransparent";
  register("none", level.aat_default_info_name, level.aat_default_info_icon);
}

function function_2b3bcce0() {
  if(!isDefined(level.var_e44e90d6)) {
    return;
  }

  foreach(call in level.var_e44e90d6) {
    [[call]]();
  }
}

function rob_ammo_mod_ready(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrenderoverridebundle("rob_ammo_mod_ready_light");
    return;
  }

  self stoprenderoverridebundle("rob_ammo_mod_ready_light");
}

function function_571fceb(aat_name, main) {
  if(!isDefined(level.var_e44e90d6)) {
    level.var_e44e90d6 = [];
  }

  if(isDefined(level.var_e44e90d6[aat_name])) {
    println("<dev string:x38>" + aat_name + "<dev string:x64>");
  }

  level.var_e44e90d6[aat_name] = main;
}

function register(name, localized_string, icon) {
  if(!isDefined(level.aat)) {
    level.aat = [];
  }

  assert(!is_false(level.aat_initializing), "<dev string:x91>");
  assert(isDefined(name), "<dev string:xff>");
  assert(!isDefined(level.aat[name]), "<dev string:x128>" + name + "<dev string:x142>");
  assert(isDefined(localized_string), "<dev string:x163>");
  assert(isDefined(icon), "<dev string:x198>");
  level.aat[name] = spawnStruct();
  level.aat[name].name = name;
  level.aat[name].localized_string = localized_string;
  level.aat[name].icon = icon;
}

function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.update_aat_hud)) {
    [[level.update_aat_hud]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    return;
  }

  update_aat_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function finalize_clientfields() {
  println("<dev string:x1c1>");

  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(level.aat.size > 1) {
    array::alphabetize(level.aat);
    i = 0;

    foreach(aat in level.aat) {
      aat.n_index = i;
      i++;
      println("<dev string:x1de>" + aat.name);
    }

    n_bits = getminbitcountfornum(level.aat.size - 1);
    clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
  }

  level.aat_initializing = 0;
}

function function_d1852e75(n_aat_index) {
  foreach(aat in level.aat) {
    if(aat.n_index == n_aat_index) {
      return hash(aat.name);
    }
  }

  return # "none";
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

function function_467efa7b(var_9f3fb329 = 0) {
  if(!isDefined(self.archetype)) {
    return "tag_origin";
  }

  switch (self.archetype) {
    case # "stoker":
    case # "catalyst":
    case # "gladiator":
    case # "nova_crawler":
    case # "zombie":
    case # "ghost":
    case # "brutus":
      if(var_9f3fb329) {
        str_tag = "j_spine4";
      } else {
        str_tag = "j_spineupper";
      }

      break;
    case # "blight_father":
    case # "tiger":
    case # "elephant":
      str_tag = "j_head";
      break;
    default:
      str_tag = "tag_origin";
      break;
  }

  return str_tag;
}

function update_aat_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  name_hash = function_d1852e75(bwastimejump);
  str_localized = get_string(bwastimejump);
  icon = get_icon(bwastimejump);

  if(str_localized == "none") {
    str_localized = # "";
  }

  var_ca2e17a3 = function_1df4c3b0(fieldname, #"zm_hud");
  var_2961e149 = createuimodel(var_ca2e17a3, "aatNameHash");
  setuimodelvalue(var_2961e149, name_hash);
  aatmodel = createuimodel(var_ca2e17a3, "aat");
  setuimodelvalue(aatmodel, str_localized);
  aaticonmodel = createuimodel(var_ca2e17a3, "aatIcon");
  setuimodelvalue(aaticonmodel, icon);
}