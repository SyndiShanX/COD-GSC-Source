/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\slinger.gsc
***********************************************/

_encstr_ADB30DDBB0A4C8978543B180029714() {
  _encstr_BE6F126E364BDC762B27BED27396A358CDB4B537();
  _encstr_8E4C1326CC076867F79341882A8C09E37F7AA7914B();
  scripts\mp\utility\sound::besttime("_encstr_99210ECA5CD55A1CD7CD6DE5D0BDB7D6");
  level._encstr_A53D09F348737317F83D93 = [];
  scripts\engine\scriptable::_id_12F5B("_encstr_AA2112697E444898C283FFA39F0AC868E1569001", ::_encstr_B6A4169BD8969BCE95E4E6D8395A838E163163ACABB9B28C);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_encstr_BE6F126E364BDC762B27BED27396A358CDB4B537() {
  level.scr_animtree["_encstr_A30E0808C94BCD20E942"] = #animtree;
  level.scr_anim["_encstr_A30E0808C94BCD20E942"]["_encstr_BDC50D6E365ADC762B27AFED832BCD"] = % _encstr_85A922E05081DB555BCB6F5562AFB7CD655A9F9B932F63FF6D8F7DA1904570C617499578;
  level.scr_animname["_encstr_A30E0808C94BCD20E942"]["_encstr_BDC50D6E365ADC762B27AFED832BCD"] = "_encstr_85A922E05081DB555BCB6F5562AFB7CD655A9F9B932F63FF6D8F7DA1904570C617499578";
  level.scr_anim["_encstr_A30E0808C94BCD20E942"]["_encstr_B29312FBB06205CA02861F50D1CADA979BA190B7"] = % _encstr_A279221B7177CBBF9B78676390515733EB1D675269AF13C7E1C86B4370C82EA9ABA5AD8F;
  level.scr_animname["_encstr_A30E0808C94BCD20E942"]["_encstr_B29312FBB06205CA02861F50D1CADA979BA190B7"] = "_encstr_A279221B7177CBBF9B78676390515733EB1D675269AF13C7E1C86B4370C82EA9ABA5AD8F";
}

_encstr_8E4C1326CC076867F79341882A8C09E37F7AA7914B() {
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC = spawnStruct();
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_99C10DA646C7526683508F87103834 = getdvarint("_encstr_A2BF1AB9C639AF6E1B5A9BECB2277D2CB9D8AC3747EB432BB4D9D0E8", 2500);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC0C0B770B8F2DF80953100858 = getdvarint("_encstr_B69818CDC627F53763D237762BC97D16E63656B9E87D472D5B59", 2.0);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_9616147A91057B1E881DB79207F8629BAE492282795E = getdvarfloat("_encstr_8A15221BD62B1F828118AA3210D5F1AB21459E83FB56334D65D0421B23B7325F99A1192A", 1250);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_911E0E85980DF00F5B70BB13EAF92EF8 = getdvarfloat("_encstr_BDA11CFF56AB18BF02D930F1F75841303F3353EB68511A098A696AC1E7A0", 1500);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.launchtime = getdvarfloat("_encstr_8D0518DCD8C9FACD1BB4B9D9CA27FAD85857B93643BEA35A6B59", 1);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_839A0EE61B4BDC7659E48656C2C6E8A1 = getdvarint("_encstr_B1CD13CDD839FACDB1967376CA27EB43B2588DE843", 1250);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_ABD8156A3207F39DD0832E058F18233BAD88B302F85533 = getdvarint("_encstr_8BF722EB49383F68F480733FC2FED16B984FB1A897FA23A312AFF79DEA4373EA5492A840", 4.0);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC1C1353F19320BE4B2AFBC033EB75082A44CBC38A = getdvarint("_encstr_87BB21F347105147B9B87AD2018EBF96D0578C7DFDB86783C8D0C36A4B6B3B0D789B02", 6.0);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_8D410C05246ADD9859FB0838D37B = getdvarint("_encstr_8F4319033E8DE6B7D1D1D00F77DE2FAB597A732389853F06D0E74B", 100);
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.cantakedamage = loadfx("_encstr_91F4437E340ABEA4173219C2488F9C77202FFEE4F8F18F6BF38806FAC84D12F7B985479A673823B597500EB3987181A3D1F6D2118CA1A73EB358C23AE885C92FC95E468E9B");
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_95100C93797B7930778F50FDA9F3 = loadfx("_encstr_8C664B0BA22328F06B881765EA45C8CEDB4A80B1DE8FBF5884B8EF5DE1FAD89F8FA23EF982C37950DD8EE77D0E20E9D63FAB13018A5F3870769419573F8D212D83236848538768E8816017654C");
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._id_127E6 = loadfx("_encstr_AB564904A7BB671847CAD908DB27D017228EF0856DC263C3318352137F928B6BFA37E01E562A1148EFE34AB87BC066A5229AEE17AF12AF91C9C3587877FEBEF14AC5EDA883DBE71BBF43E0");
  level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AAE80C80F27A41E30FC10DF5B63B = loadfx("_encstr_8E8232DDABB3A0703748A619C24738C64A1F757176AA5F687D32C87128BF18F4637FE5A5AE7192C09D4D912B59DC88BCDEB35539");
}

_encstr_A6EE12C74C4468A4872BEED1325B686811CD4F53() {
  return 1;
}

_encstr_A5900DC320094A0F5073D153EF3D63(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(getdvarint("_encstr_85DC1BB3E9BEF752F04BCECF7B2811076641094B3099D781484BFAC507", 1) > 0 && isDefined(var_1.super))
    var_1.super._encstr_AB59118625AAE5D955E38058DB671319728D75 = gettime();

  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2);
  var_3 = undefined;

  if(isDefined(var_2) || !scripts\mp\outofbounds::unset_relic_rocket_kill_ammo(var_0.origin))
    var_3 = "_encstr_97032B3FA9A8205201DC7D37F5B98D49850BEFDFC5C60F0D5A67E58C0C91D551F8BF1FC34510D12FC9ACAE0605";
  else if(level._encstr_A53D09F348737317F83D93.size >= 8 || isDefined(var_1._encstr_A53D09F348737317F83D93) && var_1._encstr_A53D09F348737317F83D93.size >= 3)
    var_3 = "_encstr_AFB6274D17E15A31A09B3BE77341888F611F7143CEEA541FA0873BD7451CF0DA91C7FDDD06A1E960F3";
  else if(!var_1 _encstr_AFC11B0F190B5ADF98E37184B910E4225F81F7DFEF21529148E9354ED1(var_0))
    var_3 = "_encstr_A35026893AD9AD6F7F3F613107B5455F9193180C96B719FB677F7949D3971D3D89CE19B82E68331D";

  if(isDefined(var_3)) {
    var_1 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    var_1 scripts\mp\hud_message::showerrormessage(var_3);

    if(isDefined(var_1.super))
      var_1 _encstr_99051473054950947AFB87A5DF32E5181C5A3BABEFBA();

    var_0 delete();
    return;
  }

  var_1 _encstr_BA8C0F37D8B4CDCE5993AF3259831BDE2F(var_0);
}

