/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\finalkillcam.gsc
***************************************/

func_9807() {
  level.finalkillcam_delay = [];
  level.finalkillcam_victim = [];
  level.finalkillcam_attacker = [];
  level.finalkillcam_attackernum = [];
  level.var_6C64 = [];
  level.var_6C65 = [];
  level.var_6C66 = [];
  level.finalkillcam_killcamentityindex = [];
  level.finalkillcam_killcamentitystarttime = [];
  level.finalkillcam_killcamentitystickstovictim = [];
  level.finalkillcam_sweapon = [];
  level.var_6C62 = [];
  level.finalkillcam_psoffsettime = [];
  level.finalkillcam_timerecorded = [];
  level.finalkillcam_timegameended = [];
  level.finalkillcam_smeansofdeath = [];
  level.finalkillcam_attackers = [];
  level.finalkillcam_attackerdata = [];
  level.finalkillcam_attackerperks = [];
  level.finalkillcam_killstreakvariantinfo = [];
  if(level.multiteambased) {
    foreach(var_01 in level.teamnamelist) {
      level.finalkillcam_delay[var_01] = undefined;
      level.finalkillcam_victim[var_01] = undefined;
      level.finalkillcam_attacker[var_01] = undefined;
      level.finalkillcam_attackernum[var_01] = undefined;
      level.var_6C64[var_01] = undefined;
      level.var_6C65[var_01] = undefined;
      level.var_6C66[var_01] = undefined;
      level.finalkillcam_killcamentityindex[var_01] = undefined;
      level.finalkillcam_killcamentitystarttime[var_01] = undefined;
      level.finalkillcam_killcamentitystickstovictim[var_01] = undefined;
      level.finalkillcam_sweapon[var_01] = undefined;
      level.var_6C62[var_01] = undefined;
      level.finalkillcam_psoffsettime[var_01] = undefined;
      level.finalkillcam_timerecorded[var_01] = undefined;
      level.finalkillcam_timegameended[var_01] = undefined;
      level.finalkillcam_smeansofdeath[var_01] = undefined;
      level.finalkillcam_attackers[var_01] = undefined;
      level.finalkillcam_attackerdata[var_01] = undefined;
      level.finalkillcam_attackerperks[var_01] = undefined;
      level.finalkillcam_killstreakvariantinfo[var_01] = undefined;
    }
  } else {
    level.finalkillcam_delay["axis"] = undefined;
    level.finalkillcam_victim["axis"] = undefined;
    level.finalkillcam_attacker["axis"] = undefined;
    level.finalkillcam_attackernum["axis"] = undefined;
    level.var_6C64["axis"] = undefined;
    level.var_6C65["axis"] = undefined;
    level.var_6C66["axis"] = undefined;
    level.finalkillcam_killcamentityindex["axis"] = undefined;
    level.finalkillcam_killcamentitystarttime["axis"] = undefined;
    level.finalkillcam_killcamentitystickstovictim["axis"] = undefined;
    level.finalkillcam_sweapon["axis"] = undefined;
    level.var_6C62["axis"] = undefined;
    level.finalkillcam_psoffsettime["axis"] = undefined;
    level.finalkillcam_timerecorded["axis"] = undefined;
    level.finalkillcam_timegameended["axis"] = undefined;
    level.finalkillcam_smeansofdeath["axis"] = undefined;
    level.finalkillcam_attackers["axis"] = undefined;
    level.finalkillcam_attackerdata["axis"] = undefined;
    level.finalkillcam_attackerperks["axis"] = undefined;
    level.finalkillcam_killstreakvariantinfo["axis"] = undefined;
    level.finalkillcam_delay["allies"] = undefined;
    level.finalkillcam_victim["allies"] = undefined;
    level.finalkillcam_attacker["allies"] = undefined;
    level.finalkillcam_attackernum["allies"] = undefined;
    level.var_6C64["allies"] = undefined;
    level.var_6C65["allies"] = undefined;
    level.var_6C66["allies"] = undefined;
    level.finalkillcam_killcamentityindex["allies"] = undefined;
    level.finalkillcam_killcamentitystarttime["allies"] = undefined;
    level.finalkillcam_killcamentitystickstovictim["allies"] = undefined;
    level.finalkillcam_sweapon["allies"] = undefined;
    level.var_6C62["allies"] = undefined;
    level.finalkillcam_psoffsettime["allies"] = undefined;
    level.finalkillcam_timerecorded["allies"] = undefined;
    level.finalkillcam_timegameended["allies"] = undefined;
    level.finalkillcam_smeansofdeath["allies"] = undefined;
    level.finalkillcam_attackers["allies"] = undefined;
    level.finalkillcam_attackerdata["allies"] = undefined;
    level.finalkillcam_attackerperks["allies"] = undefined;
    level.finalkillcam_killstreakvariantinfo["allies"] = undefined;
  }

  level.finalkillcam_delay["none"] = undefined;
  level.finalkillcam_victim["none"] = undefined;
  level.finalkillcam_attacker["none"] = undefined;
  level.finalkillcam_attackernum["none"] = undefined;
  level.var_6C64["none"] = undefined;
  level.var_6C65["none"] = undefined;
  level.var_6C66["none"] = undefined;
  level.finalkillcam_killcamentityindex["none"] = undefined;
  level.finalkillcam_killcamentitystarttime["none"] = undefined;
  level.finalkillcam_killcamentitystickstovictim["none"] = undefined;
  level.finalkillcam_sweapon["none"] = undefined;
  level.var_6C62["none"] = undefined;
  level.finalkillcam_psoffsettime["none"] = undefined;
  level.finalkillcam_timerecorded["none"] = undefined;
  level.finalkillcam_timegameended["none"] = undefined;
  level.finalkillcam_smeansofdeath["none"] = undefined;
  level.finalkillcam_attackers["none"] = undefined;
  level.finalkillcam_attackerdata["none"] = undefined;
  level.finalkillcam_attackerperks["none"] = undefined;
  level.finalkillcam_killstreakvariantinfo["none"] = undefined;
  level.finalkillcam_winner = undefined;
  level.recordfinalkillcam = 1;
}

