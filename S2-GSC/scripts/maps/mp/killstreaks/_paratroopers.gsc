/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_paratroopers.gsc
*********************************************************/

init() {
  thread _id_87A7();
  level._effect["paratrooper_landing"] = loadfx("vfx/code/paratrooper_land_medium");
  level._id_6E5E = getEntArray("paratrooper_bad_lz", "targetname");
  level._id_6E71 = [];
  setDvar("show_bad_paratrooper_origins", 0);
  thread offsets_setup();
}

_id_2B05() {
  level endon("game_ended");

  if(!isDefined(level._id_14F4)) {
    return;
  }
  for(;;) {
    if(getdvarint("show_bad_paratrooper_origins")) {
      foreach(var_1 in level._id_14F4) {}
    }

    wait 1;
  }
}

_id_87A7() {
  level._id_6E70 = 0;
  level._id_6E72 = 0;
  level._id_6E6A = ["default", "default", "cqb", "run_and_gun", "run_and_gun"];
  level._id_6E65 = [1, 1, 1, 1, 1];
  level._id_6E66 = ["veteran", "veteran", "veteran", "veteran", "veteran"];
  level.paratrooper_head = "mp_head_younger_r1c2";
  level._id_6E61 = ["raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute", "raids_paratrooper_drop_parachute"];
  level._id_6E64 = ["raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute", "raids_paratrooper_loop_parachute"];
  level._id_6E63 = ["human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d", "human_parachute_detach_d"];
  level.paratrooper_chute_loop_anim_duration = [2.17, 2.17, 2.17, 2.17, 2.17];
  level._id_6E62 = [1.25, 1.25, 1.25, 1.25, 1.25];
  level.paratrooper_chute_deploy_anims_vm = ["human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a", "human_parachute_raids_deploy_a"];
  level.paratrooper_chute_loop_anims_vm = ["human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a", "human_parachute_raids_loop_a"];
  level._id_5A7D["agent_mp"] = "paratroopers";
  level._id_5A61["paratroopers"] = ::_id_9E36;
  level._id_0A41["paratroopers"] = [];
  level._id_0A41["paratroopers"]["spawn"] = ::_id_8FE1;
  level._id_0A41["paratroopers"]["think"] = ::_id_6E69;
  level._id_0A41["paratroopers"]["on_killed"] = ::_id_6AA6;

  while(!isDefined(level._id_0A41) || !isDefined(level._id_0A41["player"]))
    waitframe();

  level._id_0A41["paratroopers"]["on_damaged"] = level._id_0A41["player"]["on_damaged"];
  level._id_0A41["paratroopers"]["on_damaged_finished"] = level._id_0A41["player"]["on_damaged_finished"];
}

_id_9E36(var_0) {
  if(maps\mp\_utility::_id_5668())
    return 0;

  if(level._id_6E70 > 0) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
    return 0;
  }

  if(maps\mp\agents\_agent_utility::_id_45BB("paratroopers") >= 1) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
    return 0;
  }

  var_1 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_2 = maps\mp\agents\_agent_utility::get_max_agents();

  if(maps\mp\agents\_agent_utility::_id_45BB() >= var_2) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self))
    return 0;

  if(isDefined(level._id_7043)) {
    foreach(var_4 in level._id_7043) {
      if(isDefined(var_4._id_01C8) && var_4._id_01C8 == "paratroopers") {
        self iprintlnbold(&"KILLSTREAKS_TOO_MANY_PARATROOPERS");
        return 0;
      }
    }
  }

  _id_3B7C();

  if(!isDefined(self._id_6E68) || !var_1 && self._id_6E68.size < 4 || var_1 && self._id_6E68.size < 5) {
    self iprintlnbold(&"KILLSTREAKS_NO_PARATROOPER_LZ");
    return 0;
  }

  self._id_6E71 = [];
  return _id_A1EA(var_0, "paratroopers");
}

_id_A1EA(var_0, var_1) {
  _id_0485::_id_5E9A("paratroopers", self.origin);
  var_2 = _id_0527::_id_4570();
  _id_0527::_id_9302(var_0, [self.origin], [var_2], var_1);
  return 1;
}

_id_3B7C() {
  if(level._id_53C6)
    var_0 = _getnodesinradiussorted(self.origin, 1000, 0, 2000, "Path");
  else
    var_0 = _getnodesinradiussorted(self.origin, 700, 0, 128, "Path");

  self._id_6E68 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && _nodeexposedtosky(var_2, 1)) {
      if(!_id_5536(var_2.origin))
        self._id_6E68[self._id_6E68.size] = var_2;
    }
  }

  var_4 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  if(var_4)
    var_5 = 5;
  else
    var_5 = 4;

  var_6 = 0;
  var_7 = self._id_6E68.size - 1;

  for(var_8 = []; var_7 >= 0 && var_6 < var_5; var_7--) {
    var_9 = 1;

    for(var_10 = 0; var_9 == 1 && var_10 < var_8.size; var_10++) {
      if(_distance2d(self._id_6E68[var_7].origin, var_8[var_10].origin) < 200)
        var_9 = 0;
    }

    if(var_9 == 1) {
      var_8[var_8.size] = self._id_6E68[var_7];
      var_6++;
    }
  }

  self._id_6E68 = var_8;
}

_id_5536(var_0) {
  if(isDefined(level._id_6E5E) && level._id_6E5E.size > 0) {
    foreach(var_2 in level._id_6E5E) {
      if(_ispointinvolume(var_0, var_2))
        return 1;
    }
  }

  if(isDefined(level._id_14F4)) {
    foreach(var_5 in level._id_14F4) {
      if(_distance2dsquared(var_0, var_5) <= 90000.0)
        return 1;
    }
  }

  return 0;
}