_encstr_99051473054950947AFB87A5DF32E5181C5A3BABEFBA() {
  var_0 = self;
  var_1 = 1;
  var_0 setweaponammoclip(var_0.super.staticdata.weapon, var_1);

  if(istrue(var_0.issuperdisabled))
    var_0.loadoutextraperksfromgamemode = var_1;

  var_0 notify("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");
  var_0 notify("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12097(var_0.super, 1);
  var_2 = var_0 scripts\mp\supers::getcurrentsuper();
  var_0 scripts\mp\supers::_id_131C7(0);
  var_0 scripts\mp\supers::_id_131C6(0);
  var_2.wasrefunded = 1;
  var_0 scripts\mp\supers::setsuperbasepoints(var_0 scripts\mp\supers::getsuperpointsneeded());
}

_encstr_AFC11B0F190B5ADF98E37184B910E4225F81F7DFEF21529148E9354ED1(var_0) {
  var_1 = 32;
  var_2 = var_0.origin + (0, 0, var_1 + 1);
  var_3 = var_0.origin + (0, 0, 4500);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::sphere_trace(var_2, var_3, var_1, var_0, var_4);
  return var_5["_encstr_A53009A25003666B9818C6"] == 1.0;
}

_encstr_BA8C0F37D8B4CDCE5993AF3259831BDE2F(var_0) {
  var_1 = self;

  if(isDefined(var_1.super)) {
    if(getdvarint("_encstr_85DC1BB3E9BEF752F04BCECF7B2811076641094B3099D781484BFAC507", 1) > 0 && !isDefined(var_1.super.usestarttime)) {
      var_2 = "_encstr_8DC7086BEEA408C0AF8A";

      if(isDefined(var_1.super.staticdata))
        var_2 = scripts\engine\utility::ter_op(isDefined(var_1.super.staticdata.ref), var_1.super.staticdata.ref, "_encstr_8C500ABA9B23CACC2D37AC8C");

      var_3 = scripts\engine\utility::ter_op(isDefined(var_1.super._encstr_AB59118625AAE5D955E38058DB671319728D75), var_1.super._encstr_AB59118625AAE5D955E38058DB671319728D75, "_encstr_8C500ABA9B23CACC2D37AC8C");
      var_4 = scripts\engine\utility::ter_op(isDefined(var_1.super.madeavailabletime), var_1.super.madeavailabletime, "_encstr_8C500ABA9B23CACC2D37AC8C");
      var_5 = scripts\engine\utility::ter_op(isDefined(var_1.super.usepercent), var_1.super.usepercent, "_encstr_8C500ABA9B23CACC2D37AC8C");
      var_6 = "_encstr_B2883799EFC2D3DB931DEDA195CBB9FFB018EAE2C946D28191B73FC0C63DB091553584459F1978DB4EA0812C493AF38590EF733ABEA3E2AAA1" + var_2 + "_encstr_AF140DC9263BF9638F4F15F33DCF0E" + var_3 + "_encstr_88011559096069424D7B2B6F33E1DAA2D00983DCD8480B" + var_4 + "_encstr_88760E1509E092C77FF1435AD9485B40" + var_5 + "_encstr_8C4C0209";
      scripts\mp\utility\script::laststand_dogtags(var_6);
    }

    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }

  var_7 = var_0.origin;
  var_8 = var_0.angles * (0, 1, 0);
  var_0 delete();
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_9 getuseholdkbmprofile(1);
  var_9 setModel("_encstr_823325DA4B634B47C2C9CB7DE6DA5E43BDB7B6EBC895838985C6D8BDB7CDAF13C2D8B60E856CDA");
  var_9.angles = var_8;
  var_9.animname = "_encstr_A30E0808C94BCD20E942";
  var_9 scripts\common\anim::setanimtree();
  var_9.owner = var_1;
  var_9.team = var_1.team;
  var_9._encstr_86271121EA1FDD7B7A40389950E8EA43658A92 = [];
  var_9._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD = [];
  var_9._encstr_971A136F3EF2B2D018EFC36803735C8B7F91CBF962 = [];
  var_9._encstr_A3B21406E6A73206E158B35FF0DBCCEA6370CFBFC1EF = [];
  var_9._encstr_916E0FE16F109537A071F28B18085B8F80 = 1;
  var_9 thread _encstr_83E215E4EACD7D46ACE08DF6BCCA46BEB9C62D733BACC9(var_1);
}

_encstr_83E215E4EACD7D46ACE08DF6BCCA46BEB9C62D733BACC9(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0._encstr_A53D09F348737317F83D93))
    var_0._encstr_A53D09F348737317F83D93 = [];

  var_0._encstr_A53D09F348737317F83D93[var_0._encstr_A53D09F348737317F83D93.size] = var_1;
  playsoundatpos(var_1.origin, "_encstr_8863102AE0915BFFF0985249ACFE9B622F60");
  playsoundatpos(var_1.origin, "_encstr_95FF0F9B6DCB1A7BDBD6F54659C136BDBC");
  playsoundatpos(var_1.origin + (0, 0, 400), "_encstr_B4131A0822C849701FC3AF8EAF0B795FF7AA8878DA60EF0BABF19E85");
  var_1 thread _encstr_936F1AE6B1B4E6B3CA27D76CED1BB1D2B94BF69BEBDD85A3C61A5627();
  var_1 thread _encstr_8F7C174EED622D018D2B21F04FAD9967CA59C4DF437AE98962();
  var_1 thread _encstr_84B41EC893DEE0AFC11B85F2CA396EFAB7B97D26E4B2855BEBDD583A6C34CA9C();
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles * (0, 1, 0));
  var_1.scenenode = var_2;
  var_1 thread _encstr_BDB715B0EA74EDD9AF32E8F52BF786BB5ED3E8B3D2CB23();
  var_2 scripts\common\anim::anim_single_solo(var_1, "_encstr_BDC50D6E365ADC762B27AFED832BCD");
  var_1 thread _encstr_8DB31627BAE6EB6EB12DCDB32B39D75A8CD8957D2C9B4BD6(var_2);
  playsoundatpos(var_1.origin + (0, 0, 4500), "_encstr_B6DB18DCDA9786BDEDDAF51358D8B17BEDE6BEA5CDCC36C28E59");
  var_1.laststandplayers = 1;
  var_3 = getdvarfloat("_encstr_ACC31CC3198507A311230D5FE16A965B4F9889ED237FE49F3BF30B44AA68", 30);
  var_4 = var_1 scripts\engine\utility::_id_143B9(var_3, "_encstr_99EC1213A3D24DE4D146C77210170840E09B53A3");

  if(var_4 == "_encstr_995408F398012F656821") {
    playFX(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._id_127E6, var_1.origin + (0, 0, 4500));
    playsoundatpos(var_1.origin + (0, 0, 4500), "_encstr_97080C6EB5CB0D7BEDDAF5E0DEE0");
  } else {
    playFX(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_95100C93797B7930778F50FDA9F3, var_1.origin + (0, 0, 4500));
    playsoundatpos(var_1.origin + (0, 0, 4500), "_encstr_ACBB10F3CA52DBADAF30910A90A9258FA9A5");
  }

  playFX(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AAE80C80F27A41E30FC10DF5B63B, var_1.origin);
  playsoundatpos(var_1.origin, "_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");

  if(isDefined(var_0) && isDefined(var_0._encstr_A53D09F348737317F83D93))
    var_0._encstr_A53D09F348737317F83D93 = scripts\engine\utility::array_remove(var_0._encstr_A53D09F348737317F83D93, var_1);

  var_2 delete();
  var_1 delete();
}

