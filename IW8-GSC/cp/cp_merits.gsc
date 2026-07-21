/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_merits.gsc
***********************************************/

init() {
  precachestring(&"_encstr_BAB7137FA821994DA370573EF8FF11298DD529FB24");

  if(!mayprocessmerits()) {
    return;
  }
  level.meritcallbacks = [];
  registermeritcallback("_encstr_B8280CF2D06BC57FFC3BE4ECC5E1", ::mt_kills);
  level thread onplayerconnect();
}

mayprocessmerits() {
  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isDefined(var_0.pers["_encstr_8D040F1CDBCDA31D58B69553CA274BE8DC"]))
      var_0.pers["_encstr_8D040F1CDBCDA31D58B69553CA274BE8DC"] = 0;

    var_0 thread initmeritdata();

    if(isai(var_0)) {
      continue;
    }
    var_0 thread monitoradstime();
  }
}

initmeritdata() {
  self.pers["_encstr_B41C1363859BE812D51B639547B45A1B1B152DADB2"] = 0;
  self.pers["_encstr_A3E90D5AF8980A358B475340F59F60"] = 0;
  self.explosiveinfo = [];
}

registermeritcallback(var_0, var_1) {
  if(!isDefined(level.meritcallbacks[var_0]))
    level.meritcallbacks[var_0] = [];

  level.meritcallbacks[var_0][level.meritcallbacks[var_0].size] = var_1;
}

getmeritstatus(var_0) {
  if(isDefined(self.meritdata[var_0]))
    return self.meritdata[var_0];
  else
    return 0;
}

mt_kills(var_0, var_1) {
  var_2 = var_0.attacker;
  var_3 = var_0.victim;

  if(!isDefined(var_2) || !isPlayer(var_2)) {
    return;
  }
  var_2 processmerit("_encstr_A9B709B6D1F5AD961BD8CD");
}

enemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_8 = spawnStruct();
  var_8.victim = self;
  var_8.einflictor = var_0;
  var_8.attacker = var_1;
  var_8.idamage = var_2;
  var_8.smeansofdeath = var_3;
  var_8.sweapon = var_4;
  var_8.sprimaryweapon = var_5;
  var_8.shitloc = var_6;
  var_8.time = gettime();
  var_8.modifiers = var_7;
  var_8.victimonground = var_8.victim isonground();
  domeritcallback("_encstr_B8280CF2D06BC57FFC3BE4ECC5E1", var_8);
  var_8.attacker notify("_encstr_81051C0E1BC2BC59932D5A8D8DB291A659275A47DC4127DED895E66EB246");
}

domeritcallback(var_0, var_1) {
  if(!mayprocessmerits()) {
    return;
  }
  if(isDefined(var_1)) {
    var_2 = var_1.player;

    if(!isDefined(var_2))
      var_2 = var_1.attacker;

    if(isDefined(var_2) && isai(var_2))
      return;
  }

  if(getdvarint("_encstr_B4500FCFF848B1EAF10BC70763A602FCE0") > 0) {
    return;
  }
  if(!isDefined(level.meritcallbacks[var_0])) {
    return;
  }
  if(isDefined(var_1)) {
    for(var_3 = 0; var_3 < level.meritcallbacks[var_0].size; var_3++)
      thread[[level.meritcallbacks[var_0][var_3]]](var_1);
  } else {
    for(var_3 = 0; var_3 < level.meritcallbacks[var_0].size; var_3++)
      thread[[level.meritcallbacks[var_0][var_3]]]();
  }
}

