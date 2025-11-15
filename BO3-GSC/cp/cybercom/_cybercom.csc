/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom_gadget_firefly;
#using scripts\cp\cybercom\_cybercom_gadget_misdirection;
#using scripts\cp\cybercom\_cybercom_gadget_security_breach;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom;

function autoexec __init__sytem__() {
  system::register("cybercom", & __init__, undefined, undefined);
}

function __init__() {
  setdvar("cybercom_fastswitch_enabled", "1");
  level.cybercom_status = 0;
  init_clientfields();
  function_15b9d1ea();
  callback::on_spawned( & on_player_spawned);
  cybercom_firefly::init();
  cybercom_security_breach::init();
  cybercom_misdirection::init();
}

function init_clientfields() {
  clientfield::register("world", "cybercom_disabled", 1, 1, "int", & cybercomdisabledall, 0, 0);
  clientfield::register("toplayer", "cybercom_disabled", 1, 1, "int", & cybercomdisabled, 0, 0);
  clientfield::register("vehicle", "cybercom_setiffname", 1, 3, "int", & setiffname, 0, 0);
  clientfield::register("actor", "cybercom_setiffname", 1, 3, "int", & setiffname, 0, 0);
  clientfield::register("actor", "cybercom_immolate", 1, 2, "int", & function_87475da2, 0, 0);
  clientfield::register("vehicle", "cybercom_immolate", 1, 1, "int", & function_a7363f41, 0, 0);
  clientfield::register("actor", "cybercom_sysoverload", 1, 2, "int", & function_572c7315, 0, 0);
  clientfield::register("vehicle", "cybercom_sysoverload", 1, 1, "int", & function_38510c4a, 0, 0);
  clientfield::register("actor", "cybercom_surge", 1, 2, "int", & function_2d61bf2e, 0, 0);
  clientfield::register("vehicle", "cybercom_surge", 1, 2, "int", & function_50dfd00b, 0, 0);
  clientfield::register("scriptmover", "cybercom_surge", 1, 1, "int", & function_38cc3f2e, 0, 0);
  clientfield::register("actor", "cybercom_shortout", 1, 2, "int", & function_82d4e6fe, 0, 0);
  clientfield::register("vehicle", "cybercom_shortout", 1, 2, "int", & function_6f88468d, 0, 0);
  clientfield::register("allplayers", "cyber_arm_pulse", 1, 2, "counter", & cyber_arm_pulse, 0, 0);
  clientfield::register("actor", "cyber_arm_pulse", 1, 2, "counter", & cyber_arm_pulse, 0, 0);
  clientfield::register("scriptmover", "cyber_arm_pulse", 1, 2, "counter", & cyber_arm_pulse, 0, 0);
  clientfield::register("actor", "sensory_overload", 1, 2, "int", & cybercom_sensoryoverload, 0, 0);
  clientfield::register("actor", "forced_malfunction", 1, 1, "int", & cybercom_forcedmalfunction, 0, 0);
  clientfield::register("toplayer", "hacking_progress", 1, 12, "int", & function_9439eecf, 0, 0);
  clientfield::register("toplayer", "resetAbilityWheel", 1, 1, "int", & function_806d1a61, 0, 0);
  level._effect["sensory_disable_human"] = "electric/fx_ability_elec_sensory_ol_human";
  level._effect["forced_malfunction"] = "electric/fx_ability_elec_sensory_ol_weapon";
}

