/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\shared.gsc
***********************************************/

placeweaponon(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(issameweapon(var_0)) {
    var_3 = var_0;
    var_4 = createheadicon(var_0);
  } else {
    var_3 = asmdevgetallstates(var_0);
    var_4 = var_0;
  }

  self notify("_encstr_9304177F8889D85A6D18A21D760BA399107867A778610E0243");
  var_5 = self.weaponinfo[var_4].position;

  if(var_1 != "_encstr_8BBA05185F8B99" && isDefined(self.a.weaponpos[var_1]) && self.a.weaponpos[var_1] == var_3) {
    return;
  }
  detachallweaponmodels();

  if(var_5 != "_encstr_8BBA05185F8B99")
    detachweapon(var_3);

  if(var_1 == "_encstr_8BBA05185F8B99") {
    updateattachedweaponmodels();
    return;
  }

  if(!getqueuedspleveltransients(self.a.weaponpos[var_1]))
    detachweapon(self.a.weaponpos[var_1]);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2 && (var_1 == "_encstr_A5AD056A019C63" || var_1 == "_encstr_8253060E2B5FE330")) {
    attachweapon(var_3, var_1);
    self.weapon = var_3;
  } else
    attachweapon(var_3, var_1);

  updateattachedweaponmodels();
}

detachweapon(var_0) {
  var_1 = createheadicon(var_0);
  self.a.weaponpos[self.weaponinfo[var_1].position] = undefined;
  self.weaponinfo[var_1].position = "_encstr_8BBA05185F8B99";
}

attachweapon(var_0, var_1) {
  var_2 = createheadicon(var_0);
  self.weaponinfo[var_2].position = var_1;
  self.a.weaponpos[var_1] = var_0;

  if(!getqueuedspleveltransients(self.a.weaponposdropping[var_1])) {
    self notify("_encstr_8AA0110F45A561E7A0A962ADA0993C6B88D15F" + var_1);
    self.a.weaponposdropping[var_1] = undefined;
  }
}

getweaponforpos(var_0) {
  var_1 = self.a.weaponpos[var_0];

  if(getqueuedspleveltransients(var_1))
    return self.a.weaponposdropping[var_0];

  return var_1;
}

detachallweaponmodels() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_8253060E2B5FE330";
  var_0[var_0.size] = "_encstr_A5AD056A019C63";
  var_0[var_0.size] = "_encstr_9A7606B11A95DCD1";
  var_0[var_0.size] = "_encstr_B69B0589C236B6";
  var_0[var_0.size] = "_encstr_867206AC09900743";
  self laseroff();

  foreach(var_2 in var_0) {
    var_3 = getweaponforpos(var_2);

    if(getqueuedspleveltransients(var_3)) {
      continue;
    }
    if(weapontype(var_3) == "_encstr_A5450BC280BF4B604068C33187" && isDefined(self.shieldmodelvariant)) {
      if(isDefined(self.shieldbroken) && self.shieldbroken) {
        playFXOnTag(scripts\engine\utility::getfx("_encstr_88ED104E2DBDE8AF373496B2B132BEC8DA9D"), self, "_encstr_AA6E0AB1E7D5CE85863FBBC6");
        self.shieldbroken = undefined;
      }
    }
  }

  self updateentitywithweapons();
}

updateattachedweaponmodels() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[var_0.size] = "_encstr_8253060E2B5FE330";
  var_0[var_0.size] = "_encstr_A5AD056A019C63";
  var_0[var_0.size] = "_encstr_9A7606B11A95DCD1";
  var_0[var_0.size] = "_encstr_B69B0589C236B6";
  var_0[var_0.size] = "_encstr_867206AC09900743";

  foreach(var_4 in var_0) {
    var_5 = var_1.size;
    var_6 = getweaponforpos(var_4);

    if(!getqueuedspleveltransients(var_6) && !nullweapon(var_6)) {
      var_7 = createheadicon(var_6);

      if(self.weaponinfo[var_7].useclip && !self.weaponinfo[var_7].hasclip)
        var_6 = var_6 withoutattachment(var_6.magazine);
    }

    if(isDefined(var_6)) {
      var_8 = gettagforpos(var_4);

      if(self tagexists(var_8)) {
        var_1[var_5] = var_6;
        var_2[var_2.size] = var_8;
      }
    }
  }

  self updateentitywithweapons(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);
  updatelaserstatus();
}

