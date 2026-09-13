/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ed61983df21d505.gsc
***********************************************/

main() {
  _id_B588D148AE6131FD();
  _id_55D6C59A7D73D8A8::main();
  _id_1E11B478B6012C7E::main();
  _id_68AE53C986C67804::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_benchmark");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.nosuspensemusic = 1;
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("level_stealth_initialized");
  scripts\engine\utility::flag_init("stealth_spotted");
  _id_48814951E916AF89::init();
  _id_48814951E916AF89::_id_C8393014DD7F8AB6();
  _id_48814951E916AF89::_id_B1D1E7E3B23E0DFE(["axis_agents"]);
  _id_A0AF0F7EC32C8DDE();
  level._id_D73697030C5D4E05 = 0;
  level._id_E38979EB8FD7F7FD = -1;
  level._id_ED524AE7534D93E6 = 0;
  level._id_5B6B443F10B4B168 = 0;
  level._id_D7D950F189473905 = [];
  level._id_07EF35B879F8DA9E = 0;
  level.blocknukekills = 1;
  level._id_53A5E39AF564749C = 1;
  level.nukeinfo.weapon = "nuke_multi_mp";
  level.onplayerconnect = ::onplayerconnect;
  level.onplayerdisconnect = ::onplayerdisconnect;
}

_id_B588D148AE6131FD() {
  setDvar("dvar_C90BDE85E15978EF", 1);
  setDvar("scr_skipclasschoice", 1);
  setDvar("scr_skip_infils", 1);
  setDvar("scr_game_graceperiod", 0);
  setDvar("scr_game_matchstarttime", 0);
  setDvar("scr_game_disableAnnouncer", 1);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("cg_defaultWindFrequencyScale", 1);
  setDvar("cg_defaultWindAmplitudeScale", 4);
  setDvar("cg_defaultWindAreaScale", 50);
  setDvar("cg_defaultWindNoiseScale", 0.7);
  setDvar("cg_defaultWindStrength", 2);
  setDvar("cg_defaultWindDir", (1, 0, 0));
  setDvar("r_vertexDeformCutOffDist", 10000);
  setDvar("r_vertexDeformFadeDist", 1500);
  setDvar("r_st_displacementDistance", 1000);
  level._id_92B187A00D3DD091 = 1;
  level._id_F82986CA81591288 = 1;

  if(getdvarint("dvar_D5FD9067CAFB06B9") != 1)
    setDvar("dvar_D5FD9067CAFB06B9", 1);

  scripts\engine\utility::flag_init("final_explosion");
  scripts\engine\utility::flag_init("stop_fake_gunfight");
  scripts\engine\utility::flag_init("player_hurt");
  scripts\engine\utility::flag_init("fly_cam_agent_1");
  scripts\engine\utility::flag_init("fly_cam_agent_2");
  scripts\engine\utility::flag_init("fly_cam_shooting_1");
  scripts\engine\utility::flag_init("fly_cam_shooting_2");
}

onplayerconnect(player) {
  player waittill("spawned");

  if(isbot(player) || getdvarint("dvar_D9306688CA178DC1", 0) == 1) {
    return;
  }
  player _meth_B88C89BB7CD1AB8E((-6055, 9315, 1046));
  player.safefromnuke = 1;
  player.team = "allies";
  level.player = player;
  player _id_B4FD7AA0956A22CD();
  player thread _id_1C0EABB829DA1339();
  player disableweapons();
  player waittill("player_active");
  setDvar("mp_benchmark_mode", 1);
  setomnvar("ui_start_benchmark", 1);
  player _id_B6A6CCE8D4248B46();
}

onplayerdisconnect(player) {
  self lerpfovscalefactor(1, 0);
}

_id_B4FD7AA0956A22CD() {
  scripts\mp\utility\player::hidehudenable();
  self lerpfovscalefactor(0, 0);
}

_id_A1A6B108B4BCC3A3(_id_41252DD8A866AD6A) {
  level endon("game_ended");
  doors = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "door");
  _id_3C98CA3B59C3EFEF = 0;
  _id_884A98392CE1109B = isDefined(_id_41252DD8A866AD6A) && isint(_id_41252DD8A866AD6A);

  foreach(door in doors) {
    if(door scriptabledoorisclosed()) {
      door scriptabledooropen("away", level.player.origin);

      if(_id_884A98392CE1109B) {
        _id_3C98CA3B59C3EFEF++;

        if(_id_3C98CA3B59C3EFEF >= _id_41252DD8A866AD6A) {
          _id_3C98CA3B59C3EFEF = 0;
          waitframe();
        }
      }
    }
  }
}

teleport_player(_id_53FD9BCFE97F77D0, new_angles) {
  self setOrigin(_id_53FD9BCFE97F77D0);
  self setplayerangles(new_angles);
}

_id_1C0EABB829DA1339() {
  scripts\engine\utility::flag_wait("player_hurt");
  inflictor = _id_14442D44E01A289D(6);
  _id_BE51FCF963660FF5 = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "none", "none"], "none", "none");
  self dodamage(self.health * 0.1, self.origin, self, inflictor, "MOD_RIFLE_BULLET", _id_BE51FCF963660FF5);
  wait 0.3;
  self dodamage(self.health * 0.1, self.origin, self, inflictor, "MOD_RIFLE_BULLET", _id_BE51FCF963660FF5);
  wait 0.5;
  self dodamage(self.health * 0.25, self.origin, self, inflictor, "MOD_RIFLE_BULLET", _id_BE51FCF963660FF5);
  scripts\engine\utility::flag_clear("player_hurt");
}

