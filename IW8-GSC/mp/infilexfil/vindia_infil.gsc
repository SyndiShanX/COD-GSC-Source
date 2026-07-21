/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\vindia_infil.gsc
***********************************************/

vindia_init(var_0) {
  initanims(var_0);
  var_1 = [];
  var_1[0] = [0];
  var_1[1] = [1, 2, 3];
  var_1[2] = [4, 5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_91270DB8126F2B707F7EBB20448F19", var_0, 6, 4, var_1, ::vindia_spawn, ::vindia_get_length, ::player_vindia_infil_think);
}

vindia_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  var_5 thread infilthink(var_0, var_2);
  return var_5;
}

vindia_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"]);
  var_1 = var_1 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"]);
  return var_1;
}

player_vindia_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread player_infil_end();
  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("_encstr_AC6B06F0DA2281E1" + var_1, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_van_disconnect();
  level waittill("_encstr_B2600CF8759933D3EE634E77CB7A");
  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  self.player_rig linkTo(var_0.linktoent, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118", (0, 0, 0), (0, 0, 0));
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_828D1AD82BC0014C52C7AFD1B7FA85483E85239652C18075292BCBFD");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread clear_infil_ambient_zone();
  level notify("_encstr_BE8518E4FF303DABB768E36B8701E52013105967CA7153E2F75A");
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
}

clear_infil_ambient_zone() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

player_infil_end() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

van_infil_radio_idle(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("_encstr_A9AB18A8FECBF098E25F7F1B6BBA53905F9331E0E939104DAB1F", 1);
    wait 0.5;
    self playlocalsound("_encstr_97901BB30EC71061F7AACB73C257A4681D9E573DA9AFE83807A2A0D81B");
    level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
    wait 4;
    self stoplocalsound("_encstr_97901BB30EC71061F7AACB73C257A4681D9E573DA9AFE83807A2A0D81B");
  }
}

player_van_disconnect() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

spawnactors(var_0, var_1, var_2) {
  if(!isDefined(self.actors))
    self.actors = [];

  self.commander = self.linktoent spawn_anim_model("_encstr_8B190AC730E03D42856D3FF2", "_encstr_99FE0B2B19086F6B9DC5D387E1", "_encstr_97D01482D869C0E7B9B9D7F1C7E3E74D8BC13FE90B1D", "_encstr_996214AB202174E1FFAEF1B7839DFA3DE8E85307E878");
  self.commander.infil = self;
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_9AE307B956E345D0AB", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118", "_encstr_97D01482D869C0E7B9B9D7F1C7E3E74D8BC13FE90B1D", "_encstr_996214AB202174E1FFAEF1B7839DFA3DE8E85307E878");

  foreach(var_4 in self.actors)
  var_4.infil = self;

  self.commander.anim_playsound_func = ::commander_play_sound_func;
  self.actors[0].anim_playsound_func = ::driver_play_sound_func;
}

