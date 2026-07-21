/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\auto_ascender.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_8A0F13B7504B39DB539A1A156D4A33A93B03BFF20B", 360.0);
  setdvarifuninitialized("_encstr_957614FBA25B20A8DFF3BFBB0647787E471B13A1AA7B", 460.0);
  setdvarifuninitialized("_encstr_A74D1763D780C18BAD4B1A62F075C7C2919FF8FD6398196FCF", 540.0);
  setdvarifuninitialized("_encstr_B28824ABDFC219DBD7DEED3DB9CB951710302BE18141921816B73E46933ABE935E110973C71B", 0);
  setdvarifuninitialized("_encstr_815F1E5F379B10C8BB167910FF9568A8C287EDFF83F2C1A0FF2E616B237D1878", 1500);
  setdvarifuninitialized("_encstr_841F21B9B14ED7C2CD3659E68C599CFAF66756C927D23259F5D60B0FEB58D8A3963BCA", -1);
  level.ascendstarts = scripts\engine\utility::getStructArray("_encstr_85D00DBFA05125A281E0CE07D4A39A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.descendstarts = scripts\engine\utility::getStructArray("_encstr_AC250E51FD4A883D33C296393AFFE338", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.ascendstructs = [];

  if(!isDefined(level.initpostmain))
    level.initpostmain = 0;

  if(!isDefined(level._id_13BEB))
    level._id_13BEB = 0;

  foreach(var_1 in level.ascendstarts)
  markupascenderstruct(var_1, 1);

  foreach(var_1 in level.descendstarts)
  markupascenderstruct(var_1, 0);

  initanimtree();
  scripts\engine\scriptable::_id_12F5B("_encstr_8D1F09027BA68F8523E342", ::ascenderscriptableused);
}

registered_checkpoints() {
  return 360.0;
}

registerfalldamagedvars() {
  return 460.0;
}

registerhandlecommand() {
  return 540.0;
}

registered_checkpoint_funcs() {
  return 0.4;
}

registereventcallback() {
  return 0.15;
}

registerhint() {
  return 12100;
}