process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1 = var_1.owner;
    else
      return;
  }

  var_9 = scripts\cp\utility::getweaponclass(var_4);
  var_10 = istrue(var_1.inlaststand);
  var_11 = scripts\engine\utility::isbulletdamage(var_3);
  var_12 = var_1 getstance();
  var_13 = self.species;
  var_14 = var_12 == "_encstr_B13D076BED70539F23";
  var_15 = var_12 == "_encstr_922406F1A6FD5E05" && !var_10;
  var_16 = isexplosivedamagemod(var_3);
  var_17 = var_3 == "_encstr_8DED0A21C79B660BC7588981";
  var_18 = (istrue(self.is_burning) || istrue(self.is_chem_burning)) && (!var_11 || var_4.basename == "_encstr_820C138A68F01BCA4484A8CA5AB9B1C23DE2B185B0");
  var_19 = istrue(self.dismember_crawl);
  var_20 = istrue(self.shockmelee);
  var_21 = var_1 issprintsliding();
  var_22 = istrue(self.faf_burned_out);

  if(isDefined(var_0.owner))
    var_23 = var_1 scripts\cp\utility::is_trap(var_0, var_4) && var_0.owner == var_1;
  else
    var_23 = var_1 scripts\cp\utility::is_trap(var_0, var_4);

  var_24 = 0;

  if(isDefined(level.all_magic_weapons)) {
    foreach(var_26 in getarraykeys(level.all_magic_weapons)) {
      if(scripts\cp\utility::getrawbaseweaponname(var_4) == var_26) {
        var_24 = 1;
        break;
      }
    }
  }

  var_28 = isDefined(var_4) && (var_4.basename == "_encstr_96BD15E8B31E1098ECC36F71F712A045BF8AE012D9F3B1" || var_4.basename == "_encstr_847F1724C4EF71EEA1880F178038B49A3DD5AB5DA1DBC92AC8" || var_4.basename == "_encstr_A6B2170320AE89A34083FC3A2DB1B0054D9F73BD58E9D9528A" || var_4.basename == "_encstr_92981596BB9BAF6EA127591946952719D5B6B597F5F4B5");
  var_29 = undefined;

  if(isDefined(var_4))
    var_29 = scripts\cp\utility::getrawbaseweaponname(var_4);

  var_30 = isDefined(var_29) && (var_29 == "_encstr_A7010918FF7DEB97F2BAEF" || var_29 == "_encstr_AB0109207642B080CAFB2D" || var_29 == "_encstr_990109104652A090DA8B5F" || var_29 == "_encstr_9B010963FFB8C82DEF483B");

  if(var_24) {
    if(issubstr(var_4.basename, "_encstr_9671052732BA9F"))
      var_24 = isDefined(var_1.has_replaced_starting_pistol);
  }

  if(var_16) {
    if(issubstr(var_4.basename, "_encstr_83B309037405E0C3CA1755"))
      var_16 = 0;
    else if(istrue(var_1.kung_fu_mode))
      var_16 = 0;
  }

  var_31 = var_4.classname == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" && var_11;
  var_32 = var_11 && scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1);

  if(!var_17) {
    switch (var_9) {
      case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        var_1 processmerit("_encstr_8F280CC88D993B1AF0C8B86BC0CF");
        break;
      case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        var_1 processmerit("_encstr_9A340DF0DB49470837EF020BA463B3");
        break;
      case "_encstr_A3710BEEACC2E0B737EB36B676":
        var_1 processmerit("_encstr_B2420D421B382BC59817DBD119A80A");
        break;
      case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        var_1 processmerit("_encstr_A1D0115BE8F5CD0DB78E3BBA73EBB5B4C68DDC");
        break;
      case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
        var_1 processmerit("_encstr_8F5F107D093F5F2A53CAD9FA081F7424F8F3");
        break;
      case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
        var_1 processmerit("_encstr_8D4D10B5D1D7079637A3B7D8D7DAB48D366E");
        break;
      case "_encstr_8261067B1D34AC27":
        if(var_28)
          var_1 processmerit("_encstr_8D4D10B5D1D7079637A3B7D8D7DAB48D366E");

        break;
      default:
        break;
    }
  }

  switch (var_13) {
    case "_encstr_BACB074025B01AAA28":
      var_1 processmerit("_encstr_A77310DFC8860A82A34EDCD738773AD44848");
      break;
    default:
      break;
  }

  if(var_16)
    var_1 processmerit("_encstr_859213DDBD37DAE89BF81F67F873AD21375BE515A6");

  if(var_17)
    var_1 processmerit("_encstr_AFB10FD6A3EBADCAD8CA2BAF5BA5B1D8B9");

  if(var_18)
    var_1 processmerit("_encstr_82130EAD8EEB33A53959EBB5A5C61B6E");

  if(var_23)
    var_1 processmerit("_encstr_A9DC0E5D3DB74B6239985F8778B02463");

  if(var_24)
    var_1 processmerit("_encstr_88D316AD47AFD6C2D92DB1EBEEB2C21CBD9BFAB54B36369B");

  if(var_32)
    var_1 processmerit("_encstr_AACC12DAD1BE43590B196E1AEDD1FA5B2DC6C6CD");

  if(var_19)
    var_1 processmerit("_encstr_B1A81107C8D0B2C3FEB84B63084FC8A340238B");

  if(var_20)
    var_1 processmerit("_encstr_8CA71962B8BEA14E9CE048213FB8905FD2CF95DFBF712768E1B173");

  if(var_21)
    var_1 processmerit("_encstr_AC4A112F3876D3627B9DEC25746F6A817860DF");

  if(var_28 || var_30)
    var_1 processmerit("_encstr_8CA61662B8BE434B1DF6704F2788C070F2E3595CBC4229B8");

  if(var_22 && var_18)
    var_1 processmerit("_encstr_AF3C18A12CC733AF8E1710B8856B079C86B2475889A0F39AD2E3");

  var_33 = var_4.basename;

  if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_B88808122B88E37680F3") {
    if(isDefined(self.agent_type) && self.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758")
      var_1 processmerit("_encstr_8E76181833A1B1F00FB9202EC1679B2B969BF0B8F9C4E3C8EB03");

    if(var_17) {
      if(var_33 == "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB" || var_33 == "_encstr_A3E41651E8423934E8A01129F319903938A8578ECA78FB57" || var_33 == "_encstr_ACE4169CA31B29A8B758789E0BEB73CDFFDDCBF741BE386B")
        var_1 processmerit("_encstr_B88D13D8330F5D08BE51E79F27253388B79A7060EB");
      else if(var_33 == "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B" || var_33 == "_encstr_A260173B7BA757BB8BC3FA5F25E7CA88B47FFBC0D0594152EF" || var_33 == "_encstr_B66017FF97A31F0668C7CAFF2D893A01988F0201F9E8CF5002")
        var_1 processmerit("_encstr_A73312F8E0174358B32E8132E354CF942422FAE6");
      else if(var_33 == "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0" || var_33 == "_encstr_AB9E1480DB7608C8C6FB4143F42F91E993B13B0913C6" || var_33 == "_encstr_999E14192747A11198CFCB0703B75FFD0FF1B846A38F")
        var_1 processmerit("_encstr_8E8D168FD198725C3003C94D211890BAE51BBF1F73B9BA1B");
      else if(var_33 == "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078" || var_33 == "_encstr_851C1BA9B7941788A70AD15A224188FD5820A1BA4FBF6B1FBF87473AC1" || var_33 == "_encstr_B21C1BD2EECDEB3ADDF6F51A2B58469519AF161ECABEDAC1F583581C91")
        var_1 processmerit("_encstr_97FB12B53AEB2363C689BE0BE1B2D7B65A1BC6B9");
      else if(var_33 == "_encstr_AD6511C90447F13AC1A04E13B7B7EF8A97D35D")
        var_1 processmerit("_encstr_BD2618F01B2765309679FFE151FB68B9BF83499B311F2BE86D13");
    }

    if(issubstr(var_33, "_encstr_83BF0820F70B83E5E740"))
      var_1 processmerit("_encstr_A62416B63ABEC8638D26AF0DC239E0F6B7DCFA5BA5C6C6DC");

    if(istrue(var_1.rave_mode))
      var_1 processmerit("_encstr_AAF216DF18DFE855D3A279C22020C04BF898D8FE5B96BB6B");
  }

  if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_8B1309EB697197372EF152") {
    if(var_33 == "_encstr_AA1E1B08FB1FD19A22EB8395D7A95A18DF92B1A332FBF847DA9F5D35A2" || var_33 == "_encstr_96F41823EF467677FEEBB8C8D21937C84B643CA842CFF9D7E042")
      var_1 processmerit("_encstr_A6B51407105EDC7A07DE19CA6F09D75F6010FBBF3871");
    else if(var_33 == "_encstr_88F71EF477961963AB6D0E4AE5438F9097DA83B9F3D8AB05CCEACF6F9F82F2F2")
      var_1 processmerit("_encstr_AFED179DD5067BFD274A21CBC85922DF583D160B63EBBFC4EF");
    else if(var_33 == "_encstr_A7D909630B0F9BCC49C1BA")
      var_1 processmerit("_encstr_ACCC146BA3F5328DD819EB86560B93D1BEB6B41B36B9");

    if(isDefined(self.agent_type) && self.agent_type == "_encstr_824C070F170FFBDD20")
      var_1 processmerit("_encstr_83EE1787D9806A44385BC192E8989CB2EE7777075BBD2212D0");

    if(var_23)
      var_1 processmerit("_encstr_AAC6135B47AFC8C61B8CD7A39C8507BEDAB41BB1CD");
    else if(istrue(var_1.kung_fu_mode) && !is_crafted_trap_damage(var_33)) {
      if(var_1.kungfu_style == "_encstr_88A2075FC3DFCFD5AA")
        var_1 processmerit("_encstr_A581152D4DC73AECE91AEF0B3081DF320D7034A439F903");
      else if(var_1.kungfu_style == "_encstr_939E06176861F83F")
        var_1 processmerit("_encstr_8B1814FFE8A634929F46B1B64E436AFD4EE86763809B");
      else if(var_1.kungfu_style == "_encstr_BA5906B9B9586D2B")
        var_1 processmerit("_encstr_B64B14B25837686257A5DFFE301BBCB717C834025D43");
      else if(var_1.kungfu_style == "_encstr_936C06E8A5B35639")
        var_1 processmerit("_encstr_85B2146DBBC954EA964567C3DB4CA29A21A0E4B51010");
    }
  }
}

