/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_75e58dc9392eee8.gsc
***********************************************/

_id_6E0DA54E3DBFD74F() {
  if(isDefined(game["completed_infil"]) || isDefined(level._id_6E0DA54E3DBFD74F)) {
    return;
  }
  init_anims();
  level._id_C3DA524E90FA9FB4 = 1;
  _id_CA85A0DE365C6A63 = "alpha";
  team = "allies";
  animnode = scripts\engine\utility::getStruct("animnode_van_infil", "targetname");
  infil = spawn("script_origin", animnode.origin);
  infil.angles = animnode.angles;
  infil.scene_node = animnode;
  infil scripts\engine\utility::ent_flag_init("infil_started");
  infil scripts\engine\utility::ent_flag_init("infil_stopped");
  infil scripts\engine\utility::ent_flag_init("actor_infil_done");
  infil._id_810484F76EA98E04 = 0;
  level._id_6E0DA54E3DBFD74F = infil;
  van = _id_5C7CB7B1BC8D7ABE(_id_CA85A0DE365C6A63, team, animnode);
  waitframe();
  infil.linktoent = van;
  infil spawnactors("allies", "van_infil");
  infil.linktoent scripts\common\anim::anim_first_frame(infil.actors, "van_infil", "tag_origin_animate");
  infil scripts\common\anim::anim_first_frame_solo(van, "van_infil");
  van vehicle_turnengineoff();

  if(getdvarint("dvar_03BBBED1090811C4", 0) == 0) {
    wait 5;

    while(!isDefined(level.players) || level.players.size == 0)
      wait 0.1;

    scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  }

  foreach(player in level.players)
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);

  infil thread _id_6D7723FE67D5EAF1::_id_A473D9A212709C78(van);
  wait 3;

  foreach(player in level.players)
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.5);

  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_set("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  allies = scripts\cp\cp_agent_utils::getaliveagentsofteam("allies");
  _id_9654B44E70F08AF6 = allies[0];
  _id_9654B44E70F08AF6 _id_6AD5EEDEE8EBE602(infil);
  _id_9654B44E70F08AF6 thread _id_F3159F2BC6FE1963(infil);
  thread _id_2D1D42D587EE4FF6();
  infil thread _id_948D91861E0F9F53(van, _id_CA85A0DE365C6A63);
  infil thread _id_E181F241C2D56EAB();
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("actor_infil_done");
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_set("infil_stopped");
  game["completed_infil"] = 1;
  level._id_C3DA524E90FA9FB4 = 0;
  setDvar("r_spotLightEntityShadows", 0);
}

_id_9FA4D7CCFBEA1242() {
  init_anims();
  animnode = scripts\engine\utility::getStruct("animnode_van_infil", "targetname");
  van = _id_5C7CB7B1BC8D7ABE("alpha", "allies", animnode);
  van vehicle_turnengineoff();
  van thread _id_D7A38553171B4024();
}

_id_D7A38553171B4024() {
  guys = [];
  guys[0] = self;
  scripts\common\anim::anim_first_frame(guys, "van_infil");
  waitframe();
  scripts\common\anim::anim_set_time(guys, "van_infil", 1.0);
  animation = scripts\engine\utility::getanim("van_infil");
  _id_01079B2F7AE39DD0 = getmovedelta(animation);
  rotation = getangledelta3d(animation);
  _id_357AE03F80F39459 = rotatevector(_id_01079B2F7AE39DD0, self.angles);
  origin = self.origin + _id_357AE03F80F39459;
  angles = combineangles(self.angles, rotation);
  self vehicle_teleport(origin, angles);
}

