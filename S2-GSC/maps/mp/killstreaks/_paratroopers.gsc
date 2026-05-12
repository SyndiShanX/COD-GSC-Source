/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_paratroopers.gsc
*************************************************/

func_00D5() {
  thread func_87A7();
  level.var_0611["paratrooper_landing"] = loadfx("vfx/code/paratrooper_land_medium");
  level.var_6E5E = getEntArray("paratrooper_bad_lz", "targetname");
  level.var_6E71 = [];
  setDvar("show_bad_paratrooper_origins", 0);
  thread offsets_setup();
}

func_2B05() {
  level endon("game_ended");
  if(!isDefined(level.var_14F4)) {
    return;
  }

  for(;;) {
    if(getdvarint("show_bad_paratrooper_origins")) {
      foreach(var_01 in level.var_14F4) {}
    }

    wait(1);
  }
}

func_87A7() {
  level.var_6E70 = 0;
  level.var_6E72 = 0;
  level.var_6E6A = ["default", "default", "cqb", "run_and_gun", "run_and_gun"];
  level.var_6E65 = [1, 1, 1, 1, 1];
  level.var_6E66 = ["veteran", "veteran", "veteran", "veteran", "veteran"];
  level.paratrooper_head = "mp_head_younger_r1c2";
  level.var_6E61 = ["raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute"];
  level.var_6E64 = ["raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute"];
  level.var_6E63 = ["human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d"];
  level.paratrooper_chute_loop_anim_duration = [2.17, 2.17, 2.17, 2.17, 2.17];
  level.var_6E62 = [1.25, 1.25, 1.25, 1.25, 1.25];
  level.paratrooper_chute_deploy_anims_vm = ["human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a"];
  level.paratrooper_chute_loop_anims_vm = ["human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a"];
  level.var_5A7D["agent_mp"] = "paratroopers";
  level.var_5A61["paratroopers"] = ::func_9E36;
  level.var_0A41["paratroopers"] = [];
  level.var_0A41["paratroopers"]["spawn"] = ::func_8FE1;
  level.var_0A41["paratroopers"]["think"] = ::func_6E69;
  level.var_0A41["paratroopers"]["on_killed"] = ::func_6AA6;
  while(!isDefined(level.var_0A41) || !isDefined(level.var_0A41["player"])) {
    wait 0.05;
  }

  level.var_0A41["paratroopers"]["on_damaged"] = level.var_0A41["player"]["on_damaged"];
  level.var_0A41["paratroopers"]["on_damaged_finished"] = level.var_0A41["player"]["on_damaged_finished"];
}

func_9E36(param_00) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(level.var_6E70 > 0) {
    self iclientprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
    return 0;
  }

  if(maps\mp\agents\_agent_utility::func_45BB("paratroopers") >= 1) {
    self iclientprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
    return 0;
  }

  var_01 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_02 = maps\mp\agents\_agent_utility::get_max_agents();
  if(maps\mp\agents\_agent_utility::func_45BB() >= var_02) {
    self iclientprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(!maps\mp\_utility::func_57A0(self)) {
    return 0;
  }

  if(isDefined(level.var_7043)) {
    foreach(var_04 in level.var_7043) {
      if(isDefined(var_04.var_01C8) && var_04.var_01C8 == "paratroopers") {
        self iclientprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
        return 0;
      }
    }
  }

  func_3B7C();
  if(!isDefined(self.var_6E68) || (!var_01 && self.var_6E68.size < 4) || var_01 && self.var_6E68.size < 5) {
    self iclientprintlnbold(&"KILLSTREAKS_NO_PARATROOPER_LZ");
    return 0;
  }

  self.var_6E71 = [];
  return func_A1EA(param_00, "paratroopers");
}

func_A1EA(param_00, param_01) {
  maps\mp\_matchdata::func_5E9A("paratroopers", self.var_0116);
  var_02 = lib_0527::func_4570();
  lib_0527::func_9302(param_00, [self.var_0116], [var_02], param_01);
  return 1;
}

func_3B7C() {
  if(level.var_53C6) {
    var_00 = getnodesinradiussorted(self.var_0116, 1000, 0, 2000, "Path");
  } else {
    var_00 = getnodesinradiussorted(self.var_0116, 700, 0, 128, "Path");
  }

  self.var_6E68 = [];
  foreach(var_02 in var_00) {
    if(isDefined(var_02) && nodeexposedtosky(var_02, 1)) {
      if(!func_5536(var_02.var_0116)) {
        self.var_6E68[self.var_6E68.size] = var_02;
      }
    }
  }

  var_04 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  if(var_04) {
    var_05 = 5;
  } else {
    var_05 = 4;
  }

  var_06 = 0;
  var_07 = self.var_6E68.size - 1;
  var_08 = [];
  while(var_07 >= 0 && var_06 < var_05) {
    var_09 = 1;
    for(var_0A = 0; var_09 == 1 && var_0A < var_08.size; var_0A++) {
      if(distance2d(self.var_6E68[var_07].var_0116, var_08[var_0A].var_0116) < 200) {
        var_09 = 0;
      }
    }

    if(var_09 == 1) {
      var_08[var_08.size] = self.var_6E68[var_07];
      var_06++;
    }

    var_07--;
  }

  self.var_6E68 = var_08;
}

func_5536(param_00) {
  if(isDefined(level.var_6E5E) && level.var_6E5E.size > 0) {
    foreach(var_02 in level.var_6E5E) {
      if(ispointinvolume(param_00, var_02)) {
        return 1;
      }
    }
  }

  if(isDefined(level.var_14F4)) {
    foreach(var_05 in level.var_14F4) {
      if(distance2dsquared(param_00, var_05) <= 90000) {
        return 1;
      }
    }
  }

  return 0;
}

