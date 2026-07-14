/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_f3a280c3232484d.gsc
****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace landmine;

function autoexec main() {
  utility::registersharedfunc(#"super_landmine", #"use", &landmine_use);
  utility::registersharedfunc(#"super_landmine", #"modifydamage", &function_9f1b9f23857a9db0);
  level callback::add(#"equipment_init", &landmine_init);
  level._effect["\x1b\x16@\x97\xc6<c\x1f{\xa8\xc2\xa4\xf4\x13\x1a\xf8+\xf4-\x91\xc4\f\xfd\xb0"] = loadfxasset("v\x9fa\xce5\xeed\x93\xbc\x1dr\xcd\xd6\x81\x8c\x01A(\xdd\x04\xb2\xdd\xfa\x12\xf9\xdeX@\xc1~c\xa5\v\x16C\x847h\x03\xb0");
}

function landmine_init(params) {
  var_90c9df0a100a8f7b = namespace_bc7cdace2d7445a5::vehicleminesgetleveldataforminesharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", 1);

  if(isDefined(var_90c9df0a100a8f7b)) {
    var_90c9df0a100a8f7b.radius = 100;
    var_90c9df0a100a8f7b.triggercallback = &function_1ceebce8cb93fc2a;
  }
}

function landmine_use(grenade) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  grenade endon("\x1e\xfd\xd1\xa2\a");
  issuper = 1;

  if(utility::issharedfuncdefined(#"equipment", #"getequipmentbundlefromweaponname")) {
    equipmentbundle = [[utility::getsharedfunc(#"equipment", #"getequipmentbundlefromweaponname")]](grenade.weapon_name);
    issuper = !isDefined(equipmentbundle) || equipmentbundle.equipmenttype == "n\xabp\x95\xc9";
  }

  if(issuper) {
    grenade.superref = "\x98\xea\xb1\x125\xe59\xc2\xc2*\x1b\x99\x04\xed";
    grenade.issuper = 1;
    grenade.bundle = namespace_bc7cdace2d7445a5::getsuperbundlefromoffhandweaponnamesharedfunc(grenade.weapon_name);
  }

  if(utility::issharedfuncdefined(#"jamming_system", #"hash_ca0042e3cac99672")) {
    grenade[[utility::getsharedfunc(#"jamming_system", #"hash_ca0042e3cac99672")]](grenade);
  }

  if(namespace_bc7cdace2d7445a5::hasperksharedfunc("\xa3\xd7h\xbf\xeb\xde\xf0X4us\x85\b\xc9\x8d\xd9C\x85\xbe\xf0")) {
    grenade.hasruggedeqp = 1;
  }

  grenade namespace_bc7cdace2d7445a5::registerspawnsharedfunc(2, &deletemine);
  thread namespace_bc7cdace2d7445a5::monitordisownedgrenadesharedfunc(self, grenade);
  grenade thread function_39bf2ad5ae19dc49();
  grenade setscriptablepartstate("}\xcaEC\x05\x96", "\x19b\xc2y", 0);
  data = spawnStruct();
  data.endonstring = "@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N";
  data.skipdeath = 1;
  grenade thread namespace_bc7cdace2d7445a5::handlemovingplatformtouchsharedfunc(data);
  grenade thread function_1fcdec5dd8955ea5();

  if(utility::issharedfuncdefined("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_68160ecc80207080")) {
    grenade thread[[utility::getsharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_68160ecc80207080")]]();
  }

  grenade thread function_d3edbf209d07b094(0.1);
  grenade waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, hitent, surfacetype, velocity, position, normal);

  if(isDefined(stuckto)) {
    if(isent(stuckto) && is_train_ent(stuckto)) {
      grenade.origin += (0, 0, 1.6);
    }

    grenade linkTo(stuckto);
  }

  thread landmine_plant(grenade, surfacetype);
}

function function_d3edbf209d07b094(delaytime) {
  if(self isscriptable()) {
    wait delaytime;

    if(isDefined(self)) {
      self setscriptablepartstate("\xe5\xd8!\xb8n\x8e\xf0\xc4\x86\xf7", "\xf1\xba\x8f\x9d", 0);
    }
  }
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }

      if(isDefined(ent.linked_model) && ent.linked_model == hitent) {
        return true;
      }
    }
  }

  return false;
}

function function_3d5574b85e88e22d() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    namespace_bc7cdace2d7445a5::removespawninfluencersharedfunc(self.dangerzone);
  }

  self.dangerzone = namespace_bc7cdace2d7445a5::addspawninfluencersharedfunc(#"equipment_mine", self.origin, self.owner.team);
}

function function_1fcdec5dd8955ea5() {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x98z\x03)`\x84\xe9]IY\x88\x80)[{\x96\x14x#\x19");
  self setscriptablepartstate("}\xcaEC\x05\x96", "\xf1\xba\x8f\x9d", 0);
}

function landmine_plant(grenade, surfacetype) {
  grenade endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  grenade endon("\x1e\xfd\xd1\xa2\a");
  grenade setotherent(self);
  grenade setentityowner(self);
  grenade missilethermal();
  grenade missileoutline();
  grenade setnodeploy(1);
  grenade setscriptablepartstate("~xGEv", "\xe3\x93}=nD", 0);
  self setscriptablepartstate("\x1bR\xe74\xa1\xa6\xcf\xa6\xf2\xa3\xef\xb9D`\xb0\xd7\xc3", "~xGEv", 0);
  namespace_bc7cdace2d7445a5::onequipmentplantedsharedfunc(grenade, "\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", &landmine_delete);
  thread namespace_bc7cdace2d7445a5::monitordisownedequipmentsharedfunc(self, grenade);
  grenade namespace_bc7cdace2d7445a5::registersentientsharedfunc("T\x8bD\xf73P\xd7>B\xc9\x89KT", grenade.owner, 1);
  grenade thread namespace_bc7cdace2d7445a5::minedamagemonitorsharedfunc();
  grenade thread function_56a547f6efc895c1();

  if(utility::issharedfuncdefined("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"empapplied")) {
    grenade namespace_bc7cdace2d7445a5::function_9fcf8d7edb21246b(grenade, utility::getsharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"empapplied"));
  }

  grenade function_3d5574b85e88e22d();
  activationdelay = 1.5;

  if(isstruct(grenade.bundle) && isDefined(grenade.bundle.landmine_activationdelay)) {
    activationdelay = grenade.bundle.landmine_activationdelay;
  }

  wait activationdelay / 2;

  if(istrue(grenade.touchedmovingplatform)) {
    grenade thread function_41f166e8845f0892();
  }

  wait activationdelay / 2;
  grenade thread namespace_bc7cdace2d7445a5::remoteinteractsetupsharedfunc(&function_8ad2943de019591c, 1, 1);
  grenade setscriptablepartstate("r<\xab", "\xe3\x93}=nD", 0);
  grenade thread function_3939eff7773d6b59();

  if(getdvarint(@ "hash_fcaa19f9e8db6031", 0)) {
    grenade thread function_8b87e28c8f2a749d();
  }

  thread namespace_bc7cdace2d7445a5::outlineequipmentforownersharedfunc(grenade);
  grenade.headiconid = grenade namespace_bc7cdace2d7445a5::setheadiconfactionimagesharedfunc(1, 2, undefined, undefined, undefined, 0.1, 1, 0, undefined, undefined, level.gamemodebundle.var_57d1073267da10 ?? "\xd0\a\x17\x83J\xc2\x16\x05\x9e*\xf2FCA)=\x9e\xe9:4\x91\xc2\xaeF\xe8", "\x8a\xba\x18[x1}c\xa5\xff");
  function_6061acb13470584a(grenade, &landmine_destroy);
}

function function_8ad2943de019591c(owner) {
  thread landmine_delete(5);

  if(!isDefined(owner)) {
    owner = self.owner;
  }

  self setentityowner(owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\x91`\xb1\xe7T\x97>", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("*\x83\xc10XI\x1e", "U\x80jpz\x9ddE\x10U", 0);
  self setscriptablepartstate("*\xf6\xc5\"Vj", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xc2\a(QF\xf7\xaf;\xf0\xf1t", "\xf8\x88m", 0);
}

function function_353ff223b97faef(vehicle) {
  landminename = namespace_bc7cdace2d7445a5::getsuperweaponsharedfunc("\x98\xea\xb1\x125\xe59\xc2\xc2*\x1b\x99\x04\xed");

  if(!isDefined(landminename) && utility::issharedfuncdefined("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"getweaponname")) {
    landminename = [[utility::getsharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"getweaponname")]]();
  }

  landmineweapon = makeweapon(landminename);
  vehicle dodamage(200, self.origin, self.owner, self, "\xa2rl\xdaDn\x17b\xd9I\xc9=N", landmineweapon);
  ignoredamageid = vehicle namespace_bc7cdace2d7445a5::function_2db54c3cfcf48f11(self.owner, landmineweapon, self, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
  thread function_4d3edae0e02dfd6f();
  waitframe();

  if(isDefined(vehicle)) {
    vehicle namespace_bc7cdace2d7445a5::function_6119cc555f148b0e(ignoredamageid);
  }
}

function function_4d3edae0e02dfd6f() {
  thread landmine_delete(5);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xc6X\xab7l\xd0", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("*\x83\xc10XI\x1e", "\xa5\x01\xf6_\x9f\t\xae\xc7\x9f6\xa3", 0);
}

function function_c06848f9de9c1f(attacker) {
  if(isDefined(attacker) && isDefined(self.owner) && attacker != self.owner) {
    if(isDefined(self.bundle) && isDefined(self.bundle.var_5550935c9480f498)) {
      attacker thread namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(self.bundle.var_5550935c9480f498);
    }
  }

  thread landmine_delete(5);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xc6X\xab7l\xd0", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("*\x83\xc10XI\x1e", "\xc0\x99\xc2\xf7\xa3r\x80\xa4\xa4`", 0);
}

function landmine_destroy(attacker) {
  thread landmine_delete(5);
  self setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xc6X\xab7l\xd0", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\xe7\xe2ST\xee\xc0\xf6", "\xe3\x93}=nD", 0);
}

function landmine_delete(deletiondelay) {
  self notify("\x1e\xfd\xd1\xa2\a");

  if(isarray(level.mines)) {
    level.mines[self getentitynumber()] = undefined;
  }

  self setscriptablepartstate("\x05z'\xe2+\xd1\xaf\n\xa6X\xbc", "\xf8\x88m");
  self setCanDamage(0);
  namespace_bc7cdace2d7445a5::makeexplosiveunusuabletagsharedfunc();
  namespace_bc7cdace2d7445a5::setheadicondeleteiconsharedfunc(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    namespace_bc7cdace2d7445a5::removespawninfluencersharedfunc(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner namespace_bc7cdace2d7445a5::removeequipsharedfunc(self);
  }

  if(isDefined(self.launchedmine)) {
    self.launchedmine delete();
  }

  if(utility::issharedfuncdefined("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_b383a9b6a9ae6db1")) {
    [[utility::getsharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_b383a9b6a9ae6db1")]]();
  }

  if(utility::issharedfuncdefined(#"jamming_system", #"hash_c33ceb91d0ca7a9d")) {
    self[[utility::getsharedfunc(#"jamming_system", #"hash_c33ceb91d0ca7a9d")]](self);
  }

  namespace_bc7cdace2d7445a5::function_1e0e5420b430eac6(self);

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  namespace_bc7cdace2d7445a5::deregisterspawnsharedfunc();

  if(isDefined(self)) {
    self delete();
  }
}

function function_41f166e8845f0892() {
  self endon("u\xd6\x19Nt\xe34(%\xf07\xb6O;");
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.attachedvelocity = (0, 0, 0);
  update_interval = 0.2;

  while(true) {
    old_origin = self.origin;
    wait update_interval;
    self.attachedvelocity = 1 / update_interval * (self.origin - old_origin);
  }
}

function function_cfffdbe35754d52e(mine) {
  return isDefined(mine) && isDefined(mine.attachedvelocity) && length2dsquared(mine.attachedvelocity) > 0.01;
}

function function_3939eff7773d6b59() {
  self endon("u\xd6\x19Nt\xe34(%\xf07\xb6O;");
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  var_70bda978daa08d06 = undefined;

  if(utility::issharedfuncdefined(#"vehicle", #"vehicleminesisfriendlytomine")) {
    var_70bda978daa08d06 = utility::getsharedfunc(#"vehicle", #"vehicleminesisfriendlytomine");
  }

  var_67b22dee50822aad = undefined;

  if(utility::issharedfuncdefined(#"vehicle", #"vehicleminesshouldvehicletriggermine")) {
    var_67b22dee50822aad = utility::getsharedfunc(#"vehicle", #"vehicleminesshouldvehicletriggermine");
  }

  var_bd7de6b1096f14fa = undefined;

  if(utility::issharedfuncdefined(#"vehicle", #"vehicleminesminetrigger")) {
    var_bd7de6b1096f14fa = utility::getsharedfunc(#"vehicle", #"vehicleminesminetrigger");
  }

  triggerconditionfunc = undefined;

  if(utility::issharedfuncdefined("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_ff42655615376475")) {
    triggerconditionfunc = utility::getsharedfunc("\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b", #"hash_ff42655615376475");
  }

  isreallyalivefunc = undefined;

  if(utility::issharedfuncdefined(#"player", #"isreallyalive")) {
    triggerconditionfunc = utility::getsharedfunc(#"player", #"isreallyalive");
  }

  var_6f3a77589a06964a = isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_6f3a77589a06964a);

  while(true) {
    self waittill("h6b\xd0\x88\xbd\xd9e\xa4X\xa5\xc1 \b\x84", entarr);
    assert(isDefined(entarr));

    if(istrue(self.isdisabled) || istrue(self.isjammed)) {
      continue;
    }

    if(!isarray(entarr)) {
      entarr = [entarr];
    }

    foreach(ent in entarr) {
      if(ent.classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
        if(isDefined(var_70bda978daa08d06) && ent[[var_70bda978daa08d06]](self)) {
          continue;
        }

        if(isDefined(var_67b22dee50822aad) && ![[var_67b22dee50822aad]](ent, self)) {
          continue;
        }

        if(isDefined(var_bd7de6b1096f14fa)) {
          [[var_bd7de6b1096f14fa]](ent, self);
        }

        break;
      }

      if(isagent(ent) || isPlayer(ent) || isDefined(triggerconditionfunc) && [[triggerconditionfunc]](ent)) {
        if(isDefined(ent.vehicle)) {
          continue;
        }

        if(isDefined(isreallyalivefunc) && ![[isreallyalivefunc]](ent)) {
          continue;
        }

        if(var_6f3a77589a06964a && istrue(ent.spawnprotection)) {
          continue;
        }

        thread function_a454aadd2687bb3(ent);
        break;
      }
    }
  }
}

function function_8b87e28c8f2a749d() {
  self endon("<dev string:x24>");
  self endon("<dev string:x36>");
  self endon("<dev string:x48>");

  if(isDefined(self.debug_trig)) {
    self.debug_trig delete();
  }

  self.debug_trig = spawn("<dev string:x51>", self.origin, 0, 48, 48);
  self.debug_trig enablelinkTo();
  self.debug_trig linkTo(self);
  cylinder(self.origin, self.origin + (0, 0, 48), 48, (1, 1, 0), 0, 100);

  while(true) {
    self.debug_trig waittill("<dev string:x63>", ent);
    assert(isDefined(ent));
    self notify("<dev string:x6e>", [ent]);
    print3d(self.origin, "<dev string:x81>", (1, 1, 0), 1, 0.5, 100, 1);
  }
}

function function_a454aadd2687bb3(ent) {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("u\xd6\x19Nt\xe34(%\xf07\xb6O;");
  self.triggeredbyplayer = 1;
  namespace_bc7cdace2d7445a5::makeexplosiveunusuabletagsharedfunc();
  self setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  self setscriptablepartstate("\x91`\xb1\xe7T\x97>", "\xe3\x93}=nD", 0);
  self setscriptablepartstate("\xc2\a(QF\xf7\xaf;\xf0\xf1t", "\xb8\"", 0);

  if(utility::issharedfuncdefined(#"weapons", #"explosivetrigger")) {
    namespace_bc7cdace2d7445a5::explosivetriggersharedfunc(ent, 0.5);
  } else {
    wait 0.5;
  }

  thread function_e5db20042dc37803();
}

function function_1ceebce8cb93fc2a(vehicle, mine) {
  mine endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  mine endon("\x1e\xfd\xd1\xa2\a");
  mine.owner endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  mine notify("u\xd6\x19Nt\xe34(%\xf07\xb6O;");
  mine namespace_bc7cdace2d7445a5::makeexplosiveunusuabletagsharedfunc();
  mine setscriptablepartstate("r<\xab", "\xba\xa5\x1f\xc9m\x80i", 0);
  mine setscriptablepartstate("\x91`\xb1\xe7T\x97>", "\xe3\x93}=nD", 0);
  wait 0.2;
  mine thread function_353ff223b97faef(vehicle);
}

function deletemine() {
  landmine_delete(0);
}

function function_e5db20042dc37803() {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  flighttime = 0.2;

  if(flighttime > 0) {
    flightdir = (0, 0, 1);
    flightdest = self.origin + flightdir * 64;
    contents = physics_createcontents(["\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae.", "\x998b\x97\xb6Y\xbb\x05\x82\x19\xfb7\xb3\xfb\x9b\\\xdbx3\x14\xc6zp\a\xe4\xfe9"]);
    ignorelist = namespace_bc7cdace2d7445a5::getmineignorelistsharedfunc();
    caststart = self.origin;
    castend = flightdest;
    castresults = physics_raycast(caststart, castend, contents, ignorelist, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);
    collideexplosion = 0;

    if(isDefined(castresults) && castresults.size > 0) {
      castdist = vectordot(castresults[0]["\xc1\xbd\xdci\xe8i{7"] - caststart, flightdir);
      castdist = max(0, castdist - 1);
      flighttime = 0;
      flightdest = self.origin;

      if(castdist > 0) {
        flighttime = castdist / 64 * 0.2;
        flightdest = self.origin + flightdir * castdist;
      }

      collideexplosion = 1;
    }

    if(function_cfffdbe35754d52e(self)) {
      flightdest += self.attachedvelocity * flighttime;
    }

    if(flighttime > 0) {
      flighttimeremaining = flighttime;
      flightdeceltime = flighttimeremaining * 1;

      if(function_cfffdbe35754d52e(self)) {
        flightdeceltime *= 0.25;
      }

      flighttimeremaining -= flightdeceltime;
      flightacceltime = 0;

      if(flighttimeremaining > 0) {
        flightacceltime = flighttimeremaining * 0;
      }

      self setscriptablepartstate(#"visibility", #"hide");
      mover = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
      mover.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      mover setModel("\xec\xbfK|\au\xcd\xc2\x19<");
      self.mover = mover;
      mover.grenade = self;
      self linkTo(mover, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
      mover moveTo(flightdest, flighttime, flightacceltime, flightdeceltime);
      mover thread function_48b94f71e06cab91(flighttime);
      thread function_5a68c6f2ab8937fa(flighttime);
      childthread namespace_bc7cdace2d7445a5::watchflightcollisionsharedfunc();
      utility::waittill_any_timeout(flighttime + 0.05, "\xcc4H\x84pw\x9d\x81\f__\xb8X\xf5\xcd\x9d\x97\x99m\xab:A\xb7");

      if(!collideexplosion) {
        mover moveTo(flightdest - (0, 0, 25), 0.2, 0.2, 0);
        utility::waittill_any_timeout(0.2, "\xcc4H\x84pw\x9d\x81\f__\xb8X\xf5\xcd\x9d\x97\x99m\xab:A\xb7");
      }

      thread function_8ad2943de019591c();
      return;
    }
  }
}

function function_48b94f71e06cab91(flighttime) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.grenade utility::waittill_any_timeout(flighttime, "\x1e\xfd\xd1\xa2\a", "@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");

  if(isDefined(self.grenade)) {
    self moveTo(self.origin, 0.05, 0, 0);
  }

  while(isDefined(self.grenade)) {
    waitframe();
  }

  self delete();
}

function function_5a68c6f2ab8937fa(flighttime) {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  playFX(utility::getfx("\x1b\x16@\x97\xc6<c\x1f{\xa8\xc2\xa4\xf4\x13\x1a\xf8+\xf4-\x91\xc4\f\xfd\xb0"), self.origin, (1, 0, 0), (0, 0, 1));
  self setscriptablepartstate("\xc6X\xab7l\xd0", "\xe3\x93}=nD", 0);
}

function function_56a547f6efc895c1() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej", attacker);

  if(isDefined(attacker)) {
    thread function_c06848f9de9c1f(attacker);
    return;
  }

  if(isDefined(self.owner)) {
    thread function_c06848f9de9c1f(self.owner);
    return;
  }

  thread landmine_destroy();
}

function function_39bf2ad5ae19dc49() {
  self endon("@(\x9c\xb6\xb6\xf2\xd3\xcb\x96\x1fn\x86\xb5N");
  self endon("\x1e\xfd\xd1\xa2\a");
  level utility::waittill_any("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7", "\x1e\x14\x9e\x05H\x9a\xb7v\x82[\xd36\x88,");
  thread landmine_destroy();
}

function function_9f1b9f23857a9db0(victim, inflictor, objweapon, meansofdeath, damage) {
  if(!isDefined(inflictor)) {
    return damage;
  }

  if(meansofdeath != "\xa2rl\xdaDn\x17b\xd9I\xc9=N") {
    return damage;
  }

  if(!isDefined(objweapon)) {
    return damage;
  }

  if(isnullweapon(objweapon)) {
    return damage;
  }

  weaponrootname = getweaponrootstring(objweapon);

  if(weaponrootname != "\x1b\xec\xdfG\xd3\xcfIh\x90\xa3\xf8\xa7\x82\x8b") {
    return damage;
  }

  up = anglestoup(inflictor.angles);
  btwn = inflictor.origin - self getEye();
  var_4ffd5e9eb4c417de = vectordot(btwn, up);
  damagescalar = 1;

  if(istrue(inflictor.triggeredbyplayer)) {
    stance = victim getstance();
    diving = 0;

    if(isDefined(inflictor.bundle) && istrue(inflictor.bundle.var_199ddae9eae18a70)) {
      diving = victim isdiving();
    }

    if(var_4ffd5e9eb4c417de > 30) {
      damagescalar = 0;
    }

    if(diving || stance == "GX\xa9]\x82") {
      if(istrue(inflictor.bundle.var_2f5ee9d6a7d79f9b)) {
        damagescalar = inflictor.bundle.var_6b011ad59c4ec29e;
      } else {
        damagescalar = 0;
      }
    }

    if(stance == "1x\xc5\xb4\xabx") {
      if(istrue(inflictor.bundle.var_2f5ee9d6a7d79f9b)) {
        damagescalar = inflictor.bundle.var_b52f6b473c0ed566;
      }
    }
  }

  return int(damage * damagescalar);
}

function function_a7a8a85547ca8b0e(launchedmine) {
  launchedmine endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(launchedmine)) {
    return;
  }

  launchedmine delete();
}

function landmine_disable(attacker) {
  self endon("\x1e\xfd\xd1\xa2\a");
  attacker thread namespace_bc7cdace2d7445a5::doscoreeventsharedfunc(#"disabled_at_mine");
  self.isdisabled = 1;
  self setscriptablepartstate("Ym\x83\x8c", "\xe3\x93}=nD", 0);
  wait 6;
  self.isdisabled = 0;
  self setscriptablepartstate("Ym\x83\x8c", "\xba\xa5\x1f\xc9m\x80i", 0);
}

function function_6061acb13470584a(ent, callbackfunction) {
  if(isDefined(level.var_e7a9ed2fd96319b)) {
    [[utility::getsharedfunc(#"game", #"registerentincrushzones")]](ent);
    ent.var_b318c9b26f4f17ea = callbackfunction;
  }
}