_id_5C7CB7B1BC8D7ABE(_id_CA85A0DE365C6A63, team, animnode) {
  van = spawnVehicle("veh9_civ_lnd_van_cargo_windows_infil", _id_CA85A0DE365C6A63, "veh9_civ_lnd_van_cargo_physics_mp", animnode.origin, animnode.angles);
  van._id_7E7897FE05B6D0B3 = 1;
  van setvehicleteam(team);
  van.animname = "van";
  collision = getEnt("infil_van_brushmodel_coll", "targetname");

  if(isDefined(collision)) {
    collision.root = getEnt(collision.target, "targetname");
    collision linkTo(collision.root);
    collision.root linkTo(van, "tag_body", (0, 0, 0), (0, 0, 0));
  }

  return van;
}

_id_6AD5EEDEE8EBE602(infil) {
  self.is_doing_infil = 1;
  self hide();
  infil._id_7091C9BC9D16EDCA = infil.linktoent spawn_anim_model("slot_5", "tag_origin_animate", self.model, self.headmodel, self.weapon);
  infil._id_7091C9BC9D16EDCA.infil = infil;
  infil._id_7091C9BC9D16EDCA thread _id_15999F6FCAFCA214();
}

_id_F3159F2BC6FE1963(infil) {
  _id_39CF5777B749B3D5 = scripts\engine\utility::getStruct("van_infil_plr_ending_seat_5", "targetname");
  thread _id_E18823EF10D93AB8(_id_39CF5777B749B3D5.origin, _id_39CF5777B749B3D5.angles);
  thread _id_CB2867A6847F0C1E();
  infil._id_7091C9BC9D16EDCA.head scriptmodelplayanim(level.scr_anim[infil._id_7091C9BC9D16EDCA.animname]["van_infil"]);
  infil.linktoent scripts\common\anim::anim_single_solo(infil._id_7091C9BC9D16EDCA, "van_infil", "tag_origin_animate");
}

_id_E18823EF10D93AB8(origin, angles) {
  scripts\engine\utility::waittill_any_ents_array(level.players, "player_infil_done");
  self dontinterpolate();
  self forceteleport(origin, angles);
}

_id_15999F6FCAFCA214() {
  scripts\engine\utility::waittill_any_ents_array(level.players, "player_infil_done");
  self delete();
}

_id_CB2867A6847F0C1E() {
  scripts\engine\utility::waittill_any_ents_array(level.players, "player_infil_done");
  self show();
}

_id_2D1D42D587EE4FF6() {
  allies = scripts\cp\cp_agent_utils::getaliveagentsofteam("allies");
  driver = undefined;

  foreach(ally in allies) {
    if(!istrue(ally.is_doing_infil)) {
      driver = ally;
      break;
    }
  }

  scripts\engine\utility::waittill_any_ents_array(level.players, "player_infil_done");
  _id_DB404F34F65DAC25 = scripts\engine\utility::getStruct("van_infil_driver_exit", "targetname");
  driver dontinterpolate();
  driver forceteleport(_id_DB404F34F65DAC25.origin, _id_DB404F34F65DAC25.angles);
}

_id_F97A8F50CC4EB6DF() {
  return !istrue(game["completed_infil"]) && level.start_point == "defender_infil";
}

_id_9B96DA45D4997EA6() {
  level endon("game_ended");

  while(!isDefined(level._id_6E0DA54E3DBFD74F))
    waitframe();
}

_id_EE497CACCCDD57FB(infil) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_116171939929AF39::_id_DB31AE430D191461(1);
  self._id_65F63669E088B607 = infil._id_810484F76EA98E04;
  infil._id_810484F76EA98E04++;
  spawn_pos = infil.linktoent gettagorigin("tag_origin_animate");
  _id_E21A7BAA6BA10015 = infil.linktoent gettagangles("tag_origin_animate");
  _id_EACF3E515F7290AA(infil, spawn_pos, _id_E21A7BAA6BA10015);
}

_id_FBB85F00D28DEC1D(infil) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  infil scripts\engine\utility::ent_flag_wait("infil_started");
  _id_EA8B44B699499EB1(infil);
}

_id_7DA864E4D4F3FDAC() {
  self setdemeanorviewmodel("normal");
  _id_116171939929AF39::_id_DB31AE430D191461(0);
}