_encstr_BDB715B0EA74EDD9AF32E8F52BF786BB5ED3E8B3D2CB23() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;
  var_0 setscriptablepartstate("_encstr_AA2112697E444898C283FFA39F0AC868E1569001", "_encstr_8E8607AB603B6E4341");
  var_0 setscriptablepartstate("_encstr_871212B6E93B8D4F4D7A59D0922403B93399C4BD", "_encstr_930B07BB1B6B3854FF");
}

_encstr_936F1AE6B1B4E6B3CA27D76CED1BB1D2B94BF69BEBDD85A3C61A5627() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 0.5;
  var_2 = 2500;
  var_3 = 0.15;
  var_4 = 99999;
  wait(var_1);
  var_0 physics_registerforcollisioncallback();
  var_0 _meth_87DE(1);

  for(;;) {
    var_0 waittill("_encstr_93510A16C71B20636A2AB8B8", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_9[2] > var_0.origin[2] + var_2 && isDefined(var_12) && var_12 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_12 scripts\engine\utility::delaycallwatchself(var_3, ::dodamage, var_4, var_9);
      var_0 notify("_encstr_99EC1213A3D24DE4D146C77210170840E09B53A3");
    }
  }
}

_encstr_8F7C174EED622D018D2B21F04FAD9967CA59C4DF437AE98962() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setCanDamage(1);
  var_0._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC = level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_839A0EE61B4BDC7659E48656C2C6E8A1;
  var_0.health = 99999;
  var_0.maxhealth = 99999;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = var_0.health + var_1;

    if(isDefined(var_10) && isDefined(var_10.magazine)) {
      switch (var_10.magazine) {
        case "_encstr_93931296D86BFFF828B323961829F3CFB587923B":
          var_1 = 300;
          break;
        case "_encstr_8A77125EB62A2F4B930B423123D58077C2CA6FFB":
          var_0 thread _encstr_ACE91E5FC2908A698D78603B05FF63C3FFD48F3F633F90C68A43EA2B8BFBE8D0(3, var_2, var_4);
          break;
      }
    }

    if(var_1 < 2) {
      continue;
    }
    if(isPlayer(var_2))
      var_2 scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", var_0.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");
    else if(isDefined(var_2.owner) && isPlayer(var_2.owner))
      var_2.owner scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", var_0.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");

    if(isDefined(var_2) && isDefined(var_2.currentweapon) && isDefined(var_2.currentweapon.basename) && var_2.currentweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83")
      var_1 = var_1 * level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC1C1353F19320BE4B2AFBC033EB75082A44CBC38A;
    else if(isDefined(var_5) && var_5 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_5 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
      var_1 = var_1 * level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_ABD8156A3207F39DD0832E058F18233BAD88B302F85533;

    if(isDefined(var_10) && isDefined(var_10.basename) && var_10.basename == "_encstr_95E70D8EDBDA85F5839CED35F5B683")
      var_1 = var_0._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC + 1;

    var_0._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC = var_0._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC - var_1;

    if(var_0._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC <= 0) {
      break;
    }

    if(isDefined(var_10) && isDefined(var_10.magazine)) {
      switch (var_10.magazine) {
        case "_encstr_A9B01326DEB13A2B0F3863F6D7C6C9DB37B9267B77":
          scripts\engine\utility::delaycallwatchself(2.05, ::dodamage, var_1, var_4, var_2, undefined, undefined, undefined, var_4);
          break;
        case "_encstr_B460120A50F13BBB302E75574EBB570237D042D3":
          scripts\engine\utility::delaycallwatchself(4, ::dodamage, var_1, var_4, var_2, undefined, undefined, undefined, var_4);
          break;
      }
    }
  }

  if(isDefined(var_2.model) && var_2.model == "_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634" && isDefined(var_2.owner) && isPlayer(var_2.owner))
    var_2.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_2.currentweapon) && isDefined(var_2.currentweapon.basename) && var_2.currentweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

  var_0 notify("_encstr_99EC1213A3D24DE4D146C77210170840E09B53A3");
}

