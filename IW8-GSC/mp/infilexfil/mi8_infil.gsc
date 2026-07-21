/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\mi8_infil.gsc
***********************************************/

mi8_init(var_0) {
  var_1 = [];
  var_1[0] = [11, 10];
  var_1[1] = [9, 8];
  var_1[2] = [7, 6];
  var_1[3] = [5, 4];
  var_1[4] = [3, 2];
  var_1[5] = [1, 0];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_97810AB4CDCCB463BED6A5C1", var_0, 12, 4, var_1, ::mi8_spawn, ::mi8_get_length, ::player_mi8_infil_think);
}

mi8_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\cp_mp\utility\game_utility::getmapname();

  if(var_5 == "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE") {
    if(var_0 == "_encstr_9A8507BA4040188D08") {
      if(distance2dsquared(var_4.origin, (-8540.17, 31520.1, -487.5)) < 100) {
        var_2 = "_encstr_871D0613938567B7";
        var_3 = "_encstr_871D0613938567B7";
      }
    } else if(distance2dsquared(var_4.origin, (7145.82, 23997.2, -34)) < 100) {
      var_2 = "_encstr_871D0613938567B7";
      var_3 = "_encstr_871D0613938567B7";
    }
  }

  initanims(var_2, var_0, var_3);
  _id_12802(var_4, var_0, var_2, var_3);
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_6.angles = var_4.angles;
  var_6.scene_node = var_4;
  var_6.subtype = var_2;
  var_6._id_1214C = var_3;
  var_6 thread infilthink(var_0, var_2);
  return var_6;
}

_id_12896(var_0, var_1, var_2) {
  var_3 = var_0.scene_node.origin;
  var_4 = var_0.scene_node.angles;

  for(;;) {
    thread scripts\cp_mp\utility\debug_utility::drawangles(var_3, var_4, level.framedurationseconds, 1.0);
    waitframe();
  }
}

_id_12802(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_4) {
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      switch (var_3) {
        case "_encstr_BDBB0616C6C186C2":
          if(var_1 == "_encstr_8E8405EA382B2A")
            var_0.angles = var_0.angles + (0, 8, 0);
          else {
            var_0.angles = var_0.angles + (0, 23, 0);
            var_0.origin = var_0.origin + anglesToForward(var_0.angles) * 100;
          }

          break;
        case "_encstr_91A40713BCD2887706":
          if(var_1 == "_encstr_8E8405EA382B2A")
            var_0.angles = var_0.angles + (0, -8, 0);
          else
            var_0.angles = var_0.angles + (0, -3, 0);

          break;
        case "_encstr_ACA407B9984198974F":
          if(var_1 == "_encstr_8E8405EA382B2A") {
            var_0.angles = var_0.angles + (0, -3, 0);
            var_0.origin = var_0.origin + anglesToForward(var_0.angles) * 200;
          } else
            var_0.angles = var_0.angles + (0, 12, 0);

          break;
      }

      break;
    case "_encstr_93D20D28714743B99070632BAF3944":
      switch (var_3) {
        case "_encstr_871D0613938567B7":
          if(var_1 == "_encstr_9A8507BA4040188D08")
            var_0.origin = var_0.origin - (0, 0, 86);
      }
    case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
      switch (var_3) {
        case "_encstr_BDBB0616C6C186C2":
          if(var_1 == "_encstr_9A8507BA4040188D08")
            var_0.angles = var_0.angles - (0, 30, 0);
      }

      break;
  }
}

mi8_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"]);
  return var_1;
}

