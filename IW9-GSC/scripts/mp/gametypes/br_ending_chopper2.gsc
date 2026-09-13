/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ending_chopper2.gsc
*******************************************************/

_id_E04BD99E1BB6430B() {
  scripts\engine\utility::delaythread(0.05, _id_40F4C8F2B94C5CD9::_id_C880EDBA9FACE762, "chopper2");
  _id_D32F459AB9F5E7AF();
  level._id_79C116F876DC27EB = ::_id_3D52F342AF8A087A;
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
}

_id_EB5E590400F33C26(_id_9C106D8742ED698F, _id_EA42132C318D38EB) {
  if(!isDefined(level._id_C2DF25D0CAADC76E))
    level._id_C2DF25D0CAADC76E = [];

  level._id_C2DF25D0CAADC76E[_id_9C106D8742ED698F] = _id_EA42132C318D38EB;
}

_id_3D52F342AF8A087A(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A) {
  thread _id_79304F320F2ACF0F(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A);
}

_id_79304F320F2ACF0F(winners, _id_CBFC3BA10CEFC8CE, movetime) {
  _id_3B03284FC91EB596 = "mp_gamemode_br_exfils";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_ending_chopper2", "getExfilSoundbank"))
    _id_3B03284FC91EB596 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_ending_chopper2", "getExfilSoundbank")]]();

  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA(_id_3B03284FC91EB596);
  _func_6F9B54CEA87F1C9E();
  wait 1.0;
  winners = scripts\engine\utility::_id_53C4C53197386572(winners, []);
  _id_CBFC3BA10CEFC8CE = scripts\engine\utility::_id_53C4C53197386572(_id_CBFC3BA10CEFC8CE, (0, 0, 0));
  movetime = scripts\engine\utility::_id_53C4C53197386572(movetime, 7.0);
  endorigin = _id_CBFC3BA10CEFC8CE + (0, 0, 360);
  startorigin = endorigin + (-7200, 7200, 1800);
  _id_932B2A9D1EC49D28 = spawn("script_model", startorigin);
  _id_932B2A9D1EC49D28 forcenetfieldhighlod(1);
  waitframe();
  _id_932B2A9D1EC49D28 playsoundonmovingent("veh_br_palfa_exfil_incoming");
  _id_932B2A9D1EC49D28 moveTo(endorigin, movetime);
  wait(movetime);
  _id_932B2A9D1EC49D28 delete();
}

chopperexfil_pack(_id_CBFC3BA10CEFC8CE) {
  if(!isDefined(_id_CBFC3BA10CEFC8CE))
    _id_CBFC3BA10CEFC8CE = (0, 0, 0);

  foreach(player in level.players)
  player setclientomnvar("ui_br_infil_exfil_player_focus", -1);

  if(!getdvarint("dvar_19A406E3C51CE52F")) {
    self.transientname = get_chopperexfil_transient();
    loadinfiltransient(self.transientname);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);

    for(_id_24B79087F3897E94 = 0; !_id_24B79087F3897E94; _id_24B79087F3897E94 = _func_2030CC4AD67D1634(self.transientname))
      waitframe();
  }

  chopper = _id_40F4C8F2B94C5CD9::_id_38C7F6BC1DEEF269("veh9_mil_air_heli_palfa_doors_open_x_vehphys_mp_exfil", undefined, "veh9_mil_air_heli_palfa_physics_mp_exfil");
  chopper setscriptablepartstate("engine", "on", 0);
  chopper vehicle_turnengineoff();

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    chopper setscriptablepartstate("running_lights_pm", "off");

  chopper._id_6A704063A0555C1D = 1;
  _id_0E25D1D189177A7C = scripts\engine\utility::ter_op(isDefined(level._id_81A5664BB0C0DD5A), level._id_81A5664BB0C0DD5A, "chopper2");
  _id_32CDBD0F9DA13261 = _id_40F4C8F2B94C5CD9::_id_8C2D124DBEF4FA60(_id_0E25D1D189177A7C, chopper);
  self._id_32CDBD0F9DA13261 = _id_32CDBD0F9DA13261;
  self.exfilchopper = chopper;
  _id_40F4C8F2B94C5CD9::chopperexfil_set_brcircle();
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0)
    _id_40F4C8F2B94C5CD9::create_disconnectplayer(self);
  else
    _id_45D36B9C3FC63236(chopper, self.winners[0]);

  _id_7FA848E5B3BBC437 = getdvarint("dvar_CF55E0F95935F5AF", 1);

  if(getdvarint("dvar_19A406E3C51CE52F") || getdvarint("dvar_2D200A3DA7FB2518"))
    _id_7FA848E5B3BBC437 = 0;

  _id_ECB33625634B60D3 = getDvar("dvar_44A16FA7B3BE2B2F", "");
  _id_062C595D55B88B26::_id_74497A0F417E329F(self.winners);
  _id_5C6B989A6F25F7FA::_id_226B83F846D32FF2(self.winners);
  _id_062C595D55B88B26::_id_05864D7EEAC0E9AC(self.winners, _id_7FA848E5B3BBC437, _id_ECB33625634B60D3);
  _id_656E81044214634C = _id_40F4C8F2B94C5CD9::spawn_script_model("fullbody_mp_ally_helicopter_crew_chief_exfil");
  _id_656E81044214634C hide(1);
  self._id_656E81044214634C = _id_656E81044214634C;
  _id_26693A5D52D6CE1A = _id_40F4C8F2B94C5CD9::spawn_script_model("fullbody_usmc_ar_br_infil");
  _id_26693A5D52D6CE1A hide(1);
  self._id_26693A5D52D6CE1A = _id_26693A5D52D6CE1A;
  self.cam = _id_40F4C8F2B94C5CD9::create_cam();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_ending_chopper2", "getAnimPack"))
    self.pack = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_ending_chopper2", "getAnimPack")]](chopper, _id_32CDBD0F9DA13261, _id_656E81044214634C, 0.25);
  else {
    self.packs = [];
    n = 0;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene1");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([], ::_id_56D4E443A1C8A4B5);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[4], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[5], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[6], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_fem_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(_id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_doorguy_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_camera_sh010"], "wz_iw9_exfil_intro_xcam_sh010");
    n++;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene3");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([], ::_id_B33B68F751A3CBAE);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[4], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[5], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[6], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_fem_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(_id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_doorguy_sh030"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_camera_sh030"], "wz_iw9_exfil_intro_xcam_sh030");
    n++;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene4");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);

    if(self.winners.size == 1)
      self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_solo_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_solo_fem_sh040"]);
    else
      self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_fem_sh040"]);

    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[4], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[5], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[6], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh040"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_fem_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(_id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_doorguy_sh040"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_camera_sh040"], "wz_iw9_exfil_intro_xcam_sh040");
    n++;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene5");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[4], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[5], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[6], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh050"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_fem_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(_id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_doorguy_sh050"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_camera_sh050"], "wz_iw9_exfil_intro_xcam_sh050");
    n++;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene6");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_324C1A95A562301E);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[4], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[5], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[6], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh060"], level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_fem_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(_id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_doorguy_sh060"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_camera_sh060"], "wz_iw9_exfil_intro_xcam_sh060");
    n = _id_0BB81F97536F811F(n);
    n++;
    self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene56");
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([], ::_id_BEFD09011A539D7A);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_2D3425695113E32B);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_outro_helicopter_sh010"]);
    self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(_id_32CDBD0F9DA13261);
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_outro_camera_sh010"], "wz_iw9_exfil_outro_xcam_sh010");
  }

  self._id_43FA788E45FC7B1E = getstartorigin(self.origin, self.angles, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_helicopter_sh010"]);
}

