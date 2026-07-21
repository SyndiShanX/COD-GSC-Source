/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\rappel_hackney_infil.gsc
**************************************************/

rappel_hackney_init(var_0) {
  initanims(var_0);
  var_1 = [];
  var_1[0] = [0, 1];
  var_1[1] = [2];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_8D4B15A5B99996C6F593B0E01C5936EB342C8DDACDB2F2", var_0, 3, 2, var_1, ::rappel_hackney_spawn, ::rappel_hackney_get_length, ::player_rappel_hackney_infil_think);
}

rappel_hackney_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  var_5 thread infilthink(var_0, var_2);
  return var_5;
}

rappel_hackney_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0]);
  return var_1;
}

player_rappel_hackney_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(isPlayer(self))
    self setclienttriggeraudiozone("_encstr_BE6919133F93D8584379261848A8F3556181BDB86191AC85F9AA75", 1);

  applymapvisionset();
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_infil_end();
  thread heli_infil_radio_idle();
  var_2 = var_0.linktoent gettagorigin("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_3 = var_0.linktoent gettagangles("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  var_0.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0.subtype);
  thread player_rappel_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_9A1804890618", 0);
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self lerpfovscalefactor(0, 0);

  if(var_1 == 0)
    self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");

  if(isDefined(self.team) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_4 = [];
    var_4[var_4.size] = "_encstr_B2B718088BB854DD36488AE1279048117D0BE3334A626A629037";
    var_4[var_4.size] = "_encstr_8C4318B51C7D2DE6995A63AF6BA587F5DAD56EB4D8D84B3B1A3A";
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

  if(isDefined(self.animname) && isPlayer(self)) {
    var_8 = "_encstr_BEFE1C2FAB5D390B03D2802869333760B40E9BB36F0420C14739BB10A3AE";

    if(isDefined(var_0.subtype)) {
      if(var_0.subtype == "_encstr_BDBB0616C6C186C2") {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_BEFE1C2FAB5D390B03D2802869333760B40E9BB36F0420C14739BB10A3AE";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_BDFE1C86E6DA87185EB368786F60D137524D750B71124BE0313FA87033D2";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_82FE1C237920674450E55954FF080EEFDAB0DA0B468B47FDB0AF582CBDEA";
            break;
          default:
            var_8 = "_encstr_BEFE1C2FAB5D390B03D2802869333760B40E9BB36F0420C14739BB10A3AE";
            break;
        }
      } else {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_ACFE1C4B60A5A1D7A0540934E048BFF6F76052631901E71BB8D0183C0E9B";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_91FE1CD6B68AD7480EC318283F5001E7A29D455B01427B10E10FD820E325";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_8EFE1C73C770D1AF38D98AE2C603C7965BB51DF127E8E763531613EA0B44";
            break;
          default:
            var_8 = "_encstr_ACFE1C4B60A5A1D7A0540934E048BFF6F76052631901E71BB8D0183C0E9B";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("_encstr_99AB13C82FF1370D5B4071EA73A504E3AE034D74B3", 2);
    self playlocalsound(var_8);
  }

  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  thread player_normal_think(var_0);
}

player_normal_think(var_0) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 10);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0.subtype);

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  if(self isnightvisionon())
    self visionsetnakedforplayer("_encstr_B40101", 0.75);

  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_934C0218", 0);
  self.manualoverridewindmaterial = 0;
}

clear_infil_ambient_zone() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

heli_infil_radio_idle() {
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

player_interactive_think(var_0) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self.player_rig linkTo(var_0.linktoent, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 80, 80, 30, 70);
  var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0.subtype + "_encstr_81ED137D96B9A3959C588D47969DACBE2DCDE8E4BD");
  thread combat_start();
  wait 15.0;
  thread combat_end();

  if(!isai(self))
    scripts\mp\utility\infilexfil::givegunless();

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0.subtype + "_encstr_B23F12EBD2374795392C6C3A5A6756F5590F5AE8");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  if(self isnightvisionon())
    self visionsetnakedforplayer("_encstr_B40101", 0.75);

  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
}

player_infil_end() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

player_rappel_disconnect() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearallsoundsubmixes();
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
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_8B190AC730E03D42856D3FF2", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", var_3.body, var_3.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_A266062032BD7723", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8", "_encstr_A58B1E9A82C3E42F28B32C0FB38FBBC53843DF27C2E0DF9AF011F5CF13C8E6A0");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_9B7408BFEF17BA445893", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8", "_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F");

  foreach(var_5 in self.actors)
  var_5.infil = self;

  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.actors[0].anim_playsound_func = ::blima_commander_play_sound_func;
}