player_mi8_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread infil_radio_idle(var_0);
  thread player_infil_end();
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");
  self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
  self lerpfovscalefactor(0, 0);
  self.player_rig linkTo(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(self.player_rig, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  if(isDefined(self.team) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_4 = [];
    var_4[var_4.size] = "_encstr_AA9114AD38BE5A73CCB4D87D5B5A87FA9BBDE45BC21B";
    var_5 = var_4.size;
    var_6 = randomint(var_5);

    if(self.team == "_encstr_9A8507BA4040188D08") {
      var_7 = game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"].size;
      level.cur_infil_track = randomint(var_7);
      self setsoundsubmix(var_4[var_6]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"][level.cur_infil_track]);
      self._id_12463 = 1;
    } else {
      var_7 = game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"].size;
      level.cur_infil_track = randomint(var_7);
      self setsoundsubmix(var_4[var_6]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"][level.cur_infil_track]);
      self._id_12463 = 1;
    }
  }

  if(isDefined(self.animname) && !isai(self)) {
    var_8 = "_encstr_87B81763D67EE9A3FABBFBE94792FB280C2CA97EBAD45870E7";

    switch (self.animname) {
      case "_encstr_A2FF07DB605823217A":
        var_8 = "_encstr_87B81763D67EE9A3FABBFBE94792FB280C2CA97EBAD45870E7";
        break;
      case "_encstr_95FF079B8D7B1DFA4C":
        var_8 = "_encstr_92B817E68D73BED2CDCC5A8DEBD6D2E68CD258EB838D4EFA64";
        break;
      case "_encstr_BAFF07CD367B1DD791":
        var_8 = "_encstr_82B817C862CDE770DB0EDB41DF3FB87DB72AC021EBE5F5CEF6";
        break;
      case "_encstr_B1FF077B0D77B8B017":
        var_8 = "_encstr_81B817D2BECDE171D0108F83C1E839BAA1C3DE419F61EBBF73";
        break;
      case "_encstr_A6FF0747907B08963F":
        var_8 = "_encstr_AAB817B9369BEBB4DCCC5A8DAFD62DB919A50BBE078DC9EBA6";
        break;
      case "_encstr_B2FF07CB61C0A3BF5D":
        var_8 = "_encstr_96B8176E1BCDBED27399B436D7DA4BDC465AC2AFC16339EB8D";
        break;
      case "_encstr_B4FF078F99887B6782":
        var_8 = "_encstr_87B81763D67EE9A3FABBFBE94792FB280C2CA97EBAD45870E7";
        break;
      case "_encstr_B6FF076E1BBD1DFACD":
        var_8 = "_encstr_92B817E68D73BED2CDCC5A8DEBD6D2E68CD258EB838D4EFA64";
        break;
      case "_encstr_A5FF0783687F5B2997":
        var_8 = "_encstr_82B817C862CDE770DB0EDB41DF3FB87DB72AC021EBE5F5CEF6";
        break;
      case "_encstr_8DFF072788ED84018B":
        var_8 = "_encstr_81B817D2BECDE171D0108F83C1E839BAA1C3DE419F61EBBF73";
        break;
      case "_encstr_8FE208C3902FF397C3C7":
        var_8 = "_encstr_AAB817B9369BEBB4DCCC5A8DAFD62DB919A50BBE078DC9EBA6";
        break;
      case "_encstr_91E208468040FBE7DEE6":
        var_8 = "_encstr_96B8176E1BCDBED27399B436D7DA4BDC465AC2AFC16339EB8D";
        break;
      default:
        var_8 = "_encstr_87B81763D67EE9A3FABBFBE94792FB280C2CA97EBAD45870E7";
        break;
    }

    self playlocalsound(var_8);
    self playlocalsound("_encstr_AF901D17937511535BBAF840310F1BD08FE1BBD7301F50AB7762104B59234E");
  }

  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  thread clear_infil_ambient_zone();
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_BA9E0AB5B40EBE2DE6994BB1");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self lerpfovscalefactor(1, 2);
  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

clear_infil_ambient_zone() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 4;
  self setclienttriggeraudiozonepartialwithfade("_encstr_8F5A117D33FB035A430158E6941B3517F0B06B", 4, "_encstr_AB1904853B28");
  wait 4;
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

infil_radio_idle(var_0) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("_encstr_9BFC145FE73DCF7B4E17AAD048EF46A59A6C69883390", 0.05, "_encstr_AB1904853B28");
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    self playlocalsound("_encstr_B4FF1F8F8708C95140E17C05FE606912D50B4FC779254219A14BB24F9340A98BB5");
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_1 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_2 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_3 = "_encstr_84690847F92EFD1AD01F" + var_2 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";
    } else
      var_3 = "_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043";

    if(soundexists(var_3))
      var_1 playLoopSound(var_3);
    else
      var_1 playLoopSound("_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043");

    scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
    wait 1;

    if(isDefined(self))
      self stoplocalsound("_encstr_B4FF1F8F8708C95140E17C05FE606912D50B4FC779254219A14BB24F9340A98BB5");

    wait 1;
    var_1 stoploopsound(var_3);
    var_1 delete();
  }
}

player_disconnect() {
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

  var_3 = getcommanderassets(var_0);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_8B190AC730E03D42856D3FF2", "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3.body, var_3.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_9AE307B956E345D0AB", "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3.body, var_3.head);

  foreach(var_5 in self.actors)
  var_5.infil = self;

  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.actors[1].anim_playsound_func = ::driver_play_sound_func;
}