_id_4AEF5B543EE8765B(infil) {
  _id_1DDB10EC294D24EB();
  waitframe();
  _id_8CCFDEC647DFB582 = "van_infil_plr_ending_seat_" + self._id_65F63669E088B607;
  _id_4AA5C806F0E6B17F = scripts\engine\utility::getStruct(_id_8CCFDEC647DFB582, "targetname");
  self setOrigin(_id_4AA5C806F0E6B17F.origin, 1);
  self setplayerangles(_id_4AA5C806F0E6B17F.angles);
  self dontinterpolate();
  self notify("player_infil_done");
}

_id_1DDB10EC294D24EB() {
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self notify("remove_rig");
}

_id_EA8B44B699499EB1(infil) {
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  self.player_rig.weapon_state_func = ::handleweaponstatenotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);
  thread player_disconnect();

  if(isDefined(self.animname) && !isai(self))
    thread _id_ACB0A5EF09F5F702();

  self lerpfovbypreset("80_instant");
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 15, 15, 30, 5);
  infil.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "van_infil", "tag_origin_animate");
  self notify("player_infil_done");

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["van_infil_" + infil.subtype + "_intro"]))
    setDvar("depthSortViewmodel", 0);

  thread clear_infil_ambient_zone();
  _id_1DDB10EC294D24EB();
}

player_infil_end() {
  self endon("disconnect");
  level._id_6E0DA54E3DBFD74F endon("infil_stopped");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  scripts\cp\utility\player::setdof_default();
  setDvar("depthSortViewmodel", 0);
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 3;
  self clearclienttriggeraudiozone(2);
  self clearallsoundsubmixes();
}

player_disconnect() {
  level._id_6E0DA54E3DBFD74F endon("infil_stopped");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\cp\utility\player::setdof_default();
  }
}

_id_948D91861E0F9F53(van, _id_CA85A0DE365C6A63) {
  van thread _id_E3E8566B27B746CB();
  _id_8545CD90449CCA7F = 0;
  _id_5E0676140EECDF2D = "van_" + _id_CA85A0DE365C6A63 + "_probe";
  _id_4AE45078DF12C7A7 = "van_" + _id_CA85A0DE365C6A63 + "_light";
  _id_5C3C95908409974F = "van_" + _id_CA85A0DE365C6A63 + "_lgt_origin";
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");
  _id_18A07AA6E49D2D16 = getEnt(_id_5C3C95908409974F, "targetname");
  _id_8545CD90449CCA7F = isDefined(probe) && lights.size > 0 && isDefined(_id_18A07AA6E49D2D16);

  if(_id_8545CD90449CCA7F) {
    self._id_ADDD3217BC59A7B8 = _id_BBFDAED21B5CDDBB(_id_CA85A0DE365C6A63);
    self.linktoent _id_FFA1124C73DA1AB3(self._id_ADDD3217BC59A7B8);
  }

  thread scripts\common\anim::anim_single_solo(van, "van_infil");
}

_id_E181F241C2D56EAB() {
  foreach(actor in self.actors)
  actor.head scriptmodelplayanim(level.scr_anim[actor.animname]["van_infil"]);

  self.linktoent scripts\common\anim::anim_single(self.actors, "van_infil");
  scripts\engine\utility::ent_flag_set("actor_infil_done");
}

_id_E3E8566B27B746CB() {
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_started");
  self playsoundonmovingent("scn_infil_van_driving_front");
  self playSound("scn_infil_van_driving_rear");
  level thread scripts\cp\utility::play_music_to_team("mx_cp_lone_infil");
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_stopped");
}

_id_EACF3E515F7290AA(infil, spawn_pos, _id_E21A7BAA6BA10015) {
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + self._id_65F63669E088B607, spawn_pos, _id_E21A7BAA6BA10015);
  self.player_rig linkTo(infil.linktoent);
  _id_4B9D74E8E109D11E = self.player_rig gettagangles("tag_camera_scripted");
  self setplayerangles(_id_4B9D74E8E109D11E);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
}