_id_45D36B9C3FC63236(chopper, player) {
  if(isDefined(player.vehiclecustomization)) {
    _id_35FD13041DDE93E8 = scripts\cp_mp\vehicles\vehicle::_id_471CDE1983A05F66(player, "veh9_palfa");

    if(isDefined(_id_35FD13041DDE93E8)) {
      chopper._id_35FD13041DDE93E8 = _id_35FD13041DDE93E8;
      chopper _meth_788D3C14D6B4BA6B(_id_35FD13041DDE93E8.ref);
    }
  }
}

_id_A5538B1593309BB0() {
  _id_79A78F73D2D4925D = [];
  _id_078258CA0B59079A = 30.0;
  _id_E4C66FC441E3F497 = 68.0;
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh010"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh030"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh040"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh050"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator01_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator02_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator03_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator04_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator05_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator06_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_operator07_sh060"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_A5C6D4F05FA73949 = "veh9_mil_air_heli_palfa_doors_open_x_vehphys_mp_exfil";
  _id_FB88F2D5ECEBB3E1 = (0, 0, -70);
  _id_EA07460C784BE362 = 350.0;
  _id_ABA9DA4BE1CE5CE2 = 10;
  _id_D4364A524E8A2BCD = 1;
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh010"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh030"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh040"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh050"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh060"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_outro_helicopter_sh010"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_outro_helicopter_sh010"], 0.99, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh010"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh030"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh040"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh050"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_intro_helicopter_sh060"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2, _id_D4364A524E8A2BCD);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["wz_iw9_exfil_outro_helicopter_sh010"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, 200, _id_D4364A524E8A2BCD);
  return _id_79A78F73D2D4925D;
}

_id_BC14125CC728C43C() {
  _id_A2F250A190B79409 = ["light_009", "light_010", "light_003", "light_012", "light_008", "light_012", "light_013", "light_016"];

  if(isDefined(self._id_32CDBD0F9DA13261)) {
    foreach(light in self._id_32CDBD0F9DA13261.lights) {
      if(isDefined(light.name) && scripts\engine\utility::array_contains(_id_A2F250A190B79409, light.name))
        light._id_F6F4314E3EB6DDCB = 0.0;
    }
  }
}

_id_CD166DFB41041FB2() {
  _id_A2F250A190B79409 = ["light_009", "light_010", "light_003", "light_012", "light_008", "light_012", "light_013", "light_016"];

  if(isDefined(self._id_32CDBD0F9DA13261)) {
    foreach(light in self._id_32CDBD0F9DA13261.lights) {
      if(isDefined(light.name) && scripts\engine\utility::array_contains(_id_A2F250A190B79409, light.name))
        light._id_F6F4314E3EB6DDCB = undefined;
    }
  }
}

_id_98486F8B479597E1(_id_477C1209E5432ABE) {
  if(_id_477C1209E5432ABE <= 0.0)
    _id_477C1209E5432ABE = 0.0;
  else if(_id_477C1209E5432ABE >= 1.0)
    _id_477C1209E5432ABE = 1.0;

  _id_C5FAA94190723347 = int(_id_477C1209E5432ABE * 100.0);
  _id_C5FAA94190723347 = _id_C5FAA94190723347 - scripts\engine\utility::mod(_id_C5FAA94190723347, 10);
  self setscriptablepartstate("wind", scripts\engine\utility::string(_id_C5FAA94190723347), 1);
}

_id_48B6AD7AFC978B6C() {
  self endon("stopWind");
  _id_1E51BF3BEB996BEA = getdvarfloat("dvar_35E512315EC17F9E", -175.0);
  _id_9C1B24ED417256AC = getdvarfloat("dvar_35C124315E992C7C", -275.0);

  for(;;) {
    baseorigin = self.exfilchopper.origin;
    baseangles = self.exfilchopper.angles;

    if(!isDefined(baseangles))
      baseangles = (0, 0, 0);

    _id_1C4B07EADA9FB0AD = anglesToForward(baseangles);
    _id_B6217B906C6BE73E = scripts\engine\utility::array_add(self.winners, self._id_656E81044214634C);

    foreach(operator in _id_B6217B906C6BE73E) {
      if(!isDefined(operator)) {
        continue;
      }
      if(istrue(operator.isdisconnectplayer)) {
        continue;
      }
      _id_2024448B0E38D2CD = operator.origin - baseorigin;
      _id_A6C6221A1040F454 = scripts\engine\math::scalar_projection(_id_1C4B07EADA9FB0AD, _id_2024448B0E38D2CD);
      _id_1865B7643C24139D = (_id_A6C6221A1040F454 - _id_1E51BF3BEB996BEA) / (_id_9C1B24ED417256AC - _id_1E51BF3BEB996BEA);
      operator _id_98486F8B479597E1(_id_1865B7643C24139D);
    }

    wait 0.1;
  }
}

