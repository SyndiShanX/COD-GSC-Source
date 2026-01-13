/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_chi_meter.gsc
****************************************************/

init_chi_meter(var_0) {
  var_0.chi_meter_adustment = 0;
}

chi_meter_on(var_0, var_1) {
  var_2 = 1;
  switch (var_1) {
    case "snake":
      var_2 = 1;
      break;

    case "tiger":
      var_2 = 2;
      break;

    case "crane":
      var_2 = 3;
      break;

    case "dragon":
      var_2 = 4;
      break;
  }

  var_0 setclientomnvar("zm_ui_show_general", var_2);
  var_0 thread clean_up_chi_meter_on_last_stand(var_0);
  var_0 chi_drain_time(600);
}

chi_meter_off(var_0) {
  var_0 setclientomnvar("zm_ui_show_general", 0);
  var_0 setclientomnvar("zom_general_fill_percent", 0);
  var_0 notify("chi_mode_exited");
}

clean_up_chi_meter_on_last_stand(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("chi_mode_exited");
  for(;;) {
    var_0 waittill("last_stand");
    if(scripts\engine\utility::istrue(var_0.unlimited_chi)) {
      continue;
    } else {
      var_0 chi_meter_off(var_0);
    }
  }
}

chi_drain_time(var_0) {
  self endon("disconnect");
  self endon("chi_mode_exited");
  level endon("game_ended");
  var_1 = 1000;
  var_2 = var_1 / 1000;
  var_3 = var_1 / var_0;
  self.chi_meter_amount = var_1;
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      if(scripts\engine\utility::istrue(self.chi_mode_od)) {
        self.chi_meter_adustment = 0;
      }

      if(!scripts\engine\utility::istrue(self.unlimited_chi)) {
        var_1 = var_1 + self.chi_meter_adustment;
      }

      if(var_1 > 1000) {
        var_1 = 1000;
      } else if(var_1 <= 0) {
        var_1 = 0;
      }

      self.chi_meter_adustment = 0;
      var_2 = var_1 / 1000;
      if(var_2 > 1) {
        var_2 = 1;
      }

      var_4 = var_2;
      self setclientomnvar("zom_general_fill_percent", var_4);
      if(var_2 <= 0) {
        while(scripts\engine\utility::istrue(self.kung_fu_exit_delay)) {
          wait(0.1);
        }

        self setclientomnvar("zom_general_fill_percent", 0);
        self.pre_kung_fu_weapon = scripts\cp\utility::getvalidtakeweapon();
        scripts\cp\maps\cp_disco\kung_fu_mode::unset_kung_fu_mode(self, self.pre_kung_fu_weapon);
        break;
      }
    }

    self.chi_meter_amount = var_1;
    wait(0.1);
  }
}

chi_meter_small_bump() {
  self.chi_meter_adustment = self.chi_meter_adustment + 100;
}

chi_meter_large_bump() {
  self.chi_meter_adustment = self.chi_meter_adustment + 500;
}

chi_meter_kill_decrement(var_0) {
  self.chi_meter_adustment = self.chi_meter_adustment - var_0;
}

flash_chi_meter_glow() {
  if(!scripts\engine\utility::istrue(self.unlimited_chi)) {
    self setclientomnvar("zm_ui_show_general", 2);
    wait(0.5);
    if(scripts\engine\utility::istrue(self.chi_mode)) {
      self setclientomnvar("zm_ui_show_general", 4);
      return;
    }

    self setclientomnvar("zm_ui_show_general", 1);
  }
}

watchforearlychiexit() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("chi_mode_exited");
}