is_crafted_trap_damage(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_8BFF1A72E8D3FFF5899FE5E67908F8CF09E03A7A11B59BE1EADF15E0":
    case "_encstr_8EC510377F1479FAF831AD732A5020B10AF3":
    case "_encstr_B87017C55DB6D11E9F3AF883033358B08FAB517BF4DF89E98B":
    case "_encstr_820C138A68F01BCA4484A8CA5AB9B1C23DE2B185B0":
    case "_encstr_97BF14B477B9D7951B95D88E9396B11D27851CEBD3D6":
      return 1;
  }

  return 0;
}

processmerit(var_0, var_1, var_2) {
  if(!mayprocessmerits()) {
    return;
  }
  if(!isPlayer(self) || isai(self)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  if(!havedataformerit(var_0)) {
    return;
  }
  var_3 = getmeritstatus(var_0);

  if(var_3 == 5) {
    return;
  }
  var_4 = isDefined(level.meritinfo[var_0]["_encstr_BA5B0AF6E02BE4853A4BBD73"]);

  if(var_3 > level.meritinfo[var_0]["_encstr_92BF0A78CA422F493B8647C9"].size) {
    var_5 = var_3 == level.meritinfo[var_0]["_encstr_92BF0A78CA422F493B8647C9"].size + 1;
    var_6 = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[var_0]);

    if(var_5 && !var_6)
      var_3 = level.meritinfo[var_0]["_encstr_92BF0A78CA422F493B8647C9"].size;
    else
      return;
  }

  var_7 = scripts\cp\cp_hud_util::mt_getprogress(var_0);
  var_8 = level.meritinfo[var_0]["_encstr_92BF0A78CA422F493B8647C9"][var_3];

  if(!isDefined(var_8)) {
    return;
  }
  if(isDefined(var_2) && var_2)
    var_9 = var_1;
  else
    var_9 = var_7 + var_1;

  var_10 = 0;

  if(var_9 >= var_8) {
    var_11 = 1;
    var_10 = var_9 - var_8;
    var_9 = var_8;
  } else
    var_11 = 0;

  if(var_7 < var_9)
    scripts\cp\cp_hud_util::mt_setprogress(var_0, var_9);

  if(var_11) {
    thread giverankxpafterwait(var_0, var_3);
    storecompletedmerit(var_0);
    givemeritscore(level.meritinfo[var_0]["_encstr_82FB06EB26785BD7"][var_3]);
    var_3++;
    scripts\cp\cp_hud_util::mt_setstate(var_0, var_3);
    self.meritdata[var_0] = var_3;
    thread scripts\cp\cp_hud_message::showchallengesplash(var_0);

    if(areallmerittierscomplete(var_0))
      processmastermerit(var_0);
  }
}

