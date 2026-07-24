/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2858.gsc
**************************************/

_id_B9D3() {
  scripts\engine\utility::flag_init("primary_equipment_input_down");
  scripts\engine\utility::flag_init("secondary_equipment_input_down");
  scripts\engine\utility::flag_init("primary_equipment_in_use");
  scripts\engine\utility::flag_init("secondary_equipment_in_use");
  scripts\engine\utility::flag_init("equipment_switching_disabled");
  thread _id_B998();
  thread _id_B9A1();
  thread _id_6697();
  thread _id_61F4();
}

_id_6240(var_0) {
  level.player._id_110C0 = var_0;
}

_id_B998() {
  self endon("death");

  for(;;) {
    self waittill("primary_equipment_change", var_0);

    switch (var_0) {
      case "emp":
        level.player thread _id_0E25::_id_618D();
        break;
      case "seeker":
        thread _id_0E26::_id_F162();
        break;
      default:
        break;
    }
  }
}

_id_B9A1() {
  self endon("death");

  for(;;) {
    self waittill("secondary_equipment_change", var_0);

    switch (var_0) {
      case "offhandshield_up1":
      case "offhandshield":
        thread _id_0E2B::_id_C334();
        break;
      case "hackingdevice":
        thread _id_0E29::_id_8836();
        break;
      case "supportdrone_up2":
      case "supportdrone":
        thread _id_0E2D::_id_112BB();
        break;
      default:
        break;
    }
  }
}

_id_6697() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(self fragButtonPressed() && !var_0) {
      scripts\engine\utility::flag_set("primary_equipment_input_down");
      level.player notify("primary_equipment_pressed");
      var_0 = 1;
    } else if(!self fragButtonPressed() && var_0) {
      scripts\engine\utility::flag_clear("primary_equipment_input_down");
      level.player notify("primary_equipment_released");
      var_0 = 0;
    }

    if(self secondaryoffhandbuttonPressed() && !var_1) {
      scripts\engine\utility::flag_set("secondary_equipment_input_down");
      level.player notify("secondary_equipment_pressed");
      var_1 = 1;
    } else if(!self secondaryoffhandbuttonPressed() && var_1) {
      scripts\engine\utility::flag_clear("secondary_equipment_input_down");
      level.player notify("secondary_equipment_released");
      var_1 = 0;
    }

    wait 0.05;
  }
}

_id_61F4() {
  thread _id_D8CF();
  thread _id_F0B5();
}

_id_5527() {
  level.player notify("disable_equipment_autoswitch");
}

_id_D8CF() {
  self endon("death");
  self endon("disable_equipment_autoswitch");

  while(!isDefined(level.player.curobjid))
    wait 0.05;

  thread _id_D8CE();

  for(;;) {
    var_0 = scripts\sp\utility::_id_7BD6();

    if(!isDefined(var_0)) {
      level.player waittill("primary_equipment_change");
      continue;
    }

    var_1 = scripts\sp\utility::_id_7BD7();
    self waittill("offhand_fired");

    if(!isDefined(scripts\sp\utility::_id_7BD6()) || var_0 != scripts\sp\utility::_id_7BD6()) {
      continue;
    }
    if(var_1 == scripts\sp\utility::_id_7BD7()) {
      continue;
    }
    if(isDefined(scripts\sp\utility::_id_7BD6()) && scripts\sp\utility::_id_7BD7() <= 0) {
      if(isDefined(scripts\sp\utility::_id_7CAF()) && scripts\sp\utility::_id_7CB0() > 0)
        _id_1418();
    }
  }
}

