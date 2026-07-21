/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\shellshock.gsc
***********************************************/

init() {
  level._effect["_encstr_B25B09F8B82B618DFB068B"] = loadfx("_encstr_859B239339CB462678ED7537C730AAD7FD909E1B41A3CF5EB82F67448710345B0848B262AB");
  level._effect["_encstr_8E670ACB70FB6FA3BA687094"] = loadfx("_encstr_8F1D24DE94AA1E464793DA76E0B7FACFE1081F563CF2974E19D0623A999974C31EEED1FF43DB");
  level._effect["_encstr_83580CDA956356ACEB37C1C958F2"] = loadfx("_encstr_955926B4F673705F458380CA8B1E35717F96902C4EDBA6BB2F4A88902176D1C8FF04D026B02B29DB");
  level._effect["_encstr_81DD1499ED393695F546D26EDAAC6BC4564EDAACDCE8"] = loadfx("_encstr_9A6136C31C7876D30F47A2C7E5BB63A5C16C3878591BF3FF0F5AA033A988D32B1801E17F43054DB75E98030730D28D5BB7A9177743BB32D0");
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6", scripts\mp\equipment\flash_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_83631D97EFB2E6F013BA4098E5C1E0A5FA732D332BBB2D0854164AB5CBDED0", scripts\mp\equipment\concussion_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92C6169D2CB94AB93A2BC94EBAE047225636B05E32ABDCD8", scripts\mp\equipment\gas_grenade::gas_getblurinterruptdelayms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_888F1CD858E6D19AA385B946A4B9E859C939D538A311CA632CBC19AB376C", scripts\mp\laststand::getshellshockinterruptdelayms);
}

shellshockondamage(var_0, var_1) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }
  if(var_0 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_0 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_0 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B") {
    if(var_1 > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction)
        scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_B83B10B348E9604BAF25467D9FF7120FF0E8", "_encstr_B2BE0788BAF573592F", self.shellshockreduction);
      else
        scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_B83B10B348E9604BAF25467D9FF7120FF0E8", "_encstr_B2BE0788BAF573592F", 0.5);
    }
  }
}

endondeath() {
  self waittill("_encstr_AD75063D571AE108");
  waittillframeend;
  self notify("_encstr_BDF90C4D10A95F47E990CAF2D83B");
}

grenade_earthquake(var_0, var_1) {
  self notify("_encstr_B634131C229FD5F315ED57E0536AFD3819631192B0");
  self endon("_encstr_B634131C229FD5F315ED57E0536AFD3819631192B0");
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_2 = undefined;

  if(!isDefined(var_1) || var_1)
    self waittill("_encstr_860808CB78E2984063BA", var_2);
  else
    var_2 = self.origin;

  grenade_earthquakeatposition_internal(var_2, var_0);
}

grenade_earthquakeatposition(var_0, var_1) {
  grenade_earthquakeatposition_internal(var_0, var_1);
}

grenade_earthquakeatposition_internal(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  var_2 = 0.45 * var_1;
  var_3 = 0.7;
  var_4 = 800;
  earthquake(var_2, var_3, var_0, var_4);
  _screenshakeonposition(var_0, 600);
}

bloodeffect(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);

  if(var_4 > 0 && var_4 > 0.5) {
    return;
  }
  if(abs(var_4) < 0.866) {
    var_6 = level._effect["_encstr_B25B09F8B82B618DFB068B"];

    if(var_5 > 0)
      var_6 = level._effect["_encstr_8E670ACB70FB6FA3BA687094"];

    var_7 = ["_encstr_AD75063D571AE108", "_encstr_B2BE0788BAF573592F"];
    thread play_fx_with_entity(var_6, var_7, 7.0);
  } else {}
}

