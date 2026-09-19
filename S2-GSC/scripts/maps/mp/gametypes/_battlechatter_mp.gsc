/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_battlechatter_mp.gsc
***********************************************************/

init() {
  if(maps\mp\_utility::_id_571D()) {
    level._id_212F = 1;
    return;
  }

  if(level._id_6520) {
    foreach(var_1 in level._id_985B) {
      level._id_5801[var_1] = 0;
      level._id_90C1[var_1] = [];
    }
  } else {
    level._id_5801["allies"] = 0;
    level._id_5801["axis"] = 0;
    level._id_90C1["allies"] = [];
    level._id_90C1["axis"] = [];
  }

  level._id_46D9 = _id_0510::_id_46D9;

  if(!isDefined(level._id_1676))
    level._id_1676 = [];

  level._id_1676["reload"] = "inform_reloading_generic";
  level._id_1676["frag_out"] = "inform_attack_grenade";
  level._id_1676["semtex_out"] = "semtex_use";
  level._id_1676["conc_out"] = "inform_attack_stun";
  level._id_1676["smoke_out"] = "inform_attack_smoke";
  level._id_1676["emp_out"] = "emp_use";
  level._id_1676["threat_out"] = "threat_use";
  level._id_1676["drone_out"] = "inform_drone_use";
  level._id_1676["betty_out"] = "betty_use";
  level._id_1676["tabun_out"] = "tabun_use";
  level._id_1676["grenade_incoming"] = "grenade_incoming";
  level._id_1676["semtex_incoming"] = "semtex_incoming";
  level._id_1676["stun_incoming"] = "stun_incoming";
  level._id_1676["emp_incoming"] = "incoming_emp";
  level._id_1676["drone_incoming"] = "inform_drone_enemy";
  level._id_1676["conc_incoming"] = "conc_incoming";
  level._id_1676["smoke_incoming"] = "smoke_incoming";
  level._id_1676["tabun_incoming"] = "tabun_incoming";
  level._id_1676["exo_cloak_use"] = "inform_cloaking_use";
  level._id_1676["exo_overclock_use"] = "inform_overclock_use";
  level._id_1676["exo_ping_use"] = "exo_ping";
  level._id_1676["exo_shield_use"] = "exo_shield_use";
  level._id_1676["callout_generic"] = "threat_infantry_generic";
  level._id_1676["callout_sniper"] = "threat_sniper_generic";
  level._id_1676["callout_hover"] = "enemy_hover";
  level._id_1676["callout_shield"] = "exo_shield_enemy";
  level._id_1676["callout_cloak"] = "inform_cloaking_enemy";
  level._id_1676["callout_overclock"] = "inform_overclock_enemy";
  level._id_1676["callout_response_generic"] = "response_ack_yes";
  level._id_1676["kill"] = "inform_killfirm_infantry";
  level._id_1676["casualty"] = "inform_casualty_generic";
  level._id_1676["suppressing_fire"] = "cmd_suppressfire";
  level._id_1676["moving"] = "order_move_combat";
  level._id_1676["damage"] = "inform_taking_fire";
  level._id_1676["melee_exertion"] = "melee_exertion";
  level._id_1676["bayo_charge_intro"] = "bayo_charge_intro";
  level._id_1676["bayo_charge_intro_end"] = "bayo_charge_intro_end";
  level._id_1676["bayo_charge"] = "bayo_charge";
  level._id_1676["bayo_charge_end"] = "bayo_charge_end";
  level._id_1676["bayo_charge_attack"] = "bayo_charge_attack";
  level._id_166D = [];
  level._id_166D["timeout"]["suppressing_fire"] = 5000;
  level._id_166D["timeout"]["moving"] = 45000;
  level._id_166D["timeout"]["callout_generic"] = 15000;
  level._id_166D["timeout"]["callout_location"] = 3000;
  level._id_166D["timeout_player"]["suppressing_fire"] = 10000;
  level._id_166D["timeout_player"]["moving"] = 120000;
  level._id_166D["timeout_player"]["callout_generic"] = 5000;
  level._id_166D["timeout_player"]["callout_location"] = 5000;

  foreach(var_5, var_4 in level._id_90C1) {
    level._id_166D["last_say_time"][var_5]["suppressing_fire"] = -99999;
    level._id_166D["last_say_time"][var_5]["moving"] = -99999;
    level._id_166D["last_say_time"][var_5]["callout_generic"] = -99999;
    level._id_166D["last_say_time"][var_5]["callout_location"] = -99999;
    level._id_166D["last_say_pos"][var_5]["suppressing_fire"] = (0, 0, -9000);
    level._id_166D["last_say_pos"][var_5]["moving"] = (0, 0, -9000);
    level._id_166D["last_say_pos"][var_5]["callout_generic"] = (0, 0, -9000);
    level._id_166D["last_say_pos"][var_5]["callout_location"] = (0, 0, -9000);
    level._id_A601[var_5][""] = 0;
    level._id_A601[var_5]["w"] = 0;
  }

  if(_func_367()) {
    return;
  }
  if(isDefined(level.add_bcs_location_mappings_callback)) {
    level.bcs_location_mappings = [];
    [[level.add_bcs_location_mappings_callback]]();
    common_scripts\_bcs_location_trigs::bcs_trigs_assign_aliases();
    level.bcs_location_mappings = undefined;
    anim._id_5E5E = [];
  } else
    common_scripts\_bcs_location_trigs::_id_1671();

  var_6 = getDvar("1924");
  level._id_57F5 = 1;

  if(var_6 == "war" || var_6 == "conf" || var_6 == "dom")
    level._id_57F5 = 0;

  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("spawned_player", "faux_spawn");
    self._id_166D = [];
    self._id_166D["last_say_time"]["suppressing_fire"] = -99999;
    self._id_166D["last_say_time"]["moving"] = -99999;
    self._id_166D["last_say_time"]["callout_generic"] = -99999;
    self._id_166D["last_say_time"]["callout_location"] = -99999;
    var_0 = [[level._id_46D9]](self.team);
    var_1 = 6;
    var_2 = 3;
    var_3 = "";

    if(!_isagent(self) && self hasfemalecustomizationmodel())
      var_3 = "w";

    self.pers["voiceNum"] = level._id_A601[self.team][var_3];

    if(var_3 == "w")
      level._id_A601[self.team][var_3] = (level._id_A601[self.team][var_3] + 1) % var_2;
    else
      level._id_A601[self.team][var_3] = (level._id_A601[self.team][var_3] + 1) % var_1;

    self.pers["voicePrefix"] = var_0 + var_3 + self.pers["voiceNum"] + "_";

    if(level.splitscreen) {
      continue;
    }
    thread _id_60E6();
    thread _id_1659();
    thread _id_1654();
    thread _id_1652();

    if(!level.teambased) {
      continue;
    }
    thread _id_7C2A();
    thread _id_4872();
    thread _id_486A();
    thread _id_94F9();
    thread _id_2030();
    thread _id_29DF();
    thread _id_9132();
    thread _id_998F();
  }
}