_id_ACB0A5EF09F5F702() {
  soundalias = "scn_infil_van_plr1";
  waittime = 4.9;

  switch (self.animname) {
    case "slot_0":
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
    case "slot_1":
      soundalias = "scn_infil_van_plr2";
      waittime = 2.1;
      break;
    case "slot_2":
      soundalias = "scn_infil_van_plr3";
      waittime = 8.3;
      break;
    case "slot_3":
      soundalias = "scn_infil_van_plr4";
      waittime = 9.5;
      break;
    case "slot_4":
      soundalias = "scn_infil_van_plr5";
      waittime = 9.5;
      break;
    case "slot_5":
      soundalias = "scn_infil_van_plr6";
      waittime = 3.0;
      break;
    default:
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
  }

  self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);
  wait(waittime);

  if(soundexists(soundalias))
    self playlocalsound(soundalias);
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(!isDefined(self.actors))
    self.actors = [];

  self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_sp_ally_mex_sf_a", "head_sp_ally_mex_sf_a");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_sp_ally_mex_sf_a", "head_sp_ally_mex_sf_a");

  foreach(actor in self.actors) {
    actor.infil = self;
    thread _id_D8D665DD360C8810(actor);
  }
}

_id_D8D665DD360C8810(ent) {
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_stopped");

  if(isDefined(ent))
    ent delete();
}

spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(weapon)) {
    _id_E71CCB5E6023BCDD = spawn("script_model", (0, 0, 0));
    _id_E71CCB5E6023BCDD setModel("wpn_wm_p00_stream_ar");
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

  if(animname == "chief") {}

  return guy;
}

handleweaponstatenotetrack(state) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  self.player endon("death_or_disconnect");

  switch (state) {
    case "drop":
      self.player setdemeanorviewmodel("normal");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_blocked");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_pending");
      self.player scripts\engine\utility::ent_flag_init("swapLoadout_complete");
      self.player scripts\engine\utility::ent_flag_set("swapLoadout_blocked");
      self.player thread cleanupswaploadoutflags();

      if(!isai(self.player) && isDefined(self) && isDefined(self.player) && isalive(self.player))
        self.player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();

      if(istrue(self.updatedversion))
        self showonlytoplayer(self.player);

      if(isDefined(self.player))
        self.player _id_3B64EB40368C1450::set("notetrack_drop", "reload", 0);

      break;
    case "raise":
      if(isDefined(self.player.infilweapon) && self.player hasweapon(self.player.infilweapon))
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player.infilweapon);

      self.player.infilweaponraise = 1;

      if(self.player scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && self.player scripts\engine\utility::ent_flag("swapLoadout_blocked"))
        self.player scripts\engine\utility::ent_flag_clear("swapLoadout_blocked");

      self.player setdemeanorviewmodel("normal");

      if(!istrue(self.updatedversion))
        self.player stopviewmodelanim();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "loadout_finalizeWeapons"))
        self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "loadout_finalizeWeapons")]]();

      if(!isai(self.player))
        self.player scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();

      if(istrue(self.updatedversion) && self.player islinked())
        self.player playerlinkedsetforceparentvisible(0);

      self.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("notetrack_drop");
      break;
    case "safe":
      if(isDefined(self._id_953281E4198E2FF7)) {
        self.player setdemeanorviewmodel("normal");
        wait 0.05;
        self.player setdemeanorviewmodel("safe", self._id_953281E4198E2FF7);
      } else
        self.player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");

      break;
    case "safe_offscreen":
      if(!isai(self))
        self showonlytoplayer(self.player);

      self.player setdemeanorviewmodel("normal");
      wait 0.05;
      self.player setdemeanorviewmodel("safe", "iw9_ges_demeanor_safe_van_gundown");
      self._id_953281E4198E2FF7 = "iw8_ges_demeanor_safe_van";
      break;
    case "normal":
      self.player setdemeanorviewmodel("normal");
      break;
    case "free":
      self.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("notetrack_hold");
      break;
    case "hold":
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "fire", 0);
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "ads", 0);
      self.player _id_3B64EB40368C1450::set("notetrack_hold", "reload", 0);
      break;
  }
}

