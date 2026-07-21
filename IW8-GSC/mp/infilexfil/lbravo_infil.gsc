/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\lbravo_infil.gsc
***********************************************/

lbravo_init(var_0) {
  var_1 = [];
  var_1[0] = [0, 1];
  var_1[1] = [2, 3];
  var_1[2] = [4];
  var_1[3] = [5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_91540D2DDC33D263FA36132785B3DE", var_0, 6, 4, var_1, ::lbravo_spawn, ::lbravo_get_length, ::player_lbravo_infil_think);
}

lbravo_spawn(var_0, var_1, var_2, var_3) {
  initanims(var_2, var_0, var_3);
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_12802(var_4, var_0, var_2, var_3);
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);

  if(!isDefined(var_4.angles))
    var_4.angles = (0, 0, 0);

  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  var_5.subtype = var_2;
  var_5._id_1214C = var_3;
  var_5 thread infilthink(var_0, var_2);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" && isDefined(var_4.target))
    level.teamdata[var_0]["_encstr_9A57156FC9BAA32553C204684AF75D10952E8FBD75E048"] = var_4.target;

  return var_5;
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
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      switch (var_3) {
        case "_encstr_ACA407B9984198974F":
          if(var_1 == "_encstr_9A8507BA4040188D08")
            var_0.origin = var_0.origin + anglesToForward(var_0.angles) * 100;

          break;
        case "_encstr_84F607E03B912337C7":
          if(var_1 == "_encstr_9A8507BA4040188D08") {
            var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -50;
            var_0.origin = var_0.origin + anglestoright(var_0.angles) * -10;
          }

          break;
      }

      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      if(var_1 == "_encstr_8E8405EA382B2A" && var_2 == "_encstr_871D0613938567B7") {
        var_0.origin = (8296.4, 786.17, 286);
        var_0.angles = (0, 210, 0);
      }

      if(var_1 == "_encstr_9A8507BA4040188D08") {
        switch (level.gametype) {
          case "_encstr_BDD705AD7BD143":
          case "_encstr_8E07030349":
          case "_encstr_9A7205B39CB919":
          case "_encstr_B60703EACA":
          case "_encstr_ACF906B79752C5E8":
          case "_encstr_B807035284":
          case "_encstr_9B0703CD93":
            var_0.angles = (var_0.angles[0], 344, var_0.angles[2]);
            break;
        }
      }

      break;
  }
}

