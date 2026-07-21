/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\infilexfil\lbravo_infil_cp.gsc
***********************************************/

lbravo_init(var_0) {
  initanims(var_0);
  var_1 = [];
  var_1[0] = [0, 1];
  var_1[1] = [4, 5];
  var_1[2] = [2];
  var_1[3] = [3];
  scripts\cp\infilexfil\infilexfil::infil_add("_encstr_91540D2DDC33D263FA36132785B3DE", var_0, 6, 4, var_1, ::lbravo_spawn, ::lbravo_get_length, ::player_lbravo_infil_think);
}

lbravo_spawn(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_3.origin);
  var_4.angles = var_3.angles;
  var_4.scene_node = var_3;

  if(isDefined(var_3.target))
    var_4.path = scripts\engine\utility::getStruct("_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_4 thread infilthink(var_0, var_2);
  level.infil_struct = var_4;
  return var_4;
}

lbravo_get_length(var_0) {
  if(isDefined(self.path)) {
    var_1 = parsepathlength();
    var_1 = var_1 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0 + "_encstr_AAD30BBED8DBED38AF59F05A1D"]);
    var_1 = var_1 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0 + "_encstr_96D206F968DB6F43"]);
    return var_1;
  } else {
    var_2 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0]);
    var_2 = var_2 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0 + "_encstr_96D206F968DB6F43"]);
    return var_2;
  }
}

player_lbravo_infil_think(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);

  if(isPlayer(self))
    self setclienttriggeraudiozone("_encstr_8CDF133561B84943A8A7B7B3CD432ABF9808AB3A78", 1);

  thread player_infil_end(var_0);
  thread scripts\cp\cp_infilexfil::infil_player_rig("_encstr_AC6B06F0DA2281E1" + var_1, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  self.player_rig.weapon_state_func = scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  self.player_rig linkTo(var_0.linktoent, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  self predictstreampos(var_0.linktoent.origin);
  self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0.0, 0.55, "_encstr_81A3086ECB28576FAD13");
  thread player_van_disconnect();
  scripts\engine\utility::waittill_any_ents(level, "_encstr_B2600CF8759933D3EE634E77CB7A", var_0, "_encstr_B2600CF8759933D3EE634E77CB7A");

  if(isDefined(self.team) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    self setsoundsubmix("_encstr_82BD13C83BD0115EF387D3D5C33B90C92F13D323A5");
    self setplayermusicstate("_encstr_AFD61033BFA7C42BD31F331FA18020BBC3F8");
  }

  self.is_doing_infil = 1;
  self notify("_encstr_93E5126FC75143212990F29AA823A3CF0825E60D");
  self notify("_encstr_81A3086ECB28576FAD13");
  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");

  if(isDefined(var_0.path))
    thread playerthinkpath(var_0, var_1);
  else
    thread playerthinkanim(var_0, var_1);

  self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
}

playerthinkpath(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(var_1 == 0)
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 30);
  else if(var_1 == 1)
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 30);
  else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 30);

  rideloop(var_0);
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  self lerpfovscalefactor(1, 2);
  self stopanimscriptsceneevent();
  self setcinematicmotionoverride("_encstr_966114C11CA2DF8241981BD2E8ABBD8B60885E7FB9F3");
  self.player_rig unlink();
  self.is_doing_infil = undefined;
  self notify("_encstr_88DC164073A192739379942B0D1A67780DCBB170937E2829");
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("_encstr_82BD13C83BD0115EF387D3D5C33B90C92F13D323A5");
  var_0 notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
}

rideloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0.linktoent endon("_encstr_81A8077D3088BFA631");

  for(;;) {
    var_0.linktoent thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0.subtype + "_encstr_A3850616E56F783F", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
    wait 10;
  }
}

playerthinkanim(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 30);
  var_0.linktoent scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0.subtype, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self.player_rig unlink();
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self stopviewmodelanim();
  scripts\cp\cp_infilexfil::takegunlesscp();
  self clearsoundsubmix("_encstr_82BD13C83BD0115EF387D3D5C33B90C92F13D323A5");
  var_0 notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
}

scriptswitchweaponhack() {
  waitframe();
  self notify("_encstr_AC251B5FF7CD10B91FC3D19EAAE76D60E959FDDD69F52177035A688363");
}