cleanupswaploadoutflags() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(self, "death", level, "prematch_over");
  scripts\engine\utility::ent_flag_clear("swapLoadout_blocked", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_pending", 1);
  scripts\engine\utility::ent_flag_clear("swapLoadout_complete", 1);
}

init_anims() {
  _id_D17EB457D7BD3320();
  _id_8D59EA17104CCC81();
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", ::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", ::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", ::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", ::player_free_look, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_on", ::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_on", ::rumble_low, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", ::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", ::cam_shake_running, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_chief_sfx", ::_id_A0F56B3EC08B2E78, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_door_sfx", ::_id_B81E9C558F4DE6CB, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("chief", "van_close_sfx", ::_id_18B3E1AE919D6F5D, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_van_npc1", ::_id_AAF7FE816CCDF1B3, "van_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_van_npc2", ::_id_AAF7FF816CCDF3E6, "van_infil");
}

player_fov_default_2(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player lerpfovbypreset("default_2seconds");
}

player_free_look(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  if(player islinked())
    player lerpviewangleclamp(0, 0, 0, 45, 45, 45, 45);
}

rumble_low(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1);
}

updateshakeonplayer(_id_7AC5F1F9205AC776, _id_7AE8E3F92080F064, _id_FA5A6EF8C302A935, _id_5C7FA8F909B33748, _id_019067C8C80AFB50, _id_21F510057C7BF283, _id_30F2848645468450, _id_30CF7A864520269A) {
  if(istrue(level.interactiveinfil) && istrue(self.interactivecombat)) {
    return;
  }
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  level endon("prematch_over");
  level endon("infil_done");
  self endon("death_or_disconnect");

  while(isDefined(self)) {
    if(isDefined(_id_7AC5F1F9205AC776) && isDefined(_id_7AE8E3F92080F064))
      self earthquakeforplayer(randomfloatrange(_id_7AC5F1F9205AC776, _id_7AE8E3F92080F064), _id_FA5A6EF8C302A935, _id_5C7FA8F909B33748, _id_019067C8C80AFB50);

    if(isDefined(_id_21F510057C7BF283))
      self playrumbleonpositionforclient(_id_21F510057C7BF283, self.origin);

    wait(randomfloatrange(_id_30F2848645468450, _id_30CF7A864520269A));
  }
}

cam_shake_running(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread updateshakeonplayer(0.09, 0.115, 2, player.origin, 8000, undefined, 0.15, 0.5);
}

_id_A0F56B3EC08B2E78(guy) {
  guy playsoundonmovingent("scn_infil_van_chief");
}

_id_B81E9C558F4DE6CB(guy) {
  guy playsoundonmovingent("scn_infil_van_door");
}

_id_18B3E1AE919D6F5D(guy) {
  guy playsoundonmovingent("scn_infil_van_door_close");
}

_id_AAF7FE816CCDF1B3(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc1");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_AAF7FF816CCDF3E6(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_van_npc2");

  guy._id_8655D6F4C9340DB1 = 1;
}

#using_animtree("script_model");