infilthink(var_0, var_1) {
  foreach(var_3 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_3 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  level waittill("_encstr_BE8518E4FF303DABB768E36B8701E52013105967CA7153E2F75A");
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 1);
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 0);

  while(isDefined(self.commander) || isDefined(self.actors))
    waitframe();

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawninfilvehicle(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(var_4, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_4.interiorlights[0] setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_8D5209E3A7634DD85FB1DB");
  scripts\common\anim::anim_single_solo(var_4, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::anim_single_solo(var_4, "_encstr_B68025CB809823ECB07FA1BE15A8F587B0BB6313A8F8DB27A041B2B13F483B8BED51BBFA3048EB");

  foreach(var_6 in var_4.interiorlights)
  var_6 delete();

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"] = ::spawnpersistentvehicle;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_91260B40A2EC2B91B36DA82E47"] = self.linktoent.origin;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_AF260B886A249329FB35F7680F"] = self.linktoent.angles;
}

spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_91260B40A2EC2B91B36DA82E47"];
  var_3 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_AF260B886A249329FB35F7680F"];
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_4.angles = var_3;
  var_4 setModel("_encstr_955E17539903DAE9289B3C07B9186FFFB4B04AFAE06F8F5E92");
  var_4.animname = "_encstr_AC1207CE6BC8A76777";
  var_4 scripts\common\anim::setanimtree();
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_5.angles = var_3;
  var_5 setModel("_encstr_88071E5437EA198E0DFF30B1F356A19F735CC0D58CD20FB1B90FF8E8E3625931");
  var_5 linkTo(var_4, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_4.turret = var_5;
}

van_interior_sfx(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_1 linkTo(self.linktoent, "_encstr_824B1713030C49CC20033D447EC8E9925DE7F7EFC1AE9294F0");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_2 linkTo(self.linktoent, "_encstr_994D096B20E7F183F0A074");
  wait 0.1;
  var_1 playsoundonmovingent("_encstr_8FC51FBB0FB81977E011722A1ECB8FCE78ED2529DFC0DE23AFE83AB3E61ED706E8");
  var_2 playsoundonmovingent("_encstr_AF0420C8DF3EA69BA2A78319F19AD3699353F0CBC7DEB95D990C081DD9923D50CE53");
  wait 7.75;
  var_1 playsoundonmovingent("_encstr_AB722043F735798C6E23AB914774C8531273E203E1ED2AD6912B7D207B873D57ED06");
  wait 8;
  var_1 playsoundonmovingent("_encstr_ADF121908766EED31A6F5BD109520BD1DB1BB8480F1661E5D11740685A5957F837F730");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_2 delete();
  var_1 delete();
}

van_infil_sfx_npc1(var_0) {
  var_0 playsoundonmovingent("_encstr_8FCE1BCDB1CDF5B4B999A536D734C28DADE656F2D7EC1673FA371CD833");
}

van_infil_sfx_npc2(var_0) {
  var_0 playsoundonmovingent("_encstr_91CE1BB346CDF9DA733419900F719ADEBC70610B47D3162EB9759AAF72");
}

van_infil_sfx_npc3(var_0) {
  var_0 playsoundonmovingent("_encstr_ACCE1B9B1BE6AF2D9B332DC6F5430B8DD6E6B25EAF3B2C9BAF37C1C689");
}

van_infil_sfx_npc4(var_0) {
  var_0 playsoundonmovingent("_encstr_A1CE1BDCC6E67D2D37CC4B36FA0DB0B1B6CD59F2FA3BC237BE371CB1D8");
}

van_infil_sfx_npc5(var_0) {
  var_0 playsoundonmovingent("_encstr_93CE1BFF7B8DE9BBB362D078194367D064DE6B63DFF350704FFA0B8187");
}

van_infil_sfx_npc6(var_0) {
  var_0 playsoundonmovingent("_encstr_A3CE1BF720F01FD2957C0C45C8A16AEBF8D02727292B99EA9F3752BE65");
}

actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame_solo(self.commander, "_encstr_8FAA0DD6806E77D0190FCC0B13BBC4", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_8FAA0DD6806E77D0190FCC0B13BBC4", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.commander hide();
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.commander show();
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single_solo(self.commander, "_encstr_8FAA0DD6806E77D0190FCC0B13BBC4", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  self.commander.head scriptmodelplayanim(level.scr_anim[self.commander.animname]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"]);
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_8FAA0DD6806E77D0190FCC0B13BBC4", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  var_4 = getanimlength(level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"]);
  wait(var_4);
  self.commander delete();
  self.commander = undefined;

  foreach(var_6 in self.actors)
  var_6 delete();

  self.actors = undefined;
}

spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;

  if(scripts\engine\utility::cointoss())
    var_5 = 0;

  if(var_2 == "_encstr_A31207CBF788523281") {
    if(var_5) {
      var_6 = randomint(3);

      if(var_6 == 0)
        var_2 = "_encstr_832F17997FC2A8AB797BEB0FA0308FA957D9EE6119331833CA";
      else if(var_6 == 1)
        var_2 = "_encstr_BACA1C8025F8ABC978408857AE9E75EF69F7209CA783BFDF779686B7FFEB";
      else if(var_6 == 2)
        var_2 = "_encstr_929214A948241FF1E84E013760382830114B393FAE32";
    } else if(scripts\engine\utility::cointoss())
      var_2 = "_encstr_9699169827F696A182F555E8CDB98D99459F68D097E92ED9";
    else
      var_2 = "_encstr_857C15EF9909010BCF4F245E2055F2DD91A84F9752E616";
  }

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_7 setModel(var_2);

  if(isDefined(var_3)) {
    if(var_3 == "_encstr_A31207CBF788523281") {
      if(var_5) {
        if(scripts\engine\utility::cointoss())
          var_3 = "_encstr_B6CC2C86B22C46FA89CED7ECB09C7D86B20B91EB313BFA5B2CC62BBEC0E4BE43B20BC8D7E6B1D7D685C695F54C1A";
        else
          var_3 = "_encstr_AA472C9AB1AFB3F138FF67368BC089CBC5A9D25118776BB7F9DD531701F241137DC14AD940DD5B6D21CF4924A730";
      } else if(scripts\engine\utility::cointoss())
        var_3 = "_encstr_BAFA30D02B1646F589B3FA9D16E47DA12B8532EB99CAD60BB156FA8936FA6089BE0D2B0B467D37B1D79995AD2C3656F56218";
      else
        var_3 = "_encstr_818B3034952C91F54CD9F5B3B027BE0DCAB08CD79B8DFACCB2D6B0B195FA18D0F543CAB0C8FA99565BC21B95D74C1BBE608C";
    }

    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_8 setModel(var_3);
    var_8 linkTo(var_7, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_7.head = var_8;
    var_7 thread scripts\engine\utility::delete_on_death(var_8);
  }

  if(isDefined(var_4)) {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_9 setModel(var_4);
    var_9 linkTo(var_7, "_encstr_8107069A17A718C5", (0, 0, 0), (0, 0, 0));
    var_7 thread scripts\engine\utility::delete_on_death(var_9);
    var_7.weapon = var_9;
  }

  var_7.animname = var_0;
  var_7 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_7);
    var_7 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_7;
}