updatelaserstatus() {
  if(isDefined(self.custom_laser_function))
    [[self.custom_laser_function]]();
  else {
    if(!isDefined(self.a.weaponpos) || getqueuedspleveltransients(self.a.weaponpos["_encstr_8253060E2B5FE330"])) {
      return;
    }
    if(canuselaser()) {
      self laseron();
      return;
    }

    self laseroff();
  }
}

canuselaser() {
  if(!self.a.laseron)
    return 0;

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isshotgun(self.weapon))
    return 0;

  return isalive(self);
}

gettagforpos(var_0) {
  switch (var_0) {
    case "_encstr_9A7606B11A95DCD1":
      return "_encstr_AB0111A37657C98E7BFFA79BCB91DE38ED4A2B";
    case "_encstr_B69B0589C236B6":
      return "_encstr_9A8610EB2818A99B30D71B4A31A15E09A177";
    case "_encstr_A5AD056A019C63":
      return "_encstr_A98C10F0117A694307579828C090CC85ED33";
    case "_encstr_8253060E2B5FE330":
      return "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D";
    case "_encstr_B2CC0599D03A79":
      return "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5";
    case "_encstr_867206AC09900743":
      return "_encstr_A996115D09F786976B8A38A0D24941B867B7EB";
    default:
      break;
  }
}

dropaiweaponinternal(var_0) {
  var_1 = createheadicon(var_0);
  var_2 = self.weaponinfo[var_1].position;

  if(self.dropweapon && var_2 != "_encstr_8BBA05185F8B99")
    thread dropweaponwrapper(var_0, var_2);

  detachweapon(var_0);

  if(var_0 == self.weapon)
    self.weapon = isundefinedweapon();

  if(var_0 == self.primaryweapon)
    self.primaryweapon = isundefinedweapon();

  if(var_0 == self.secondaryweapon)
    self.secondaryweapon = isundefinedweapon();

  if(var_0 == self.sidearm) {
    if(!nullweapon(self.primaryweapon))
      dropaiweaponinternal(self.primaryweapon);

    self.sidearm = isundefinedweapon();
  }
}

dropaiweapon(var_0) {
  if(!isDefined(var_0))
    var_0 = self.weapon;

  if(nullweapon(var_0)) {
    return;
  }
  if(isDefined(self.nodrop)) {
    return;
  }
  detachallweaponmodels();
  dropaiweaponinternal(var_0);

  if(nullweapon(self.primaryweapon)) {
    if(!nullweapon(self.weapon))
      self.primaryweapon = self.weapon;
    else if(!nullweapon(self.secondaryweapon))
      self.primaryweapon = self.secondaryweapon;
    else if(!nullweapon(self.sidearm))
      self.primaryweapon = self.sidearm;

    if(self.primaryweapon == self.secondaryweapon)
      self.secondaryweapon = isundefinedweapon();
  }

  updateattachedweaponmodels();
}

dropallaiweapons() {
  if(isDefined(self.nodrop))
    return "_encstr_8BBA05185F8B99";

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "_encstr_A5AD056A019C63";
  var_0[var_0.size] = "_encstr_8253060E2B5FE330";
  var_0[var_0.size] = "_encstr_9A7606B11A95DCD1";
  var_0[var_0.size] = "_encstr_B69B0589C236B6";
  var_0[var_0.size] = "_encstr_867206AC09900743";
  detachallweaponmodels();

  foreach(var_2 in var_0) {
    var_3 = self.a.weaponpos[var_2];

    if(getqueuedspleveltransients(var_3)) {
      continue;
    }
    var_4 = createheadicon(var_3);
    self.weaponinfo[var_4].position = "_encstr_8BBA05185F8B99";
    self.a.weaponpos[var_2] = undefined;

    if(self.dropweapon)
      thread dropweaponwrapper(var_3, var_2);
  }

  self.weapon = isundefinedweapon();
  updateattachedweaponmodels();
}