blima_chief_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.blima.players)
  var_4 playsoundtoplayer(var_0, var_4);
}

infilthink(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4", 0.2);

  foreach(var_4 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_4 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 1.0);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_2);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(self._id_1214C != self.subtype && (getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" || getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_AC880C67503EA82A05DD62214CE7"))
    var_2 = self._id_1214C;

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_0);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  self.linktoent setscriptablepartstate("_encstr_819B0F723920B3DCD3888219800B17633B", "_encstr_8419044EB232", 0);
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9", 0);
  self.linktoent thread _id_11BF2();
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_0);
  var_4 = getanimlength(level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_0]);
  wait(var_4);
  self.linktoent delete();
  self.linktoent = undefined;
}

_id_11BF2() {
  self playsoundonmovingent("_encstr_A90E1AE66C37AF5AE633A5637DB5D2E6912D0BBE0DB2365AF559C347");
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
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_92E20BD5BADA2E49D82688EB2F" + var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_92E20BD5BADA2E49D82688EB2F" + var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2]);
  var_4 = getanimlength(level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2]);
  wait(var_4);

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

initanims(var_0, var_1, var_2) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0, var_1, var_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B4FF078F99887B6782", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B6FF076E1BBD1DFACD", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A5FF0783687F5B2997", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8DFF072788ED84018B", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_8FE208C3902FF397C3C7", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
  scripts\common\anim::addnotetrack_customfunction("_encstr_91E208468040FBE7DEE6", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BA9E0AB5B40EBE2DE6994BB1");
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

script_model_alpha_anims(var_0) {
  level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_A503156B07BE4BB9994B8DF56BA50E7DB3EACB8D7DC089;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_A503156B07BE4BB9994B8DF56BA50E7DB3EACB897DC089";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_AD0D1143FE17C0B1FFAA586A91EBFD702B777B";
  level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_8603154F781669E2C5BB0DC991E3BF17B9C8973369A38A;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_8603154F781669E2C5BB0DC991E3BF17B9C897B369A38A";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_810D110AE855CC236631E940C0E8CFD7A9C907";
  level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_8B0315584FB7C0F5992A2DAF7860FFA7DCABD748E71F7E;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_8B0315584FB7C0F5992A2DAF7860FFA7DCABD74CE71F7E";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_AA0D11986BB6E01131E503B3715A5B490C17C2";
  level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_A90315BBA391D318162CF06ED5F162AFCA1F2B31870F05;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_A90315BBA391D318162CF06ED5F162AFCA1F2B71870F05";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_840D112DDC33D263FA5BD270D7B1CACC3ABE0D";
  level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_8C0315DA83BEB4B9CCB4B1AFB6D2C1D7D9AEF2367D609A;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_8C0315DA83BEB4B9CCB4B1AFB6D2C1D7D9AEF2267D609A";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_B20D1173D82644257760F23308F1ADC2FB7EAD";
  level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_9A0315E883515B400BF1A908DD1FC26F07BB3068E9222D;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_9A0315E883515B400BF1A908DD1FC26F07BB3069E9222D";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_850D11630BD203D89F9DE0D20984D8CC4B6745";
  level.scr_animtree["_encstr_B4FF078F99887B6782"] = #animtree;
  level.scr_anim["_encstr_B4FF078F99887B6782"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_BEB01537836EE16A5D238571196B478F31401FC3E12B71;
  level.scr_animname["_encstr_B4FF078F99887B6782"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_BEB01537836EE16A5D238571196B478F31401F43E12B71";
  level.scr_eventanim["_encstr_B4FF078F99887B6782"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_B4F312D2B966A5D8F5B54B1CFAE44BD9D0A3F526";
  level.scr_animtree["_encstr_B6FF076E1BBD1DFACD"] = #animtree;
  level.scr_anim["_encstr_B6FF076E1BBD1DFACD"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_ACB015D7AB19C708C4D2E07751997841EFB5E24DB7188F;
  level.scr_animname["_encstr_B6FF076E1BBD1DFACD"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_ACB015D7AB19C708C4D2E07751997841EFB5E20DB7188F";
  level.scr_eventanim["_encstr_B6FF076E1BBD1DFACD"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_B1F3124BF32E6899C96D9B3BC933DB1198332952";
  level.scr_animtree["_encstr_A5FF0783687F5B2997"] = #animtree;
  level.scr_anim["_encstr_A5FF0783687F5B2997"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_B8B015C5AFAFC1C599E9FCF19BE0F08E1F8B6F3B29EF8F;
  level.scr_animname["_encstr_A5FF0783687F5B2997"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_B8B015C5AFAFC1C599E9FCF19BE0F08E1F8B6FBB29EF8F";
  level.scr_eventanim["_encstr_A5FF0783687F5B2997"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_A2F312BBD30ADB102725A88A41D2E00442035F97";
  level.scr_animtree["_encstr_8DFF072788ED84018B"] = #animtree;
  level.scr_anim["_encstr_8DFF072788ED84018B"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_8FB0156BE0BE2DDC995AD8BEB6B41CD7B357E5E4F50386;
  level.scr_animname["_encstr_8DFF072788ED84018B"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_8FB0156BE0BE2DDC995AD8BEB6B41CD7B357E5A4F50386";
  level.scr_eventanim["_encstr_8DFF072788ED84018B"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_A9F3122DB9CC2D8DFADAD2E07D4E2DCED0D1AF1A";
  level.scr_animtree["_encstr_8FE208C3902FF397C3C7"] = #animtree;
  level.scr_anim["_encstr_8FE208C3902FF397C3C7"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_91B015BDEB19893AE4037BBF631B27C7B0D330C2A6BA1D;
  level.scr_animname["_encstr_8FE208C3902FF397C3C7"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_91B015BDEB19893AE4037BBF631B27C7B0D330CAA6BA1D";
  level.scr_eventanim["_encstr_8FE208C3902FF397C3C7"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_BAF312A5CD995A1BAFDA2D83F54E2DEC0D47AF9A";
  level.scr_animtree["_encstr_91E208468040FBE7DEE6"] = #animtree;
  level.scr_anim["_encstr_91E208468040FBE7DEE6"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = % _encstr_93B015C06BF7887DFACCB92825E219B63797F8B06F302B;
  level.scr_animname["_encstr_91E208468040FBE7DEE6"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_93B015C06BF7887DFACCB92825E219B63797F8B16F302B";
  level.scr_eventanim["_encstr_91E208468040FBE7DEE6"]["_encstr_BA9E0AB5B40EBE2DE6994BB1"] = "_encstr_9AF3124B3799B4B1FA6B5A83AFE45AB343A3BED8";
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
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

vehicles_alpha_anims(var_0, var_1, var_2) {
  var_3 = getDvar("_encstr_9570084B1793A090CDFF");

  if(isDefined(var_2) && var_0 != var_2 && (var_3 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" || var_3 == "_encstr_AC880C67503EA82A05DD62214CE7")) {
    switch (var_2) {
      case "_encstr_91A40713BCD2887706":
        if(var_1 == "_encstr_8E8405EA382B2A") {
          if(var_3 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB")
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_950823ADE0BEA537335A36FAB55A07BEC213AF1A951BA5AF19B7DDB947BD7773FA56C2DC8E;

          if(var_3 == "_encstr_AC880C67503EA82A05DD62214CE7")
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_BA061FD58371E1624CABC317BBE3CF1F3803C11C5980B9499F4FB3B3F79D028B78;
        } else {
          if(var_3 == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB")
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_866F23A802610B154BFFE098354B91B8B7A7A611273CC8267C47CCB34348145D7F03CF0BA5;

          if(var_3 == "_encstr_AC880C67503EA82A05DD62214CE7")
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_B6701FADE0EBD2B9CC2DB1AFB596E0EBB04CAF1A59C6A5F50E7B278EFABB593747;
        }

        break;
      case "_encstr_ACA407B9984198974F":
        if(var_1 == "_encstr_8E8405EA382B2A")
          level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_8F2723C88F992B066C8890A7C8FBD979323D0FF8C57108E7814FCCEBE520D380AE60B09F5B;
        else
          level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_87B523A0124F58207A87F18F8FD253A109FA6E98FFD48070B2B7CFE5839A3CD09F03517323;

        break;
    }
  } else {
    switch (var_0) {
      case "_encstr_BDBB0616C6C186C2":
        level.scr_animtree["_encstr_8A19047AE0D9"] = #animtree;

        switch (getDvar("_encstr_9570084B1793A090CDFF")) {
          case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_967C22B507D7D2CD665A1BEBD65A0EEB2CFA0D56C6A57DC8F6EECD47BDDD9BEBB22C6E47;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_9AE82240EB7708FD7A4C39A8A5629936B1BFF08823E98691B2F320C53DBB6D7E0FCFA0B8;

            break;
          case "_encstr_93D20D28714743B99070632BAF3944":
          case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_96D120B583AF5A7399A5C6AFD6D20EFA167D86951B96FA5CBA0B9CC9CBFACA2CB93A;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_96D120B583AF5A7399A5C6AFD6D20EFA167D86951B96FA5CBA0B9CC9CBFACA2CB93A;

            break;
          case "_encstr_AC880C67503EA82A05DD62214CE7":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_92011E839BA9EB100E34F896DDF95A08A2BF012B4392B8A82FCAE36EC7D948D5;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_BD6D1E9A43E0F7CD68B3042FA3C880E7175E42826843770248AD14277F801A33;

            break;
          case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_AB42293082FFE890CA17617F7F42C31199D118892D21A15612437B2D2F6A25180F368D2097975887BA0F63;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_9BE8288AD8E70CEB81F32C679908FAD9C3096282A063494358642D42AED0739F17909A5A48DBFB677040;

            break;
          default:
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_8E5D12B6E0EB4BB9334B63BE5B4B0EAFD0561B5A;
            break;
        }

        break;
      case "_encstr_871D0613938567B7":
        level.scr_animtree["_encstr_8A19047AE0D9"] = #animtree;

        switch (getDvar("_encstr_9570084B1793A090CDFF")) {
          case "_encstr_93D20D28714743B99070632BAF3944":
          case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_B88B20D8730FDB18FF0981EF2564F28893F9F0411A6F1828D31985AD49C1D06F0FE3;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_B88B20D8730FDB18FF0981EF2564F28893F9F0411A6F1828D31985AD49C1D06F0FE3;

            break;
          case "_encstr_AC880C67503EA82A05DD62214CE7":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_95CC1EAD077D5ACD999636F5B65A1CFA4CEB0D2B8D4BD7C1F6938EEBACB0E68E;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_81621EBDEB19893AE4037BBF631B27C798967407C0707713480D03C74F355B24;

            break;
          case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_A7FE291D9A2892AAA940C4A6C55F1BA8F2D0D02F640109BBB0EEC5D6A3E0E98569112993772FFF4775F8CF;
            else
              level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_877A282A482760507FD0A1D1F5127327F22E6C612D48F1E8E71097E3D6321182477A37302B4F3318B7E3;

            break;
          default:
            level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0 + "_encstr_BA4C02DF" + var_1] = % _encstr_8E5D12B6E0EB4BB9334B63BE5B4B0EAFD0561B5A;
            break;
        }

        break;
      default:
        level.scr_anim["_encstr_8A19047AE0D9"]["_encstr_92E20BD5BADA2E49D82688EB2F" + var_0] = % _encstr_8E5D12B6E0EB4BB9334B63BE5B4B0EAFD0561B5A;
        break;
    }
  }
}

spawninfilvehicle(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;
  var_5 = "_encstr_95541DB4F5339227C532C849AA9C35365F91302541BF4ADF2C6A90F01239F9";

  if(var_1 == "_encstr_9A8507BA4040188D08")
    var_5 = "_encstr_860622ED65E43A58477A6836C26F8649FDF155B1010E8280C752835B4907B058145CAF01";

  var_6 = spawnVehicle(var_5, var_2, "_encstr_A6320D807AE04FD84366B339479723", var_3, var_4);
  var_6 setvehicleteam(var_1);
  var_6.animname = "_encstr_8A19047AE0D9";
  var_6 setCanDamage(0);
  var_6 notsolid();
  var_6.infil = self;
  return var_6;
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

driver_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

getcommanderassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "_encstr_A1FF2A137B232FAFB5387DB2859B8E2B9C37FA999627CAD12BC26BEB561637477D9BECF5377BEBDCD896B976";
  var_1.head = "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693";
  return var_1;
}

customground(var_0) {
  scripts\mp\utility\infilexfil::cam_shake_off(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;
}

_id_11C9E(var_0, var_1, var_2) {
  switch (level.mapname) {
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      switch (var_1) {
        case "_encstr_9A8507BA4040188D08":
          switch (var_2) {
            case "_encstr_BDBB0616C6C186C2":
              break;
            case "_encstr_871D0613938567B7":
              var_0.origin = var_0.origin + anglesToForward(var_0.angles) * 200;
              break;
          }

          break;
        case "_encstr_8E8405EA382B2A":
          switch (var_2) {
            case "_encstr_BDBB0616C6C186C2":
              break;
            case "_encstr_871D0613938567B7":
              var_0.origin = var_0.origin + anglestoup(var_0.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}