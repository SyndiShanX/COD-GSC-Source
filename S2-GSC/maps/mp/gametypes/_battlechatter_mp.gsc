/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_battlechatter_mp.gsc
***************************************************/

func_00D5() {
  if(maps\mp\_utility::func_571D()) {
    level.var_212F = 1;
    return;
  }

  if(level.var_6520) {
    foreach(var_01 in level.var_985B) {
      level.var_5801[var_01] = 0;
      level.var_90C1[var_01] = [];
    }
  } else {
    level.var_5801["allies"] = 0;
    level.var_5801["axis"] = 0;
    level.var_90C1["allies"] = [];
    level.var_90C1["axis"] = [];
  }

  level.var_46D9 = ::maps\mp\gametypes\_teams::func_46D9;
  if(!isDefined(level.var_1676)) {
    level.var_1676 = [];
  }

  level.var_1676["reload"] = "inform_reloading_generic";
  level.var_1676["frag_out"] = "inform_attack_grenade";
  level.var_1676["semtex_out"] = "semtex_use";
  level.var_1676["conc_out"] = "inform_attack_stun";
  level.var_1676["smoke_out"] = "inform_attack_smoke";
  level.var_1676["emp_out"] = "emp_use";
  level.var_1676["threat_out"] = "threat_use";
  level.var_1676["drone_out"] = "inform_drone_use";
  level.var_1676["betty_out"] = "betty_use";
  level.var_1676["tabun_out"] = "tabun_use";
  level.var_1676["grenade_incoming"] = "grenade_incoming";
  level.var_1676["semtex_incoming"] = "semtex_incoming";
  level.var_1676["stun_incoming"] = "stun_incoming";
  level.var_1676["emp_incoming"] = "incoming_emp";
  level.var_1676["drone_incoming"] = "inform_drone_enemy";
  level.var_1676["conc_incoming"] = "conc_incoming";
  level.var_1676["smoke_incoming"] = "smoke_incoming";
  level.var_1676["tabun_incoming"] = "tabun_incoming";
  level.var_1676["exo_cloak_use"] = "inform_cloaking_use";
  level.var_1676["exo_overclock_use"] = "inform_overclock_use";
  level.var_1676["exo_ping_use"] = "exo_ping";
  level.var_1676["exo_shield_use"] = "exo_shield_use";
  level.var_1676["callout_generic"] = "threat_infantry_generic";
  level.var_1676["callout_sniper"] = "threat_sniper_generic";
  level.var_1676["callout_hover"] = "enemy_hover";
  level.var_1676["callout_shield"] = "exo_shield_enemy";
  level.var_1676["callout_cloak"] = "inform_cloaking_enemy";
  level.var_1676["callout_overclock"] = "inform_overclock_enemy";
  level.var_1676["callout_response_generic"] = "response_ack_yes";
  level.var_1676["kill"] = "inform_killfirm_infantry";
  level.var_1676["casualty"] = "inform_casualty_generic";
  level.var_1676["suppressing_fire"] = "cmd_suppressfire";
  level.var_1676["moving"] = "order_move_combat";
  level.var_1676["damage"] = "inform_taking_fire";
  level.var_1676["melee_exertion"] = "melee_exertion";
  level.var_1676["bayo_charge_intro"] = "bayo_charge_intro";
  level.var_1676["bayo_charge_intro_end"] = "bayo_charge_intro_end";
  level.var_1676["bayo_charge"] = "bayo_charge";
  level.var_1676["bayo_charge_end"] = "bayo_charge_end";
  level.var_1676["bayo_charge_attack"] = "bayo_charge_attack";
  level.var_166D = [];
  level.var_166D["timeout"]["suppressing_fire"] = 5000;
  level.var_166D["timeout"]["moving"] = -20536;
  level.var_166D["timeout"]["callout_generic"] = 15000;
  level.var_166D["timeout"]["callout_location"] = 3000;
  level.var_166D["timeout_player"]["suppressing_fire"] = 10000;
  level.var_166D["timeout_player"]["moving"] = 120000;
  level.var_166D["timeout_player"]["callout_generic"] = 5000;
  level.var_166D["timeout_player"]["callout_location"] = 5000;
  foreach(var_05, var_04 in level.var_90C1) {
    level.var_166D["last_say_time"][var_05]["suppressing_fire"] = -99999;
    level.var_166D["last_say_time"][var_05]["moving"] = -99999;
    level.var_166D["last_say_time"][var_05]["callout_generic"] = -99999;
    level.var_166D["last_say_time"][var_05]["callout_location"] = -99999;
    level.var_166D["last_say_pos"][var_05]["suppressing_fire"] = (0, 0, -9000);
    level.var_166D["last_say_pos"][var_05]["moving"] = (0, 0, -9000);
    level.var_166D["last_say_pos"][var_05]["callout_generic"] = (0, 0, -9000);
    level.var_166D["last_say_pos"][var_05]["callout_location"] = (0, 0, -9000);
    level.var_A601[var_05][""] = 0;
    level.var_A601[var_05]["w"] = 0;
  }

  if(function_0367()) {
    return;
  }

  if(isDefined(level.add_bcs_location_mappings_callback)) {
    level.var_166F = [];
    [[level.add_bcs_location_mappings_callback]]();
    common_scripts\_bcs_location_trigs::func_1674();
    level.var_166F = undefined;
    anim.var_5E5E = [];
  } else {
    common_scripts\_bcs_location_trigs::func_1671();
  }

  var_06 = getDvar("1924");
  level.var_57F5 = 1;
  if(var_06 == "war" || var_06 == "conf" || var_06 == "dom") {
    level.var_57F5 = 0;
  }

  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    common_scripts\utility::func_A70A("spawned_player", "faux_spawn");
    self.var_166D = [];
    self.var_166D["last_say_time"]["suppressing_fire"] = -99999;
    self.var_166D["last_say_time"]["moving"] = -99999;
    self.var_166D["last_say_time"]["callout_generic"] = -99999;
    self.var_166D["last_say_time"]["callout_location"] = -99999;
    var_00 = [[level.var_46D9]](self.var_01A7);
    var_01 = 6;
    var_02 = 3;
    var_03 = "";
    if(!function_01EF(self) && self method_843D()) {
      var_03 = "w";
    }

    self.var_012C["voiceNum"] = level.var_A601[self.var_01A7][var_03];
    if(var_03 == "w") {
      level.var_A601[self.var_01A7][var_03] = level.var_A601[self.var_01A7][var_03] + 1 % var_02;
    } else {
      level.var_A601[self.var_01A7][var_03] = level.var_A601[self.var_01A7][var_03] + 1 % var_01;
    }

    self.var_012C["voicePrefix"] = var_00 + var_03 + self.var_012C["voiceNum"] + "_";
    if(level.var_910F) {
      continue;
    }

    thread func_60E6();
    thread func_1659();
    thread func_1654();
    thread func_1652();
    if(!level.var_984D) {
      continue;
    }

    thread func_7C2A();
    thread func_4872();
    thread func_486A();
    thread func_94F9();
    thread func_2030();
    thread func_29DF();
    thread func_9132();
    thread func_998F();
  }
}