clear_infil_ambient_zone() {
  wait 1;
  self clearclienttriggeraudiozone(2);
}

player_infil_end(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA", var_0, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

player_van_disconnect() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

infilthink(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_3 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_3 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8C0D0E8410E8B112602F133F559DCAF4", self, "_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  self notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  var_5 = lbravo_get_length(var_1);
  wait(var_5);
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA", self, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path))
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
  else
    thread vehiclethinkanim(var_0, var_1, var_2, var_3);
}

vehiclethinkanim(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2);
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8C0D0E8410E8B112602F133F559DCAF4", self, "_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2);
  var_4 = getanimlength(level.scr_anim[self.linktoent.animname]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2]);
  wait(var_4);
  self.linktoent delete();
  self.linktoent = undefined;
}

spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;

  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
  }

  var_5 = spawnVehicle("_encstr_A5EA215BCFF05A30720F6907475AEE199C664331B32FA95F2A5B4F1F6312BD4817BE8B", var_2, "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", var_3, var_4);
  var_5 setvehicleteam(var_1);
  var_5.animname = "_encstr_951007814D5B63F807";
  var_5 setCanDamage(0);
  var_5 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_5.infil = self;

  if(isDefined(level._id_1356F))
    level thread[[level._id_1356F]](var_5);

  return var_5;
}