areallmerittierscomplete(var_0) {
  if(self.meritdata[var_0] >= level.meritinfo[var_0]["_encstr_92BF0A78CA422F493B8647C9"].size)
    return 1;

  return 0;
}

get_table_name() {
  return "_encstr_820613E0612536534983E7C92977FDB145A6AB43C4";
}

storecompletedmerit(var_0) {
  if(!isDefined(self.meritscompleted))
    self.meritscompleted = [];

  var_1 = 0;

  foreach(var_3 in self.meritscompleted) {
    if(var_3 == var_0)
      var_1 = 1;
  }

  if(!var_1)
    self.meritscompleted[self.meritscompleted.size] = var_0;
}

storecompletedoperation(var_0) {
  if(!isDefined(self.operationscompleted))
    self.operationscompleted = [];

  var_1 = 0;

  foreach(var_3 in self.operationscompleted) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  if(!var_1)
    self.operationscompleted[self.operationscompleted.size] = var_0;
}

giverankxpafterwait(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[var_0]["_encstr_8F9F07D3D81FB62369"][var_1]));
  scripts\cp\drone\emp_drone::giverankxp(var_0, level.meritinfo[var_0]["_encstr_8F9F07D3D81FB62369"][var_1], undefined);
}

givemeritscore(var_0) {
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_9AED0F1BA97065333540E2CACF1E075AF8");

  if(isDefined(var_1))
    self setplayerdata("_encstr_850703B7D9", "_encstr_9AED0F1BA97065333540E2CACF1E075AF8", var_1 + var_0);
}