registerheadlessinfil() {
  return 72;
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

initanimtree() {
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = % _encstr_ADCB1D23B5AFD84F0987EFD78FC21D103A81CB7B51FF80852157DDA7F38A5E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = "_encstr_ADCB1D23B5AFD84F0987EFD78FC21D103A81CB7B51FF80852157DDA7F38A5E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = "_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = % _encstr_ABB41BD4EFB70D8B9F23E7607FC0BB586B49D34B8FE1F7607A390F12AA;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = "_encstr_ABB41BD4EFB70D8B9F23E7607FC0BB586B49D34B8FE1F7607A390F12AA";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = "_encstr_83D41167AB57713DFFBA60015312A7A88F2F77";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = % _encstr_B1701EE3D0811D63C0ABAFD79B707A55B0FE5BEA0EE8A5EB385FF3CB8727C29A;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = "_encstr_B1701EE3D0811D63C0ABAFD79B707A55B0FE5BEA0EE8A5EB385FF3CB8727C29A";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = "_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = % _encstr_A3B01FC3E9DF32198678B70FA058C4FA5D68CF3D4CD5E957E9F80F37D056A832F5;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = "_encstr_A3B01FC3E9DF32198678B70FA058C4FA5D68CF3D4CD5E957E9F80F37D056A832F5";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = "_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = % _encstr_AFA11D53711F3BC35F1AFE4709E85F2942671715A833AFCB481D1BF903CB0E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = "_encstr_AFA11D53711F3BC35F1AFE4709E85F2942671715A833AFCB481D1BF903CB0E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = "_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = % _encstr_82FB20EE217E07D237884B4240BD4FDF7380447F4420A71F7B38719A60F5C9C368FE;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = "_encstr_82FB20EE217E07D237884B4240BD4FDF7380447F4420A71F7B38719A60F5C9C368FE";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = "_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = % _encstr_8849223B5BBECAC5EB85DCC62BE691CAC9AF5707BE9D2BE8F57BB9D785E68D2B7323959C;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = "_encstr_8849223B5BBECAC5EB85DCC62BE691CAC9AF5707BE9D2BE8F57BB9D785E68D2B7323959C";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B"] = "_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = % _encstr_AB35205D074105309F9EA3B98786D04D2B67C3D9379AD8F8E879E9B32E755875324B;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = "_encstr_AB35205D074105309F9EA3B98786D04D2B67C3D9379AD8F8E879E9B32E755875324B";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_83D41167AB57713DFFBA60015312A7A88F2F77"] = "_encstr_83D41167AB57713DFFBA60015312A7A88F2F77";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = % _encstr_830223D95BFA59C5D7C2CD36B237195627BEEA837D3B9547FAF6CC66D785B91B2B7332959C;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = "_encstr_830223D95BFA59C5D7C2CD36B237195627BEEA837D3B9547FAF6CC66D785B91B2B7332959C";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40"] = "_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = % _encstr_A6EC24CD4DC930AF6F1A6B91A253EDF85AE76147FFED99FCAF63E6183ABF1710B635EDD99552;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = "_encstr_A6EC24CD4DC930AF6F1A6B91A253EDF85AE76147FFED99FCAF63E6183ABF1710B635EDD99552";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38"] = "_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = % _encstr_A953223BDAAF595CEB0B6ED8ACE62359E4EB91B7DDDC7DC6EDED0ED70B376C2B3746AC27;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = "_encstr_A953223BDAAF595CEB0B6ED8ACE62359E4EB91B7DDDC7DC6EDED0ED70B376C2B3746AC27";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38"] = "_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = % _encstr_975925C3F7D72DE3F9A0E31F9D0E657DEBDF14900F1BC8FC333B676876DC99C0C316A22BACBA48;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = "_encstr_975925C3F7D72DE3F9A0E31F9D0E657DEBDF14900F1BC8FC333B676876DC99C0C316A22BACBA48";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B"] = "_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8F84120BDCC6B2378CAC4ED7AE07D75AB9BEEE6B"] = % _encstr_990222F3457F089FD9B7DF87DFB26D400A513BAB61AFF0D5F1A7EDF7E74B2698BEF7A163;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8F84120BDCC6B2378CAC4ED7AE07D75AB9BEEE6B"] = "_encstr_990222F3457F089FD9B7DF87DFB26D400A513BAB61AFF0D5F1A7EDF7E74B2698BEF7A163";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8F84120BDCC6B2378CAC4ED7AE07D75AB9BEEE6B"] = "_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_9BB5141F0EDF13229F4BCB41AF23AF70ADDF13AEE36F"] = % _encstr_8B55206CB5A7710331FA68E05295D189FB1FF5672F337877A221E0982A6F8DE11FDA;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_9BB5141F0EDF13229F4BCB41AF23AF70ADDF13AEE36F"] = "_encstr_8B55206CB5A7710331FA68E05295D189FB1FF5672F337877A221E0982A6F8DE11FDA";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_9BB5141F0EDF13229F4BCB41AF23AF70ADDF13AEE36F"] = "_encstr_83D41167AB57713DFFBA60015312A7A88F2F77";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A3CB134A33EEF7FD48BB0ADF631049170D4B219358"] = % _encstr_B15923A7FFB9FDD807060B012FEEA82583CF2B319F82B5B86F9D91B959C9586EAAA3F193B3;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A3CB134A33EEF7FD48BB0ADF631049170D4B219358"] = "_encstr_B15923A7FFB9FDD807060B012FEEA82583CF2B319F82B5B86F9D91B959C9586EAAA3F193B3";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A3CB134A33EEF7FD48BB0ADF631049170D4B219358"] = "_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_AD32140B9B6C569B91CA397D23F6DD37FAB4DCEBEE6B"] = % _encstr_AC5024AB707077BA11338B63C36007BF0EAE12929BB0E777E831AF67FDC10EBF3E012AAAA116;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_AD32140B9B6C569B91CA397D23F6DD37FAB4DCEBEE6B"] = "_encstr_AC5024AB707077BA11338B63C36007BF0EAE12929BB0E777E831AF67FDC10EBF3E012AAAA116";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_AD32140B9B6C569B91CA397D23F6DD37FAB4DCEBEE6B"] = "_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A35D16C7A78E6A561081BAC999707712480177074938F31D"] = % _encstr_A2182277ADEB2B8BBEC237B12BCDC8ACE4EB8CEDDDCD7D36F6DB837D586E8DB2DC8C59E4;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A35D16C7A78E6A561081BAC999707712480177074938F31D"] = "_encstr_A2182277ADEB2B8BBEC237B12BCDC8ACE4EB8CEDDDCD7D36F6DB837D586E8DB2DC8C59E4";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A35D16C7A78E6A561081BAC999707712480177074938F31D"] = "_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_81AB1569BE69976531D8CB11F80F1B034628E5F4C0B3FF"] = % _encstr_954225A8C2C1D3335F49968625F3D9ABF289A8E0DB256F096F6488883EEB666B1AD22850023F6D;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_81AB1569BE69976531D8CB11F80F1B034628E5F4C0B3FF"] = "_encstr_954225A8C2C1D3335F49968625F3D9ABF289A8E0DB256F096F6488883EEB666B1AD22850023F6D";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_81AB1569BE69976531D8CB11F80F1B034628E5F4C0B3FF"] = "_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B";
}