_id_D8CE() {
  self endon("death");
  self endon("disable_equipment_autoswitch");

  for(;;) {
    var_0 = scripts\sp\utility::_id_7BD6();

    if(!isDefined(var_0)) {
      level.player waittill("primary_equipment_change");
      continue;
    }

    var_1 = scripts\sp\utility::_id_7BD7();

    if(var_1 != 0) {
      level.player scripts\engine\utility::waittill_any("primary_equipment_change", "offhand_fired");
      continue;
    }

    scripts\sp\utility::_id_13656();

    if(!isDefined(scripts\sp\utility::_id_7BD6()) || var_0 != scripts\sp\utility::_id_7BD6()) {
      continue;
    }
    if(scripts\sp\utility::_id_7BD7() > 0) {
      continue;
    }
    if(scripts\engine\utility::flag("primary_equipment_in_use"))
      scripts\engine\utility::flag_waitopen("primary_equipment_in_use");

    if(var_0 != scripts\sp\utility::_id_7BD6()) {
      continue;
    }
    if(isDefined(scripts\sp\utility::_id_7CAF()) && scripts\sp\utility::_id_7CB0() > 0)
      _id_1418();
  }
}

_id_F0B5() {
  self endon("death");
  self endon("disable_equipment_autoswitch");

  while(!isDefined(level.player._id_4B21))
    wait 0.05;

  thread _id_F0B4();

  for(;;) {
    var_0 = scripts\sp\utility::_id_7C3D();

    if(!isDefined(var_0)) {
      level.player waittill("secondary_equipment_change");
      continue;
    }

    var_1 = scripts\sp\utility::_id_7C3E();
    var_2 = scripts\engine\utility::waittill_any_return("offhand_fired", "secondary_equipment_change");

    if(var_2 == "secondary_equipment_change") {
      continue;
    }
    if(!isDefined(scripts\sp\utility::_id_7C3D()) || var_0 != scripts\sp\utility::_id_7C3D()) {
      continue;
    }
    if(var_1 == scripts\sp\utility::_id_7C3E()) {
      continue;
    }
    if(scripts\engine\utility::flag("secondary_equipment_in_use"))
      scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");

    while(level.player isthrowinggrenade())
      wait 0.05;

    if(!isDefined(scripts\sp\utility::_id_7C3D()) || var_0 != scripts\sp\utility::_id_7C3D()) {
      continue;
    }
    if(isDefined(scripts\sp\utility::_id_7C3D()) && scripts\sp\utility::_id_7C3E() <= 0) {
      if(isDefined(scripts\sp\utility::_id_7CB1()) && scripts\sp\utility::_id_7CB2() > 0)
        _id_1419();
    }
  }
}

_id_F0B4() {
  self endon("death");
  self endon("disable_equipment_autoswitch");

  for(;;) {
    var_0 = scripts\sp\utility::_id_7C3D();

    if(!isDefined(var_0)) {
      level.player waittill("secondary_equipment_change");
      continue;
    }

    var_1 = scripts\sp\utility::_id_7C3E();

    if(var_1 != 0) {
      level.player scripts\engine\utility::waittill_any("secondary_equipment_change", "offhand_fired");
      continue;
    }

    scripts\sp\utility::_id_13661();

    if(!isDefined(scripts\sp\utility::_id_7C3D()) || var_0 != scripts\sp\utility::_id_7C3D()) {
      continue;
    }
    if(scripts\sp\utility::_id_7C3E() > 0) {
      continue;
    }
    if(scripts\engine\utility::flag("secondary_equipment_in_use"))
      scripts\engine\utility::flag_waitopen("secondary_equipment_in_use");

    if(var_0 != scripts\sp\utility::_id_7C3D()) {
      continue;
    }
    if(isDefined(scripts\sp\utility::_id_7CB1()) && scripts\sp\utility::_id_7CB2() > 0)
      _id_1419();
  }
}

_id_66A1() {
  level.player notifyonplayercommand("secondary_equipment_switch_input", "+actionslot 3");
  level.player notifyonplayercommand("primary_equipment_switch_input", "+actionslot 4");
  level.player thread _id_66A2();
}

_id_66A2() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("secondary_equipment_switch_input", "primary_equipment_switch_input");

    if(var_0 == "primary_equipment_switch_input" && level.player._id_110BD != "" && !scripts\sp\utility::_id_9C8E() && !scripts\sp\utility::_id_9CB6()) {
      _id_1418();
      continue;
    }

    if(var_0 == "secondary_equipment_switch_input" && level.player._id_110BA != "" && !scripts\sp\utility::_id_9C8E() && !scripts\sp\utility::_id_9CB6())
      _id_1419();
  }
}