clearplayerwind() {
  self notify("stopWind");
  _id_B6217B906C6BE73E = scripts\engine\utility::array_add(self.winners, self._id_656E81044214634C);

  foreach(operator in _id_B6217B906C6BE73E) {
    if(!isDefined(operator)) {
      continue;
    }
    if(istrue(operator.isdisconnectplayer)) {
      continue;
    }
    operator setscriptablepartstate("wind", "1", 1);
  }
}

_id_56D4E443A1C8A4B5(array) {
  self._id_656E81044214634C show();
  level thread _id_B9291D46181CF846(self.winners);
  _id_BC14125CC728C43C();
  _id_B6217B906C6BE73E = scripts\engine\utility::array_add(self.winners, self._id_656E81044214634C);

  foreach(operator in _id_B6217B906C6BE73E) {
    if(!isDefined(operator)) {
      continue;
    }
    if(istrue(operator.isdisconnectplayer)) {
      continue;
    }
    operator setscriptablepartstate("wind", "100", 1);
  }

  if(getdvarint("dvar_B44BA42BBA42B79E", 1)) {
    if(isDefined(self._id_43FA788E45FC7B1E)) {
      foreach(player in level.players)
      player _meth_BC667001F9DD3808(self._id_43FA788E45FC7B1E);
    }
  }
}

_id_B33B68F751A3CBAE(array) {
  thread _id_48B6AD7AFC978B6C();
}

_id_4AAB258F30CC0184(array) {
  self._id_656E81044214634C hide(1);
}

_id_B9291D46181CF846(winners) {
  _id_D39EB0D89E4B241F = 7;
  winners = scripts\engine\utility::_id_53C4C53197386572(winners, []);
  _id_C5D4AE74FE20F862 = min(winners.size, _id_D39EB0D89E4B241F);
  _id_51941101270F867D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_exfil_intro1");
  _id_B644F6544A90AC9A = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_exfil_intro1_classic");
  soundalias = "scn_br_palfa_exfil_intro";

  if(_id_C5D4AE74FE20F862 > 0) {
    _id_CE3D772E6CC183B8 = "br_exfil_intro" + _id_C5D4AE74FE20F862;
    _id_51941101270F867D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_CE3D772E6CC183B8);
    _id_B644F6544A90AC9A = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_CE3D772E6CC183B8 + "_classic");
    _id_DEC9BCCE93873125 = "scn_br_palfa_exfil_";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_ending_chopper2", "getExfilSoundPrefix"))
      _id_DEC9BCCE93873125 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_ending_chopper2", "getExfilSoundPrefix")]]();

    soundalias = _id_DEC9BCCE93873125 + _id_C5D4AE74FE20F862 + "player";
  }

  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(level.players, _id_51941101270F867D, undefined, undefined, _id_B644F6544A90AC9A);
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, soundalias);
  _id_7AB5B649FA408138::_id_4E8BA327EB12540C(level.players, "mp_br_exfil_fade", 4.0);
}

_id_324C1A95A562301E(array) {
  foreach(player in level.players)
  player setclienttriggeraudiozone("br_exfil_palfa_int", 0.0);

  _id_4AAB258F30CC0184(array);
  _id_25CF5FD8FE110865 = scripts\engine\utility::ter_op(isDefined(level._id_02FBC45A120A095D), level._id_02FBC45A120A095D, "mp_saba_exfil");
  scripts\cp_mp\utility\player_utility::_visionsetnaked(_id_25CF5FD8FE110865, 0.0);
  _func_EE7C0CCDE65DE2EC("enum_270C7FE96829828B");
  _id_3184653FDF31DB44 = makeweapon("iw9_me_fists_mp");

  foreach(player in self.winners) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.player_rig) && isDefined(player.player_rig._id_7D489A3282F9CCE0) && isDefined(player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
      player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 delete();

    if(istrue(player.isdisconnectplayer)) {
      continue;
    }
    player clearaccessory();
    player takeallweapons();
    player giveweapon(_id_3184653FDF31DB44);
    player switchtoweaponimmediate(_id_3184653FDF31DB44);
  }

  _id_CD166DFB41041FB2();
  clearplayerwind();
  thread _id_E395443832372863();
}

_id_E395443832372863() {
  _id_B1B9B4BEAAB998C7 = "scene6";
  _id_B89590F33908D177 = "scene56";
  _id_1DA0EBB14F23D56A = 0;
  _id_86EF029E00D906FE = 0.0;

  foreach(pack in self.packs) {
    if(pack.anime == _id_B89590F33908D177) {
      break;
    }

    if(!_id_1DA0EBB14F23D56A && pack.anime == _id_B1B9B4BEAAB998C7) {
      _id_1DA0EBB14F23D56A = 1;
      continue;
    }

    if(_id_1DA0EBB14F23D56A) {
      if(isDefined(pack._id_437B6BB41D98DF26)) {
        _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(pack._id_437B6BB41D98DF26);
        _id_86EF029E00D906FE = _id_86EF029E00D906FE + _id_8355076D4ED3FC96;
        continue;
      }

      animlength = getanimlength(level.scr_anim["endingCam"][pack.anime]);
      _id_86EF029E00D906FE = _id_86EF029E00D906FE + animlength;
    }
  }

  _id_86EF029E00D906FE = _id_86EF029E00D906FE - scripts\engine\utility::mod(_id_86EF029E00D906FE, 0.05);
  level thread _id_42F6E3EDE94BFA29(_id_86EF029E00D906FE);
}

_id_ACF4F08CF7755A04(array) {
  if(array.size > 0) {
    _id_7B16B71F3113D26D = array[0];

    if(isDefined(_id_7B16B71F3113D26D)) {
      foreach(winner in self.winners) {
        if(isDefined(winner) && isPlayer(winner)) {
          if(winner getentitynumber() == _id_7B16B71F3113D26D) {
            winner scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
            winner scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_ending_chopper2::hideAllButFocusPlayer()");
            continue;
          }

          winner scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
          winner scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_ending_chopper2::hideAllButFocusPlayer()");
        }
      }

      foreach(rig in self.player_rigs) {
        if(rig._id_6EA8E24D4901E87C == _id_7B16B71F3113D26D) {
          rig _id_40F4C8F2B94C5CD9::_id_E874FD3A9C016379(0, 1);
          continue;
        }

        rig _id_40F4C8F2B94C5CD9::_id_E874FD3A9C016379(1, 1);
      }
    }
  }
}

