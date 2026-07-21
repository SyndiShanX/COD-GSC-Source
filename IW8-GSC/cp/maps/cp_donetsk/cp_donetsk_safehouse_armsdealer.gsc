/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer.gsc
******************************************************************/

registersafehouse() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_878E1C6F0D51D384F0F9D59FF349DB8ABC4BD3DFBB867A479041CBE3EBF8");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\cp_objectives::registerobjective("_encstr_822A19B6718BB9C9C573B018C91EB5F0A71C3527C42F835FADEA88", ::init_safehouse, ::start_safehouse, undefined, ::debugbeatobjective, ::debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8A17151BD7A9F74487F87B12C1F3BAAF63CD9581F91163", ::init_safehouse, ::start_safehouse, undefined, ::debugbeatobjective, ::debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_83821C0AF9E0B54A702B7727172FB3E5E0E10716B02B6AF1D613137F7540", undefined, ::_id_137FB, undefined, ::debugbeatobjective, ::debug_safehouse_return_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_A1EB1D5847A6116942F31E2D419A65D81BCB60309B7D4B4FFB9F16AD2643A1", undefined, ::_id_137FA, undefined, ::debugbeatobjective, ::debug_safehouse_return_start);
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E57();
}

debugbeatobjective(var_0) {}

debug_safehouse_return_start(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB"))
    scripts\engine\utility::flag_init("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");

  scripts\engine\utility::flag_set("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
  scripts\engine\utility::flag_wait("_encstr_A3872D91E25F20B0EA87F1C787C186403E3F7868CBDB9060F233CBCFD30AC7F0D5520661F20F68206A23D1FB8BD29D");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333");
}

debug_safehouse_start(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB"))
    scripts\engine\utility::flag_init("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");

  scripts\engine\utility::flag_set("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
  scripts\engine\utility::flag_wait("_encstr_A3872D91E25F20B0EA87F1C787C186403E3F7868CBDB9060F233CBCFD30AC7F0D5520661F20F68206A23D1FB8BD29D");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84");
}

spawn_atvs() {
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 3;

  if(!isDefined(level.atvs))
    level.atvs = [];

  var_0 = scripts\engine\utility::getStructArray("_encstr_A616153B8AAD68DD7FF25079EBBF0E28C6E75DCF015388", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

init_safehouse(var_0) {}

start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("_encstr_A3872D91E25F20B0EA87F1C787C186403E3F7868CBDB9060F233CBCFD30AC7F0D5520661F20F68206A23D1FB8BD29D");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_1 = scripts\engine\utility::getStruct("_encstr_887F1D1693B5CD192B16C6569C7D372C669534BD57CDCA7DB1B7C246F6BAA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 4096, "_encstr_B8832F40AE03C428D5C25B84A5CE2FF202DD162B6812CDC1F08A8219C5AF98D107A71856388D9F1F2845605DF2B8506961", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 4096, "_encstr_A5832FAAC69DEAF00B801B2B8846DC320FE63923B8FF7217B0E033271879AF0F4BE8BD1A17159A75DE783F7FC0704DA165", "_encstr_AC110A7F14873B5B3D073009");
  level thread managejumpmasterinfodisplay();
  thread spawn_atvs();
  thread safehouse_loadout_interaction("_encstr_887F1D1693B5CD192B16C6569C7D372C669534BD57CDCA7DB1B7C246F6BAA3");
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_B8E508DA7711DAB4F8A8", "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7", 10, 1);
  wait 10;
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_1, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_1, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_1, 4096, "_encstr_B8832F40AE03C428D5C25B84A5CE2FF202DD162B6812CDC1F08A8219C5AF98D107A71856388D9F1F2845605DF2B8506961", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_1, 4096, "_encstr_A5832FAAC69DEAF00B801B2B8846DC320FE63923B8FF7217B0E033271879AF0F4BE8BD1A17159A75DE783F7FC0704DA165", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_1, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_1, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_1, 4096, "_encstr_B8832F40AE03C428D5C25B84A5CE2FF202DD162B6812CDC1F08A8219C5AF98D107A71856388D9F1F2845605DF2B8506961", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_1, 4096, "_encstr_A5832FAAC69DEAF00B801B2B8846DC320FE63923B8FF7217B0E033271879AF0F4BE8BD1A17159A75DE783F7FC0704DA165", "_encstr_AC110A7F14873B5B3D073009");
  level scripts\engine\utility::_id_143BA(40, "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7", "_encstr_86D41E69DA25D07D02DFB9A3BB893E98C6F7B020838328B8497FE7BB33E20DF8");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
  makesafehouseclipsolid(0);
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_93D90AD6F627B036CA6ED7C4");
  level._id_121B1 = getEnt("_encstr_97C712BFACD9200D87F73B31DF8AD6786585A153", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_121B1))
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level._id_121B1);
}

managejumpmasterinfodisplay() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE7812F2A35058D1A6DB8B9FD140BB93F82E2B7D");

  if(getdvarint("_encstr_831409792835B3A07E4B18") < 1) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_994D1B6AE897FEE373B87C69469B97060FB0D352696773DF0B154731FF", "_encstr_9A8507BA4040188D08");
    var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
    wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_97E61347B0CDA621176D7DB7CED33A476B1883E3A8"));
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8211205A6311172B5309F8D9D84876333523729D18F78056C388A2466BBA30CE5A4F", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_957D2024F3C7661BA091D339CF633E2A504842B038B75BEC14A728280B760AC82261", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8411208CF0AFC6839BD7D6C25B85BEE4B2E6D8D52BAFD03B5ABE2DE68E93EDEB3303", "_encstr_9A8507BA4040188D08");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8E7D208C1ED7C6E0B97D36856E9BEB4E2B376CBA2BEB0D9D4BF5B473A339F6EB4360", "_encstr_9A8507BA4040188D08");
    setDvar("_encstr_831409792835B3A07E4B18", 1);
  } else
    wait 3;

  level notify("_encstr_86D41E69DA25D07D02DFB9A3BB893E98C6F7B020838328B8497FE7BB33E20DF8");
}