_encstr_ACE91E5FC2908A698D78603B05FF63C3FFD48F3F633F90C68A43EA2B8BFBE8D0(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("_encstr_AD75063D571AE108");

  for(var_4 = 0; var_4 < var_0; var_4 = var_4 + 0.25) {
    wait 0.25;

    if(scripts\mp\utility\player::isreallyalive(var_1))
      var_1 scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");
  }

  var_3 dodamage(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_8D410C05246ADD9859FB0838D37B * var_0, var_2, var_1, undefined, undefined, undefined, var_2);
}

_encstr_84B41EC893DEE0AFC11B85F2CA396EFAB7B97D26E4B2855BEBDD583A6C34CA9C() {
  var_0 = self;
  var_0 waittill("_encstr_AD75063D571AE108");

  foreach(var_2 in var_0._encstr_86271121EA1FDD7B7A40389950E8EA43658A92) {
    var_3 = var_2 getentitynumber();
    var_4 = var_0._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_3];
    var_4 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_133FC(var_2);
    var_4 stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
    _encstr_A16713E6632DE6CEAC9C33AB363636B156C2CDAE0E(var_2, var_3, var_0);
  }
}

_encstr_8DB31627BAE6EB6EB12DCDB32B39D75A8CD8957D2C9B4BD6(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;)
    var_0 scripts\common\anim::anim_single_solo(var_1, "_encstr_B29312FBB06205CA02861F50D1CADA979BA190B7");
}

