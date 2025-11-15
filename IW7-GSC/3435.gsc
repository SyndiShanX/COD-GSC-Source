/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3435.gsc
************************/

applyarchetype() {
  equipextras();
}

func_97D0() {}

removearchetype() {
  self setclientomnvar("ui_dodge_charges", 0);
  self notify("removeArchetype");
}

equipextras() {}

func_F6E6(param_00) {
  thread func_13A1A(param_00);
}

func_13A1A(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  for(;;) {
    self waittill("got_a_kill", var_01, var_02, var_03);
    if(param_00 == "equipment" && !scripts\engine\utility::isbulletdamage(var_03)) {
      continue;
    } else {
      createentityeventdata(self, var_01, param_00);
    }
  }
}

createentityeventdata(param_00, param_01, param_02) {
  var_03 = 20;
  var_04 = 20;
  var_05 = spawn("script_model", param_01.origin + (0, 0, 10));
  var_06 = func_7E95(param_02);
  var_05 _meth_8594();
  var_05 setModel(var_06);
  var_05.triggerportableradarping = param_00;
  var_05.team = param_00.team;
  var_05.type = param_02;
  var_05 hidefromplayer(param_00);
  var_07 = spawn("trigger_radius", param_01.origin, 0, var_03, var_04);
  var_07 thread func_13A1C(var_05);
  var_07 thread func_13A19(var_05);
  if(param_02 != "equipment" && param_02 != "super") {
    var_05 thread func_90DE();
    var_05 rotateyaw(1000, 30, 0.2, 0.2);
  } else {
    var_05 thread func_11A17(var_07);
  }

  var_05 thread func_13A1B(30, var_07);
  if(var_05.type == "equipment") {
    var_05 func_F6E8(param_00);
    foreach(var_09 in level.players) {
      if(var_09 != param_00) {
        var_05 hidefromplayer(var_09);
      }
    }

    return;
  }

  foreach(var_09 in level.players) {
    if(!level.teambased) {
      if(var_09 == param_00) {
        var_05 func_F6E8(var_09);
      } else {
        var_05 hidefromplayer(var_09);
      }

      continue;
    }

    if(var_09.team != param_00.team) {
      var_05 hidefromplayer(var_09);
      continue;
    }

    var_05 func_F6E8(var_09);
  }
}

func_7E95(param_00) {
  switch (param_00) {
    case "battery":
      var_01 = "mp_battery_drop";
      break;

    case "scorestreak":
      var_01 = "mp_battery_drop";
      break;

    case "super":
      var_01 = "mp_battery_drop";
      break;

    case "equipment":
      var_01 = "equipment_resupply_bag";
      break;

    default:
      var_01 = "mp_battery_drop";
      break;
  }

  return var_01;
}

func_13A18(param_00) {
  self endon("death");
  self endon("disconnect");
  wait(param_00);
}

func_F6E8(param_00) {
  self showtoplayer(param_00);
}

func_F6E7(param_00) {
  param_00 endon("death");
  self endon("death");
  var_01 = scripts\mp\utility::outlineenableforplayer(self, "cyan", param_00, 1, 0, "equipment");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(30);
  scripts\mp\utility::outlinedisable(var_01, self);
}

func_90DE() {
  self endon("death");
  var_00 = self.origin;
  for(;;) {
    self moveto(var_00 + (0, 0, 15), 1, 0.2, 0.2);
    wait(1);
    self moveto(var_00, 1, 0.2, 0.2);
    wait(1);
  }
}

func_11A17(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(self.origin, 32);
  self.origin = var_01;
  if(isDefined(param_00)) {
    param_00.origin = var_01;
  }
}

func_13A1C(param_00) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      continue;
    }

    if(level.teambased) {
      if(var_01.team != param_00.team) {
        continue;
      }
    } else if(var_01 != param_00.triggerportableradarping) {
      continue;
    }

    if(param_00.type == "equipment" && var_01 != param_00.triggerportableradarping) {
      continue;
    }

    if(param_00.type == "super" && var_01 scripts\mp\supers::issuperready() || var_01 scripts\mp\supers::issuperinuse()) {
      continue;
    }

    if(param_00.type == "equipment" && var_01.powers.size == 0) {
      continue;
    }

    var_01 setvehiclelookattext(param_00);
    var_01 playlocalsound("scavenger_pack_pickup");
    if(var_01 scripts\mp\utility::_hasperk("specialty_superpack")) {
      var_01 scripts\mp\missions::func_D991("ch_trait_super_pack");
    }

    param_00 delete();
  }
}

setvehiclelookattext(param_00) {
  if(param_00.type == "battery") {
    thread scripts\mp\rank::scoreeventpopup("battery_pack");
    scripts\mp\equipment\battery::func_E83B(param_00.triggerportableradarping);
    return;
  }

  if(param_00.type == "scorestreak") {
    thread scripts\mp\rank::scoreeventpopup("scorestreak_pack");
    var_01 = scripts\mp\rank::getscoreinfovalue("scorestreak_pack");
    thread scripts\mp\rank::scorepointspopup(var_01);
    scripts\mp\killstreaks\_killstreaks::_meth_83A7("scorestreak_pack", var_01);
    return;
  }

  if(param_00.type == "super") {
    thread scripts\mp\rank::scoreeventpopup("super_pack");
    scripts\mp\supers::stopshellshock(125);
    return;
  }

  if(param_00.type == "equipment") {
    scripts\mp\weapons::func_EBD3(self);
    scripts\mp\hud_message::showmiscmessage("scavenger_eqp");
    return;
  }
}

func_9DDC(param_00) {
  switch (param_00) {
    case "super_pack":
    case "scorestreak_pack":
    case "battery_pack":
      return 1;

    default:
      return 0;
  }
}

func_13A19(param_00) {
  self endon("death");
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_13A1B(param_00, param_01) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  param_01 delete();
  self delete();
}