erasefinalkillcam() {
  if(level.multiteambased) {
    for(var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
      level.finalkillcam_delay[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_victim[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_attacker[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_attackernum[level.teamnamelist[var_00]] = undefined;
      level.var_6C64[level.teamnamelist[var_00]] = undefined;
      level.var_6C65[level.teamnamelist[var_00]] = undefined;
      level.var_6C66[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_killcamentityindex[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_killcamentitystarttime[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_killcamentitystickstovictim[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_sweapon[level.teamnamelist[var_00]] = undefined;
      level.var_6C62[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_psoffsettime[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_timerecorded[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_timegameended[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_smeansofdeath[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_attackers[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_attackerdata[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_attackerperks[level.teamnamelist[var_00]] = undefined;
      level.finalkillcam_killstreakvariantinfo[level.teamnamelist[var_00]] = undefined;
    }
  } else {
    level.finalkillcam_delay["axis"] = undefined;
    level.finalkillcam_victim["axis"] = undefined;
    level.finalkillcam_attacker["axis"] = undefined;
    level.finalkillcam_attackernum["axis"] = undefined;
    level.var_6C64["axis"] = undefined;
    level.var_6C65["axis"] = undefined;
    level.var_6C66["axis"] = undefined;
    level.finalkillcam_killcamentityindex["axis"] = undefined;
    level.finalkillcam_killcamentitystarttime["axis"] = undefined;
    level.finalkillcam_killcamentitystickstovictim["axis"] = undefined;
    level.finalkillcam_sweapon["axis"] = undefined;
    level.var_6C62["axis"] = undefined;
    level.finalkillcam_psoffsettime["axis"] = undefined;
    level.finalkillcam_timerecorded["axis"] = undefined;
    level.finalkillcam_timegameended["axis"] = undefined;
    level.finalkillcam_smeansofdeath["axis"] = undefined;
    level.finalkillcam_attackers["axis"] = undefined;
    level.finalkillcam_attackerdata["axis"] = undefined;
    level.finalkillcam_attackerperks["axis"] = undefined;
    level.finalkillcam_killstreakvariantinfo["axis"] = undefined;
    level.finalkillcam_delay["allies"] = undefined;
    level.finalkillcam_victim["allies"] = undefined;
    level.finalkillcam_attacker["allies"] = undefined;
    level.finalkillcam_attackernum["allies"] = undefined;
    level.var_6C64["allies"] = undefined;
    level.var_6C65["allies"] = undefined;
    level.var_6C66["allies"] = undefined;
    level.finalkillcam_killcamentityindex["allies"] = undefined;
    level.finalkillcam_killcamentitystarttime["allies"] = undefined;
    level.finalkillcam_killcamentitystickstovictim["allies"] = undefined;
    level.finalkillcam_sweapon["allies"] = undefined;
    level.var_6C62["allies"] = undefined;
    level.finalkillcam_psoffsettime["allies"] = undefined;
    level.finalkillcam_timerecorded["allies"] = undefined;
    level.finalkillcam_timegameended["allies"] = undefined;
    level.finalkillcam_smeansofdeath["allies"] = undefined;
    level.finalkillcam_attackers["allies"] = undefined;
    level.finalkillcam_attackerdata["allies"] = undefined;
    level.finalkillcam_attackerperks["allies"] = undefined;
    level.finalkillcam_killstreakvariantinfo["allies"] = undefined;
  }

  level.finalkillcam_delay["none"] = undefined;
  level.finalkillcam_victim["none"] = undefined;
  level.finalkillcam_attacker["none"] = undefined;
  level.finalkillcam_attackernum["none"] = undefined;
  level.var_6C64["none"] = undefined;
  level.var_6C65["none"] = undefined;
  level.var_6C66["none"] = undefined;
  level.finalkillcam_killcamentityindex["none"] = undefined;
  level.finalkillcam_killcamentitystarttime["none"] = undefined;
  level.finalkillcam_killcamentitystickstovictim["none"] = undefined;
  level.finalkillcam_sweapon["none"] = undefined;
  level.var_6C62["none"] = undefined;
  level.finalkillcam_psoffsettime["none"] = undefined;
  level.finalkillcam_timerecorded["none"] = undefined;
  level.finalkillcam_timegameended["none"] = undefined;
  level.finalkillcam_smeansofdeath["none"] = undefined;
  level.finalkillcam_attackers["none"] = undefined;
  level.finalkillcam_attackerdata["none"] = undefined;
  level.finalkillcam_attackerperks["none"] = undefined;
  level.finalkillcam_killstreakvariantinfo["none"] = undefined;
  level.finalkillcam_winner = undefined;
}

preloadfinalkillcam() {
  var_00 = level.finalkillcam_attacker[level.finalkillcam_winner];
  if(isDefined(var_00)) {
    foreach(var_02 in level.players) {
      var_02 gettweakablelastvalue(var_00);
    }
  }
}

func_5853() {
  level waittill("round_end_finished");
  level.showingfinalkillcam = 1;
  var_00 = "none";
  if(isDefined(level.finalkillcam_winner)) {
    var_00 = level.finalkillcam_winner;
  }

  var_01 = level.finalkillcam_delay[var_00];
  var_02 = level.finalkillcam_victim[var_00];
  var_03 = level.finalkillcam_attacker[var_00];
  var_04 = level.finalkillcam_attackernum[var_00];
  var_05 = level.var_6C64[var_00];
  var_06 = level.var_6C65[var_00];
  var_07 = level.var_6C66[var_00];
  var_08 = level.finalkillcam_killcamentityindex[var_00];
  var_09 = level.finalkillcam_killcamentitystarttime[var_00];
  var_0A = level.finalkillcam_killcamentitystickstovictim[var_00];
  var_0B = level.finalkillcam_sweapon[var_00];
  var_0C = level.var_6C62[var_00];
  var_0D = level.finalkillcam_psoffsettime[var_00];
  var_0E = level.finalkillcam_timerecorded[var_00];
  var_0F = level.finalkillcam_timegameended[var_00];
  var_10 = level.finalkillcam_smeansofdeath[var_00];
  var_11 = level.finalkillcam_attackers[var_00];
  var_12 = level.finalkillcam_attackerdata[var_00];
  var_13 = level.finalkillcam_attackerperks[var_00];
  var_14 = level.finalkillcam_killstreakvariantinfo[var_00];
  if(!isDefined(var_02) || !isDefined(var_03)) {
    level.showingfinalkillcam = 0;
    level notify("final_killcam_done");
    return;
  }

  var_15 = 20;
  var_16 = var_0F - var_0E;
  if(var_16 > var_15) {
    level.showingfinalkillcam = 0;
    level notify("final_killcam_done");
    return;
  }

  if(isDefined(var_03)) {
    if(level.teambased) {
      var_17 = var_03.team;
    } else {
      var_17 = var_04.guid;
    }

    if(isDefined(level.finalkillcam_attacker[var_17]) && level.finalkillcam_attacker[var_17] == var_03) {
      scripts\mp\missions::processfinalkillchallenges(var_03, var_02);
    }
  }

  var_18 = spawnStruct();
  var_18.agent_type = var_06;
  var_18.lastspawntime = var_07;
  var_19 = gettime() - var_02.deathtime / 1000;
  foreach(var_1B in level.players) {
    var_1B scripts\mp\utility::restorebasevisionset(0);
    var_1B.setclientnamemode = var_02 getentitynumber();
    var_1B scripts\mp\damage::updatedeathdetails(var_11, var_12);
    if(!scripts\mp\utility::iskillstreakweapon(var_0B)) {
      var_1B scripts\mp\killcam::func_F770(var_0B, var_10, var_05);
    }

    var_1B thread scripts\mp\killcam::killcam(var_05, var_18, var_04, var_08, var_09, var_02 getentitynumber(), var_0A, var_0B, var_19 + var_0C, var_0D, 0, 12, var_03, var_02, var_10, var_13, var_14);
  }

  wait(0.15 + level.var_B4A7);
  while(anyplayersinkillcam()) {
    wait(0.05);
  }

  level notify("final_killcam_done");
  level.showingfinalkillcam = 0;
}

recordfinalkillcam(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(level.teambased && isDefined(param_02.team)) {
    level.finalkillcam_delay[param_02.team] = param_00;
    level.finalkillcam_victim[param_02.team] = param_01;
    level.finalkillcam_attacker[param_02.team] = param_02;
    level.finalkillcam_attackernum[param_02.team] = param_03;
    level.var_6C64[param_02.team] = param_04;
    level.finalkillcam_killcamentityindex[param_02.team] = param_05;
    level.finalkillcam_killcamentitystarttime[param_02.team] = param_06;
    level.finalkillcam_killcamentitystickstovictim[param_02.team] = param_07;
    level.finalkillcam_sweapon[param_02.team] = param_08;
    level.var_6C62[param_02.team] = param_09;
    level.finalkillcam_psoffsettime[param_02.team] = param_0A;
    level.finalkillcam_timerecorded[param_02.team] = scripts\mp\utility::getsecondspassed();
    level.finalkillcam_timegameended[param_02.team] = scripts\mp\utility::getsecondspassed();
    level.finalkillcam_smeansofdeath[param_02.team] = param_0B;
    level.finalkillcam_attackers[param_02.team] = param_01.attackers;
    level.finalkillcam_attackerdata[param_02.team] = param_01.attackerdata;
    level.finalkillcam_attackerperks[param_02.team] = param_02.pers["loadoutPerks"];
    level.finalkillcam_killstreakvariantinfo[param_02.team] = param_01.killsteakvariantattackerinfo;
    if(isDefined(param_04) && isagent(param_04)) {
      level.var_6C65[param_02.team] = param_04.agent_type;
      level.var_6C66[param_02.team] = param_04.lastspawntime;
    } else {
      level.var_6C65[param_02.team] = undefined;
      level.var_6C66[param_02.team] = undefined;
    }
  } else if(!level.teambased) {
    level.finalkillcam_delay[param_02.guid] = param_00;
    level.finalkillcam_victim[param_02.guid] = param_01;
    level.finalkillcam_attacker[param_02.guid] = param_02;
    level.finalkillcam_attackernum[param_02.guid] = param_03;
    level.var_6C64[param_02.guid] = param_04;
    level.finalkillcam_killcamentityindex[param_02.guid] = param_05;
    level.finalkillcam_killcamentitystarttime[param_02.guid] = param_06;
    level.finalkillcam_killcamentitystickstovictim[param_02.guid] = param_07;
    level.finalkillcam_sweapon[param_02.guid] = param_08;
    level.var_6C62[param_02.guid] = param_09;
    level.finalkillcam_psoffsettime[param_02.guid] = param_0A;
    level.finalkillcam_timerecorded[param_02.guid] = scripts\mp\utility::getsecondspassed();
    level.finalkillcam_timegameended[param_02.guid] = scripts\mp\utility::getsecondspassed();
    level.finalkillcam_smeansofdeath[param_02.guid] = param_0B;
    level.finalkillcam_attackers[param_02.guid] = param_01.attackers;
    level.finalkillcam_attackerdata[param_02.guid] = param_01.attackerdata;
    level.finalkillcam_attackerperks[param_02.guid] = param_02.pers["loadoutPerks"];
    level.finalkillcam_killstreakvariantinfo[param_02.guid] = param_01.killsteakvariantattackerinfo;
    if(isDefined(param_04) && isagent(param_04)) {
      level.var_6C65[param_02.guid] = param_04.agent_type;
      level.var_6C66[param_02.guid] = param_04.lastspawntime;
    } else {
      level.var_6C65[param_02.guid] = undefined;
      level.var_6C66[param_02.guid] = undefined;
    }
  }

  level.finalkillcam_delay["none"] = param_00;
  level.finalkillcam_victim["none"] = param_01;
  level.finalkillcam_attacker["none"] = param_02;
  level.finalkillcam_attackernum["none"] = param_03;
  level.var_6C64["none"] = param_04;
  level.finalkillcam_killcamentityindex["none"] = param_05;
  level.finalkillcam_killcamentitystarttime["none"] = param_06;
  level.finalkillcam_killcamentitystickstovictim["none"] = param_07;
  level.finalkillcam_sweapon["none"] = param_08;
  level.var_6C62["none"] = param_09;
  level.finalkillcam_psoffsettime["none"] = param_0A;
  level.finalkillcam_timerecorded["none"] = scripts\mp\utility::getsecondspassed();
  level.finalkillcam_timegameended["none"] = scripts\mp\utility::getsecondspassed();
  level.finalkillcam_timegameended["none"] = scripts\mp\utility::getsecondspassed();
  level.finalkillcam_smeansofdeath["none"] = param_0B;
  level.finalkillcam_attackers["none"] = param_01.attackers;
  level.finalkillcam_attackerdata["none"] = param_01.attackerdata;
  level.finalkillcam_attackerperks["none"] = param_02.pers["loadoutPerks"];
  level.finalkillcam_killstreakvariantinfo["none"] = param_01.killsteakvariantattackerinfo;
  if(isDefined(param_04) && isagent(param_04)) {
    level.var_6C65["none"] = param_04.agent_type;
    level.var_6C66["none"] = param_04.lastspawntime;
    return;
  }

  level.var_6C65["none"] = undefined;
  level.var_6C66["none"] = undefined;
}

func_13716() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

func_13717(param_00) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait(param_00);
  self notify("killcam_death_done_waiting");
}

func_10266(param_00) {
  self endon("disconnect");
  if(level.showingfinalkillcam) {
    return 0;
  }

  if(!isai(self)) {
    thread func_13716();
    thread func_13717(param_00);
    var_01 = scripts\engine\utility::waittill_any_return("killcam_death_done_waiting", "killcam_death_button_cancel");
    if(var_01 == "killcam_death_done_waiting") {
      return 0;
    } else {
      return 1;
    }
  }

  return 0;
}

func_5854(param_00, param_01, param_02, param_03, param_04) {
  self endon("killcam_ended");
  if(isDefined(level.var_58D8)) {
    return;
  }

  level.var_58D8 = 1;
  var_05 = param_00.var_37F1;
  var_06 = 0;
  var_07 = param_03 getentitynumber();
  if(!isDefined(param_00.var_24FF)) {
    param_00.var_24FF = param_02 getentitynumber();
  }

  var_08 = var_05;
  if(var_08 > 1) {
    var_08 = 1;
    var_06 = var_06 + 1;
    wait(var_05 - var_06);
  }

  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_radio_3d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_narration_2d", 0);
  soundsettimescalefactor("voice_special_2d", 0);
  soundsettimescalefactor("voice_bchatter_1_3d", 0);
  soundsettimescalefactor("plr_ui_ingame_unres_2d", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.25);
  soundsettimescalefactor("reload_plr_res_2d", 0.3);
  soundsettimescalefactor("reload_plr_unres_2d", 0.3);
  soundsettimescalefactor("hurt_nofilter_2d", 0.15);
  soundsettimescalefactor("scn_fx_unres_3d", 0.15);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("scn_lfe_unres_3d", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0.15);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.15);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.15);
  soundsettimescalefactor("weap_npc_main_3d", 0.25);
  soundsettimescalefactor("weap_npc_mech_3d", 0.25);
  soundsettimescalefactor("weap_npc_mid_3d", 0.25);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.25);
  soundsettimescalefactor("weap_npc_lo_3d", 0.25);
  soundsettimescalefactor("melee_npc_3d", 0.25);
  soundsettimescalefactor("melee_plr_2d", 0.25);
  soundsettimescalefactor("special_hi_unres_1_3d", 0.15);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.15);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.2);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0.2);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("equip_use_unres_3d", 0.15);
  soundsettimescalefactor("shock1_nofilter_3d", 0.15);
  soundsettimescalefactor("explo_1_3d", 0.15);
  soundsettimescalefactor("explo_2_3d", 0.15);
  soundsettimescalefactor("explo_3_3d", 0.15);
  soundsettimescalefactor("explo_4_3d", 0.15);
  soundsettimescalefactor("explo_5_3d", 0.15);
  soundsettimescalefactor("explo_lfe_3d", 0.15);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.15);
  soundsettimescalefactor("projectile_loop_close", 0.15);
  soundsettimescalefactor("projectile_loop_mid", 0.15);
  soundsettimescalefactor("projectile_loop_dist", 0.15);
  setslowmotion(1, 0.25, var_08);
  wait(var_08 + 0.5);
  setslowmotion(0.25, 1, 1);
  level.var_58D8 = undefined;
}

anyplayersinkillcam() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.killcam)) {
      return 1;
    }
  }

  return 0;
}