dropweaponwrapper(var_0, var_1) {
  if(self isragdoll())
    return "_encstr_8BBA05185F8B99";

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = var_0;
  var_3 = var_0.basename;

  if(issubstr(tolower(var_3), "_encstr_971A04703752")) {
    var_3 = getsubstr(var_3, 0, var_3.size - 3);
    var_2 = getcompleteweaponname(var_3, var_0.attachments);
  }

  thread setdroppedweaponammo(var_2);

  if(isagent(self)) {
    if(isDefined(level.dropped_weapon_func))
      self thread[[level.dropped_weapon_func]](var_2, var_1);
    else
      self dropweaponnovelocity(var_2, var_1);
  } else if(canaiflingweapon(self)) {
    if(var_1 == "_encstr_B69B0589C236B6" || var_1 == "_encstr_867206AC09900743")
      var_4 = "_encstr_B4650C6B20E7F1EF93A0676DCD1E" + var_1;
    else
      var_4 = "_encstr_93120C1B820F2030DFE199AF0689" + var_1;

    if(!scripts\engine\utility::hastag(self.model, var_4)) {
      self dropweapon(var_2, var_1, 0);
      self endon("_encstr_8AA0110F45A561E7A0A962ADA0993C6B88D15F" + var_1);
      waitframe();
      return;
    }

    var_5 = self gettagorigin(var_4);
    self endon("_encstr_8AA0110F45A561E7A0A962ADA0993C6B88D15F" + var_1);
    waitframe();

    if(!isDefined(self)) {
      return;
    }
    var_6 = self gettagorigin(var_4);
    var_7 = self gettagangles(var_4);
    var_8 = createheadicon(var_2);
    var_9 = spawn("_encstr_B2010820C5337B67C8CF" + var_8, var_6);
    var_9.angles = var_7;
    var_10 = var_6 - var_5;
    var_11 = vectorNormalize(var_10);
    var_12 = 20;
    var_13 = 50;
    var_14 = min(length(var_10) * var_12, var_13);
    var_15 = var_11 * var_14;
    var_16 = (0, 0, 950);
    var_17 = var_6 + var_11 * -1;
    var_18 = var_15 + var_16;

    if(weaponclass(var_2) == "_encstr_8D940738966ED1DB8D")
      var_18 = var_18 * 0.5;

    var_9 physicslaunchserveritem(var_17, var_18);
  } else {
    self dropweapon(var_2, var_1, 0);
    self endon("_encstr_8AA0110F45A561E7A0A962ADA0993C6B88D15F" + var_1);
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }
  if(isagent(self) && !isalive(self)) {
    return;
  }
  detachallweaponmodels();
  self.a.weaponposdropping[var_1] = undefined;
  updateattachedweaponmodels();
}

canaiflingweapon(var_0) {
  if(!getdvarint("_encstr_ACB51143213059F9F8DE5F926A38179EDFBF96", 0))
    return 0;

  if(!scripts\common\utility::issp())
    return 0;

  if(!isDefined(var_0.lastattacker))
    return 0;

  if(!isPlayer(var_0.lastattacker))
    return 0;

  if(isexplosivedamagemod(var_0.damagemod))
    return 1;

  var_1 = 300;

  if(distance(var_0.lastattacker.origin, var_0.origin) < var_1)
    return 0;

  return 1;
}

setdroppedweaponammo(var_0) {
  self waittill("_encstr_B8E20FBB59851CF6E6AF91E4DBC107B232", var_1);
  var_1 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && isvaliddroppedweapon(var_0)) {
    if(isDefined(var_1)) {
      var_1 physics_registerforcollisioncallback();
      var_1 thread weapondrop_physics_callback_monitor(var_0);
      var_2 = getsubstr(var_1.classname, 7, var_1.classname.size);
      var_1 setscriptammo(var_2, self);
    }
  }
}

isvaliddroppedweapon(var_0) {
  if(var_0.ismelee)
    return 0;

  return 1;
}

weapondrop_physics_callback_monitor(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_995408F398012F656821");
  thread weapondrop_physics_timeout(2);
  self waittill("_encstr_93510A16C71B20636A2AB8B8", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = physics_getsurfacetypefromflags(var_4);
  var_10 = getsubstr(var_9["_encstr_84BA05A8CA852B"], 9);

  if(var_10 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
    var_10 = "_encstr_AA9D0F9543A77B872312D8C04A3CAD964E";

  if(isDefined(var_0.classname) && isDefined(self)) {
    var_11 = "_encstr_A9D30EAF47C988B11FBABDC1C67A6571";

    switch (var_0.classname) {
      case "_encstr_965306392D3336B2":
        var_11 = "_encstr_A9D30EAF47C988B11FBABDC1C67A6571";
        break;
      case "_encstr_BE1904DCDA9D":
        var_11 = "_encstr_8B4910EEB2160EF51927BDC1F59BD616B1C6";
        break;
      case "_encstr_BE0703A54C":
        var_11 = "_encstr_AA0E116847B1C3778222B797711B49A90AF770";
        break;
      case "_encstr_A1100738A33A638123":
        var_11 = "_encstr_ABF310AF5859088949BE558A3071A2B221F0";
        break;
      case "_encstr_850707F7E5833355B8":
        var_11 = "_encstr_ABF310AF5859088949BE558A3071A2B221F0";
        break;
      case "_encstr_8D940738966ED1DB8D":
        var_11 = "_encstr_858E11C75FCF915F30689060099BCA63717811";
        break;
      case "_encstr_8C8D08671D451291C849":
        var_11 = "_encstr_95F4134323165859D88288287185A2FDE5478C4DAB";
        break;
      case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
        var_11 = "_encstr_95F4134323165859D88288287185A2FDE5478C4DAB";
        break;
    }

    if(soundexists(var_11))
      self playsurfacesound(var_11, var_10);
    else {}
  }
}

weapondrop_physics_timeout(var_0) {
  wait(var_0);
  self notify("_encstr_995408F398012F656821");
}

getaimyawtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos))
      return 0;

    return scripts\engine\utility::getaimyawtopoint(self.shootpos);
  }

  return scripts\engine\utility::getaimyawtopoint(self.shootent getshootatpos());
}