#using_animtree("script_model");

_id_77E33BE51923D0CA(player_rig) {
  level.scr_animtree["player_weapon"] = #animtree;
  level.scr_anim["player_weapon"]["mp_vm_benchmark"] = % iw9_mp_vm_benchmark_weapon;
  level.scr_animname["player_weapon"]["mp_vm_benchmark"] = "iw9_mp_vm_benchmark_weapon";
  level.scr_eventanim["player_weapon"]["mp_vm_benchmark"] = "mp_vm_benchmark";
  _id_E170A74F4CB5D9D5 = spawn("script_model", (0, 0, 0));
  _id_E170A74F4CB5D9D5 setModel("wpn_vm_p01_ar_mike4_benchmark");
  _id_E170A74F4CB5D9D5 useanimtree(#animtree);
  _id_E170A74F4CB5D9D5.animname = "player_weapon";
  _id_E170A74F4CB5D9D5 linkTo(player_rig, "j_gun", (0, 0, 0), (0, 0, 0));
  return _id_E170A74F4CB5D9D5;
}

#using_animtree("player");

_id_B6A6CCE8D4248B46() {
  _id_A165F8AFFEA867AC = scripts\engine\utility::spawn_tag_origin((-10000, 9000, 400), (0, 0, 0));
  teleport_player(_id_A165F8AFFEA867AC.origin, _id_A165F8AFFEA867AC.angles);
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["mp_vm_benchmark"] = % iw9_mp_vm_benchmark;
  level.scr_animname["player_rig"]["mp_vm_benchmark"] = "iw9_mp_vm_benchmark";
  level.scr_eventanim["player_rig"]["mp_vm_benchmark"] = "mp_vm_benchmark";
  level.scr_viewmodelanim["player_rig"]["mp_vm_benchmark"] = "iw9_mp_vm_benchmark";
  player_rig = spawn("script_model", _id_A165F8AFFEA867AC.origin);
  player_rig.animname = "player_rig";
  player_rig setModel("mp_western_vm_arms_milsim_usmc_mef_1_1");
  player_rig.angles = _id_A165F8AFFEA867AC.angles;
  player_rig useanimtree(#animtree);
  self.animname = "player_rig";
  self playerlinktoabsolute(player_rig, "tag_player");
  _id_E170A74F4CB5D9D5 = _id_77E33BE51923D0CA(player_rig);
  thread _id_301B68A5C26D9398(player_rig);
  thread intro_music();
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fly_cam_agent_1", ::_id_C0E1A47B89667DE7, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fly_cam_agent_2", ::_id_D3F58B2AA09004DC, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fly_cam_shooting_1", ::_id_F049859962927FAA, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fly_cam_shooting_2", ::_id_3AD6969C3BA2DEFD, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fly_cam_fade_to_black", ::_id_D0483F7116D5B273, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_weapon", "player_start_firing", ::_id_CD84691A4126F1EA, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "agent_start_firing", ::_id_625E7EABDAA844F8, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_smoke_sequence", ::_id_1C4DD76B0584C396, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "plr_enter_water", ::_id_DBF2535F14EBAAF7, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "plr_surface_water", ::_id_7CA0405A2D14D884, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "plr_exit_water", ::_id_2CAD7DBF385CFB05, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "truck_being_shot", ::_id_DD65843BCDDA88A4, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_heli_passby", ::_id_E07AD1790CEA70EB, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_player_damage", ::_id_B4F019858D64FD6F, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "trigger_heli_missile_explosion", ::_id_AE7ED5D46F7BA982, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_enemy_molotov_agent", ::_id_6687F6DDC92D40BE, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_nuke_sequence", ::_id_D77CE79F17308572, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "final_fade_to_black", ::_id_F0C3CC11A73AB2BE, "mp_vm_benchmark");
  _id_A165F8AFFEA867AC scripts\common\anim::anim_first_frame_solo(player_rig, "mp_vm_benchmark");
  player_rig scripts\common\anim::anim_first_frame_solo(_id_E170A74F4CB5D9D5, "mp_vm_benchmark", "j_gun");
  player_rig thread scripts\common\anim::anim_single_solo(_id_E170A74F4CB5D9D5, "mp_vm_benchmark", "j_gun");
  _id_A165F8AFFEA867AC scripts\common\anim::anim_single_solo(player_rig, "mp_vm_benchmark");
}

intro_music() {
  _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("east_animated_infil");
  self setplayermusicstate(_id_39D6886350FA21AB);
  self setsoundsubmix("iw9_mp_core_prematch");
  level waittill("fly_cam_transition_done");
  self clearsoundsubmix("iw9_mp_core_prematch", 1);
}

_id_DB80A10566409336() {
  self endon("stop_fake_gunfight");
  _id_7BA8DE76721A4097 = [(600, 500, 0), (-600, 700, 0), (600, -500, 0), (-750, -500, 0)];
  _id_F6F217EA2AA761F9 = ["benchmark_weap_mcharlie_fire_npc_med_atmo", "benchmark_weap_mcbravo_fire_npc_med_atmo", "benchmark_weap_pgolf1_fire_npc_med_atmo", "benchmark_weap_slima_fire_npc_far_atmo", "benchmark_weap_mbravo_fire_npc_med_atmo"];
  _id_819382A0FC083B42 = [0.8, 2, 1, 1.5, 1.2];
  index = 0;

  while(!scripts\engine\utility::flag("stop_fake_gunfight")) {
    _id_0B1F7119DBD8CABB = level.player.origin + _id_7BA8DE76721A4097[index % _id_7BA8DE76721A4097.size];
    thread scripts\engine\utility::play_sound_in_space(_id_F6F217EA2AA761F9[index % _id_F6F217EA2AA761F9.size], _id_0B1F7119DBD8CABB);
    index++;
    wait(_id_819382A0FC083B42[index % _id_819382A0FC083B42.size]);
  }
}

_id_301B68A5C26D9398(player_rig) {
  level._id_410E9F94A2295E23 = [];
  player_rig hide();
  self playerhide();
  _id_E967153DBEFDCD7C = getEnt("player_3rd_person_fake_model", "targetname");
  _id_CE2D1A7E5668C719(_id_E967153DBEFDCD7C);
  _id_C538CAE87112FA9F = getEntArray("flycam_agent", "targetname");

  foreach(_id_1C9C827B51267985 in _id_C538CAE87112FA9F)
  _id_7B1B603AFE4BAB15 = _id_6DE59184FCFFE5E4(_id_1C9C827B51267985);
}

_id_F049859962927FAA(guy) {
  _id_01F8FD8D55E9AAB0 = _id_FD5CF954E504D8F8(8);

  if(isDefined(_id_01F8FD8D55E9AAB0)) {
    _id_7E012FFB2E3CD09A = _id_FD5CF954E504D8F8(6);
    _id_01F8FD8D55E9AAB0 thread _id_DD588B457257283C(_id_7E012FFB2E3CD09A);
  }
}

_id_3AD6969C3BA2DEFD(guy) {
  _id_01F8FD8D55E9AAB0 = _id_FD5CF954E504D8F8(2);

  if(isDefined(_id_01F8FD8D55E9AAB0)) {
    _id_7E012FFB2E3CD09A = _id_FD5CF954E504D8F8(3);
    _id_01F8FD8D55E9AAB0 thread _id_DD588B457257283C(_id_7E012FFB2E3CD09A);
  }
}

_id_DD588B457257283C(_id_F5518F46A56B505B) {
  self endon("death");
  _id_819382A0FC083B42 = [0.3, 0.4, 0.2];
  index = 0;

  while(isalive(self) && isalive(_id_F5518F46A56B505B)) {
    start = self gettagorigin("tag_flash");
    end = _id_F5518F46A56B505B getEye() + (0, 0, -20 + 5 * index);

    if(self canshoot(end)) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash"), self, "tag_flash");
      magicbullet(self.primaryweapon, start, end);
      index++;

      if(index >= 3)
        _id_F5518F46A56B505B dodamage(_id_F5518F46A56B505B.health, self.origin);

      wait(_id_819382A0FC083B42[index % _id_819382A0FC083B42.size]);
      continue;
    }

    wait 0.05;
  }
}

_id_B4B0AA2ABDB17FE1(ent) {
  self endon("death");
  self enabletraversals(0);
  self allowedstances("stand");
  self.maxhealth = 1;
  self.health = 1;
  self.baseaccuracy = 1;
  self.goalradius = 64;
  self.grenadeammo = 0;
  self.dontevershoot = 1;
  self.bt.cannotmelee = 1;
  self _meth_9215CE6FC83759B9(600);
  self agentsetfavoriteenemy(undefined);
  thread scripts\engine\utility::set_movement_speed(200);
  self._id_98ADD129A7ECB962 = 0;

  switch (self.script_noteworthy) {
    case "1":
      scripts\engine\utility::flag_wait("fly_cam_agent_1");
      thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_aqen_aqs1_hesrightthere", 2);
      thread _id_C99C377931B453AA();
      break;
    case "2":
      self.team = "allies";
      self _meth_9215CE6FC83759B9(1000);
      break;
    case "3":
      self.maxhealth = 400;
      self.health = 400;
      scripts\engine\utility::flag_wait("fly_cam_agent_2");
      thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_etca_aqs1_onesmovingtowardsus", 5);
      self _meth_9215CE6FC83759B9(350);
      wait 2.5;
      break;
    case "4":
      scripts\engine\utility::delaythread(3.4, ::_id_53C67F419C96DF15, self);
      wait 2;
      break;
    case "6":
      self.maxhealth = 400;
      self.health = 400;
      self.disablebulletwhizbyreaction = 1;
      break;
    case "7":
      wait 4;
      thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_aqsp_aqs1_coveringyou", 6);
      break;
    case "8":
      self.team = "allies";
      self _meth_9215CE6FC83759B9(1000);
      break;
    default:
      break;
  }

  if(isDefined(ent))
    _id_8D6B8D7478142531(ent);
}

_id_3DA3325A5D18C3F0(_id_78786E87E7996E27, waittime, _id_C99B6F045AE0AE35) {
  self endon("death");

  if(isDefined(waittime) && isDefined(_id_78786E87E7996E27)) {
    wait(waittime);
    self playSound(_id_78786E87E7996E27);
  }
}

_id_72DB677F715520E5() {
  level endon("game_ended");
  level waittill("fly_cam_transition_done");
  _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(2);
  _id_01F8FD8D55E9AAB0 thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_aqen_aqs2_thereheis", 1.5);
  _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(5);
  _id_01F8FD8D55E9AAB0 thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_enmy_aqs4_enemy", 10);
}

_id_C99C377931B453AA() {
  self endon("death");
  self waittill("agent_reach_end_path");
  magicgrenademanual("frag_grenade_mp", self.origin, (0, 0, 0), 0.1);
}

_id_C0E1A47B89667DE7(guy) {
  scripts\engine\utility::flag_set("fly_cam_agent_1");
}

_id_D3F58B2AA09004DC(guy) {
  scripts\engine\utility::flag_set("fly_cam_agent_2");
}

_id_53C67F419C96DF15(guy) {
  _id_D5685B7BAEE6505E = (-7721, 10217, 350);
  end_pos = guy.origin;
  magicbullet("iw9_la_gromeo_mp", _id_D5685B7BAEE6505E, end_pos, level.player);
  radiusdamage(end_pos, 254, 250, 250, level.player, "MOD_EXPLOSIVE", "c4_mp");
  wait 2;
  magicgrenademanual("flash_grenade_mp", (-9352, 8269, 318), (0, 0, 0), 0.1);
}

_id_D0483F7116D5B273(guy) {
  blackoverlay = newhudelem();
  blackoverlay.x = 0;
  blackoverlay.y = 0;
  blackoverlay setshader("black", 640, 480);
  blackoverlay.alignx = "left";
  blackoverlay.aligny = "top";
  blackoverlay.sort = 1;
  blackoverlay.horzalign = "fullscreen";
  blackoverlay.vertalign = "fullscreen";
  blackoverlay.alpha = 0;
  blackoverlay.foreground = 1;
  blackoverlay fadeovertime(0.5);
  blackoverlay.alpha = 1;
  wait 0.6;
  _id_BEB39746DD6BBFE1();
  guy show();
  thread _id_A1A6B108B4BCC3A3(150);
  thread _id_EDC42FD4E99BE095();
  thread _id_72DB677F715520E5();
  level.player thread _id_DB80A10566409336();
  wait 0.6;
  level notify("fly_cam_transition_done");
  blackoverlay fadeovertime(1);
  blackoverlay.alpha = 0;
  wait 1.1;
  blackoverlay destroy();
}

_id_CD84691A4126F1EA(guy) {
  level._id_07EF35B879F8DA9E = level._id_07EF35B879F8DA9E + 1;
  _id_379CADD4C9B0CD35 = guy gettagorigin("tag_flash");
  _id_A074196295D2E93B = guy _id_D1C894D34CD6A82E(level._id_07EF35B879F8DA9E);
  playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash"), guy, "tag_flash");
  magicbullet("iw9_ar_mike4_mp_benchmark", _id_379CADD4C9B0CD35, _id_A074196295D2E93B);
}

_id_625E7EABDAA844F8(guy) {
  _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(level._id_53A5E39AF564749C);

  if(isDefined(_id_01F8FD8D55E9AAB0)) {
    if(level._id_53A5E39AF564749C == 12)
      _id_01F8FD8D55E9AAB0 thread _id_78DCABB37410E003();
    else
      _id_01F8FD8D55E9AAB0 thread _id_0EF0F9CD5DE157E6();
  }

  level._id_53A5E39AF564749C = level._id_53A5E39AF564749C + 1;
}

_id_0EF0F9CD5DE157E6() {
  self endon("death");
  _id_819382A0FC083B42 = [0.5, 0.3, 0.4];
  index = 0;

  while(isalive(self)) {
    start = self gettagorigin("tag_flash");
    end = level.player getEye();
    _id_6B14B71D0092A457 = anglesToForward(self gettagangles("tag_flash"));
    _id_53F1B3D4CB41ECAE = vectorNormalize(end - start);

    if(_id_FB0753AFC466B10F(_id_6B14B71D0092A457, _id_53F1B3D4CB41ECAE)) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash"), self, "tag_flash");
      magicbullet(self.primaryweapon, start, end + (-20, 0, 0));
      wait(_id_819382A0FC083B42[index % _id_819382A0FC083B42.size]);
      index++;
      continue;
    }

    wait 0.05;
  }
}