infilthink(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4", 0.2);

  foreach(var_4 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_4 delete();

  thread helithink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 1.0);

  if(level.prematchperiodend > self.infillength)
    wait(level.prematchperiodend - self.infillength);

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_2);
}

helithink(var_0, var_1, var_2) {
  spawnheli(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  self.linktoent setscriptablepartstate("_encstr_8C550F4EAE9B73A5B93BF51B5AEC86A3E6", "_encstr_AB0703DBB9", 0);
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9", 0);
  thread heli_normal_think(var_0, var_1, var_2);
  thread heli_interior_sfx(var_2);
}

heli_interior_sfx(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_2 linkTo(self.linktoent, "_encstr_BD8E14C36F2F1184C0C85BD3F1794F1AEF7F0C7B6FEB");
  wait 0.1;

  if(var_0 == "_encstr_BDBB0616C6C186C2") {
    self.linktoent playsoundonmovingent("_encstr_852D18FB438B579A20E143879E7F0E9DB38843B56973D12E382B");
    var_1 linkTo(self.linktoent, "_encstr_8C6510A6BE475AB28CAFB116981B597D8191");
    wait 0.1;
    var_1 playsoundonmovingent("_encstr_BD0228AB6618AF9415F02A725171CE071058052990208F1D2352319AB8AB45E7E8B4B7BA170BB325D368");
    var_2 playsoundonmovingent("_encstr_A7A828E636DCD7969BCCB4B1EB3458C6B67359BCBE1A958DD2C4D7D8EDC6DA1C2D3AD7E4B047E836CADC");
  } else {
    self.linktoent playsoundonmovingent("_encstr_B61318E686BAE7F820374330BF43D0DB9321D365DD22C56614AB");
    var_1 linkTo(self.linktoent, "_encstr_BA7B137A997A83682C9F40105F7B21C532BF78DF3A");
    wait 0.1;
    var_1 playsoundonmovingent("_encstr_8A762856360A57C88E4398A8BFD08167221DC5DB81C2FB90613A21D83FF9F88BDAC750E6E6DB91D855C7");
    var_2 playsoundonmovingent("_encstr_83142863403807A3584FD88AC7533993187D52E33E61098D6792890ED87118DBD8A3C1CBF1B5B87BED93");
  }

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_1 delete();
  var_2 delete();
}

heli_interactive_think(var_0, var_1, var_2) {
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2 + "_encstr_A3780DBF1388FBDD20817E83B838E5");
  wait(level.interactivecombatduration - 15.0);
  thread ropethink(var_2);
  wait 15.0;
  cleanup();
}

heli_normal_think(var_0, var_1, var_2) {
  thread ropethink(var_2);

  if(isDefined(self.path)) {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2);
    vehiclethinkpath(var_0, var_1, var_2);
  } else {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2);
    var_3 = getanimlength(level.scr_anim[self.linktoent.animname]["_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2]);
    wait(var_3);
  }

  cleanup();
}

ropethink(var_0) {
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_1 = getanimlength(level.scr_anim[self.linktoent.rope.animname]["_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0]);
  wait(var_1);
  self.linktoent.rope unlink();
  thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_0 + "_encstr_86B6062E5FA9A8F9");
}

_id_13293(var_0) {
  var_0 playsoundonmovingent("_encstr_AFAE1D371BCDEBD2DCCC4B36FAA185C6B5E6AC5EAF1AB2B1D2C4F539ED83B2");
}

_id_13294(var_0) {
  var_0 playsoundonmovingent("_encstr_96EA1D9B1BB9D7B49BCC96C6BE1A0BC6B69BACBCAF1ACAD8A564FA93BD1CAC");
}

actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  actor_normal_think(var_0, var_1, var_2);
}

actor_interactive_think(var_0, var_1, var_2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2 + "_encstr_A3780DBF1388FBDD20817E83B838E5", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2 + "_encstr_A3780DBF1388FBDD20817E83B838E5", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2 + "_encstr_A3780DBF1388FBDD20817E83B838E5"]);
}

