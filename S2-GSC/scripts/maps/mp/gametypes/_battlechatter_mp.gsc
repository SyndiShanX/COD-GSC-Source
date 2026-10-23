/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_battlechatter_mp.gsc
***********************************************************/

init() {
  if(maps\mp\_utility::_id_571D()) {
    level.chatterdisabled = 1;
    return;
  }

  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      level.isteamspeaking[var_1] = 0;
      level.speakers[var_1] = [];
    }
  } else {
    level.isteamspeaking["allies"] = 0;
    level.isteamspeaking["axis"] = 0;
    level.speakers["allies"] = [];
    level.speakers["axis"] = [];
  }

  level.getteamvoiceprefix = _id_0510::getteamvoiceprefix;

  if(!isDefined(level.bcsounds)) {
    level.bcsounds = [];
  }

  level.bcsounds["reload"] = "inform_reloading_generic";
  level.bcsounds["frag_out"] = "inform_attack_grenade";
  level.bcsounds["semtex_out"] = "semtex_use";
  level.bcsounds["conc_out"] = "inform_attack_stun";
  level.bcsounds["smoke_out"] = "inform_attack_smoke";
  level.bcsounds["emp_out"] = "emp_use";
  level.bcsounds["threat_out"] = "threat_use";
  level.bcsounds["drone_out"] = "inform_drone_use";
  level.bcsounds["betty_out"] = "betty_use";
  level.bcsounds["tabun_out"] = "tabun_use";
  level.bcsounds["grenade_incoming"] = "grenade_incoming";
  level.bcsounds["semtex_incoming"] = "semtex_incoming";
  level.bcsounds["stun_incoming"] = "stun_incoming";
  level.bcsounds["emp_incoming"] = "incoming_emp";
  level.bcsounds["drone_incoming"] = "inform_drone_enemy";
  level.bcsounds["conc_incoming"] = "conc_incoming";
  level.bcsounds["smoke_incoming"] = "smoke_incoming";
  level.bcsounds["tabun_incoming"] = "tabun_incoming";
  level.bcsounds["exo_cloak_use"] = "inform_cloaking_use";
  level.bcsounds["exo_overclock_use"] = "inform_overclock_use";
  level.bcsounds["exo_ping_use"] = "exo_ping";
  level.bcsounds["exo_shield_use"] = "exo_shield_use";
  level.bcsounds["callout_generic"] = "threat_infantry_generic";
  level.bcsounds["callout_sniper"] = "threat_sniper_generic";
  level.bcsounds["callout_hover"] = "enemy_hover";
  level.bcsounds["callout_shield"] = "exo_shield_enemy";
  level.bcsounds["callout_cloak"] = "inform_cloaking_enemy";
  level.bcsounds["callout_overclock"] = "inform_overclock_enemy";
  level.bcsounds["callout_response_generic"] = "response_ack_yes";
  level.bcsounds["kill"] = "inform_killfirm_infantry";
  level.bcsounds["casualty"] = "inform_casualty_generic";
  level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
  level.bcsounds["moving"] = "order_move_combat";
  level.bcsounds["damage"] = "inform_taking_fire";
  level.bcsounds["melee_exertion"] = "melee_exertion";
  level.bcsounds["bayo_charge_intro"] = "bayo_charge_intro";
  level.bcsounds["bayo_charge_intro_end"] = "bayo_charge_intro_end";
  level.bcsounds["bayo_charge"] = "bayo_charge";
  level.bcsounds["bayo_charge_end"] = "bayo_charge_end";
  level.bcsounds["bayo_charge_attack"] = "bayo_charge_attack";
  level.bcinfo = [];
  level.bcinfo["timeout"]["suppressing_fire"] = 5000;
  level.bcinfo["timeout"]["moving"] = 45000;
  level.bcinfo["timeout"]["callout_generic"] = 15000;
  level.bcinfo["timeout"]["callout_location"] = 3000;
  level.bcinfo["timeout_player"]["suppressing_fire"] = 10000;
  level.bcinfo["timeout_player"]["moving"] = 120000;
  level.bcinfo["timeout_player"]["callout_generic"] = 5000;
  level.bcinfo["timeout_player"]["callout_location"] = 5000;

  foreach(var_5, var_4 in level.speakers) {
    level.bcinfo["last_say_time"][var_5]["suppressing_fire"] = -99999;
    level.bcinfo["last_say_time"][var_5]["moving"] = -99999;
    level.bcinfo["last_say_time"][var_5]["callout_generic"] = -99999;
    level.bcinfo["last_say_time"][var_5]["callout_location"] = -99999;
    level.bcinfo["last_say_pos"][var_5]["suppressing_fire"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["moving"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["callout_generic"] = (0, 0, -9000);
    level.bcinfo["last_say_pos"][var_5]["callout_location"] = (0, 0, -9000);
    level.voice_count[var_5][""] = 0;
    level.voice_count[var_5]["w"] = 0;
  }

  if(_func_367()) {
    return;
  }
  if(isDefined(level.add_bcs_location_mappings_callback)) {
    level.bcs_location_mappings = [];
    [[level.add_bcs_location_mappings_callback]]();
    common_scripts\_bcs_location_trigs::bcs_trigs_assign_aliases();
    level.bcs_location_mappings = undefined;
    anim.locationlastcallouttimes = [];
  } else
    common_scripts\_bcs_location_trigs::bcs_location_trigs_init();

  var_6 = getDvar("1924");
  level.istactical = 1;

  if(var_6 == "war" || var_6 == "conf" || var_6 == "dom") {
    level.istactical = 0;
  }

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
    common_scripts\utility::waittill_any("spawned_player", "faux_spawn");
    self.bcinfo = [];
    self.bcinfo["last_say_time"]["suppressing_fire"] = -99999;
    self.bcinfo["last_say_time"]["moving"] = -99999;
    self.bcinfo["last_say_time"]["callout_generic"] = -99999;
    self.bcinfo["last_say_time"]["callout_location"] = -99999;
    var_0 = [[level.getteamvoiceprefix]](self.team);
    var_1 = 6;
    var_2 = 3;
    var_3 = "";

    if(!_isagent(self) && self hasfemalecustomizationmodel()) {
      var_3 = "w";
    }

    self.pers["voiceNum"] = level.voice_count[self.team][var_3];

    if(var_3 == "w") {
      level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_2;
    } else {
      level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_1;
    }

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
    thread reloadtracking();
    thread grenadetracking();
    thread grenadeproximitytracking();
    thread suppressingfiretracking();
    thread casualtytracking();
    thread damagetracking();
    thread sprinttracking();
    thread threatcallouttracking();
  }
}