func_A6E3(param_00, param_01, param_02) {
  param_00 endon("airstrike_complete");
  param_02 endon("disconnect");
  param_02 endon("joined_team");
  while(!lib_0527::func_34AE(param_00, param_00.var_34AC, param_01)) {
    wait 0.05;
  }

  param_00.var_6F2A = 1;
  param_02 thread func_8FE2();
}

func_8FE2() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  level.var_6E72 = 0;
  for(var_00 = 0; var_00 < self.var_6E68.size; var_00++) {
    var_01 = self.var_6E68[var_00].var_0116 + (0, 0, 2000);
    var_02 = self.var_6E68[var_00].var_001D;
    self.var_6E71 = common_scripts\utility::func_0FA0(self.var_6E71);
    var_03 = self.var_6E71.size;
    var_04 = [[level.var_0A4D]]("paratroopers", self.var_01A7, undefined, var_01, var_02, self, 0, 0, level.var_6E66[level.var_6E72]);
    if(!isDefined(var_04)) {
      continue;
    }

    self.var_6E71[var_03] = var_04;
    var_04 thread do_paratrooper_drop(level.var_6E72, self.var_6E68[var_00].var_0116[2]);
    level.var_6E72++;
    wait(0.3);
  }

  level.var_6E71 = self.var_6E71;
  level.var_6E70 = self.var_6E71.size;
  thread func_3694();
}

changeweaponusagestatewrapper(param_00) {
  if((!isDefined(self.playerparachuteweaponsenabled) && 1) || isDefined(self.playerparachuteweaponsenabled) && self.playerparachuteweaponsenabled == 1) {
    return;
  }

  maps\mp\_utility::func_3E8F(param_00);
  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    if(param_00) {
      if(!self method_85EB() && self getcurrentweapon() == "emote_weapon_mp") {
        self takeweapon("emote_weapon_mp");
        self switchtoweapon(self.var_7704);
        self method_8327();
        return;
      }

      return;
    }

    self giveweapon("emote_weapon_mp");
    self switchtoweaponimmediate("emote_weapon_mp");
    self setspawnweapon("emote_weapon_mp");
    self method_8326();
  }
}

func_A8D2(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  if(isscriptmodel(self)) {
    thread script_model_fake_gravity_fall_if_parachute_gone(param_00);
    while(self.var_0116[2] > param_00) {
      wait 0.05;
    }

    self scriptmodelplayanim("mp_smg_stand_jump_land_heavy", "finished_paratrooper_deploy");
  } else {
    while(!self isonground()) {
      if(isDefined(self.playerparachuteweaponsactiveatcertaindropheight) && self.var_0116[2] <= param_00 + self.playerparachuteweaponsactiveatcertaindropheight) {
        changeweaponusagestatewrapper(1);
      }

      wait 0.05;
    }

    if(isDefined(self.paratrooperinsertaccelerateddescent)) {
      self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
    }
  }

  if(isDefined(self) && !common_scripts\utility::func_562E(self.no_fx)) {
    playFX(level.var_0611["paratrooper_landing"], self.var_0116);
  }

  if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0) || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0) {
    self allowmovement(1);
  }

  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    self.var_6E6B = 0;
  }

  wait(0.5);
  if(isPlayer(self)) {
    if(!isDefined(self.playerparachuteweaponsactiveatcertaindropheight)) {
      changeweaponusagestatewrapper(1);
    }

    self method_8113(1);
    self method_8114(1);
    return;
  }

  if(function_01EF(self)) {
    self botsetflag("disable_attack", 0);
    self botsetflag("disable_movement", 0);
    self botsetflag("never_allow_aerial_targeting", 1);
  }
}