actor_normal_think(var_0, var_1, var_2) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2]);
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
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);

  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack["_encstr_8B190AC730E03D42856D3FF2"])) {
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_8CB30A6D0FDF2BD7B2B270E8", ::blima_door_slam);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_A1940ACB83991FF717C06AE3", ::blima_cam_shake_low);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_BE550B37D0C2ADB2F589D5AD0E", ::blima_cam_shake_bump);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_9A720E32DBBD9C7DB78395E6F5E6CC1E", ::heli_door_open_sfx);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_B864210A19108F5AF00D1F0317AB82EB20A00710D6687DC25B674F174BC14A2E23A97A", ::heli_commander_sfx);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_AFAE1D371BCDEBD2DCCC4B36FAA185C6B5E6AC5EAF1AB2B1D2C4F539ED83B2", ::_id_13293);
    scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_96EA1D9B1BB9D7B49BCC96C6BE1A0BC6B69BACBCAF1ACAD8A564FA93BD1CAC", ::_id_13294);
  }

  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
      break;
    case "_encstr_871D0613938567B7":
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AAA80D901BE37B48292F97C9B3F851", ::outsideheli, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_9ADA0C27EAAD31D8B2F527ED83AC", ::blima_rumble_rope, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_8C4F0E395D6BC4D8ACAFEC4EB7EADC32", ::blima_rumble_ground, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
      break;
  }
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