updatemerits() {
  self.meritdata = [];
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!mayprocessmerits()) {
    return;
  }
  var_0 = 0;

  foreach(var_5, var_2 in level.meritinfo) {
    var_0++;

    if(var_0 % 20 == 0)
      wait 0.05;

    self.meritdata[var_5] = 0;
    var_3 = var_2["_encstr_B48F06CC58B0F50B"];
    var_4 = scripts\cp\cp_hud_util::mt_getstate(var_5);
    self.meritdata[var_5] = var_4;
  }
}

getmeritfilter(var_0) {
  return tablelookup("_encstr_8BA91663972D52A002388D7A10990751690B050D3AE327BB", 0, var_0, 5);
}

isweaponmerit(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1))
    return 1;

  return 0;
}

getweaponfrommerit(var_0) {
  return getmeritfilter(var_0);
}

isoperationmerit(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = getmeritfilter(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "_encstr_AFA90CB20138C35126412F5B3F6F" || var_1 == "_encstr_8DA90C0A793382900764B7536F8A" || var_1 == "_encstr_A5A90CAB01961F612019A7A46772" || var_1 == "_encstr_812B0CC352BFE063EA47232D7793" || var_1 == "_encstr_BE8F0A272F9B2BE97268AE8B" || var_1 == "_encstr_8660126E0E95D8A52C63EB595CAEA50EAD2BB9E8" || var_1 == "_encstr_B19A0BD803A4E10F42E50598BB" || var_1 == "_encstr_A1ED09400BA5D351227715" || var_1 == "_encstr_ACCD0E334BE6B08DD7B52DC6C61B0BB5" || var_1 == "_encstr_BE82060380E3F9A2" || var_1 == "_encstr_93F90C435DB52DB12D583A2DB7DC" || var_1 == "_encstr_8CF50A1853FDF943BBDCC840" || var_1 == "_encstr_811F08C0C726E1953267" || var_1 == "_encstr_83AD06DDE1316B75" || var_1 == "_encstr_95D70D24486912E5A0B01F73E058AE" || var_1 == "_encstr_862B0B8567AB4309E338C73B10" || scripts\cp\utility::isstrstart(var_1, "_encstr_847F0DA4CB5942FB03930F27F0DB9F"))
      return 1;
  }

  if(isweaponmerit(var_0))
    return 1;

  return 0;
}