func_486A() {
  self endon("disconnect");
  self endon("death");
  var_00 = self.var_0116;
  var_01 = 147456;
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  for(;;) {
    if(common_scripts\utility::func_24A6()) {
      wait(5);
      continue;
    }

    var_02 = common_scripts\utility::func_98E7(isDefined(level.var_486C), level.var_486C, []);
    var_03 = common_scripts\utility::func_98E7(isDefined(level.var_6248), level.var_6248, []);
    var_04 = common_scripts\utility::func_98E7(isDefined(level.var_9BB5), level.var_9BB5, []);
    if(var_02.size + var_03.size + var_04.size < 1 || !maps\mp\_utility::func_57A0(self)) {
      wait 0.05;
      continue;
    }

    var_02 = common_scripts\utility::func_0F73(var_02, var_03);
    var_02 = common_scripts\utility::func_0F73(var_02, var_04);
    if(var_02.size < 1) {
      wait 0.05;
      continue;
    }

    foreach(var_06 in var_02) {
      wait 0.05;
      if(!isDefined(var_06)) {
        continue;
      }

      var_07 = (isDefined(var_06.var_01B9) && var_06.var_01B9 == "explosive_drone" || var_06.var_01B9 == "tracking_drone") || isDefined(var_06.var_01C8);
      if(isDefined(var_06.var_A9E0)) {
        switch (var_06.var_A9E0) {
          case "gamemode_ball":
            break;
        }

        if(function_01D4(var_06.var_A9E0) != "offhand" && function_01AA(var_06.var_A9E0) == "grenade") {
          continue;
        }
      }

      if(!isDefined(var_06.var_0117) && !var_07) {
        var_06.var_0117 = function_01B3(var_06);
      }

      if(isDefined(var_06.var_0117) && isDefined(var_06.var_0117.var_01A7) && level.var_984D && var_06.var_0117.var_01A7 == self.var_01A7) {
        continue;
      }

      var_08 = distancesquared(var_06.var_0116, self.var_0116);
      if(var_08 < var_01) {
        if(bullettracepassed(var_06.var_0116, self.var_0116, 0, self)) {
          var_09 = "";
          if(var_07) {
            var_09 = "drone_incoming";
          } else if(isDefined(var_06.var_A9E0)) {
            switch (var_06.var_A9E0) {
              case "semtex_mp":
                var_09 = "semtex_incoming";
                break;

              case "stun_grenade_mp":
                var_09 = "stun_incoming";
                break;

              case "emp_grenade_mp":
                var_09 = "emp_incoming";
                break;

              case "concussion_grenade_mp":
                var_09 = "conc_incoming";
                break;

              case "smoke_grenade_axis_expeditionary_mp":
              case "smoke_grenade_expeditionary_mp":
              case "smoke_grenade_axis_mp":
              case "smoke_grenade_mp":
                var_09 = "smoke_incoming";
                break;

              case "tabun_grenade_mp":
                var_09 = "tabun_incoming";
                break;
            }
          }

          if(var_09 == "") {
            var_09 = "grenade_incoming";
          }

          level thread func_8079(self, var_09);
          wait(5);
        }
      }
    }
  }
}

