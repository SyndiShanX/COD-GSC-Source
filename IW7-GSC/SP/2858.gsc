/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2858.gsc
************************/

func_B9D3() {
  scripts\engine\utility::flag_init("primary_equipment_input_down");
  scripts\engine\utility::flag_init("secondary_equipment_input_down");
  scripts\engine\utility::flag_init("primary_equipment_in_use");
  scripts\engine\utility::flag_init("secondary_equipment_in_use");
  scripts\engine\utility::flag_init("equipment_switching_disabled");
  thread func_B998();
  thread func_B9A1();
  thread func_6697();
  thread func_61F4();
}

func_6240(param_00) {
  level.player.var_110C0 = param_00;
}

func_B998() {
  self endon("death");
  for(;;) {
    self waittill("primary_equipment_change", var_00);
    switch (var_00) {
      case "emp":
        level.player thread lib_0E25::func_618D();
        break;

      case "seeker":
        thread lib_0E26::func_F162();
        break;

      default:
        break;
    }
  }
}

func_B9A1() {
  self endon("death");
  for(;;) {
    self waittill("secondary_equipment_change", var_00);
    switch (var_00) {
      case "offhandshield_up1":
      case "offhandshield":
        thread lib_0E2B::func_C334();
        break;

      case "hackingdevice":
        thread lib_0E29::func_8836();
        break;

      case "supportdrone_up2":
      case "supportdrone":
        thread lib_0E2D::func_112BB();
        break;

      default:
        break;
    }
  }
}

func_6697() {
  self endon("death");
  var_00 = 0;
  var_01 = 0;
  for(;;) {
    if(self fragbuttonpressed() && !var_00) {
      scripts\engine\utility::flag_set("primary_equipment_input_down");
      level.player notify("primary_equipment_pressed");
      var_00 = 1;
    } else if(!self fragbuttonpressed() && var_00) {
      scripts\engine\utility::flag_clear("primary_equipment_input_down");
      level.player notify("primary_equipment_released");
      var_00 = 0;
    }

    if(self secondaryoffhandbuttonpressed() && !var_01) {
      scripts\engine\utility::flag_set("secondary_equipment_input_down");
      level.player notify("secondary_equipment_pressed");
      var_01 = 1;
    } else if(!self secondaryoffhandbuttonpressed() && var_01) {
      scripts\engine\utility::flag_clear("secondary_equipment_input_down");
      level.player notify("secondary_equipment_released");
      var_01 = 0;
    }

    wait(0.05);
  }
}

func_61F4() {
  thread func_D8CF();
  thread func_F0B5();
}

func_5527() {
  level.player notify("disable_equipment_autoswitch");
}

func_D8CF() {
  self endon("death");
  self endon("disable_equipment_autoswitch");
  while(!isDefined(level.player.curobjid)) {
    wait(0.05);
  }

  thread func_D8CE();
  for(;;) {
    var_00 = scripts\sp\utility::func_7BD6();
    if(!isDefined(var_00)) {
      level.player waittill("primary_equipment_change");
      continue;
    }

    var_01 = scripts\sp\utility::func_7BD7();
    self waittill("offhand_fired");
    if(!isDefined(scripts\sp\utility::func_7BD6()) || var_00 != scripts\sp\utility::func_7BD6()) {
      continue;
    }

    if(var_01 == scripts\sp\utility::func_7BD7()) {
      continue;
    }

    if(isDefined(scripts\sp\utility::func_7BD6()) && scripts\sp\utility::func_7BD7() <= 0) {
      if(isDefined(scripts\sp\utility::func_7CAF()) && scripts\sp\utility::func_7CB0() > 0) {
        func_1418();
      }
    }
  }
}