_id_A58B0CD5621C3A9B(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_assists");
  _id_ACF4F08CF7755A04(array);
  self._id_656E81044214634C show();
}

_id_54B72844C61D70D6(array) {
  self._id_656E81044214634C hide(1);
}

_id_F3FEF66A70EEF54C(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_bigguns");
  _id_ACF4F08CF7755A04(array);
  self.turret show();
}

_id_DCFF93DC43B3B24D(array) {
  self.turret hide(1);
}

_id_11C3E7F6948A2F8B(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_interrogator");
  _id_ACF4F08CF7755A04(array);
  self._id_633F01F8D61A0608 show();
}

_id_9E25517348F9BC46(array) {
  self._id_633F01F8D61A0608 hide(1);
}

_id_8A728519D4905203(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_survivor");
  _id_ACF4F08CF7755A04(array);
  self._id_656E81044214634C show();
}

_id_34B1EEDBDA30832E(array) {
  self._id_656E81044214634C hide(1);
}

_id_D194CEFAE48CF24B(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_commando");
  _id_ACF4F08CF7755A04(array);
  self._id_ABBDCD320B2C6901 show();
}

_id_874C741F98EA4106(array) {
  self._id_ABBDCD320B2C6901 hide(1);
}

_id_932662A48F4B78A0(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_killer");
  _id_ACF4F08CF7755A04(array);
  self.pistol show();
}

_id_D4167F1FB22F9B99(array) {
  self.pistol hide(1);
}

_id_4AB372DA9678B072(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_assassin");
  _id_ACF4F08CF7755A04(array);
  self.knife show();
}

_id_C1D49D4C8BBD7F8F(array) {
  self.knife hide(1);
}

_id_EFCF7C93BC6A0909(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_machinist");
  _id_ACF4F08CF7755A04(array);
  self.trophy show();
}

_id_E0B764063F385640(array) {
  self.trophy hide(1);
}

_id_A051B485BA0FB929(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_pyro");
  _id_ACF4F08CF7755A04(array);
  self.molotov show();
  self._id_2A134FC42D8FF298 show();
}

_id_2BC9B32EFC090060(array) {
  self.molotov hide(1);
  self._id_2A134FC42D8FF298 hide(1);
}

_id_15415640AFE4A773(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_breacher");
  _id_ACF4F08CF7755A04(array);
  self._id_365929041E4386ED show();
}

_id_DD6B801655A7C7DE(array) {
  self._id_365929041E4386ED hide(1);
}

_id_FEBE34F292DD99AA(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_moneybags");
  _id_ACF4F08CF7755A04(array);
  self._id_666CCC93F2A77080 show();
}

_id_0E5AF63C2421E9F7(array) {
  self._id_666CCC93F2A77080 hide(1);
}

_id_966E436219859937(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_marksman");
  _id_ACF4F08CF7755A04(array);
  self._id_CE0F2978F55FED86 show();
}

_id_8138AA473F39300A(array) {
  self._id_CE0F2978F55FED86 hide(1);
}

_id_6E62F53B0AAD04EC(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_sniper");
  _id_ACF4F08CF7755A04(array);
  self.sniper show();
}

_id_AE65051999F31FED(array) {
  self.sniper hide(1);
}

_id_25B6A50A7AA50C29(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_scout");
  _id_ACF4F08CF7755A04(array);
  self.tablet show();
}

_id_108417D7E3F01B60(array) {
  self.tablet hide(1);
}

_id_CCC949210ABF432A(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_team_objectives");
  _id_ACF4F08CF7755A04(array);
  self.laptop show();
}

_id_A5500F224FD47777(array) {
  self.laptop hide(1);
}

_id_3DA3C099A7B6D51D(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_trapper");
  _id_ACF4F08CF7755A04(array);
  self._id_656F0AE440B1B5D5 show();
  self._id_91B6C7C6D039F50E show();
  self._id_A692F7EC32DEFE8D show();
}

_id_3CF591A6FF5A5B7C(array) {
  self._id_656F0AE440B1B5D5 hide(1);
  self._id_91B6C7C6D039F50E hide(1);
  self._id_A692F7EC32DEFE8D hide(1);
}

_id_16667626A939ADAF(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_scavenger");
  _id_ACF4F08CF7755A04(array);
  self.sniper show();
  self._id_ABBDCD320B2C6901 show();
  self.pistol show();
  self._id_CE0F2978F55FED86 show();
  self._id_666CCC93F2A77080 show();
}

_id_30779E2B5ADA3052(array) {
  self.sniper hide(1);
  self._id_ABBDCD320B2C6901 hide(1);
  self.pistol hide(1);
  self._id_CE0F2978F55FED86 hide(1);
  self._id_666CCC93F2A77080 hide(1);
}

_id_FB788D97921F7D15(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_supplier");
  _id_ACF4F08CF7755A04(array);
  self.sniper show();
  self._id_ABBDCD320B2C6901 show();
  self.pistol show();
  self._id_CE0F2978F55FED86 show();
  self._id_666CCC93F2A77080 show();
  self._id_96480725B7D62AA7 show();
  self._id_26693A5D52D6CE1A show();
}

_id_CED95B76AE5616E4(array) {
  self.sniper hide(1);
  self._id_ABBDCD320B2C6901 hide(1);
  self.pistol hide(1);
  self._id_CE0F2978F55FED86 hide(1);
  self._id_666CCC93F2A77080 hide(1);
  self._id_96480725B7D62AA7 hide(1);
  self._id_26693A5D52D6CE1A hide(1);
}

_id_88EEFE51538F221D(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_medic");
  _id_ACF4F08CF7755A04(array);
  self._id_D112F8B17645F340 show();
}

_id_D76EC37713E7E07C(array) {
  self._id_D112F8B17645F340 hide(1);
}

_id_85DB091EF1712AD6(array) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_accolade_ghost");
  _id_ACF4F08CF7755A04(array);
  self.dogtags show();
}

_id_5016DA1692956A9B(array) {
  self.dogtags hide(1);
}