_id_137FA(var_0) {
  scripts\engine\utility::flag_wait("_encstr_A3872D91E25F20B0EA87F1C787C186403E3F7868CBDB9060F233CBCFD30AC7F0D5520661F20F68206A23D1FB8BD29D");
  level thread safehouse_loadout_interaction("_encstr_B6EC24B2EB1167B7987BACAD35213A77CCA19ADA93F6F7A1186BCCA50D70C98BE059D2427BCD");
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_91490A8D397B9B9BDDA537C8", "_encstr_87571A3ADED9ECC6ACEBCD85665643EDEA3795BEB956E83A9637CECD", 10, 1);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;
  level thread init_laser_traps(var_0);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;

  if(isDefined(level._id_121B1))
    level._id_121B1 delete();

  scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
  var_2 = scripts\engine\utility::getStructArray("_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.initlocs_bunkertest = var_2;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12E5A(var_2);
  scripts\engine\utility::flag_set("_encstr_878E1C6F0D51D384F0F9D59FF349DB8ABC4BD3DFBB867A479041CBE3EBF8");
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
  setDvar("_encstr_A53D19F2CB684F52B83FBF8C3BF01D8726C60B0B71565341D005B2", "_encstr_A1EB1D5847A6116942F31E2D419A65D81BCB60309B7D4B4FFB9F16AD2643A1");
  setDvar("_encstr_A2B41A6C0EFA859CD69B912BB0D82B397D8CFAE63A16E41DFADB9853", "_encstr_A1EB1D5847A6116942F31E2D419A65D81BCB60309B7D4B4FFB9F16AD2643A1");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_83F00E0229E3C25CC660BFF720F9125B");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 2048, "_encstr_B4F62BAB1EBA80F7935F2531670935D84EF9B1A085027921FA131B2977138B281F8D193E6E47BAC771373533C7", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread _id_1437D("_encstr_B83117F8F9E1DAC32823FBCAA7C9F209F0915DAF457127F59C", var_1);
}

_id_137FB(var_0) {
  scripts\engine\utility::flag_wait("_encstr_A3872D91E25F20B0EA87F1C787C186403E3F7868CBDB9060F233CBCFD30AC7F0D5520661F20F68206A23D1FB8BD29D");
  level thread safehouse_loadout_interaction("_encstr_B6EC24B2EB1167B7987BACAD35213A77CCA19ADA93F6F7A1186BCCA50D70C98BE059D2427BCD");
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_91490A8D397B9B9BDDA537C8", "_encstr_87571A3ADED9ECC6ACEBCD85665643EDEA3795BEB956E83A9637CECD", 10, 1);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;
  level thread init_laser_traps(var_0);

  if(!scripts\engine\utility::flag("_encstr_878E1C6F0D51D384F0F9D59FF349DB8ABC4BD3DFBB867A479041CBE3EBF8")) {
    thread maxplunderextractions();
    var_1 = level.camera_loadout_showcase_preview_sticker.origin;

    if(isDefined(level._id_121B1))
      level._id_121B1 delete();

    scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
    var_2 = scripts\engine\utility::getStructArray("_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.initlocs_bunkertest = var_2;
    scripts\mp\vehicles\vehicle_damage_mp::_id_12E5A(var_2);
    scripts\engine\utility::flag_set("_encstr_878E1C6F0D51D384F0F9D59FF349DB8ABC4BD3DFBB867A479041CBE3EBF8");
    setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
    setDvar("_encstr_A53D19F2CB684F52B83FBF8C3BF01D8726C60B0B71565341D005B2", "_encstr_A1EB1D5847A6116942F31E2D419A65D81BCB60309B7D4B4FFB9F16AD2643A1");
    setDvar("_encstr_A2B41A6C0EFA859CD69B912BB0D82B397D8CFAE63A16E41DFADB9853", "_encstr_A1EB1D5847A6116942F31E2D419A65D81BCB60309B7D4B4FFB9F16AD2643A1");
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_83F00E0229E3C25CC660BFF720F9125B");
  } else
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_83F00E0229E3C25CC660BFF720F9125B");

  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_1, 2048, "_encstr_B4F62BAB1EBA80F7935F2531670935D84EF9B1A085027921FA131B2977138B281F8D193E6E47BAC771373533C7", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  level waittill("_encstr_91BA1432D258B1B7765DB27D98E4D2CACCAF8CBD9B2B");
  thread _id_1437D("_encstr_B83117F8F9E1DAC32823FBCAA7C9F209F0915DAF457127F59C", var_1);
}

maxplunderextractions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A57D1BB19B89CE83FB59F8B1FDD141FF12672DCB6F020E4B05EF6683B2", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_88231B1D30D9EF2B5367700BCF8B0601129E801541A295702DABE1922A", "_encstr_9A8507BA4040188D08");
  level notify("_encstr_91BA1432D258B1B7765DB27D98E4D2CACCAF8CBD9B2B");
}

maxplunderdropondeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_88231B1D30D9EF2B5367700BCF8B0601129E801541A295702DABE1922A", "_encstr_9A8507BA4040188D08");
  level notify("_encstr_91BA1432D258B1B7765DB27D98E4D2CACCAF8CBD9B2B");
}

_id_1437D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill(var_0);
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_1, 2048, "_encstr_B4F62BAB1EBA80F7935F2531670935D84EF9B1A085027921FA131B2977138B281F8D193E6E47BAC771373533C7", "_encstr_AC110A7F14873B5B3D073009");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
}

maxweaponxpcap(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5, var_3 in scripts\cp\utility::getplayersinteam(var_0)) {
    var_4 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var_3))
      var_4 = 1;

    var_3 thread player_regroup(var_1, var_5, var_4);
  }

  wait 0.5;
}

player_regroup(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread regroup_blackscreen(self, var_3, var_4);
  wait 0.5;
  var_0[var_1].angles = scripts\engine\utility::ter_op(isDefined(var_0[var_1].angles), var_0[var_1].angles, (0, 0, 0));

  if(istrue(var_2)) {
    self.respawn_forcespawnorigin = var_0[var_1].origin;
    self.respawn_forcespawnangles = var_0[var_1].angles;
    self.forcespawnorigin = self.respawn_forcespawnorigin;
    self.forcespawnangles = self.respawn_forcespawnangles;
    scripts\cp\cp_laststand::instant_revive(self);
    self notify("_encstr_AF1C19BBFF262A7D30E69AA73BA09682685117E76DC51222408B12");
  }

  if(isDefined(self.currentturret))
    self.currentturret notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);

  if(isDefined(level.choppergunners)) {
    foreach(var_6 in level.choppergunners)
    var_6 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
  }

  if(isDefined(self.helperdrone))
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var_8 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_8)) {
    var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_8, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_8, var_9, self, undefined, 1);
  }

  self setOrigin(var_0[var_1].origin);
  self setplayerangles(var_0[var_1].angles);
  self dontinterpolate();
}

