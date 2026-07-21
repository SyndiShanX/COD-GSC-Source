/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tac_ops_map.gsc
***********************************************/

init() {
  if(level.gametype != "_encstr_A53E0883E976B715503F" && getsubstr(scripts\mp\utility\game::getgametype(), 0, 3) != "_encstr_921904F9DFA1") {
    return;
  }
  level.tacopsmap = spawnStruct();
  var_0 = level.tacopsmap;
  var_0.mapconfigs = [];
  var_0.activeconfigs = [];
  var_0.globalspawnareas = [];
  var_0.globalspawnareas["_encstr_9A8507BA4040188D08"] = [];
  var_0.globalspawnareas["_encstr_8E8405EA382B2A"] = [];
  setupconfigentities();
  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
  level._effect["_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9"] = loadfx("_encstr_99452E086F5158BE68AB4DBF6060FAEC0617407163328FFB6AD87A1FF05101E3028A6A5F5B7FB7C8DF603563D284C883");
  level._effect["_encstr_92901389CBAB79F5D84E615738AB8B589067B4EA88"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
}

createmapconfig(var_0, var_1) {
  var_2 = level.tacopsmap;
  var_2.mapconfigs[var_0] = var_1;
  var_1.ref = var_0;
  var_1.spawnareas = [];
  var_1.spawnareas["_encstr_9A8507BA4040188D08"] = [];
  var_1.spawnareas["_encstr_8E8405EA382B2A"] = [];
  var_1.mappositions = [];
  var_1.mappositions["_encstr_9A8507BA4040188D08"] = [];
  var_1.mappositions["_encstr_8E8405EA382B2A"] = [];
  return var_1;
}

mapconfigexists(var_0) {
  return isDefined(level.tacopsmap) && isDefined(level.tacopsmap.mapconfigs[var_0]);
}

setactivemapconfig(var_0, var_1) {
  if(!mapconfigexists(var_0)) {
    clearactivemapconfigs();
    return;
  }

  if(isDefined(level.tacopsmap.activeconfigs[var_1]) && level.tacopsmap.mapconfigs[var_0] == level.tacopsmap.activeconfigs[var_1]) {
    return;
  }
  level.tacopsmap.activeconfigs[var_1] = level.tacopsmap.mapconfigs[var_0];
  level notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

getactivemapconfig(var_0) {
  return level.tacopsmap.activeconfigs[self.team];
}

clearactivemapconfigs() {
  level.tacopsmap.activeconfigs = [];
  level notify("_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08");
}

setteammapposition(var_0, var_1, var_2) {
  if(!mapconfigexists(var_0))
    createmapconfig(var_0);

  var_3 = level.tacopsmap.mapconfigs[var_0];
  var_3.mappositions[var_1] = var_2;
}

initspawnarea(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("_encstr_BD4A1A7AA33863EEA07FA7A03F19B57F3FFE133369ECD3A2E26FB3AE", 0, var_2);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.anchorentity = var_4;
  var_1.typeid = var_3;
  var_1.typeref = var_2;
  var_1.team = var_0;
  var_1.enabled = 1;

  if(isDefined(var_1.dynamicent))
    var_4 linkTo(var_1.dynamicent);
  else if(isDefined(var_1.target))
    var_1.areatriggers = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

addspawnareatoconfig(var_0, var_1, var_2, var_3) {
  if(!mapconfigexists(var_0))
    createmapconfig(var_0);

  var_4 = level.tacopsmap.mapconfigs[var_0];
  initspawnarea(var_1, var_2, var_3);
  var_4.spawnareas[var_1][var_4.spawnareas[var_1].size] = var_2;
}

addglobalspawnarea(var_0, var_1, var_2, var_3) {
  var_4 = level.tacopsmap;
  initspawnarea(var_1, var_2, var_3);
  var_4.globalspawnareas[var_1][var_0] = var_2;
}

removeglobalspawnarea(var_0, var_1) {
  level.tacopsmap.globalspawnareas[var_1][var_0] = undefined;
  level notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

refreshplayerspawnareaomnvars() {
  var_0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var_0)) {
    for(var_1 = 0; var_1 < 8; var_1++) {
      self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_1, undefined);
      self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_1, -1);
    }
  }

  var_2 = level.tacopsmap.globalspawnareas[self.team].size;
  var_3 = var_0.spawnareas[self.team].size + var_2;
  var_4 = 0;

  foreach(var_6 in level.tacopsmap.globalspawnareas[self.team]) {
    self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_4, var_6.anchorentity);
    self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_4, var_6.typeid);
    var_4++;
  }

  for(var_1 = 0; var_1 < var_0.spawnareas[self.team].size; var_1++) {
    var_8 = var_0.spawnareas[self.team][var_1];

    if(istrue(var_8.enabled)) {
      self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_4, var_8.anchorentity);
      self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_4, var_8.typeid);
      var_4++;
    }
  }

  for(var_1 = var_4; var_1 < 8; var_1++) {
    self setclientomnvar("_encstr_963615BD2A187BA0A88E9FABD17FF0A0EAD543C07BB871" + var_1, undefined);
    self setclientomnvar("_encstr_A3CB110B70F0B3BD6BCF0BF04B2805D7034921" + var_1, -1);
  }
}