merit_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + var_2 * 3);
  return int(var_3);
}

merit_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 11 + var_2 * 3);
  return int(var_3);
}

merit_scoreval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 12 + var_2 * 3);
  return int(var_3);
}

buildmerittableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_2 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_2, 0);

    if(var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = getmeritmasterchallenge(var_4);
    level.meritinfo[var_4] = [];
    level.meritinfo[var_4]["_encstr_B48F06CC58B0F50B"] = var_2;
    level.meritinfo[var_4]["_encstr_81EF05D197C12B"] = var_1;
    level.meritinfo[var_4]["_encstr_92BF0A78CA422F493B8647C9"] = [];
    level.meritinfo[var_4]["_encstr_8F9F07D3D81FB62369"] = [];
    level.meritinfo[var_4]["_encstr_82FB06EB26785BD7"] = [];
    level.meritinfo[var_4]["_encstr_A9A80769FCC4081D93"] = getmeritfilter(var_4);
    level.meritinfo[var_4]["_encstr_8A20076B0B378E2B39"] = var_5;

    if(isoperationmerit(var_4)) {
      level.meritinfo[var_4]["_encstr_BA5B0AF6E02BE4853A4BBD73"] = 1;
      level.meritinfo[var_4]["_encstr_8C6809ABC38B0DBBEEC261"] = [];

      if(isweaponmerit(var_4)) {
        var_6 = getweaponfrommerit(var_4);

        if(isDefined(var_6))
          level.meritinfo[var_4]["_encstr_AC20072B9FA9487832"] = var_6;
      }
    }

    for(var_7 = 0; var_7 < 5; var_7++) {
      var_8 = merit_targetval(var_0, var_4, var_7);
      var_9 = merit_rewardval(var_0, var_4, var_7);
      var_10 = merit_scoreval(var_0, var_4, var_7);

      if(var_8 == 0) {
        break;
      }

      level.meritinfo[var_4]["_encstr_92BF0A78CA422F493B8647C9"][var_7] = var_8;
      level.meritinfo[var_4]["_encstr_8F9F07D3D81FB62369"][var_7] = var_9;
      level.meritinfo[var_4]["_encstr_82FB06EB26785BD7"][var_7] = var_10;
      var_3 = var_3 + var_9;
    }

    var_4 = tablelookupbyrow(var_0, var_2, 0);
    var_2++;
  }

  return int(var_3);
}

buildmeritinfo() {
  level.meritinfo = [];
  var_0 = 0;
  var_0 = var_0 + buildmerittableinfo("_encstr_8BA91663972D52A002388D7A10990751690B050D3AE327BB", 0);
}

ismeritunlocked(var_0) {
  var_1 = level.meritinfo[var_0]["_encstr_A9A80769FCC4081D93"];

  if(!isDefined(var_1))
    return 1;

  return self isitemunlocked(var_1, "_encstr_932E0A09FB023CC0DA8D7FFF");
}

havedataformerit(var_0) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var_0]);
}

getmeritmasterchallenge(var_0) {
  var_1 = tablelookup("_encstr_8BA91663972D52A002388D7A10990751690B050D3AE327BB", 0, var_0, 7);

  if(isDefined(var_1) && var_1 == "_encstr_B40101")
    return undefined;

  return var_1;
}

processmastermerit(var_0) {
  var_1 = level.meritinfo[var_0]["_encstr_8A20076B0B378E2B39"];

  if(isDefined(var_1))
    thread processmerit(var_1);
}

monitoradstime() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.adstime = 0.0;

  for(;;) {
    if(self playerads() == 1)
      self.adstime = self.adstime + 0.05;
    else
      self.adstime = 0.0;

    wait 0.05;
  }
}