_id_A6E3(var_0, var_1, var_2) {
  var_0 endon("airstrike_complete");
  var_2 endon("disconnect");
  var_2 endon("joined_team");

  while(!_id_0527::_id_34AE(var_0, var_0._id_34AC, var_1))
    waitframe();

  var_0._id_6F2A = 1;
  var_2 thread _id_8FE2();
}

_id_8FE2() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  level._id_6E72 = 0;

  for(var_0 = 0; var_0 < self._id_6E68.size; var_0++) {
    var_1 = self._id_6E68[var_0].origin + (0, 0, 2000);
    var_2 = self._id_6E68[var_0].angles;
    self._id_6E71 = common_scripts\utility::_id_0FA0(self._id_6E71);
    var_3 = self._id_6E71.size;
    var_4 = [[level._id_0A4D]]("paratroopers", self.team, undefined, var_1, var_2, self, 0, 0, level._id_6E66[level._id_6E72]);

    if(!isDefined(var_4)) {
      continue;
    }
    self._id_6E71[var_3] = var_4;
    var_4 thread do_paratrooper_drop(level._id_6E72, self._id_6E68[var_0].origin[2]);
    level._id_6E72++;
    wait 0.3;
  }

  level._id_6E71 = self._id_6E71;
  level._id_6E70 = self._id_6E71.size;
  thread _id_3694();
}

changeweaponusagestatewrapper(var_0) {
  if(!isDefined(self.playerparachuteweaponsenabled) && 1 || isDefined(self.playerparachuteweaponsenabled) && self.playerparachuteweaponsenabled == 1) {
    return;
  }
  maps\mp\_utility::_id_3E8F(var_0);

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    if(var_0) {
      if(!self _meth_85EB() && self getcurrentweapon() == "emote_weapon_mp") {
        self takeweapon("emote_weapon_mp");
        self switchtoweapon(self.primaryweapon);
        self enableweaponswitch();
      }
    } else {
      self giveweapon("emote_weapon_mp");
      self switchtoweaponimmediate("emote_weapon_mp");
      self setspawnweapon("emote_weapon_mp");
      self disableweaponswitch();
    }
  }
}

_id_A8D2(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isscriptmodel(self)) {
    thread script_model_fake_gravity_fall_if_parachute_gone(var_0);

    while(self.origin[2] > var_0)
      waitframe();

    self scriptmodelplayanim("mp_smg_stand_jump_land_heavy", "finished_paratrooper_deploy");
  } else {
    while(!self isonground()) {
      if(isDefined(self.playerparachuteweaponsactiveatcertaindropheight) && self.origin[2] <= var_0 + self.playerparachuteweaponsactiveatcertaindropheight)
        changeweaponusagestatewrapper(1);

      waitframe();
    }

    if(isDefined(self.paratrooperinsertaccelerateddescent))
      self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
  }

  if(isDefined(self) && !common_scripts\utility::_id_562E(self.no_fx))
    playFX(level._effect["paratrooper_landing"], self.origin);

  if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0 || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0))
    self _meth_8546(1);

  if(isDefined(self._id_6E6B) && self._id_6E6B)
    self._id_6E6B = 0;

  wait 0.5;

  if(isPlayer(self)) {
    if(!isDefined(self.playerparachuteweaponsactiveatcertaindropheight))
      changeweaponusagestatewrapper(1);

    self allowcrouch(1);
    self allowprone(1);
  } else if(_isagent(self)) {
    self botsetflag("disable_attack", 0);
    self botsetflag("disable_movement", 0);
    self botsetflag("never_allow_aerial_targeting", 1);
  }
}

