/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_rave_meter.gsc
*****************************************************/

init_rave_meter(var_0) {
  var_0.rave_meter_adustment = 0;
}

rave_meter_on(var_0) {
  var_0 setclientomnvar("zm_ui_show_general", 1);
  var_0 thread clean_up_rave_meter_on_last_stand(var_0);
  var_0 thread clean_up_rave_meter_on_death();
  var_0 rave_drain_time(600);
}

rave_meter_off(var_0) {
  var_0 setclientomnvar("zm_ui_show_general", 0);
  var_0 setclientomnvar("zom_general_fill_percent", 0);
  var_0 notify("rave_mode_exited");
}

clean_up_rave_meter_on_last_stand(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("rave_mode_exited");
  for(;;) {
    var_0 waittill("last_stand");
    if(scripts\engine\utility::istrue(var_0.unlimited_rave)) {
      continue;
    } else {
      var_0 rave_meter_off(var_0);
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

rave_drain_time(var_0) {
  self endon("disconnect");
  self endon("rave_mode_exited");
  level endon("game_ended");
  thread watchforearlyraveexit();
  var_1 = 1000;
  var_2 = var_1 / 1000;
  var_3 = var_1 / var_0;
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      if(scripts\engine\utility::istrue(self.rave_mode_od)) {
        self.rave_meter_adustment = 0;
      }

      if(!scripts\engine\utility::istrue(self.unlimited_rave)) {
        var_1 = var_1 - var_3 + self.rave_meter_adustment;
        self setclientomnvar("zm_ui_general_two", 0);
      } else {
        self setclientomnvar("zm_ui_general_two", 1);
      }

      if(var_1 > 1000) {
        var_1 = 1000;
      } else if(var_1 <= 0) {
        var_1 = 0;
      }

      self.rave_meter_adustment = 0;
      var_2 = var_1 / 1000;
      if(var_2 > 1) {
        var_2 = 1;
      }

      var_4 = 1 - var_2;
      self setclientomnvar("zom_general_fill_percent", var_4);
      if(var_2 <= 0) {
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