_id_486A() {
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = 147456;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    if(common_scripts\utility::_id_24A6()) {
      wait 5;
      continue;
    }

    var_2 = common_scripts\utility::_id_98E7(isDefined(level._id_486C), level._id_486C, []);
    var_3 = common_scripts\utility::_id_98E7(isDefined(level._id_6248), level._id_6248, []);
    var_4 = common_scripts\utility::_id_98E7(isDefined(level._id_9BB5), level._id_9BB5, []);

    if(var_2.size + var_3.size + var_4.size < 1 || !maps\mp\_utility::isreallyalive(self)) {
      waitframe();
      continue;
    }

    var_2 = common_scripts\utility::_id_0F73(var_2, var_3);
    var_2 = common_scripts\utility::_id_0F73(var_2, var_4);

    if(var_2.size < 1) {
      waitframe();
      continue;
    }

    foreach(var_6 in var_2) {
      waitframe();

      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = isDefined(var_6.type) && (var_6.type == "explosive_drone" || var_6.type == "tracking_drone") || isDefined(var_6._id_01C8);

      if(isDefined(var_6._id_A9E0)) {
        switch (var_6._id_A9E0) {
          case "gamemode_ball":
            continue;
        }

        if(weaponinventorytype(var_6._id_A9E0) != "offhand" && weaponclass(var_6._id_A9E0) == "grenade")
          continue;
      }

      if(!isDefined(var_6._id_0117) && !var_7)
        var_6._id_0117 = _getmissileowner(var_6);

      if(isDefined(var_6._id_0117) && isDefined(var_6._id_0117.team) && level.teambased && var_6._id_0117.team == self.team) {
        continue;
      }
      var_8 = distancesquared(var_6.origin, self.origin);

      if(var_8 < var_1) {
        if(_bullettracepassed(var_6.origin, self.origin, 0, self)) {
          var_9 = "";

          if(var_7)
            var_9 = "drone_incoming";
          else if(isDefined(var_6._id_A9E0)) {
            switch (var_6._id_A9E0) {
              case "semtex_mp":
                var_9 = "semtex_incoming";
                break;
              case "stun_grenade_mp":
                var_9 = "stun_incoming";
                break;
              case "emp_grenade_mp":
                var_9 = "emp_incoming";
                break;
              case "concussion_grenade_mp":
                var_9 = "conc_incoming";
                break;
              case "smoke_grenade_axis_expeditionary_mp":
              case "smoke_grenade_expeditionary_mp":
              case "smoke_grenade_axis_mp":
              case "smoke_grenade_mp":
                var_9 = "smoke_incoming";
                break;
              case "tabun_grenade_mp":
                var_9 = "tabun_incoming";
            }
          }

          if(var_9 == "")
            var_9 = "grenade_incoming";

          level thread playerlinkweaponviewtodelta(self, var_9);
          wait 5;
        }
      }
    }
  }
}