function function_15b9d1ea() {
  level.var_6d1233cd = spawnStruct();
  level.var_6d1233cd.var_f9151455 = [];
  level.var_6d1233cd.var_f9151455[0] = 1;
  level.var_6d1233cd.var_f9151455[1] = 2;
  level.var_6d1233cd.var_f9151455[2] = 6;
  level.var_6d1233cd.var_f9151455[3] = 3;
  level.var_6d1233cd.var_f9151455[4] = 5;
  level.var_6d1233cd.var_f9151455[5] = 4;
  level.var_6d1233cd.var_7835feac = [];
  level.var_6d1233cd.var_7835feac[0] = 0;
  level.var_6d1233cd.var_7835feac[1] = 1;
  level.var_6d1233cd.var_7835feac[2] = 3;
  level.var_6d1233cd.var_7835feac[3] = 5;
  level.var_6d1233cd.var_7835feac[4] = 4;
  level.var_6d1233cd.var_7835feac[5] = 2;
}

function function_ff55db55(var_29072664) {
  return level.var_6d1233cd.var_f9151455[var_29072664];
}

function function_d3ef9004(var_b41337db) {
  return level.var_6d1233cd.var_7835feac[var_b41337db];
}

function function_850a0f8d(var_80c5df, start_index) {
  for(index = 1; index < 6; index++) {
    var_93a57fde = (start_index + index) % 6;
    abilityindex = function_d3ef9004(var_93a57fde);
    if(self iscybercomindexenabled(var_80c5df, abilityindex)) {
      return var_93a57fde;
    }
  }
  return undefined;
}

function function_5eccc9a4(localclientnum) {
  var_28b99141 = self getcybercomtype();
  var_1d8356fd = function_371a93b4(localclientnum, var_28b99141);
  if(!isDefined(var_1d8356fd)) {
    return;
  }
  var_f0285882 = self function_850a0f8d(var_28b99141, var_1d8356fd);
  if(!isDefined(var_f0285882)) {
    return;
  }
  var_b536f3a3 = function_d3ef9004(var_f0285882);
  var_d2dd9579 = self getcybercomabilityname(self getcybercomtype(), var_b536f3a3);
  self setplayercybercomability(var_d2dd9579);
  function_62d5481c(localclientnum, var_28b99141, var_f0285882);
}

function on_player_spawned(localclientnum) {
  self initcybercom(localclientnum);
  self thread watchmenu(localclientnum);
}

function opentacmenu(localclientnum) {
  if(!isDefined(self.tacticalmenu) && !isigcactive(localclientnum)) {
    self.tacticalmenu = createluimenu(localclientnum, self.cybercom.menu);
    openluimenu(localclientnum, self.tacticalmenu);
    self setintacticalhud(1);
    audio::playloopat("gdt_tac_menu_snapshot_loop", (0, 0, 0));
  } else {
    self.var_316fa5e6 = 1;
  }
  self.var_5208f863 = undefined;
}

function freetacmenuhandle(localclientnum, menu) {
  self endon("disconnect");
  self notify("freetacmenuhandle");
  self endon("freetacmenuhandle");
  audio::stoploopat("gdt_tac_menu_snapshot_loop", (0, 0, 0));
  wait(0.25);
  closeluimenu(localclientnum, menu);
  if(!isDefined(self)) {
    return;
  }
  self.tacticalmenu = undefined;
  self setintacticalhud(0);
  if(isDefined(self.var_316fa5e6) && self.var_316fa5e6) {
    self opentacmenu(localclientnum);
    self.var_316fa5e6 = undefined;
  }
}

function closetacmenu(localclientnum) {
  if(isDefined(self.tacticalmenu)) {
    setluimenudata(localclientnum, self.tacticalmenu, "close_current_menu", 1);
    self thread freetacmenuhandle(localclientnum, self.tacticalmenu);
  } else if(isDefined(self.var_5208f863) && (isDefined(self.var_5208f863) && self.var_5208f863) && getdvarint("cybercom_fastswitch_enabled") == 1) {
    self function_5eccc9a4(localclientnum);
  }
  self.var_316fa5e6 = undefined;
  self.var_5208f863 = undefined;
}

function watchmenuclose(localclientnum) {
  self endon("disconnect");
  self notify("watchmenuclosestart");
  self endon("watchmenuclosestart");
  for(;;) {
    self util::waittill_any("tactical_menu_close", "death");
    self closetacmenu(localclientnum);
  }
}