lbravo_get_length(var_0) {
  if(issubstr(var_0, "_encstr_BDBB0616C6C186C2"))
    var_0 = "_encstr_BDBB0616C6C186C2";

  if(issubstr(var_0, "_encstr_871D0613938567B7"))
    var_0 = "_encstr_871D0613938567B7";

  if(isDefined(self.path)) {
    var_1 = scripts\mp\infilexfil\infilexfil::parsehelipathlength();
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
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(isPlayer(self))
    self setclienttriggeraudiozone("_encstr_8CDF133561B84943A8A7B7B3CD432ABF9808AB3A78", 1);

  thread lbravo_infil_radio_idle();
  thread player_infil_end(var_0);
  var_2 = var_0.linktoent gettagorigin("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_3 = var_0.linktoent gettagangles("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
  self lerpfovscalefactor(0, 0);
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_9A1804890618", 0);
  var_4 = var_1 == 0 || var_1 == 1;

  if(istrue(level.interactiveinfil) && !isai(self) && var_4)
    giveinteractiveinfilweapon();
  else
    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");

  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_van_disconnect();
  thread cinematiccameratimeline(var_0);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self nightvisionviewon();

  if(isDefined(self.team) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_5 = [];
    var_5[var_5.size] = "_encstr_B2B718088BB854DD36488AE1279048117D0BE3334A626A629037";
    var_5[var_5.size] = "_encstr_8C4318B51C7D2DE6995A63AF6BA587F5DAD56EB4D8D84B3B1A3A";
    var_5[var_5.size] = "_encstr_AA9114AD38BE5A73CCB4D87D5B5A87FA9BBDE45BC21B";
    var_6 = var_5.size;
    var_7 = randomint(var_6);

    if(self.team == "_encstr_9A8507BA4040188D08") {
      var_8 = game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"].size;
      level.cur_infil_track = randomint(var_8);
      self setsoundsubmix(var_5[var_7]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"][level.cur_infil_track]);
      self._id_12463 = 1;
    } else {
      var_8 = game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"].size;
      level.cur_infil_track = randomint(var_8);
      self setsoundsubmix(var_5[var_7]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"][level.cur_infil_track]);
      self._id_12463 = 1;
    }
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var_9 = "_encstr_97721B78D27D57C04B9E4B314FAB69D5662B2091FAD77998B790C13619";

    if(isDefined(var_0.subtype)) {
      if(var_0.subtype == "_encstr_BDBB0616C6C186C2") {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_9 = "_encstr_97721B78D27D57C04B9E4B314FAB69D5662B2091FAD77998B790C13619";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_9 = "_encstr_88721B3B8F3899F76091F2AA9E49030AA85DAF8F31D81DBF804B9A53CB";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_9 = "_encstr_81721B4F9848D71A4DA4C4BDAF61E2A2F158477758812CC2D7478D325E";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_9 = "_encstr_8A721B56360A57C88E4398A8BFD4E145821BC0C84C12E9305733B8507A";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_9 = "_encstr_84721BE636E6BED23799B4B1FA1B89392C3BF6D7432BD8A5F50E6339A6";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_9 = "_encstr_AD721BB6D6EAB7286E63B8889FB48125A23B20286C32891077D3987012";
            break;
          default:
            var_9 = "_encstr_97721B78D27D57C04B9E4B314FAB69D5662B2091FAD77998B790C13619";
            break;
        }
      } else {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_9 = "_encstr_B40E2143EA35699C253A7A40D9E5B56A699E107F52505715677103BAA023F6F8E19DEA";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_9 = "_encstr_B60E213B8E36A1EB82F3A3A1FF4AA630D12320367672181CCA2FB94B2B22606864BA03";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_9 = "_encstr_A60E21831F1D8F40A0413785D9598D32111B7B9F783B58F380C171D5D2E719AB2CA5C2";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_9 = "_encstr_B20E2147B02EC9641538F21908F12E83595BF7FF18D309B44719F33B305B779A4235D9";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_9 = "_encstr_840E216EC637BE4B7399D2D8D7B1C4E4B0ECDB7D1339C23BDBBE0D568D4BEB0EC6274D";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_9 = "_encstr_8A0E21B750C839CBF0CADA95F0DA31E229C33D511312DE4E388628E5F0C0B1607DD81E";
            break;
          default:
            var_9 = "_encstr_B40E2143EA35699C253A7A40D9E5B56A699E107F52505715677103BAA023F6F8E19DEA";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("_encstr_93A00D2BE8727FFB4F87B332E1D4B3", 2);
    self playlocalsound(var_9);
  }

  self setcinematicmotionoverride("_encstr_A3FA119934268978BB01837A036FE9D3E4CC50");

  if(istrue(level.interactiveinfil) && !isai(self) && var_4)
    thread allowinteractivecombat();

  if(isDefined(var_0.path))
    thread playerthinkpath(var_0, var_1);
  else
    thread playerthinkanim(var_0, var_1);

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self setcinematicmotionoverride("_encstr_966114C11CA2DF8241981BD2E8ABBD8B60885E7FB9F3");
  self setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_934C0218", 0);
  self.manualoverridewindmaterial = 0;
}

playerthinkpath(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(var_1 == 0)
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  else if(var_1 == 1)
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);

  rideloop(var_0);
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  self lerpfovscalefactor(1, 2);
  self stopanimscriptsceneevent();
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0.subtype + "_encstr_AAD30BBED8DBED38AF59F05A1D", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  self setcinematicmotionoverride("_encstr_966114C11CA2DF8241981BD2E8ABBD8B60885E7FB9F3");
  self.player_rig unlink();
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0.subtype + "_encstr_96D206F968DB6F43");
}

rideloop(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0.linktoent endon("_encstr_81A8077D3088BFA631");

  for(;;)
    var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_0.subtype + "_encstr_A3850616E56F783F", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

playerthinkanim(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_2 = var_0.subtype;

  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
    if(self.team == "_encstr_9A8507BA4040188D08" && (var_0._id_1214C == "_encstr_91A40713BCD2887706" || var_0._id_1214C == "_encstr_ACA407B9984198974F"))
      var_2 = "_encstr_871D0613938567B7";

    if(self.team == "_encstr_8E8405EA382B2A" && var_0._id_1214C == "_encstr_871D0613938567B7")
      var_2 = "_encstr_BDBB0616C6C186C2";
  }

  if(var_1 == 0)
    self lerpviewangleclamp(1, 0.25, 0.25, 10, 45, 45, 45);
  else if(var_1 == 1)
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 10, 45, 45);
  else
    self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);

  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");

  if(self islinked())
    self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);

  self.player_rig unlink();
  self lerpfovscalefactor(1, 2);
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_96D206F968DB6F43");
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
}

scriptswitchweaponhack() {
  waitframe();
  self notify("_encstr_AC251B5FF7CD10B91FC3D19EAAE76D60E959FDDD69F52177035A688363");
}