func_94F9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = undefined;
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  for(;;) {
    self waittill("begin_firing");
    thread func_94FD();
    thread func_94FC();
    self notify("stoppedFiring");
  }
}

func_94FC() {
  thread func_A700();
  self endon("begin_firing");
  self waittill("end_firing");
  wait(0.3);
  self notify("stoppedFiring");
}

func_A700() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread func_94FC();
}

func_94FD() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death");
  self endon("disconnect");
  self endon("stoppedFiring");
  wait(1);
  if(func_1F69("suppressing_fire")) {
    level thread func_8079(self, "suppressing_fire");
  }
}

func_7C2A() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  for(;;) {
    self waittill("reload_start");
    level thread func_8079(self, "reload");
  }
}

func_4872() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "frag_grenade_mp" || var_01 == "frag_grenade_german_mp") {
      level thread func_8079(self, "frag_out");
      continue;
    }

    if(var_01 == "semtex_mp") {
      level thread func_8079(self, "semtex_out");
      continue;
    }

    if(var_01 == "concussion_grenade_mp" || var_01 == "stun_grenade_mp") {
      level thread func_8079(self, "conc_out");
      continue;
    }

    if(var_01 == "smoke_grenade_mp" || var_01 == "smoke_grenade_axis_mp" || var_01 == "smoke_grenade_expeditionary_mp" || var_01 == "smoke_grenade_axis_expeditionary_mp") {
      level thread func_8079(self, "smoke_out");
      continue;
    }

    if(var_01 == "bouncingbetty_mp") {
      level thread func_8079(self, "betty_out");
      continue;
    }

    if(var_01 == "tabun_grenade_mp") {
      level thread func_8079(self, "tabun_out");
    }
  }
}