function function_524667f7(localclientnum) {
  self endon("tactical_menu_open");
  self endon("tactical_menu_close");
  self endon("watchmenuopenstart");
  self endon("death");
  self.var_5208f863 = 1;
  wait(0.15);
  self opentacmenu(localclientnum);
}

function watchmenuopen(localclientnum) {
  self notify("watchmenuopenstart");
  self endon("watchmenuopenstart");
  for(;;) {
    self waittill("tactical_menu_open");
    if(level.cybercom_status == 0 && (!(isDefined(self.cybercomdisabled) && self.cybercomdisabled)) && !isigcactive(localclientnum)) {
      self thread function_524667f7(localclientnum);
    }
  }
}

function function_820cd75b(localclientnum) {
  self notify("hash_820cd75b");
  self endon("hash_820cd75b");
  for(;;) {
    self waittill("tactical_menu_toggle");
    if(isDefined(self.tacticalmenu)) {
      self closetacmenu(localclientnum);
      continue;
    }
    if(level.cybercom_status == 0 && (!(isDefined(self.cybercomdisabled) && self.cybercomdisabled)) && !isigcactive(localclientnum)) {
      self opentacmenu(localclientnum);
    }
  }
}

function watchmenu(localclientnum) {
  if(self islocalplayer()) {
    self thread watchmenuopen(localclientnum);
    self thread watchmenuclose(localclientnum);
    self thread function_820cd75b(localclientnum);
  }
}

function cybercomdisabled(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self notify("tactical_menu_close");
    self.cybercomdisabled = 1;
  } else {
    self.cybercomdisabled = undefined;
  }
}

function cybercomdisabledall(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.cybercom_status = newval;
  players = getlocalplayers();
  if(level.cybercom_status == 1) {
    foreach(player in players) {
      player notify("tactical_menu_close");
      player.cybercomdisabled = 1;
    }
  } else {
    foreach(player in players) {
      player notify("tactical_menu_close");
      player.cybercomdisabled = undefined;
    }
  }
}

function emergencyreserve(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  assert(isDefined(player));
  if(isDefined(player.emergencyreserve) && player.emergencyreserve && !newval) {
    player.emergencyreserve = undefined;
    visionsetnaked(localclientnum, getdvarstring("mapname"), 0);
  } else if(!(isDefined(player.emergencyreserve) && player.emergencyreserve) && newval) {
    player.emergencyreserve = 1;
    visionsetnaked(localclientnum, "cheat_bw", 0.5);
  }
}

function repulsorarmorrecharging(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  assert(isDefined(player));
  if(isDefined(player.repulsorrecharging) && player.repulsorrecharging && !newval) {
    player.repulsorrecharging = undefined;
    visionsetnaked(localclientnum, getdvarstring("mapname"), 0);
  } else if(!(isDefined(player.repulsorrecharging) && player.repulsorrecharging) && newval) {
    player.repulsorrecharging = 1;
    visionsetnaked(localclientnum, "cheat_bw", 0.5);
  }
}

function castinganimationwatcher(localclientnum) {
  self notify("castinganimationwatcher");
  self endon("castinganimationwatcher");
  self endon("disconnect");
  self endon("entityshutdown");
  self.cybercom.lastcastat = 0;
  while(true) {
    self waittill("gadget_casting_anim");
    curtime = gettime();
    if((self.cybercom.lastcastat + 1000) < curtime) {
      cyber_arm_pulse(localclientnum, 0, 0);
      self.cybercom.lastcastat = curtime;
    }
  }
}

function initcybercom(localclientnum) {
  if(!isDefined(self.cybercom)) {
    self.cybercom = spawnStruct();
    self.cybercom.menu = "AbilityWheel";
    self.tacticalmenu = undefined;
  }
  self thread castinganimationwatcher(localclientnum);
}