markupascenderstruct(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2)) {
    var_0 = undefined;
    return;
  }

  var_3 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_3)) {
    var_0 = undefined;
    return;
  }

  level.ascendstructs[var_0.targetname] = var_0;
  level._id_13BEB++;
  var_0.ascendstructend = var_2;
  var_0.ascendstructout = var_3;
  var_0.inuse = 0;
  var_0.exitangle = var_0.angles + (0, 180, 0);
  var_0.startangle = var_0.angles;
  var_0.dir = var_1;
  var_0.ascender = [];
  var_0.waittill_player_opens_tac_map = 0;
}

ascenderscriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "_encstr_BA19049F4B2D") {
    if(istrue(var_3.usingascender)) {
      return;
    }
    thread ascenderuse(var_0, var_3);
  }
}

laststand_player_in_focus() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AA77128CCA73CB829BD8567319A6CAE6E6C23B56");
  self endon("_encstr_AA77128CCA73CB829BD8567319A6CAE6E6C23B56");
  self playsoundtoplayer("_encstr_A5A918FB80AF7FEFD80BABA46760B333B6183203E9F8FB27E05B", self);

  if(isDefined(level.canspawnitemname))
    self[[level.canspawnitemname]]("_encstr_AA44190A73AEB7BD08FB4A1F8D3085E7C229D251597563B790CB53", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar(80);
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }
}

laststandattacker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A1611B8925A5F097FF1A89D0523F4D683AB90773E4CE1855170301D8BA");
  self endon("_encstr_A1611B8925A5F097FF1A89D0523F4D683AB90773E4CE1855170301D8BA");
  self playsoundtoplayer("_encstr_A5A918FB80AF7FEFD80BABA46760B333B6183203E9F8FB27E05B", self);

  if(isDefined(level.canspawnitemname))
    self[[level.canspawnitemname]]("_encstr_872D1B4953EFED284F35ADFF5A3558A6A7AA61360A3F1E30A21C93E544", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar(55);
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }
}

denyascendmessage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AA77128CCA73CB829BD8567319A6CAE6E6C23B56");
  self endon("_encstr_AA77128CCA73CB829BD8567319A6CAE6E6C23B56");
  self playsoundtoplayer("_encstr_A5A918FB80AF7FEFD80BABA46760B333B6183203E9F8FB27E05B", self);

  if(isDefined(level.canspawnitemname))
    self[[level.canspawnitemname]]("_encstr_A145110F628A7378D43F30611BE490B7D20F75", 4);
  else {
    scripts\mp\utility\lower_message::setlowermessageomnvar(43);
    wait 4;
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }
}

ascenddeathlistener(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
  self endon("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  var_1 = spawnStruct();
  var_1._id_125BC = self.guid;
  var_1.cansnapcamera = self.cansnapcamera;
  var_1.cansolospawn = self.cansolospawn;
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self))
    self stopanimscriptsceneevent();

  var_0.locationsnames = var_1;
  var_0 cleanupascenduse(self);
}

endascenderanim(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");

  if(var_1)
    var_4 = "_encstr_8A5E10E8E27BADA80FEFADF1CB2FC9D06B40";
  else
    var_4 = "_encstr_81B41256B6D742769108E34F18A827BAD7C0DB8B";

  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_4);
  scripts\common\anim::anim_single_solo(var_3, var_4 + "_encstr_B81A04AFEE6B");
}