func_9132() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self waittill("sprint_begin");
    if(func_1F69("moving")) {
      level thread func_8079(self, "moving", 0, 0);
    }
  }
}

func_60E6() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self waittill("melee_fired");
    if(self.var_165B) {
      continue;
    }

    level thread func_8079(self, "melee_exertion", 1);
  }
}

func_1659() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = "";
  var_01 = "";
  var_02 = "";
  var_03 = "";
  self.var_0BBA = "_2D";
  var_04 = 3;
  var_05 = 0;
  for(;;) {
    self.var_1656 = 0;
    self waittill("sprint_melee_charge_begin");
    if(!maps\mp\_utility::func_585F()) {
      self method_8626("bayo_submix");
    } else if(isDefined(self.nobayocharge) && self.nobayocharge) {
      continue;
    }

    self.var_1655 = "";
    self.var_1656 = 1;
    if(self.var_01A7 != "spectator") {
      var_06 = self.var_012C["voicePrefix"];
      if(maps\mp\_utility::func_585F()) {
        var_06 = "plr_";
      }

      if(isDefined(var_06)) {
        if(isDefined(level.var_1676["bayo_charge"])) {
          var_02 = var_06 + level.var_1676["bayo_charge"];
          if(maps\mp\_utility::func_0649("specialty_sprintmeleechargelonger")) {
            var_02 = var_02 + "_intro";
          } else if(maps\mp\_utility::func_0649("specialty_sprintmeleecharge")) {
            var_02 = var_02 + "_intro_short";
          }
        }
      }

      if(maps\mp\_utility::func_585F()) {
        var_07 = lib_0378::func_307B(self.var_20D8);
        var_02 = var_02 + "_" + var_07;
      }
    }

    if(function_0344(var_03)) {
      self.var_1657 = lib_0380::func_6844(var_03, undefined, self);
    }

    lib_0380::func_684C(self.var_1657, self, "charge_intro_done");
    thread func_1653();
    self waittill("charge_intro_done");
    self.var_1656 = 0;
    self.var_1655 = "_0";
    for(var_06 = randomint(var_05) + 1; var_06 == var_08; var_06 = randomint(var_05) + 1) {}

    var_08 = var_06;
    self.var_1655 = self.var_1655 + var_06;
    if(self.var_01A7 != "spectator" && self.var_165B) {
      var_06 = self.var_012C["voicePrefix"];
      if(maps\mp\_utility::func_585F()) {
        var_06 = "plr_";
      }

      if(isDefined(var_06)) {
        if(isDefined(level.var_1676["bayo_charge"])) {
          var_00 = var_06 + level.var_1676["bayo_charge"];
          if(!self.var_1656 && !maps\mp\_utility::func_585F()) {
            var_00 = var_00 + self.var_1655;
          }
        }
      }

      if(maps\mp\_utility::func_585F()) {
        var_07 = lib_0378::func_307B(self.var_20D8);
        var_00 = var_00 + "_" + var_07;
      }

      if(function_0344(var_00)) {
        self.var_1658 = lib_0380::func_6844(var_00, undefined, self);
      }
    }
  }
}

func_1653() {
  self endon("disconnect");
  var_00 = common_scripts\utility::func_A715("death", "sprint_melee_charge_end", "sprint_melee_charge_attack");
  if(var_00 == "death" && isDefined(self)) {
    if(self.var_1656) {
      lib_0380::func_6850(self.var_1657, 0.1);
    } else {
      lib_0380::func_6850(self.var_1658, 0.1);
    }

    self method_8627("bayo_submix");
  }
}