actorthink(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.actors = thread spawnactors(var_0, var_2, var_3);
  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\engine\utility::waittill_any_ents(level, "_encstr_8C0D0E8410E8B112602F133F559DCAF4", self, "_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    actorthinkpath(var_0, var_1, var_2, var_3);
  else
    actorthinkanim(var_0, var_1, var_2, var_3);
}

actorthinkpath(var_0, var_1, var_2, var_3) {
  if(isDefined(level.watchfraggrenadeexplode))
    level thread[[level.watchfraggrenadeexplode]](self);
  else
    autoassignfirstquest(self);
}

autoassignfirstquest(var_0) {
  var_0 thread actorloopthink(var_0.actors[0]);
  var_0 thread actorloopthink(var_0.actors[1]);
}

actorloopthink(var_0) {
  actorloop(var_0);
  self.linktoent scripts\common\anim::anim_single_solo(var_0, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + self.subtype + "_encstr_AAD30BBED8DBED38AF59F05A1D", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

actorloop(var_0) {
  self.linktoent endon("_encstr_81A8077D3088BFA631");

  for(;;)
    self.linktoent scripts\common\anim::anim_single_solo(var_0, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + self.subtype + "_encstr_A3850616E56F783F", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

actorthinkanim(var_0, var_1, var_2, var_3) {
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_4 = getanimlength(level.scr_anim["_encstr_A266062032BD7723"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2]);
  wait(var_4);

  foreach(var_6 in self.actors)
  var_6 delete();

  self.actors = undefined;
}

spawnactors(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = self.linktoent spawn_anim_model("_encstr_A266062032BD7723", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_A9C718DB740D58BD9BF1F3D82A5FED3127C57949E2B578FB4F0F");
  var_3[var_3.size] = self.linktoent spawn_anim_model("_encstr_9B7408BFEF17BA445893", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_AFC7187AE059D72F583FF8F941D8B3C7F47B223249A0BB60A90D");

  foreach(var_5 in var_3)
  var_5.infil = self;

  return var_3;
}

spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_5.head = var_6;
    var_5 thread scripts\engine\utility::delete_on_death(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "_encstr_8107069A17A718C5", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::delete_on_death(var_7);
    var_5.weapon = var_7;
  }

  var_5.animname = var_0;
  var_5 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_5);
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

initanims(var_0) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_820A0FB85F73205A67FFD3C52723FBB0CD", scripts\mp\utility\infilexfil::player_fov_80_instant);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8ECF1882C83763C35EB301889D3D2B73051067901F8309112843;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8ECF1882C83763C35EB301889D3D2B73051067901F8309112843";
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B";
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8C0E1A85D321B132FC1B73C76996BBF13098B10EAE284F0B43397763;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8C0E1A85D321B132FC1B73C76996BBF13098B10EAE284F0B43397763";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_A1011A6B07D796CD33D236AF8D31C9B09D7BEBB0FAB3AEBCC4F5EED6;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A1011A6B07D796CD33D236AF8D31C9B09D7BEBB0FAB3AEBCC4F5EED6";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_B1A81117184C12BB7160734D901DE8CFE1EFAF";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_8B5F165A9B334B8DBE63C4C958ECEDEB89BEB23C5AD1AF13";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_97A811973504EBD997A5307B02BB27A902A6DA";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_87801B230DF2438DD73368E0EF16B8F72AF929B825EB6769C83F209196";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_BAA81158ED1E3049713B557D27CBB739B109AB";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_8D5F1696CD99B48DAFC69893B0CEEDBE987D2B0F4B47FA91";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AAA811A078C238E85F0B63FDBB28578F6A8792";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_96801B20CD47C301AF382233C7F050AE7756190F42707E8D29C0F139F6";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A9A811883DCEE099410B052D57BB500961D97B";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_A55F16B8126F2B707F643E2E41F3D8FFD6A940B81A830FA3";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_81A8116130C9A7E54790CAC3D03D1DC7E130A3";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_88801B967399A51BFAC6262758D9F6EB167D36BDF6C1BE95E1B4E8F533";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A6A81144A30FFF59E103EA236A63A5E9EA0F43";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_9A5F16E490A528BA6150907E7F235FB93E872BC31060AF03";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_B2A811ACF5C5931BFFAB01E6A8F52F99C8319C";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_81801BAA48F56C83C611426ABFCB473923290242D871A9FF5A8B5C4FED";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_B6A8115ACD33D263F53689C958B3DBD70BBEA9";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_AF5F164B37994B8DFA6326E42C3BB7AF26D7ACE15AD1EBA6";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_84A811BF68D149E29719AEA2F7BDAA37397946";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_AA801B517BD1ABFD3728FD23273B82B777F9B9F070EB0F472A2A1B2163";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_B4A811DC48B0E9BAD8A9E3AB9B74B26720F683";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_A95F165A37CC2DD8F563989C16D9DEEB267D2BC3B43AF51B";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_8AA8119673662D36BED84CE40BD9DB7DC4D7D8";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_97801BB4CDCCB463BEC6899316B3DBAF857D1BDBED1CFA2BF05AD1EBB1";
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_A26518390B213B6AD3C38AD1219DCB88B64F9F50D0594955C088;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_A26518390B213B6AD3C38AD1219DCB88B64F9F50D0594955C088";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_8DB31AD638F52DCD992D8DAF63319C58CEDE7D89EBD87B07B41BEDE8;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_8DB31AD638F52DCD992D8DAF63319C58CEDE7D89EBD87B07B41BEDE8";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_97A811973504EBD997A5307B02BB27A902A6DA";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8B5F165A9B334B8DBE63C4C958ECEDEB89BEB23C5AD1AF13";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AAA811A078C238E85F0B63FDBB28578F6A8792";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8D5F1696CD99B48DAFC69893B0CEEDBE987D2B0F4B47FA91";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_81A8116130C9A7E54790CAC3D03D1DC7E130A3";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A55F16B8126F2B707F643E2E41F3D8FFD6A940B81A830FA3";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_B2A811ACF5C5931BFFAB01E6A8F52F99C8319C";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_9A5F16E490A528BA6150907E7F235FB93E872BC31060AF03";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_84A811BF68D149E29719AEA2F7BDAA37397946";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_AF5F164B37994B8DFA6326E42C3BB7AF26D7ACE15AD1EBA6";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_8AA8119673662D36BED84CE40BD9DB7DC4D7D8";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A95F165A37CC2DD8F563989C16D9DEEB267D2BC3B43AF51B";
      break;
  }
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_951007814D5B63F807"] = #animtree;
      level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_883917B05BB908305507C817F11A9B86A0B2F7C7EF5A3DDBF8;
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_951007814D5B63F807"] = #animtree;

      switch (getDvar("_encstr_9570084B1793A090CDFF")) {
        case "_encstr_B6EE0A72AB0863F3C065A5BA":
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_86381E938BB9FB203E04E8866DE21827C30F7F159F72B578599113DB15C6E8E6;
          break;
        default:
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_8E8B178FD998A25E180805C180108AFAE40FBF3B1FBB2A0418;
          break;
      }

      break;
  }
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

vehiclethinkpath(var_0, var_1, var_2, var_3) {
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent endon("_encstr_AD75063D571AE108");
  self.linktoent.unload_hover_offset = 116;
  self.linktoent.unload_time = 3.5;
  self.linktoent vehicle_paths_helicopter(self.path);
  thread gopath(self.linktoent);
}

vehiclefollowpath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  self startpath(var_0);

  for(var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"); isDefined(var_1); var_1 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed())
    wait 0.1;
}

gopath(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.hasstarted))
    return;
  else
    var_0.hasstarted = 1;

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("_encstr_BDB712B06B76D5BB4736F57B31EFE0B39A82A3F0");
  var_0 notify("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");
}

vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0))
    self.attachedpath = var_0;

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1)
    self waittill("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto))
      set_lookat_from_dest(var_7);

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_7;
    var_7 notify("_encstr_8F5C086405E70FBA4B4A", self);

    if(isDefined(var_7.script_delete)) {
      self delete();
      return;
    }

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "_encstr_BA2207BF09B8544A2E")
        self setmaxpitchroll(25, 50);
    }

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7.script_team))
      self.script_team = var_7.script_team;

    if(isDefined(var_7.script_unload)) {
      self notify("_encstr_81A8077D3088BFA631");
      scripts\engine\utility::waittill_notify_or_timeout("_encstr_BD82096B5DA4B07F924F29", self.unload_time);
      level notify("_encstr_A32B1CC3D94F6B9D6083318318A8AFA295531B07A56EB25DE128754F90C0");
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype))
        self.veh_pathtype = var_7.script_pathtype;
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post))
        wait(var_7.script_delay_post);

      self notify("_encstr_8D910D32568D855EEB1C16E6E62B91");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");

  if(isDefined(self.script_vehicle_selfremove))
    self delete();
}

