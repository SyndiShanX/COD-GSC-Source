/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_rave_meter.gsc
*****************************************************/

init_rave_meter(param_00) {
  param_00.rave_meter_adustment = 0;
}

rave_meter_on(param_00) {
  param_00 setclientomnvar("zm_ui_show_general", 1);
  param_00 thread clean_up_rave_meter_on_last_stand(param_00);
  param_00 thread clean_up_rave_meter_on_death();
  param_00 rave_drain_time(600);
}

rave_meter_off(param_00) {
  param_00 setclientomnvar("zm_ui_show_general", 0);
  param_00 setclientomnvar("zom_general_fill_percent", 0);
  param_00 notify("rave_mode_exited");
}

clean_up_rave_meter_on_last_stand(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("rave_mode_exited");
  for(;;) {
    param_00 waittill("last_stand");
    if(scripts\engine\utility::istrue(param_00.unlimited_rave)) {
      continue;
    } else {
      param_00 rave_meter_off(param_00);
    }
  }
}

clean_up_rave_meter_on_death() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("rave_mode_exited");
  self waittill("death");
  self.unlimited_rave = undefined;
  scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(self);
}

rave_drain_time(param_00) {
  self endon("disconnect");
  self endon("rave_mode_exited");
  level endon("game_ended");
  thread watchforearlyraveexit();
  var_01 = 1000;
  var_02 = var_01 / 1000;
  var_03 = var_01 / param_00;
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      if(scripts\engine\utility::istrue(self.rave_mode_od)) {
        self.rave_meter_adustment = 0;
      }

      if(!scripts\engine\utility::istrue(self.unlimited_rave)) {
        var_01 = var_01 - var_03 + self.rave_meter_adustment;
        self setclientomnvar("zm_ui_general_two", 0);
      } else {
        self setclientomnvar("zm_ui_general_two", 1);
      }

      if(var_01 > 1000) {
        var_01 = 1000;
      } else if(var_01 <= 0) {
        var_01 = 0;
      }

      self.rave_meter_adustment = 0;
      var_02 = var_01 / 1000;
      if(var_02 > 1) {
        var_02 = 1;
      }

      var_04 = 1 - var_02;
      self setclientomnvar("zom_general_fill_percent", var_04);
      if(var_02 <= 0) {
        self setclientomnvar("zom_general_fill_percent", 0);
        scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(self);
        break;
      }
    }

    wait(0.1);
  }
}

rave_meter_small_bump() {
  self.rave_meter_adustment = self.rave_meter_adustment + 100;
}

rave_meter_large_bump() {
  self.rave_meter_adustment = self.rave_meter_adustment + 500;
}

rave_meter_kill_decrement() {
  self.rave_meter_adustment = self.rave_meter_adustment - 50;
  thread flash_rave_meter_glow();
}

flash_rave_meter_glow() {
  if(!scripts\engine\utility::istrue(self.unlimited_rave)) {
    self setclientomnvar("zm_ui_show_general", 2);
    wait(0.5);
    if(scripts\engine\utility::istrue(self.rave_mode)) {
      self setclientomnvar("zm_ui_show_general", 4);
      return;
    }

    self setclientomnvar("zm_ui_show_general", 0);
  }
}

watchforearlyraveexit() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("rave_mode_exited");
}