func_D8CE() {
  self endon("death");
  self endon("disable_equipment_autoswitch");
  for(;;) {
    var_00 = scripts\sp\utility::func_7BD6();
    if(!isDefined(var_00)) {
      level.player waittill("primary_equipment_change");
      continue;
    }

    var_01 = scripts\sp\utility::func_7BD7();
    if(var_01 != 0) {
      level.player scripts\engine\utility::waittill_any_3("primary_equipment_change", "offhand_fired");
      continue;
    }

    scripts\sp\utility::func_13656();
    if(!isDefined(scripts\sp\utility::func_7BD6()) || var_00 != scripts\sp\utility::func_7BD6()) {
      continue;
    }

    if(scripts\sp\utility::func_7BD7() > 0) {
      continue;
    }

    if(scripts\engine\utility::flag("primary_equipment_in_use")) {
      scripts\engine\utility::flag_waitopen("primary_equipment_in_use");
    }

    if(var_00 != scripts\sp\utility::func_7BD6()) {
      continue;
    }

    if(isDefined(scripts\sp\utility::func_7CAF()) && scripts\sp\utility::func_7CB0() > 0) {
      func_1418();
    }
  }
}

func_F0B5() {
  self endon("death");
  self endon("disable_equipment_autoswitch");
  while(!isDefined(level.player.var_4B21)) {
    wait(0.05);
  }

  thread func_F0B4();
  for(;;) {
    var_00 = scripts\sp\utility::func_7C3D();
    if(!isDefined(var_00)) {
      level.player waittill("secondary_equipment_change");
      continue;
    }

    var_01 = scripts\sp\utility::func_7C3E();
    var_02 = scripts\engine\utility::waittill_any_return("offhand_fired", "secondary_equipment_change");
    if(var_02 == "secondary_equipment_change") {
      continue;
    }

    if(!isDefined(scripts\sp\utility::func_7C3D()) || var_00 != scripts\sp\utility::func_7C3D()) {
      continue;
    }

    if(var_01 == scripts\sp\utility::func_7C3E()) {
      continue;
    }

    if(scripts\engine\utility::flag("secondary_equipment_in_use")) {
      scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");
    }

    while(level.player isthrowinggrenade()) {
      wait(0.05);
    }

    if(!isDefined(scripts\sp\utility::func_7C3D()) || var_00 != scripts\sp\utility::func_7C3D()) {
      continue;
    }

    if(isDefined(scripts\sp\utility::func_7C3D()) && scripts\sp\utility::func_7C3E() <= 0) {
      if(isDefined(scripts\sp\utility::func_7CB1()) && scripts\sp\utility::func_7CB2() > 0) {
        func_1419();
      }
    }
  }
}

func_F0B4() {
  self endon("death");
  self endon("disable_equipment_autoswitch");
  for(;;) {
    var_00 = scripts\sp\utility::func_7C3D();
    if(!isDefined(var_00)) {
      level.player waittill("secondary_equipment_change");
      continue;
    }

    var_01 = scripts\sp\utility::func_7C3E();
    if(var_01 != 0) {
      level.player scripts\engine\utility::waittill_any_3("secondary_equipment_change", "offhand_fired");
      continue;
    }

    scripts\sp\utility::func_13661();
    if(!isDefined(scripts\sp\utility::func_7C3D()) || var_00 != scripts\sp\utility::func_7C3D()) {
      continue;
    }

    if(scripts\sp\utility::func_7C3E() > 0) {
      continue;
    }

    if(scripts\engine\utility::flag("secondary_equipment_in_use")) {
      scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");
    }

    if(var_00 != scripts\sp\utility::func_7C3D()) {
      continue;
    }

    if(isDefined(scripts\sp\utility::func_7CB1()) && scripts\sp\utility::func_7CB2() > 0) {
      func_1419();
    }
  }
}

func_66A1() {
  level.player notifyonplayercommand("secondary_equipment_switch_input", "+actionslot 3");
  level.player notifyonplayercommand("primary_equipment_switch_input", "+actionslot 4");
  level.player thread func_66A2();
}

func_66A2() {
  self endon("death");
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_return("secondary_equipment_switch_input", "primary_equipment_switch_input");
    if(var_00 == "primary_equipment_switch_input" && level.player.var_110BD != "" && !scripts\sp\utility::func_9C8E() && !scripts\sp\utility::func_9CB6()) {
      func_1418();
      continue;
    }

    if(var_00 == "secondary_equipment_switch_input" && level.player.var_110BA != "" && !scripts\sp\utility::func_9C8E() && !scripts\sp\utility::func_9CB6()) {
      func_1419();
    }
  }
}