script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B";
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = % _encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = "_encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA";
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = % _encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = "_encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA";
      level.scr_animtree["_encstr_8B190AC730E03D42856D3FF2"] = #animtree;
      level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_85AE156D3BC959CA14F3AB6FCDC96285D02666B4B0A01E;
      level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_85AE156D3BC959CA14F3AB6FCDC96285D02666B4B0A01E";
      level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = % _encstr_8D6019FD7169CC23AC886A4191760309F8216175EBC196C3C321C2;
      level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = "_encstr_8D6019FD7169CC23AC886A4191760309F8216175EBC196C3C321C2";
      level.scr_animtree["_encstr_A11F05257FC375"] = #animtree;
      level.scr_anim["_encstr_A11F05257FC375"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D;
      level.scr_animname["_encstr_A11F05257FC375"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D";
      level.scr_anim["_encstr_A11F05257FC375"]["_encstr_AD3620EBE1F7138FB85F80913F58958F9BDED2B2A9C33B49B8119090D3D1DFE74910"] = % _encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663;
      level.scr_animname["_encstr_A11F05257FC375"]["_encstr_AD3620EBE1F7138FB85F80913F58958F9BDED2B2A9C33B49B8119090D3D1DFE74910"] = "_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_879915A3BB89CBF0EED418763EDCF071C29F3FEBF727AF;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_879915A3BB89CBF0EED418763EDCF071C29F3FEBF727AF";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_AA7922436D968F33BFCA691FF91D227F0A312BDA3B2B4B217AA8A87AF7B130F1AA3BF7B6";
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B2EC1CB3985DA9DFB85C010CF840C7EEFF685A6B11099F03B0281E288E03", ::_id_12EEE);
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_969915E843DF50A5123451F0CE8A9398496730500FE883;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_969915E843DF50A5123451F0CE8A9398496730500FE883";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_967922A5E699D28DF59C580E07591BEB0D0B6CB6E695E5BE168D0E8685D7588D362FEB23";
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A6EC1CC74385E1A3AB6A2870014B6FC81CD6636BD76C48799FD1C0FBEA0A", ::_id_12EEF);
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_889915AD07AF5A73CC9663FA2663D2D6B0F5B3ABBC6099;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_889915AD07AF5A73CC9663FA2663D2D6B0F5B3ABBC6099";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = "_encstr_887922A537CCA563AF932C070795D87D43166C5B3795CBAF16D807A185D7C236B15EBE66";
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B6EC1C93C990D7F4C075A9A46F98BE7F4AC04ABBD67BF76DC01FD6A02F9A", ::_id_12EF0);
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B";
      level.scr_anim["_encstr_A266062032BD7723"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = % _encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B;
      level.scr_animname["_encstr_A266062032BD7723"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = "_encstr_953724E0B01036234B33B3F8F4E6D8387148359C361A822D29F7C347C01BA297D32F1155994B";
      level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA";
      level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = % _encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA;
      level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = "_encstr_86AC26B507AF332C39D291C243EBB4CD33A51B8DAF4CD22791AF2CEB6CBD1CB4367BA3EB4B8C1BCA";
      level.scr_animtree["_encstr_8B190AC730E03D42856D3FF2"] = #animtree;
      level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_A3E71755D0015AB0C92D5029F21970D827EE568E0E30D812FE;
      level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_A3E71755D0015AB0C92D5029F21970D827EE568E0E30D812FE";
      level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = % _encstr_AD241B6AEB608F654DB7E2C637DFA161C1BA1CBF1FA1817696D272C32D;
      level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = "_encstr_AD241B6AEB608F654DB7E2C637DFA161C1BA1CBF1FA1817696D272C32D";
      level.scr_animtree["_encstr_A11F05257FC375"] = #animtree;
      level.scr_anim["_encstr_A11F05257FC375"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_A55427AC8BBAA583DA5937D17DCC166EA3EB4EBD1CCAD7BB6BAF18627DB437334B8DF543CAC62DD727;
      level.scr_animname["_encstr_A11F05257FC375"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_A55427AC8BBAA583DA5937D17DCC166EA3EB4EBD1CCAD7BB6BAF18627DB437334B8DF543CAC62DD727";
      level.scr_anim["_encstr_A11F05257FC375"]["_encstr_99AB20D22F935BCF4971026A68BFC5C76A98417634D853197D309A1320FFBF8F60F9"] = % _encstr_A9AE2C56E2D5B483ADB27347D7CC85DC47AF277B0759EB77B5BE0362F5D237335A36AF1A951B4B7DC9D733B0C663;
      level.scr_animname["_encstr_A11F05257FC375"]["_encstr_99AB20D22F935BCF4971026A68BFC5C76A98417634D853197D309A1320FFBF8F60F9"] = "_encstr_A9AE2C56E2D5B483ADB27347D7CC85DC47AF277B0759EB77B5BE0362F5D237335A36AF1A951B4B7DC9D733B0C663";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_84CD1770C2BFA8D08A5721BF83D2AB4059911B8EAFFD50B7D7;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_84CD1770C2BFA8D08A5721BF83D2AB4059911B8EAFFD50B7D7";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_9B222233C8CA5385BED3439B298D6C17E4F78F3F1B7103F8BD9D93D67DD9C76ABA180701";
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B4EC1C6F67A869F1E041DC659E280162F2E5BFFFB7C3B2BCF04E156A31E2", ::_id_12EF1);
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_8ACD17E14AA183802EE758C9A34C38D3EA39E66067FB6B8342;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_8ACD17E14AA183802EE758C9A34C38D3EA39E66067FB6B8342";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_8622228BB5055063E6BB7A7F2B7092F021D6372B8819AAB18652F37B60210961B898093D";
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_95EC1C6EC9638F78BDB5CB29A8D027012F6850E7E134A29118B726CA5053", ::_id_12EF2);
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_85CD178FB8D629A285FB4D8956A9EAE5B9597BBFE84B810F47;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_85CD178FB8D629A285FB4D8956A9EAE5B9597BBFE84B810F47";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = "_encstr_8B2222C0E5D210D841DB93F883708907185EB0E84D05517962AA31346AB7FE3ABC18A70F";
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A2EC1C283FDE467B420723B951FAB30933F310E0676059395A61A8BFB637", ::_id_12EF3);
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

vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_84AB069378304D32"] = #animtree;

      switch (getDvar("_encstr_9570084B1793A090CDFF")) {
        case "_encstr_AB5D0960CBB77E40E7D955":
        case "_encstr_8E940C29F87032C3FF82F50F725A":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_B230229D1109AC43CC28CAE15111976540E7681D51D07977EF83034A197617DEC0218861;
          break;
        case "_encstr_99020BB0027F38974BA78783FF":
        case "_encstr_BDFF088922C9FF1946BF":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_847521DA07F5D2DC335A367D131BA5B62CAF8659634BBEB5076C0B3BACEB0BC61C0DB0;
          break;
        case "_encstr_82670A6D9FF7A9AAD022B0CA":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_A95322B6E0AF5A9BCC4B8DD74CC64B5BC2EBA1B21BD27DD60E6C4E589B86EB0B36070D16;
          break;
        case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_A3A32C5B0E7D4B3733A58D7D986396D6C2D7A1B28DB4FADAE0C2DC5ACB58A1AF3A588DD15AB10B367D16C60ED0C2;
          break;
        case "_encstr_87B60AA0124F68A3DAEBFBFF":
        case "_encstr_82740C4F78166D12D1B3CA0495DD":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_B295241A50010B5A320BD356F55AAA5F9FD7B0B7ACAB47E79BFFED80302DE12F79AA416B2881;
          break;
        case "_encstr_96040A5B1CAF0D163926ED9C":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_BDA02387DF790385A2D920F6EBA8F0383F914BED48DC3F984A086ACE6648CD86A2087380FE;
          break;
        case "_encstr_8B1D09FFC8A63802BDEF7B":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_99FD236D3BC959CA14F3AB6FCDC96285D026A4F710C027B27787839F1567FBFF88E85A3C29;
          break;
        default:
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340"] = % _encstr_ADFB14B5D74F62963148BB6F08A859EA8BF87C2FB14B;
          break;
      }

      level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8C3B27FEA90BC31BCD29A0E0C224D5B9C76F8B7806D70827F60258B01AF19390ABFD8E679BCB108DDF"] = % _encstr_A5A4185D11C18B98E16140F1F2F261B81A1D7380534E407D64AA;
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_84AB069378304D32"] = #animtree;

      switch (getDvar("_encstr_9570084B1793A090CDFF")) {
        case "_encstr_AB5D0960CBB77E40E7D955":
        case "_encstr_8E940C29F87032C3FF82F50F725A":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_84C322512801619290DCE820FE58C7E7516652DBE96919A58373D818C72D6FFDB557BBF7;
          break;
        case "_encstr_99020BB0027F38974BA78783FF":
        case "_encstr_BDFF088922C9FF1946BF":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_A5DB21D61CD7969B33B4B1FA891B2DADB0FA3495D8967DD6E01B2CB3B2BEC49C2C67F6;
          break;
        case "_encstr_82670A6D9FF7A9AAD022B0CA":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_93DA22D607F5B437CC2D1B7DC4D8B4B516EB432B1B4BFAAD0E8DC90B370DF54CC985ECB7;
          break;
        case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_ACAB2CF33B31376EB93BB0BFF66419737AE0DB41AACB71B3E84F46086B4F81EF837FA651407923CCD7519E8B289A;
          break;
        case "_encstr_87B60AA0124F68A3DAEBFBFF":
        case "_encstr_82740C4F78166D12D1B3CA0495DD":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_AB5E2460CBB773B027D16917C28DC0C9F79158E9F287A090FA8F6773E4F2188467DA9391FBC7;
          break;
        case "_encstr_96040A5B1CAF0D163926ED9C":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_AC0F2347087F21F82D27384E60B939D1FE5EA4C3E074A1D1C8118366F2108B09102067A350;
          break;
        case "_encstr_8B1D09FFC8A63802BDEF7B":
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_925B23E2B08F7493E9AB744F367057BD1B313AFAF85BA1D74398486DD6F96B4945F0524378;
          break;
        default:
          level.scr_anim["_encstr_84AB069378304D32"]["_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30"] = % _encstr_AD86165D0340108897F7CB7E952A41E3B82F5331089711F4;
          break;
      }

      level.scr_anim["_encstr_84AB069378304D32"]["_encstr_B2B927F09A2F121F3C8ECA6E1F80CD9F6981423D1A72FA81301B96AD9A3F78B20B05DAF1B19BC0FBF2"] = % _encstr_92D11ADD1B61D828342BE1C7D841EB075AE9F887D6F66D5F48DF5A2F;
      break;
  }
}

spawnheli(var_0, var_1, var_2) {
  var_3 = "_encstr_84D51A0A48FB7DA7F625757B4DBB3B0919C82351D85DF7FFC8807570";

  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0")
    var_3 = "_encstr_95E2174CD84B5BC2D7D0B01BB6E6955EBE96E6994B36AFB583";

  var_4 = spawnVehicle("_encstr_84B91AEC2BD070AFB55AB1BEC2B44EFA31B1A5D6C2AFA573CCA51BB9", var_2, var_3, var_0.origin, var_0.angles);
  var_4 setvehicleteam(var_1);
  var_4 setCanDamage(0);
  var_4.animname = "_encstr_84AB069378304D32";
  self.linktoent = var_4;
  var_4.infil = self;
  self.linktoent.rope = self.linktoent spawn_anim_model("_encstr_A11F05257FC375", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  self.linktoent.rope scripts\common\anim::anim_first_frame_solo(self.linktoent.rope, "_encstr_87A216D310135072F1802C66F687BA0D5A79371B80E8B419" + var_2);
  return var_4;
}

helifollowpath(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.speed = 500;
  self.accel = 175;
  self.combatmode = "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78";
  self notify(self.combatmode);

  while(isDefined(var_1.target)) {
    thread scripts\mp\killstreaks\jackal::guardpositionescort(var_2.origin, undefined, 800);

    for(;;) {
      var_3 = distance(self.origin, var_2.origin);

      if(var_3 < 2000) {
        break;
      }

      waitframe();
    }

    self notify("_encstr_BA2D081B2B58B32D37EC");

    if(!isDefined(var_2.target)) {
      break;
    }

    var_1 = var_2;
    var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }
}

cleanup() {
  foreach(var_1 in self.actors)
  var_1 delete();

  self.linktoent.rope delete();
  self.linktoent delete();
  level.stop_station_closed_vo--;
  self delete();
}

spawn_infil_axis_ai(var_0, var_1, var_2, var_3) {
  level.gameskill = 0;
  var_4 = scripts\mp\mp_agent::spawnnewagent("_encstr_A7E80E1818902B623DBA872BD4C1184C", "_encstr_8E8405EA382B2A", var_1, var_2, scripts\engine\utility::ter_op(isDefined(var_3), var_3, "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1"));

  if(!isDefined(var_4))
    return undefined;

  var_4.desiredmovetype = "_encstr_AA7C07466F9DA30713";
  var_4 clearpath();
  var_4.goalradius = 999;
  var_4.fixednode = 0;
  var_4 scripts\mp\agents\agent_common::set_agent_health(50);
  return var_4;
}

spawninteractiveinfilai() {
  level thread alphaai();
  level thread bravoai();
}

alphaai() {
  level endon("_encstr_959D1BD7AD553A1A68314B148B106FB220C55F5B677642CD08F8075B81");
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level endon("_encstr_A3860BD065664831F983C7FDBF");
  level.alphaagents = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_96AA0F16B4AF0BB1388685FACD8EB0E4A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_A25911963738974B0B5A672FBB1213B3CF5870", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    var_4 = spawn_infil_axis_ai("_encstr_BDBB0616C6C186C2", var_3.origin, var_3.angles);

    if(isDefined(var_4))
      level thread alpha_ai_array_handler(var_4);

    if(level.alphaagents.size == 5) {
      break;
    }
  }

  for(;;) {
    if(level.alphaagents.size < 5) {
      var_6 = randomint(var_1.size);

      if(randomint(100) > 75)
        var_7 = "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8";
      else
        var_7 = undefined;

      var_4 = spawn_infil_axis_ai("_encstr_BDBB0616C6C186C2", var_1[var_6].origin, var_1[var_6].angles, var_7);

      if(isDefined(var_4))
        level thread alpha_ai_array_handler(var_4, var_7);
    }

    waitframe();
  }
}

alpha_ai_array_handler(var_0, var_1) {
  level.alphaagents = scripts\engine\utility::array_add(level.alphaagents, var_0);
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, "_encstr_9A8507BA4040188D08", scripts\engine\utility::ter_op(isDefined(var_1), "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_96AE15674513800375C947242F6863285787EB2916E22F"), "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
  level.alphaagents = scripts\engine\utility::array_remove(level.alphaagents, var_0);
}

bravoai() {
  level endon("_encstr_959D1BD7AD553A1A68314B148B106FB220C55F5B677642CD08F8075B81");
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level endon("_encstr_A3860BD065664831F983C7FDBF");
  level.bravoagents = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_B8A00F5896D7989C0BCEDBFAB9A385C98E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_A65C116A30C7EEBB415C0F0776E9F732E3A8E2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    var_4 = spawn_infil_axis_ai("_encstr_871D0613938567B7", var_3.origin, var_3.angles);

    if(isDefined(var_4))
      level thread bravo_ai_array_handler(var_4);

    if(level.bravoagents.size == 5) {
      break;
    }
  }

  for(;;) {
    if(level.bravoagents.size < 5) {
      var_6 = randomint(var_1.size);

      if(randomint(100) > 75)
        var_7 = "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8";
      else
        var_7 = undefined;

      var_4 = spawn_infil_axis_ai("_encstr_871D0613938567B7", var_1[var_6].origin, var_1[var_6].angles, var_7);

      if(isDefined(var_4))
        level thread bravo_ai_array_handler(var_4, var_7);
    }

    waitframe();
  }
}

bravo_ai_array_handler(var_0, var_1) {
  level.bravoagents = scripts\engine\utility::array_add(level.bravoagents, var_0);
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, "_encstr_9A8507BA4040188D08", scripts\engine\utility::ter_op(isDefined(var_1), "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_96AE15674513800375C947242F6863285787EB2916E22F"), "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
  level.bravoagents = scripts\engine\utility::array_remove(level.bravoagents, var_0);
}

cleanupinteractiveinfilai() {
  var_0 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8E752DE0626A99D133D7BB27C307780B9029A0886A44E9AEDF1CBFABD9AFC0D53B12F08892DB3BC3A707CB90A433C8"]);
  var_0 = var_0 + 15.0;
  wait(var_0);

  foreach(var_2 in level.alphaagents) {
    if(isalive(var_2))
      var_2 kill();
  }

  foreach(var_2 in level.bravoagents) {
    if(isalive(var_2))
      var_2 kill();
  }
}

agent_handledamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1) && var_1.team != "_encstr_8E8405EA382B2A") {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101", var_2 >= self.health);

    if(var_2 >= self.health) {
      if(!isDefined(var_1.infilscore))
        var_1.infilscore = 1;
      else
        var_1.infilscore++;

      if(var_1.infilscore > level.highestinfilscore)
        level updatehighinfilscore(var_1);
    }
  }
}