func_1654() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  var_00 = "";
  for(;;) {
    self waittill("sprint_melee_charge_end", var_01);
    if(!maps\mp\_utility::func_585F()) {
      self method_8627("bayo_submix");
    }

    if(!self.var_1656) {
      if(self.var_01A7 != "spectator") {
        var_02 = self.var_012C["voicePrefix"];
        if(maps\mp\_utility::func_585F()) {
          var_02 = "plr_";
        }

        if(isDefined(var_02)) {
          if(isDefined(level.var_1676["bayo_charge_end"])) {
            var_00 = var_02 + level.var_1676["bayo_charge_end"];
            if(!maps\mp\_utility::func_585F()) {
              var_00 = var_00 + self.var_1655;
            }
          }
        }
      }

      if(!self.var_1656) {
        lib_0380::func_6850(self.var_1658, 0.1);
      }

      if(maps\mp\_utility::func_585F()) {
        var_03 = lib_0378::func_307B(self.var_20D8);
        var_00 = var_00 + "_" + var_03;
      }

      if(function_0344(var_00)) {
        lib_0380::func_6844(var_00, undefined, self, 0.1);
      }
    }
  }
}

func_1652() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  var_00 = "";
  var_01 = undefined;
  for(;;) {
    self waittill("sprint_melee_charge_attack", var_02);
    if(!maps\mp\_utility::func_585F()) {
      self method_8627("bayo_submix");
    }

    if(self.var_01A7 != "spectator") {
      var_03 = self.var_012C["voicePrefix"];
      if(maps\mp\_utility::func_585F()) {
        var_03 = "plr_";
      }

      if(isDefined(var_03)) {
        if(isDefined(level.var_1676["bayo_charge_end"])) {
          var_00 = var_03 + level.var_1676["bayo_charge_attack"];
        }
      }

      if(!self.var_1656) {
        lib_0380::func_6850(self.var_1658, 0.1);
      } else {
        lib_0380::func_6850(self.var_1657, 0.1);
      }

      if(maps\mp\_utility::func_585F()) {
        var_04 = lib_0378::func_307B(self.var_20D8);
        var_00 = var_00 + "_" + var_04;
      }

      if(function_0344(var_00)) {
        lib_0380::func_6844(var_00, undefined, self, 0.1);
      }
    }
  }
}

func_29DF() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  for(;;) {
    self waittill("damage", var_00, var_01);
    if(!isDefined(var_01)) {
      continue;
    }

    if(!isDefined(var_01.var_003A)) {
      continue;
    }

    if(var_01 != self && var_01.var_003A != "worldspawn") {
      wait(1.5);
      level thread func_8079(self, "damage");
      wait(3);
    }
  }
}

func_2030() {
  self endon("disconnect");
  self endon("faux_spawn");
  var_00 = self.var_01A7;
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  self waittill("death");
  foreach(var_02 in level.var_6E97) {
    if(!isDefined(var_02)) {
      continue;
    }

    if(var_02 == self) {
      continue;
    }

    if(!maps\mp\_utility::func_57A0(var_02)) {
      continue;
    }

    if(var_02.var_01A7 != var_00) {
      continue;
    }

    if(isDefined(self) && distancesquared(self.var_0116, var_02.var_0116) <= 262144) {
      level thread func_807A(var_02, "casualty", 0.75);
      break;
    }
  }
}

func_998F() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  for(;;) {
    self waittill("enemy_sighted");
    if(getdvarint("ui_inprematch")) {
      level waittill("prematch_over");
      continue;
    }

    if(!func_1F69("callout_location") && !func_1F69("callout_generic")) {
      continue;
    }

    var_00 = self method_82F0();
    if(!isDefined(var_00)) {
      continue;
    }

    var_01 = undefined;
    var_02 = 4000000;
    if(self playerads() > 0.7) {
      var_02 = 6250000;
    }

    foreach(var_04 in var_00) {
      if(isDefined(var_04) && maps\mp\_utility::func_57A0(var_04) && !var_04 maps\mp\_utility::func_0649("specialty_coldblooded") && distancesquared(self.var_0116, var_04.var_0116) < var_02) {
        var_05 = var_04 func_4709(self);
        var_01 = var_04;
        if(isDefined(var_05) && func_1F69("callout_location") && func_3EB6(4840000)) {
          if(maps\mp\_utility::func_0649("specialty_silentmovement") || maps\mp\_utility::func_0649("specialty_quieter") || !func_3EB6(262144)) {
            level thread func_8079(self, var_05.var_5E5C[0], 0);
          } else {
            level thread func_8079(self, var_05.var_5E5C[0], 1);
          }

          break;
        }
      }
    }

    if(isDefined(var_01) && func_1F69("callout_generic")) {
      var_07 = var_01 getcurrentprimaryweapon();
      var_08 = isDefined(self.var_3EF6);
      var_09 = function_01AA(var_07) == "sniper";
      if(var_08) {
        level thread func_8079(self, "callout_shield");
      } else if(var_09) {
        level thread func_8079(self, "callout_sniper");
      } else {
        level thread func_8079(self, "callout_generic");
      }
    }
  }
}