function function_38510c4a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFX(localclientnum, "electric/fx_elec_sparks_burst_lg_os", self.origin);
    if(isDefined(self.archetype)) {
      switch (self.archetype) {
        case "turret": {
          playSound(0, "gdt_cybercore_turret_shutdown", self.origin);
          break;
        }
        case "amws": {
          playSound(0, "gdt_cybercore_amws_shutdown", self.origin);
          break;
        }
        case "pamws": {
          playSound(0, "gdt_cybercore_amws_shutdown", self.origin);
          break;
        }
        case "raps": {
          playSound(0, "veh_raps_skid", self.origin);
          break;
        }
        case "wasp": {
          playSound(0, "gdt_cybercore_wasp_shutdown", self.origin);
          break;
        }
      }
    }
  }
}

function function_572c7315(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFXOnTag(localclientnum, "electric/fx_elec_sparks_burst_lg_os", self, "j_neck");
    self playSound(0, "fly_bot_disable");
  } else if(newval == 2) {
    playFXOnTag(localclientnum, "electric/fx_ability_elec_startup_robot", self, "j_spine4");
    self playSound(0, "fly_bot_reboot");
  }
}

function function_38cc3f2e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_trail", self, "tag_origin");
    self playSound(0, "gdt_surge_bounce");
  }
}

function function_2d61bf2e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_robot", self, "j_spine4");
    self playSound(0, "gdt_surge_impact");
  } else if(newval == 2) {
    playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_robot", self, "j_spine4");
    self playSound(0, "gdt_surge_chase");
  }
}

function function_50dfd00b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_3949887b)) {
    stopfx(localclientnum, self.var_3949887b);
  }
  if(newval == 1) {
    self playSound(0, "gdt_surge_impact");
    switch (self.archetype) {
      case "turret": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_turret", self, "tag_fx");
        break;
      }
      case "amws": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_amws", self, "tag_head_slide_animate");
        break;
      }
      case "pamws": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_pamws", self, "tag_head_slide_animate");
        break;
      }
      case "raps": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_raps", self, "tag_wheel_front_right_animate");
        break;
      }
      case "wasp": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_wasp", self, "tag_body");
        break;
      }
      default: {
        assert(0, "");
        break;
      }
    }
  } else if(newval == 2) {
    switch (self.archetype) {
      case "turret": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_turret", self, "tag_fx");
        break;
      }
      case "amws": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_amws", self, "tag_head_slide_animate");
        break;
      }
      case "pamws": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_pamws", self, "tag_head_slide_animate");
        break;
      }
      case "raps": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_raps", self, "tag_wheel_front_right_animate");
        break;
      }
      case "wasp": {
        self.var_3949887b = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_wasp", self, "tag_body");
        break;
      }
      default: {
        assert(0, "");
        break;
      }
    }
  }
}

function function_82d4e6fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playSound(0, "gdt_servo_robot_die");
    playFXOnTag(localclientnum, "electric/fx_ability_servo_shortout_robot", self, "j_spine4");
  }
  if(newval == 2) {
    playFXOnTag(localclientnum, "destruct/fx_dest_robot_limb_sparks_right", self, "j_knee_ri");
    playFXOnTag(localclientnum, "destruct/fx_dest_robot_limb_sparks_left", self, "j_knee_le");
  }
}