_id_94F9() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = undefined;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("begin_firing");
    thread _id_94FD();
    thread _id_94FC();
    self notify("stoppedFiring");
  }
}

_id_94FC() {
  thread _id_A700();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

_id_A700() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread _id_94FC();
}

_id_94FD() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death");
  self endon("disconnect");
  self endon("stoppedFiring");
  wait 1;

  if(_id_1F69("suppressing_fire"))
    level thread playerlinkweaponviewtodelta(self, "suppressing_fire");
}

_id_7C2A() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("reload_start");
    level thread playerlinkweaponviewtodelta(self, "reload");
  }
}

_id_4872() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "frag_grenade_mp" || var_1 == "frag_grenade_german_mp") {
      level thread playerlinkweaponviewtodelta(self, "frag_out");
      continue;
    }

    if(var_1 == "semtex_mp") {
      level thread playerlinkweaponviewtodelta(self, "semtex_out");
      continue;
    }

    if(var_1 == "concussion_grenade_mp" || var_1 == "stun_grenade_mp") {
      level thread playerlinkweaponviewtodelta(self, "conc_out");
      continue;
    }

    if(var_1 == "smoke_grenade_mp" || var_1 == "smoke_grenade_axis_mp" || var_1 == "smoke_grenade_expeditionary_mp" || var_1 == "smoke_grenade_axis_expeditionary_mp") {
      level thread playerlinkweaponviewtodelta(self, "smoke_out");
      continue;
    }

    if(var_1 == "bouncingbetty_mp") {
      level thread playerlinkweaponviewtodelta(self, "betty_out");
      continue;
    }

    if(var_1 == "tabun_grenade_mp")
      level thread playerlinkweaponviewtodelta(self, "tabun_out");
  }
}

_id_9132() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");

    if(_id_1F69("moving"))
      level thread playerlinkweaponviewtodelta(self, "moving", 0, 0);
  }
}

_id_60E6() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("melee_fired");

    if(self._id_165B) {
      continue;
    }
    level thread playerlinkweaponviewtodelta(self, "melee_exertion", 1);
  }
}