clear_infil_ambient_zone() {
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

lbravo_infil_radio_idle() {
  if(isPlayer(self)) {
    var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_0 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_2 = "_encstr_84690847F92EFD1AD01F" + var_1 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";
    } else
      var_2 = "_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043";

    if(soundexists(var_2))
      var_0 playLoopSound(var_2);
    else
      var_0 playLoopSound("_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043");

    scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
    wait 2;
    var_0 stoploopsound(var_2);
    var_0 delete();
  }
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
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

infilthink(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4", 0.2);

  foreach(var_4 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_4 delete();

  if(issubstr(var_1, "_encstr_BDBB0616C6C186C2"))
    var_1 = "_encstr_BDBB0616C6C186C2";

  if(issubstr(var_1, "_encstr_871D0613938567B7"))
    var_1 = "_encstr_871D0613938567B7";

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 1.0);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  self notify("_encstr_B2600CF8759933D3EE634E77CB7A");

  if(istrue(level.interactiveinfil))
    level thread interactiveinfilthink(var_0);

  scripts\engine\utility::waittill_any_ents(level, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA", self, "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_2);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path))
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
  else
    thread vehiclethinkanim(var_0, var_1, var_2, var_3);

  thread heli_interior_sfx(var_2);
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  wait 3.0;
  self.linktoent solid();
}

vehiclethinkanim(var_0, var_1, var_2, var_3) {
  if(self._id_1214C != self.subtype && getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB")
    var_2 = self._id_1214C;

  if(var_0 == "_encstr_9A8507BA4040188D08" && (self._id_1214C == "_encstr_BDBB0616C6C186C2" || self._id_1214C == "_encstr_ACA407B9984198974F") && getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4")
    var_2 = self._id_1214C;

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_0);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9", 0);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_0);
  var_4 = getanimlength(level.scr_anim[self.linktoent.animname]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_0]);
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

  if(var_1 == "_encstr_9A8507BA4040188D08")
    var_5 = "_encstr_B6F81EC3887190E7383BE4DFC740AB8191280B0AB8273113119EE3176888BF15";
  else
    var_5 = "_encstr_9B6E239DB28607F5B696B1FA85B4E4F536264E16CEB7D707CAC9CDDE9BB956C67DAC0BDC3A";

  var_6 = spawnVehicle(var_5, var_2, "_encstr_BADC10304DDB593E1FE6C245DCE75BCF28E3", var_3, var_4);
  var_6 setvehicleteam(var_1);
  var_6.animname = "_encstr_951007814D5B63F807";
  var_6 setCanDamage(0);
  var_6 notsolid();
  var_6.infil = self;
  var_7 = getEnt("_encstr_BD300CB126390BB3F6BE8DD8A507", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_7)) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
    var_8.angles = var_6.angles;
    var_8 clonebrushmodeltoscriptmodel(var_7);
    var_8 linkTo(var_6);
  }

  return var_6;
}

actorthink(var_0, var_1, var_2, var_3) {
  self.actors = thread spawnactors(var_0, var_2, var_3);
  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    actorthinkpath(var_0, var_1, var_2, var_3);
  else
    actorthinkanim(var_0, var_1, var_2, var_3);
}

actorthinkpath(var_0, var_1, var_2, var_3) {
  thread actorloopthink(self.actors[0]);
  thread actorloopthink(self.actors[1]);
}

actorloopthink(var_0) {
  actorloop(var_0);
}