func_1132(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  var_02 = level.var_6E61[param_00];
  var_03 = level.var_6E63[param_00];
  var_04 = level.var_6E62[param_00];
  var_05 = level.paratrooper_chute_deploy_anims_vm[param_00];
  if(isscriptmodel(self)) {
    self.var_001D = self.var_001D - level.paratrooper_bindattach_to_animattach_delta_ang[param_00];
    dontinterpolatesafe();
  } else if(function_01EF(self)) {} else {
    self.angles_original = self.var_001D;
    self setangles(self.var_001D - level.paratrooper_bindattach_to_animattach_delta_ang[param_00]);
    dontinterpolatesafe();
  }

  self.var_6E4F = spawn("script_model", self.var_0116);
  self.var_6E4F.var_0117 = self;
  self.var_6E4F.deploy_time = gettime();
  self.var_6E4F.var_6E72 = param_00;
  thread func_4ADE(param_01);
  if((1 && isPlayer(self) && !isbot(self)) || (0 && isbot(self)) || common_scripts\utility::func_562E(self.force_vm)) {
    attach_parachute_model_vm();
  }

  if(isscriptmodel(self)) {
    func_988F(self.var_6E4F, "tag_attach", self.var_0116, self.var_001D);
    self.var_6E4F dontinterpolatesafe();
  } else if(function_01EF(self)) {
    self.var_001D = self.var_6E4F gettagangles("tag_attach");
    self.var_0116 = self.var_6E4F gettagorigin("tag_attach");
    dontinterpolatesafe();
  } else {
    func_988F(self.var_6E4F, "TAG_ATTACH", self.var_0116, self.var_001D);
    self.var_6E4F dontinterpolatesafe();
  }

  if(isscriptmodel(self)) {
    vm_model_linkto_if_needed();
    self linkto(self.var_6E4F, "tag_attach");
  } else if(function_01EF(self)) {
    self method_8388(self.var_6E4F, "tag_attach", 1);
  } else {
    vm_model_linkto_if_needed();
    self playerlinkto(self.var_6E4F, "tag_attach", 0, 180, 180, 180, 180, 1);
  }

  if(!common_scripts\utility::func_562E(param_01)) {
    if((1 || 0) && isDefined(self.var_6E4F.parachute_model_vm)) {
      self.var_6E4F.parachute_model_vm scriptmodelplayanim(var_02, "finished_paratrooper_deploy");
      self.var_6E4F.parachute_model_vm scriptmodelpauseanim(1);
    }

    if(1 && isDefined(self.var_6E4F.parachute_model_pitchingvm)) {
      self.var_6E4F.parachute_model_pitchingvm scriptmodelplayanim(var_05, "finished_paratrooper_deploy");
      self.var_6E4F.parachute_model_pitchingvm scriptmodelpauseanim(1);
    }

    self.var_6E4F scriptmodelplayanim(var_02, "finished_paratrooper_deploy");
    self.var_6E4F scriptmodelpauseanim(1);
    if(isscriptmodel(self)) {
      self scriptmodelplayanim("raids_paratrooper_drop_npc", "finished_paratrooper_deploy");
      self scriptmodelpauseanim(1);
    }
  }

  if(isPlayer(self) && isDefined(self.angles_original)) {
    self setangles(self.angles_original);
    dontinterpolatesafe();
    self.angles_original = undefined;
  }

  if(!common_scripts\utility::func_562E(param_01)) {
    self.var_6E4F scriptmodelpauseanim(0);
    if((1 || 0) && isDefined(self.var_6E4F.parachute_model_vm)) {
      self.var_6E4F.parachute_model_vm scriptmodelpauseanim(0);
    }

    if(1 && isDefined(self.var_6E4F.parachute_model_pitchingvm)) {
      self.var_6E4F.parachute_model_pitchingvm scriptmodelpauseanim(0);
    }

    if(isscriptmodel(self)) {
      self scriptmodelpauseanim(0);
    } else {
      self playerparachutestartdeploy();
    }
  }

  if(function_01EF(self) || isPlayer(self) && (!isDefined(self.playerparachutedamageenabled) && 0) || isDefined(self.playerparachutedamageenabled) && self.playerparachutedamageenabled) {
    var_06 = spawn("script_model", self.var_6E4F.var_0116);
    var_06.var_001D = self.var_6E4F.var_001D;
    var_06 setModel("ger_carepackage_parachute");
    var_06 setCanDamage(1);
    var_06 method_805C();
    var_06 method_8449(self.var_6E4F);
    self.var_6E4F.parachute_collision = var_06;
  }

  self.var_6E4F lib_0378::func_8D74("ks_paratroopers_parachute");
  thread func_A8D1(self.var_6E4F.parachute_collision);
  thread func_6E5F(self.var_6E4F.parachute_collision, var_03, var_04);
  thread play_idle_loop_when_ready(param_01, self.parachute_idle_starttime, self.parachute_idle_rate);
}

play_idle_loop_when_ready(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = level.var_6E64[self.var_6E4F.var_6E72];
  var_04 = level.paratrooper_chute_loop_anims_vm[self.var_6E4F.var_6E72];
  if(!common_scripts\utility::func_562E(param_00)) {
    self.var_6E4F waittill("finished_paratrooper_deploy");
  } else {
    waittillframeend;
  }

  self.var_6E4F.var_2D6A = 1;
  if(isscriptmodel(self)) {
    self scriptmodelplayanim("raids_paratrooper_loop_npc", "finished_paratrooper_deploy", param_01, param_02);
  } else {
    param_01 = param_01 + level.parachute_loop_anim_start_time_sec;
  }

  if(isDefined(self.var_6E4F)) {
    self.var_6E4F scriptmodelplayanim(var_03, "finished_paratrooper_loop", param_01, param_02);
    if((1 || 0) && isDefined(self.var_6E4F.parachute_model_vm)) {
      self.var_6E4F.parachute_model_vm scriptmodelplayanim(var_03, "finished_paratrooper_loop", param_01, param_02);
    }

    if(1 && isDefined(self.var_6E4F.parachute_model_pitchingvm)) {
      self.var_6E4F.parachute_model_pitchingvm scriptmodelplayanim(var_04, "finished_paratrooper_loop", param_01, param_02);
    }
  }
}

func_6E5F(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = self.var_6E4F;
  var_04 = self.var_01A7;
  var_05 = common_scripts\utility::func_A715("death", "paratrooper_released", "disconnect");
  if(isDefined(level.var_4E09)) {
    maps\mp\gametypes\_hostmigration::func_A782();
  }

  if(isDefined(self)) {
    self unlink();
  }

  var_03 notify("detach");
  if(isDefined(self) && isalive(self)) {
    self playerparachutesetactive(0);
    self setvelocity((0, 0, -150));
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }

  if(isDefined(var_03)) {
    thread parachute_cleanup_anim_then_delete(var_03, var_04, param_01, param_02);
  }

  if((1 || 0) && isDefined(self.var_6E4F.parachute_model_vm)) {
    var_03.parachute_model_vm delete();
  }

  if(1 && isDefined(self.var_6E4F.parachute_model_pitchingvm)) {
    thread parachute_cleanup_anim_then_delete(var_03.parachute_model_pitchingvm, var_04, param_01, param_02, 1);
  }
}

parachute_cleanup_anim_then_delete(param_00, param_01, param_02, param_03, param_04) {
  if(common_scripts\utility::func_562E(param_04)) {
    param_00 scriptmodelplayanim(param_02, "finished_parachute_detach");
  } else {
    param_00 method_8278(param_02, "finished_parachute_detach");
  }

  param_00 setmaterialscriptparam(1, 1, 0);
  if(param_01 == "allies") {
    param_00 setModel("usa_human_parachute_fade");
  } else {
    param_00 setModel("ger_human_parachute_fade");
  }

  var_05 = 1;
  param_00 setmaterialscriptparam(1, 0, var_05);
  param_00 common_scripts\utility::func_2CBE(param_03, ::delete);
}