_encstr_B6A4169BD8969BCE95E4E6D8395A838E163163ACABB9B28C(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_8E8607AB603B6E4341") {
    if(!_encstr_BE2614CB6BD8B203079292EB7B667F2A60C34E578BC0(var_0, var_3)) {
      return;
    }
    if(getdvarint("_encstr_91F22A7BB64B7F2221B80A92F035113781A6E2E9DF11FB6F9F40129BE84DD6FFDB83779678192B368D40AA92", 1) && isDefined(var_3.get_search_turret_target_player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_99E91506C96A0BC2A122215D97489BCA21EF92C0686FA2")) {
      var_0._encstr_881F1017F50BC10942AB38188794603F225D = var_0.entity;
      var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_99E91506C96A0BC2A122215D97489BCA21EF92C0686FA2")]](var_0);
      return;
    }

    var_3 thread _encstr_BD1A0BCD5F90627373CDA28AAB(var_0);
  }
}

_encstr_BE2614CB6BD8B203079292EB7B667F2A60C34E578BC0(var_0, var_1) {
  if(istrue(var_0.inuse))
    return 0;

  if(var_1 isswitchingweapon())
    return 0;

  if(var_1.currentweapon.basename == "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817")
    return 0;

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(var_1.tracking_max_health))
    return 0;

  if(istrue(var_1.inlaststand))
    return 0;

  if(istrue(var_1.isreviving))
    return 0;

  if(istrue(var_1.isjuggernaut))
    return 0;

  if(var_1 isskydiving())
    return 0;

  if(var_1 isparachuting())
    return 0;

  if(istrue(var_1.iszombie))
    return 0;

  if(!var_1 scripts\common\utility::trial_ui_retry_disabled())
    return 0;

  return 1;
}