_id_1659() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = "";
  var_1 = "";
  var_2 = "";
  var_3 = "";
  self._id_0BBA = "_2D";
  var_4 = 3;
  var_5 = 0;

  for(;;) {
    self._id_1656 = 0;
    self waittill("sprint_melee_charge_begin");

    if(!maps\mp\_utility::_id_585F())
      self clientaddsoundsubmix("bayo_submix");
    else if(isDefined(self.nobayocharge) && self.nobayocharge) {
      continue;
    }
    self._id_1655 = "";
    self._id_1656 = 1;

    if(self.team != "spectator") {
      var_6 = self.pers["voicePrefix"];

      if(maps\mp\_utility::_id_585F())
        var_6 = "plr_";

      if(isDefined(var_6)) {
        if(isDefined(level._id_1676["bayo_charge"])) {
          var_2 = var_6 + level._id_1676["bayo_charge"];

          if(maps\mp\_utility::_hasperk("specialty_sprintmeleechargelonger"))
            var_2 = var_2 + "_intro";
          else if(maps\mp\_utility::_hasperk("specialty_sprintmeleecharge"))
            var_2 = var_2 + "_intro_short";
        }
      }

      if(maps\mp\_utility::_id_585F()) {
        var_7 = _id_0378::_id_307B(self._id_20D8);
        var_2 = var_2 + ("_" + var_7);
      }
    }

    if(_soundexists(var_2))
      self._id_1657 = _id_0380::_id_6844(var_2, undefined, self);

    _id_0380::_id_684C(self._id_1657, self, "charge_intro_done");
    thread _id_1653();
    self waittill("charge_intro_done");
    self._id_1656 = 0;
    self._id_1655 = "_0";

    for(var_8 = randomint(var_4) + 1; var_8 == var_5; var_8 = randomint(var_4) + 1) {}

    var_5 = var_8;
    self._id_1655 = self._id_1655 + var_8;

    if(self.team != "spectator" && self._id_165B) {
      var_6 = self.pers["voicePrefix"];

      if(maps\mp\_utility::_id_585F())
        var_6 = "plr_";

      if(isDefined(var_6)) {
        if(isDefined(level._id_1676["bayo_charge"])) {
          var_0 = var_6 + level._id_1676["bayo_charge"];

          if(!self._id_1656 && !maps\mp\_utility::_id_585F())
            var_0 = var_0 + self._id_1655;
        }
      }

      if(maps\mp\_utility::_id_585F()) {
        var_7 = _id_0378::_id_307B(self._id_20D8);
        var_0 = var_0 + ("_" + var_7);
      }

      if(_soundexists(var_0))
        self._id_1658 = _id_0380::_id_6844(var_0, undefined, self);
    }
  }
}

_id_1653() {
  self endon("disconnect");
  var_0 = common_scripts\utility::waittill_any_return("death", "sprint_melee_charge_end", "sprint_melee_charge_attack");

  if(var_0 == "death" && isDefined(self)) {
    if(self._id_1656)
      _id_0380::_id_6850(self._id_1657, 0.1);
    else
      _id_0380::_id_6850(self._id_1658, 0.1);

    self clientclearsoundsubmix("bayo_submix");
  }
}

_id_1654() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  var_0 = "";

  for(;;) {
    self waittill("sprint_melee_charge_end", var_1);

    if(!maps\mp\_utility::_id_585F())
      self clientclearsoundsubmix("bayo_submix");

    if(!self._id_1656) {
      if(self.team != "spectator") {
        var_2 = self.pers["voicePrefix"];

        if(maps\mp\_utility::_id_585F())
          var_2 = "plr_";

        if(isDefined(var_2)) {
          if(isDefined(level._id_1676["bayo_charge_end"])) {
            var_0 = var_2 + level._id_1676["bayo_charge_end"];

            if(!maps\mp\_utility::_id_585F())
              var_0 = var_0 + self._id_1655;
          }
        }
      }

      if(!self._id_1656)
        _id_0380::_id_6850(self._id_1658, 0.1);

      if(maps\mp\_utility::_id_585F()) {
        var_3 = _id_0378::_id_307B(self._id_20D8);
        var_0 = var_0 + ("_" + var_3);
      }

      if(_soundexists(var_0))
        _id_0380::_id_6844(var_0, undefined, self, 0.1);
    }
  }
}