actorloop(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self.linktoent endon("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");

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
  var_3[var_3.size] = self.linktoent spawn_anim_model("_encstr_A266062032BD7723", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8", "_encstr_A58B1E9A82C3E42F28B32C0FB38FBBC53843DF27C2E0DF9AF011F5CF13C8E6A0");
  var_3[var_3.size] = self.linktoent spawn_anim_model("_encstr_9B7408BFEF17BA445893", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8", "_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F");

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

initanims(var_0, var_1, var_2) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0, var_1, var_2);
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
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::_id_12497, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::rumble_low, "_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44");
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
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_A9BB1FD20BA8AF9520CB4C77E928DAD76480899A761C178862BF7D489BC0A94701;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_A9BB1FD20BA8AF9520CB4C77E928DAD76480899A761C178862BF7D489BC0A94701";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_826C1681D02947C567B0EAE3B05D7DE7A1D01518FBB3575A";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_A97D16F3E20F1804595A721ADF25675698F6B0DF2AAF198F";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_87801B230DF2438DD73368E0EF16B8F72AF929B825EB6769C83F209196";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_BAA81158ED1E3049713B557D27CBB739B109AB";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_B8431FF952B99B88269F50D1937A43C3933D787761D27B525A2F10E0AF843E574A;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_B8431FF952B99B88269F50D1937A43C3933D787761D27B525A2F10E0AF843E574A";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_926C16331DE253F027C378F0DF26A8873AC9BDC3B49B77F3";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AF7D16B05D4EDB026654D6E2A7C86701C9E9802017DAE125";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_96801B20CD47C301AF382233C7F050AE7756190F42707E8D29C0F139F6";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A9A811883DCEE099410B052D57BB500961D97B";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_8E261F5B1CBE4BDC3396C6FAB18939589DED7DC2FA3B5DF299BEB21E4B8EFAEEDA;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_8E261F5B1CBE4BDC3396C6FAB18939589DED7DC2FA3B5DF299BEB21E4B8EFAEEDA";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_BE6C162D3733D2C6FAC6C4E40B677BD72CAF9587D28ED766";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_9A7D162DDC335AC6BEB1139C0BECB7AF0BEB1BB7DBE07D33";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_88801B967399A51BFAC6262758D9F6EB167D36BDF6C1BE95E1B4E8F533";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A6A81144A30FFF59E103EA236A63A5E9EA0F43";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_A9F91F8922C9EBF8568F40E1A36AB333830D680771E26B426C3F2BD05F942E475A;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_A9F91F8922C9EBF8568F40E1A36AB333830D680771E26B426C3F2BD05F942E475A";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_816C161B9ED46B094F3BC2D0B10327C9EF57B9E8A314192B";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_A27D169CF0055ABC3EB86B23F83367E1E3802595E89171AC";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_81801BAA48F56C83C611426ABFCB473923290242D871A9FF5A8B5C4FED";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_B6A8115ACD33D263F53689C958B3DBD70BBEA9";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_AD1C1FA81A57403872BFF997831A7E5816B596A149D7686BBF7FD3C1EF23D020D5;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_AD1C1FA81A57403872BFF997831A7E5816B596A149D7686BBF7FD3C1EF23D020D5";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_886C16D2CD99B436FA36139C853BED7DB07D591E4B1D7D9A";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_957D1629AB23E4DAC15DEB5B873338617029B260680BC04D";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_AA801B517BD1ABFD3728FD23273B82B777F9B9F070EB0F472A2A1B2163";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = % _encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BA0C13046BDE272EB7A9F8269E98ABB90861924C96"] = "_encstr_B4A811DC48B0E9BAD8A9E3AB9B74B26720F683";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = % _encstr_B2A41FED4796DFEDBD20A2A9308DA2B7EBA05799483917F0F5793AD370C9D13760;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_B2A41FED4796DFEDBD20A2A9308DA2B7EBA05799483917F0F5793AD370C9D13760";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A558188D133985B3DED7B4B9992DC6EB0B8D0EA158BE593C4B3A"] = "_encstr_966C161FC871A90277F94E42571D0A5739D9A7A318EB27EF";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = % _encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8F101863C49C0BCEB7F5A59B995A1BF50BD8E08658FAB1B7EDE0"] = "_encstr_BA7D16FBD52A9BC81F8B20B8A76EE0BFE231E1706DA32FBB";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = % _encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_86481D51EA1A8844C78140A83AF771C1764CF1D19109A8B71F8B9EF1C38F35"] = "_encstr_97801BB4CDCCB463BEC6899316B3DBAF857D1BDBED1CFA2BF05AD1EBB1";
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_A26518390B213B6AD3C38AD1219DCB88B64F9F50D0594955C088;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_A26518390B213B6AD3C38AD1219DCB88B64F9F50D0594955C088";
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B";
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_8DB31AD638F52DCD992D8DAF63319C58CEDE7D89EBD87B07B41BEDE8;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_8DB31AD638F52DCD992D8DAF63319C58CEDE7D89EBD87B07B41BEDE8";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AC681A6B1B21BBADED73D599C96BAB86D44D8983E651B32313799F18";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_97A811973504EBD997A5307B02BB27A902A6DA";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8E741F1873A1ABB01BE1B938CC23FB03532A11E8F9C7DB6A9E2F35A3D10306E77D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8B5F165A9B334B8DBE63C4C958ECEDEB89BEB23C5AD1AF13";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_A97D16F3E20F1804595A721ADF25675698F6B0DF2AAF198F";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_87801B230DF2438DD73368E0EF16B8F72AF929B825EB6769C83F209196";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_885C1ADA38AF5ADCCC5A36BED889E40B9DEDD74CD7B3572F46BEDDB6";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AAA811A078C238E85F0B63FDBB28578F6A8792";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8D2D1F6DE02033206E77B35F79359E275BC8172248E4CBB37247C5EBDF936707A9";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_8D5F1696CD99B48DAFC69893B0CEEDBE987D2B0F4B47FA91";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_AF7D16B05D4EDB026654D6E2A7C86701C9E9802017DAE125";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_96801B20CD47C301AF382233C7F050AE7756190F42707E8D29C0F139F6";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_BD571A92C0FF6483F99B447F2141CBAE05A0399A5157DB973BE84775";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_81A8116130C9A7E54790CAC3D03D1DC7E130A3";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A36C1FDA0EBED237332D36AFC6133916677BD713D7D9BAF2CCFA953C2D477D775B";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A55F16B8126F2B707F643E2E41F3D8FFD6A940B81A830FA3";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_9A7D162DDC335AC6BEB1139C0BECB7AF0BEB1BB7DBE07D33";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_88801B967399A51BFAC6262758D9F6EB167D36BDF6C1BE95E1B4E8F533";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_BE4C1AB60EFA4BB9334B63F56398C9C23BB7EB4C7DECBA2FA1EB77B5";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_B2A811ACF5C5931BFFAB01E6A8F52F99C8319C";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_96641FC59F4E070555D84A7118B5FADF83886F42A0113F88A951C2FB28A1F9CF58";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_9A5F16E490A528BA6150907E7F235FB93E872BC31060AF03";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_A27D169CF0055ABC3EB86B23F83367E1E3802595E89171AC";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_81801BAA48F56C83C611426ABFCB473923290242D871A9FF5A8B5C4FED";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_AC461A913AD1F3D07EB768F94B92AB1BAB65AFAE590A837A7557A890";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_84A811BF68D149E29719AEA2F7BDAA37397946";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_82901FFDAB59C97AA4433BFFA15E4339F8D0F986E6C09D432517079BB37DD96798";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_AF5F164B37994B8DFA6326E42C3BB7AF26D7ACE15AD1EBA6";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_957D1629AB23E4DAC15DEB5B873338617029B260680BC04D";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_AA801B517BD1ABFD3728FD23273B82B777F9B9F070EB0F472A2A1B2163";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = % _encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_A23E1AC16A81A3A00EC738A9FB227BEB7BD550DE09BA538AA607D820";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A967131B31272C3BBDEB2DCD994BB1F5264EC2D9DB"] = "_encstr_8AA8119673662D36BED84CE40BD9DB7DC4D7D8";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = % _encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_ADB11FC55029F0858620284622BB12C96B87817847C9EBB3725720833079E7ABB8";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A25A185012AAFBF3FF17FB6006CFF83F16BBA0083A093B0ABF44"] = "_encstr_A95F165A37CC2DD8F563989C16D9DEEB267D2BC3B43AF51B";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = % _encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8E9618842D78B62B401692EAD9AB9BE150B501065F69BD0778EB"] = "_encstr_BA7D16FBD52A9BC81F8B20B8A76EE0BFE231E1706DA32FBB";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = % _encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B4F1DC6C42716ECB7F596DC332D8DD7C44EB03BBDD71BDBED83D795C3B48E"] = "_encstr_97801BB4CDCCB463BEC6899316B3DBAF857D1BDBED1CFA2BF05AD1EBB1";
      break;
    default:
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