_encstr_BD1A0BCD5F90627373CDA28AAB(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_2 = var_0.entity;
  var_2 endon("_encstr_AD75063D571AE108");
  var_2._encstr_86271121EA1FDD7B7A40389950E8EA43658A92[var_2._encstr_86271121EA1FDD7B7A40389950E8EA43658A92.size] = var_1;
  var_1._id_140AF = 1;
  var_1.shouldskiplaststand = 1;

  if(isDefined(var_1.get_search_turret_target_player))
    var_1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier(0);

  _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_1246F(var_1);
  var_1 scripts\common\utility::allow_usability(0);
  var_0 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_13405();
  var_1.usingascender = 1;
  var_3 = var_1 getentitynumber();
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_2._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_3] = var_4;
  var_4 dontinterpolate();
  var_4.origin = var_0.origin;
  var_4.angles = var_1.angles;
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_5 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_5 setModel("_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097");
  var_5 showonlytoplayer(var_1);
  var_2._encstr_971A136F3EF2B2D018EFC36803735C8B7F91CBF962[var_3] = var_5;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_6 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_6 setModel("_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097");
  var_6 hide();
  var_2._encstr_A3B21406E6A73206E158B35FF0DBCCEA6370CFBFC1EF[var_3] = var_6;
  var_1 thread _encstr_8DB71EE358636307C80D918BC7208DB39BF03A1AC1CF43BCD8039B74D34017A3(var_0, var_3);
  var_1._encstr_85D412BBF23238F04B5A3957A11DD32F890963E9 = 0;
  var_7 = var_4 _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_133FB(var_1, var_5, var_6);

  if(!var_7) {
    _encstr_A16713E6632DE6CEAC9C33AB363636B156C2CDAE0E(var_1, var_3, var_2);
    playsoundatpos(var_0.origin, "_encstr_82AC1682309030A2F89F3FF3FB1F0A79901EFF8F08F8C5CA");
    return;
  }

  var_1 childthread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_133FE();
  var_1 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_12505();
  var_4 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_133FD(var_1, var_5, var_6);
  var_4 playLoopSound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_4 moveTo(var_4.origin + (0, 0, level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_99C10DA646C7526683508F87103834), level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC0C0B770B8F2DF80953100858, level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC0C0B770B8F2DF80953100858);
  playfxontagforclients(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.cantakedamage, var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1);
  wait(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC0C0B770B8F2DF80953100858 * 0.35);
  var_1._encstr_85D412BBF23238F04B5A3957A11DD32F890963E9 = 1;
  wait(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_AC0C0B770B8F2DF80953100858 * 0.65);
  stopFXOnTag(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.cantakedamage, var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 notify("_encstr_86531F22176324977032CA62EA17C0FF602A1BEA105801BDA2D654A8D3235A6A45");
  var_4 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_133FC(var_1, var_5, var_6);
  var_4 stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_1 playlocalsound("_encstr_83761ADC1BE4FAC4E4BED2CDCC4B36D74DD5B5C1AF371DB4E6CEACE4", var_1);
  var_1 earthquakeforplayer(0.2, 1.5, var_1.origin, 1000);
  var_8 = "_encstr_A18008BD35E222F01BD0";

  if(isDefined(var_1.operatorcustomization) && isDefined(var_1.operatorcustomization.disabledebugdialogue))
    var_8 = var_8 + var_1.operatorcustomization.disabledebugdialogue;

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", var_8, 0);
  var_1 setisinfilskydive(1);
  var_1._encstr_BE4F166B85E8B5C7E5D0717BDB8EF2E8A451F9B8D8A9E35B = anglesToForward(var_1 getplayerangles(1)) * level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_9616147A91057B1E881DB79207F8629BAE492282795E;
  var_4 movegravity(var_1._encstr_BE4F166B85E8B5C7E5D0717BDB8EF2E8A451F9B8D8A9E35B + (0, 0, level._encstr_85290EB91BA59BB3AC4E832CC90BDADC._encstr_911E0E85980DF00F5B70BB13EAF92EF8), level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.launchtime);
  wait(level._encstr_85290EB91BA59BB3AC4E832CC90BDADC.launchtime - 0.1);
  var_1 setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 1);
  var_1 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_id_13403();
  _encstr_A16713E6632DE6CEAC9C33AB363636B156C2CDAE0E(var_1, var_3, var_2);
  var_2._encstr_86271121EA1FDD7B7A40389950E8EA43658A92 = scripts\engine\utility::array_remove(var_2._encstr_86271121EA1FDD7B7A40389950E8EA43658A92, var_1);
}