_id_1652() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  var_0 = "";
  var_1 = undefined;

  for(;;) {
    self waittill("sprint_melee_charge_attack", var_2);

    if(!maps\mp\_utility::_id_585F())
      self clientclearsoundsubmix("bayo_submix");

    if(self.team != "spectator") {
      var_3 = self.pers["voicePrefix"];

      if(maps\mp\_utility::_id_585F())
        var_3 = "plr_";

      if(isDefined(var_3)) {
        if(isDefined(level._id_1676["bayo_charge_end"]))
          var_0 = var_3 + level._id_1676["bayo_charge_attack"];
      }

      if(!self._id_1656)
        _id_0380::_id_6850(self._id_1658, 0.1);
      else
        _id_0380::_id_6850(self._id_1657, 0.1);

      if(maps\mp\_utility::_id_585F()) {
        var_4 = _id_0378::_id_307B(self._id_20D8);
        var_0 = var_0 + ("_" + var_4);
      }

      if(_soundexists(var_0))
        _id_0380::_id_6844(var_0, undefined, self, 0.1);
    }
  }
}

_id_29DF() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.classname)) {
      continue;
    }
    if(var_1 != self && var_1.classname != "worldspawn") {
      wait 1.5;
      level thread playerlinkweaponviewtodelta(self, "damage");
      wait 3;
    }
  }
}

_id_2030() {
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.team;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  self waittill("death");

  foreach(var_2 in level._id_6E97) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 == self) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_2)) {
      continue;
    }
    if(var_2.team != var_0) {
      continue;
    }
    if(isDefined(self) && distancesquared(self.origin, var_2.origin) <= 262144) {
      level thread playerlinktoabsolute(var_2, "casualty", 0.75);
      break;
    }
  }
}

_id_998F() {
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

    if(!_id_1F69("callout_location") && !_id_1F69("callout_generic")) {
      continue;
    }
    var_0 = self getsightedplayers();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = undefined;
    var_2 = 4000000;

    if(self playerads() > 0.7)
      var_2 = 6250000;

    foreach(var_4 in var_0) {
      if(isDefined(var_4) && maps\mp\_utility::isreallyalive(var_4) && !var_4 maps\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var_4.origin) < var_2) {
        var_5 = var_4 _id_4709(self);
        var_1 = var_4;

        if(isDefined(var_5) && _id_1F69("callout_location") && _id_3EB6(4840000)) {
          if(maps\mp\_utility::_hasperk("specialty_silentmovement") || maps\mp\_utility::_hasperk("specialty_quieter") || !_id_3EB6(262144))
            level thread playerlinkweaponviewtodelta(self, var_5._id_5E5C[0], 0);
          else
            level thread playerlinkweaponviewtodelta(self, var_5._id_5E5C[0], 1);

          break;
        }
      }
    }

    if(isDefined(var_1) && _id_1F69("callout_generic")) {
      var_7 = var_1 getcurrentprimaryweapon();
      var_8 = isDefined(self._id_3EF6);
      var_9 = weaponclass(var_7) == "sniper";

      if(var_8)
        level thread playerlinkweaponviewtodelta(self, "callout_shield");
      else if(var_9)
        level thread playerlinkweaponviewtodelta(self, "callout_sniper");
      else
        level thread playerlinkweaponviewtodelta(self, "callout_generic");
    }
  }
}

playerlinktoabsolute(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("disconnect");
  wait(var_2);
  playerlinkweaponviewtodelta(var_0, var_1, var_3, var_4);
}

playerlinkweaponviewtodelta(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(isDefined(level._id_212F) && level._id_212F) {
    return;
  }
  if(isDefined(var_0._id_166B) && var_0._id_166B == 1) {
    return;
  }
  if(_id_57DD(var_0)) {
    return;
  }
  if(var_0.team != "spectator") {
    var_4 = var_0.pers["voicePrefix"];

    if(isDefined(var_4)) {
      if(isDefined(level._id_1676[var_1])) {
        var_5 = var_4 + level._id_1676[var_1];

        switch (var_1) {
          case "callout_overclock":
          case "callout_cloak":
          case "callout_shield":
          case "callout_hover":
          case "callout_sniper":
            var_1 = "callout_generic";
            break;
          case "bayo_charge":
        }
      } else {
        _id_5E56(var_1);
        var_5 = var_4 + "co_loc_" + var_1;
        var_0 thread _id_32B5(var_5, var_1);
        var_1 = "callout_location";
      }

      var_0 _id_A0F4(var_1);
      var_0 thread _id_32AB(var_5, var_1, var_2, var_3);
    }
  }
}