_id_1132(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  var_2 = level._id_6E61[var_0];
  var_3 = level._id_6E63[var_0];
  var_4 = level._id_6E62[var_0];
  var_5 = level.paratrooper_chute_deploy_anims_vm[var_0];

  if(isscriptmodel(self)) {
    self.angles = self.angles - level.paratrooper_bindattach_to_animattach_delta_ang[var_0];
    dontinterpolatesafe();
  } else if(_isagent(self)) {} else {
    self.angles_original = self.angles;
    self setplayerangles(self.angles - level.paratrooper_bindattach_to_animattach_delta_ang[var_0]);
    dontinterpolatesafe();
  }

  self._id_6E4F = spawn("script_model", self.origin);
  self._id_6E4F._id_0117 = self;
  self._id_6E4F.deploy_time = gettime();
  self._id_6E4F._id_6E72 = var_0;
  thread _id_4ADE(var_1);

  if(1 && isPlayer(self) && !isbot(self) || 0 && isbot(self) || common_scripts\utility::_id_562E(self.force_vm))
    attach_parachute_model_vm();

  if(isscriptmodel(self)) {
    _id_988F(self._id_6E4F, "tag_attach", self.origin, self.angles);
    self._id_6E4F dontinterpolatesafe();
  } else if(_isagent(self)) {
    self.angles = self._id_6E4F gettagangles("tag_attach");
    self.origin = self._id_6E4F gettagorigin("tag_attach");
    dontinterpolatesafe();
  } else {
    _id_988F(self._id_6E4F, "TAG_ATTACH", self.origin, self.angles);
    self._id_6E4F dontinterpolatesafe();
  }

  if(isscriptmodel(self)) {
    vm_model_linkto_if_needed();
    self linkto(self._id_6E4F, "tag_attach");
  } else if(_isagent(self))
    self _meth_8388(self._id_6E4F, "tag_attach", 1);
  else {
    vm_model_linkto_if_needed();
    self playerlinkto(self._id_6E4F, "tag_attach", 0, 180, 180, 180, 180, 1);
  }

  if(!common_scripts\utility::_id_562E(var_1)) {
    if((1 || 0) && isDefined(self._id_6E4F.parachute_model_vm)) {
      self._id_6E4F.parachute_model_vm scriptmodelplayanim(var_2, "finished_paratrooper_deploy");
      self._id_6E4F.parachute_model_vm setshadowrendering(1);
    }

    if(1 && isDefined(self._id_6E4F.parachute_model_pitchingvm)) {
      self._id_6E4F.parachute_model_pitchingvm scriptmodelplayanim(var_5, "finished_paratrooper_deploy");
      self._id_6E4F.parachute_model_pitchingvm setshadowrendering(1);
    }

    self._id_6E4F scriptmodelplayanim(var_2, "finished_paratrooper_deploy");
    self._id_6E4F setshadowrendering(1);

    if(isscriptmodel(self)) {
      self scriptmodelplayanim("raids_paratrooper_drop_npc", "finished_paratrooper_deploy");
      self setshadowrendering(1);
    }
  }

  if(isPlayer(self) && isDefined(self.angles_original)) {
    self setplayerangles(self.angles_original);
    dontinterpolatesafe();
    self.angles_original = undefined;
  }

  if(!common_scripts\utility::_id_562E(var_1)) {
    self._id_6E4F setshadowrendering(0);

    if((1 || 0) && isDefined(self._id_6E4F.parachute_model_vm))
      self._id_6E4F.parachute_model_vm setshadowrendering(0);

    if(1 && isDefined(self._id_6E4F.parachute_model_pitchingvm))
      self._id_6E4F.parachute_model_pitchingvm setshadowrendering(0);

    if(isscriptmodel(self))
      self setshadowrendering(0);
    else
      self _meth_800B();
  }

  if(_isagent(self) || isPlayer(self) && (!isDefined(self.playerparachutedamageenabled) && 0 || isDefined(self.playerparachutedamageenabled) && self.playerparachutedamageenabled)) {
    var_6 = spawn("script_model", self._id_6E4F.origin);
    var_6.angles = self._id_6E4F.angles;
    var_6 setModel("ger_carepackage_parachute");
    var_6 setcandamage(1);
    var_6 hide();
    var_6 linktosynchronizedparent(self._id_6E4F);
    self._id_6E4F.parachute_collision = var_6;
  }

  self._id_6E4F _id_0378::_id_8D74("ks_paratroopers_parachute");
  thread _id_A8D1(self._id_6E4F.parachute_collision);
  thread _id_6E5F(self._id_6E4F.parachute_collision, var_3, var_4);
  thread play_idle_loop_when_ready(var_1, self.parachute_idle_starttime, self.parachute_idle_rate);
}

play_idle_loop_when_ready(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = level._id_6E64[self._id_6E4F._id_6E72];
  var_4 = level.paratrooper_chute_loop_anims_vm[self._id_6E4F._id_6E72];

  if(!common_scripts\utility::_id_562E(var_0))
    self._id_6E4F waittill("finished_paratrooper_deploy");
  else
    waittillframeend;

  self._id_6E4F._id_2D6A = 1;

  if(isscriptmodel(self))
    self scriptmodelplayanim("raids_paratrooper_loop_npc", "finished_paratrooper_deploy", var_1, var_2);
  else
    var_1 = var_1 + level.parachute_loop_anim_start_time_sec;

  if(isDefined(self._id_6E4F)) {
    self._id_6E4F scriptmodelplayanim(var_3, "finished_paratrooper_loop", var_1, var_2);

    if((1 || 0) && isDefined(self._id_6E4F.parachute_model_vm))
      self._id_6E4F.parachute_model_vm scriptmodelplayanim(var_3, "finished_paratrooper_loop", var_1, var_2);

    if(1 && isDefined(self._id_6E4F.parachute_model_pitchingvm))
      self._id_6E4F.parachute_model_pitchingvm scriptmodelplayanim(var_4, "finished_paratrooper_loop", var_1, var_2);
  }
}

_id_6E5F(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = self._id_6E4F;
  var_4 = self.team;
  var_5 = common_scripts\utility::waittill_any_return("death", "paratrooper_released", "disconnect");

  if(isDefined(level.hostmigrationtimer))
    maps\mp\gametypes\_hostmigration::_id_A782();

  if(isDefined(self))
    self unlink();

  var_3 notify("detach");

  if(isDefined(self) && isalive(self)) {
    self _meth_8009(0);
    self setvelocity((0, 0, -150));
  }

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_3))
    thread parachute_cleanup_anim_then_delete(var_3, var_4, var_1, var_2);

  if((1 || 0) && isDefined(self._id_6E4F.parachute_model_vm))
    var_3.parachute_model_vm delete();

  if(1 && isDefined(self._id_6E4F.parachute_model_pitchingvm))
    thread parachute_cleanup_anim_then_delete(var_3.parachute_model_pitchingvm, var_4, var_1, var_2, 1);
}

parachute_cleanup_anim_then_delete(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_562E(var_4))
    var_0 scriptmodelplayanim(var_2, "finished_parachute_detach");
  else
    var_0 scriptmodelplayanimdeltamotion(var_2, "finished_parachute_detach");

  var_0 _meth_8450(1, 1, 0);

  if(var_1 == "allies")
    var_0 setModel("usa_human_parachute_fade");
  else
    var_0 setModel("ger_human_parachute_fade");

  var_5 = 1;
  var_0 _meth_8450(1, 0, var_5);
  var_0 common_scripts\utility::_id_2CBE(var_3, ::delete);
}