vehicles_alpha_anims(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_0 != var_2 && getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
    switch (var_2) {
      case "_encstr_91A40713BCD2887706":
        if(var_1 == "_encstr_8E8405EA382B2A")
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_8B252570C2BFA8D08A5721BFBB3226204E9DBE49A1E0B09952A739D7FFDA6D08E73526415643F0;
        else
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_ADFE26E8501F534DA8B13487A1C203A9D6C2AF6D0AF6C0B1613A46915F334549E5A7CA4F3B556BCD;

        break;
      case "_encstr_ACA407B9984198974F":
        if(var_1 == "_encstr_8E8405EA382B2A")
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_8B252570C2BFA8D08A5721BFBB3226204E9DBE49A1E0B09952A739D7FFDA6D08E73526415643F0;
        else
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_881E269932D9FBE846BF70F1B39AA323B31D1896DA71A1F12497E12057A778718A8308B0238A5F1B;

        break;
      case "_encstr_8AF607CE7287CBD742":
        if(var_1 == "_encstr_8E8405EA382B2A")
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_B68826ADC1FAA5CD99D2B1FAC6C4932C677B7D89197DD0CAC6D27D91DBDDCDA3ED779BD72BB06EE8;
        else
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_881E269932D9FBE846BF70F1B39AA323B31D1896DA71A1F12497E12057A778718A8308B0238A5F1B;

        break;
      case "_encstr_84F607E03B912337C7":
        if(var_1 == "_encstr_8E8405EA382B2A")
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_929026686BB073F0A0498D5770A6CB301C5F393A6361495598A7582FCF57C88BBA7B5869F9D66BF8;
        else
          level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_ADFE26E8501F534DA8B13487A1C203A9D6C2AF6D0AF6C0B1613A46915F334549E5A7CA4F3B556BCD;

        break;
    }
  } else {
    switch (var_0) {
      case "_encstr_BDBB0616C6C186C2":
        level.scr_animtree["_encstr_951007814D5B63F807"] = #animtree;

        switch (getDvar("_encstr_9570084B1793A090CDFF")) {
          case "_encstr_93D20D28714743B99070632BAF3944":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_AADA24C703E98A8E57B4807E406002D12BA760E0C1CB09316AD65C6BC5C5C757BFF8797F9033;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_936F24DAC1AF9637CC961BEB8D98C9C23B7BF558EBA19563D2D7661693D67DB3BBD7DD2B6E3A;

            break;
          case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_8B252570C2BFA8D08A5721BFBB3226204E9DBE49A1E0B09952A739D7FFDA6D08E73526415643F0;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_93BA259A43E0F7CD68B3042FA190121F9C5831C20EC39F0578F704177FD8DB5F44D0C92BD12613;

            break;
          case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_B15423938BB9FB203E04E8866DE21827C30F7F139F72B578599173DBD6DA5063098FFBBFAB;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_99E12318B32F40B5020461E05D1AD5096EB701E0A7A019791AA1E7FD76331DF29F7FA8F893;

            break;
          case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_A6C42605E37F4CAB95B3C92972EEF8C174B8FF2F1758DAA38BF76B162A7BC7FA390C0481E76FE7E8;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_8569250A58678C6B0173ACE799E953D66D089142B9E147BBD870ACD527F18B9DF52019BB806F7B;

            break;
          case "_encstr_A3890850E25F90B79A83":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_BD241CF05B27E320D72199875CBE88BFDB020EF931132DE82C3FADF371E7;
            break;
          case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_92C2215B0E7D969B99D28DEB634C4EC2B37B7D0BF51AAC632DFA0E598E39DBEC9CC2C8;
            break;
          case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_A77A225A0837DC3BB1C31C3769198366DD58E1120931970B88200809F64197EF0BD85AEB;
            break;
          case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
            if(var_1 == "_encstr_8E8405EA382B2A") {
              switch (level.gametype) {
                case "_encstr_BDD705AD7BD143":
                case "_encstr_8E07030349":
                case "_encstr_9A7205B39CB919":
                case "_encstr_B60703EACA":
                case "_encstr_ACF906B79752C5E8":
                case "_encstr_B807035284":
                case "_encstr_9B0703CD93":
                  level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_883917B05BB908305507C817F11A9B86A0B2F7C7EF5A3DDBF8;
                  break;
                default:
                  level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_A6C42605E37F4CAB95B3C92972EEF8C174B8FF2F1758DAA38BF76B162A7BC7FA390C0481E76FE7E8;
                  break;
              }
            } else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_AD50219012EFF9157D50902F408B36B0430DA933870968AAAAB8DB687BBB4E2089DCFA;

            break;
          case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_8C5827AD0ED74BB9994BC6D71B4C270BECDB7DC2F5D095D85AAFB0DCD2972C1AD7D185D81D968D16C6;
            break;
          case "_encstr_BD960C6B0ED7CAD61CED395AD5B6":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_B21225B6E0F5B4B9CCD28DAFD81393B03BB7EB58AF4395B15ABECAD61CDB39B4D5D6BE59583747;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_BDA8253992795B48E6DF1091D33A038353FDB8B721621B30C1EF50088B5F5B2B8BE530C4070BF1;

            break;
          case "_encstr_8E2D0CDA88B79E8791429C87E593":
          case "_encstr_A9940CCB60D9B8B3B33AD901B212":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_83101FADE0FA4B379996C6F5D8319CC267B77D2CBE8695B196AF980B8D5BB17B3A;
            break;
          case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
            if(var_1 == "_encstr_9A8507BA4040188D08" && var_2 == "_encstr_BDBB0616C6C186C2" || var_2 == "_encstr_ACA407B9984198974F")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_92C2215B0E7D969B99D28DEB634C4EC2B37B7D0BF51AAC632DFA0E598E39DBEC9CC2C8;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_883917B05BB908305507C817F11A9B86A0B2F7C7EF5A3DDBF8;

            break;
          case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
            if(var_1 == "_encstr_8E8405EA382B2A" && var_2 == "_encstr_BDBB0616C6C186C2")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_96550ED84C3958B3DEAFA5CD992D1BEB" + var_2 + "_encstr_BA4C02DF" + var_1] = % _encstr_8C5827AD0ED74BB9994BC6D71B4C270BECDB7DC2F5D095D85AAFB0DCD2972C1AD7D185D81D968D16C6;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_883917B05BB908305507C817F11A9B86A0B2F7C7EF5A3DDBF8;

            break;
          case "_encstr_87B60AA0124F68A3DAEBFBFF":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_8ABA280A0BDF5340F070D89FC46AC3C79E97E7E6FE5BF5F2C8E9350214839B5718830A1001D26B3F08B3;
            break;
          case "_encstr_ACFD0AAAF8C7AFF723550536":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_AF891E88B30FCB25DDC82BC938F65BB340ED01789868C361336F77D79AC305F8;
            break;
          case "_encstr_96040A5B1CAF0D163926ED9C":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_A67F1EE3F36F3A2D53C7E1B66C060530037FE17AB980DD68EAFF10971BB2080A;
            break;
          case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_92742CC290AF54B3C94B94AFD1911B9E55D0699A81B90FF32DB87281F41953A2B36072F1E81985EFB99B698E0621;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_A6922B69909FC835776298F9CA8EC501E327F8D7272B31699C2960404367BD1B37D47D40738F79A1C483A068DA;

            break;
          default:
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_8CCA14A4260DAAC3583171AEEA7BB037073970939F96" + var_1] = % _encstr_883917B05BB908305507C817F11A9B86A0B2F7C7EF5A3DDBF8;
            break;
        }

        break;
      case "_encstr_871D0613938567B7":
        level.scr_animtree["_encstr_951007814D5B63F807"] = #animtree;

        switch (getDvar("_encstr_9570084B1793A090CDFF")) {
          case "_encstr_93D20D28714743B99070632BAF3944":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_BE18245BE07D96733396D8AF6331C92C9DBDEB13BE4356B1B4AF33B039DAFAB3DDF5AC85CD8E;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8AA52450E25F48306AB7C19F9B1206402EBD9EC941C090F97287DDEB8B8AD8A8C71903A1F224;

            break;
          case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8B252570C2BFA8D08A5721BFBB3226204E9DBE49A1E0B09952A739D7FFDA6D08E73526415643F0;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_93BA259A43E0F7CD68B3042FA190121F9C5831C20EC39F0578F704177FD8DB5F44D0C92BD12613;

            break;
          case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_AF842388B30FCB25DDC82BC938F65BB340ED01609868C361336F2FDD5E9B8E40E6C7D388BB;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_B4EF231741300AF6A0A09DA9F87812427CE75793B7C3B2BCF04ED22B71D05A9B403F275F99;

            break;
          case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_A91526AF98F649C2E59B2DE971957B09BBF8EF2B49C8BD2AD3B876DDEB8B82D826D0D7576041E3F3;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_91BB25B6E0D7A537665A367D1BC4E4C2CEB7EB89D743CA3696BE23ACB023F4DBB956D7BBACB9A3;

            break;
          case "_encstr_B6EE0A72AB0863F3C065A5BA":
          case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_86381E938BB9FB203E04E8866DE21827C30F7F159F72B578599113DB15C6E8E6;
            break;
          case "_encstr_A3890850E25F90B79A83":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_B6D61C02506F9473090BD4EF91D15BDE9510A96AC1F94FB3C078B2C93BF9;
            break;
          case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
            if(var_1 == "_encstr_8E8405EA382B2A") {
              switch (level.gametype) {
                case "_encstr_BDD705AD7BD143":
                case "_encstr_8E07030349":
                case "_encstr_9A7205B39CB919":
                case "_encstr_B60703EACA":
                case "_encstr_ACF906B79752C5E8":
                case "_encstr_B807035284":
                case "_encstr_9B0703CD93":
                  level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8E8B178FD998A25E180805C180108AFAE40FBF3B1FBB2A0418;
                  break;
                default:
                  level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_A91526AF98F649C2E59B2DE971957B09BBF8EF2B49C8BD2AD3B876DDEB8B82D826D0D7576041E3F3;
                  break;
              }
            } else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_A5A6215D11C18B98E16140F122E26DA70EDD1FF82FA828F961C9DF0BFB606FF0AFA4D1;

            break;
          case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8C5827AD0ED74BB9994BC6D71B4C270BECDB7DC2F5D095D85AAFB0DCD2972C1AD7D185D81D968D16C6;
            break;
          case "_encstr_87B60AA0124F68A3DAEBFBFF":
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_811C28C0EA70672503C3984E70AAD27B9492AE1D27C89D4BFBBF9F5098C3B0BF3F2EBF21FB6351D06F10;
            break;
          case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
            if(var_1 == "_encstr_8E8405EA382B2A")
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_820D2CCA671103CA4684C0E7F850D30226E2B18AC92B214CC38813414B7F934B4C0A5DD0B35ABA93B99017252F89;
            else
              level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_821B2B9932D9FBE846BF70F1B39AA323B31D18964102BBD0214F884833B5FB7FEA478DB0262A7B18199B68806B;

            break;
          default:
            level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8E8B178FD998A25E180805C180108AFAE40FBF3B1FBB2A0418;
            break;
        }

        break;
      default:
        level.scr_anim["_encstr_951007814D5B63F807"]["_encstr_BA0514B1C49358D9B7D7D237339636F5262716B3DBD7" + var_1] = % _encstr_8E8B178FD998A25E180805C180108AFAE40FBF3B1FBB2A0418;
        break;
    }
  }
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