_id_32AB(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = self.pers["team"];
  level _id_09ED(self, var_4);

  if(!_soundexists(var_0)) {
    level _id_7CFB(self, var_4);
    return;
  }

  switch (var_1) {
    case "bayo_charge_attack":
    case "bayo_charge_end":
    case "bayo_charge":
    case "bayo_charge_intro_end":
    case "bayo_charge_intro":
    case "melee_exertion":
      var_6 = 1;
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
      var_6 = 0;
      break;
  }

  var_7 = [];
  var_8 = 1;
  var_4 = "all";

  if((!isDefined(var_2) || var_2 == 0) && isPlayer(self))
    var_8 = 0;

  if(!var_6)
    var_4 = self.team;

  var_9 = self _meth_861E(var_0, var_4, var_8);

  if(isDefined(var_9)) {
    var_10 = _lookupsoundlength(var_0);

    if(isDefined(var_10))
      wait(var_10);
  }

  if(isDefined(self))
    level _id_7CFB(self, self.team);
}

_id_32B5(var_0, var_1) {
  var_2 = common_scripts\utility::waittill_any_return(var_0, "death", "disconnect");

  if(var_2 == var_0) {
    var_3 = self.team;

    if(!_isagent(self))
      var_4 = self hasfemalecustomizationmodel();
    else
      var_4 = 0;

    var_5 = self.pers["voiceNum"];
    var_6 = self.origin;
    wait 0.5;

    foreach(var_8 in level._id_6E97) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8 == self) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_8)) {
        continue;
      }
      if(var_8.team != var_3) {
        continue;
      }
      if(!_isagent(var_8))
        var_9 = var_8 hasfemalecustomizationmodel();
      else
        var_9 = 0;

      if((var_5 != var_8.pers["voiceNum"] || var_4 != var_9) && distancesquared(var_6, var_8.origin) <= 262144 && !_id_57DD(var_8)) {
        var_10 = var_8.pers["voicePrefix"];
        var_11 = var_10 + "co_loc_" + var_1 + "_echo";

        if(common_scripts\utility::_id_24A6() && _soundexists(var_11))
          var_12 = var_11;
        else
          var_12 = var_10 + level._id_1676["callout_response_generic"];

        var_8 thread _id_32AB(var_12, var_1, 0, 0);
        break;
      }
    }
  }
}

_id_99EF(var_0) {
  self endon("death");
  self endon("disconnect");
  wait 2.0;
  self notify(var_0);
}

_id_57DD(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_1))
    var_1 = 1000;

  var_2 = var_1 * var_1;

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_3 = 0; var_3 < level._id_90C1[var_0.team].size; var_3++) {
      var_4 = level._id_90C1[var_0.team][var_3];

      if(var_4 == var_0)
        return 1;

      if(!isDefined(var_4)) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0.origin) < var_2)
        return 1;
    }
  }

  return 0;
}

_id_09ED(var_0, var_1) {
  level._id_90C1[var_1][level._id_90C1[var_1].size] = var_0;
}

_id_7CFB(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_90C1[var_1].size; var_3++) {
    if(level._id_90C1[var_1][var_3] == var_0) {
      continue;
    }
    var_2[var_2.size] = level._id_90C1[var_1][var_3];
  }

  level._id_90C1[var_1] = var_2;
}

_id_2F72(var_0) {
  var_0._id_166B = 1;
}

_id_3654(var_0) {
  var_0._id_166B = undefined;
}

_id_1F69(var_0) {
  var_1 = self.pers["team"];

  if(var_1 == "spectator")
    return 0;

  var_2 = level._id_166D["timeout_player"][var_0];
  var_3 = gettime() - self._id_166D["last_say_time"][var_0];

  if(var_2 > var_3)
    return 0;

  var_2 = level._id_166D["timeout"][var_0];
  var_3 = gettime() - level._id_166D["last_say_time"][var_1][var_0];

  if(var_2 < var_3)
    return 1;

  return 0;
}

_id_A0F4(var_0) {
  var_1 = self.pers["team"];
  self._id_166D["last_say_time"][var_0] = gettime();
  level._id_166D["last_say_time"][var_1][var_0] = gettime();
  level._id_166D["last_say_pos"][var_1][var_0] = self.origin;
}