startascenderanim(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  var_0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_8BB007E03658CBCAE4", var_0.origin, var_0.angles);
  var_2.animname = "_encstr_9690073295D94B8D59";
  var_2 scripts\common\anim::setanimtree();
  var_3.animname = "_encstr_9690073295D94B8D59";
  var_3 scripts\common\anim::setanimtree();
  var_3 hide();
  var_4 = (1, 0, 0);

  if(var_1) {
    var_5 = "_encstr_B2AE149D158949D9E69E950B62470AD639E5A1076BD5";
    var_6 = "_encstr_A21F0F1A1F51AAF8A3CB589F1B8330CC5B";
    var_4 = rotatevector((-40.9464, 22.9807, 0), self.angles);
  } else {
    var_5 = "_encstr_97D7133BD5B7E0899EC96D81C71DC290BFB35BFF19";
    var_6 = "_encstr_AC3F11D8E30E1310738DD65864B7FBFDF9AA38";
    var_4 = rotatevector((-42.2388, -23.4915, 0), self.angles);
  }

  var_0.player_rig moveTo(self.origin + var_4, 0.4, 0.1, 0.1);
  var_7 = vectorNormalize(var_4 * -1);
  var_8 = vectortoanglessafe(var_7, (0, 0, 1));
  var_0.player_rig rotateTo(var_8, 0.4, 0.1, 0.1);
  var_9 = gettime();
  var_10 = var_0 scripts\mp\utility\infilexfil::givegunless();

  if(!var_10)
    return 0;

  var_0 _meth_87E4();
  var_11 = gettime();
  var_12 = 0.4 - (var_11 - var_9) / 1000.0;
  var_13 = max(0, var_12);
  wait(var_13);
  var_3 show();
  var_3 hidefromplayer(var_0);
  var_0.player_rig linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2 linkTo(var_0.player_rig, var_5, (0, 0, 0), (0, 0, 0));
  var_3 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.player_rig showonlytoplayer(var_0);
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_6);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_6);
  thread scripts\common\anim::anim_single_solo(var_3, var_6 + "_encstr_B81A04AFEE6B");
  var_14 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_6]);
  wait(var_14);
  return 1;
}

loopwaitanim(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_92EE13030FF275B8B48F930EF5977837E9BBE795CF");
  self endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");

  if(var_3)
    var_4 = "_encstr_83D41167AB57713DFFBA60015312A7A88F2F77";
  else
    var_4 = "_encstr_9708132CB91BAC738C5927BEC8DEBB9BBE1BDBDB38";

  var_5 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_4]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_0 thread scripts\mp\anim::anim_player_solo(self, self.player_rig, var_4);
    var_0 scripts\common\anim::anim_single_solo(var_2, var_4 + "_encstr_B81A04AFEE6B");

    if(!isDefined(var_5) || var_5 == 0) {
      break;
    }

    wait(var_5);
  }
}

get_any_player_has_respawn(var_0, var_1) {
  if(var_1 isswitchingweapon()) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  if(istrue(var_1.tracking_max_health)) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  if(istrue(var_1.inlaststand)) {
    var_1 thread laststandattacker();
    return 0;
  }

  if(istrue(var_1.isreviving))
    return 0;

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name) && getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0)) {
    var_2 = istrue(var_1.iszombie) && isDefined(var_1.vehicle_occupancy_monitormovementcontrols);
    var_3 = var_1 isgestureplaying("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC") || var_1 isgestureplaying("_encstr_8FF715E75013DF2357390EC4150F8BBDDBC83BABB88848");

    if(var_2 || var_3) {
      var_1 thread laststand_player_in_focus();
      return 0;
    }
  }

  if(!var_1 scripts\common\utility::trial_ui_retry_disabled()) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  if(var_1 isskydiving())
    return 0;

  var_4 = level.ascendstructs[var_0.target];

  if(!isDefined(var_4))
    return 0;

  if(var_4.inuse && getdvarint("_encstr_B28824ABDFC219DBD7DEED3DB9CB951710302BE18141921816B73E46933ABE935E110973C71B", 0)) {
    var_1 thread denyascendmessage();
    return 0;
  }

  if(gettime() - var_4.waittill_player_opens_tac_map < getdvarint("_encstr_815F1E5F379B10C8BB167910FF9568A8C287EDFF83F2C1A0FF2E616B237D1878")) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  var_5 = max(level._id_13BEB, 30);
  var_6 = getdvarint("_encstr_841F21B9B14ED7C2CD3659E68C599CFAF66756C927D23259F5D60B0FEB58D8A3963BCA", var_5);

  if(var_6 != -1)
    var_5 = var_6;

  if(level.initpostmain >= var_5) {
    var_1 thread laststand_player_in_focus();
    return 0;
  }

  if(isDefined(var_4._id_134CB) && istrue(var_4._id_134CB.inuse)) {
    var_1 thread denyascendmessage();
    return 0;
  }

  if(isDefined(var_1.get_search_turret_target_player)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8463164B976BEB44DB13CA52011B3A4FE506D3C5B8F1FFCA")) {
      if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8463164B976BEB44DB13CA52011B3A4FE506D3C5B8F1FFCA")]](var_0))
        return 0;
    }
  }

  return 1;
}

