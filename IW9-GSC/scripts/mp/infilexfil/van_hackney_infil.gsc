/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\van_hackney_infil.gsc
*******************************************************/

van_hackney_init(subtype) {
  scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "spawnPersistentVan", ::spawnpersistentvehicle);
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [5, 4];
  _id_453E4FC2C649FEA4[1] = [3, 2];
  _id_453E4FC2C649FEA4[2] = [1, 0];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_van_hackney", subtype, 6, 4, _id_453E4FC2C649FEA4, ::van_hackney_spawn, ::van_hackney_get_length, ::player_van_hackney_infil_think);
}

van_hackney_spawn(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_crash2":
      scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * -50;
      clipent = getentarrayinradius("script_brushmodel", "classname", (1250, -2150, 75), 300);

      if(isDefined(clipent))
        clipent[0].origin = clipent[0].origin + anglesToForward(scene_node.angles) * -50;

      break;
  }
}

van_hackney_get_length(subtype) {
  animlength = 0.0;

  if(istrue(level.interactiveinfil))
    animlength = level.interactivecombatduration;
  else
    animlength = getanimlength(level.scr_anim["slot_0"]["van_hackney_infil_" + subtype]);

  return animlength;
}

player_van_hackney_infil_think(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");
  thread van_infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.linktoent gettagorigin("tag_origin");
  _id_B7850001037AA074 = infil.linktoent gettagangles("tag_origin");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;

  if(_id_E4B9CD561C7C0DE6 == 0)
    self lerpfovbypreset("80_instant");

  self.player_rig linkTo(infil.linktoent, "tag_origin", (0, 0, 0), (0, 0, 0));
  infil.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "van_hackney_infil_" + infil.subtype);
  thread player_van_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_van", 0.1);
    self playlocalsound("scn_mp_hackney_van_lr");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    soundalias = "scn_infil_hackney_van_plr1";

    if(isDefined(infil.subtype)) {
      if(infil.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_hackney_van_plr3";
            break;
          case "slot_1":
            soundalias = "scn_infil_hackney_van_plr2";
            break;
          case "slot_2":
            soundalias = "scn_infil_hackney_van_plr1";
            break;
          case "slot_3":
            soundalias = "scn_infil_hackney_van_plr6";
            break;
          case "slot_4":
            soundalias = "scn_infil_hackney_van_plr5";
            break;
          case "slot_5":
            soundalias = "scn_infil_hackney_van_plr4";
            break;
          default:
            soundalias = "scn_infil_hackney_van_plr3";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_hackney_van_plr3";
            break;
          case "slot_1":
            soundalias = "scn_infil_hackney_van_plr2";
            break;
          case "slot_2":
            soundalias = "scn_infil_hackney_van_plr1";
            break;
          case "slot_3":
            soundalias = "scn_infil_hackney_van_plr6";
            break;
          case "slot_4":
            soundalias = "scn_infil_hackney_van_plr5";
            break;
          case "slot_5":
            soundalias = "scn_infil_hackney_van_plr4";
            break;
          default:
            soundalias = "scn_infil_hackney_van_plr3";
            break;
        }
      }
    }

    self playlocalsound(soundalias);
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "van_hackney_infil_" + infil.subtype, "tag_origin");
  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;

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

van_infil_radio_idle(infil) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_van_intro", 1);
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 4;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC delete();
  }
}

player_van_disconnect() {
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

  if(team == "allies")
    self.actors[0] hidepart("j_sling_pivot");
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
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  gates = getEntArray("infil_opforce_gate", "targetname");

  foreach(ent in gates)
  ent hide();

  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);
  level notify("start_scene");
  level waittill("prematch_over");

  foreach(ent in gates)
  ent show();

  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", _id_E026A614F7467557);
  _id_330B9CED435F328D = getEntArray("van_hackney_infil_alpha_probe", "targetname");
  _id_93C53ACA7D492296 = getEntArray("van_probe", "script_noteworthy");
  _id_F7200B59912B6DD6 = getEntArray("van_probe_fallback", "script_noteworthy");
  _id_7A03243611606B01 = scripts\engine\utility::array_combine(_id_330B9CED435F328D, _id_93C53ACA7D492296, _id_F7200B59912B6DD6);

  if(isDefined(_id_7A03243611606B01) && _id_7A03243611606B01.size > 0) {
    foreach(probe in _id_7A03243611606B01)
    probe hide();
  }

  while(isDefined(self.actors))
    waitframe();

  level.infilsactive--;
  self delete();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  van = spawnvan(scene_node, team, _id_CA85A0DE365C6A63);
  scripts\common\anim::anim_first_frame_solo(van, "van_hackney_infil_" + _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  clip = getEnt("palfa_clip", "targetname");

  if(isDefined(clip)) {
    _id_5F83B6E30BB8AE0C = spawn("script_model", van.origin);
    _id_5F83B6E30BB8AE0C.angles = van.angles;
    _id_5F83B6E30BB8AE0C clonebrushmodeltoscriptmodel(clip);
  }

  van setscriptablepartstate("infil_lights", "on", 0);
  van setscriptablepartstate("exhaust", "on", 0);
  thread van_interior_sfx(_id_CA85A0DE365C6A63);
  scripts\common\anim::anim_single_solo(van, "van_hackney_infil_" + _id_CA85A0DE365C6A63 + "_intro");
  scripts\common\anim::anim_single_solo(van, "van_hackney_infil_" + _id_CA85A0DE365C6A63);
  scripts\common\anim::anim_single_solo(van, "van_hackney_infil_" + _id_CA85A0DE365C6A63 + "_exit");
  van setscriptablepartstate("infil_lights", "off", 0);
  van setscriptablepartstate("exhaust", "off", 0);
  game["infil"]["types"][self.type][_id_CA85A0DE365C6A63]["persistentVehicle"] = ::spawnpersistentvehicle;
  game["infil"]["types"][self.type][_id_CA85A0DE365C6A63]["vehicleOrg"] = self.linktoent.origin;
  game["infil"]["types"][self.type][_id_CA85A0DE365C6A63]["vehicleAng"] = self.linktoent.angles;
}