_id_1418() {
  var_0 = level.player._id_110BD;
  self giveweapon(var_0);
  self setweaponammoclip(var_0, level.player._id_110BE);
  self playSound("plr_switch_equipment");
  level.player notify("primary_equipment_switch");
}

_id_1419() {
  var_0 = level.player._id_110BA;
  self giveweapon(var_0);
  self setweaponammoclip(var_0, level.player._id_110BB);
  self playSound("plr_switch_equipment");
  level.player notify("secondary_equipment_switch");

  if(var_0 == "offhandshield" && scripts\sp\utility::_id_9CB5()) {
    scripts\engine\utility::allow_offhand_secondary_weapons(0);
    scripts\sp\utility::_id_13662();
    scripts\engine\utility::allow_offhand_secondary_weapons(1);
  }
}

_id_11429() {
  level.player._id_C399 = undefined;
  level.player._id_C397 = undefined;
  level.player._id_C39A = undefined;
  level.player._id_C398 = undefined;
  level.player._id_C38D = undefined;
  level.player._id_C386 = undefined;
  level.player._id_C38E = undefined;
  level.player._id_C387 = undefined;

  if(isDefined(level.player._id_110BD)) {
    if(!scripts\sp\utility::_id_93A6() || !scripts\sp\utility::_id_93AC() || level.player._id_110BD != "nanoshot") {
      level.player._id_C399 = level.player._id_110BD;
      level.player._id_C39A = level.player._id_110BE;
      level.player._id_110BD = "";
      level.player._id_110BE = 0;
    }
  }

  if(isDefined(level.player._id_110BA)) {
    if(!scripts\sp\utility::_id_93A6() || !scripts\sp\utility::_id_93AC() || level.player._id_110BA != "helmet") {
      level.player._id_C397 = level.player._id_110BA;
      level.player._id_C398 = level.player._id_110BB;
      level.player._id_110BA = "";
      level.player._id_110BB = 0;
    }
  }

  var_0 = level.player getweaponslistall();
  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(scripts\sp\utility::_id_93A6() && scripts\sp\utility::_id_93AC()) {
      if(var_0[var_3] == "nanoshot" || var_0[var_3] == "helmet")
        continue;
    }

    if(_id_0B29::_id_12F5(var_0[var_3]))
      var_1 = var_0[var_3];

    if(_id_0B29::_id_12F1(var_0[var_3]))
      var_2 = var_0[var_3];
  }

  if(isDefined(var_1)) {
    level.player._id_C38D = var_1;
    level.player._id_C38E = level.player getammocount(var_1);
    level.player takeweapon(var_1);
  }

  if(isDefined(var_2)) {
    level.player._id_C386 = var_2;
    level.player._id_C387 = level.player getammocount(var_2);
    level.player takeweapon(var_2);
  }
}

_id_E2C0() {
  if(isDefined(level.player._id_C38D) && level.player._id_C38D != "") {
    level.player giveweapon(level.player._id_C38D);
    level.player setweaponammoclip(level.player._id_C38D, level.player._id_C38E);
  }

  if(isDefined(level.player._id_C386) && level.player._id_C386 != "") {
    level.player giveweapon(level.player._id_C386);
    level.player setweaponammoclip(level.player._id_C386, level.player._id_C387);
  }

  if(isDefined(level.player._id_C399) && level.player._id_C399 != "") {
    level.player giveweapon(level.player._id_C399);
    level.player setweaponammoclip(level.player._id_C399, level.player._id_C39A);
  }

  if(isDefined(level.player._id_C397) && level.player._id_C397 != "") {
    level.player giveweapon(level.player._id_C397);
    level.player setweaponammoclip(level.player._id_C397, level.player._id_C398);
  }

  level.player._id_C399 = undefined;
  level.player._id_C397 = undefined;
  level.player._id_C39A = undefined;
  level.player._id_C398 = undefined;
  level.player._id_C38D = undefined;
  level.player._id_C386 = undefined;
  level.player._id_C38E = undefined;
  level.player._id_C387 = undefined;
}