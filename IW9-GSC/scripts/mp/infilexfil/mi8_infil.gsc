/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mi8_infil.gsc
***********************************************/

mi8_init(subtype) {
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [11, 10];
  _id_453E4FC2C649FEA4[1] = [9, 8];
  _id_453E4FC2C649FEA4[2] = [7, 6];
  _id_453E4FC2C649FEA4[3] = [5, 4];
  _id_453E4FC2C649FEA4[4] = [3, 2];
  _id_453E4FC2C649FEA4[5] = [1, 0];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_mi8", subtype, 12, 4, _id_453E4FC2C649FEA4, ::mi8_spawn, ::mi8_get_length, ::player_mi8_infil_think);
}

mi8_spawn(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, subtype);
  return infil;
}

printdata(infil, subtype, originalsubtype) {
  org = infil.scene_node.origin;
  _id_8BC14603A27FA3E7 = infil.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(org, _id_8BC14603A27FA3E7, level.framedurationseconds, 1.0);
    waitframe();
  }
}

postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_downtown_gw":
      switch (originalsubtype) {
        case "alpha":
          if(team == "axis")
            scene_node.angles = scene_node.angles + (0, 8, 0);
          else {
            scene_node.angles = scene_node.angles + (0, 23, 0);
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * 100;
          }

          break;
        case "alpha1":
          if(team == "axis")
            scene_node.angles = scene_node.angles + (0, -8, 0);
          else
            scene_node.angles = scene_node.angles + (0, -3, 0);

          break;
        case "alpha2":
          if(team == "axis") {
            scene_node.angles = scene_node.angles + (0, -3, 0);
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * 200;
          } else
            scene_node.angles = scene_node.angles + (0, 12, 0);

          break;
      }

      break;
    case "mp_farms2_gw":
      switch (originalsubtype) {
        case "bravo":
          if(team == "allies")
            scene_node.origin = scene_node.origin - (0, 0, 86);
      }
    case "mp_promenade_gw":
      switch (originalsubtype) {
        case "alpha":
          if(team == "allies")
            scene_node.angles = scene_node.angles - (0, 30, 0);
      }

      break;
  }
}

mi8_get_length(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["mi8_infil"]);
  return animlength;
}

player_mi8_infil_think(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");
  thread infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.origin;
  _id_B7850001037AA074 = infil.angles;
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.player_rig linkTo(infil);
  infil scripts\common\anim::anim_first_frame_solo(self.player_rig, "mi8_infil");
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self)) {
    soundalias = "scn_infil_mindia_plr_1";

    switch (self.animname) {
      case "slot_0":
        soundalias = "scn_infil_mindia_plr_1";
        break;
      case "slot_1":
        soundalias = "scn_infil_mindia_plr_2";
        break;
      case "slot_2":
        soundalias = "scn_infil_mindia_plr_3";
        break;
      case "slot_3":
        soundalias = "scn_infil_mindia_plr_4";
        break;
      case "slot_4":
        soundalias = "scn_infil_mindia_plr_5";
        break;
      case "slot_5":
        soundalias = "scn_infil_mindia_plr_6";
        break;
      case "slot_6":
        soundalias = "scn_infil_mindia_plr_1";
        break;
      case "slot_7":
        soundalias = "scn_infil_mindia_plr_2";
        break;
      case "slot_8":
        soundalias = "scn_infil_mindia_plr_3";
        break;
      case "slot_9":
        soundalias = "scn_infil_mindia_plr_4";
        break;
      case "slot_10":
        soundalias = "scn_infil_mindia_plr_5";
        break;
      case "slot_11":
        soundalias = "scn_infil_mindia_plr_6";
        break;
      default:
        soundalias = "scn_infil_mindia_plr_1";
        break;
    }

    self playlocalsound(soundalias);
    self playlocalsound("scn_infil_mindia_heli_int_lr");
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  thread clear_infil_ambient_zone();
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "mi8_infil");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self lerpfovscalefactor(1, 2);
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 4;
  self setclienttriggeraudiozonepartialwithfade("mindia_infil_mix", 4, "mix");
  wait 4;

  if(isDefined(self._id_5B097BDE4417D7AD))
    self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

  self clearclienttriggeraudiozone(2);
}