func_807A(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("death");
  param_00 endon("disconnect");
  wait(param_02);
  func_8079(param_00, param_01, param_03, param_04);
}

func_8079(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  param_00 endon("disconnect");
  if(isDefined(level.var_212F) && level.var_212F) {
    return;
  }

  if(isDefined(param_00.var_166B) && param_00.var_166B == 1) {
    return;
  }

  if(func_57DD(param_00)) {
    return;
  }

  if(param_00.var_01A7 != "spectator") {
    var_04 = param_00.var_012C["voicePrefix"];
    if(isDefined(var_04)) {
      if(isDefined(level.var_1676[param_01])) {
        var_05 = var_04 + level.var_1676[param_01];
        switch (param_01) {
          case "callout_overclock":
          case "callout_cloak":
          case "callout_shield":
          case "callout_hover":
          case "callout_sniper":
            param_01 = "callout_generic";
            break;

          case "bayo_charge":
            break;
        }
      } else {
        func_5E56(param_02);
        var_05 = var_05 + "co_loc_" + param_02;
        param_00 thread func_32B5(var_05, param_01);
        param_01 = "callout_location";
      }

      param_00 func_A0F4(param_01);
      param_00 thread func_32AB(var_05, param_01, param_02, param_03);
    }
  }
}

func_32AB(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = self.var_012C["team"];
  level func_09ED(self, var_04);
  if(!function_0344(param_00)) {
    level func_7CFB(self, var_04);
    return;
  }

  switch (param_01) {
    case "bayo_charge_attack":
    case "bayo_charge_end":
    case "bayo_charge":
    case "bayo_charge_intro_end":
    case "bayo_charge_intro":
    case "melee_exertion":
      var_06 = 1;
      break;

    case "moving":
    case "suppressing_fire":
    case "casualty":
    case "callout_overclock":
    case "callout_cloak":
    case "callout_shield":
    case "callout_hover":
    case "callout_sniper":
    case "callout_generic":
    case "tabun_incoming":
    case "smoke_incoming":
    case "conc_incoming":
    case "emp_incoming":
    case "stun_incoming":
    case "semtex_incoming":
    case "grenade_incoming":
    case "tabun_out":
    case "betty_out":
    case "smoke_out":
    case "conc_out":
    case "semtex_out":
    case "frag_out":
    case "reload":
    case "damage":
    default:
      var_06 = 0;
      break;
  }

  var_07 = [];
  var_08 = 1;
  var_04 = "all";
  if((!isDefined(param_02) || param_02 == 0) && isPlayer(self)) {
    var_08 = 0;
  }

  if(!var_06) {
    var_04 = self.var_01A7;
  }

  var_09 = self playvo(param_00, var_04, var_08);
  if(isDefined(var_09)) {
    var_0A = lookupsoundlength(param_00);
    if(isDefined(var_0A)) {
      wait(var_0A);
    }
  }

  if(isDefined(self)) {
    level func_7CFB(self, self.var_01A7);
  }
}