_id_78DCABB37410E003() {
  self endon("death");
  _id_819382A0FC083B42 = [0.2, 0.3, 0.4];
  _id_9EB0FE394F115634 = 2;
  index = 0;
  wait(_id_9EB0FE394F115634);

  while(isalive(self)) {
    start = self gettagorigin("tag_flash");
    end = level.player getEye();
    playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash"), self, "tag_flash");
    magicbullet(self.primaryweapon, start, end + (-20, 0, 0));
    wait(_id_819382A0FC083B42[index % _id_819382A0FC083B42.size]);
    index++;
  }
}

_id_FB0753AFC466B10F(_id_6B14B71D0092A457, _id_0F5354AFC4A687E0) {
  _id_EB9B1C94C4A70BC5 = 12;
  _id_A3CD3112C6949144 = scripts\engine\math::anglebetweenvectors(_id_6B14B71D0092A457, _id_0F5354AFC4A687E0);
  return _id_A3CD3112C6949144 < _id_EB9B1C94C4A70BC5;
}

_id_D1C894D34CD6A82E(_id_07EF35B879F8DA9E) {
  _id_A074196295D2E93B = anglesToForward(self gettagangles("tag_flash")) * 4000;

  switch (_id_07EF35B879F8DA9E) {
    case 3:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(1);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 6:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(2);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      thread _id_B69C13B16FDC401C();
      break;
    case 10:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(3);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 13:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(4);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 18:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(5);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 38:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(7);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 41:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(8);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
    case 45:
      _id_01F8FD8D55E9AAB0 = _id_14442D44E01A289D(15);
      _id_A074196295D2E93B = _id_01F8FD8D55E9AAB0.origin + (0, 0, 35);
      break;
  }

  return _id_A074196295D2E93B;
}