function function_6f88468d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_3e759796)) {
    stopfx(localclientnum, self.var_3e759796);
  }
  if(newval == 1) {
    self playSound(0, "gdt_servo_robot_die");
    switch (self.archetype) {
      case "turret": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_turret", self, "tag_fx");
        break;
      }
      case "amws": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_amws", self, "tag_head_slide_animate");
        break;
      }
      case "pamws": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_pamws", self, "tag_head_slide_animate");
        break;
      }
      case "raps": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_raps", self, "tag_wheel_front_right_animate");
        break;
      }
      case "wasp": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_wasp", self, "tag_body");
        break;
      }
      default: {
        assert(0, "");
        break;
      }
    }
  } else if(newval == 2) {
    switch (self.archetype) {
      case "turret": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_turret", self, "tag_fx");
        break;
      }
      case "amws": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_amws", self, "tag_head_slide_animate");
        break;
      }
      case "pamws": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_pamws", self, "tag_head_slide_animate");
        break;
      }
      case "raps": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_raps", self, "tag_wheel_front_right_animate");
        break;
      }
      case "wasp": {
        self.var_3e759796 = playFXOnTag(localclientnum, "electric/fx_ability_elec_surge_short_upgrade_wasp", self, "tag_body");
        break;
      }
      default: {
        assert(0, "");
        break;
      }
    }
  }
}

function function_87475da2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.archetype == "robot") {
    if(newval == 1) {
      self playSound(0, "gdt_immolation_robot_countdown");
    } else if(newval == 2) {
      player = getlocalplayers()[0];
      player earthquake(0.5, 0.5, self.origin, 500);
      playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
      playSound(0, "wpn_incendiary_explode", self.origin);
      playFXOnTag(localclientnum, "explosions/fx_ability_exp_immolation", self, "j_spinelower");
      physicsexplosionsphere(localclientnum, self.origin, 200, 32, 2, 10, 1, 1, 1);
    }
  } else if(self.archetype == "human" || self.archetype == "human_riotshield") {
    if(newval == 1) {
      self playSound(0, "gdt_immolation_human_countdown");
    }
  }
}

function function_a7363f41(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self playSound(0, "gdt_immolation_robot_countdown");
  }
}

function setiffname(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0: {
      self setdrawname();
      self.var_2b998b77 = undefined;
      self notify("hash_e0f9c098");
      break;
    }
    case 1: {
      text = makelocalizedstring("WEAPON_LINK_INPROGRESS");
      self.var_2b998b77 = text;
      self setdrawname(self.var_2b998b77, 1);
      self playSound(0, "gdt_iff_activate");
      break;
    }
    case 2: {
      self.var_2b998b77 = function_a4cd6b9a();
      self setdrawname(self.var_2b998b77);
      self callback::on_shutdown( & function_d48fcfa6);
      break;
    }
    case 3: {
      text = makelocalizedstring("WEAPON_LINK_FAILURE");
      self.var_2b998b77 = text;
      self setdrawname(self.var_2b998b77, 1);
      break;
    }
    case 4: {
      text = makelocalizedstring("WEAPON_LINK_TERMINATED");
      self.var_2b998b77 = text;
      self setdrawname(self.var_2b998b77, 1);
      self playSound(0, "gdt_iff_deactivate");
      break;
    }
  }
}

function private function_13f09a6b() {
  self endon("entityshutdown");
  self notify("hash_e0f9c098");
  self endon("hash_e0f9c098");
  while(true) {
    wait(2);
    self setdrawname(self.var_2b998b77, 2);
    wait(2);
    self setdrawname(self.var_2b998b77, 1);
  }
}

function private function_d48fcfa6(localclientnum) {
  self setdrawname();
}

function private function_66be631b() {
  alpha = array("A", "B", "C", "D", "E", "F");
  digit = array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
  var_f00997fd = (randomint(100) < 50 ? alpha[randomint(alpha.size)] : digit[randomint(digit.size)]);
  var_160c1266 = (randomint(100) < 50 ? alpha[randomint(alpha.size)] : digit[randomint(digit.size)]);
  return var_f00997fd + var_160c1266;
}

function private function_a4cd6b9a() {
  name = "";
  if(issubstr(self.model, "_54i_")) {
    var_461b88f6 = "3534:49FF:FE";
  } else {
    if(issubstr(self.model, "_nrc_")) {
      var_461b88f6 = "4E52:43FF:FE";
    } else {
      var_461b88f6 = "4349:41FF:FE";
    }
  }
  var_13ff0d3c = function_66be631b();
  var_86067c77 = function_66be631b();
  var_6004020e = function_66be631b();
  name = (((var_461b88f6 + var_13ff0d3c) + ":") + var_86067c77) + var_6004020e;
  return name;
}