func_32B5(param_00, param_01) {
  var_02 = common_scripts\utility::func_A715(param_00, "death", "disconnect");
  if(var_02 == param_00) {
    var_03 = self.var_01A7;
    if(!function_01EF(self)) {
      var_04 = self method_843D();
    } else {
      var_04 = 0;
    }

    var_05 = self.var_012C["voiceNum"];
    var_06 = self.var_0116;
    wait(0.5);
    foreach(var_08 in level.var_6E97) {
      if(!isDefined(var_08)) {
        continue;
      }

      if(var_08 == self) {
        continue;
      }

      if(!maps\mp\_utility::func_57A0(var_08)) {
        continue;
      }

      if(var_08.var_01A7 != var_03) {
        continue;
      }

      if(!function_01EF(var_08)) {
        var_09 = var_08 method_843D();
      } else {
        var_09 = 0;
      }

      if((var_05 != var_08.var_012C["voiceNum"] || var_04 != var_09) && distancesquared(var_06, var_08.var_0116) <= 262144 && !func_57DD(var_08)) {
        var_0A = var_08.var_012C["voicePrefix"];
        var_0B = var_0A + "co_loc_" + param_01 + "_echo";
        if(common_scripts\utility::func_24A6() && function_0344(var_0B)) {
          var_0C = var_0B;
        } else {
          var_0C = var_0B + level.var_1676["callout_response_generic"];
        }

        var_08 thread func_32AB(var_0C, param_01, 0, 0);
        break;
      }
    }
  }
}

func_99EF(param_00) {
  self endon("death");
  self endon("disconnect");
  wait(2);
  self notify(param_00);
}

func_57DD(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!isDefined(param_01)) {
    param_01 = 1000;
  }

  var_02 = param_01 * param_01;
  if(isDefined(param_00) && isDefined(param_00.var_01A7) && param_00.var_01A7 != "spectator") {
    for(var_03 = 0; var_03 < level.var_90C1[param_00.var_01A7].size; var_03++) {
      var_04 = level.var_90C1[param_00.var_01A7][var_03];
      if(var_04 == param_00) {
        return 1;
      }

      if(!isDefined(var_04)) {
        continue;
      }

      if(distancesquared(var_04.var_0116, param_00.var_0116) < var_02) {
        return 1;
      }
    }
  }

  return 0;
}

func_09ED(param_00, param_01) {
  level.var_90C1[param_01][level.var_90C1[param_01].size] = param_00;
}

func_7CFB(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < level.var_90C1[param_01].size; var_03++) {
    if(level.var_90C1[param_01][var_03] == param_00) {
      continue;
    }

    var_02[var_02.size] = level.var_90C1[param_01][var_03];
  }

  level.var_90C1[param_01] = var_02;
}

func_2F72(param_00) {
  param_00.var_166B = 1;
}

func_3654(param_00) {
  param_00.var_166B = undefined;
}

func_1F69(param_00) {
  var_01 = self.var_012C["team"];
  if(var_01 == "spectator") {
    return 0;
  }

  var_02 = level.var_166D["timeout_player"][param_00];
  var_03 = gettime() - self.var_166D["last_say_time"][param_00];
  if(var_02 > var_03) {
    return 0;
  }

  var_02 = level.var_166D["timeout"][param_00];
  var_03 = gettime() - level.var_166D["last_say_time"][var_01][param_00];
  if(var_02 < var_03) {
    return 1;
  }

  return 0;
}

func_A0F4(param_00) {
  var_01 = self.var_012C["team"];
  self.var_166D["last_say_time"][param_00] = gettime();
  level.var_166D["last_say_time"][var_01][param_00] = gettime();
  level.var_166D["last_say_pos"][var_01][param_00] = self.var_0116;
}

func_4561() {
  var_00 = func_4087();
  var_00 = common_scripts\utility::func_0F92(var_00);
  if(var_00.size) {
    foreach(var_02 in var_00) {
      if(!func_5E57(var_02)) {
        return var_02;
      }
    }

    foreach(var_02 in var_00) {
      if(!func_5E58(var_02)) {
        return var_02;
      }
    }
  }

  return undefined;
}

