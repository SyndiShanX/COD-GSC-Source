/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\airdrop_multiple.gsc
**************************************************/

airdrop_multiple_init() {
  level.cratedropdata.ac130s = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_88C5055208731B")]]();

  airdrop_multiple_initanimations();
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

airdrop_multiple_initanimations() {
  var_0 = "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417";
  var_1 = undefined;
  var_1 = "_encstr_A937066AFF52FA4F";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_A67E16E3F36FFAEE5BAB60535FC627785F4578FA684AF68A;
  level.scr_animname[var_1][var_0] = "_encstr_A67E16E3F36FFAEE5BAB60535FC627785F4578FA684AF68A";
  var_1 = "_encstr_8D160FA0AA220B2E0BB1666A896F51B75A";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_91F812B6C17D2BB04693BD83EB1B1CB576EB1813;
  level.scr_animname[var_1][var_0] = "_encstr_91F812B6C17D2BB04693BD83EB1B1CB576EB1813";
  var_1 = "_encstr_AF160F3832BAE3C6F3598EF231C7C9CFF2";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_93F8126B1C7DAC858C9CB70EAFC6E06DECAF0346;
  level.scr_animname[var_1][var_0] = "_encstr_93F8126B1C7DAC858C9CB70EAFC6E06DECAF0346";
  var_1 = "_encstr_9A160FD8852756BE0EB0B15BC2B359FA99";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_A3F812A328A99558794AB72BCF471BF067F7FA6E;
  level.scr_animname[var_1][var_0] = "_encstr_A3F812A328A99558794AB72BCF471BF067F7FA6E";
  var_1 = "_encstr_B4821506F148BD21F70B4F177314CACF98783B4BE9C911";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_9AC817B303B0FD2F4140E84B676291D60F01C31BBBFB577936;
  level.scr_animname[var_1][var_0] = "_encstr_9AC817B303B0FD2F4140E84B676291D60F01C31BBBFB577936";
  var_1 = "_encstr_B18215E07F8A594FEBBE6E6296B27346C33328D0F70F7B";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_BAC817F8E2216A2A2050C048385A77C273FB108DBCAFBF791A;
  level.scr_animname[var_1][var_0] = "_encstr_BAC817F8E2216A2A2050C048385A77C273FB108DBCAFBF791A";
  var_1 = "_encstr_A282151F98DBFD694117766C0F0782BF81B8DFCB2BD663";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % _encstr_A9C817C368C138BF9B2310FB19236758E6D3717BF437A15FFE;
  level.scr_animname[var_1][var_0] = "_encstr_A9C817C368C138BF9B2310FB19236758E6D3717BF437A15FFE";
}

airdrop_multiple_dropcrates(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level.cratedropdata.ac130s.size >= 2) {
    if(isDefined(var_0) && isDefined(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88D02667E3D104E7E1DAB5C7236955AFFB8BEF767025C71BBD758B984F87CAA13C3C71A96EA075BC");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59"))
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59")]](var_5.mpstreaksysteminfo, "_encstr_8261067B1D34AC27");
    }
  } else {
    var_6 = [];
    var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B4EB140F73A95AEB30C3DF2618910EA2E8E7F7A3C3CE");
    var_8 = 3;
    var_9 = undefined;

    if(isDefined(var_5.cratetype))
      var_7 = var_5.cratetype;

    if(isDefined(var_5.numcrates))
      var_8 = var_5.numcrates;

    if(isDefined(var_5.usephysics))
      var_9 = var_5.usephysics;

    for(var_10 = 0; var_10 < var_8; var_10++) {
      var_11 = undefined;

      if(var_6.size > 0)
        var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(var_6);
      else
        var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

      var_6[var_6.size] = var_11;
    }

    var_12 = airdrop_multiple_getcratedropcaststart(var_2);
    var_13 = var_3 * (0, 1, 0);

    if(isDefined(var_5.scenenodeoffset) && isvector(var_5.scenenodeoffset))
      var_12 = var_12 + var_5.scenenodeoffset;

    var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_12);
    var_14.angles = var_13;
    var_14 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_14.owner = var_0;
    var_14.team = var_1;
    var_14.hasowner = isDefined(var_0);
    var_14.latestanimendtime = -1;
    var_0 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
      thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_959F16A797DD2A376870CA570B4040D1A1E34B3B0BFF72C5", var_0);

    airdrop_multiple_createac130(var_14);
    var_14.crates = [];
    var_14.chutes = [];

    for(var_10 = 0; var_10 < var_8; var_10++) {
      var_15 = undefined;

      switch (var_10) {
        case 0:
          var_15 = "_encstr_8D160FA0AA220B2E0BB1666A896F51B75A";
          break;
        case 1:
          var_15 = "_encstr_AF160F3832BAE3C6F3598EF231C7C9CFF2";
          break;
        case 2:
          var_15 = "_encstr_9A160FD8852756BE0EB0B15BC2B359FA99";
          break;
      }

      var_16 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var_6[var_10], 0);
      var_17 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var_0, var_1, var_7, var_4, var_9, 0, var_16, var_5, var_14, var_15, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");

      if(!isDefined(var_17)) {
        break;
      }

      var_15 = undefined;

      switch (var_10) {
        case 0:
          var_15 = "_encstr_B4821506F148BD21F70B4F177314CACF98783B4BE9C911";
          break;
        case 1:
          var_15 = "_encstr_B18215E07F8A594FEBBE6E6296B27346C33328D0F70F7B";
          break;
        case 2:
          var_15 = "_encstr_A282151F98DBFD694117766C0F0782BF81B8DFCB2BD663";
          break;
      }

      if(isDefined(var_17)) {
        var_18 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var_14, var_17, var_15, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");
        var_18 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
      }
    }

    if(var_14.crates.size < var_8) {
      var_14 thread airdrop_multiple_watchdropcratesend();
      return undefined;
    }

    var_14 thread airdrop_multiple_watchdropcrates();
  }
}