blima_door_slam(var_0) {
  foreach(var_2 in var_0.infil.players) {
    var_2 earthquakeforplayer(randomfloatrange(0.135, 0.15), 2, self.origin, 8000);
    var_2 playrumbleonpositionforclient("_encstr_AA9A12B327DBAB73237D07F6EACD23BE6358E646", var_2.origin);
  }
}

blima_cam_shake_low(var_0) {
  foreach(var_2 in var_0.infil.players)
  var_2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, var_2.origin, 8000, "_encstr_A27F0B27D879C7BB4B1136AD0D", 0.05, 0.1);
}

blima_cam_shake_bump(var_0) {
  foreach(var_2 in var_0.infil.players)
  var_2 scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, var_2.origin, 8000, "_encstr_BD9D0CF353BB8D8702EF7030ABE0", 0.05, 0.15);
}

heli_door_open_sfx(var_0) {
  if(var_0.infil.subtype == "_encstr_BDBB0616C6C186C2") {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.infil.linktoent.origin);
    var_1 linkTo(var_0.infil.linktoent, "_encstr_849E106850A9BF81C398281878184EBA981B");
    var_1 playSound("_encstr_81552292F30D970B555AACC047F887192825214AD033E5FD84E7F77758753317F7CB19B8");
    wait 3;
    var_1 delete();
  } else {
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.infil.linktoent.origin);
    var_1 linkTo(var_0.infil.linktoent, "_encstr_A55F106862EF33169367B82E7FE3DE95D51B");
    var_1 playSound("_encstr_A67022DEBE82DF7036CB4B20475809DFBA655D63193A6318E9A2A9189F67A36F428AC560");
    wait 3;
    var_1 delete();
  }
}