getaimpitchtoshootentorpos() {
  var_0 = getpitchtoshootentorpos();

  if(self.script == "_encstr_8DE30D6CF69D2B937DB1277BAE8DD0" && isDefined(self.a.covermode) && self.a.covermode == "_encstr_9BAD05B1560B9B")
    var_0 = var_0 - anim.covercrouchleanpitch;

  return var_0;
}

getpitchtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos))
      return 0;

    return _encstr_83062042F108F193B56F3EFFADD38A7F58D87D8E2950BF9B8D733BD7B183C66F70A1::getpitchtoshootspot(self.shootpos);
  }

  return _encstr_83062042F108F193B56F3EFFADD38A7F58D87D8E2950BF9B8D733BD7B183C66F70A1::getpitchtoshootspot(self.shootent getshootatpos());
}

ramboaim(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  ramboaiminternal(var_0);
}

ramboaiminternal(var_0) {}

decidenumshotsforburst() {
  var_0 = 0;
  var_1 = weaponburstcount(self.weapon);

  if(var_1)
    var_0 = var_1;
  else if(_encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::usingsemiautoweapon())
    var_0 = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  else if(self.fastburst)
    var_0 = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  else
    var_0 = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];

  if(var_0 <= self.bulletsinclip)
    return var_0;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

decidenumshotsforfull() {
  var_0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "_encstr_BE0703A54C") {
    var_1 = randomfloat(10);

    if(var_1 < 3)
      var_0 = randomintrange(2, 6);
    else if(var_1 < 8)
      var_0 = randomintrange(6, 12);
    else
      var_0 = randomintrange(12, 20);
  }

  return var_0;
}

hideweaponmagattachment(var_0) {
  self.weaponinfo[var_0].hasclip = 0;
  updateattachedweaponmodels();
}

showweaponmagattachment(var_0) {
  self.weaponinfo[var_0].hasclip = 1;
  updateattachedweaponmodels();
}

handledropclip(var_0) {
  self endon("_encstr_8AA00D1F5D20B3E471CB276D80683C");
  self endon(var_0 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_1 = self.weapon;
  var_2 = createheadicon(var_1);
  var_3 = undefined;

  if(self.weaponinfo[var_2].useclip)
    var_3 = getweaponclipmodel(self.weapon);

  if(self.weaponinfo[var_2].hasclip) {
    if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
      self playSound("_encstr_B2701F5B2988F0894EBBDBDF9B7DB148607313256021AB722B69CF8FA988EA80C8");
    else
      self playSound("_encstr_BA1B1C874723CA367D7AF3EAC1140938B85711CFF2B3230528EBD1706BC1");

    if(isDefined(var_3)) {
      hideweaponmagattachment(var_2);
      thread dropclipmodel(var_3, "_encstr_91230983981FD60F4BE88B");
    }
  }

  var_4 = 0;

  while(!var_4) {
    self waittill(var_0, var_5);

    if(!isarray(var_5))
      var_5 = [var_5];

    foreach(var_7 in var_5) {
      switch (var_7) {
        case "_encstr_ABC511C247D10BD81A40B1362DE0801B563347":
          if(isDefined(var_3))
            self attach(var_3, "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");

          _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::refillclip();
          break;
        case "_encstr_8F6812858EE8B08D1A10D8C64B1C1093969D43A3":
          if(isDefined(var_3))
            self attach(var_3, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");

          _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::refillclip();
          break;
        case "_encstr_881E131D776BEB49489A0868A788E93D22DC07908F":
          if(isDefined(var_3))
            self detach(var_3, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");

          break;
        case "_encstr_ADE1125982037FD0DCE07F69C18292BEDF1A50C3":
          if(isDefined(var_3)) {
            self detach(var_3, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");

            if(var_1 == self.weapon)
              showweaponmagattachment(var_2);
            else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var_2].hasclip = 1;
            }

            self notify("_encstr_9BB20E1BB1D207EB32563A858D862B91");
          }

          self.a.needstorechamber = 0;
          var_4 = 1;
          break;
        case "_encstr_AAC111BD589B4E57E0015E8DD8BAF8254DC6F3":
          if(isDefined(var_3)) {
            self detach(var_3, "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");

            if(var_1 == self.weapon)
              showweaponmagattachment(var_2);
            else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var_2].hasclip = 1;
            }

            self notify("_encstr_9BB20E1BB1D207EB32563A858D862B91");
          }

          self.a.needstorechamber = 0;
          var_4 = 1;
          break;
      }
    }
  }
}