_id_AE99616202575E39(targetorigin, _id_195927E09B405481, _id_D2666395E6CF4732, _id_031C8C817A0E8136) {
  self endon("death");
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 1);

  if(isDefined(_id_D2666395E6CF4732)) {
    _id_D2666395E6CF4732 = min(abs(_id_D2666395E6CF4732), 256);
    targetorigin = targetorigin + (randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732), randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732), randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732));
  }

  scripts\asm\asm_mp::asm_setanimScripted();
  self orientmode("face angle", vectortoangles(targetorigin - self.origin)[1]);
  [animname, _id_07ADB38055D0917F, _id_472050D5EBCF25B8] = _id_371B4C2AB5861E62::_id_CF56C061947EF668(self.origin, targetorigin);
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", animname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  animlength = getanimlength(xanim);
  self aisetanim("animscripted", animindex);
  _id_20343D86382EC753 = animlength * _id_07ADB38055D0917F;
  wait(_id_20343D86382EC753);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 0);
  [_id_3EB0E5F5F61F0A10, _id_56EBCB2D4FCB8071] = _id_371B4C2AB5861E62::_id_A615009E6466353A(self, targetorigin, _id_195927E09B405481, _id_472050D5EBCF25B8);

  if(isDefined(_id_031C8C817A0E8136) && (isvector(_id_031C8C817A0E8136) || isfloat(_id_031C8C817A0E8136)))
    _id_56EBCB2D4FCB8071 = _id_56EBCB2D4FCB8071 * _id_031C8C817A0E8136;

  grenade = self launchgrenade(_id_195927E09B405481, _id_3EB0E5F5F61F0A10, _id_56EBCB2D4FCB8071);
  grenade.owner = self;

  if(_id_195927E09B405481 == "molotov_mp") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pyro", "molotov_used"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("pyro", "molotov_used")]](grenade);

    wait 1;
    grenade notify("missile_stuck");
    _id_20343D86382EC753 = _id_20343D86382EC753 - 1;
  }

  if(_id_20343D86382EC753 > 0)
    wait(_id_20343D86382EC753);

  scripts\asm\asm_bb::bb_clearanimScripted();
}