_id_A8D1(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.playerparachutehealth))
    var_0._id_22DF = self.playerparachutehealth;
  else
    var_0._id_22DF = 250;

  for(;;) {
    var_0 waittill("damage", var_1, var_2);

    if(isDefined(var_2)) {
      if(level.teambased && isDefined(var_2.team) && var_2.team != self.team || !level.teambased && isDefined(self._id_0117) && var_2 != self._id_0117) {
        var_2 thread _id_04C7::_id_A102("standard");
        self._id_6E4B = var_2;
        var_0._id_22DF = var_0._id_22DF - var_1;

        if(var_0._id_22DF <= 0) {
          if(isDefined(self._id_6E6B) && self._id_6E6B) {
            changeweaponusagestatewrapper(1);
            self dodamage(1, var_2.origin, var_2);
            self._id_5723 = 1;

            if(maps\mp\_utility::_hasperk("specialty_falldamage"))
              self._id_3A0F = 0.93;

            if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0 || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0))
              self _meth_8546(0);
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

  while(!self isonground() && !self._id_5723) {
    if(self sprintbuttonpressed()) {
      if(!self.paratrooperinsertaccelerateddescent) {
        self.paratrooperinsertaccelerateddescent = 1;
        self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
      }
    } else if(self.paratrooperinsertaccelerateddescent) {
      self.paratrooperinsertaccelerateddescent = 0;
      self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 1);
    }

    waitframe();
  }

  self.paratrooperinsertaccelerateddescent = 0;
  self setclientomnvar("ui_show_paratrooper_insert_descent_prompt", 0);
}

watchforhostmigrationparachutemove(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");

  if(isDefined(self._id_0117)) {
    self._id_0117 endon("joined_team");
    self._id_0117 endon("joined_spectators");
  }

  level waittill("host_migration_begin");
  var_1 = gettime() * 0.001;
  self moveto(self.origin, 0.05);

  if(1 && isDefined(self.parachute_model_vm))
    self.parachute_model_vm moveto(self.origin, 0.05);

  level waittill("host_migration_end");
  var_2 = var_0 - var_1;
  self moveto(self._id_4805, var_2);

  if(1 && isDefined(self.parachute_model_vm))
    self.parachute_model_vm moveto(self._id_4805, var_2);
}

watchforparachutemovegoalchange(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");

  if(isDefined(self._id_0117)) {
    self._id_0117 endon("joined_team");
    self._id_0117 endon("joined_spectators");
  }

  self._id_0117 waittill("changeParachuteEndpoint", var_1);
  self._id_4805 = (var_1 - self.origin) * 2 + self.origin;
  var_2 = gettime() * 0.001;
  var_3 = var_0 - var_2;
  self moveto(self._id_4805, var_3);

  if(1 && isDefined(self.parachute_model_vm))
    self.parachute_model_vm moveto(self._id_4805, var_3);
}

_id_64B8(var_0) {
  self endon("death");
  self endon("detach");
  var_1 = (0, 0, 0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = self._id_0117;
  var_6 = 2700;

  if(isDefined(var_5.playerparachutedropheight))
    var_6 = var_5.playerparachutedropheight;

  var_7 = (0, 0, 0);
  var_8 = self.angles - var_5.angles;

  if(isDefined(var_5._id_6E6B) && var_5._id_6E6B)
    var_5 thread watchparatrooperinsertaccelerateddescent();

  for(;;) {
    if(isDefined(level.hostmigrationtimer))
      var_4 = (0, 0, 0);
    else if(isDefined(var_0))
      var_4 = (0, 0, var_0);
    else if(!isPlayer(var_5) && (!isDefined(self._id_2D6A) || !self._id_2D6A))
      var_4 = (0, 0, -25);
    else if(isDefined(var_5) && var_5 playerads() > 0.5 && isDefined(var_5.playerparachutedropadsunitsperframeoverride))
      var_4 = (0, 0, var_5.playerparachutedropadsunitsperframeoverride);
    else if(isDefined(var_5) && isDefined(var_5.paratrooperinsertaccelerateddescent) && var_5.paratrooperinsertaccelerateddescent && isDefined(var_5.playerparachutedropsprintingunitsperframeoverride))
      var_4 = (0, 0, var_5.playerparachutedropsprintingunitsperframeoverride);
    else if(isDefined(var_5) && isDefined(var_5.playerparachutedropunitsperframeoverride))
      var_4 = (0, 0, var_5.playerparachutedropunitsperframeoverride);
    else
      var_4 = (0, 0, -15);

    if(isalive(var_5) && isDefined(var_5) && isPlayer(var_5) && (!isDefined(var_5.playerparachutemovementenabled) && 1 || isDefined(var_5.playerparachutemovementenabled) && var_5.playerparachutemovementenabled)) {
      var_9 = var_5 getnormalizedmovement();

      if(_abs(var_9[0]) > 0.5 || _abs(var_9[1]) > 0.5) {
        var_10 = (var_9[0], -1 * var_9[1], 0);
        var_10 = var_10 * 6.6675;
        var_1 = _rotatevector(var_10, var_5.angles);

        if(var_5 issprinting())
          var_1 = var_1 * 2.0;

        var_4 = var_4 + var_1;
      }

      self.angles = var_5.angles + var_8;
      var_4 = applyplayercliptest(var_4, var_5, var_1);

      if((1 || 0) && isDefined(self.parachute_model_pitchingvm))
        match_vm_parachute(var_5, var_4, var_7);
    }

    if(var_7 != var_4) {
      if(var_4 == (0, 0, 0)) {
        var_2 = (0, 0, 0);
        var_3 = 0.05;
      } else {
        var_11 = var_6 * 2;
        var_12 = var_11 / length(var_4);
        var_2 = var_4 * var_12;
        var_3 = var_12 * 0.05;
      }

      self._id_4805 = self.origin + var_2;
      self moveto(self._id_4805, var_3);

      if(1 && isDefined(self.parachute_model_vm))
        self.parachute_model_vm moveto(self._id_4805, var_3);

      thread watchforhostmigrationparachutemove(gettime() * 0.001 + var_3);
      thread watchforparachutemovegoalchange(gettime() * 0.001 + var_3);
    }

    var_7 = var_4;
    waitframe();
  }
}

_id_4ADE(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("detach");
  self endon("cancel_fadein");

  if(!common_scripts\utility::_id_562E(var_0)) {
    self._id_6E4F _meth_8450(1, 1, 0);

    if(self.team == "allies")
      self._id_6E4F setModel("usa_human_parachute_fade");
    else
      self._id_6E4F setModel("ger_human_parachute_fade");

    var_1 = 0.35;
    self._id_6E4F _meth_8450(0, 1, var_1);
    wait(var_1);
  }

  if(self.team == "allies")
    self._id_6E4F setModel("usa_human_parachute");
  else
    self._id_6E4F setModel("ger_human_parachute");
}

_id_2605(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("paratrooper_released");
  self endon("disconnect");
  var_1 = _playerphysicstrace(self.origin, (self.origin[0], self.origin[1], self.origin[2] - 2700));

  for(;;) {
    if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 1 || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled)) {
      var_2 = _getgroundposition(self.origin, 8, 100, 0.0, 1);

      if(self.origin[2] < var_2[2] + 100) {
        break;
      }
    } else if(self.origin[2] < var_1[2] + 100) {
      break;
    }

    wait 0.1;
  }

  self notify("paratrooper_released");
}