function cyber_arm_pulse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_effect_duration = 1;
  n_pulse_speed = 1;
  n_number_of_pulses = 1;
  switch (newval) {
    case 0: {
      self notify("hash_2f142d63");
      self thread function_38e32940();
      break;
    }
    case 1: {
      n_pulse_speed = 3.023;
      n_effect_duration = 3.05;
      n_number_of_pulses = 4;
      self notify("hash_2f142d63");
      self setarmpulse(n_effect_duration, n_pulse_speed, n_number_of_pulses, "gdt_cybercore_arm_pulse");
      break;
    }
    case 2: {
      n_pulse_speed = 3.023;
      n_effect_duration = 3.05;
      n_number_of_pulses = 5;
      self notify("hash_2f142d63");
      self setarmpulse(n_effect_duration, n_pulse_speed, n_number_of_pulses, "gdt_cybercore_arm_pulse");
      break;
    }
  }
}

function function_38e32940() {
  self endon("entityshutdown");
  self endon("disconnect");
  self endon("hash_2f142d63");
  var_f13af102 = 0;
  var_b608e411 = 0;
  var_9fd3593c = 1;
  time_counter = 0;
  var_a36d3ca2 = getdvarint("cybercom_arm_ready", 50);
  var_b6fa88aa = getdvarint("cybercom_move_down_arm", 110);
  var_293e9a7b = getdvarint("cybercom_hold_on_arm", 290);
  var_968d78d2 = getdvarfloat("cybercom_hand_glow_shader_pct", 0.46);
  var_191c13e8 = getdvarfloat("cybercom_hand_glow_start", 0.07);
  var_266a1a59 = 690;
  var_b608e411 = var_191c13e8;
  total_time = var_266a1a59;
  while(time_counter < total_time) {
    current_time = time_counter;
    switch (var_f13af102) {
      case 0: {
        if(current_time > var_a36d3ca2) {
          var_f13af102 = 1;
        } else {
          var_9fd3593c = (0.2 - var_191c13e8) / (var_a36d3ca2 * 0.09999999);
          var_b608e411 = var_b608e411 + var_9fd3593c;
          self setarmpulseposition(var_b608e411);
        }
        break;
      }
      case 1: {
        if(current_time > var_b6fa88aa) {
          var_f13af102 = 2;
        } else {
          var_9fd3593c = (var_968d78d2 - 0.2) / ((var_b6fa88aa - var_a36d3ca2) * 0.09999999);
          var_b608e411 = var_b608e411 + var_9fd3593c;
          self setarmpulseposition(var_b608e411);
        }
        break;
      }
      case 2: {
        if(current_time > var_293e9a7b) {
          var_9fd3593c = (1 - var_968d78d2) / ((total_time - current_time) * 0.09999999);
          var_f13af102 = 3;
        }
        break;
      }
      case 3: {
        var_b608e411 = var_b608e411 + var_9fd3593c;
        self setarmpulseposition(var_b608e411);
        break;
      }
    }
    wait(0.01);
    time_counter = time_counter + 10;
  }
}

function cybercom_forcedmalfunction(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0 && isDefined(self.var_dea2a612)) {
    deletefx(localclientnum, self.var_dea2a612);
  }
  if(newval == 1) {
    if(isDefined(self.var_dea2a612)) {
      deletefx(localclientnum, self.var_dea2a612);
    }
    tagorigin = self gettagorigin("tag_brass");
    if(isDefined(tagorigin)) {
      self.var_dea2a612 = playFXOnTag(localclientnum, level._effect["forced_malfunction"], self, "tag_brass");
    }
  }
}