grenadeproximitytracking() {
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = 147456;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    if(common_scripts\utility::cointoss()) {
      wait 5;
      continue;
    }

    var_2 = common_scripts\utility::ter_op(isDefined(level.grenades), level.grenades, []);
    var_3 = common_scripts\utility::ter_op(isDefined(level.missiles), level.missiles, []);
    var_4 = common_scripts\utility::ter_op(isDefined(level.trackingdrones), level.trackingdrones, []);

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

      if(isDefined(var_6.weaponname)) {
        switch (var_6.weaponname) {
          case "gamemode_ball":
            continue;
        }

        if(weaponinventorytype(var_6.weaponname) != "offhand" && weaponclass(var_6.weaponname) == "grenade") {
          continue;
        }
      }

      if(!isDefined(var_6._id_0117) && !var_7) {
        var_6._id_0117 = _getmissileowner(var_6);
      }

      if(isDefined(var_6._id_0117) && isDefined(var_6._id_0117.team) && level.teambased && var_6._id_0117.team == self.team) {
        continue;
      }
      var_8 = distancesquared(var_6.origin, self.origin);

      if(var_8 < var_1) {
        if(_bullettracepassed(var_6.origin, self.origin, 0, self)) {
          var_9 = "";

          if(var_7) {
            var_9 = "drone_incoming";
          } else if(isDefined(var_6.weaponname)) {
            switch (var_6.weaponname) {
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

          if(var_9 == "") {
            var_9 = "grenade_incoming";
          }

          level thread playerlinkweaponviewtodelta(self, var_9);
          wait 5;
        }
      }
    }
  }
}

suppressingfiretracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = undefined;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("begin_firing");
    thread suppresswaiter();
    thread suppresstimeout();
    self notify("stoppedFiring");
  }
}

suppresstimeout() {
  thread waitsuppresstimeout();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

waitsuppresstimeout() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread suppresstimeout();
}

suppresswaiter() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death");
  self endon("disconnect");
  self endon("stoppedFiring");
  wait 1;

  if(cansay("suppressing_fire")) {
    level thread playerlinkweaponviewtodelta(self, "suppressing_fire");
  }
}

reloadtracking() {
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

grenadetracking() {
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

    if(var_1 == "tabun_grenade_mp") {
      level thread playerlinkweaponviewtodelta(self, "tabun_out");
    }
  }
}

sprinttracking() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("sprint_begin");

    if(cansay("moving")) {
      level thread playerlinkweaponviewtodelta(self, "moving", 0, 0);
    }
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

    if(!maps\mp\_utility::_id_585F()) {
      self clientaddsoundsubmix("bayo_submix");
    } else if(isDefined(self.nobayocharge) && self.nobayocharge) {
      continue;
    }
    self._id_1655 = "";
    self._id_1656 = 1;

    if(self.team != "spectator") {
      var_6 = self.pers["voicePrefix"];

      if(maps\mp\_utility::_id_585F()) {
        var_6 = "plr_";
      }

      if(isDefined(var_6)) {
        if(isDefined(level.bcsounds["bayo_charge"])) {
          var_2 = var_6 + level.bcsounds["bayo_charge"];

          if(maps\mp\_utility::_hasperk("specialty_sprintmeleechargelonger")) {
            var_2 = var_2 + "_intro";
          } else if(maps\mp\_utility::_hasperk("specialty_sprintmeleecharge")) {
            var_2 = var_2 + "_intro_short";
          }
        }
      }

      if(maps\mp\_utility::_id_585F()) {
        var_7 = _id_0378::_id_307B(self.characterindex);
        var_2 = var_2 + ("_" + var_7);
      }
    }

    if(_soundexists(var_2)) {
      self._id_1657 = _id_0380::_id_6844(var_2, undefined, self);
    }

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

      if(maps\mp\_utility::_id_585F()) {
        var_6 = "plr_";
      }

      if(isDefined(var_6)) {
        if(isDefined(level.bcsounds["bayo_charge"])) {
          var_0 = var_6 + level.bcsounds["bayo_charge"];

          if(!self._id_1656 && !maps\mp\_utility::_id_585F()) {
            var_0 = var_0 + self._id_1655;
          }
        }
      }

      if(maps\mp\_utility::_id_585F()) {
        var_7 = _id_0378::_id_307B(self.characterindex);
        var_0 = var_0 + ("_" + var_7);
      }

      if(_soundexists(var_0)) {
        self._id_1658 = _id_0380::_id_6844(var_0, undefined, self);
      }
    }
  }
}