_id_8FE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");

  while(!isDefined(level._id_4696))
    waitframe();

  if(self._id_4B60)
    wait(_randomintrange(6, 10));

  maps\mp\agents\_agent_utility::_id_5334(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_7 = var_0;
    var_8 = var_1;
    self._id_5BE0 = spawnStruct();
    self._id_5BE0.origin = var_7;
    self._id_5BE0.angles = var_8;
  } else {
    self _meth_856C();
    var_9 = [[level._id_4696]]();
    var_7 = var_9.origin;
    var_8 = var_9.angles;
    self._id_5BE0 = var_9;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(var_2.name);
  self._id_5BE2 = gettime();

  if(level.teambased) {
    var_10["position"] = var_7;
    var_10["time"] = self._id_5BE2;
    level._id_7AD4[self.team][level._id_7AD4[self.team].size] = var_10;
  }

  var_11 = var_7 + (0, 0, 25);
  var_12 = var_7;
  var_13 = _playerphysicstrace(var_11, var_12);

  if(distancesquared(var_13, var_11) > 1)
    var_7 = var_13;

  self spawnagent(var_7, var_8);

  if(isDefined(var_5))
    self._id_0A43 = var_5;

  if(isDefined(self._id_0A43)) {
    if(self._id_0A43 == "follow_code_and_dev_dvar")
      self[[level.bot_funcs["bot_set_difficulty"]]](self botgetdifficulty(), 1);
    else
      self[[level.bot_funcs["bot_set_difficulty"]]](var_5);
  } else
    self[[level.bot_funcs["bot_set_difficulty"]]](self botgetdifficulty());

  self[[level.bot_funcs["bot_set_personality"]]](level._id_6E6A[level._id_6E72]);
  maps\mp\agents\_agent_common::_id_83FD(getdvarint("scr_player_maxhealth", 100));

  if(isDefined(var_4) && var_4)
    self._id_7DAD = 1;

  if(isDefined(var_2))
    maps\mp\agents\_agent_utility::hudoutlineenable(var_2.team, var_2);

  if(isDefined(self._id_0117))
    self thread[[level._id_0A55]](self._id_0117);

  thread maps\mp\_flashgrenades::_id_6394();
  self enableanimstate(0);

  if(isDefined(var_6)) {
    self._id_0BA6 = var_6;
    self _meth_858A(var_6);
    maps\mp\agents\_agent_common::_id_83FD(getdvarint("scr_player_maxhealth", 100));
    maps\mp\gametypes\_class::_id_4774();
  } else {
    self[[level._id_0A5B]]();
    maps\mp\gametypes\_class::_id_4773(self.team, self.class, 1);
  }

  self setperk("specialty_radarparatrooper", 1, 0);

  if(isDefined(self._id_0117) && self._id_0117 maps\mp\_utility::_hasperk("specialty_improvedstreaks")) {
    maps\mp\_utility::giveperk("specialty_sprintreload");
    maps\mp\_utility::giveperk("specialty_fastreload");
    maps\mp\_utility::giveperk("specialty_silentmovement");
    maps\mp\_utility::giveperk("specialty_plainsight");
    maps\mp\_utility::giveperk("specialty_stalker");
    maps\mp\_utility::giveperk("specialty_reducedsway");
    maps\mp\_utility::giveperk("specialty_fastermelee");
    maps\mp\_utility::giveperk("specialty_silentkill");
    maps\mp\_utility::giveperk("specialty_coldblooded");
    maps\mp\_utility::giveperk("specialty_spygame");
    maps\mp\_utility::giveperk("specialty_heartbreaker");
    maps\mp\_utility::giveperk("specialty_uavhidden");
    maps\mp\_utility::giveperk("specialty_delaymine");
    self._id_90DA = 6.0;
    maps\mp\_utility::giveperk("specialty_paint");
    maps\mp\_utility::giveperk("specialty_paint_pro");
    maps\mp\_utility::giveperk("specialty_blastshield2");
    self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 35) / 100;

    if(isDefined(level.hardcoremode) && level.hardcoremode)
      self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 9) / 100;

    maps\mp\_utility::giveperk("specialty_stun_resistance");
    maps\mp\_utility::giveperk("specialty_resistshellshock");
    maps\mp\_utility::giveperk("specialty_immunesmoke");
    self._id_94BE = 0.1;
    maps\mp\_utility::giveperk("specialty_fireshield");
    self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale", 35) / 100;

    if(isDefined(level.hardcoremode) && level.hardcoremode)
      self._id_90D8 = maps\mp\_utility::getintproperty("perk_fireShieldScale_HC", 9) / 100;
  }

  self thread[[level.bot_funcs["bot_think_watch_enemy"]]](1);
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();

  if(!self._id_4B60)
    _id_050D::_id_09FA();

  thread _id_0513::_id_9B90();
  self._id_4B60 = 0;
  thread _id_04D6::_id_73FC();
  self._id_0009 = &"KILLSTREAKS_PARATROOPER";

  if(maps\mp\_utility::_id_4571() != "mp_sandbox_01") {
    if(self.team == "allies") {
      self setModel("usa_paratrooper_streak_org1_mp");
      self attach(level.paratrooper_head);
    } else {
      self setModel("ita_paratrooper_streak_org1_mp");
      self attach(level.paratrooper_head);
    }
  } else
    self setagentcostumeindex(13, self.team);

  self botsetflag("disable_attack", 1);
  self botsetflag("disable_movement", 1);
  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