regroup_blackscreen(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 show_safehouse_regroup_text(var_2);
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0.fullscreen_overlay = newclienthudelem(self);
  var_0.fullscreen_overlay.x = 0;
  var_0.fullscreen_overlay.y = 0;
  var_0.fullscreen_overlay setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_0.fullscreen_overlay.alignx = "_encstr_A5AD056A019C63";
  var_0.fullscreen_overlay.aligny = "_encstr_AC190479FF92";
  var_0.fullscreen_overlay.sort = 1;
  var_0.fullscreen_overlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.fullscreen_overlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.fullscreen_overlay.alpha = 1;
  var_0.fullscreen_overlay.foreground = 1;
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_0 setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 0);
  var_0 setclientomnvar("_encstr_A7FE1805DC2832CA4A98C780F74FB3BEE3CB30035701807931E0", 0);

  if(isDefined(var_1) && isstring(var_1))
    level waittill(var_1);
  else
    wait 3;

  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
  var_0.fullscreen_overlay fadeovertime(2);
  var_0.fullscreen_overlay.alpha = 0.5;
  wait 2;
  var_0.fullscreen_overlay destroy();
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
}

show_safehouse_regroup_text(var_0) {
  var_1 = "_encstr_83821C0AF9E0B54A702B7727172FB3E5E0E10716B02B6AF1D613137F7540";

  if(isDefined(var_0) && isstring(var_0))
    var_1 = var_0;

  var_2 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");
  var_3 = "_encstr_911904535326" + var_2 + "_encstr_A6F310A6BAC37268E64CE3C545CA7A4E3F83";
  var_4 = int(tablelookup(var_3, 1, var_1, 0));
  self setclientomnvar("_encstr_A7FE1805DC2832CA4A98C780F74FB3BEE3CB30035701807931E0", var_4);
  self setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 1);
  self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
}

makesafehouseclipsolid(var_0) {
  var_1 = getEntArray("_encstr_B11C1947CB50FA8B983BC9736164F7747B63EBCD07D0C5573FF627", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_AC691C603B028F2FEB63D53AC69FAF86DCCF30B7A3D39330B74AA3F0BF55", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);

  if(istrue(var_0)) {
    foreach(var_5 in var_3) {
      var_5 disconnectPaths();
      var_5 solid();
    }
  } else {
    foreach(var_5 in var_3) {
      var_5 connectpaths();
      var_5 notsolid();
    }
  }
}

safehouse_loadout_interaction(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  setheadicondrawthroughgeo(var_2.headicon, 0);
  setheadiconsnaptoedges(var_2.headicon, 1024);
  setheadiconmaxdistance(var_2.headicon, 30);
  addclienttoheadiconmask(var_2.headicon, 10);
  var_2 makeusable();
  var_2 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AF0C1B26D8F7A535C5A98181A0AD439F5EB5DDAB744FCCC73EC0E11989", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BECC055CF3811A", 256, 65, 64, 65);
  level.camera_loadout_showcase_preview_sticker = var_2;

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_3 thread scripts\mp\vehicles\vehicle_damage_mp::edit_loadout(var_2);
  }

  return var_2;
}