func_A8D1(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  if(!isDefined(param_00)) {
    return;
  }

  if(isDefined(self.playerparachutehealth)) {
    param_00.var_22DF = self.playerparachutehealth;
  } else {
    param_00.var_22DF = 250;
  }

  for(;;) {
    param_00 waittill("damage", var_01, var_02);
    if(isDefined(var_02)) {
      if((level.var_984D && isDefined(var_02.var_01A7) && var_02.var_01A7 != self.var_01A7) || !level.var_984D && isDefined(self.var_0117) && var_02 != self.var_0117) {
        var_02 thread maps\mp\gametypes\_damagefeedback::func_A102("standard");
        self.var_6E4B = var_02;
        param_00.var_22DF = param_00.var_22DF - var_01;
        if(param_00.var_22DF <= 0) {
          if(isDefined(self.var_6E6B) && self.var_6E6B) {
            changeweaponusagestatewrapper(1);
            self dodamage(1, var_02.var_0116, var_02);
            self.var_5723 = 1;
            if(maps\mp\_utility::func_0649("specialty_falldamage")) {
              self.var_3A0F = 0.93;
            }

            if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0) || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0) {
              self allowmovement(0);
            }
          }

          self notify("paratrooper_released");
          return;
        }
      }
    }
  }
}

watchparatrooperinsertaccelerateddescent() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self.paratrooperinsertaccelerateddescent = 0;
  self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 1);
  while(!self isonground() && !self.var_5723) {
    if(self method_83C1()) {
      if(!self.paratrooperinsertaccelerateddescent) {
        self.paratrooperinsertaccelerateddescent = 1;
        self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
      }

      continue;
    }

    if(self.paratrooperinsertaccelerateddescent) {
      self.paratrooperinsertaccelerateddescent = 0;
      self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 1);
    }

    wait 0.05;
  }

  self.paratrooperinsertaccelerateddescent = 0;
  self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
}

watchforhostmigrationparachutemove(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");
  if(isDefined(self.var_0117)) {
    self.var_0117 endon("joined_team");
    self.var_0117 endon("joined_spectators");
  }

  level waittill("host_migration_begin");
  var_01 = gettime() * 0.001;
  self moveto(self.var_0116, 0.05);
  if(1 && isDefined(self.parachute_model_vm)) {
    self.parachute_model_vm moveto(self.var_0116, 0.05);
  }

  level waittill("host_migration_end");
  var_02 = param_00 - var_01;
  self moveto(self.var_4805, var_02);
  if(1 && isDefined(self.parachute_model_vm)) {
    self.parachute_model_vm moveto(self.var_4805, var_02);
  }
}

watchforparachutemovegoalchange(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");
  if(isDefined(self.var_0117)) {
    self.var_0117 endon("joined_team");
    self.var_0117 endon("joined_spectators");
  }

  self.var_0117 waittill("changeParachuteEndpoint", var_01);
  self.var_4805 = var_01 - self.var_0116 * 2 + self.var_0116;
  var_02 = gettime() * 0.001;
  var_03 = param_00 - var_02;
  self moveto(self.var_4805, var_03);
  if(1 && isDefined(self.parachute_model_vm)) {
    self.parachute_model_vm moveto(self.var_4805, var_03);
  }
}

func_64B8(param_00) {
  self endon("death");
  self endon("detach");
  var_01 = (0, 0, 0);
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = self.var_0117;
  var_06 = 2700;
  if(isDefined(var_05.playerparachutedropheight)) {
    var_06 = var_05.playerparachutedropheight;
  }

  var_07 = (0, 0, 0);
  var_08 = self.var_001D - var_05.var_001D;
  if(isDefined(var_05.var_6E6B) && var_05.var_6E6B) {
    var_05 thread watchparatrooperinsertaccelerateddescent();
  }

  for(;;) {
    if(isDefined(level.var_4E09)) {
      var_04 = (0, 0, 0);
    } else if(isDefined(param_00)) {
      var_04 = (0, 0, param_00);
    } else if(!isPlayer(var_05) && !isDefined(self.var_2D6A) || !self.var_2D6A) {
      var_04 = (0, 0, -25);
    } else if(isDefined(var_05) && var_05 playerads() > 0.5 && isDefined(var_05.playerparachutedropadsunitsperframeoverride)) {
      var_04 = (0, 0, var_05.playerparachutedropadsunitsperframeoverride);
    } else if(isDefined(var_05) && isDefined(var_05.paratrooperinsertaccelerateddescent) && var_05.paratrooperinsertaccelerateddescent && isDefined(var_05.playerparachutedropsprintingunitsperframeoverride)) {
      var_04 = (0, 0, var_05.playerparachutedropsprintingunitsperframeoverride);
    } else if(isDefined(var_05) && isDefined(var_05.playerparachutedropunitsperframeoverride)) {
      var_04 = (0, 0, var_05.playerparachutedropunitsperframeoverride);
    } else {
      var_04 = (0, 0, -15);
    }

    if(isalive(var_05) && isDefined(var_05) && isPlayer(var_05) && (!isDefined(var_05.playerparachutemovementenabled) && 1) || isDefined(var_05.playerparachutemovementenabled) && var_05.playerparachutemovementenabled) {
      var_09 = var_05 getnormalizedmovement();
      if(abs(var_09[0]) > 0.5 || abs(var_09[1]) > 0.5) {
        var_0A = (var_09[0], -1 * var_09[1], 0);
        var_0A = var_0A * 6.6675;
        var_01 = rotatevector(var_0A, var_05.var_001D);
        if(var_05 issprinting()) {
          var_01 = var_01 * 2;
        }

        var_04 = var_04 + var_01;
      }

      self.var_001D = var_05.var_001D + var_08;
      var_04 = applyplayercliptest(var_04, var_05, var_01);
      if((1 || 0) && isDefined(self.parachute_model_pitchingvm)) {
        match_vm_parachute(var_05, var_04, var_07);
      }
    }

    if(var_07 != var_04) {
      if(var_04 == (0, 0, 0)) {
        var_02 = (0, 0, 0);
        var_03 = 0.05;
      } else {
        var_0B = var_06 * 2;
        var_0C = var_0B / length(var_04);
        var_02 = var_04 * var_0C;
        var_03 = var_0C * 0.05;
      }

      self.var_4805 = self.var_0116 + var_02;
      self moveto(self.var_4805, var_03);
      if(1 && isDefined(self.parachute_model_vm)) {
        self.parachute_model_vm moveto(self.var_4805, var_03);
      }

      thread watchforhostmigrationparachutemove(gettime() * 0.001 + var_03);
      thread watchforparachutemovegoalchange(gettime() * 0.001 + var_03);
    }

    var_07 = var_04;
    wait 0.05;
  }
}