bloodmeleeeffect(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = _id_14096(var_0);

  if(isDefined(var_2))
    thread attraction_sr_range_hud(var_2);
  else {
    var_3 = ["_encstr_AD75063D571AE108"];
    thread play_fx_with_entity(level._effect["_encstr_83580CDA956356ACEB37C1C958F2"], var_3, 1.5);

    if(var_0.basename == "_encstr_A36F15D2EE70BEB6B2EB3A9CC67BB046F6AB1DFA5B1C3B") {
      var_4 = var_1 getcorpseentity();

      if(isDefined(var_4)) {
        var_5 = ["_encstr_83190BED4757A3B3B20C5E83E0", "_encstr_A1190BD4FABB9396DC47EB8DAC", "_encstr_AADA07DBF19A4A81D7"];
        var_6 = ["_encstr_BD500A3C087F4AD519410B6F", "_encstr_AC500A7A366A5BBFC04F9465"];
        var_7 = self getEye();
        var_8 = var_4 gettagorigin("_encstr_AADA07DBF19A4A81D7");
        var_9 = var_4 gettagorigin("_encstr_BD500A3C087F4AD519410B6F");

        if(distancesquared(var_8, var_7) < distancesquared(var_9, var_7))
          playFXOnTag(level._effect["_encstr_81DD1499ED393695F546D26EDAAC6BC4564EDAACDCE8"], var_4, var_5[randomintrange(0, var_5.size)]);
        else
          playFXOnTag(level._effect["_encstr_81DD1499ED393695F546D26EDAAC6BC4564EDAACDCE8"], var_4, var_6[randomintrange(0, var_6.size)]);
      }
    }
  }
}

_id_14096(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.receiver))
    return undefined;

  if(var_0 hasattachment("_encstr_82100D3A69900F6A46C059DE58D031"))
    return "_encstr_97EE0C8936DE7B19232C8CA59356";
  else if(var_0 hasattachment("_encstr_B6F90882C07F450B59B3") || scripts\engine\utility::string_starts_with(var_0.receiver, "_encstr_A6BA09419BE8E0839FC303"))
    return "_encstr_B6F90882C07F450B5DA3";
  else if(var_0 hasattachment("_encstr_83A10EBBE998DA4C1012C19688509EA3") || scripts\engine\utility::string_starts_with(var_0.receiver, "_encstr_A3C8088AF1F0CF3E08A3"))
    return "_encstr_8A4C0D9863F6DB8C19858463BA37E8";
  else if(var_0 hasattachment("_encstr_9B7C0D76D92F029C31C077DFB80952"))
    return "_encstr_813B0C4141728F3525B8F7E83BFA";
  else
    return undefined;
}

attraction_sr_range_hud(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setscriptablepartstate("_encstr_93380B5BAC632B2B8436F6B746", var_0);
  wait 0.05;
  self setscriptablepartstate("_encstr_93380B5BAC632B2B8436F6B746", "_encstr_A7A408B9CA5D1D4E2C63");
}

play_fx_with_entity(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = spawnfxforclient(var_0, self getEye(), self);
  triggerfx(var_3);
  var_3 setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(var_1, var_2);
  var_3 delete();
}

c4_earthquake() {
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_0);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  earthquake(0.4, 0.75, var_0, 512);
  var_1 = scripts\common\utility::playersinsphere(var_0, 512);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_3 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

artillery_earthquake(var_0, var_1, var_2, var_3, var_4) {
  playrumbleonposition("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0);

  if(!isDefined(var_1))
    var_1 = 0.7;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_3))
    var_3 = 800;

  earthquake(var_1, var_2, var_0, var_3);
  _screenshakeonposition(var_0, var_3, var_4);
}

stealthairstrike_earthquake(var_0) {
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  earthquake(1.0, 0.6, var_0, 2000);
  var_1 = scripts\common\utility::playersinsphere(var_0, 1000);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_3 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

airstrike_earthquake(var_0) {
  playrumbleonposition("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0);
  earthquake(0.5, 0.65, var_0, 1000);
  _screenshakeonposition(var_0, 900);
}

pulsegrenade_earthquake(var_0) {
  self notify("_encstr_8BCB1828FDA00A3B37E6FD3D7279A0C70F36EA7954FFEB1792E2");
  self endon("_encstr_8BCB1828FDA00A3B37E6FD3D7279A0C70F36EA7954FFEB1792E2");
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0)
    self waittill("_encstr_860808CB78E2984063BA", var_1);
  else
    var_1 = self.origin;

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::playersinsphere(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_4 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

engineerdrone_earthquake(var_0) {
  self notify("_encstr_8BCB1828FDA00A3B37E6FD3D7279A0C70F36EA7954FFEB1792E2");
  self endon("_encstr_8BCB1828FDA00A3B37E6FD3D7279A0C70F36EA7954FFEB1792E2");
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0)
    self waittill("_encstr_860808CB78E2984063BA", var_1);
  else
    var_1 = self.origin;

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::playersinsphere(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_4 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

_screenshakeonposition(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersinsphere(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_2)) {
      if(isarray(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5))
          continue;
      } else if(var_5 == var_2)
        continue;
    }

    if(var_5 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_5 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}