vehiclethinkpath(var_0, var_1, var_2, var_3) {
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  self.linktoent.unload_hover_offset = 116;
  self.linktoent.unload_time = 3.5;
  self.linktoent thread scripts\mp\infilexfil\infilexfil::vehicle_paths_helicopter(self.path);
  thread scripts\mp\infilexfil\infilexfil::heli_path(self.linktoent);
  self.linktoent waittill("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");
  self.linktoent delete();
  self.linktoent = undefined;
}

heli_interior_sfx(var_0) {
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  if(var_0 == "_encstr_BDBB0616C6C186C2") {
    self.linktoent playsoundonmovingent("_encstr_A7141A9F489807CABD54346DD051B2D2810877A7A8517CB25BE07DE2");
    self.linktoent playsoundonmovingent("_encstr_A5211CCF51A01133B8617BB5D9AA962273839F8E7AE3CC514B31DD0F20E3");
  } else {
    self.linktoent playsoundonmovingent("_encstr_B11C1A53E750F18F18F9AA82A661EBF27065F7F769E0C5571EF6F26B");
    self.linktoent playsoundonmovingent("_encstr_88A01C9BC6CD7DB4CDCCB463AFB1269C2CD9F67D1AB2634BC87D33CA5647");
  }

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
}

giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0", ["_encstr_8B210CA32782D679D89B8170D7DA", "_encstr_911E0E079317F02187A84A707A7F3BEA", "_encstr_93610D39B387B277C7E91F88A9C288", "_encstr_ACE80C9DC211299881B808595D9A", "_encstr_8EA813FB5BED0880AFE213181AD6EF11C5B90F61D4", "_encstr_8C741265D01867A218E587ABAFB73A80A0F98BBA"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  scripts\common\utility::allow_weapon_switch(1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.infilweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\mp\utility\weapon::setrecoilscale(0.0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