waitforspawnselection() {
  if(isai(self)) {
    return;
  }
  var_0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var_0)) {
    return;
  }
  waitframe();
  runtacopsmap(var_0);
}

runtacopsmap(var_0) {
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.5;
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getvieworigin());
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.angles = self getplayerangles();
  self.tacopsmapcameraent = var_1;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  var_1 movecameratomappos(var_0.mappositions[self.team].origin, var_0.mappositions[self.team].angles, self);
  self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 1);
  refreshplayerspawnareaomnvars();
  self.deathspectatepos = var_0.mappositions[self.team].origin;
  self.deathspectateangles = var_0.mappositions[self.team].angles;
  showteamicons();
  var_2 = var_0;

  for(;;) {
    var_3 = watchendconditions();
    var_4 = 1;

    switch (var_3) {
      case "_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA":
        thread clearselectedareaonspawn();
        thread runslamzoomonspawn();
        var_4 = 1;
        closetacopsmap();
        break;
      case "_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F":
        self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 0);
        var_2 = level.tacopsmap.activeconfigs[self.team];
        var_1 movecameratomappos(var_2.mappositions[self.team].origin, var_2.mappositions[self.team].angles);
        self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 1);
        refreshplayerspawnareaomnvars();
        var_4 = 0;
        break;
      case "_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08":
        var_4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527":
        var_4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546":
        var_4 = 0;
        closetacopsmap();
        stopcamera();
        break;
      default:
        break;
    }

    if(var_4)
      return;
  }
}

watchendconditions() {
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  var_0 = scripts\engine\utility::_id_143B7("_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA", "_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F", "_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546");
  self notify("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  return var_0;
}

endconditionwatcher_selectionmade() {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_B49C247D558A4F28AE2BF80807F7402F627BE6736F03AF978D6390B85B19B8E5C8A6ED0D94EE");
  self endon("_encstr_B49C247D558A4F28AE2BF80807F7402F627BE6736F03AF978D6390B85B19B8E5C8A6ED0D94EE");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_BE081CE34FC7F167038867EFA81937AAE7D7EADF27178BB568D09FFB68D1") {
      var_2 = undefined;
      var_3 = level.tacopsmap.activeconfigs[self.team];

      foreach(var_5 in var_3.spawnareas[self.team]) {
        if(var_1 == var_5.anchorentity getentitynumber()) {
          var_2 = var_5;
          break;
        }
      }

      if(!isDefined(var_2)) {
        foreach(var_5 in level.tacopsmap.globalspawnareas[self.team]) {
          if(var_1 == var_5.anchorentity getentitynumber()) {
            var_2 = var_5;
            break;
          }
        }
      }

      self.tacopsmapselectedarea = var_2;
      self notify("_encstr_A9A11B8E0B6CAFBDE0E6AFDAB01CAF9B568DB2B18E967B73AFDAC219CA");
      break;
    }
  }
}

endconditionwatcher_gameended() {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_965320B2CD23A1B7E623D21DA5DBE6BAC21DD8865693D7D12CAD592AB9465919A025");
  self endon("_encstr_965320B2CD23A1B7E623D21DA5DBE6BAC21DD8865693D7D12CAD592AB9465919A025");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8B4D178EB036EBF61C377DB51683F57685D6B27DACB9C89546");
}

endconditionwatcher_mapcleared() {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_A5CA21E3D860872782CB68D547EF287F21FB1BEBE7AB28EC96371E1C8AF7DA57CBDE4E");
  self endon("_encstr_A5CA21E3D860872782CB68D547EF287F21FB1BEBE7AB28EC96371E1C8AF7DA57CBDE4E");
  level waittill("_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08");
  self notify("_encstr_A69C146C47CBCF55CBDFD81F7F1786B6A1B1AFFBEA08");
}