player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

infil_radio_idle(infil) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("mindia_preinfil_mix", 0.05, "mix");
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    self playlocalsound("scn_infil_mindia_heli_prestart");
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;

    if(isDefined(self))
      self stoplocalsound("scn_infil_mindia_heli_prestart");

    wait 1;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC delete();
  }
}

player_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(!isDefined(self.actors))
    self.actors = [];

  _id_46959F58CBABA3AC = getcommanderassets(team);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("commander", "tag_origin", _id_46959F58CBABA3AC.body, _id_46959F58CBABA3AC.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin", _id_46959F58CBABA3AC.body, _id_46959F58CBABA3AC.head);

  foreach(actor in self.actors)
  actor.infil = self;

  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.actors[1].anim_playsound_func = ::driver_play_sound_func;
}

blima_chief_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.blima.players)
  player playsoundtoplayer(alias, player);
}

infilthink(team, _id_CA85A0DE365C6A63) {
  _id_E026A614F7467557 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", _id_E026A614F7467557);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  level.infilsactive--;
  self delete();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent = spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63);

  if(self.originalsubtype != self.subtype && (getDvar("g_mapname") == "mp_downtown_gw" || getDvar("g_mapname") == "mp_port2_gw"))
    _id_CA85A0DE365C6A63 = self.originalsubtype;

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "mi8_infil_" + _id_CA85A0DE365C6A63 + "_" + team);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("blinking_light", "red", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  self.linktoent thread mindia_exterior_sfx();
  thread scripts\common\anim::anim_single_solo(self.linktoent, "mi8_infil_" + _id_CA85A0DE365C6A63 + "_" + team);
  animlength = getanimlength(level.scr_anim["mi8"]["mi8_infil_" + _id_CA85A0DE365C6A63 + "_" + team]);
  wait(animlength);
  self.linktoent delete();
  self.linktoent = undefined;
}

mindia_exterior_sfx() {
  if(soundexists("scn_infil_mindia_heli_ext"))
    self playsoundonmovingent("scn_infil_mindia_heli_ext");
}

van_infil_sfx_npc1(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc3");
}

van_infil_sfx_npc2(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc2");
}

van_infil_sfx_npc3(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc1");
}

van_infil_sfx_npc4(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc6");
}

van_infil_sfx_npc5(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc5");
}

van_infil_sfx_npc6(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_npc4");
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "mi8_infil_" + _id_CA85A0DE365C6A63, "tag_origin");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "mi8_infil_" + _id_CA85A0DE365C6A63, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["mi8_infil_" + _id_CA85A0DE365C6A63]);
  duration = getanimlength(level.scr_anim["commander"]["mi8_infil_" + _id_CA85A0DE365C6A63]);
  wait(duration);

  foreach(actor in self.actors)
  actor delete();

  self.actors = undefined;
}

spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  _id_C920DC0E8DFA0EF4 = 1;

  if(scripts\engine\utility::cointoss())
    _id_C920DC0E8DFA0EF4 = 0;

  if(body == "random") {
    if(_id_C920DC0E8DFA0EF4) {
      index = randomint(3);

      if(index == 0)
        body = "c_civ_pic_male_2_brown";
      else if(index == 1)
        body = "body_opforce_london_civ_1_1";
      else if(index == 2)
        body = "civ_london_male_2_5";
    } else if(scripts\engine\utility::cointoss())
      body = "civ_london_female_1_4";
    else
      body = "c_civ_pic_female_5_6";
  }

  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    if(head == "random") {
      if(_id_C920DC0E8DFA0EF4) {
        if(scripts\engine\utility::cointoss())
          head = "head_bg_var_head_bg_male_09_head_sc_male_14";
        else
          head = "head_bg_var_head_male_bc_01_head_hero_gator";
      } else if(scripts\engine\utility::cointoss())
        head = "head_bg_var_head_female_bc_01_head_sc_female_10";
      else
        head = "head_bg_var_head_sc_female_04_head_female_bc_02";
    }

    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(weapon)) {
    _id_E71CCB5E6023BCDD = spawn("script_model", (0, 0, 0));
    _id_E71CCB5E6023BCDD setModel(weapon);
    _id_E71CCB5E6023BCDD linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread scripts\engine\utility::delete_on_death(_id_E71CCB5E6023BCDD);
    guy.weapon = _id_E71CCB5E6023BCDD;
  }

  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_0609C1B125A13456)) {
    thread scripts\engine\utility::delete_on_death(guy);
    guy linkTo(self, _id_0609C1B125A13456, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

initanims(subtype, team, originalsubtype) {
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype, team, originalsubtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_off", ::customground, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "free_look", scripts\mp\utility\infilexfil::player_free_look, "mi8_infil");
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mi8_infil"] = % mp_infil_mi8_guyl_01;
  level.scr_animname["slot_0"]["mi8_infil"] = "mp_infil_mi8_guyL_01";
  level.scr_eventanim["slot_0"]["mi8_infil"] = "infil_mi8_left_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mi8_infil"] = % mp_infil_mi8_guyl_02;
  level.scr_animname["slot_1"]["mi8_infil"] = "mp_infil_mi8_guyL_02";
  level.scr_eventanim["slot_1"]["mi8_infil"] = "infil_mi8_left_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mi8_infil"] = % mp_infil_mi8_guyl_03;
  level.scr_animname["slot_2"]["mi8_infil"] = "mp_infil_mi8_guyL_03";
  level.scr_eventanim["slot_2"]["mi8_infil"] = "infil_mi8_left_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mi8_infil"] = % mp_infil_mi8_guyl_04;
  level.scr_animname["slot_3"]["mi8_infil"] = "mp_infil_mi8_guyL_04";
  level.scr_eventanim["slot_3"]["mi8_infil"] = "infil_mi8_left_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mi8_infil"] = % mp_infil_mi8_guyl_05;
  level.scr_animname["slot_4"]["mi8_infil"] = "mp_infil_mi8_guyL_05";
  level.scr_eventanim["slot_4"]["mi8_infil"] = "infil_mi8_left_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mi8_infil"] = % mp_infil_mi8_guyl_06;
  level.scr_animname["slot_5"]["mi8_infil"] = "mp_infil_mi8_guyL_06";
  level.scr_eventanim["slot_5"]["mi8_infil"] = "infil_mi8_left_6";
  level.scr_animtree["slot_6"] = #animtree;
  level.scr_anim["slot_6"]["mi8_infil"] = % mp_infil_mi8_guyr_01;
  level.scr_animname["slot_6"]["mi8_infil"] = "mp_infil_mi8_guyR_01";
  level.scr_eventanim["slot_6"]["mi8_infil"] = "infil_mi8_right_1";
  level.scr_animtree["slot_7"] = #animtree;
  level.scr_anim["slot_7"]["mi8_infil"] = % mp_infil_mi8_guyr_02;
  level.scr_animname["slot_7"]["mi8_infil"] = "mp_infil_mi8_guyR_02";
  level.scr_eventanim["slot_7"]["mi8_infil"] = "infil_mi8_right_2";
  level.scr_animtree["slot_8"] = #animtree;
  level.scr_anim["slot_8"]["mi8_infil"] = % mp_infil_mi8_guyr_03;
  level.scr_animname["slot_8"]["mi8_infil"] = "mp_infil_mi8_guyR_03";
  level.scr_eventanim["slot_8"]["mi8_infil"] = "infil_mi8_right_3";
  level.scr_animtree["slot_9"] = #animtree;
  level.scr_anim["slot_9"]["mi8_infil"] = % mp_infil_mi8_guyr_04;
  level.scr_animname["slot_9"]["mi8_infil"] = "mp_infil_mi8_guyR_04";
  level.scr_eventanim["slot_9"]["mi8_infil"] = "infil_mi8_right_4";
  level.scr_animtree["slot_10"] = #animtree;
  level.scr_anim["slot_10"]["mi8_infil"] = % mp_infil_mi8_guyr_05;
  level.scr_animname["slot_10"]["mi8_infil"] = "mp_infil_mi8_guyR_05";
  level.scr_eventanim["slot_10"]["mi8_infil"] = "infil_mi8_right_5";
  level.scr_animtree["slot_11"] = #animtree;
  level.scr_anim["slot_11"]["mi8_infil"] = % mp_infil_mi8_guyr_06;
  level.scr_animname["slot_11"]["mi8_infil"] = "mp_infil_mi8_guyR_06";
  level.scr_eventanim["slot_11"]["mi8_infil"] = "infil_mi8_right_6";
}