spawnpersistentvehicle(type, subtype) {
  spawnpos = game["infil"]["types"][type][subtype]["vehicleOrg"];
  _id_B7850001037AA074 = game["infil"]["types"][type][subtype]["vehicleAng"];
  van = spawn("script_model", spawnpos);
  van.angles = _id_B7850001037AA074;
  model = "veh8_civ_lnd_palfa_rhd_wet_infil";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_crash2")
    model = "veh8_civ_lnd_palfa_rhd_infil";

  van setModel(model);
  van.animname = "van";
  van scripts\common\anim::setanimtree();
  clip = getEnt("palfa_clip", "targetname");

  if(isDefined(clip)) {
    _id_5F83B6E30BB8AE0C = spawn("script_model", spawnpos);
    _id_5F83B6E30BB8AE0C.angles = _id_B7850001037AA074;
    _id_5F83B6E30BB8AE0C clonebrushmodeltoscriptmodel(clip);
  }
}

van_interior_sfx(_id_CA85A0DE365C6A63) {
  _id_88E114FBE86CE809 = spawn("script_model", self.linktoent.origin);
  _id_88E114FBE86CE809 linkTo(self.linktoent, "tag_door_back_left");
  _id_281505CDDA221800 = spawn("script_model", self.linktoent.origin);
  _id_281505CDDA221800 linkTo(self.linktoent, "tag_hood");
  wait 0.1;
  _id_88E114FBE86CE809 playsoundonmovingent("scn_infil_hackney_van_int_rear");
  _id_281505CDDA221800 playsoundonmovingent("scn_infil_hackney_van_int_front");
  wait 7.75;
  _id_88E114FBE86CE809 playsoundonmovingent("scn_infil_hackney_van_door_open");
  wait 8;
  _id_88E114FBE86CE809 playsoundonmovingent("scn_infil_hackney_van_door_close");
  level waittill("prematch_over");
  _id_281505CDDA221800 delete();
  _id_88E114FBE86CE809 delete();
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

van_infil_sfx_chief(guy) {
  guy playsoundonmovingent("scn_infil_hackney_van_commander");
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "van_hackney_infil_" + _id_CA85A0DE365C6A63, "tag_origin");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "van_hackney_infil_" + _id_CA85A0DE365C6A63, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["van_hackney_infil_" + _id_CA85A0DE365C6A63]);
  duration = getanimlength(level.scr_anim["commander"]["van_hackney_infil_" + _id_CA85A0DE365C6A63]);
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

initanims(subtype) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_parked", scripts\mp\utility\infilexfil::cam_shake_parked, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", ::customground, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "van_infil_sfx_npc1", ::van_infil_sfx_npc1);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "van_infil_sfx_npc2", ::van_infil_sfx_npc2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "van_infil_sfx_npc3", ::van_infil_sfx_npc3);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "van_infil_sfx_npc4", ::van_infil_sfx_npc4);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "van_infil_sfx_npc5", ::van_infil_sfx_npc5);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "van_infil_sfx_npc6", ::van_infil_sfx_npc6);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "van_hackney_infil_alpha");
}

#using_animtree("script_model");