_id_42F6E3EDE94BFA29(_id_86EF029E00D906FE) {
  _id_86EF029E00D906FE = scripts\engine\utility::_id_53C4C53197386572(_id_86EF029E00D906FE, 0.0);

  if(_id_86EF029E00D906FE > 1.5) {
    waittime = _id_86EF029E00D906FE - 1.5;
    wait(waittime);
  }

  foreach(player in level.players)
  player clearclienttriggeraudiozone(1.5);

  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "scn_br_palfa_exfil_outro");
}

_id_4D471B771B1FF7E8() {
  level waittill("br_credits_complete");
  _id_74B5B12BB6514385 = getdvarfloat("dvar_C88B807EA15B731F", 0.0);
  _id_CD1BD4A1058452DA = getdvarfloat("dvar_A1CEFFE4417264D1", 1.0);
  _id_95A318D022E623A7 = getdvarfloat("dvar_C9F5C9DB0C714FAE", 2.0);
  _id_1BB7594C18D17443 = getdvarfloat("dvar_4633BCE56A15979A", 1.0);

  if(_id_74B5B12BB6514385 > 0)
    wait(_id_74B5B12BB6514385);

  level._id_9B73AFBDE2775159 = 1;
  level thread _id_40F4C8F2B94C5CD9::_id_C300D34E34164B6D(_id_CD1BD4A1058452DA, _id_95A318D022E623A7, _id_1BB7594C18D17443);

  if(_id_CD1BD4A1058452DA > 0)
    wait(_id_CD1BD4A1058452DA);

  level notify("br_ending_skip_scene");
}

_id_C63452AE16FA9DF1(val) {
  level notify("br_credits_complete");
}

_id_BEFD09011A539D7A(array) {
  if(getdvarint("dvar_B44BA42BBA42B79E", 1)) {
    foreach(player in level.players)
    player clearpredictedstreampos();
  }

  scripts\cp_mp\utility\player_utility::_visionsetnaked("", 0.0);

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self.exfilchopper setscriptablepartstate("running_lights_pm", "on");

  _func_90FB4916AA7FD9F3("enum_270C7FE96829828B");
  _func_EE7C0CCDE65DE2EC("enum_2D625FB2F0FF42FB");

  if(!_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch()) {
    setomnvarforallclients("post_game_state", 14);
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  level scripts\common\ui::lui_registercallback("br_credits_complete", ::_id_C63452AE16FA9DF1);
  level thread _id_4D471B771B1FF7E8();
}

_id_2D3425695113E32B(array) {
  if(!istrue(level._id_9B73AFBDE2775159))
    level thread _id_40F4C8F2B94C5CD9::_id_C300D34E34164B6D(undefined, 2.0, 1.0);

  level._id_9B73AFBDE2775159 = undefined;
  _func_90FB4916AA7FD9F3("enum_2D625FB2F0FF42FB");
  level thread _id_C4EBE940E6D84D42();
}

_id_C4EBE940E6D84D42() {
  wait 60.0;
  _id_3B03284FC91EB596 = "mp_gamemode_br_exfils";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_ending_chopper2", "getExfilSoundbank"))
    _id_3B03284FC91EB596 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("br_ending_chopper2", "getExfilSoundbank")]]();

  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D(_id_3B03284FC91EB596);
}

get_chopperexfil_transient() {
  switch (level.script) {
    case "mp_br_mechanics_pm":
    case "mp_br_mechanics":
      return "mp_infil_br_mechanics_ending_chopper2_tr";
    case "mp_saba_pm":
      return "mp_infil_br_saba_pm_ending_chopper2_tr";
    case "mp_saba":
    case "mp_saba2":
      return "mp_infil_br_saba_ending_chopper2_tr";
    case "mp_sealion":
      return "mp_infil_br_sealion_ending_chopper2_tr";
    case "mp_delta":
      return "mp_infil_delta_ending_chopper2_tr";
    case "mp_delta_pm":
      return "mp_infil_delta_pm_ending_chopper2_tr";
    case "mp_mgl_escape4":
      return "mp_infil_br_escape4_ending_chopper2_tr";
  }

  return "";
}

_id_D32F459AB9F5E7AF() {
  _id_EB5E590400F33C26("assists", ::_id_B3B9870BEB16D86A);
  _id_EB5E590400F33C26("bigguns", ::_id_7E54A96EA5E607D6);
  _id_EB5E590400F33C26("interrogator", ::_id_012E989117D690D7);
  _id_EB5E590400F33C26("survivor", ::_id_2AEFBD13A387E43B);
  _id_EB5E590400F33C26("commando", ::_id_CD69F0DB8F84CBE3);
  _id_EB5E590400F33C26("killer", ::_id_2E1F07B2BE2D2FA2);
  _id_EB5E590400F33C26("assassin", ::_id_4D1476B502255ACC);
  _id_EB5E590400F33C26("machinist", ::_id_AA5A08332191098D);
  _id_EB5E590400F33C26("pyro", ::_id_8B2BDBA1733047BD);
  _id_EB5E590400F33C26("breacher", ::_id_9DD165DBFB566C1B);
  _id_EB5E590400F33C26("moneybags", ::_id_B708B05C5B1F9748);
  _id_EB5E590400F33C26("marksman", ::_id_21DEB471E3977DB7);
  _id_EB5E590400F33C26("sniper", ::_id_B8C41DB7E4F3C4F2);
  _id_EB5E590400F33C26("scout", ::_id_D1CA14FC67A1A96D);
  _id_EB5E590400F33C26("teamobjectives", ::_id_64E12D18ECC4E758);
  _id_EB5E590400F33C26("trapper", ::_id_AAA9C9C9A239388D);
  _id_EB5E590400F33C26("scavenger", ::_id_AE31B668B8588403);
  _id_EB5E590400F33C26("supplier", ::_id_E95E12D39F4B87D9);
  _id_EB5E590400F33C26("medic", ::_id_3AC76BB4E8C880E1);
  _id_EB5E590400F33C26("ghost", ::_id_9A174D9E60E5CA74);
}

_id_0BB81F97536F811F(n) {
  foreach(_id_16A81C74CE61860E in level._id_6B11625ABE5346B0) {
    _id_B37316FAE4667B00 = _id_16A81C74CE61860E.ref;
    player = _id_16A81C74CE61860E.player;
    _id_1384D9221443F717 = level._id_BCF7BE5C24905AB9[_id_B37316FAE4667B00];
    _id_32FADF218FE865AD = level._id_C2DF25D0CAADC76E[_id_1384D9221443F717.name];
    n = [[_id_32FADF218FE865AD]](n, player);
  }

  return n;
}