_id_6E69() {
  self notify("paratrooper_think");
  self endon("paratrooper_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self._id_6F7F]]();
    waitframe();
  }
}

_id_6AA6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self._id_6E4B) && !isPlayer(var_1) && !_isagent(var_1) && var_3 == "MOD_FALLING")
    var_1 = self._id_6E4B;

  self[[level._id_0A5D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);
  var_9 = _id_047A::_id_43D6(var_4, var_3);

  if(isPlayer(var_1) && (!isDefined(self._id_0117) || var_1 != self._id_0117) && (!isDefined(self._id_672C) || !self._id_672C)) {
    if(var_9 == "kill")
      maps\mp\gametypes\_damage::_id_6B4B(var_1, var_4, var_3, var_2, "paratroopers_destroyed");
    else {
      var_10 = _id_5643(var_1);

      if(isDefined(var_10)) {
        var_10 maps\mp\_utility::incplayerstat(var_9, 1);
        level thread maps\mp\gametypes\_rank::_id_1457(var_9, var_10, var_4, undefined, var_3);
      }
    }
  }

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  thread _id_0513::_id_34A9(var_1, var_3, var_4);

  if(self._id_565F) {
    self._id_4B60 = 1;

    if(maps\mp\_utility::getgametypenumlives() != 1 && (isDefined(self._id_7DAD) && self._id_7DAD))
      self thread[[maps\mp\agents\_agent_utility::_id_0A59("spawn")]]();
    else
      maps\mp\agents\_agent_utility::_id_2A73();
  }

  level._id_6E70--;

  if(level._id_6E70 <= 0) {
    level._id_6E72 = 0;

    if(isDefined(self._id_0117))
      self._id_0117 notify("paratroopers_ended");
  }
}

_id_5643(var_0) {
  var_1 = undefined;

  if(isDefined(var_0) && isDefined(self._id_0117)) {
    if(isDefined(var_0._id_0117) && isPlayer(var_0._id_0117))
      var_0 = var_0._id_0117;

    if(var_0 == self._id_0117) {
      return;
    }
    if(_issentient(self._id_0117) && _issentient(var_0)) {
      if(!_isalliedsentient(self._id_0117, var_0))
        var_1 = var_0;
    } else if(level.teambased) {
      if(self._id_0117.team != var_0.team)
        var_1 = var_0;
    } else if(self._id_0117 != var_0)
      var_1 = var_0;
  }

  return var_1;
}

_id_3694() {
  level endon("game_ended");
  self endon("paratroopers_ended");
  var_0 = common_scripts\utility::_id_A71B(80, "disconnect", "joined_team");

  foreach(var_2 in self._id_6E71)
  maps\mp\agents\_agent_utility::_id_5A28(var_2);

  level._id_6E71 = common_scripts\utility::_id_0FA0(level._id_6E71);
}

do_paratrooper_drop(var_0, var_1, var_2, var_3) {
  _id_1132(var_0, var_3);
  self._id_6E4F thread _id_64B8(var_2);
  thread _id_2605(var_1);
  thread _id_A8D2(var_1);
}

isscriptmodel(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "script_model";
}

script_model_fake_gravity_fall_if_parachute_gone(var_0) {
  self endon("death");

  while(isDefined(self getlinkedparent()))
    waitframe();

  var_1 = var_0 - 3.0 - self.origin[2];

  if(isDefined(self) && isDefined(self.playerparachutedropunitsperframeoverride))
    var_2 = self.playerparachutedropunitsperframeoverride;
  else
    var_2 = -15;

  var_3 = _abs(var_1 / var_2) * 0.05;
  var_4 = (self.origin[0], self.origin[1], var_0);
  self moveto(var_4, var_3);
}