function cybercom_sensoryoverload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0 && isDefined(self.var_ac70f183)) {
    deletefx(localclientnum, self.var_ac70f183);
  }
  if(newval == 2) {} else {}
  if(newval != 0) {
    if(isDefined(self.var_ac70f183)) {
      deletefx(localclientnum, self.var_ac70f183);
    }
    self.var_ac70f183 = playFXOnTag(localclientnum, level._effect["sensory_disable_human"], self, "j_neck");
  }
}

function function_2aa9d708(model, range, start) {
  self notify("hash_2aa9d708");
  self endon("hash_2aa9d708");
  self endon("hash_14a1bc97");
  starttime = getrealtime();
  val = start / range;
  while(val <= 1) {
    setuimodelvalue(model, val);
    totaltime = ((getrealtime() - starttime) / 1000) + start;
    val = math::clamp(totaltime / range, 0, 1);
    wait(0.016);
  }
  setuimodelvalue(model, 0);
}

function function_9439eecf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  model = getuimodel(getuimodelforcontroller(localclientnum), "WorldSpaceIndicators.hackingPercent");
  if(!isDefined(model)) {
    return;
  }
  setuimodelvalue(model, 0);
  if(newval > 0) {
    range = newval & 31;
    start = ((newval >> 5) / 128) * range;
    self thread function_2aa9d708(model, range, start);
  } else {
    self notify("hash_14a1bc97");
  }
}

function function_806d1a61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_3d954e27 = getuimodel(controllermodel, "AbilityWheel.Selected1");
    if(!isDefined(var_3d954e27)) {
      createuimodel(controllermodel, "AbilityWheel.Selected1");
      var_3d954e27 = getuimodel(controllermodel, "AbilityWheel.Selected1");
    }
    var_cb8ddeec = getuimodel(controllermodel, "AbilityWheel.Selected2");
    if(!isDefined(var_cb8ddeec)) {
      createuimodel(controllermodel, "AbilityWheel.Selected2");
      var_cb8ddeec = getuimodel(controllermodel, "AbilityWheel.Selected2");
    }
    var_f1905955 = getuimodel(controllermodel, "AbilityWheel.Selected3");
    if(!isDefined(var_f1905955)) {
      createuimodel(controllermodel, "AbilityWheel.Selected3");
      var_f1905955 = getuimodel(controllermodel, "AbilityWheel.Selected3");
    }
    setuimodelvalue(var_3d954e27, 1);
    setuimodelvalue(var_cb8ddeec, 1);
    setuimodelvalue(var_f1905955, 1);
  }
}

function function_62d5481c(localclientnum, var_5a8c2a63, var_191d8f6d) {
  controllermodel = getuimodelforcontroller(localclientnum);
  var_e4d4320f = "AbilityWheel.Selected" + (var_5a8c2a63 + 1);
  selected = getuimodel(controllermodel, var_e4d4320f);
  setuimodelvalue(selected, var_191d8f6d + 1);
}

function function_371a93b4(localclientnum, var_c5f458e4) {
  var_e4230c26 = self getcybercomtype();
  controllermodel = getuimodelforcontroller(localclientnum);
  var_29ad5b90 = undefined;
  if(var_e4230c26 == 0) {
    var_29ad5b90 = getuimodel(controllermodel, "AbilityWheel.Selected1");
  } else {
    if(var_e4230c26 == 1) {
      var_29ad5b90 = getuimodel(controllermodel, "AbilityWheel.Selected2");
    } else if(var_e4230c26 == 2) {
      var_29ad5b90 = getuimodel(controllermodel, "AbilityWheel.Selected3");
    }
  }
  if(!isDefined(var_29ad5b90)) {
    return undefined;
  }
  var_191d8f6d = getuimodelvalue(var_29ad5b90);
  if(!isDefined(var_191d8f6d)) {
    return undefined;
  }
  return var_191d8f6d - 1;
}