initanims(var_0) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3");
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

script_model_alpha_anims() {
  level.scr_animtree["_encstr_9AE307B956E345D0AB"] = #animtree;
  level.scr_anim["_encstr_9AE307B956E345D0AB"]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"] = % _encstr_8D01175B1C7D4BB999B4B1D7EC9673C85A167D4693D2B35993;
  level.scr_animname["_encstr_9AE307B956E345D0AB"]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"] = "_encstr_8D01175B1C7D4BB999B4B1D7EC9673C85A167D4693D2B35993";
  level.scr_animtree["_encstr_8B190AC730E03D42856D3FF2"] = #animtree;
  level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"] = % _encstr_879516B683BEA5B9CC4B8DEBEC96B9C8B42CF56C34A55699;
  level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8FAA0DD6806E77D0190FCC0B13BBC4"] = "_encstr_879516B683BEA5B9CC4B8DEBEC96B9C8B42CF56C34A55699";
  level.scr_animtree["_encstr_AC1207CE6BC8A76777"] = #animtree;
  level.scr_anim["_encstr_AC1207CE6BC8A76777"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_8F0C1A6BE0D74BCD3396B1D7D95A9B464BC2BE6759437DB4CDE8E4BD;
  level.scr_animname["_encstr_AC1207CE6BC8A76777"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_8F0C1A6BE0D74BCD3396B1D7D95A9B464BC2BE6759437DB4CDE8E4BD";
  level.scr_anim["_encstr_AC1207CE6BC8A76777"]["_encstr_B68025CB809823ECB07FA1BE15A8F587B0BB6313A8F8DB27A041B2B13F483B8BED51BBFA3048EB"] = % _encstr_AA402CADE07D2DCD33B436EBCE5A73914BB0FAECCA43D7F65D47C9B7AF36AC661DC9D23B0DA339ACB04E91B7B739;
  level.scr_animname["_encstr_AC1207CE6BC8A76777"]["_encstr_B68025CB809823ECB07FA1BE15A8F587B0BB6313A8F8DB27A041B2B13F483B8BED51BBFA3048EB"] = "_encstr_AA402CADE07D2DCD33B436EBCE5A73914BB0FAECCA43D7F65D47C9B7AF36AC661DC9D23B0DA339ACB04E91B7B739";
  level.scr_anim["_encstr_AC1207CE6BC8A76777"]["_encstr_86C22024DC089A833FE95398D59B23F7D898B3BAFF4FD96B202C52F05F7618BF9758"] = % _encstr_A6EE27FB50C950208B9A8816934FE8F09CD91775ED6C99F8EF634318297315B87322FBD382D7D030AB;
  level.scr_animname["_encstr_AC1207CE6BC8A76777"]["_encstr_86C22024DC089A833FE95398D59B23F7D898B3BAFF4FD96B202C52F05F7618BF9758"] = "_encstr_A6EE27FB50C950208B9A8816934FE8F09CD91775ED6C99F8EF634318297315B87322FBD382D7D030AB";
  level.scr_anim["_encstr_AC1207CE6BC8A76777"]["_encstr_8F5C1C6633FB035A430158E6941B3517E0335BFBAFCF8BA0375A49207FE3"] = % _encstr_96252393105904C07750319FA3FF88D20BC6FE2BB568697FA5CD453F89F0C962A34BC81508;
  level.scr_animname["_encstr_AC1207CE6BC8A76777"]["_encstr_8F5C1C6633FB035A430158E6941B3517E0335BFBAFCF8BA0375A49207FE3"] = "_encstr_96252393105904C07750319FA3FF88D20BC6FE2BB568697FA5CD453F89F0C962A34BC81508";
  level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_85F51E2982694B58F62FE081AB019099D26E88A45B638326D11B28E0E71FCBD3;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_85F51E2982694B58F62FE081AB019099D26E88A45B638326D11B28E0E71FCBD3";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_865115020B5021F111E3C8025A1B90FF206DB89B9081E7";
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_AFBC1D5BC1AF5A73CCA5D8F59D5ACDC85AC27DCEAB5E26AFCAE12D1DFABBD6;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_AFBC1D5BC1AF5A73CCA5D8F59D5ACDC85AC27DCEAB5E26AFCAE12D1DFABBD6";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_BA6314F1A05937953730EA9248B30E379113496450CB";
  level.scr_viewmodelanim["_encstr_A2FF07DB605823217A"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_8EBC1DD61CEB96B9664B36AF9DB4E6919616EB76AEBCC47D95E14BE87D676B";
  level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_9B911EAD0EF54B739996D87DD9A5738C2DB0EBECAB9746D796CDA339DBF5EE5B;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_9B911EAD0EF54B739996D87DD9A5738C2DB0EBECAB9746D796CDA339DBF5EE5B";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_8B511596DC6696D8AF6796DC322D2CD7D2CD3A39BDD78C";
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_AF8C1DD86A273048E22F49277B3A80E0B98606115359A2E80A935B49C7A359;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_AF8C1DD86A273048E22F49277B3A80E0B98606115359A2E80A935B49C7A359";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_9563145A37CC2DB1F5CE967332B4C2F5CA3CD247D78C";
  level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_A7D81E7721102AD68080BD495BC0EE32D39B37A7C3AB37AF9008B30A90993FFA;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_A7D81E7721102AD68080BD495BC0EE32D39B37A7C3AB37AF9008B30A90993FFA";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_83511573823A61348F5B9282D1B85E5977C8731B98990F";
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_B4FB1D68DA9780F8B27F39572B6A30304976D6A103091A38FA230B19775389;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_B4FB1D68DA9780F8B27F39572B6A30304976D6A103091A38FA230B19775389";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_A263143BEAB23B4A37FDDA9D258BFA79A558F3E0D0DF";
  level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_AA3D1EADE07D2DCD33B436EBCE5A73914BB0FACEEACB0DF55AE6D139B7AFEED6;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_AA3D1EADE07D2DCD33B436EBCE5A73914BB0FACEEACB0DF55AE6D139B7AFEED6";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_8C5115B49B33D2D8EB3B2DCD32D2C2AFB49BA39CDBFAA1";
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_95BF1DD60EFAD2E6CCA5C6EBCE96E6C89616FAB3AEE5D0F55987D2477DDDB6;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_95BF1DD60EFAD2E6CCA5C6EBCE96E6C89616FAB3AEE5D0F55987D2477DDDB6";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_B66314FFA589738947BBCBD32DEA0AC610134209F9CA";
  level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_88501E402BF9E3F8A32971E02EC7A0B1DC82598893888316B746056E1FF74B1B;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_88501E402BF9E3F8A32971E02EC7A0B1DC82598893888316B746056E1FF74B1B";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_9A5115E865352F0AC193B79321B91AB9DC65DB0B6717F3";
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_BE3E1DEB40F96010BB8A98E6635FD8C08CA90767EDD8DAF0DFB3308B190F01;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_BE3E1DEB40F96010BB8A98E6635FD8C08CA90767EDD8DAF0DFB3308B190F01";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_B46314BA58E57C93F62C7966CDD86F091BC322E369EB";
  level.scr_viewmodelanim["_encstr_A6FF0747907B08963F"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_913E1D3D77A6EFDD8D70F2D990CB9593D85787AF0D8A46A9A390AA63F11D8D";
  level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = % _encstr_97131EAD38FA5AB9992D1BF5D9B4CD912DC2EBD95DF2B17D4BCD8EE4DEF5BB6B;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_97131EAD38FA5AB9992D1BF5D9B4CD912DC2EBD95DF2B17D4BCD8EE4DEF5BB6B";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_91A4133DB955E87347499860C23FB9792C06B1AD57"] = "_encstr_AF51152D73662DD8BED94BE64696B0F52DB9A39CDBFA63";
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = % _encstr_82DD1DC9D871BB5856A3C1F784DFF0401B8F903FABB02561A7C3BB7C81FBCD;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_82DD1DC9D871BB5856A3C1F784DFF0401B8F903FABB02561A7C3BB7C81FBCD";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_B263142878795FD0EEC3CC5BE3BADE9FEB3033755EBA";
  level.scr_viewmodelanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A3DA1267B4CDC8D216BE2DCD66D263FAB2E14BA3"] = "_encstr_86DD1DB60EBE967366D2B1AFD9D237194BC2BECEBA5E6CFA2B874B3AEBCEDA";
}

vehicles_alpha_anims() {}

spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 setModel("_encstr_955E17539903DAE9289B3C07B9186FFFB4B04AFAE06F8F5E92");
  var_3.animname = "_encstr_AC1207CE6BC8A76777";
  var_3 scripts\common\anim::setanimtree();
  var_3 setCanDamage(0);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_4.angles = var_0.angles;
  var_4 setModel("_encstr_88071E5437EA198E0DFF30B1F356A19F735CC0D58CD20FB1B90FF8E8E3625931");
  var_4 linkTo(var_3, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_3.turret = var_4;
  self.linktoent = var_3;
  var_3.infil = self;
  var_5 = [];
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_6.angles = var_3.angles;
  var_6 setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  var_6 linkTo(var_3, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118", (-60, 0, 32), (-90, 0, 0));
  var_5[var_5.size] = var_6;
  var_3.interiorlights = var_5;
  return var_3;
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

driver_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}