_id_4561() {
  var_0 = _id_4087();
  var_0 = common_scripts\utility::array_randomize(var_0);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!_id_5E57(var_2))
        return var_2;
    }

    foreach(var_2 in var_0) {
      if(!_id_5E58(var_2))
        return var_2;
    }
  }

  return undefined;
}

_id_4709(var_0) {
  var_1 = _id_4087();
  var_1 = common_scripts\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!_id_5E57(var_3) && var_0 _id_1F33(var_3))
        return var_3;
    }

    foreach(var_3 in var_1) {
      if(!_id_5E58(var_3) && var_0 _id_1F33(var_3))
        return var_3;
    }
  }

  return undefined;
}

_id_4087() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_5E5C))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_A097() {
  if(isDefined(anim.bcs_locations))
    anim.bcs_locations = common_scripts\utility::_id_0FA0(anim.bcs_locations);
}

_id_559C() {
  var_0 = _id_4087();

  foreach(var_2 in var_0) {
    if(!_id_5E58(var_2))
      return 1;
  }

  return 0;
}

_id_5E57(var_0) {
  var_1 = _id_5E5A(var_0._id_5E5C[0]);

  if(!isDefined(var_1))
    return 0;

  return 1;
}

_id_5E58(var_0) {
  var_1 = _id_5E5A(var_0._id_5E5C[0]);

  if(!isDefined(var_1))
    return 0;

  var_2 = var_1 + 25000;

  if(gettime() < var_2)
    return 1;

  return 0;
}

_id_5E56(var_0) {
  anim._id_5E5E[var_0] = gettime();
}

_id_5E5A(var_0) {
  if(isDefined(anim._id_5E5E[var_0]))
    return anim._id_5E5E[var_0];

  return undefined;
}

_id_1F33(var_0) {
  foreach(var_2 in var_0._id_5E5C) {
    var_3 = _id_4563("co_loc_" + var_2);
    var_4 = _id_463B(var_2, 0);
    var_5 = _id_4563("concat_loc_" + var_2);
    var_6 = _soundexists(var_3) || _soundexists(var_4) || _soundexists(var_5);

    if(var_6)
      return var_6;
  }

  return 0;
}

_id_1F48(var_0) {
  var_1 = var_0._id_5E5C;

  foreach(var_3 in var_1) {
    if(_id_569C(var_3, self))
      return 1;
  }

  return 0;
}

_id_4449(var_0) {
  var_1 = undefined;
  var_2 = self._id_5E5C;

  foreach(var_4 in var_2) {
    if(_id_569D(var_4, var_0) && !isDefined(self._id_77F0)) {
      var_1 = var_4;
      break;
    }

    if(_id_569E(var_4))
      var_1 = var_4;
  }

  return var_1;
}

_id_569E(var_0) {
  return issubstr(var_0, "_report");
}

_id_569C(var_0, var_1) {
  var_2 = var_1 _id_4563("concat_loc_" + var_0);

  if(_soundexists(var_2))
    return 1;

  return 0;
}

_id_569D(var_0, var_1) {
  if(issubstr(var_0, "_qa") && _soundexists(var_0))
    return 1;

  var_2 = var_1 _id_463B(var_0, 0);

  if(_soundexists(var_2))
    return 1;

  return 0;
}

_id_4563(var_0) {
  var_1 = self.pers["voicePrefix"] + var_0;
  return var_1;
}

_id_463B(var_0, var_1) {
  var_2 = _id_4563(var_0);
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

_id_163A() {
  return 0;
}

_id_163B() {
  return 0;
}

_id_163F(var_0) {}

_id_1640(var_0) {}

_id_163C(var_0) {}

_id_440A(var_0) {}

_id_1641(var_0, var_1, var_2) {}

_id_3EB6(var_0) {
  if(!isDefined(var_0))
    var_0 = 262144;

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team) && isDefined(self.pers["team"]) && var_2.team == self.pers["team"]) {
      if(var_2 != self && distancesquared(var_2.origin, self.origin) <= var_0)
        return 1;
    }
  }

  return 0;
}