script_model_alpha_anims() {
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["van_hackney_infil_alpha"] = % infil_opforce_van_driver;
  level.scr_animname["driver"]["van_hackney_infil_alpha"] = "infil_opforce_van_driver";
  level.scr_animtree["commander"] = #animtree;
  level.scr_anim["commander"]["van_hackney_infil_alpha"] = % infil_opforce_van_chief;
  level.scr_animname["commander"]["van_hackney_infil_alpha"] = "infil_opforce_van_chief";
  scripts\common\anim::addnotetrack_customfunction("commander", "sfx_infil_hackney_van_commander", ::van_infil_sfx_chief);
  level.scr_animtree["van"] = #animtree;

  switch (getDvar("g_mapname")) {
    case "mp_spear":
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % mp_infil_van_veh_intro_spear;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "mp_infil_van_veh_intro_spear";
      break;
    case "mp_crash2":
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % infil_opforce_van_hackney_enter_van_mpcrash;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "infil_opforce_van_hackney_enter_van_mpcrash";
      break;
    default:
      level.scr_anim["van"]["van_hackney_infil_alpha_intro"] = % infil_opforce_van_hackney_enter_van;
      level.scr_animname["van"]["van_hackney_infil_alpha_intro"] = "infil_opforce_van_hackney_enter_van";
      break;
  }

  level.scr_anim["van"]["van_hackney_infil_alpha"] = % infil_opforce_van_van;
  level.scr_animname["van"]["van_hackney_infil_alpha"] = "infil_opforce_van_van";
  level.scr_anim["van"]["van_hackney_infil_alpha_exit"] = % infil_opforce_van_hackney_exit_van;
  level.scr_animname["van"]["van_hackney_infil_alpha_exit"] = "infil_opforce_van_hackney_exit_van";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["van_hackney_infil_alpha"] = % infil_opforce_van_1;
  level.scr_animname["slot_0"]["van_hackney_infil_alpha"] = "infil_opforce_van_1";
  level.scr_eventanim["slot_0"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["van_hackney_infil_alpha"] = % infil_opforce_van_2;
  level.scr_animname["slot_1"]["van_hackney_infil_alpha"] = "infil_opforce_van_2";
  level.scr_eventanim["slot_1"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["van_hackney_infil_alpha"] = % infil_opforce_van_3;
  level.scr_animname["slot_2"]["van_hackney_infil_alpha"] = "infil_opforce_van_3";
  level.scr_eventanim["slot_2"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["van_hackney_infil_alpha"] = % infil_opforce_van_4;
  level.scr_animname["slot_3"]["van_hackney_infil_alpha"] = "infil_opforce_van_4";
  level.scr_eventanim["slot_3"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["van_hackney_infil_alpha"] = % infil_opforce_van_5;
  level.scr_animname["slot_4"]["van_hackney_infil_alpha"] = "infil_opforce_van_5";
  level.scr_eventanim["slot_4"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["van_hackney_infil_alpha"] = % infil_opforce_van_6;
  level.scr_animname["slot_5"]["van_hackney_infil_alpha"] = "infil_opforce_van_6";
  level.scr_eventanim["slot_5"]["van_hackney_infil_alpha"] = "infil_van_hackney_alpha_6";
}

vehicles_alpha_anims() {}

spawnvan(scene_node, team, _id_CA85A0DE365C6A63) {
  van = spawn("script_model", scene_node.origin);
  van.angles = scene_node.angles;
  model = "veh8_civ_lnd_palfa_rhd_wet_infil";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm")
    model = "veh8_civ_lnd_palfa_rhd_infil";

  van setModel(model);
  van.animname = "van";
  van scripts\common\anim::setanimtree();
  van setCanDamage(0);
  self.linktoent = van;
  van.infil = self;
  _id_330B9CED435F328D = getEntArray("van_hackney_infil_alpha_probe", "targetname");
  _id_93C53ACA7D492296 = getEntArray("van_probe", "script_noteworthy");
  _id_F7200B59912B6DD6 = getEntArray("van_probe_fallback", "script_noteworthy");
  _id_83D076584339CBE2 = scripts\engine\utility::array_combine(_id_330B9CED435F328D, _id_93C53ACA7D492296, _id_F7200B59912B6DD6);
  probe = undefined;

  foreach(_id_F90358454413407F in _id_83D076584339CBE2) {
    if(isDefined(_id_F90358454413407F.van)) {
      continue;
    }
    probe = _id_F90358454413407F;
    break;
  }

  if(isDefined(probe)) {
    van.probe = probe;
    probe.van = van;
    van.probe.origin = van.origin;
    van.probe linkTo(van, "tag_origin", (-42, 0, 56.5), (0, 0, 0));

    switch (level.mapname) {
      case "mp_spear":
      case "mp_piccadilly":
      case "mp_hackney_am":
      case "mp_hackney_yard":
      case "mp_spear_pm":
      case "mp_crash2":
        van.probe hide();
        break;
    }
  }

  return van;
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

driver_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

getcommanderassets(team) {
  data = spawnStruct();

  if(team == "axis") {
    data.body = "body_mp_eastern_fireteam_east_sg_no_sling";
    data.head = "head_mp_eastern_fireteam_east_ar_4";
  } else {
    data.body = "body_mp_western_fireteam_west_smg_1_1";
    data.head = "head_mp_western_fireteam_west_smg_2_1";
  }

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