_id_734A8512EBF4E928(player, array) {
  _id_B37316FAE4667B00 = array[0];
  _id_5A4F63372F6A484D = array[1];
  _id_CAA2AFB2CDCB7815 = level._id_E3FCA817C22E740D[_id_B37316FAE4667B00];
  _id_C7DF9D76114D30F4 = 0;

  if(isDefined(_id_5A4F63372F6A484D))
    _id_C7DF9D76114D30F4 = _id_5A4F63372F6A484D getentitynumber();

  _id_5C9DDCF56D36F133 = _id_C7DF9D76114D30F4;
  _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 | _id_CAA2AFB2CDCB7815 << 8;
  player setclientomnvar("ui_br_infil_exfil_player_focus", _id_5C9DDCF56D36F133);
}

_id_B3B9870BEB16D86A(n, player) {
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("assists");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(48.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_A58B0CD5621C3A9B);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_54B72844C61D70D6);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["assists", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_656E81044214634C, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_operator02_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assists_camera_sh010"], "wz_IW9_exfil_acc_assists_xcam_sh010");
  return n;
}

_id_7E54A96EA5E607D6(n, player) {
  if(!isDefined(self.turret)) {
    self.turret = _id_40F4C8F2B94C5CD9::spawn_script_model("weapon_vm_mg_sentry_turret_exfil");
    self.turret hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("biggunsA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_F3FEF66A70EEF54C);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_DCFF93DC43B3B24D);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["bigguns", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_bigguns_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_bigguns_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_bigguns_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.turret, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_bigguns_mg_sentry_turret_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_bigguns_camera_sh010"], "wz_iw9_exfil_acc_bigguns_xcam_sh010");
  return n;
}

_id_012E989117D690D7(n, player) {
  if(!isDefined(self._id_633F01F8D61A0608)) {
    self._id_633F01F8D61A0608 = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand1h_smartphone_exfil");
    self._id_633F01F8D61A0608 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("interrogatorA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_11C3E7F6948A2F8B);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["interrogator", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_633F01F8D61A0608, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_smphones_01_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_camera_sh010"], "wz_iw9_exfil_acc_interrogator_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("interrogatorB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_9E25517348F9BC46);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_operator01_sh020"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_633F01F8D61A0608, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_smphones_01_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_interrogator_camera_sh020"], "wz_iw9_exfil_acc_interrogator_xcam_sh020");
  return n;
}

_id_2AEFBD13A387E43B(n, player) {
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("survivor");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_8A728519D4905203);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_34B1EEDBDA30832E);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["survivor", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_survivor_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_survivor_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_survivor_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_656E81044214634C, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_survivor_operator02_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_survivor_camera_sh010"], "wz_iw9_exfil_acc_survivor_xcam_sh010");
  return n;
}

_id_CD69F0DB8F84CBE3(n, player) {
  if(!isDefined(self._id_ABBDCD320B2C6901)) {
    self._id_ABBDCD320B2C6901 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p12_sh_mike1014_exfil");
    self._id_ABBDCD320B2C6901 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("commandoA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_D194CEFAE48CF24B);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["commando", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_sh_mike1014_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_camera_sh010"], "wz_iw9_exfil_acc_commando_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("commandoB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_sh_mike1014_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_camera_sh020"], "wz_iw9_exfil_acc_commando_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("commandoC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_sh_mike1014_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_camera_sh030"], "wz_iw9_exfil_acc_commando_xcam_sh030");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("commandoD");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_874C741F98EA4106);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_helicopter_sh040"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_sh040"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_operator01_fem_sh040"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_sh_mike1014_sh040"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_commando_camera_sh040"], "wz_iw9_exfil_acc_commando_xcam_sh040");
  return n;
}

_id_2E1F07B2BE2D2FA2(n, player) {
  if(!isDefined(self.pistol)) {
    self.pistol = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p27_pi_papa220_exfil");
    self.pistol hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("killerA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_932662A48F4B78A0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["killer", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_pipapa220_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_camera_sh010"], "wz_iw9_exfil_acc_killer_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("killerB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_sh020"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_pipapa220_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_camera_sh020"], "wz_iw9_exfil_acc_killer_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("killerC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_D4167F1FB22F9B99);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_pipapa220_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_killer_camera_sh030"], "wz_iw9_exfil_acc_killer_xcam_sh030");
  return n;
}

_id_4D1476B502255ACC(n, player) {
  if(!isDefined(self.knife)) {
    self.knife = _id_40F4C8F2B94C5CD9::spawn_script_model("att_wm_p33_me_tac_knife02_exfil");
    self.knife hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("assassinA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_4AB372DA9678B072);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["assassin", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.knife, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_knife_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_camera_sh010"], "wz_iw9_exfil_acc_assassin_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("assassinB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_sh020"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.knife, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_knife_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_camera_sh020"], "wz_iw9_exfil_acc_assassin_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("assassinC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_C1D49D4C8BBD7F8F);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_sh030"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.knife, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_knife_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_assassin_camera_sh030"], "wz_iw9_exfil_acc_assassin_xcam_sh030");
  return n;
}

_id_AA5A08332191098D(n, player) {
  if(!isDefined(self.trophy)) {
    self.trophy = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_2h_vm_trophy_system_exfil");
    self.trophy hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("machinistA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_EFCF7C93BC6A0909);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["machinist", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.trophy, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_2htrophy_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_camera_sh010"], "wz_iw9_exfil_acc_machinist_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("machinistB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_E0B764063F385640);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.trophy, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_2htrophy_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_machinist_camera_sh020"], "wz_iw9_exfil_acc_machinist_xcam_sh020");
  return n;
}