func_1418() {
  var_00 = level.player.var_110BD;
  self giveweapon(var_00);
  self setweaponammoclip(var_00, level.player.var_110BE);
  self playSound("plr_switch_equipment");
  level.player notify("primary_equipment_switch");
}

func_1419() {
  var_00 = level.player.var_110BA;
  self giveweapon(var_00);
  self setweaponammoclip(var_00, level.player.var_110BB);
  self playSound("plr_switch_equipment");
  level.player notify("secondary_equipment_switch");
  if(var_00 == "offhandshield" && scripts\sp\utility::func_9CB5()) {
    scripts\engine\utility::allow_offhand_secondary_weapons(0);
    scripts\sp\utility::func_13662();
    scripts\engine\utility::allow_offhand_secondary_weapons(1);
  }
}

func_11429() {
  level.player.var_C399 = undefined;
  level.player.var_C397 = undefined;
  level.player.var_C39A = undefined;
  level.player.var_C398 = undefined;
  level.player.var_C38D = undefined;
  level.player.var_C386 = undefined;
  level.player.var_C38E = undefined;
  level.player.var_C387 = undefined;
  if(isDefined(level.player.var_110BD)) {
    if(!scripts\sp\utility::func_93A6() || !scripts\sp\utility::func_93AC() || level.player.var_110BD != "nanoshot") {
      level.player.var_C399 = level.player.var_110BD;
      level.player.var_C39A = level.player.var_110BE;
      level.player.var_110BD = "";
      level.player.var_110BE = 0;
    }
  }

  if(isDefined(level.player.var_110BA)) {
    if(!scripts\sp\utility::func_93A6() || !scripts\sp\utility::func_93AC() || level.player.var_110BA != "helmet") {
      level.player.var_C397 = level.player.var_110BA;
      level.player.var_C398 = level.player.var_110BB;
      level.player.var_110BA = "";
      level.player.var_110BB = 0;
    }
  }

  var_00 = level.player getweaponslistoffhands();
  var_01 = undefined;
  var_02 = undefined;
  for(var_03 = 0; var_03 < var_00.size; var_03++) {
    if(scripts\sp\utility::func_93A6() && scripts\sp\utility::func_93AC()) {
      if(var_00[var_03] == "nanoshot" || var_00[var_03] == "helmet") {
        continue;
      }
    }

    if(lib_0B29::func_12F5(var_00[var_03])) {
      var_01 = var_00[var_03];
    }

    if(lib_0B29::func_12F1(var_00[var_03])) {
      var_02 = var_00[var_03];
    }
  }

  if(isDefined(var_01)) {
    level.player.var_C38D = var_01;
    level.player.var_C38E = level.player getrunningforwardpainanim(var_01);
    level.player takeweapon(var_01);
  }

  if(isDefined(var_02)) {
    level.player.var_C386 = var_02;
    level.player.var_C387 = level.player getrunningforwardpainanim(var_02);
    level.player takeweapon(var_02);
  }
}

func_E2C0() {
  if(isDefined(level.player.var_C38D) && level.player.var_C38D != "") {
    level.player giveweapon(level.player.var_C38D);
    level.player setweaponammoclip(level.player.var_C38D, level.player.var_C38E);
  }

  if(isDefined(level.player.var_C386) && level.player.var_C386 != "") {
    level.player giveweapon(level.player.var_C386);
    level.player setweaponammoclip(level.player.var_C386, level.player.var_C387);
  }

  if(isDefined(level.player.var_C399) && level.player.var_C399 != "") {
    level.player giveweapon(level.player.var_C399);
    level.player setweaponammoclip(level.player.var_C399, level.player.var_C39A);
  }

  if(isDefined(level.player.var_C397) && level.player.var_C397 != "") {
    level.player giveweapon(level.player.var_C397);
    level.player setweaponammoclip(level.player.var_C397, level.player.var_C398);
  }

  level.player.var_C399 = undefined;
  level.player.var_C397 = undefined;
  level.player.var_C39A = undefined;
  level.player.var_C398 = undefined;
  level.player.var_C38D = undefined;
  level.player.var_C386 = undefined;
  level.player.var_C38E = undefined;
  level.player.var_C387 = undefined;
}