func_4ADE(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("detach");
  self endon("cancel_fadein");
  if(!common_scripts\utility::func_562E(param_00)) {
    self.var_6E4F setmaterialscriptparam(1, 1, 0);
    if(self.var_01A7 == "allies") {
      self.var_6E4F setModel("usa_human_parachute_fade");
    } else {
      self.var_6E4F setModel("ger_human_parachute_fade");
    }

    var_01 = 0.35;
    self.var_6E4F setmaterialscriptparam(0, 1, var_01);
    wait(var_01);
  }

  if(self.var_01A7 == "allies") {
    self.var_6E4F setModel("usa_human_parachute");
    return;
  }

  self.var_6E4F setModel("ger_human_parachute");
}

func_2605(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");
  var_01 = playerphysicstrace(self.var_0116, (self.var_0116[0], self.var_0116[1], self.var_0116[2] - 2700));
  for(;;) {
    if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 1) || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled) {
      var_02 = getgroundposition(self.var_0116, 8, 100, 0, 1);
      if(self.var_0116[2] < var_02[2] + 100) {
        break;
      }
    } else if(self.var_0116[2] < var_01[2] + 100) {
      break;
    }

    wait(0.1);
  }

  self notify("paratrooper_released");
}

func_8FE1(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("disconnect");
  while(!isDefined(level.var_4696)) {
    wait 0.05;
  }

  if(self.var_4B60) {
    wait(randomintrange(6, 10));
  }

  maps\mp\agents\_agent_utility::func_5334(1);
  if(isDefined(param_00) && isDefined(param_01)) {
    var_07 = param_00;
    var_08 = param_01;
    self.var_5BE0 = spawnStruct();
    self.var_5BE0.var_0116 = var_07;
    self.var_5BE0.var_001D = var_08;
  } else {
    self method_856C();
    var_09 = [[level.var_4696]]();
    var_07 = var_09.var_0116;
    var_08 = var_09.var_001D;
    self.var_5BE0 = var_09;
  }

  maps\mp\agents\_agent_utility::func_08A7();
  self.var_5CC6 = maps\mp\agents\_agent_utility::func_45AE(param_02.var_0109);
  self.var_5BE2 = gettime();
  if(level.var_984D) {
    var_0A["position"] = var_07;
    var_0A["time"] = self.var_5BE2;
    level.var_7AD4[self.var_01A7][level.var_7AD4[self.var_01A7].size] = var_0A;
  }

  var_0B = var_07 + (0, 0, 25);
  var_0C = var_07;
  var_0D = playerphysicstrace(var_0B, var_0C);
  if(distancesquared(var_0D, var_0B) > 1) {
    var_07 = var_0D;
  }

  self method_838F(var_07, var_08);
  if(isDefined(param_05)) {
    self.var_0A43 = param_05;
  }

  if(isDefined(self.var_0A43)) {
    if(self.var_0A43 == "follow_code_and_dev_dvar") {
      self[[level.var_19D5["bot_set_difficulty"]]](self botgetdifficulty(), 1);
    } else {
      self[[level.var_19D5["bot_set_difficulty"]]](param_05);
    }
  } else {
    self[[level.var_19D5["bot_set_difficulty"]]](self botgetdifficulty());
  }

  self[[level.var_19D5["bot_set_personality"]]](level.var_6E6A[level.var_6E72]);
  maps\mp\agents\_agent_common::func_83FD(getdvarint("scr_player_maxhealth", 100));
  if(isDefined(param_04) && param_04) {
    self.var_7DAD = 1;
  }

  if(isDefined(param_02)) {
    maps\mp\agents\_agent_utility::func_83FE(param_02.var_01A7, param_02);
  }

  if(isDefined(self.var_0117)) {
    self thread[[level.var_0A55]](self.var_0117);
  }

  thread maps\mp\_flashgrenades::func_6394();
  self method_83D6(0);
  if(isDefined(param_06)) {
    self.var_0BA6 = param_06;
    self method_858A(param_06);
    maps\mp\agents\_agent_common::func_83FD(getdvarint("scr_player_maxhealth", 100));
    maps\mp\gametypes\_class::func_4774();
  } else {
    self[[level.var_0A5B]]();
    maps\mp\gametypes\_class::func_4773(self.var_01A7, self.var_2319, 1);
  }

  self setperk("specialty_radarparatrooper", 1, 0);
  if(isDefined(self.var_0117) && self.var_0117 maps\mp\_utility::func_0649("specialty_improvedstreaks")) {
    maps\mp\_utility::func_47A2("specialty_sprintreload");
    maps\mp\_utility::func_47A2("specialty_fastreload");
    maps\mp\_utility::func_47A2("specialty_silentmovement");
    maps\mp\_utility::func_47A2("specialty_plainsight");
    maps\mp\_utility::func_47A2("specialty_stalker");
    maps\mp\_utility::func_47A2("specialty_reducedsway");
    maps\mp\_utility::func_47A2("specialty_fastermelee");
    maps\mp\_utility::func_47A2("specialty_silentkill");
    maps\mp\_utility::func_47A2("specialty_coldblooded");
    maps\mp\_utility::func_47A2("specialty_spygame");
    maps\mp\_utility::func_47A2("specialty_heartbreaker");
    maps\mp\_utility::func_47A2("specialty_uavhidden");
    maps\mp\_utility::func_47A2("specialty_delaymine");
    self.var_90DA = 6;
    maps\mp\_utility::func_47A2("specialty_paint");
    maps\mp\_utility::func_47A2("specialty_paint_pro");
    maps\mp\_utility::func_47A2("specialty_blastshield2");
    self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale", 35) / 100;
    if(isDefined(level.var_4B17) && level.var_4B17) {
      self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale_HC", 9) / 100;
    }

    maps\mp\_utility::func_47A2("specialty_stun_resistance");
    maps\mp\_utility::func_47A2("specialty_resistshellshock");
    maps\mp\_utility::func_47A2("specialty_immunesmoke");
    self.var_94BE = 0.1;
    maps\mp\_utility::func_47A2("specialty_fireshield");
    self.var_90D8 = maps\mp\_utility::func_4529("perk_fireShieldScale", 35) / 100;
    if(isDefined(level.var_4B17) && level.var_4B17) {
      self.var_90D8 = maps\mp\_utility::func_4529("perk_fireShieldScale_HC", 9) / 100;
    }
  }

  self thread[[level.var_19D5["bot_think_watch_enemy"]]](1);
  self thread[[level.var_19D5["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::func_0A59("think")]]();
  if(!self.var_4B60) {
    lib_050D::func_09FA();
  }

  thread maps\mp\gametypes\_weapons::func_9B90();
  self.var_4B60 = 0;
  thread maps\mp\gametypes\_healthoverlay::func_73FC();
  self.var_0009 = &"KILLSTREAKS_PARATROOPER";
  if(maps\mp\_utility::func_4571() != "mp_sandbox_01") {
    if(self.var_01A7 == "allies") {
      self setModel("usa_paratrooper_streak_org1_mp");
      self attach(level.paratrooper_head);
    } else {
      self setModel("ita_paratrooper_streak_org1_mp");
      self attach(level.paratrooper_head);
    }
  } else {
    self method_8528(13, self.var_01A7);
  }

  self botsetflag("disable_attack", 1);
  self botsetflag("disable_movement", 1);
  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

func_6E69() {
  self notify("paratrooper_think");
  self endon("paratrooper_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  for(;;) {
    self[[self.var_6F7F]]();
    wait 0.05;
  }
}

func_6AA6(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.var_6E4B) && !isPlayer(param_01) && !function_01EF(param_01) && param_03 == "MOD_FALLING") {
    param_01 = self.var_6E4B;
  }

  self[[level.var_0A5D]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, 1);
  var_09 = maps\mp\_events::func_43D6(param_04, param_03);
  if(isPlayer(param_01) && (!isDefined(self.var_0117) || param_01 != self.var_0117) && !isDefined(self.var_672C) || !self.var_672C) {
    if(var_09 == "kill") {
      maps\mp\gametypes\_damage::func_6B4B(param_01, param_04, param_03, param_02, "paratroopers_destroyed");
    } else {
      var_0A = func_5643(param_01);
      if(isDefined(var_0A)) {
        var_0A maps\mp\_utility::func_50EA(var_09, 1);
        level thread maps\mp\gametypes\_rank::func_1457(var_09, var_0A, param_04, undefined, param_03);
      }
    }
  }

  if(isDefined(level.var_6A75)) {
    [[level.var_6A75]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  thread maps\mp\gametypes\_weapons::func_34A9(param_01, param_03, param_04);
  if(self.var_565F) {
    self.var_4B60 = 1;
    if(maps\mp\_utility::func_44FC() != 1 && isDefined(self.var_7DAD) && self.var_7DAD) {
      self thread[[maps\mp\agents\_agent_utility::func_0A59("spawn")]]();
    } else {
      maps\mp\agents\_agent_utility::func_2A73();
    }
  }

  level.var_6E70--;
  if(level.var_6E70 <= 0) {
    level.var_6E72 = 0;
    if(isDefined(self.var_0117)) {
      self.var_0117 notify("paratroopers_ended");
    }
  }
}

func_5643(param_00) {
  var_01 = undefined;
  if(isDefined(param_00) && isDefined(self.var_0117)) {
    if(isDefined(param_00.var_0117) && isPlayer(param_00.var_0117)) {
      param_00 = param_00.var_0117;
    }

    if(param_00 == self.var_0117) {
      return;
    }

    if(issentient(self.var_0117) && issentient(param_00)) {
      if(!isalliedsentient(self.var_0117, param_00)) {
        var_01 = param_00;
      }
    } else if(level.var_984D) {
      if(self.var_0117.var_01A7 != param_00.var_01A7) {
        var_01 = param_00;
      }
    } else if(self.var_0117 != param_00) {
      var_01 = param_00;
    }
  }

  return var_01;
}

func_3694() {
  level endon("game_ended");
  self endon("paratroopers_ended");
  var_00 = common_scripts\utility::func_A71B(80, "disconnect", "joined_team");
  foreach(var_02 in self.var_6E71) {
    maps\mp\agents\_agent_utility::func_5A28(var_02);
  }

  level.var_6E71 = common_scripts\utility::func_0FA0(level.var_6E71);
}

do_paratrooper_drop(param_00, param_01, param_02, param_03) {
  func_1132(param_00, param_03);
  self.var_6E4F thread func_64B8(param_02);
  thread func_2605(param_01);
  thread func_A8D2(param_01);
}

isscriptmodel(param_00) {
  return isDefined(param_00.var_003A) && param_00.var_003A == "script_model";
}

script_model_fake_gravity_fall_if_parachute_gone(param_00) {
  self endon("death");
  while(isDefined(self getlinkedparent())) {
    wait 0.05;
  }

  var_01 = param_00 - 3 - self.var_0116[2];
  if(isDefined(self) && isDefined(self.playerparachutedropunitsperframeoverride)) {
    var_02 = self.playerparachutedropunitsperframeoverride;
  } else {
    var_02 = -15;
  }

  var_03 = abs(var_01 / var_02) * 0.05;
  var_04 = (self.var_0116[0], self.var_0116[1], param_00);
  self moveto(var_04, var_03);
}

paratroopers_beacon() {
  var_00 = self.var_0116;
  waittillframeend;
  var_01 = spawn("script_model", var_00 - (0, 0, 32));
  var_01 setModel("npc_soccer_ball_zombie_01");
  var_01 method_8511();
  var_01.var_0117 = self;
  var_01.isplayersteerable = 1;
  var_01 thread maps\mp\gametypes\_weapons::func_95A0();
  if(isDefined(var_01.var_359B["friendly"])) {
    function_014E(var_01.var_359B["friendly"], 0);
  }

  if(isDefined(var_01.var_359B["enemy"])) {
    function_014E(var_01.var_359B["enemy"], 0);
  }

  wait(7);
  maps\mp\perks\_perkfunctions::func_2D54(var_01);
}

applyplayercliptest(param_00, param_01, param_02) {
  var_03 = length2d(param_02);
  if(var_03 == 0) {
    return param_00;
  }

  var_04 = param_01.var_0116 + (0, 0, param_00[2]);
  var_05 = param_02 / var_03;
  var_04 = var_04 + var_05 * 15;
  var_06 = var_03 + 55 - 15;
  var_07 = var_04 + var_05 * var_06;
  var_08 = undefined;
  if(isDefined(self.parachute_collision)) {
    var_08 = function_0223(var_04, var_07, self.parachute_collision);
  } else {
    var_08 = function_0223(var_04, var_07);
  }

  if(var_08["fraction"] < 1) {
    param_00 = (0, 0, param_00[2]);
  }

  return param_00;
}

verify_player_paratrooper_position(param_00) {
  if(!isDefined(level.paratrooper_pos)) {
    level.paratrooper_pos_expire_time = -999;
    level.paratrooper_pos = [];
  }

  if(gettime() > level.paratrooper_pos_expire_time) {
    level.paratrooper_pos = [];
  }

  for(var_01 = 0; var_01 < level.paratrooper_pos.size; var_01++) {
    if(distance2d(level.paratrooper_pos[var_01], param_00) < 80) {
      param_00 = level.paratrooper_pos[var_01] + (0, 0, 130);
      level.paratrooper_pos[var_01] = param_00;
      level.paratrooper_pos_expire_time = gettime() + 2000;
      return param_00;
    }
  }

  level.paratrooper_pos[level.paratrooper_pos.size] = param_00;
  level.paratrooper_pos_expire_time = gettime() + 2000;
  return param_00;
}

player_paratrooper(param_00, param_01, param_02) {
  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.var_6E4F) && isDefined(self.var_6E4F.deploy_time) && gettime() == self.var_6E4F.deploy_time) {
    return;
  }

  var_03 = undefined;
  if(0) {
    thread paratroopers_beacon();
  }

  if(isDefined(param_00)) {
    var_03 = param_00;
  } else {
    var_03 = self.var_0116;
  }

  var_04 = 2700;
  if(isDefined(self.playerparachutedropheight)) {
    var_04 = self.playerparachutedropheight;
  }

  var_05 = var_03 + (0, 0, var_04);
  var_06 = verify_player_paratrooper_position(var_05);
  self setorigin(var_06);
  dontinterpolatesafe();
  var_07 = randomint(level.var_6E61.size);
  changeweaponusagestatewrapper(0);
  if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0) || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0) {
    self allowmovement(0);
  }

  self method_8113(0);
  self method_8114(0);
  lib_0378::func_8D74("aud_player_parachute_open");
  lib_0378::func_8D74("aud_player_parachute_submix");
  do_paratrooper_drop(var_07, var_03[2], param_01, param_02);
}