_id_1653() {
  self endon("disconnect");
  var_0 = common_scripts\utility::waittill_any_return("death", "sprint_melee_charge_end", "sprint_melee_charge_attack");

  if(var_0 == "death" && isDefined(self)) {
    if(self._id_1656) {
      _id_0380::_id_6850(self._id_1657, 0.1);
    } else {
      _id_0380::_id_6850(self._id_1658, 0.1);
    }

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

    if(!maps\mp\_utility::_id_585F()) {
      self clientclearsoundsubmix("bayo_submix");
    }

    if(!self._id_1656) {
      if(self.team != "spectator") {
        var_2 = self.pers["voicePrefix"];

        if(maps\mp\_utility::_id_585F()) {
          var_2 = "plr_";
        }

        if(isDefined(var_2)) {
          if(isDefined(level.bcsounds["bayo_charge_end"])) {
            var_0 = var_2 + level.bcsounds["bayo_charge_end"];

            if(!maps\mp\_utility::_id_585F()) {
              var_0 = var_0 + self._id_1655;
            }
          }
        }
      }

      if(!self._id_1656) {
        _id_0380::_id_6850(self._id_1658, 0.1);
      }

      if(maps\mp\_utility::_id_585F()) {
        var_3 = _id_0378::_id_307B(self.characterindex);
        var_0 = var_0 + ("_" + var_3);
      }

      if(_soundexists(var_0)) {
        _id_0380::_id_6844(var_0, undefined, self, 0.1);
      }
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

    if(!maps\mp\_utility::_id_585F()) {
      self clientclearsoundsubmix("bayo_submix");
    }

    if(self.team != "spectator") {
      var_3 = self.pers["voicePrefix"];

      if(maps\mp\_utility::_id_585F()) {
        var_3 = "plr_";
      }

      if(isDefined(var_3)) {
        if(isDefined(level.bcsounds["bayo_charge_end"])) {
          var_0 = var_3 + level.bcsounds["bayo_charge_attack"];
        }
      }

      if(!self._id_1656) {
        _id_0380::_id_6850(self._id_1658, 0.1);
      } else {
        _id_0380::_id_6850(self._id_1657, 0.1);
      }

      if(maps\mp\_utility::_id_585F()) {
        var_4 = _id_0378::_id_307B(self.characterindex);
        var_0 = var_0 + ("_" + var_4);
      }

      if(_soundexists(var_0)) {
        _id_0380::_id_6844(var_0, undefined, self, 0.1);
      }
    }
  }
}

damagetracking() {
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

casualtytracking() {
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.team;

  if(maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  self waittill("death");

  foreach(var_2 in level.participants) {
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

threatcallouttracking() {
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

    if(!cansay("callout_location") && !cansay("callout_generic")) {
      continue;
    }
    var_0 = self getsightedplayers();

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = undefined;
    var_2 = 4000000;

    if(self playerads() > 0.7) {
      var_2 = 6250000;
    }

    foreach(var_4 in var_0) {
      if(isDefined(var_4) && maps\mp\_utility::isreallyalive(var_4) && !var_4 maps\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin, var_4.origin) < var_2) {
        var_5 = var_4 getvalidlocation(self);
        var_1 = var_4;

        if(isDefined(var_5) && cansay("callout_location") && friendly_nearby(4840000)) {
          if(maps\mp\_utility::_hasperk("specialty_silentmovement") || maps\mp\_utility::_hasperk("specialty_quieter") || !friendly_nearby(262144)) {
            level thread playerlinkweaponviewtodelta(self, var_5.locationaliases[0], 0);
          } else {
            level thread playerlinkweaponviewtodelta(self, var_5.locationaliases[0], 1);
          }

          break;
        }
      }
    }

    if(isDefined(var_1) && cansay("callout_generic")) {
      var_7 = var_1 getcurrentprimaryweapon();
      var_8 = isDefined(self.frontshieldmodel);
      var_9 = weaponclass(var_7) == "sniper";

      if(var_8) {
        level thread playerlinkweaponviewtodelta(self, "callout_shield");
      } else if(var_9) {
        level thread playerlinkweaponviewtodelta(self, "callout_sniper");
      } else {
        level thread playerlinkweaponviewtodelta(self, "callout_generic");
      }
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

  if(isDefined(level.chatterdisabled) && level.chatterdisabled) {
    return;
  }
  if(isDefined(var_0.bcdisabled) && var_0.bcdisabled == 1) {
    return;
  }
  if(isspeakerinrange(var_0)) {
    return;
  }
  if(var_0.team != "spectator") {
    var_4 = var_0.pers["voicePrefix"];

    if(isDefined(var_4)) {
      if(isDefined(level.bcsounds[var_1])) {
        var_5 = var_4 + level.bcsounds[var_1];

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
        location_add_last_callout_time(var_1);
        var_5 = var_4 + "co_loc_" + var_1;
        var_0 thread dothreatcalloutresponse(var_5, var_1);
        var_1 = "callout_location";
      }

      var_0 updatechatter(var_1);
      var_0 thread dosound(var_5, var_1, var_2, var_3);
    }
  }
}

dosound(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = self.pers["team"];
  level _id_09ED(self, var_4);

  if(!_soundexists(var_0)) {
    level removespeaker(self, var_4);
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

  if((!isDefined(var_2) || var_2 == 0) && isPlayer(self)) {
    var_8 = 0;
  }

  if(!var_6) {
    var_4 = self.team;
  }

  var_9 = self setadrenalinesupport(var_0, var_4, var_8);

  if(isDefined(var_9)) {
    var_10 = _lookupsoundlength(var_0);

    if(isDefined(var_10)) {
      wait(var_10);
    }
  }

  if(isDefined(self)) {
    level removespeaker(self, self.team);
  }
}

dothreatcalloutresponse(var_0, var_1) {
  var_2 = common_scripts\utility::waittill_any_return(var_0, "death", "disconnect");

  if(var_2 == var_0) {
    var_3 = self.team;

    if(!_isagent(self)) {
      var_4 = self hasfemalecustomizationmodel();
    } else {
      var_4 = 0;
    }

    var_5 = self.pers["voiceNum"];
    var_6 = self.origin;
    wait 0.5;

    foreach(var_8 in level.participants) {
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
      if(!_isagent(var_8)) {
        var_9 = var_8 hasfemalecustomizationmodel();
      } else {
        var_9 = 0;
      }

      if((var_5 != var_8.pers["voiceNum"] || var_4 != var_9) && distancesquared(var_6, var_8.origin) <= 262144 && !isspeakerinrange(var_8)) {
        var_10 = var_8.pers["voicePrefix"];
        var_11 = var_10 + "co_loc_" + var_1 + "_echo";

        if(common_scripts\utility::cointoss() && _soundexists(var_11)) {
          var_12 = var_11;
        } else {
          var_12 = var_10 + level.bcsounds["callout_response_generic"];
        }

        var_8 thread dosound(var_12, var_1, 0, 0);
        break;
      }
    }
  }
}

timehack(var_0) {
  self endon("death");
  self endon("disconnect");
  wait 2.0;
  self notify(var_0);
}

isspeakerinrange(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_2 = var_1 * var_1;

  if(isDefined(var_0) && isDefined(var_0.team) && var_0.team != "spectator") {
    for(var_3 = 0; var_3 < level.speakers[var_0.team].size; var_3++) {
      var_4 = level.speakers[var_0.team][var_3];

      if(var_4 == var_0) {
        return 1;
      }

      if(!isDefined(var_4)) {
        continue;
      }
      if(distancesquared(var_4.origin, var_0.origin) < var_2) {
        return 1;
      }
    }
  }

  return 0;
}

_id_09ED(var_0, var_1) {
  level.speakers[var_1][level.speakers[var_1].size] = var_0;
}

removespeaker(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.speakers[var_1].size; var_3++) {
    if(level.speakers[var_1][var_3] == var_0) {
      continue;
    }
    var_2[var_2.size] = level.speakers[var_1][var_3];
  }

  level.speakers[var_1] = var_2;
}

disablebattlechatter(var_0) {
  var_0.bcdisabled = 1;
}

enablebattlechatter(var_0) {
  var_0.bcdisabled = undefined;
}

cansay(var_0) {
  var_1 = self.pers["team"];

  if(var_1 == "spectator") {
    return 0;
  }

  var_2 = level.bcinfo["timeout_player"][var_0];
  var_3 = gettime() - self.bcinfo["last_say_time"][var_0];

  if(var_2 > var_3) {
    return 0;
  }

  var_2 = level.bcinfo["timeout"][var_0];
  var_3 = gettime() - level.bcinfo["last_say_time"][var_1][var_0];

  if(var_2 < var_3) {
    return 1;
  }

  return 0;
}

updatechatter(var_0) {
  var_1 = self.pers["team"];
  self.bcinfo["last_say_time"][var_0] = gettime();
  level.bcinfo["last_say_time"][var_1][var_0] = gettime();
  level.bcinfo["last_say_pos"][var_1][var_0] = self.origin;
}

getlocation() {
  var_0 = get_all_my_locations();
  var_0 = common_scripts\utility::array_randomize(var_0);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!location_called_out_ever(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in var_0) {
      if(!location_called_out_recently(var_2)) {
        return var_2;
      }
    }
  }

  return undefined;
}

getvalidlocation(var_0) {
  var_1 = get_all_my_locations();
  var_1 = common_scripts\utility::array_randomize(var_1);

  if(var_1.size) {
    foreach(var_3 in var_1) {
      if(!location_called_out_ever(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }

    foreach(var_3 in var_1) {
      if(!location_called_out_recently(var_3) && var_0 cancalloutlocation(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

update_bcs_locations() {
  if(isDefined(anim.bcs_locations)) {
    anim.bcs_locations = common_scripts\utility::_id_0FA0(anim.bcs_locations);
  }
}

is_in_callable_location() {
  var_0 = get_all_my_locations();

  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2)) {
      return 1;
    }
  }

  return 0;
}

location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

location_called_out_recently(var_0) {
  var_1 = location_get_last_callout_time(var_0.locationaliases[0]);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = var_1 + 25000;

  if(gettime() < var_2) {
    return 1;
  }

  return 0;
}

location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0] = gettime();
}

location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0])) {
    return anim.locationlastcallouttimes[var_0];
  }

  return undefined;
}

cancalloutlocation(var_0) {
  foreach(var_2 in var_0.locationaliases) {
    var_3 = getloccalloutalias("co_loc_" + var_2);
    var_4 = getqacalloutalias(var_2, 0);
    var_5 = getloccalloutalias("concat_loc_" + var_2);
    var_6 = _soundexists(var_3) || _soundexists(var_4) || _soundexists(var_5);

    if(var_6) {
      return var_6;
    }
  }

  return 0;
}

canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self)) {
      return 1;
    }
  }

  return 0;
}

getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

iscallouttypeconcat(var_0, var_1) {
  var_2 = var_1 getloccalloutalias("concat_loc_" + var_0);

  if(_soundexists(var_2)) {
    return 1;
  }

  return 0;
}

iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && _soundexists(var_0)) {
    return 1;
  }

  var_2 = var_1 getqacalloutalias(var_0, 0);

  if(_soundexists(var_2)) {
    return 1;
  }

  return 0;
}

getloccalloutalias(var_0) {
  var_1 = self.pers["voicePrefix"] + var_0;
  return var_1;
}

getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias(var_0);
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

battlechatter_canprint() {
  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

battlechatter_print(var_0) {}

battlechatter_printdump(var_0) {}

battlechatter_debugprint(var_0) {}

getaliastypefromsoundalias(var_0) {}

battlechatter_printdumpline(var_0, var_1, var_2) {}

friendly_nearby(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 262144;
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team) && isDefined(self.pers["team"]) && var_2.team == self.pers["team"]) {
      if(var_2 != self && distancesquared(var_2.origin, self.origin) <= var_0) {
        return 1;
      }
    }
  }

  return 0;
}