_encstr_8DB71EE358636307C80D918BC7208DB39BF03A1AC1CF43BCD8039B74D34017A3(var_0, var_1) {
  var_2 = self;
  var_2 endon("_encstr_BAB1110FC1A015F719C67950D0900B21053B7D");
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", level, "_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2))
    var_2 stopanimscriptsceneevent();

  var_3 = var_0.entity;
  var_3._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_1] stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_3._encstr_86271121EA1FDD7B7A40389950E8EA43658A92 = scripts\engine\utility::array_remove(var_3._encstr_86271121EA1FDD7B7A40389950E8EA43658A92, var_2);
  _encstr_A16713E6632DE6CEAC9C33AB363636B156C2CDAE0E(var_2, var_1, var_3);
}

_encstr_A16713E6632DE6CEAC9C33AB363636B156C2CDAE0E(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
    var_0 setisinfilskydive(0);
  }

  if(isDefined(var_2._encstr_971A136F3EF2B2D018EFC36803735C8B7F91CBF962[var_1])) {
    var_2._encstr_971A136F3EF2B2D018EFC36803735C8B7F91CBF962[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2._encstr_971A136F3EF2B2D018EFC36803735C8B7F91CBF962[var_1] delete();
  }

  if(isDefined(var_2._encstr_A3B21406E6A73206E158B35FF0DBCCEA6370CFBFC1EF[var_1])) {
    var_2._encstr_A3B21406E6A73206E158B35FF0DBCCEA6370CFBFC1EF[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2._encstr_A3B21406E6A73206E158B35FF0DBCCEA6370CFBFC1EF[var_1] delete();
  }

  var_2 thread _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::cleanupascenduse(var_0);
  var_2 thread _encstr_86CE1180E9EFAA4BA0D8BC77C2E1A39B366383(var_0, var_1);

  if(isDefined(var_0)) {
    if(!istrue(level.client_activate))
      var_0 skydive_setbasejumpingstatus(1);

    var_0.player_rig stopanimScripted();
    var_0.usingascender = 0;
    var_0._id_140AF = 0;
    var_0 notify("_encstr_86531F22176324977032CA62EA17C0FF602A1BEA105801BDA2D654A8D3235A6A45");

    if(isDefined(var_0._encstr_BE4F166B85E8B5C7E5D0717BDB8EF2E8A451F9B8D8A9E35B))
      var_0 setvelocity(var_0._encstr_BE4F166B85E8B5C7E5D0717BDB8EF2E8A451F9B8D8A9E35B);

    var_0._encstr_BE4F166B85E8B5C7E5D0717BDB8EF2E8A451F9B8D8A9E35B = undefined;

    if(istrue(var_0._encstr_85D412BBF23238F04B5A3957A11DD32F890963E9) && !istrue(level.client_activate) && !scripts\mp\utility\player::unset_relic_trex(var_0))
      var_0 skydive_beginfreefall();

    var_0 notify("_encstr_BAB1110FC1A015F719C67950D0900B21053B7D");
  }
}

_encstr_86CE1180E9EFAA4BA0D8BC77C2E1A39B366383(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_0)) {
    var_0 unlink();

    if(!var_0 scripts\common\utility::can_be_executed())
      var_0 scripts\common\utility::allow_execution_victim(1);
  }

  if(isDefined(var_2._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_1])) {
    var_2._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2._encstr_B4E2132C9BC62BE632CA93DCD8B2B92B9BDE9159CD[var_1] delete();
  }
}