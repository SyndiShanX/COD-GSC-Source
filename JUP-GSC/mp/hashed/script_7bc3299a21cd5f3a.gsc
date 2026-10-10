/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7bc3299a21cd5f3a.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\utility\dvars;
#namespace perk_death_perception;

function function_3898a008fcd449e9(str_currency, var_fe59c44529c721a0) {
  n_perk_cost = default_to(var_fe59c44529c721a0, 2000);
  level thread function_f3a23df892bf82f6("specialty_death_perception", str_currency, n_perk_cost, &function_b082d082ea19d61e, &function_548af41a7d702704, 1, 1);
}

function function_b082d082ea19d61e() {
  self notify("end_death_perception");

  if(issharedfuncdefined("unlock_relics_s3", "death_perception_check")) {
    self[[getsharedfunc("unlock_relics_s3", "death_perception_check")]]();
  }

  thread function_a3cd1789cdd98eb4();
}

function function_a3cd1789cdd98eb4() {
  level endon("game_ended");
  self endon("death");
  self endon("end_death_perception");
  var_6cc0e51421b0dfe6 = [];
  bundle = level.perkbundles["specialty_death_perception"];
  radius = default_to(bundle.var_9b6739d84c393132, 600);

  while(true) {
    var_209a236c75708db0 = getaiarrayinradius(self.origin, radius);

    foreach(ai in var_6cc0e51421b0dfe6) {
      if(!isDefined(ai) || array_contains(var_209a236c75708db0, ai)) {
        continue;
      }

      ai hudoutlinedisableforclient(self);
      var_6cc0e51421b0dfe6 = array_remove(var_6cc0e51421b0dfe6, ai);
    }

    var_6cc0e51421b0dfe6 = array_removeundefined(var_6cc0e51421b0dfe6);

    foreach(ai in var_209a236c75708db0) {
      if(ai.team == self.team || ai.team == "neutral") {
        ai hudoutlinedisableforclient(self);

        if(array_contains(var_6cc0e51421b0dfe6, ai)) {
          var_6cc0e51421b0dfe6 = array_remove(var_6cc0e51421b0dfe6, ai);
        }

        continue;
      }

      if(ai ent_flag("spawn_animating") || self getclientomnvar("ui_hide_hud") == 1) {
        ai hudoutlinedisableforclient(self);

        if(array_contains(var_6cc0e51421b0dfe6, ai)) {
          var_6cc0e51421b0dfe6 = array_remove(var_6cc0e51421b0dfe6, ai);
        }

        continue;
      }

      if(isDefined(ai) && !istrue(ai.var_54b7951c49363c15) && !array_contains(var_6cc0e51421b0dfe6, ai)) {
        outline_name = "jup_death_perception";

        if(isDefined(level.gametype) && level.gametype == "zm_rb") {
          outline_name = "death_perception";
        }

        ai hudoutlineenableforclients([self], outline_name);
        var_6cc0e51421b0dfe6 = array_add(var_6cc0e51421b0dfe6, ai);
      }
    }

    waitframe();
  }
}

function function_236b011a322933f() {
  level endon("game_ended");
  self endon("death");
  self endon("end_death_perception");
  var_592695d36ff6a0f9 = [];
  bundle = level.perkbundles["specialty_death_perception"];
  radius = default_to(bundle.var_9b6739d84c393132, 600);

  while(true) {
    var_f0c7f034eb6bac63 = getentarrayinradius(undefined, undefined, self.origin, radius);

    foreach(item in var_592695d36ff6a0f9) {
      if(!item function_86eebb20520a5e5d()) {
        continue;
      }

      if(array_contains(var_f0c7f034eb6bac63, item)) {
        continue;
      }

      item hudoutlinedisableforclient(self);
      var_592695d36ff6a0f9 = array_remove(var_592695d36ff6a0f9, item);
    }

    var_592695d36ff6a0f9 = array_removeundefined(var_592695d36ff6a0f9);

    foreach(item in var_f0c7f034eb6bac63) {
      if(!item function_86eebb20520a5e5d()) {
        continue;
      }

      if(array_contains(var_592695d36ff6a0f9, item)) {
        continue;
      }

      item hudoutlineenableforclients([self], "outline_nodepth_white");
      var_592695d36ff6a0f9 = array_add(var_592695d36ff6a0f9, item);
    }

    waitframe();
  }
}

function function_86eebb20520a5e5d() {
  return isDefined(self) && istrue(ent_flag("perk_death_perception_fx"));
}

function function_548af41a7d702704(b_pause, str_perk, str_result, n_slot) {
  self notify("end_death_perception");
  bundle = level.perkbundles["specialty_death_perception"];
  radius = default_to(bundle.var_9b6739d84c393132, 600);
  radius *= 1.5;
  var_209a236c75708db0 = getaiarrayinradius(self.origin, radius);

  foreach(ai in var_209a236c75708db0) {
    if(!isDefined(ai)) {
      continue;
    }

    ai hudoutlinedisableforclient(self);
  }

  var_f0c7f034eb6bac63 = getentarrayinradius(undefined, undefined, self.origin, radius);

  foreach(item in var_f0c7f034eb6bac63) {
    if(!item function_86eebb20520a5e5d()) {
      continue;
    }

    item hudoutlinedisableforclient(self);
  }
}