heli_wait_node(var_0, var_1, var_2) {
  self endon("_encstr_87DE08E656DDC158E81A");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("_encstr_9A93071D297064AAC5");

      if(isDefined(self.unload_land_offset))
        var_3 = self.unload_land_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset))
      var_3 = self.unload_hover_offset;
    else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max)
        var_3 = self.unload_hover_offset_max;
      else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height)
        var_3 = self.unload_hover_land_height;
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos))
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000)
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0.script_stopnode) && var_0.script_stopnode;
  var_11 = isDefined(var_0.script_unload);
  var_12 = isDefined(var_0.script_flag_wait) && !scripts\engine\utility::flag(var_0.script_flag_wait);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles))
    var_15 = var_0.angles[1];
  else
    var_15 = 0;

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2))
    var_16 = (var_16[0], var_16[1], var_16[2] + var_2);

  if(isDefined(self.heliheightoverride))
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);

  self vehicle_helisetai(var_16, var_7, var_8, var_9, var_0.script_goalyaw, var_0.script_anglevehicle, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  } else
    self waittill("_encstr_8B7205D9ED5958");

  if(isDefined(var_0.script_flag_set))
    level notify(var_0.script_flag_set);

  if(isDefined(var_0.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](var_0);
  }

  var_0 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(var_0);

  self notify("_encstr_B4EC0D2F7FA8DBF1E023DF6259C808");
}

get_path_getfunc(var_0) {
  var_1 = ::get_from_vehicle_node;

  if(isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target)))
      var_1 = ::get_from_entity;

    if(isDefined(get_from_spawnStruct(var_0.target)))
      var_1 = ::get_from_spawnstruct;
  }

  return var_1;
}

get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

parsepathlength() {
  if(!isDefined(self.path))
    return 0.0;

  if(isDefined(self.pathduration))
    return self.pathduration;

  self.pathduration = 0.0;
  var_0 = self.path;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0.script_unload)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed))
      var_1 = var_0.speed;

    var_4 = 17.6;
    self.pathduration = self.pathduration + var_3 * 1.8 / (var_1 * var_4);
    var_0 = var_2;
  }

  return self.pathduration;
}