_id_8B2BDBA1733047BD(n, player) {
  if(!isDefined(self.molotov)) {
    self.molotov = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_2h_vm_molotov_exfil");
    self.molotov hide(1);
  }

  if(!isDefined(self._id_2A134FC42D8FF298)) {
    self._id_2A134FC42D8FF298 = _id_40F4C8F2B94C5CD9::spawn_script_model("equipment_lighter_wm_exfil");
    self._id_2A134FC42D8FF298 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("pyroA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_A051B485BA0FB929);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["pyro", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.molotov, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_molotov_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_2A134FC42D8FF298, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_lighter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_camera_sh010"], "wz_iw9_exfil_acc_pyro_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("pyroB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.molotov, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_molotov_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_2A134FC42D8FF298, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_lighter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_camera_sh020"], "wz_iw9_exfil_acc_pyro_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("pyroC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_2BC9B32EFC090060);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.molotov, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_molotov_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_2A134FC42D8FF298, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_lighter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_pyro_camera_sh030"], "wz_iw9_exfil_acc_pyro_xcam_sh030");
  return n;
}

_id_9DD165DBFB566C1B(n, player) {
  if(!isDefined(self._id_365929041E4386ED)) {
    self._id_365929041E4386ED = _id_40F4C8F2B94C5CD9::spawn_script_model("accessory_paper_wall_map_exfil");
    self._id_365929041E4386ED hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("breacherA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_15415640AFE4A773);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["breacher", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_operator01_sh010"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_365929041E4386ED, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_map_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_camera_sh010"], "wz_iw9_exfil_acc_breacher_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("breacherB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_DD6B801655A7C7DE);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_operator01_sh020"], level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_365929041E4386ED, level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_map_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_iw9_exfil_acc_breacher_camera_sh020"], "wz_iw9_exfil_acc_breacher_xcam_sh020");
  return n;
}

_id_B708B05C5B1F9748(n, player) {
  if(!isDefined(self._id_666CCC93F2A77080)) {
    self._id_666CCC93F2A77080 = _id_40F4C8F2B94C5CD9::spawn_script_model("accessory_money_bag_large_exfil");
    self._id_666CCC93F2A77080 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("moneybagsA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_FEBE34F292DD99AA);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["moneybags", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_moneybag01_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_camera_sh010"], "wz_iw9_exfil_acc_moneybags_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("moneybagsB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_moneybag01_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_camera_sh020"], "wz_iw9_exfil_acc_moneybags_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("moneybagsC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_0E5AF63C2421E9F7);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_moneybag01_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_moneybags_camera_sh030"], "wz_iw9_exfil_acc_moneybags_xcam_sh030");
  return n;
}

_id_21DEB471E3977DB7(n, player) {
  if(!isDefined(self._id_CE0F2978F55FED86)) {
    self._id_CE0F2978F55FED86 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_wm_p01_ar_mike4_exfil");
    self._id_CE0F2978F55FED86 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("marksmanA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(40.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_966E436219859937);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["marksman", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_mike4_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_camera_sh010"], "wz_iw9_exfil_acc_marksman_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("marksmanB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_mike4_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_camera_sh020"], "wz_iw9_exfil_acc_marksman_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("marksmanC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_8138AA473F39300A);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_mike4_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_marksman_camera_sh030"], "wz_iw9_exfil_acc_marksman_xcam_sh030");
  return n;
}

_id_B8C41DB7E4F3C4F2(n, player) {
  if(!isDefined(self.sniper)) {
    self.sniper = _id_40F4C8F2B94C5CD9::spawn_script_model("weapon_wm_sn_alpha50_exfil");
    self.sniper hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("sniperA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_6E62F53B0AAD04EC);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["sniper", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_snalpha50_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_camera_sh010"], "wz_iw9_exfil_acc_sniper_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("sniperB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_snalpha50_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_camera_sh020"], "wz_iw9_exfil_acc_sniper_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("sniperC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_AE65051999F31FED);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_snalpha50_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_sniper_camera_sh030"], "wz_iw9_exfil_acc_sniper_xcam_sh030");
  return n;
}

_id_D1CA14FC67A1A96D(n, player) {
  if(!isDefined(self.tablet)) {
    self.tablet = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_1h_vm_tablet_ui_v0");
    self.tablet hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scoutA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(35.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_25B6A50A7AA50C29);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["scout", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.tablet, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_tablet_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_camera_sh010"], "wz_iw9_exfil_acc_scout_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scoutB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(45.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.tablet, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_tablet_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_camera_sh020"], "wz_iw9_exfil_acc_scout_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scoutC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_108417D7E3F01B60);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.tablet, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_tablet_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scout_camera_sh030"], "wz_iw9_exfil_acc_scout_xcam_sh030");
  return n;
}

_id_64E12D18ECC4E758(n, player) {
  if(!isDefined(self.laptop)) {
    self.laptop = _id_40F4C8F2B94C5CD9::spawn_script_model("device_laptop_exfil");
    self.laptop hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("teamObjectivesA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(35.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_CCC949210ABF432A);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["teamobjectives", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.laptop, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_laptop_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_camera_sh010"], "wz_IW9_exfil_acc_team_objectives_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("teamObjectivesB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.laptop, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_laptop_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_camera_sh020"], "wz_IW9_exfil_acc_team_objectives_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("teamObjectivesC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(55.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_A5500F224FD47777);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.laptop, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_laptop_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_team_objectives_camera_sh030"], "wz_IW9_exfil_acc_team_objectives_xcam_sh030");
  return n;
}

_id_AAA9C9C9A239388D(n, player) {
  if(!isDefined(self._id_656F0AE440B1B5D5)) {
    self._id_656F0AE440B1B5D5 = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_2h_vm_c4_exfil");
    self._id_656F0AE440B1B5D5 hide(1);
  }

  if(!isDefined(self._id_91B6C7C6D039F50E)) {
    self._id_91B6C7C6D039F50E = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_wm_claymore_stack_exfil");
    self._id_91B6C7C6D039F50E hide(1);
  }

  if(!isDefined(self._id_A692F7EC32DEFE8D)) {
    self._id_A692F7EC32DEFE8D = _id_40F4C8F2B94C5CD9::spawn_script_model("offhand_wm_c4_stack_exfil");
    self._id_A692F7EC32DEFE8D hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("trapperA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_3DA3C099A7B6D51D);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["trapper", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_656F0AE440B1B5D5, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_claymore_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_91B6C7C6D039F50E, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_stack_claymore_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_A692F7EC32DEFE8D, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_stack_c4_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_camera_sh010"], "wz_iw9_exfil_acc_trapper_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("trapperB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_3CF591A6FF5A5B7C);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_656F0AE440B1B5D5, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_claymore_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_91B6C7C6D039F50E, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_stack_claymore_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_A692F7EC32DEFE8D, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_stack_c4_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_trapper_camera_sh020"], "wz_iw9_exfil_acc_trapper_xcam_sh020");
  return n;
}

_id_AE31B668B8588403(n, player) {
  if(!isDefined(self.sniper)) {
    self.sniper = _id_40F4C8F2B94C5CD9::spawn_script_model("weapon_wm_sn_alpha50_exfil");
    self.sniper hide(1);
  }

  if(!isDefined(self._id_ABBDCD320B2C6901)) {
    self._id_ABBDCD320B2C6901 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p12_sh_mike1014_exfil");
    self._id_ABBDCD320B2C6901 hide(1);
  }

  if(!isDefined(self.pistol)) {
    self.pistol = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p27_pi_papa220_exfil");
    self.pistol hide(1);
  }

  if(!isDefined(self._id_CE0F2978F55FED86)) {
    self._id_CE0F2978F55FED86 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_wm_p01_ar_mike4_exfil");
    self._id_CE0F2978F55FED86 hide(1);
  }

  if(!isDefined(self._id_666CCC93F2A77080)) {
    self._id_666CCC93F2A77080 = _id_40F4C8F2B94C5CD9::spawn_script_model("accessory_money_bag_large_exfil");
    self._id_666CCC93F2A77080 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scavengerA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_16667626A939ADAF);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["scavenger", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_alpha50_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike1014_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_papa220_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike4_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_money_bag_large_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_camera_sh010"], "wz_iw9_exfil_acc_scavenger_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scavengerB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(50.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_alpha50_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike1014_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_papa220_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike4_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_money_bag_large_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_camera_sh020"], "wz_iw9_exfil_acc_scavenger_xcam_sh020");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scavengerC");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_30779E2B5ADA3052);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_helicopter_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_sh030"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_operator01_fem_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_alpha50_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike1014_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_papa220_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_mike4_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_money_bag_large_sh030"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_scavenger_camera_sh030"], "wz_iw9_exfil_acc_scavenger_xcam_sh030");
  return n;
}

_id_E95E12D39F4B87D9(n, player) {
  if(!isDefined(self.sniper)) {
    self.sniper = _id_40F4C8F2B94C5CD9::spawn_script_model("weapon_wm_sn_alpha50_exfil");
    self.sniper hide(1);
  }

  if(!isDefined(self._id_ABBDCD320B2C6901)) {
    self._id_ABBDCD320B2C6901 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p12_sh_mike1014_exfil");
    self._id_ABBDCD320B2C6901 hide(1);
  }

  if(!isDefined(self.pistol)) {
    self.pistol = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_vm_p27_pi_papa220_exfil");
    self.pistol hide(1);
  }

  if(!isDefined(self._id_CE0F2978F55FED86)) {
    self._id_CE0F2978F55FED86 = _id_40F4C8F2B94C5CD9::spawn_script_model("wpn_wm_p01_ar_mike4_exfil");
    self._id_CE0F2978F55FED86 hide(1);
  }

  if(!isDefined(self._id_666CCC93F2A77080)) {
    self._id_666CCC93F2A77080 = _id_40F4C8F2B94C5CD9::spawn_script_model("accessory_money_bag_large_exfil");
    self._id_666CCC93F2A77080 hide(1);
  }

  if(!isDefined(self._id_96480725B7D62AA7)) {
    self._id_96480725B7D62AA7 = _id_40F4C8F2B94C5CD9::spawn_script_model("props_armor_pickup_light_exfil");
    self._id_96480725B7D62AA7 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("supplierA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(35.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_FB788D97921F7D15);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["supplier", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_alpha50_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_mike1014_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_papa220_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_mike4_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_money_bag_large_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_96480725B7D62AA7, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_vest_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_26693A5D52D6CE1A, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator02_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_camera_sh010"], "wz_iw9_exfil_acc_supplier_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("supplierB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(42.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_CED95B76AE5616E4);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.sniper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_alpha50_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_ABBDCD320B2C6901, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_mike1014_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.pistol, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_papa220_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_CE0F2978F55FED86, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_mike4_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_666CCC93F2A77080, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_money_bag_large_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_96480725B7D62AA7, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_vest_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_26693A5D52D6CE1A, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_operator02_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_supplier_camera_sh020"], "wz_iw9_exfil_acc_supplier_xcam_sh020");
  return n;
}

_id_3AC76BB4E8C880E1(n, player) {
  if(!isDefined(self._id_D112F8B17645F340)) {
    self._id_D112F8B17645F340 = _id_40F4C8F2B94C5CD9::spawn_script_model("weapon_wm_stim_exfil");
    self._id_D112F8B17645F340 hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("medicA");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(48.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_88EEFE51538F221D);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["medic", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_D112F8B17645F340, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_stim_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_camera_sh010"], "wz_iw9_exfil_acc_medic_xcam_sh010");
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("medicB");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(65.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_D76EC37713E7E07C);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_helicopter_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_operator01_sh020"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_operator01_fem_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self._id_D112F8B17645F340, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_stim_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_medic_camera_sh020"], "wz_iw9_exfil_acc_medic_xcam_sh020");
  return n;
}

_id_9A174D9E60E5CA74(n, player) {
  if(!isDefined(self.dogtags)) {
    self.dogtags = _id_40F4C8F2B94C5CD9::spawn_script_model("c_t10_gear_usa_dogtag_exfil");
    self.dogtags hide(1);
  }

  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("ghost");
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_5C32248DFFFAC064();
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_2D4C340DD3908B2D(48.0);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6098F3014CD4C598(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_6372AFDC0E9EE2DD(0.25);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([player getentitynumber()], ::_id_85DB091EF1712AD6);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_E718BA63D511FCDE(["ghost", player], ::_id_734A8512EBF4E928);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944([], ::_id_5016DA1692956A9B);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.exfilchopper, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_ghost_helicopter_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_707983B9FDB53C55(self._id_32CDBD0F9DA13261);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(player, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_ghost_operator01_sh010"], level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_ghost_operator01_fem_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(self.dogtags, level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_ghost_dogtag_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["wz_IW9_exfil_acc_ghost_camera_sh010"], "wz_iw9_exfil_acc_ghost_xcam_sh010");
  return n;
}