ascenderuse(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");

  if(!get_any_player_has_respawn(var_0, var_1)) {
    return;
  }
  var_2 = level.ascendstructs[var_0.target];
  var_1.shouldskiplaststand = 1;
  var_2.waittill_player_opens_tac_map = gettime();
  var_2.ascender[var_1.guid] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.ascender[var_1.guid] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.initpostmain++;
  var_2.scriptable = var_0;

  if(var_1 getstance() != "_encstr_A5AD069B231F0BAF")
    var_1 setstance("_encstr_A5AD069B231F0BAF");

  var_1 scripts\common\utility::allow_execution_victim(0);
  var_1 scripts\common\utility::allow_melee(0);
  var_1 scripts\common\utility::allow_ads(0);
  var_1 scripts\common\utility::allow_fire(0);

  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
      var_3 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

      if(istrue(var_3))
        var_1 disableweaponswitch();
    }
  } else {
    var_1 disableoffhandweapons();
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 disableweaponswitch();
  }

  var_2.ascender[var_1.guid] scripts\cp_mp\ent_manager::registerspawncount(2);
  var_2.inuse = 1;
  var_1.usingascender = 1;
  var_1 scripts\common\utility::allow_usability(0);
  var_4 = var_2.ascendstructend;
  var_5 = var_2.ascendstructout;
  var_2.ascender[var_1.guid] dontinterpolate();
  var_2.ascender[var_1.guid].origin = var_2.origin;
  var_2.ascender[var_1.guid].angles = var_2.angles;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);

  if(!scripts\cp_mp\utility\game_utility::_id_140AA())
    var_6 setModel("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE");
  else
    var_6 setModel("_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097");

  var_6 showonlytoplayer(var_1);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);

  if(!scripts\cp_mp\utility\game_utility::_id_140AA())
    var_7 setModel("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE");
  else
    var_7 setModel("_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417");

  var_7 hidefromplayer(var_1);
  var_1.cansticktoent = var_2;
  var_1.cansnapcamera = var_6;
  var_1.cansolospawn = var_7;
  var_1 thread ascenddeathlistener(var_2);
  var_8 = var_2.ascender[var_1.guid] startascenderanim(var_1, var_2.dir, var_6, var_7);

  if(!var_8) {
    var_1 thread laststand_player_in_focus();
    var_2 cleanupascenduse(var_1);
    return;
  }

  var_2.ascender[var_1.guid] playLoopSound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_1 thread loopwaitanim(var_2.ascender[var_1.guid], var_6, var_7, var_2.dir);
  var_9 = distance(var_4.origin, var_2.origin);

  if(!var_2.dir) {
    if(scripts\common\utility::iscp())
      var_10 = getdvarfloat("_encstr_A74D1763D780C18BAD4B1A62F075C7C2919FF8FD6398196FCF", registerhandlecommand());
    else
      var_10 = getdvarfloat("_encstr_957614FBA25B20A8DFF3BFBB0647787E471B13A1AA7B", registerfalldamagedvars());
  } else
    var_10 = getdvarfloat("_encstr_8A0F13B7504B39DB539A1A156D4A33A93B03BFF20B", registered_checkpoints());

  var_11 = var_9 / var_10;
  var_12 = registered_checkpoint_funcs() * var_11;
  var_13 = registereventcallback() * var_11;
  var_2.ascender[var_1.guid] moveTo(var_4.origin, var_11, var_12, var_13);

  if(var_1.currentweapon.basename != "_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6")
    var_1 scripts\mp\utility\infilexfil::givegunless();

  wait(var_11);
  var_2.ascender[var_1.guid] stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_1 notify("_encstr_92EE13030FF275B8B48F930EF5977837E9BBE795CF");
  var_2.ascender[var_1.guid] endascenderanim(var_1, var_2.dir, var_6, var_7);
  var_2 cleanupascenduse(var_1);
  var_1 notify("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
}

