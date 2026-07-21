/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\face.gsc
***********************************************/

saygenericdialogue(var_0) {
  if(self.unittype != "_encstr_958C08CDDBD8325A959C" && self.unittype != "_encstr_83E8094727E333E8F9CE50" && self.unittype != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79" && self.unittype != "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
    return;
  }
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_A9110CDAAC36B259163AD10B8DAD":
    case "_encstr_BE5E0C6135D5F7729EC9B2ED6F08":
      var_2 = 0.5;
      break;
    case "_encstr_ABE70A08F0C68B546D12A8E7":
      var_2 = 0.7;
      var_1 = 50;
      break;
    case "_encstr_B60D055B0E3128":
      var_2 = 0.9;
      var_1 = 98;
      break;
    case "_encstr_B1B50D6E8F820761BA4718102FC3F8":
    case "_encstr_83310BDCF5FA3349844FD86863":
    case "_encstr_840F0BACF038D87B2359C2E81A":
    case "_encstr_B6DD0A9958C6C691AC584743":
    case "_encstr_84D00BF04583C8D0AA673BE9AB":
    case "_encstr_AD75063D571AE108":
      var_2 = 1.0;
      break;
    default:
      var_2 = 0.3;
      break;
  }

  if(isDefined(var_1) && randomint(100) > var_1) {
    return;
  }
  var_3 = undefined;
  var_4 = "_encstr_B4F309CE95E695E4968DFA";
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    switch (self.battlechatter.npcid) {
      case "_encstr_BE190458C8B5":
      case "_encstr_B119044DE338":
      case "_encstr_A7190410BAF2":
      case "_encstr_8D19046DCDA1":
      case "_encstr_A61904136240":
      case "_encstr_8719049B63D1":
      case "_encstr_AA180456470D":
        var_5 = self.battlechatter.npcid;
        var_4 = "_encstr_AC4606137F03FFF6";
        var_6 = 1;
        break;
    }
  }

  if(!isDefined(var_5)) {
    switch (self.voice) {
      case "_encstr_841804CCB9B0":
      case "_encstr_81190403AE66":
      case "_encstr_8BD90D13804B3C120DDFE3AFC9A53B":
      case "_encstr_BAA814DBED11D8CDC2335371075A8058B88760505754":
      case "_encstr_8A390E2F88D07452C1384E0393EFDA3B":
        var_5 = "_encstr_ACFC091AE8AB2FCBE15119";
        var_6 = anim.numfriendlyvoices;
        break;
      case "_encstr_8A500F91A5B1C8FDDA631B2D7F224F687D":
      case "_encstr_92430EC555C280A397EAC951226FE9F8":
      case "_encstr_A1440A8C62AA7519DD2FC0B0":
      case "_encstr_978D0A1B20CFBFB7B0A77C6D":
      case "_encstr_A67A134BD0ABF37F08D74C21A17882F3C528826219":
      case "_encstr_AF5E14AB37A5A3AC237316E82DB737B96659AD851B95":
        var_5 = "_encstr_ACFC091AE8AB2FCBE15119";
        var_4 = "_encstr_8FE807F368310F1569";
        var_6 = anim.numfriendlyfemalevoices;
        break;
      case "_encstr_9B07038DB1":
        var_5 = "_encstr_9B07038DB1";
        var_6 = 1;
        break;
      default:
        var_5 = "_encstr_88BF06FD784A6393";
        var_6 = anim.numenemyvoices;
    }
  }

  var_3 = 1 + self getentitynumber() % var_6;
  var_5 = var_5 + "_encstr_BA4C02DF" + var_3;
  var_7 = undefined;

  if(!isDefined(var_7)) {
    if(isDefined(self.generic_voice_override))
      var_7 = self.generic_voice_override + "_encstr_BA4C02DF" + var_0 + "_encstr_BA4C02DF" + var_5;
    else
      var_7 = var_4 + var_0 + "_encstr_BA4C02DF" + var_5;

    if(!soundexists(var_7))
      var_7 = "_encstr_B4F309CE95E695E4968DFA" + var_0 + "_encstr_BA4C02DF" + var_5;
  }

  if(getdvarint("_encstr_83C8191B42BBC0E8FA0985B917277897ABFA11438AB707C0D41987", 1)) {}

  thread playfacethread(var_7, undefined);
}

sayspecificdialogue(var_0, var_1) {
  thread playfacethread(var_0, var_1);
}

playfacethread(var_0, var_1) {
  if(isai(self)) {
    self.a.facialanimdone = 1;
    self.a.facialsounddone = 1;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      playfacesound(var_0, "_encstr_95621558372DADCD364E96833A10CC16C6B2E6F65D9B91" + var_1, 1);
      thread waitforfacesound(var_1);
    }
  } else
    playfacesound(var_0);
}

playfacesound(var_0, var_1, var_2) {
  if(isai(self))
    self[[anim.callbacks["_encstr_B2A216D049519FA2AFC0821A59A1AB9789AC409D533963B3"]]](var_0, var_1, var_2);
  else if(isDefined(var_1) && isDefined(var_2))
    self playSound(var_0, var_1, var_2);
  else if(isDefined(var_1))
    self playSound(var_0, var_1);
  else
    self playSound(var_0);
}

waitforfacesound(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_95621558372DADCD364E96833A10CC16C6B2E6F65D9B91" + var_0);
  self notify(var_0);
}

initlevelface() {
  anim.numenemyvoices = 7;
  anim.numfriendlyvoices = 7;
  anim.numfriendlyfemalevoices = 3;
  initfacialanims();
}

initfacialanims() {
  anim.facial = [];
}

animhasfacialoverride(var_0) {
  return animhasnotetrack(var_0, "_encstr_B20710E6CF11DF2EA991923B78ADA297A9A5");
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
#using_animtree("_encstr_B40101");

playfacialanim(var_0, var_1, var_2) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims)
    self aiclearanim(%_encstr_81CC0586952C91, 0.2);
  else {
    if(isDefined(var_0) && animhasfacialoverride(var_0)) {
      self aiclearanim(%_encstr_81CC0586952C91, 0.2);
      return;
    }

    if(!isDefined(anim.facial[var_1])) {
      return;
    }
    if(isDefined(var_2) && var_2 >= 0 && var_2 < anim.facial[var_1].size)
      var_3 = var_2;
    else
      var_3 = randomint(anim.facial[var_1].size);

    var_4 = anim.facial[var_1][var_3];
    self setanimknob(var_4);
  }
}