heli_commander_sfx(var_0) {
  if(var_0.infil.subtype == "_encstr_BDBB0616C6C186C2")
    var_0 playsoundonmovingent("_encstr_BAD822C84F1A67211BC1C2C540E36FF3E802905877D2BA2B30BBA9CAB0C8874082E85043");
  else
    var_0 playsoundonmovingent("_encstr_A9012287EF82C8201EEF500859F0A81E0A73131B878AAD5021D29EE17DADB047F2A39B95");
}

_id_12EEE(var_0) {
  var_0 playsoundonmovingent("_encstr_B2EC1CB3985DA9DFB85C010CF840C7EEFF685A6B11099F03B0281E288E03");
}

_id_12EEF(var_0) {
  var_0 playsoundonmovingent("_encstr_A6EC1CC74385E1A3AB6A2870014B6FC81CD6636BD76C48799FD1C0FBEA0A");
}

_id_12EF0(var_0) {
  var_0 playsoundonmovingent("_encstr_B6EC1C93C990D7F4C075A9A46F98BE7F4AC04ABBD67BF76DC01FD6A02F9A");
}

_id_12EF1(var_0) {
  var_0 playsoundonmovingent("_encstr_B4EC1C6F67A869F1E041DC659E280162F2E5BFFFB7C3B2BCF04E156A31E2");
}