paratroopers_beacon() {
  var_0 = self.origin;
  waittillframeend;
  var_1 = spawn("script_model", var_0 - (0, 0, 32));
  var_1 setModel("npc_soccer_ball_zombie_01");
  var_1 ghost();
  var_1._id_0117 = self;
  var_1.isplayersteerable = 1;
  var_1 thread _id_0513::_id_95A0();

  if(isDefined(var_1._id_359B["friendly"]))
    setfxkillondelete(var_1._id_359B["friendly"], 0);

  if(isDefined(var_1._id_359B["enemy"]))
    setfxkillondelete(var_1._id_359B["enemy"], 0);

  wait 7.0;
  _id_052C::_id_2D54(var_1);
}

applyplayercliptest(var_0, var_1, var_2) {
  var_3 = _length2d(var_2);

  if(var_3 == 0)
    return var_0;

  var_4 = var_1.origin + (0, 0, var_0[2]);
  var_5 = var_2 / var_3;
  var_4 = var_4 + var_5 * 15;
  var_6 = var_3 + 55 - 15;
  var_7 = var_4 + var_5 * var_6;
  var_8 = undefined;

  if(isDefined(self.parachute_collision))
    var_8 = _playerphysicstraceinfo(var_4, var_7, self.parachute_collision);
  else
    var_8 = _playerphysicstraceinfo(var_4, var_7);

  if(var_8["fraction"] < 1.0)
    var_0 = (0, 0, var_0[2]);

  return var_0;
}

verify_player_paratrooper_position(var_0) {
  if(!isDefined(level.paratrooper_pos)) {
    level.paratrooper_pos_expire_time = -999;
    level.paratrooper_pos = [];
  }

  if(gettime() > level.paratrooper_pos_expire_time)
    level.paratrooper_pos = [];

  for(var_1 = 0; var_1 < level.paratrooper_pos.size; var_1++) {
    if(_distance2d(level.paratrooper_pos[var_1], var_0) < 80) {
      var_0 = level.paratrooper_pos[var_1] + (0, 0, 130);
      level.paratrooper_pos[var_1] = var_0;
      level.paratrooper_pos_expire_time = gettime() + 2000.0;
      return var_0;
    }
  }

  level.paratrooper_pos[level.paratrooper_pos.size] = var_0;
  level.paratrooper_pos_expire_time = gettime() + 2000.0;
  return var_0;
}

player_paratrooper(var_0, var_1, var_2) {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self._id_6E4F) && isDefined(self._id_6E4F.deploy_time) && gettime() == self._id_6E4F.deploy_time) {
    return;
  }
  var_3 = undefined;

  if(0)
    thread paratroopers_beacon();

  if(isDefined(var_0))
    var_3 = var_0;
  else
    var_3 = self.origin;

  var_4 = 2700;

  if(isDefined(self.playerparachutedropheight))
    var_4 = self.playerparachutedropheight;

  var_5 = var_3 + (0, 0, var_4);
  var_6 = verify_player_paratrooper_position(var_5);
  self setOrigin(var_6);
  dontinterpolatesafe();
  var_7 = randomint(level._id_6E61.size);
  changeweaponusagestatewrapper(0);

  if(isPlayer(self) && (!isDefined(self.playerparachutemovementenabled) && 0 || isDefined(self.playerparachutemovementenabled) && self.playerparachutemovementenabled == 0))
    self _meth_8546(0);

  self allowcrouch(0);
  self allowprone(0);
  _id_0378::_id_8D74("aud_player_parachute_open");
  _id_0378::_id_8D74("aud_player_parachute_submix");
  do_paratrooper_drop(var_7, var_3[2], var_1, var_2);
}

player_paratroopers_spawn_thread(var_0, var_1, var_2) {
  if(!isDefined(level._id_6E71)) {}

  level endon("game_ended");

  if(isDefined(var_1))
    level endon(var_1);

  if(isDefined(var_2) && var_2) {
    foreach(var_4 in level.players) {
      if((!isDefined(var_0) || var_4.team == var_0) && (!isDefined(var_4.sessionstate) || var_4.sessionstate != "spectator")) {
        var_5 = undefined;

        if(maps\mp\_utility::_id_579B() && isDefined(var_4.spawnpos_postraidvignette))
          var_5 = var_4.spawnpos_postraidvignette;
        else
          var_5 = var_4._id_9092;

        var_4 thread player_paratrooper(var_5);
        var_4 _id_0378::_id_8D74("aud_player_parachute_open");
        var_4 _id_0378::_id_8D74("aud_player_parachute_submix");
      }
    }
  }

  for(;;) {
    level waittill("player_spawned", var_4);

    if(!isDefined(var_0) || var_4.team == var_0 || var_0 == "all") {
      var_4 thread player_paratrooper();
      var_4 _id_0378::_id_8D74("aud_player_parachute_open");
      var_4 _id_0378::_id_8D74("aud_player_parachute_submix");
    }
  }
}

player_paratroopers_spawn_after_raidvignette(var_0) {
  maps\mp\_utility::gameflagwait("finished_intro_vignette_" + var_0);
  var_1 = var_0;

  if(game["switchedsides"])
    var_1 = maps\mp\_utility::getotherteam(var_0);

  thread player_paratroopers_spawn_thread(var_1, "kill_paratroopers_thread", 1);
  wait 3;
  level notify("kill_paratroopers_thread");
}

showtoallexceptplayer(var_0) {
  self show();
  self _meth_8006(var_0);
}

hidefromallexceptplayer(var_0) {
  self hide();
  self showtoplayer(var_0);
}