_id_6687F6DDC92D40BE(guy) {
  if(isalive(level._id_54D76AFAA07E2AF1))
    level._id_54D76AFAA07E2AF1 scripts\mp\agents\agent_utility::_id_CB7D1454840BB597(0);

  _id_88B4727DD33BA280 = getEnt("molotov_origin", "targetname");
  _id_D41E280C0E602872 = getEnt("enemy_agent_molotov", "targetname");
  _id_D41E280C0E602872._id_944FB27383E6F511 = (-9882, 9332, 362.5);
  agent = _id_7DDC1802148E4BA9(_id_D41E280C0E602872);
  agent.team = "allies";
  agent thread _id_3DA3325A5D18C3F0("dx_bc_aqsc_aqen_aqs2_ifoundhim", 4);
  _id_A664AAD02EE98BD2 = "molotov_mp";
  _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, _id_A664AAD02EE98BD2, 1);
  agent waittill("agent_reach_end_path");
  wait 1;
  agent thread _id_AE99616202575E39(_id_88B4727DD33BA280.origin, _id_A664AAD02EE98BD2, undefined, (2, 2, 1));
  wait 2.3;
  scripts\engine\utility::flag_set("player_hurt");
  wait 0.7;
  agent scripts\mp\agents\agent_utility::_id_CB7D1454840BB597(1);
}

_id_1C4DD76B0584C396(guy) {
  _id_E65D7AD64FB406F4 = getEntArray("smoke_grenade_spawn", "targetname");
  _id_5B01B6814F50DC96 = (0, 0, 10);

  foreach(smoke in _id_E65D7AD64FB406F4) {
    magicgrenademanual("smoke_grenade_mp", smoke.origin, _id_5B01B6814F50DC96, 0.05);
    wait 0.2;
  }
}

_id_DBF2535F14EBAAF7(guy) {
  level.player _id_4B87F2871B6B025C::_id_9A01935A05B613E4();
  level.player playlocalsound("mvmt_swim_plunging_plr_fast");
  playFXOnTag(scripts\engine\utility::getfx("swim_enter_water"), guy, "tag_camera");
  level.player childthread _id_4B87F2871B6B025C::_id_178428152F0B5E74();
  level.player childthread _id_4B87F2871B6B025C::_id_4186D69A94FE93D9();
  level.player setclientomnvar("swim_under_water", level.player._id_C3A0F3B16CCE4CA9.underwater);
}

_id_7CA0405A2D14D884(guy) {
  level.player _id_4B87F2871B6B025C::_id_4594E9DCEBF2C645();
  level.player playlocalsound("mvmt_swim_surfacing_plr_sprint_gasping");
  playFXOnTag(scripts\engine\utility::getfx("swim_exit_water"), guy, "tag_camera");
  level.player childthread _id_4B87F2871B6B025C::_id_8173A7A676C2AA00();
  level.player childthread _id_4B87F2871B6B025C::_id_1A0FCD6BAE3D2370();
  level.player setclientomnvar("swim_under_water", level.player._id_C3A0F3B16CCE4CA9.underwater);
}

_id_2CAD7DBF385CFB05(guy) {
  level.player playlocalsound("mvmt_swim_exitwater_plr");
}