dropclipmodel(var_0, var_1) {}

movetonodeovertime(var_0, var_1) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);

  if(var_3 < 1) {
    self safeteleport(var_2);
    return;
  }

  if(var_3 > 256 && !self maymovetopoint(var_2, !scripts\engine\utility::actor_is3d())) {
    return;
  }
  self.keepclaimednodeifvalid = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectorNormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + (var_2 - var_8) * ((var_6 + 1) / var_5);
    self safeteleport(var_9);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

returntrue() {
  return 1;
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

playlookanimation(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = ::returntrue;

  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.enemy)) {
      if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::canseeenemy() && [[var_2]]())
        return;
    }

    if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::issuppressedwrapper() && [[var_2]]()) {
      return;
    }
    self setanimknoball(var_0, %_encstr_AD9B0589ED9197, 1, 0.1);
    wait 0.1;
  }
}

throwdownweapon(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  placeweaponon(self.secondaryweapon, "_encstr_8253060E2B5FE330");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

rpgplayerrepulsor() {
  var_0 = rpgplayerrepulsor_getnummisses();

  if(var_0 == 0) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_BDAF0E16DCF52B73955B2FFAE60DED47", var_1);

    if(var_1 != self) {
      continue;
    }
    if(!isDefined(var_1.enemy)) {
      continue;
    }
    if(!isPlayer(var_1.enemy)) {
      continue;
    }
    if(isDefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0) {
      continue;
    }
    thread rpgplayerrepulsor_create(var_1.enemy);
    var_0--;

    if(var_0 <= 0)
      return;
  }
}

rpgplayerrepulsor_getnummisses() {
  var_0 = scripts\common\utility::getdifficulty();

  switch (var_0) {
    case "_encstr_AF72050FB35809":
    case "_encstr_A260053D1AE31B":
      return 2;
    case "_encstr_A2CC0A32B433995AD857C61D":
    case "_encstr_83CC051A163991":
    case "_encstr_AB5E07609A5B7368E5":
    case "_encstr_8C07031599":
      return 1;
    case "_encstr_820703B86B":
      return 0;
  }

  return 2;
}

rpgplayerrepulsor_create(var_0) {
  var_1 = missile_createrepulsorent(var_0, 5000, 800);
  wait 4.0;
  missile_deleteattractor(var_1);
}

pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }
  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }
  var_0 = undefined;

  if(distancesquared(self.origin, self.enemy.origin) < self.closeweaponmaxdist * self.closeweaponmaxdist)
    var_0 = self.forcedweaponclose;
  else
    var_0 = self.forcedweaponfar;

  if(var_0 != self.weapon) {
    forceuseweapon(var_0, "_encstr_BA7F0830B3A7859B60B0");
    self.weapon_stow setModel(getweaponmodel(self.forcedweapon));
    self.forcedweapon = var_0;
  }
}

forceuseweapon(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0;
  else
    var_2 = [[level.fnbuildweapon]](var_0);

  if(istrue(self.script_fakeactor) || istrue(self.script_drone)) {
    scripts\common\ai::gun_remove();
    scripts\common\ai::set_start_cash(getweaponattachmentworldmodels(var_2));
    return;
  }

  if(!scripts\common\utility::isweaponinitialized(var_2))
    scripts\common\utility::initweapon(var_2);

  var_3 = !nullweapon(self.weapon);
  var_4 = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm();
  var_5 = var_1 == "_encstr_AF53086E4B46ACC2E4B5";
  var_6 = var_1 == "_encstr_AC8F0AE74163F85AAA380AD8";

  if(var_3 && var_4 != var_5) {
    if(var_4)
      var_7 = "_encstr_8BBA05185F8B99";
    else if(var_6)
      var_7 = "_encstr_B69B0589C236B6";
    else
      var_7 = "_encstr_9A7606B11A95DCD1";

    placeweaponon(self.weapon, var_7);
    self.lastweapon = self.weapon;
  } else
    self.lastweapon = var_2;

  placeweaponon(var_2, "_encstr_8253060E2B5FE330");

  if(var_5)
    self.sidearm = var_2;
  else if(var_6)
    self.secondaryweapon = var_2;
  else
    self.primaryweapon = var_2;

  self.weapon = var_2;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("_encstr_8C25132BF1EFA3BD18CF0BF75B30460B1849220259");
  updateweaponarchetype(weaponclass(self.weapon));
}