attach_parachute_model_vm() {
  if(isPlayer(self))
    self._id_6E4F thread showtoallexceptplayer(self);

  if(1) {
    var_0 = spawn("script_model", self._id_6E4F.origin);

    if(self.team == "allies")
      var_0 setModel("usa_human_parachute");
    else
      var_0 setModel("ger_human_parachute");

    var_0.angles = self._id_6E4F.angles;

    if(isPlayer(self))
      var_0 thread hidefromallexceptplayer(self);

    self._id_6E4F.parachute_model_pitchingvm = var_0;
  }

  var_1 = spawn("script_model", self._id_6E4F.origin);

  if(self.team == "allies")
    var_1 setModel("usa_human_parachute_fade");
  else
    var_1 setModel("ger_human_parachute_fade");

  var_1.angles = self._id_6E4F.angles;

  if(isPlayer(self))
    var_1 thread hidefromallexceptplayer(self);

  var_1 _meth_8450(0, 0, 0.1);
  self._id_6E4F.parachute_model_vm = var_1;
}

offsets_setup() {
  level.parachute_loop_anim_start_time_sec = 2.3;

  foreach(var_2, var_1 in level._id_6E61)
  thread get_offset_for_single(var_2);
}

get_offset_for_single(var_0) {
  var_1 = (0, 0, 0);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("usa_human_parachute");
  var_3 = spawn("script_model", var_1);
  var_3 setModel("usa_human_parachute");
  var_4 = level._id_6E64[var_0];
  var_5 = level.paratrooper_chute_loop_anims_vm[var_0];
  var_6 = var_2 gettagorigin("TAG_ATTACH");
  var_7 = var_2 gettagangles("TAG_ATTACH");
  var_2 scriptmodelplayanim(var_4, "finished_paratrooper_deploy", 0.0001);
  var_2 setshadowrendering(1);
  var_3 scriptmodelplayanim(var_5, "finished_paratrooper_deploy", 0.0001);
  var_3 setshadowrendering(1);
  waitframe();
  var_8 = var_2 gettagorigin("TAG_ATTACH");
  var_9 = var_2 gettagangles("TAG_ATTACH");
  level.paratrooper_bindattach_to_animattach_delta_ang[var_0] = var_9 - var_7;
  var_10 = var_3 gettagorigin("TAG_ATTACH");
  var_11 = var_3 gettagangles("TAG_ATTACH");
  var_2 delete();
  var_3 delete();
}

_id_988F(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_0.origin;
  var_6 = var_0.angles;
  var_7 = _invertangles(var_6);

  if(isDefined(var_1))
    var_4 = var_0 gettagangles(var_1);
  else
    var_4 = var_0.angles;

  var_8 = _invertangles(var_4);
  var_9 = _combineangles(var_3, var_8);
  var_10 = _combineangles(var_0.angles, var_9);
  var_11 = undefined;

  if(isDefined(var_1)) {
    var_12 = var_0 gettagorigin(var_1) - var_5;
    var_11 = _rotatevector(var_12, var_7);
  } else
    var_11 = (0, 0, 0);

  var_13 = _rotatevector(var_11, var_10);
  var_0 dontinterpolatesafe();
  var_0.origin = var_2 - var_13;
  var_0.angles = var_10;
  return [var_2, var_10];
}

rotate_ent_relative_to(var_0, var_1, var_2, var_3, var_4) {
  level.original_ent_angles = var_1;
  level.ref_orientation = var_3;
  level.rotation_from_ref = var_4;
  level.inverted_ref_orientations = _invertangles(level.ref_orientation);
  level.ent_angles_in_refspace = _combineangles(level.original_ent_angles, level.inverted_ref_orientations);
  level.desired_ent_angles_in_refspace = _combineangles(level.rotation_from_ref, level.ent_angles_in_refspace);
  level.desired_ent_angles_in_worldspace = _combineangles(level.ref_orientation, level.desired_ent_angles_in_refspace);
  level.original_ent_origin = var_0;
  level.ent_to_ref_origin_diff_in_worldspace = level.original_ent_origin - var_2;
  level.ent_to_ref_origin_diff_in_refspace = _rotatevector(level.ent_to_ref_origin_diff_in_worldspace, level.inverted_ref_orientations);
  level.desired_ent_to_ref_origin_diff_in_refspace = _rotatevector(level.ent_to_ref_origin_diff_in_refspace, level.rotation_from_ref);
  level.desired_ent_to_ref_origin_diff_in_worldspace = _rotatevector(level.desired_ent_to_ref_origin_diff_in_refspace, level.ref_orientation);
  return [var_2 + level.desired_ent_to_ref_origin_diff_in_worldspace, level.desired_ent_angles_in_worldspace];
}

match_vm_parachute(var_0, var_1, var_2) {
  self.parachute_model_vm.angles = self.angles;
}

vm_model_linkto_if_needed() {
  if(1 && isDefined(self._id_6E4F.parachute_model_pitchingvm))
    self._id_6E4F.parachute_model_pitchingvm _meth_8405(self, undefined, (0, 0, -60), (0, 0, 0), 2, 0, 0, 0);

  if((1 || 0) && isDefined(self._id_6E4F.parachute_model_vm))
    _id_988F(self._id_6E4F.parachute_model_vm, "TAG_ATTACH", self.origin, self.angles);
}

_id_0DDE(var_0) {
  var_1 = (_angleclamp180(var_0[0]), _angleclamp180(var_0[1]), _angleclamp180(var_0[2]));
  return var_1;
}

dontinterpolatesafe() {
  if(!isDefined(self.dontinterpolate_timestamp) || gettime() > self.dontinterpolate_timestamp) {
    self.dontinterpolate_timestamp = gettime();
    self dontinterpolate();
  }
}