cleanupascenduse(var_0) {
  if(self.ascender.size == 1)
    self.inuse = 0;

  if(isDefined(var_0)) {
    var_0.usingascender = 0;
    var_0.waittill_player_opens_scavenger_cache = gettime();
    var_0 scripts\common\utility::allow_usability(1);
    var_0.shouldskiplaststand = undefined;
    var_0 scripts\common\utility::allow_execution_victim(1);
    var_0 scripts\common\utility::allow_melee(1);
    var_0 scripts\common\utility::allow_ads(1);
    var_0 scripts\common\utility::allow_fire(1);

    if(istrue(var_0.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(istrue(var_1))
          var_0 enableweaponswitch();
      }
    } else if(!istrue(var_0.inlaststand)) {
      var_0 enableoffhandweapons();
      var_0 enableweaponswitch();
      var_0 scripts\common\utility::allow_killstreaks(1);
    } else
      var_0 thread watch_for_ashes_achievement();

    if(isDefined(var_0.cansnapcamera)) {
      var_0.cansnapcamera unlink();
      var_0.cansnapcamera delete();
    }

    if(isDefined(var_0.cansolospawn)) {
      var_0.cansolospawn unlink();
      var_0.cansolospawn delete();
    }
  } else if(isDefined(self.locationsnames)) {
    if(isDefined(self.locationsnames.cansnapcamera)) {
      self.locationsnames.cansnapcamera unlink();
      self.locationsnames.cansnapcamera delete();
    }

    if(isDefined(self.locationsnames.cansolospawn)) {
      self.locationsnames.cansolospawn unlink();
      self.locationsnames.cansolospawn delete();
    }
  }

  var_2 = undefined;

  if(isDefined(var_0))
    var_2 = var_0.guid;

  if(isDefined(self.locationsnames)) {
    var_2 = self.locationsnames._id_125BC;
    self.locationsnames = undefined;
  }

  if(isDefined(var_0)) {
    var_0.cansticktoent = undefined;
    var_0.cansnapcamera = undefined;
    var_0.cansolospawn = undefined;
    var_0.player_rig unlink();
  }

  if(isDefined(var_2) && isDefined(self.ascender[var_2])) {
    self.ascender[var_2].angles = self.startangle;
    self.ascender[var_2] scripts\cp_mp\ent_manager::deregisterspawn();
    self.ascender[var_2] delete();
    self.ascender[var_2] = undefined;
    level.initpostmain--;
  }

  if(isDefined(self.scriptable)) {
    var_3 = "_encstr_AB0703DBB9";

    if(isDefined(self.scriptable.script_noteworthy))
      var_3 = self.scriptable.script_noteworthy;

    if(isDefined(self._id_134CB))
      self.scriptable setscriptablepartstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", var_3);
    else
      self.scriptable setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", var_3);
  }

  waitframe();

  if(isDefined(var_0)) {
    var_0 _meth_87E5();
    var_0 thread scripts\mp\utility\infilexfil::takegunless();
    var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  }
}

watch_for_ashes_achievement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  var_0 enableoffhandweapons();
  var_0 enableweaponswitch();
  var_0 _meth_87E5();
  var_0 scripts\common\utility::allow_killstreaks(1);
  var_0 thread scripts\mp\utility\infilexfil::takegunless();
}

canseesafecircleui() {
  var_0 = self;

  if(!istrue(var_0.usingascender)) {
    return;
  }
  var_1 = var_0.cansticktoent.ascendstructout.origin;
  var_2 = var_0.cansticktoent.ascendstructout.angles;
  var_0 notify("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  var_0 notify("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  var_0.cansticktoent cleanupascenduse(var_0);
  var_0 setOrigin(var_1);
  var_0 setplayerangles(var_2);
  var_0 forceusehintoff();
  var_0 stopanimscriptsceneevent();
}

vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

updatesixthsensevo(var_0) {
  foreach(var_2 in level.ascendstructs) {
    if(distance2dsquared(var_2.origin, var_0) < registerhint()) {
      if(abs(var_0[2] - var_2.origin[2]) < registerheadlessinfil())
        return 1;
    }
  }

  return 0;
}