allowinteractivecombat(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  thread interactivecombatmessaging();
  wait(level.interactiveinfilstart);
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  self.infil waittill("_encstr_A2551C974B25AB2BF9EB434FCF03B270CC5990F66A3FAF79313CC067525F");
  self.interactivecombat = 0;
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");
}

interactivecombatmessaging() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.infil waittill("_encstr_AD150C59EC5673D1AF5ACD4793F6");
  self iprintlnbold("_encstr_921F1CA2B959B55ACA6E02CD387B8EA356232408319601A5B901D07BA309");
  wait 3.25;
  var_0 = getinteractiveinfilline(self.animname, level.mapname);
  self iprintlnbold(var_0);
  self.infil waittill("_encstr_9B791AB7D43B128C1698ABAF60AB59DA87FC3CEDB547DB9F386897A3");
  self iprintlnbold("_encstr_A2B01F8A0BE43B958E3708A92CC9DA2B469008A82CAD56803A86B25B10DEEAD184");
}

getinteractiveinfilline(var_0, var_1) {
  switch (var_1) {
    case "_encstr_A3890850E25F90B79A83":
    case "_encstr_A6640D9D1109AF2FC7082B029395FF":
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      if(var_0 == "_encstr_A2FF07DB605823217A" || var_0 == "_encstr_95FF079B8D7B1DFA4C")
        return "_encstr_930D307D98F1F3D011C2836FA029840AE9872E64D4836EF37BE07B47B8C04F46A34645E3E8C9262E80933A670A5B087A5177";
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
      if(var_0 == "_encstr_A2FF07DB605823217A" || var_0 == "_encstr_95FF079B8D7B1DFA4C")
        return "_encstr_931C1CCD7E2603D0F99E46574D40DBA5419F46E35F97F212F5C0FA429389";

      if(var_0 == "_encstr_B1FF077B0D77B8B017" || var_0 == "_encstr_B2FF07CB61C0A3BF5D")
        return "_encstr_ABA81A0460191B08C96AB3DF20A9B8506DAFD3C45D413341D110BB06";
  }

  wait 1.25;
  self iprintlnbold("_encstr_A2B01F8A0BE43B958E3708A92CC9DA2B469008A82CAD56803A86B25B10DEEAD184");
}