player_paratroopers_spawn_thread(param_00, param_01, param_02) {
  if(!isDefined(level.var_6E71)) {}

  level endon("game_ended");
  if(isDefined(param_01)) {
    level endon(param_01);
  }

  if(isDefined(param_02) && param_02) {
    foreach(var_04 in level.var_744A) {
      if((!isDefined(param_00) || var_04.var_01A7 == param_00) && !isDefined(var_04.var_0178) || var_04.var_0178 != "spectator") {
        var_05 = undefined;
        if(maps\mp\_utility::func_579B() && isDefined(var_04.spawnpos_postraidvignette)) {
          var_05 = var_04.spawnpos_postraidvignette;
        } else {
          var_05 = var_04.var_9092;
        }

        var_04 thread player_paratrooper(var_05);
        var_04 lib_0378::func_8D74("aud_player_parachute_open");
        var_04 lib_0378::func_8D74("aud_player_parachute_submix");
      }
    }
  }

  for(;;) {
    level waittill("player_spawned", var_06);
    if(!isDefined(param_02) || var_06.var_01A7 == param_02 || param_02 == "all") {
      var_06 thread player_paratrooper();
      var_06 lib_0378::func_8D74("aud_player_parachute_open");
      var_06 lib_0378::func_8D74("aud_player_parachute_submix");
    }
  }
}