_id_12EF2(var_0) {
  var_0 playsoundonmovingent("_encstr_95EC1C6EC9638F78BDB5CB29A8D027012F6850E7E134A29118B726CA5053");
}

_id_12EF3(var_0) {
  var_0 playsoundonmovingent("_encstr_A2EC1C283FDE467B420723B951FAB30933F310E0676059395A61A8BFB637");
}

blima_rumble_rope(var_0) {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  level endon("_encstr_A3860BD065664831F983C7FDBF");
  var_1 = var_0.player;
  var_1 notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  var_1 endon("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_1 playrumbleonpositionforclient("_encstr_BD9D0CF353BB8D8702EF7030ABE0", var_1.origin);
    wait(randomfloatrange(0.05, 0.15));
  }
}

blima_rumble_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  var_1 playRumbleOnEntity("_encstr_AA9A12B327DBAB73237D07F6EACD23BE6358E646");
  var_1 lerpfovscalefactor(1, 0.5);
}

combat_start() {
  self notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  self endon("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");

  for(;;) {
    self playrumbleonpositionforclient("_encstr_A27F0B27D879C7BB4B1136AD0D", self.origin);
    wait(randomfloatrange(0.15, 0.5));
  }
}

combat_end() {
  self notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  self.interactivecombat = 0;
  scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, self.origin, 8000, "_encstr_A27F0B27D879C7BB4B1136AD0D", 0.05, 0.1);
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
}