func_4709(param_00) {
  var_01 = func_4087();
  var_01 = common_scripts\utility::func_0F92(var_01);
  if(var_01.size) {
    foreach(var_03 in var_01) {
      if(!func_5E57(var_03) && param_00 func_1F33(var_03)) {
        return var_03;
      }
    }

    foreach(var_03 in var_01) {
      if(!func_5E58(var_03) && param_00 func_1F33(var_03)) {
        return var_03;
      }
    }
  }

  return undefined;
}

func_4087() {
  var_00 = level.var_1672;
  var_01 = self getistouchingentities(var_00);
  var_02 = [];
  foreach(var_04 in var_01) {
    if(isDefined(var_04.var_5E5C)) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

func_A097() {
  if(isDefined(level.var_1672)) {
    anim.var_1672 = common_scripts\utility::func_0FA0(level.var_1672);
  }
}

func_559C() {
  var_00 = func_4087();
  foreach(var_02 in var_00) {
    if(!func_5E58(var_02)) {
      return 1;
    }
  }

  return 0;
}

func_5E57(param_00) {
  var_01 = func_5E5A(param_00.var_5E5C[0]);
  if(!isDefined(var_01)) {
    return 0;
  }

  return 1;
}

func_5E58(param_00) {
  var_01 = func_5E5A(param_00.var_5E5C[0]);
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = var_01 + 25000;
  if(gettime() < var_02) {
    return 1;
  }

  return 0;
}

func_5E56(param_00) {
  level.var_5E5E[param_00] = gettime();
}

func_5E5A(param_00) {
  if(isDefined(level.var_5E5E[param_00])) {
    return level.var_5E5E[param_00];
  }

  return undefined;
}

func_1F33(param_00) {
  foreach(var_02 in param_00.var_5E5C) {
    var_03 = func_4563("co_loc_" + var_02);
    var_04 = func_463B(var_02, 0);
    var_05 = func_4563("concat_loc_" + var_02);
    var_06 = function_0344(var_03) || function_0344(var_04) || function_0344(var_05);
    if(var_06) {
      return var_06;
    }
  }

  return 0;
}

func_1F48(param_00) {
  var_01 = param_00.var_5E5C;
  foreach(var_03 in var_01) {
    if(func_569C(var_03, self)) {
      return 1;
    }
  }

  return 0;
}

func_4449(param_00) {
  var_01 = undefined;
  var_02 = self.var_5E5C;
  foreach(var_04 in var_02) {
    if(func_569D(var_04, param_00) && !isDefined(self.var_77F0)) {
      var_01 = var_04;
      break;
    }

    if(func_569E(var_04)) {
      var_01 = var_04;
    }
  }

  return var_01;
}

func_569E(param_00) {
  return issubstr(param_00, "_report");
}

func_569C(param_00, param_01) {
  var_02 = param_01 func_4563("concat_loc_" + param_00);
  if(function_0344(var_02)) {
    return 1;
  }

  return 0;
}

func_569D(param_00, param_01) {
  if(issubstr(param_00, "_qa") && function_0344(param_00)) {
    return 1;
  }

  var_02 = param_01 func_463B(param_00, 0);
  if(function_0344(var_02)) {
    return 1;
  }

  return 0;
}

func_4563(param_00) {
  var_01 = self.var_012C["voicePrefix"] + param_00;
  return var_01;
}

func_463B(param_00, param_01) {
  var_02 = func_4563(param_00);
  var_02 = var_02 + "_qa" + param_01;
  return var_02;
}

func_163A() {
  return 0;
}

func_163B() {
  return 0;
}

func_163F(param_00) {}

func_1640(param_00) {}

func_163C(param_00) {}

func_440A(param_00) {}

func_1641(param_00, param_01, param_02) {}

func_3EB6(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 262144;
  }

  foreach(var_02 in level.var_744A) {
    if(isDefined(var_02) && isDefined(var_02.var_01A7) && isDefined(self.var_012C["team"]) && var_02.var_01A7 == self.var_012C["team"]) {
      if(var_02 != self && distancesquared(var_02.var_0116, self.var_0116) <= param_00) {
        return 1;
      }
    }
  }

  return 0;
}