_id_D17EB457D7BD3320() {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_seat_0;
  level.scr_animname["slot_0"]["van_infil"] = "iw9_mp_infil_van_seat_0";
  level.scr_eventanim["slot_0"]["van_infil"] = "infil_van_seat_0";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_seat_1;
  level.scr_animname["slot_1"]["van_infil"] = "iw9_mp_infil_van_seat_1";
  level.scr_eventanim["slot_1"]["van_infil"] = "infil_van_seat_1";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_seat_2;
  level.scr_animname["slot_2"]["van_infil"] = "iw9_mp_infil_van_seat_2";
  level.scr_eventanim["slot_2"]["van_infil"] = "infil_van_seat_2";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_seat_3;
  level.scr_animname["slot_3"]["van_infil"] = "iw9_mp_infil_van_seat_3";
  level.scr_eventanim["slot_3"]["van_infil"] = "infil_van_seat_3";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_seat_4;
  level.scr_animname["slot_4"]["van_infil"] = "iw9_mp_infil_van_seat_4";
  level.scr_eventanim["slot_4"]["van_infil"] = "infil_van_seat_4";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_seat_5;
  level.scr_animname["slot_5"]["van_infil"] = "iw9_mp_infil_van_seat_5";
  level.scr_eventanim["slot_5"]["van_infil"] = "infil_van_seat_5";
  level.scr_animtree["chief"] = #animtree;
  level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_chief;
  level.scr_animname["chief"]["van_infil"] = "iw9_mp_infil_van_chief";
  level.scr_eventanim["chief"]["van_infil"] = "infil_van_chief";
  level.scr_animtree["driver"] = #animtree;
  level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
  level.scr_animname["driver"]["van_infil"] = "iw9_mp_infil_van_driver";
  level.scr_eventanim["driver"]["van_infil"] = "infil_van_driver";
}

#using_animtree("mp_vehicles_always_loaded");

_id_8D59EA17104CCC81() {
  level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
}

_id_BBFDAED21B5CDDBB(subtype) {
  _id_ADDD3217BC59A7B8 = spawnStruct();
  _id_5E0676140EECDF2D = "van_" + subtype + "_probe";
  _id_4AE45078DF12C7A7 = "van_" + subtype + "_light";
  _id_5C3C95908409974F = "van_" + subtype + "_lgt_origin";
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");
  _id_18A07AA6E49D2D16 = getEnt(_id_5C3C95908409974F, "targetname");

  if(!isDefined(probe))
    return undefined;

  if(!isDefined(_id_18A07AA6E49D2D16))
    return undefined;

  foreach(_id_AC0E5E4AC96AAEA7 in lights) {
    if(!isDefined(_id_AC0E5E4AC96AAEA7))
      return undefined;
  }

  _id_ADDD3217BC59A7B8.probe = probe;
  _id_ADDD3217BC59A7B8.lights = lights;
  _id_ADDD3217BC59A7B8._id_18A07AA6E49D2D16 = _id_18A07AA6E49D2D16;
  _id_89A2405953B84136(_id_ADDD3217BC59A7B8, 1);
  return _id_ADDD3217BC59A7B8;
}

_id_FFA1124C73DA1AB3(_id_ADDD3217BC59A7B8) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe show();
  _id_ADDD3217BC59A7B8.probe linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(isDefined(_id_AC0E5E4AC96AAEA7.original_intensity))
      _id_AC0E5E4AC96AAEA7 setlightintensity(_id_AC0E5E4AC96AAEA7.original_intensity);

    _id_AC0E5E4AC96AAEA7 linkTo(_id_ADDD3217BC59A7B8._id_18A07AA6E49D2D16);
  }

  _id_ADDD3217BC59A7B8._id_18A07AA6E49D2D16.origin = self.origin;
  _id_ADDD3217BC59A7B8._id_18A07AA6E49D2D16.angles = self.angles;
  _id_ADDD3217BC59A7B8._id_18A07AA6E49D2D16 linkTo(self);
}

_id_89A2405953B84136(_id_ADDD3217BC59A7B8, _id_AC17789997E5B858) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe hide();

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(_id_AC17789997E5B858)
      _id_AC0E5E4AC96AAEA7.original_intensity = _id_AC0E5E4AC96AAEA7 getlightintensity();

    _id_AC0E5E4AC96AAEA7 setlightintensity(0.0);
  }
}