endconditionwatcher_mapchanged() {
  self endon("_encstr_BD711A0B61FE2F8DD8873715A5A05917107882426B43B785C993050C");
  self notify("_encstr_A799216D459A5F38BE5B881817C7503F926BD6631F139FA49923D1F01FEE89836A047B");
  self endon("_encstr_A799216D459A5F38BE5B881817C7503F926BD6631F139FA49923D1F01FEE89836A047B");
  level waittill("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
  self notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

showteamicons() {
  if(!isDefined(level.runtacopsshowteamicons))
    level.runtacopsshowteamicons = [];

  if(scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8")) {
    var_0 = 0;
    level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()] = [];

    foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
      if(var_2 == self) {
        continue;
      }
      var_3 = var_2.origin;
      var_4 = newclienthudelem(self);
      var_4.x = var_3[0];
      var_4.y = var_3[1];
      var_4.z = var_3[2] + 32;
      var_4.alpha = 1.0;
      var_4.archived = 0;
      var_4.showinkillcam = 0;

      if(level.splitscreen)
        var_4 setshader("_encstr_AB031BA37653480F0B3FAFB1E7235550EC41CBB89CBD88CDE1A399B3E7", 10, 10);
      else
        var_4 setshader("_encstr_AB031BA37653480F0B3FAFB1E7235550EC41CBB89CBD88CDE1A399B3E7", 5, 5);

      var_4 setwaypoint(0);
      var_4 settargetEnt(var_2);
      level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()][var_0] = var_4;
      var_0++;
    }
  }
}

cleanupteamicons() {
  foreach(var_1 in level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()])
  var_1 destroy();

  level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()] = undefined;
}

closetacopsmap() {
  self setclientomnvar("_encstr_979A14CD6B41A347762622DB8B404F5E909F5F309B10", 0);
  cleanupteamicons();
}

stopcamera() {
  self cameraunlink();
  self.tacopsmapcameraent delete();
  self.tacopsmapcameraent = undefined;
  self.isusingtacopsmapcamera = undefined;
}

clearselectedareaonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self.tacopsmapselectedarea = undefined;
}

runslamzoomonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.tacopsmapcameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  self.tacopsmapcameraent moveTo(var_0, 0.5);
  self.tacopsmapcameraent rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("_encstr_B40101", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
  stopcamera();
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

movecameratomappos(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_0, 1.0, 0.5, 0.5);
  self rotateTo(var_1, 1.0, 0.5, 0.5);
  var_2 thread startoperatorsound();
  wait 1.1;
}

setupconfigentities() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7B213D1BF0A90383892BEF03E708136621B7D134F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(var_3 == "_encstr_812E0B43158F7060FA533B1913")
      var_3 = "_encstr_9B61099C371176434373A3";

    createmapconfig(var_3, var_2);
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "_encstr_AA5015B35A81BBC7887FA529B7AD727B51B645201F08BB":
          addspawnareatoconfig(var_3, "_encstr_9A8507BA4040188D08", var_6, var_6.script_noteworthy);
          break;
        case "_encstr_A6A4138EB7FA9BE00BBBCDF5C23995857DC2C32DB9":
          addspawnareatoconfig(var_3, "_encstr_8E8405EA382B2A", var_6, var_6.script_noteworthy);
          break;
        case "_encstr_A11E11297F3177A8BC8C718B399B08B94AE3FB":
          setteammapposition(var_3, "_encstr_9A8507BA4040188D08", var_6);
          break;
        case "_encstr_8C500F3ADBFAC2F02DB9EB6CB0DACA39B0":
          setteammapposition(var_3, "_encstr_8E8405EA382B2A", var_6);
          break;
      }
    }
  }
}

setupspawnareas() {
  var_0 = level.tacopsmap;

  foreach(var_2 in var_0.mapconfigs) {
    foreach(var_4 in var_2.spawnareas) {
      foreach(var_6 in var_4) {
        var_6.spawnlist = [];

        foreach(var_8 in level.spawnpoints) {
          foreach(var_10 in var_6.areatriggers) {
            if(ispointinvolume(var_8.origin, var_10)) {
              var_6.spawnlist[var_8.index] = var_8;
              break;
            }
          }
        }
      }
    }
  }
}

filterspawnpoints(var_0, var_1) {
  if(isDefined(self.tacopsmapselectedarea)) {
    var_2 = [];

    foreach(var_4 in var_0) {
      if(isDefined(self.tacopsmapselectedarea.spawnlist) && isDefined(self.tacopsmapselectedarea.spawnlist[var_4.index]))
        var_2[var_2.size] = var_4;
    }

    return var_2;
  }

  return var_0;
}

adddynamicspawnarea(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_1.origin;
  var_4.dynamicent = var_1;
  var_4.script_noteworthy = var_3;
  var_4.areatriggers = [];
  addspawnareatoconfig(var_0, var_2, var_4, var_3);
}

startoperatorsound() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_0 showonlytoplayer(self);
  self setsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
  var_1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  var_2 = "_encstr_84690847F92EFD1AD01F" + var_1 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";

  if(soundexists(var_2))
    var_0 playLoopSound(var_2);
  else
    var_0 playLoopSound("_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043");

  self.spawnselectionoperatorsound = 1;
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
  var_0 stoploopsound(var_2);
  var_0 delete();
  self.spawnselectionoperatorsound = 0;
}