airdrop_multiple_watchdropcrates() {
  self endon("_encstr_AD75063D571AE108");
  scripts\common\anim::anim_first_frame_solo(self.ac130, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");

  foreach(var_1 in self.crates)
  scripts\common\anim::anim_first_frame_solo(var_1, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");

  foreach(var_4 in self.chutes)
  scripts\common\anim::anim_first_frame_solo(var_4, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");

  airdrop_multiple_watchdropcratesinternal();
  thread airdrop_multiple_watchdropcratesend();
}

airdrop_multiple_watchdropcratesinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team)
              self.ownerjoinedteam = 1;
          }
        } else
          self.ownerdisconnected = 1;
      }
    }

    if(!isDefined(var_0))
      var_0 = 1;
    else if(var_0) {
      if(isDefined(self.ac130)) {
        self.ac130 thread airdrop_multiple_ac130firstframe();
        thread scripts\common\anim::anim_single_solo(self.ac130, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");
      }

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          var_2.friendlymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

          if(isDefined(var_2.enemymodel))
            var_2.enemymodel setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);

          thread scripts\common\anim::anim_single_solo(var_2, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5)) {
          var_5 show();
          thread scripts\common\anim::anim_single_solo(var_5, "_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417");
        }
      }

      var_0 = 0;
    } else {
      var_7 = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.ac130)) {
        if(var_7 || gettime() > self.ac130.animendtime)
          self.ac130 airdrop_multiple_destroyac130();
      }

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          if(gettime() > var_2.animendtime) {
            if(var_7)
              var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

            thread scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(var_2);
            continue;
          }

          if(gettime() > var_2.animdroptime) {
            if(gettime() > var_2.animstoptrailtime) {
              var_2.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);

              if(isDefined(var_2.enemymodel))
                var_2.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 1);
            } else {
              var_2.friendlymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);

              if(isDefined(var_2.enemymodel))
                var_2.enemymodel setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 1);
            }

            if(var_7)
              var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

            continue;
          }

          if(var_7) {
            var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
            continue;
          }

          if(!isDefined(self.ac130) || istrue(self.ac130.isdestroyed))
            thread scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(var_2);
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5)) {
          if(gettime() > var_5.animendtime) {
            var_5 thread scripts\cp_mp\killstreaks\airdrop::destroychute();
            continue;
          }

          if(gettime() <= var_5.crateanimdroptime && (!isDefined(var_5.crate) || !isDefined(self.crates[var_5.crate getentitynumber()]))) {
            var_5 thread scripts\cp_mp\killstreaks\airdrop::destroychute();
            continue;
          }

          if(gettime() > var_5.animunhidetime)
            var_5 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
        }
      }
    }

    waitframe();
  }
}