updateweaponarchetype(var_0) {
  if(!isDefined(self._blackboard) || scripts\asm\asm_bb::bb_isanimScripted() || !isDefined(self.asm) || !isDefined(self.asm.archetype)) {
    return;
  }
  var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(var_0 == "_encstr_8D940738966ED1DB8D" && archetypeassetloaded(var_1 + "_encstr_A5F008DF9A58B39BB049"))
    scripts\asm\shared\utility::setoverridearchetype("_encstr_AC20072B9FA9487832", var_1 + "_encstr_A5F008DF9A58B39BB049");
  else if(var_0 == "_encstr_BE0703A54C" && archetypeassetloaded(var_1 + "_encstr_974305B1E80807"))
    scripts\asm\shared\utility::setoverridearchetype("_encstr_AC20072B9FA9487832", var_1 + "_encstr_974305B1E80807");
  else
    scripts\asm\shared\utility::clearoverridearchetype("_encstr_AC20072B9FA9487832");
}

everusessecondaryweapon() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isshotgun(self.secondaryweapon))
    return 1;

  if(weaponclass(self.primaryweapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    return 1;

  return 0;
}

default_weaponsetup(var_0) {
  if(!isDefined(self.stowsidearmposition)) {
    if(istrue(self.bhasthighholster))
      self.stowsidearmposition = "_encstr_867206AC09900743";
    else
      self.stowsidearmposition = anim.stowsidearmpositiondefault;
  }

  if(istrue(self.scriptedweaponfailed)) {
    if(isDefined(level.fnscriptedweaponassignment)) {
      if(isDefined(self.scriptedweaponfailed_primaryarray)) {
        self.primaryweapon = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_primaryarray);
        self.scriptedweaponfailed_primaryarray = undefined;
      }

      if(isDefined(self.scriptedweaponfailed_sidearmarray)) {
        self.sidearm = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_sidearmarray, "_encstr_AF53086E4B46ACC2E4B5");
        self.scriptedweaponfailed_sidearmarray = undefined;
      }

      if(isDefined(self.scriptedweaponfailed_secondaryarray)) {
        self.secondaryweapon = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_secondaryarray);
        self.scriptedweaponfailed_secondaryarray = undefined;
      }
    }
  } else if(!istrue(self.usescriptedweapon) && (!isDefined(self.agent_type) || !(self.agent_type == "_encstr_841526F157304D5330094AE2107BAF0668477A6DCFC157F7CE2183FB3E5FC3F148B7DFCC03785FE3" || self.agent_type == "_encstr_9A2D25F2F80905133E7DA6A50182DF4E69814B0BD0873F879355A2CC30EBD314D138D321C07DB7"))) {
    if(!scripts\common\utility::issp()) {
      if(issameweapon(self.primaryweapon)) {
        var_1 = getweaponbasename(self.primaryweapon);

        if(!scripts\common\utility::iscp())
          var_1 = [[level.fngetweaponrootname]](var_1);

        if(var_1 != "_encstr_8BBA05185F8B99")
          self.primaryweapon = [[level.fnbuildweapon]](var_1, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      } else
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");

      if(issameweapon(self.secondaryweapon)) {
        var_1 = getweaponbasename(self.secondaryweapon);

        if(!scripts\common\utility::iscp())
          var_1 = [[level.fngetweaponrootname]](var_1);

        if(var_1 != "_encstr_8BBA05185F8B99")
          self.secondaryweapon = [[level.fnbuildweapon]](var_1, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      } else
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");

      if(issameweapon(self.sidearm)) {
        var_1 = getweaponbasename(self.sidearm);

        if(!scripts\common\utility::iscp())
          var_1 = [[level.fngetweaponrootname]](var_1);

        if(var_1 != "_encstr_8BBA05185F8B99")
          self.sidearm = [[level.fnbuildweapon]](var_1, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      } else
        self.sidearm = [[level.fnbuildweapon]](self.sidearm, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    } else {
      self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, []);
      self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, []);
      self.sidearm = [[level.fnbuildweapon]](self.sidearm, []);
    }
  }

  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.secondaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  var_2 = self.classname;

  if(isagent(self))
    var_2 = self.agent_type;

  self setdefaultaimlimits();
  self.a.weaponpos = [];
  self.a.weaponposdropping = [];
  self.lastweapon = self.weapon;
  var_3 = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher();
  self.a.neverlean = var_3;

  if(var_3)
    thread rpgplayerrepulsor();

  self.rocketammo = 100;
  placeweaponon(self.primaryweapon, "_encstr_8253060E2B5FE330");

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isshotgun(self.secondaryweapon))
    placeweaponon(self.secondaryweapon, "_encstr_B69B0589C236B6");

  if(!nullweapon(self.sidearm) && isDefined(self.stowsidearmposition))
    placeweaponon(self.sidearm, self.stowsidearmposition);

  if(self.team != "_encstr_9A8507BA4040188D08")
    self.has_no_ir = 1;

  _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::refillclip();
}