init_laser_traps(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_AD66275827B69BC82B1663AC9CF5E456D1AEC9CDEBDCD21B59E6D856C9AFD2E63A959316D81DA5B7B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread init_laser_trap(var_1, var_0);
}

init_laser_trap(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_964E24B08EA3B0B1866BCA9BD1D7776BBEDC9BF516631C1A2CA60CFACD961B59B96C56930C26");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_2 thread _id_13397(var_2, var_1);
}

_id_13397(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setHintString(&"_encstr_85591E87172081DFE1FF3F36D4F148CE07B31F2F4F75C9E739A4650F8C3155D1");
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(128);
  var_0 sethintdisplayfov(120);
  var_0 setusefov(120);
  var_0 setuserange(128);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  objective_setlocation(var_1.objectiveindex, 0, var_0.origin);
  objective_setzoffset(var_1.objectiveindex, 15);
  var_0 makeusable();

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isPlayer(var_2)) {
      var_3 = 1;
      var_4 = var_2 getcurrentweapon();

      if(weaponclass(var_4) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" || weaponclass(var_4) == "_encstr_8C8D08671D451291C849") {
        var_2 thread scripts\cp\utility::hint_prompt("_encstr_BDC713DBF50BABE809CBA940934C01E7925D45D0CB", 1, 2);
        continue;
      }

      if(var_4.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1") {
        var_2 thread scripts\cp\utility::hint_prompt("_encstr_BDC713DBF50BABE809CBA940934C01E7925D45D0CB", 1, 2);
        continue;
      }

      if(var_4.basename == "_encstr_B8101002A7B77ED05C7773805753B96FDF87" || issubstr(var_4.basename, "_encstr_BDAB063E929A69A9")) {
        var_2 thread scripts\cp\utility::hint_prompt("_encstr_BDC713DBF50BABE809CBA940934C01E7925D45D0CB", 1, 2);
        continue;
      }

      if(var_4.basename == "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3") {
        var_2 thread scripts\cp\utility::hint_prompt("_encstr_BDC713DBF50BABE809CBA940934C01E7925D45D0CB", 1, 2);
        continue;
      }

      var_5 = var_2.currentweapon;
      var_6 = var_5;
      var_7 = undefined;
      var_8 = scripts\cp\utility::attachmentmap_tounique("_encstr_AD3E09B95A632BDC6CCA27", var_6);

      for(var_9 = 0; var_9 < var_5.attachments.size; var_9++) {
        if(var_6 canuseattachment(var_8) && scripts\cp\cp_weapon::attachmentsconflict(var_5.attachments[var_9], var_8, var_6) == "_encstr_B40101") {
          var_3 = 1;
          continue;
        }

        var_3 = 0;
        break;
      }

      if(var_3)
        var_7 = var_6 withattachment(var_8);

      if(!isDefined(var_7)) {
        if(!isbot(var_2))
          var_2 thread scripts\cp\utility::hint_prompt("_encstr_BDC713DBF50BABE809CBA940934C01E7925D45D0CB", 1, 2);

        continue;
      }

      var_2 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_5);
      var_2 giveweapon(var_7);
      var_2 setweaponammoclip(var_7, weaponclipsize(var_7));
      var_2 setweaponammostock(var_7, weaponmaxammo(var_7));
      var_2 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_7);
      scripts\cp\cp_weapon::fixupplayerweapons(var_2, var_7);
    }
  }
}