interactiveinfilthink(var_0) {
  level thread manageinteractivecombattargets(var_0);
}

manageinteractivecombattargets(var_0) {
  while(!isDefined(level.infiltargets))
    waitframe();

  foreach(var_2 in level.infiltargets["_encstr_9A8507BA4040188D08"]) {
    var_2 thread targetdamagethink(var_0);
    var_2 thread deleteoninfilcomplete();
  }
}

targetdamagethink(var_0) {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(istrue(self.isbonus))
    self.health = 220;
  else
    self.health = 100;

  wait(level.interactiveinfilstart);
  var_1 = scripts\mp\utility\outline::outlineenableforteam(self, var_0, scripts\engine\utility::ter_op(istrue(self.isbonus), "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_96AE15674513800375C947242F6863285787EB2916E22F"), "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 >= self.health) {
      scripts\mp\utility\outline::outlinedisable(var_1, self);

      if(istrue(self.isbonus)) {
        var_3 thread scripts\mp\rank::giverankxp("_encstr_A2C60C4B9BCC2DD8FA89F69BBA37", 1000);
        var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_A2C60C4B9BCC2DD8FA89F69BBA37");
      }

      break;
    }
  }
}

deleteoninfilcomplete() {
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isbonus) && !isai(self))
    self setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_BECC055CF3811A");
  else if(isalive(self))
    self suicide();
}

cinematiccameratimeline(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

  switch (level.mapname) {
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
    case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
      wait 2.15;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(0.0, 1.0, 0.75);
      wait 0.75;
      thread scripts\mp\utility\infilexfil::set_cinematicmotionomnvarovertime(1.0, 0.0, 0.75);
      break;
  }
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