airdrop_multiple_watchdropcratesend() {
  if(isDefined(self.ac130))
    self.ac130 thread airdrop_multiple_destroyac130();

  foreach(var_1 in self.crates) {
    if(isDefined(var_1))
      var_1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  foreach(var_4 in self.chutes) {
    if(isDefined(var_4))
      var_4 thread scripts\cp_mp\killstreaks\airdrop::destroychute();
  }

  self delete();
}

airdrop_multiple_createac130(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.scenenode = var_0;
  var_0.ac130 = var_1;
  var_1 setModel("_encstr_954624A0420C69F69741199821EF1BDF364AC8908BA503493E233F9033BF666F9EC3906812FA");
  var_1 scriptmoveroutline();
  var_1 scriptmoverthermal();
  var_1 setotherent(var_0.owner);
  var_1 setentityowner(var_0.owner);
  var_1 hide();
  airdrop_multiple_addac130tolist(var_1);
  var_1.animname = "_encstr_A937066AFF52FA4F";
  var_1 scripts\common\anim::setanimtree();
  var_2 = level.scr_anim["_encstr_A937066AFF52FA4F"]["_encstr_B8111BA2FF1339A91A49739B570FBD6FFB862060AF95ABA173A0787417"];
  var_1.animendtime = gettime() + getanimlength(var_2) * 1000;
  var_0.latestanimendtime = scripts\engine\utility::ter_op(var_1.animendtime > var_0.latestanimendtime, var_1.animendtime, var_0.latestanimendtime);
  var_3 = -1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_3 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]]("_encstr_A26F161C306860B15F6053C34D33BBA17A2DBA6048E1B3B7", var_0.team, 1, 1, 1);

  if(var_3 != -1)
    var_1.minimapid = var_3;

  return var_1;
}

airdrop_multiple_ac130firstframe() {
  self show();
  self playLoopSound("_encstr_BD6616AB57C2CEEDB22218201A08DFE1B3E7AF08DB0EBB91");
  self setscriptablepartstate("_encstr_BE2908C47B90B4630EFB", "_encstr_AB0703DBB9", 0);
  self setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56")]](1000, "_encstr_A2FB098A2035874AB0F358", ::airdrop_multiple_ac130handlefataldamage, ::airdrop_multiple_ac130handledamage, 1);
}

airdrop_multiple_destroyac130() {
  airdrop_multiple_deleteac130();
}

airdrop_multiple_deleteac130(var_0) {
  self notify("_encstr_AD75063D571AE108");

  if(isDefined(self.scenenode))
    self.scenenode.ac130 = undefined;

  airdrop_multiple_removeac130fromlist(self getentitynumber());
  self.scenenode = undefined;
  self.animendtime = undefined;
  self stoploopsound();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);

    self.minimapid = undefined;
  }

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  self delete();
}

airdrop_multiple_ac130handledamage(var_0) {
  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
      var_0.attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_B40101");
  }

  return 0;
}

airdrop_multiple_ac130handlefataldamage(var_0) {
  if(isPlayer(var_0.attacker)) {
    var_1 = 0;

    if(level.teambased && var_0.attacker.team == self.team)
      var_1 = 1;
    else if(var_0.attacker == self.owner)
      var_1 = 1;

    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_B8BB18512A8B0148735C9FD175DA58D65F4369395117CEE29A70", var_0.attacker);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516"))
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516")]]("_encstr_ABD70578F3D02C", var_0.objweapon, 400);
    }
  }

  airdrop_multiple_destroyac130();
}

airdrop_multiple_getcratedropcaststart(var_0) {
  var_0 = var_0 * (1, 1, 0);
  var_0 = var_0 + (0, 0, scripts\cp_mp\killstreaks\airdrop::getscriptedhelidropheightbase() + 200);
  var_0 = var_0 + (0, 0, level.cratedropdata.ac130s.size * 300);
  return var_0;
}

airdrop_multiple_getdropheight() {
  return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

airdrop_multiple_addac130tolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.ac130s[var_1] = var_0;
}

airdrop_multiple_removeac130fromlist(var_0) {
  level.cratedropdata.ac130s[var_0] = undefined;
}