blima_commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  var_4 playsoundtoplayer(var_0, var_4);
}

vehiclethinkpath(var_0, var_1, var_2) {
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  self.linktoent.unload_hover_offset = 300;
  self.linktoent.unload_time = 10;
  self.linktoent thread scripts\mp\infilexfil\infilexfil::vehicle_paths_helicopter(self.path);
  thread scripts\mp\infilexfil\infilexfil::heli_path(self.linktoent);
  self.linktoent waittill("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");
  self.linktoent delete();
  self.linktoent = undefined;
}

giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("_encstr_8B1217E1674A59232176123A38080E5A6A236E76F35091EF57", ["_encstr_A6FE0C0F717B90960BBD23C54B91"]);
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

updatehighinfilscore(var_0) {
  level.highestinfilname = var_0.name;
  level.highestinfilscore = var_0.infilscore;

  foreach(var_2 in level.players) {
    if(var_2.team == "_encstr_9A8507BA4040188D08")
      var_2 iprintlnbold(level.highestinfilname + "_encstr_A7F61701B4E6802DCD041D865908B156B04601EE5A3A434002" + level.highestinfilscore + "_encstr_BE7F070AD0A0FC527F");
  }
}

announceinfilwinner() {
  level waittill("_encstr_959D1BD7AD553A1A68314B148B106FB220C55F5B677642CD08F8075B81");

  if(!isDefined(level.highestinfilname)) {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1.team == "_encstr_9A8507BA4040188D08")
      var_1 iprintlnbold(level.highestinfilname + "_encstr_A59D0C02BBBDE608EE4B3A1A0108" + level.highestinfilscore + "_encstr_BE7F070AD0A0FC527F");
  }
}

dummychopper() {
  var_0 = (1325, -1200, 30);
  var_1 = (0, 90, 0);
  var_2 = spawnVehicle("_encstr_AFD51326359090DF221B5B7F4280C05F46F8A86BC7", "_encstr_BDBB0616C6C186C2", "_encstr_95E2174CD84B5BC2D7D0B01BB6E6955EBE96E6994B36AFB583", var_0, var_1);
  var_2 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_2 setCanDamage(0);
  var_2.animname = "_encstr_84AB069378304D32";
  var_2 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  var_3 setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_849F0AB030B98F45F79CC828");
  var_3 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -60), (-90, 0, 0));
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "_encstr_82E31B231782A045EBD1F1B7D61CF85B20F01896B7483921A8A8C33340");
  var_4 = (525, -1460, 30);
  var_5 = (0, 180, 0);
  var_6 = spawnVehicle("_encstr_AFD51326359090DF221B5B7F4280C05F46F8A86BC7", "_encstr_871D0613938567B7", "_encstr_95E2174CD84B5BC2D7D0B01BB6E6955EBE96E6994B36AFB583", var_4, var_5);
  var_6 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_6 setCanDamage(0);
  var_6.animname = "_encstr_84AB069378304D32";
  var_6 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
  var_3.angles = var_6.angles;
  var_3 setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  var_3 setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_849F0AB030B98F45F79CC828");
  var_3 linkTo(var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, -60), (-90, 0, 0));
  var_6 thread scripts\common\anim::anim_single_solo(var_6, "_encstr_8D871B6B570AA3A82408D868524F13C969BFB1B8AB80E22F28FA900D30");
}

applymapvisionset() {
  switch (level.mapname) {
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      self visionsetnakedforplayer("_encstr_842F0F5250B08001802B3A05A93847C32A", 0);
      break;
    default:
      return;
  }
}

removemapvisionset() {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  wait 1.5;
  self visionsetnakedforplayer("_encstr_B40101", 1.0);
}

getcommanderassets(var_0) {
  var_1 = spawnStruct();

  if(var_0 == "_encstr_8E8405EA382B2A") {
    var_1.body = "_encstr_915B1E13E20FEBF6EB5D968E29CF98DF742AE8D09A65316B6F62880731C36041";
    var_1.head = "_encstr_AC1F25C89FA9E860F30F070F57EA30E94877B060861F83ADFA0B6711AFE288F8274DBBF9AA6D10";
  } else {
    var_1.body = "_encstr_8CB81826ED465EEB6BC1D71A2B63D21BB7388E59C9BE8D4E2BEE";
    var_1.head = "_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F";
  }

  return var_1;
}

outsideheli(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;

  var_1 thread clear_infil_ambient_zone();
  var_1 thread removemapvisionset();
}