_id_DD65843BCDDA88A4(guy) {
  _id_4F455D19526C27E8 = getEnt("truck_bullet_start_pos", "targetname");
  _id_0B1F7119DBD8CABB = _id_4F455D19526C27E8.origin;
  _id_E4E3307B5DADACF8 = getEnt("truck_bullet_impact_1", "targetname");
  _id_DD8C494A23EEFB7C = getEnt("truck_bullet_impact_2", "targetname");
  _id_39133786C7DF597E = _id_E4E3307B5DADACF8.origin;
  _id_8800D31D663C14C2 = _id_DD8C494A23EEFB7C.origin;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_39133786C7DF597E);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_39133786C7DF597E);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_39133786C7DF597E);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.2;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_39133786C7DF597E);
  wait 0.3;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.2;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_39133786C7DF597E);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.1;
  magicbullet("iw9_ar_akilo_mp", _id_0B1F7119DBD8CABB, _id_8800D31D663C14C2);
  wait 0.8;
  radiusdamage(_id_0B1F7119DBD8CABB, 254, 500, 500, level.player, "MOD_EXPLOSIVE", "c4_mp");
  thread scripts\engine\utility::play_sound_in_space("benchmark_veh9_dmg_civ_lnd_truck_explode", _id_0B1F7119DBD8CABB);
}

_id_B4F019858D64FD6F(guy) {
  scripts\engine\utility::flag_set("player_hurt");
  magicbullet("iw9_la_gromeo_mp", (-8623, 8754, 314.5), (-7958, 8598, 395));
}

_id_D77CE79F17308572(guy) {
  _id_35E15053D2E9F98E = getEnt("nuke_explosion_pos", "targetname");
  _id_E82473B42B3ADBAD(_id_35E15053D2E9F98E.origin);
  thread _id_9A9553BCB5117966("dx_mp_kill_chop_uktl_ause", 4, 2);
}

_id_F0C3CC11A73AB2BE(guy) {
  blackoverlay = newhudelem();
  blackoverlay.x = 0;
  blackoverlay.y = 0;
  blackoverlay setshader("black", 640, 480);
  blackoverlay.alignx = "left";
  blackoverlay.aligny = "top";
  blackoverlay.sort = 1;
  blackoverlay.horzalign = "fullscreen";
  blackoverlay.vertalign = "fullscreen";
  blackoverlay.alpha = 0;
  blackoverlay.foreground = 1;
  blackoverlay fadeovertime(0.8);
  blackoverlay.alpha = 1;
  wait 1.2;

  foreach(_id_35009BC5BEE3C7EC in level._id_D7D950F189473905)
  _id_35009BC5BEE3C7EC scripts\mp\agents\agent_utility::_id_CB7D1454840BB597(0);

  level.player setsoundsubmix("fade_to_black_all_except_music", 2);
  wait 2;
  setomnvar("ui_show_benchmark_report", 1);
}

_id_B69C13B16FDC401C() {
  wait 0.7;
  _id_B7A86BE94397DFF0 = getEnt("first_rpg_start_position", "targetname");
  _id_2A5A886E62537051 = getEnt("first_rpg_end_position", "targetname");
  magicbullet("iw9_la_gromeo_mp", _id_B7A86BE94397DFF0.origin, _id_2A5A886E62537051.origin, _id_14442D44E01A289D(4));
}

_id_14442D44E01A289D(index) {
  foreach(_id_1C9C827B51267985 in level._id_D7D950F189473905) {
    if(isDefined(_id_1C9C827B51267985.script_noteworthy)) {
      if(int(_id_1C9C827B51267985.script_noteworthy) == index)
        return _id_1C9C827B51267985;
    }
  }
}

_id_EDC42FD4E99BE095() {
  _id_8DAA7EF0C0F67DC1 = getEntArray("enemy_agent", "targetname");

  foreach(_id_1C9C827B51267985 in _id_8DAA7EF0C0F67DC1)
  _id_7DDC1802148E4BA9(_id_1C9C827B51267985);
}

_id_A0AF0F7EC32C8DDE() {
  precachemodel("head_al_qatala_3_ar");
  precachemodel("head_al_qatala_desert_05");
  precachemodel("head_al_qatala_desert_08");
  precachemodel("head_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02");
  precachemodel("body_al_qatala_desert_03");
  precachemodel("body_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02_b");
  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "head_al_qatala_3_ar";
  level.enemyheadmodels[1] = "head_al_qatala_desert_05";
  level.enemyheadmodels[2] = "head_al_qatala_desert_08";
  level.enemyheadmodels[3] = "head_al_qatala_desert_09";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "body_al_qatala_desert_02";
  level.enemybodymodels[1] = "body_al_qatala_desert_03";
  level.enemybodymodels[2] = "body_al_qatala_desert_09";
  level.enemybodymodels[3] = "body_al_qatala_desert_02_b";
}

enemy_soldier_think(ent, _id_4C6BD934D2B20193) {
  self enabletraversals(0);
  self allowedstances("stand");
  self.maxhealth = 1;
  self.health = 1;
  self.baseaccuracy = 1;
  self.goalradius = 16;
  self.grenadeammo = 0;
  self.disablegrenaderesponse = 1;
  self.disabledodge = 1;
  self.combatmode = "no_cover";
  self setgoalpos(self.origin, 16);
  self clearpath();
  self.fixednode = 1;
  self.dontevershoot = 1;
  self.bt.cannotmelee = 1;
  self _meth_9215CE6FC83759B9(9000);
  _id_E4A29F8A0C3FDCA7 = scripts\engine\utility::ter_op(isDefined(_id_4C6BD934D2B20193) && _id_4C6BD934D2B20193 == 1, undefined, level.player);
  self agentsetfavoriteenemy(_id_E4A29F8A0C3FDCA7);
  thread scripts\engine\utility::set_movement_speed(200);
  self._id_98ADD129A7ECB962 = 0;

  if(isDefined(ent))
    _id_8D6B8D7478142531(ent);
}