initdeaths() {
  anim.numdeathsuntilcrawlingpain = randomintrange(0, 15);
  anim.numdeathsuntilcornergrenadedeath = randomintrange(0, 10);
  anim.nextcrawlingpaintime = gettime() + randomintrange(0, 20000);
  anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(0, 10000);
  anim.nextcornergrenadedeathtime = gettime() + randomintrange(0, 15000);
  anim.nextbalconydeathtime = gettime() + randomintrange(0, 1000);
}

initadvancetoenemy() {
  level.lastadvancetoenemytime = [];
  level.lastadvancetoenemytime["_encstr_8E8405EA382B2A"] = 0;
  level.lastadvancetoenemytime["_encstr_9A8507BA4040188D08"] = 0;
  level.lastadvancetoenemytime["_encstr_B848067B63177293"] = 0;
  level.lastadvancetoenemytime["_encstr_A7A408B9CA5D1D4E2C63"] = 0;
  level.lastadvancetoenemydest = [];
  level.lastadvancetoenemydest["_encstr_8E8405EA382B2A"] = (0, 0, 0);
  level.lastadvancetoenemydest["_encstr_9A8507BA4040188D08"] = (0, 0, 0);
  level.lastadvancetoenemydest["_encstr_B848067B63177293"] = (0, 0, 0);
  level.lastadvancetoenemydest["_encstr_A7A408B9CA5D1D4E2C63"] = (0, 0, 0);
  level.lastadvancetoenemysrc = [];
  level.lastadvancetoenemysrc["_encstr_8E8405EA382B2A"] = (0, 0, 0);
  level.lastadvancetoenemysrc["_encstr_9A8507BA4040188D08"] = (0, 0, 0);
  level.lastadvancetoenemysrc["_encstr_B848067B63177293"] = (0, 0, 0);
  level.lastadvancetoenemysrc["_encstr_A7A408B9CA5D1D4E2C63"] = (0, 0, 0);
  level.lastadvancetoenemyattacker = [];
  level.advancetoenemygroup = [];
  level.advancetoenemygroup["_encstr_8E8405EA382B2A"] = 0;
  level.advancetoenemygroup["_encstr_9A8507BA4040188D08"] = 0;
  level.advancetoenemygroup["_encstr_B848067B63177293"] = 0;
  level.advancetoenemygroup["_encstr_A7A408B9CA5D1D4E2C63"] = 0;
  level.advancetoenemyinterval = 2000;
  level.advancetoenemygroupmax = 3;
}

initmeleecharges() {
  anim.meleechargetimers["_encstr_9B07038DB1"] = 0;
  anim.meleechargeintervals["_encstr_9B07038DB1"] = 9000;
  anim.meleechargeplayertimers["_encstr_9B07038DB1"] = 0;
  anim.meleechargeplayerintervals["_encstr_9B07038DB1"] = 15000;
  anim.meleechargetimers["_encstr_ABBE07B995566D569C"] = 0;
  anim.meleechargeintervals["_encstr_ABBE07B995566D569C"] = 9000;
  anim.meleechargeplayertimers["_encstr_ABBE07B995566D569C"] = 0;
  anim.meleechargeplayerintervals["_encstr_ABBE07B995566D569C"] = 15000;
}

init_squadmanager() {
  if(isDefined(anim.squadinitialized) && anim.squadinitialized) {
    return;
  }
  anim.squadcreatefuncs = [];
  anim.squadcreatestrings = [];
  anim.squads = [];
  anim.squadindex = [];
  anim.squadrand = 0;
  anim.squadinitialized = 1;
}