player_paratroopers_spawn_after_raidvignette(param_00) {
  maps\mp\_utility::func_3FA5("finished_intro_vignette_" + param_00);
  var_01 = param_00;
  if(game["switchedsides"]) {
    var_01 = maps\mp\_utility::func_45DE(param_00);
  }

  thread player_paratroopers_spawn_thread(var_01, "kill_paratroopers_thread", 1);
  wait(3);
  level notify("kill_paratroopers_thread");
}

showtoallexceptplayer(param_00) {
  self method_805B();
  self hidefromclient(param_00);
}

hidefromallexceptplayer(param_00) {
  self method_805C();
  self showtoclient(param_00);
}

attach_parachute_model_vm() {
  if(isPlayer(self)) {
    self.var_6E4F thread showtoallexceptplayer(self);
  }

  if(1) {
    var_00 = spawn("script_model", self.var_6E4F.var_0116);
    if(self.var_01A7 == "allies") {
      var_00 setModel("usa_human_parachute");
    } else {
      var_00 setModel("ger_human_parachute");
    }

    var_00.var_001D = self.var_6E4F.var_001D;
    if(isPlayer(self)) {
      var_00 thread hidefromallexceptplayer(self);
    }

    self.var_6E4F.parachute_model_pitchingvm = var_00;
  }

  var_01 = spawn("script_model", self.var_6E4F.var_0116);
  if(self.var_01A7 == "allies") {
    var_01 setModel("usa_human_parachute_fade");
  } else {
    var_01 setModel("ger_human_parachute_fade");
  }

  var_01.var_001D = self.var_6E4F.var_001D;
  if(isPlayer(self)) {
    var_01 thread hidefromallexceptplayer(self);
  }

  var_01 setmaterialscriptparam(0, 0, 0.1);
  self.var_6E4F.parachute_model_vm = var_01;
}