_id_8D6B8D7478142531(ent) {
  while(isDefined(ent.target)) {
    self enabletraversals(1);

    if(isDefined(ent._id_944FB27383E6F511)) {
      self setgoalpos(ent._id_944FB27383E6F511, 16);
      target_ent = ent;
      target_ent.target = undefined;
    } else {
      target_ent = getnode(ent.target, "targetname");
      self setgoalnode(target_ent);
    }

    if(isDefined(target_ent.target))
      self waittill("near_goal");
    else
      self waittill("goal");

    ent = target_ent;
  }

  self notify("agent_reach_end_path");
  self enabletraversals(0);
}

_id_27874E75FC2CFB79(_id_4C6BD934D2B20193) {
  self enabletraversals(0);
  self allowedstances("crouch");
  self.disablegrenaderesponse = 1;
  self.disabledodge = 1;
  self.combatmode = "no_cover";
  self setgoalpos(self.origin, 16);
  self clearpath();
  self.fixednode = 1;
  self.maxhealth = 1;
  self.health = 1;
  self.baseaccuracy = 1;
  self.goalradius = 64;
  self.grenadeammo = 0;
  self.dontevershoot = 1;
  self.bt.cannotmelee = 1;
  self _meth_9215CE6FC83759B9(9000);
  _id_E4A29F8A0C3FDCA7 = scripts\engine\utility::ter_op(isDefined(_id_4C6BD934D2B20193) && _id_4C6BD934D2B20193 == 1, undefined, level.player);
  self agentsetfavoriteenemy(_id_E4A29F8A0C3FDCA7);
  thread scripts\engine\utility::set_movement_speed(200);
  self._id_98ADD129A7ECB962 = 0;
}

enemy_model_setup(index) {
  head = level.enemyheadmodels[index % level.enemyheadmodels.size];
  body = level.enemybodymodels[index % level.enemyheadmodels.size];

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(body);
  self attach(head, "", 1);
  self.headmodel = head;
}

spawn_agent(ent) {
  aitype = "enemy_mp_base";
  agent = scripts\mp\mp_agent::spawnnewagentaitype(aitype, ent.origin, ent.angles);

  while(!isDefined(agent))
    wait 0.05;

  return agent;
}

_id_CE2D1A7E5668C719(ent) {
  waitframe();
  level._id_54D76AFAA07E2AF1 = spawn_agent(ent);
  level._id_54D76AFAA07E2AF1 enabletraversals(0);
  level._id_54D76AFAA07E2AF1 allowedstances("stand");
  level._id_54D76AFAA07E2AF1.goalradius = 64;
  level._id_54D76AFAA07E2AF1.aggressivemode = 0;
  level._id_54D76AFAA07E2AF1 _meth_9215CE6FC83759B9(600);
  level._id_54D76AFAA07E2AF1 agentsetfavoriteenemy(undefined);
  level._id_54D76AFAA07E2AF1.ignoreme = 1;
  level._id_54D76AFAA07E2AF1.ignoreall = 1;
  level._id_54D76AFAA07E2AF1.disablebulletwhizbyreaction = 1;
  level._id_54D76AFAA07E2AF1.combatmode = "no_cover";
  level._id_54D76AFAA07E2AF1.disablerunngun = 1;
  level._id_54D76AFAA07E2AF1.disabledodge = 1;
  level._id_54D76AFAA07E2AF1.scripted_mode = 1;
}

_id_6DE59184FCFFE5E4(ent) {
  _id_F1DEDCCA27836AD7 = spawn_agent(ent);

  if(isDefined(ent.script_noteworthy))
    _id_F1DEDCCA27836AD7.script_noteworthy = ent.script_noteworthy;

  _id_F1DEDCCA27836AD7 thread _id_B4B0AA2ABDB17FE1(ent);
  _id_F1DEDCCA27836AD7 enemy_model_setup(level._id_410E9F94A2295E23.size);
  level._id_410E9F94A2295E23 = scripts\engine\utility::array_add(level._id_410E9F94A2295E23, _id_F1DEDCCA27836AD7);
  return _id_F1DEDCCA27836AD7;
}

_id_FD5CF954E504D8F8(index) {
  foreach(_id_1C9C827B51267985 in level._id_410E9F94A2295E23) {
    if(isDefined(_id_1C9C827B51267985.script_noteworthy)) {
      if(int(_id_1C9C827B51267985.script_noteworthy) == index)
        return _id_1C9C827B51267985;
    }
  }
}

_id_BEB39746DD6BBFE1() {
  foreach(_id_7B1B603AFE4BAB15 in level._id_410E9F94A2295E23)
  _id_7B1B603AFE4BAB15 scripts\mp\agents\agent_utility::_id_CB7D1454840BB597(0);
}

_id_7DDC1802148E4BA9(ent) {
  _id_F1DEDCCA27836AD7 = spawn_agent(ent);
  level._id_5B6B443F10B4B168 = level._id_5B6B443F10B4B168 + 1;

  if(isDefined(ent.script_noteworthy)) {
    _id_F1DEDCCA27836AD7.script_noteworthy = ent.script_noteworthy;

    switch (int(_id_F1DEDCCA27836AD7.script_noteworthy)) {
      case 1:
        _id_F1DEDCCA27836AD7 thread enemy_soldier_think(ent, 1);
        _id_F1DEDCCA27836AD7.disabledodge = 1;
        _id_F1DEDCCA27836AD7.disablebulletwhizbyreaction = 1;
        break;
      case 5:
        _id_F1DEDCCA27836AD7 thread _id_27874E75FC2CFB79();
        break;
      case 7:
        _id_F1DEDCCA27836AD7 thread _id_27874E75FC2CFB79();
        break;
      case 8:
        _id_F1DEDCCA27836AD7 thread _id_27874E75FC2CFB79();
        break;
      default:
        _id_F1DEDCCA27836AD7 thread enemy_soldier_think(ent);
        break;
    }
  } else
    _id_F1DEDCCA27836AD7 thread enemy_soldier_think(ent);

  _id_F1DEDCCA27836AD7 enemy_model_setup(level._id_5B6B443F10B4B168);
  level._id_D7D950F189473905 = scripts\engine\utility::array_add(level._id_D7D950F189473905, _id_F1DEDCCA27836AD7);
  return _id_F1DEDCCA27836AD7;
}