initanimvars() {
  anim.animflagnameindex = 0;
  anim.combatmemorytimeconst = 10000;
  anim.combatmemorytimerand = 6000;
  anim.weaponsetupfuncs = [];
  anim.weaponsetupfuncs["_encstr_851904A33B16"] = ::c12_weaponsetup;
  anim.dismemberheavyfx = [];
  anim.weaponstowfunction = ::pickandsetforceweapon;

  if(!isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  if(!isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  if(!isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects = [];

  if(!isDefined(anim.shootenemywrapper_func))
    anim.shootenemywrapper_func = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::shootenemywrapper_shootnotify;

  if(!isDefined(anim.shootposwrapper_func))
    anim.shootposwrapper_func = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::shootposwrapper;

  anim.fire_notetrack_functions = [];
  anim.lastcarexplosiontime = -100000;
  anim.burstfirenumshots = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::array(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.fastburstfirenumshots = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::array(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.semifirenumshots = _encstr_8814195F88DBF19B491E65EE881B02CF4358AFAB60B32986B7367E::array(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim.badplaces = [];
  anim.badplaceint = 0;
}

c12_getweapontypeforweapon() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingrocketlauncher())
    return "_encstr_8D8A07F05F6987BF4B";
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingriflelikeweapon())
    return "_encstr_95AD085B5AB9D2ECABE6";

  return undefined;
}

c12_weaponsetup() {
  self.weapons = [];

  if(!nullweapon(self.primaryweapon)) {
    self.weapon = self.primaryweapon;
    self.weapons["_encstr_8253060E2B5FE330"] = c12_getweapontypeforweapon();
  }

  if(!nullweapon(self.secondaryweapon)) {
    self.weapon = self.secondaryweapon;
    self.weapons["_encstr_A5AD056A019C63"] = c12_getweapontypeforweapon();
  }

  self.weapon = isundefinedweapon();
  self.bulletsinclip = 1;
}

initwindowtraverse() {
  level.window_down_height[0] = -36.8552;
  level.window_down_height[1] = -27.0095;
  level.window_down_height[2] = -15.5981;
  level.window_down_height[3] = -4.37769;
  level.window_down_height[4] = 17.7776;
  level.window_down_height[5] = 59.8499;
  level.window_down_height[6] = 104.808;
  level.window_down_height[7] = 152.325;
  level.window_down_height[8] = 201.052;
  level.window_down_height[9] = 250.244;
  level.window_down_height[10] = 298.971;
  level.window_down_height[11] = 330.681;
}

setuprandomtable() {
  anim.randominttablesize = 60;
  anim.randominttable = [];

  for(var_0 = 0; var_0 < anim.randominttablesize; var_0++)
    anim.randominttable[var_0] = var_0;

  for(var_0 = 0; var_0 < anim.randominttablesize; var_0++) {
    var_1 = randomint(anim.randominttablesize);
    var_2 = anim.randominttable[var_0];
    anim.randominttable[var_0] = anim.randominttable[var_1];
    anim.randominttable[var_1] = var_2;
  }
}

setupweapons() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_84190E8DB7B019FA33B4B9B4B94356C8");

  if(isDefined(anim.weaponsetupfuncs) && isDefined(anim.weaponsetupfuncs[self.unittype]))
    self[[anim.weaponsetupfuncs[self.unittype]]]();
  else
    default_weaponsetup();
}

setscriptammo(var_0, var_1, var_2) {
  if(isDefined(var_1.script_ammo_clip))
    self itemweaponsetammo(var_1.script_ammo_clip, var_1.script_ammo_extra);
  else if(isDefined(var_1.script_ammo_extra))
    self itemweaponsetammo(var_1.script_ammo_clip, var_1.script_ammo_extra);

  if(isDefined(var_1.script_ammo_alt_clip))
    self itemweaponsetammo(var_1.script_ammo_alt_clip, var_1.script_ammo_alt_extra, undefined, 1);
  else if(isDefined(var_1.script_ammo_alt_extra))
    self itemweaponsetammo(var_1.script_ammo_alt_clip, var_1.script_ammo_alt_extra, undefined, 1);

  if(isDefined(var_1.script_ammo_max))
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));

  if(istrue(var_2))
    self itemweaponsetammo(1, 6, 0, 1);
  else if(issubstr(var_0, "_encstr_86110D3329C8F7B510B5B2BD2F9BBA") || issubstr(var_0, "_encstr_BE780E7361D145B2AAD3DACA6758DB90"))
    self itemweaponsetammo(1, 1, 0, 1);
}