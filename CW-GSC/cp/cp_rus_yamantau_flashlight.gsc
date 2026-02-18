/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_yamantau_flashlight.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\utility;
#namespace cp_rus_yamantau_flashlight;

function preload() {
  clientfield::register("toplayer", "cp_rus_yamantau_flashlight", 1, 2, "int");
  clientfield::register("actor", "set_flashlight_fx", 1, 1, "int");
}

function postload() {}

function on_player_spawned() {
  level flag::wait_till("chyron_menu_closed");
  self.var_cef36b49 = 0;
  self thread function_2d7d736();
}

function function_2d7d736() {
  self endon(#"death");

  while(true) {
    if(self actionslotfourbuttonPressed() && !self sprintbuttonPressed()) {
      self function_6afceef5();

      while(self actionslotfourbuttonPressed()) {
        waitframe(1);
      }

      continue;
    } else {
      waitframe(1);
      continue;
    }

    if(self actionslotfourbuttonPressed()) {
      self function_6afceef5();

      while(self actionslotfourbuttonPressed()) {
        waitframe(1);
      }

      continue;
    }

    waitframe(1);
  }
}

function function_6afceef5() {
  if(self.var_cef36b49) {
    self clientfield::set_to_player("cp_rus_yamantau_flashlight", 0);
    self.var_cef36b49 = 0;

    if(level flag::get("flg_bunker_stealth_overrides")) {
      function_ad08c00b();
    }

    return;
  }

  w_current = self getcurrentweapon();

  if(w_current === getweapon(#"knife_loadout") || w_current === getweapon(#"none")) {
    self clientfield::set_to_player("cp_rus_yamantau_flashlight", 2);
  } else {
    self clientfield::set_to_player("cp_rus_yamantau_flashlight", 1);
  }

  self.var_cef36b49 = 1;

  if(level flag::get("flg_bunker_stealth_overrides")) {
    function_aebeccea();
  }
}

function function_aebeccea() {
  var_5d14e11e = [];
  var_5d14e11e[# "prone"] = 400;
  var_5d14e11e[# "crouch"] = 800;
  var_5d14e11e[# "stand"] = 1500;
  var_8293536e = [];
  var_8293536e[# "prone"] = 8192;
  var_8293536e[# "crouch"] = 8192;
  var_8293536e[# "stand"] = 8192;
  namespace_979752dc::set_detect_ranges(var_5d14e11e, var_8293536e);
}

function function_ad08c00b() {
  var_5d14e11e = [];
  var_5d14e11e[# "prone"] = 200;
  var_5d14e11e[# "crouch"] = 400;
  var_5d14e11e[# "stand"] = 600;
  var_8293536e = [];
  var_8293536e[# "prone"] = 300;
  var_8293536e[# "crouch"] = 600;
  var_8293536e[# "stand"] = 1200;
  namespace_979752dc::set_detect_ranges(var_5d14e11e, var_8293536e);
}