_id_E82473B42B3ADBAD(_id_45292519459D6838) {
  scripts\engine\utility::delaythread(10, scripts\engine\utility::flag_set, "stop_fake_gunfight");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke_multi", level.player);
  streakinfo.streakname = "nuke_multi";
  streakinfo.debug_state = "begin_use";
  level.player scripts\cp_mp\killstreaks\nuke::nuke_start(streakinfo, 0, level.player.origin + (0, 0, 900), _id_45292519459D6838, undefined, undefined, "nuke_multi_mp");
}

_id_C0735CFF4544083B(startstruct) {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = startstruct;
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = scripts\engine\utility::getStruct(startstruct.target, "targetname");

  for(num = 1; isDefined(_id_9E4E1482CB40C9C5[num].target) && scripts\engine\utility::getStruct(_id_9E4E1482CB40C9C5[num].target, "targetname") != startstruct; num++)
    _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = scripts\engine\utility::getStruct(_id_9E4E1482CB40C9C5[num].target, "targetname");

  points = [];

  foreach(struct in _id_9E4E1482CB40C9C5)
  points[points.size] = struct;

  return points;
}

_id_E07AD1790CEA70EB(guy) {
  start = scripts\engine\utility::getStruct("p2p_heli_start", "targetname");
  offset = (0, 0, -50);
  _id_235D14D5FEEFC6F0 = start.origin + offset;
  vehicle = spawnVehicle("veh9_mil_air_heli_ahotel64_mp", "apache_spawner", "apache_physics", _id_235D14D5FEEFC6F0, start.angles);
  vehicle.script_startinghealth = 1000;
  vehicle _meth_D2E41C7603BA7697("p2p");
  vehicle _meth_77320E794D35465A("p2p", "goalThreshold", scripts\engine\utility::mph_to_ips(45));
  vehicle _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  vehicle _meth_77320E794D35465A("p2p", "manualSpeed", scripts\engine\utility::mph_to_ips(45));
  vehicle setscriptablepartstate("engine", "on");
  points = _id_C0735CFF4544083B(start);
  thread _id_967606D29FE3BE2D(vehicle);

  for(index = 1; index <= points.size; index++) {
    if(index > 1)
      vehicle waittill("near_goal");

    if(index == points.size) {
      vehicle delete();
      break;
    }

    vehicle _meth_77320E794D35465A("p2p", "goalPoint", points[index].origin + offset);
    vehicle _meth_77320E794D35465A("p2p", "goalAngles", points[index].angles);
  }
}

_id_9A9553BCB5117966(aliasname, waittime, _id_5D1C94FBB9E3C27D) {
  wait(waittime);

  if(soundexists(aliasname))
    level.player queuedialogforplayer(aliasname, aliasname, _id_5D1C94FBB9E3C27D);
}

_id_967606D29FE3BE2D(vehicle) {
  _id_8DAA7EF0C0F67DC1 = getEntArray("mortar_enemy_agent", "targetname");
  wait 1;

  foreach(_id_1C9C827B51267985 in _id_8DAA7EF0C0F67DC1)
  _id_7DDC1802148E4BA9(_id_1C9C827B51267985);

  level.player thread _id_1C0EABB829DA1339();
  scripts\engine\utility::flag_wait("final_explosion");
  _id_D00FF67F8C73AA09 = getEnt("missile_impact_1", "targetname");
  _id_D00FF37F8C73A370 = getEnt("missile_impact_2", "targetname");
  _id_D00FF47F8C73A5A3 = getEnt("missile_impact_3", "targetname");
  _id_D00FF97F8C73B0A2 = getEnt("missile_impact_4", "targetname");
  _id_D00FFA7F8C73B2D5 = getEnt("missile_impact_5", "targetname");
  _id_D00FF77F8C73AC3C = getEnt("missile_impact_6", "targetname");
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FF67F8C73AA09.origin);
  wait 0.3;
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FF37F8C73A370.origin);
  wait 0.2;
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FF47F8C73A5A3.origin);
  wait 0.2;
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FF97F8C73B0A2.origin);
  wait 0.3;
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FFA7F8C73B2D5.origin);
  wait 0.3;
  thread _id_B295C2C3D97921AB(vehicle.origin + (0, 0, -150), _id_D00FF77F8C73AC3C.origin);
}

_id_AE7ED5D46F7BA982(guy) {
  scripts\engine\utility::flag_set("final_explosion");
  thread _id_9A9553BCB5117966("dx_mp_kill_nuke_uktl_ause", 3.5, 2);
}

_id_B295C2C3D97921AB(_id_4E5348300548819D, _id_095B5506BB7B5044) {
  _id_D42E799E256E8C7A = magicbullet("gunship_hellfire_mp", _id_4E5348300548819D, _id_095B5506BB7B5044, level.player);

  while(isDefined(_id_D42E799E256E8C7A))
    waitframe();

  radiusdamage(_id_095B5506BB7B5044, 254, 250, 250, level.player, "MOD_EXPLOSIVE", "c4_mp");
}