offsets_setup() {
  level.parachute_loop_anim_start_time_sec = 2.3;
  foreach(var_02, var_01 in level.var_6E61) {
    thread get_offset_for_single(var_02);
  }
}

get_offset_for_single(param_00) {
  var_01 = (0, 0, 0);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("usa_human_parachute");
  var_03 = spawn("script_model", var_01);
  var_03 setModel("usa_human_parachute");
  var_04 = level.var_6E64[param_00];
  var_05 = level.paratrooper_chute_loop_anims_vm[param_00];
  var_06 = var_02 gettagorigin("TAG_ATTACH");
  var_07 = var_02 gettagangles("TAG_ATTACH");
  var_02 scriptmodelplayanim(var_04, "finished_paratrooper_deploy", 0.0001);
  var_02 scriptmodelpauseanim(1);
  var_03 scriptmodelplayanim(var_05, "finished_paratrooper_deploy", 0.0001);
  var_03 scriptmodelpauseanim(1);
  wait 0.05;
  var_08 = var_02 gettagorigin("TAG_ATTACH");
  var_09 = var_02 gettagangles("TAG_ATTACH");
  level.paratrooper_bindattach_to_animattach_delta_ang[param_00] = var_09 - var_07;
  var_0A = var_03 gettagorigin("TAG_ATTACH");
  var_0B = var_03 gettagangles("TAG_ATTACH");
  var_02 delete();
  var_03 delete();
}

func_988F(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = param_00.var_0116;
  var_06 = param_00.var_001D;
  var_07 = invertangles(var_06);
  if(isDefined(param_01)) {
    var_04 = param_00 gettagangles(param_01);
  } else {
    var_04 = param_00.var_001D;
  }

  var_08 = invertangles(var_04);
  var_09 = combineangles(param_03, var_08);
  var_0A = combineangles(param_00.var_001D, var_09);
  var_0B = undefined;
  if(isDefined(param_01)) {
    var_0C = param_00 gettagorigin(param_01) - var_05;
    var_0B = rotatevector(var_0C, var_07);
  } else {
    var_0B = (0, 0, 0);
  }

  var_0D = rotatevector(var_0B, var_0A);
  param_00 dontinterpolatesafe();
  param_00.var_0116 = param_02 - var_0D;
  param_00.var_001D = var_0A;
  return [param_02, var_0A];
}

rotate_ent_relative_to(param_00, param_01, param_02, param_03, param_04) {
  level.original_ent_angles = param_01;
  level.ref_orientation = param_03;
  level.rotation_from_ref = param_04;
  level.inverted_ref_orientations = invertangles(level.ref_orientation);
  level.ent_angles_in_refspace = combineangles(level.original_ent_angles, level.inverted_ref_orientations);
  level.desired_ent_angles_in_refspace = combineangles(level.rotation_from_ref, level.ent_angles_in_refspace);
  level.desired_ent_angles_in_worldspace = combineangles(level.ref_orientation, level.desired_ent_angles_in_refspace);
  level.original_ent_origin = param_00;
  level.ent_to_ref_origin_diff_in_worldspace = level.original_ent_origin - param_02;
  level.ent_to_ref_origin_diff_in_refspace = rotatevector(level.ent_to_ref_origin_diff_in_worldspace, level.inverted_ref_orientations);
  level.desired_ent_to_ref_origin_diff_in_refspace = rotatevector(level.ent_to_ref_origin_diff_in_refspace, level.rotation_from_ref);
  level.desired_ent_to_ref_origin_diff_in_worldspace = rotatevector(level.desired_ent_to_ref_origin_diff_in_refspace, level.ref_orientation);
  return [param_02 + level.desired_ent_to_ref_origin_diff_in_worldspace, level.desired_ent_angles_in_worldspace];
}

match_vm_parachute(param_00, param_01, param_02) {
  self.parachute_model_vm.var_001D = self.var_001D;
}

vm_model_linkto_if_needed() {
  if(1 && isDefined(self.var_6E4F.parachute_model_pitchingvm)) {
    self.var_6E4F.parachute_model_pitchingvm method_8405(self, undefined, (0, 0, -60), (0, 0, 0), 2, 0, 0, 0);
  }

  if((1 || 0) && isDefined(self.var_6E4F.parachute_model_vm)) {
    func_988F(self.var_6E4F.parachute_model_vm, "TAG_ATTACH", self.var_0116, self.var_001D);
  }
}

func_0DDE(param_00) {
  var_01 = (angleclamp180(param_00[0]), angleclamp180(param_00[1]), angleclamp180(param_00[2]));
  return var_01;
}

dontinterpolatesafe() {
  if(!isDefined(self.dontinterpolate_timestamp) || gettime() > self.dontinterpolate_timestamp) {
    self.dontinterpolate_timestamp = gettime();
    self method_808C();
  }
}