#using_animtree("mp_vehicles_always_loaded");

vehicles_alpha_anims(subtype, team, originalsubtype) {
  mapname = getDvar("g_mapname");

  if(isDefined(originalsubtype) && subtype != originalsubtype && (mapname == "mp_downtown_gw" || mapname == "mp_port2_gw")) {
    switch (originalsubtype) {
      case "alpha1":
        if(team == "axis") {
          if(mapname == "mp_downtown_gw")
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_downtown_east;

          if(mapname == "mp_port2_gw")
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_port_east;
        } else {
          if(mapname == "mp_downtown_gw")
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_downtown_west;

          if(mapname == "mp_port2_gw")
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_port_west;
        }

        break;
      case "alpha2":
        if(team == "axis")
          level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a2_heli_downtown_east;
        else
          level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a2_heli_downtown_west;

        break;
    }
  } else {
    switch (subtype) {
      case "alpha":
        level.scr_animtree["mi8"] = #animtree;

        switch (getDvar("g_mapname")) {
          case "mp_downtown_gw":
            if(team == "axis")
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_downtown_east;
            else
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_downtown_west;

            break;
          case "mp_quarry2":
          case "mp_farms2_gw":
            if(team == "axis")
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_quarry_east;
            else
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_quarry_east;

            break;
          case "mp_port2_gw":
            if(team == "axis")
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_port_east;
            else
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_port_west;

            break;
          default:
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_heli;
            break;
        }

        break;
      case "bravo":
        level.scr_animtree["mi8"] = #animtree;

        switch (getDvar("g_mapname")) {
          case "mp_quarry2":
          case "mp_farms2_gw":
            if(team == "axis")
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_quarry_east;
            else
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_quarry_east;

            break;
          case "mp_port2_gw":
            if(team == "axis")
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_port_east;
            else
              level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_port_west;

            break;
          default:
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_heli;
            break;
        }

        break;
      default:
        level.scr_anim["mi8"]["mi8_infil_" + subtype] = % mp_infil_mi8_heli;
        break;
    }
  }
}

spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;
  model = "veh8_mil_air_mindia8_infil_x";

  if(team == "allies")
    model = "veh8_mil_air_mindia8_west_infil_x";

  vehicle = spawnVehicle(model, _id_CA85A0DE365C6A63, "mi8_infil_mp", spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle.animname = "mi8";
  vehicle setCanDamage(0);
  vehicle notsolid();
  vehicle.infil = self;
  return vehicle;
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players) {
    if(soundexists(alias))
      self playsoundtoplayer(alias, player);
  }
}

driver_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

getcommanderassets(team) {
  data = spawnStruct();
  data.body = "body_mp_eastern_fireteam_east_sg_no_sling";
  data.head = "head_mp_eastern_fireteam_east_ar_4";
  return data;
}

customground(guy) {
  scripts\mp\utility\infilexfil::cam_shake_off(guy);

  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;
}

modifyscenenode(infil, team, subtype) {
  switch (level.mapname) {
    case "mp_quarry2":
      switch (team) {
        case "allies":
          switch (subtype) {
            case "alpha":
              break;
            case "bravo":
              infil.origin = infil.origin + anglesToForward(infil.angles) * 200;
              break;
          }

          break;
        case "axis":
          switch (subtype) {
            case "alpha":
              break;
            case "bravo":
              infil.origin = infil.origin + anglestoup(infil.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}