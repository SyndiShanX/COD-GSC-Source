/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_48a4239470df1e08.gsc
*****************************************************/

#using script_61aaa2ffe334dbde;
#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\damagefeedback;
#namespace namespace_9c78033d1af4cb71;

function private autoexec __init__system__() {
  system::register(#"hash_f5a9c1bdd23c6934", undefined, undefined, &post_main);
}

function private post_main() {
  level thread function_e45c3f86a46d03db();
}

function private function_2d9805b4e5838429(entity) {
  return isDefined(entity.unittype) && entity.unittype == "\x9b\x11\"\xd6\xfb;";
}

function private function_e45c3f86a46d03db() {
  player = level.player;
  player endon("\x1e\xfd\xd1\xa2\a");
  player namespace_9c6af7bc2adacbee::function_d802e1ce8bdd5552();
  oldactor = undefined;
  initialanchor = player;
  datacache = spawnStruct();
  datacache.prevactor = initialanchor;
  datacache.prevhealth = -1;
  player.var_790664b058897d05 = datacache;
  hidebartime = 0;
  hidedelay = 400;
  updateinterval = 0.05;
  updatems = int(updateinterval * 1000);
  widgetstruct = spawnStruct();
  widgetstruct.ent = initialanchor;
  widgetstruct.anchor_type = "\xe5'v\xf5\xb1\x94\x1c~\xbc3\x9c?\x8f\xca\xf7&k&\xc1\xf3;o\x01\x8ci,\xc3\xca\xd7U\xfd\x94\xfb\xfaI+6a\x801l";
  widgetstruct.remove_on_death = 0;
  var_2d85848eb889961c = hud_management::function_a1a13273e72bfe46("\xff\xf7\x05\xfc\xa0\x11-5v\xf8#J)o\xed\xf4\x05\b\x9c\xa5\xbby\x0e\x05\x86\v0\xd3\xe1\xdf:\x1ad");
  player hud_management::function_35924dfcb78711f4("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", var_2d85848eb889961c, widgetstruct);
  player hud_management::function_d8d634ceece460("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", "\xd8VZW\xd3\xad");
  level.healthbaroffsets = [(0, 0, 0), (0, 0, 30), (0, 0, 60)];
  var_ca60e6f12ae8b883 = 0.991;
  level.var_c5ecde845cb04ab2 = [1000, 2500, var_ca60e6f12ae8b883, 0.999];
  level.var_57015ee01eab10b = [150, 1000, 0.95, var_ca60e6f12ae8b883];

  while(true) {
    checktime = hidebartime - hidedelay + updatems;
    time = gettime();
    playerorigin = player getorigin();
    playerangles = player getplayerangles();
    playerfwd = anglesToForward(playerangles);
    tracestart = player getvieworigin();
    newactor = undefined;
    bestdot = 0;

    if(isactor(player.lookatent) && istrue(player.lookatent.enablehealthbar) && !istrue(player.lookatent.doinglongdeath) && !player.lookatent utility::ent_flag("\x89\xa9\xa85\xc3\xaeP:^~")) {
      newactor = player.lookatent;
    } else if(!isDefined(oldactor) || checktime < time) {
      all_enemies = getaiarrayinradius(playerorigin, 2048, ["?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1"]);

      foreach(guy in all_enemies) {
        var_148842deec6c3733 = isDefined(guy.shadowarmor) && guy.shadowarmor > 0;

        if(!istrue(guy.enablehealthbar) || !var_148842deec6c3733 || guy utility::ent_flag("\x89\xa9\xa85\xc3\xaeP:^~")) {
          continue;
        }

        isvisible = player utility_sp::function_9763c1b8660451c9(guy, 1, "8\xcaP8\x8c");
        guy.healthbarvisible = isvisible;
        guy.var_1ac10d81c3e79326 = time;

        if(!isvisible || istrue(guy.doinglongdeath)) {
          continue;
        }

        if(!function_2d9805b4e5838429(guy)) {
          var_718399dc4a722b60 = player namespace_9c6af7bc2adacbee::function_3c22b02277d856c8(guy);

          if(var_718399dc4a722b60) {
            function_c5af4f5730f0e40b(player, guy);
          }
        }

        dotcheckresults = guy function_489a051c048d16dd(playerfwd, tracestart, playerorigin);

        if(dotcheckresults["\x8b\a\x17_"]) {
          currentdot = dotcheckresults["Q&\xf7\xcf\xe0\xeb[@{"];

          if(bestdot < currentdot && isvisible) {
            newactor = guy;
            bestdot = currentdot;
          }
        }
      }
    }

    if(newactor != oldactor) {
      if(isDefined(newactor)) {
        if(function_2d9805b4e5838429(newactor)) {
          player hud_management::function_7b7d992c0de840f("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", newactor, "\xe5'v\xf5\xb1\x94\x1c~\xbc3\x9c?\x8f\xca\xf7&k&\xc1\xf3;o\x01\x8ci,\xc3\xca\xd7U\xfd\x94\xfb\xfaI+6a\x801l");
        }

        player thread function_35ad1611d0be1b34(newactor);
        oldactor = newactor;
        hidebartime = time + hidedelay;
      } else if(isDefined(oldactor)) {
        var_bc7a39cf9629cf81 = player namespace_9c6af7bc2adacbee::function_6ee8c20e1f070ac1(oldactor) == "{\xd0\x9e\xf49\xc6\x16\x97";

        if(!var_bc7a39cf9629cf81 && oldactor function_489a051c048d16dd(playerfwd, tracestart, playerorigin)["\x8b\a\x17_"] && player utility_sp::function_9763c1b8660451c9(oldactor, 1, "8\xcaP8\x8c")) {
          hidebartime = time + hidedelay;
        } else if(var_bc7a39cf9629cf81 || time > hidebartime) {
          if(function_2d9805b4e5838429(oldactor)) {
            player function_b3d761c52184088c();
          } else if(!var_bc7a39cf9629cf81) {
            player shrinkhealthbar(oldactor);
          }

          oldactor = undefined;
          player notify(" \x93\x8a\xb8Z\xe1\x88\x9cA\xed(|\xd2\xf1\x82\xec\xa1\xf1&\xd6");
        }
      }
    } else {
      hidebartime = time + hidedelay;
    }

    wait updateinterval;
  }
}

function private function_489a051c048d16dd(playerfwd, tracestart, playerorigin) {
  retstruct = [];
  retstruct["\x8b\a\x17_"] = 0;
  retstruct["Q&\xf7\xcf\xe0\xeb[@{"] = 0;
  dot = 0;

  for(i = 0; i < level.healthbaroffsets.size; i++) {
    testdot = vectordot(playerfwd, vectorNormalize(self.origin + level.healthbaroffsets[i] - tracestart));

    if(testdot > dot) {
      dot = testdot;
    }
  }

  retstruct["Q&\xf7\xcf\xe0\xeb[@{"] = dot;

  if(dot < 0.707) {
    return retstruct;
  }

  dist = distance(self.origin, playerorigin);

  if(dist < 1000) {
    remapcheck = level.var_57015ee01eab10b;
  } else {
    remapcheck = level.var_c5ecde845cb04ab2;
  }

  remapdist = clamp(dist, 150, 2500);
  indot = math::remap(remapdist, remapcheck[0], remapcheck[1], remapcheck[2], remapcheck[3]);

  if(dot > indot) {
    retstruct["\x8b\a\x17_"] = 1;
  }

  return retstruct;
}

function private showhealthbar(actor) {
  player = self;
  curstate = player namespace_9c6af7bc2adacbee::function_6ee8c20e1f070ac1(actor);

  if(player.var_790664b058897d05.prevactor != player && isDefined(player.var_790664b058897d05.prevactor) && player.var_790664b058897d05.prevactor != actor) {
    if(curstate != "{\xd0\x9e\xf49\xc6\x16\x97") {
      player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(player.var_790664b058897d05.prevactor, "\x87Z\x01\xf9X\x8a");
    }
  }

  if(function_2d9805b4e5838429(actor)) {
    player hud_management::function_d8d634ceece460("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", "\xf0\xba\x8f\x9d");
    param = "\x87C;\x1f\t\x93\xeb\x86\x1d\xfd\xb1[\xd3i4\xe0\x19\xcd";

    if(isDefined(actor.var_892567d7d27b24e2)) {
      param = actor.var_892567d7d27b24e2;
    }

    player hud_management::function_b683400f784cb7dc("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", param);

    if(isDefined(actor.var_90ed0de999f7f413)) {
      player hud_management::function_d3b457baa69dec73("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", "3\xad\xb68\xb6\xeaY\xe6T\xfc\x01\x11\x9c\xea]\x15,\x7f", actor.var_90ed0de999f7f413);
    }
  } else {
    player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(actor, "\xcaD\xf5\xd4\x82\t");
  }

  player.var_790664b058897d05.prevactor = actor;
  player.var_790664b058897d05.prevhealth = -1;
  player.var_790664b058897d05.prevarmor = -1;
}

function private function_b3d761c52184088c() {
  player = self;
  player hud_management::function_7b7d992c0de840f("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", player, "\xe5'v\xf5\xb1\x94\x1c~\xbc3\x9c?\x8f\xca\xf7&k&\xc1\xf3;o\x01\x8ci,\xc3\xca\xd7U\xfd\x94\xfb\xfaI+6a\x801l");
  player hud_management::function_d8d634ceece460("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", "\xd8VZW\xd3\xad");
  player.var_790664b058897d05.prevhealth = -1;
  player.var_790664b058897d05.prevarmor = -1;
}

function private hidehealthbar(ent_num) {
  player = self;

  if(!player namespace_9c6af7bc2adacbee::function_aaf323f136885fe7(ent_num)) {
    return;
  }

  player.var_790664b058897d05.prevhealth = -1;
  player.var_790664b058897d05.prevarmor = -1;
  player namespace_9c6af7bc2adacbee::function_3f42c8f248f0224(ent_num);
}

function private shrinkhealthbar(actor) {
  player = self;

  if(!player namespace_9c6af7bc2adacbee::function_aaf323f136885fe7(actor getentitynumber())) {
    return;
  }

  curstate = player namespace_9c6af7bc2adacbee::function_6ee8c20e1f070ac1(actor);

  if(curstate != "{\xd0\x9e\xf49\xc6\x16\x97") {
    player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(actor, "\x87Z\x01\xf9X\x8a");
  }

  player.var_790664b058897d05.prevhealth = -1;
  player.var_790664b058897d05.prevarmor = -1;
}

function private function_dc44e088a690672a(actor) {
  player = self;

  if(!player namespace_9c6af7bc2adacbee::function_aaf323f136885fe7(actor getentitynumber())) {
    return;
  }

  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("~\x19vt<\x88\xe7NO2j\x99\x0e\x16dP\x02\r\xea&\xf6\xb6\xe1J\xc1" + actor getentitynumber());
  actor endon("\x1e\xfd\xd1\xa2\a");
  actor.var_1ac10d81c3e79326 = gettime();
  prevvis = actor.healthbarvisible ?? 1;
  var_ceb81c549572d907 = 500;

  while(true) {
    time = gettime();

    if(time - actor.var_1ac10d81c3e79326 >= var_ceb81c549572d907) {
      actor.healthbarvisible = player utility_sp::function_9763c1b8660451c9(actor, 1, "8\xcaP8\x8c");
      actor.var_1ac10d81c3e79326 = time;
    }

    if(isDefined(actor.healthbarvisible) && prevvis != actor.healthbarvisible) {
      prevvis = actor.healthbarvisible;

      if(!actor.healthbarvisible) {
        player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(actor, "{\xd0\x9e\xf49\xc6\x16\x97");
      } else if(!isDefined(player.lookatent) || player.lookatent != actor) {
        curstate = player namespace_9c6af7bc2adacbee::function_6ee8c20e1f070ac1(actor);

        if(curstate != "\xcaD\xf5\xd4\x82\t") {
          player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(actor, "\xaa\xb9\xb7\xd8\xb16u\x8c+d");
        }
      }
    }

    waitframe();
  }
}

function private function_9269cb7f4088d495(actor) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  ent_num = actor getentitynumber();
  player endon("~\x19vt<\x88\xe7NO2j\x99\x0e\x16dP\x02\r\xea&\xf6\xb6\xe1J\xc1" + actor getentitynumber());

  while(isDefined(actor)) {
    msg = actor utility::waittill_any_return("\x1e\xfd\xd1\xa2\a", "*\xeb\x7f!\xa4\xb9\xe6/\xcf\a", "P\x16\xce\xf4\xcf\xd8>V`\x92\xaf\x9f\x12\xd3", "\xc5c\b\x02~\r];]\xe3\xdf\x04x", "\xafYgV\xa2`\xa2D\xa8\x96na\x99G7\x90-of", "\fU`\xc0y\x95", "\xba\x9e9\x10\xc4{\x18\xde\xd3\x98\x8cix\x10\x176\x8d\xf2v\xc6\xbd\x89\xa5");

    if(msg == "\x1e\xfd\xd1\xa2\a" || msg == "*\xeb\x7f!\xa4\xb9\xe6/\xcf\a" || msg == "P\x16\xce\xf4\xcf\xd8>V`\x92\xaf\x9f\x12\xd3" || msg == "\xc5c\b\x02~\r];]\xe3\xdf\x04x" || msg == "\xafYgV\xa2`\xa2D\xa8\x96na\x99G7\x90-of") {
      player hidehealthbar(ent_num);
      break;
    } else {
      displayarmor = actor.shadowarmor ?? 0;

      if(displayarmor <= 0) {
        player hidehealthbar(ent_num);
        break;
      }
    }

    waittillframeend();
  }
}

function private function_cf47e4f2c5e4ab1f(rawdistance, mindistance, maxdistance, minvalue, maxvalue) {
  clampeddist = clamp(rawdistance, mindistance, maxdistance);
  return floor(math::remap(clampeddist, mindistance, maxdistance, maxvalue, minvalue));
}

function private function_da170c5de61bc279(actor) {
  player = self;

  if(!player namespace_9c6af7bc2adacbee::function_aaf323f136885fe7(actor getentitynumber())) {
    return;
  }

  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("~\x19vt<\x88\xe7NO2j\x99\x0e\x16dP\x02\r\xea&\xf6\xb6\xe1J\xc1" + actor getentitynumber());
  actor endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(actor)) {
    rawdist = distance(actor.origin, player getorigin());
    actor.var_aa1196ec47eb6ee9["J\a]/F\n\xbfU\x9d\xf4\n\x0e=\xeff"] = function_cf47e4f2c5e4ab1f(rawdist, 750, 1200, 9, 7);
    actor.var_aa1196ec47eb6ee9["\x8f.!\x82\xbad\xf9\x9f\x1e\xee b"] = function_cf47e4f2c5e4ab1f(rawdist, 1000, 1500, 10, 25);
    player namespace_9c6af7bc2adacbee::function_94bed235dabe3f88(actor);
    waitframe();
  }
}

function private function_6ba8cf9cd7305841(actor) {
  player = self;
  player namespace_9c6af7bc2adacbee::function_ca98fa678e58d265(actor, "jM\x85\xe3");
  actor.var_aa1196ec47eb6ee9 = [];
  actor.var_aa1196ec47eb6ee9["\xbc\f\xc5\xb0\xfet\xb6\x98U\x99\x14\x11\x10\xe7\x88"] = function_fe7e5260a66cdd54(actor);
  player namespace_9c6af7bc2adacbee::function_94bed235dabe3f88(actor);
}

function private function_35ad1611d0be1b34(actor) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify(" \x93\x8a\xb8Z\xe1\x88\x9cA\xed(|\xd2\xf1\x82\xec\xa1\xf1&\xd6");
  player endon(" \x93\x8a\xb8Z\xe1\x88\x9cA\xed(|\xd2\xf1\x82\xec\xa1\xf1&\xd6");
  actor notify("\xc1\x1b\vyYN_\xc6{okX\x1d\xafh\x95\xc2\xb1:\x1ab,9");
  player showhealthbar(actor);
  iszombieactor = function_2d9805b4e5838429(actor);

  while(isDefined(actor)) {
    prevhealth = player.var_790664b058897d05.prevhealth;
    prevarmor = player.var_790664b058897d05.prevarmor;
    shouldupdate = iszombieactor ? actor.health != prevhealth : actor.shadowarmor != prevarmor;

    if(shouldupdate) {
      if(iszombieactor) {
        newhealthpct = actor.health / actor.maxhealth;
        player hud_management::function_d3b457baa69dec73("\x86L\xba^\xc4\x9a\xa2\xdc2h\x98\xf0\xa7\xabJ\x8a\xc1[+j\xa8^\xed<\x1f\xa6", "z\xa8\xf9\xbcC\x9b\x11\x91u\x91\x1e\x19\xb5\xc0)Xzp", newhealthpct);
      } else {
        displayarmor = 0;

        if(isDefined(actor.shadowarmor) && actor.shadowarmor > 0) {
          displayarmor = actor.shadowarmor;
        }

        if(displayarmor <= 0) {
          break;
        }

        actor.var_aa1196ec47eb6ee9["\xbc\f\xc5\xb0\xfet\xb6\x98U\x99\x14\x11\x10\xe7\x88"] = function_fe7e5260a66cdd54(actor);
        actor.var_aa1196ec47eb6ee9["\xc3\x9auL+G\xa7\xb3\xb0\xef \xcb\x86"] = displayarmor;
        player namespace_9c6af7bc2adacbee::function_94bed235dabe3f88(actor);
        player.var_790664b058897d05.prevarmor = displayarmor;
      }

      player.var_790664b058897d05.prevhealth = actor.health;
    }

    msg = actor utility::waittill_any_return("\fU`\xc0y\x95", "\xba\x9e9\x10\xc4{\x18\xde\xd3\x98\x8cix\x10\x176\x8d\xf2v\xc6\xbd\x89\xa5", "\x1e\xfd\xd1\xa2\a", "*\xeb\x7f!\xa4\xb9\xe6/\xcf\a");

    if(iszombieactor && (msg == "\x1e\xfd\xd1\xa2\a" || msg == "*\xeb\x7f!\xa4\xb9\xe6/\xcf\a")) {
      player function_b3d761c52184088c();
      break;
    }

    waittillframeend();
  }
}

function private function_c5af4f5730f0e40b(player, entity) {
  player function_6ba8cf9cd7305841(entity);
  player thread function_da170c5de61bc279(entity);
  player thread function_dc44e088a690672a(entity);
  player thread function_9269cb7f4088d495(entity);
}

function setarmor(armorvalue, increasemaxhealth = 0) {
  armorvalue = int(armorvalue);
  self.shadowarmor = armorvalue;
  self.shadowarmormax = armorvalue;

  if(increasemaxhealth) {
    healthvalue = armorvalue + self.health;
    newmax = self.maxhealth + armorvalue;
    self.health = healthvalue;
    self.maxhealth = newmax;
  }

  self.healthpips = self.maxhealth - self.shadowarmormax;
  var_718399dc4a722b60 = level.player namespace_9c6af7bc2adacbee::function_3c22b02277d856c8(self);

  if(var_718399dc4a722b60) {
    function_c5af4f5730f0e40b(level.player, self);
  }

  trackshadowarmor();
}

function addarmor(extraarmor) {
  if(!isDefined(self.shadowarmormax) || self.shadowarmormax == 0) {
    setarmor(extraarmor, 1);

    if(isfunction(level.var_802897f70c231d7a)) {
      self[[level.var_802897f70c231d7a]]();
    }
  } else {
    oldmax = self.maxhealth;
    newsa = math::round_float((self.shadowarmor + extraarmor) / 1330 + 0.5, 0, 1) * 1330;
    newsa = min(self.shadowarmormax, newsa);
    maxadd = int(newsa - self.shadowarmor);
    self.health += maxadd;
    self.maxhealth = oldmax;
    self.shadowarmor += maxadd;

    if(isDefined(self.var_2bceba18e0b27277)) {
      self.var_4cc69f5cde478bfb = self.var_2bceba18e0b27277;
    }
  }

  self.var_c38dfabbf7656462 = 1;
  var_718399dc4a722b60 = level.player namespace_9c6af7bc2adacbee::function_3c22b02277d856c8(self);

  if(var_718399dc4a722b60) {
    function_c5af4f5730f0e40b(level.player, self);
  }

  trackshadowarmor();
}

function trackshadowarmor() {
  if(getdvarint(@ "hash_ee2f59f415bbde93", 0) > 0) {
    thread debugprintarmorhealth();
  }

  if(self.shadowarmor > 0) {
    self setsurfacetype("J$\xfa1 \xdfH%?%");

    if(!isDefined(self.var_e80ee03f4075c446)) {
      utility_sp::function_940ea80ad54d7dc4(&function_c94da39c4a17e);
      self.var_e80ee03f4075c446 = 1;
    }

    return;
  }

  utility_sp::remove_damage_function(&function_c94da39c4a17e);
  self.var_e80ee03f4075c446 = undefined;
}

function private function_c94da39c4a17e(damage, attacker, direction, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if((self.shadowarmor ?? 0) > 0) {
    damagefeedback::function_cba21d645862bfd5(2);
    self.shadowarmor -= damage;
  }

  if((self.shadowarmor ?? 0) <= 0) {
    damagefeedback::function_cba21d645862bfd5(4);
    self setsurfacetype(";Z\x0f\xdaH");
    self.shadowarmor = 0;

    if(!isDefined(self.special_type)) {
      self.var_c38dfabbf7656462 = 0;
      self.enablehealthbar = 0;
      ent_num = self getentitynumber();

      if(level.player namespace_9c6af7bc2adacbee::function_aaf323f136885fe7(ent_num)) {
        level.player namespace_9c6af7bc2adacbee::function_3f42c8f248f0224(ent_num);
      }
    }

    utility_sp::remove_damage_function(&function_c94da39c4a17e);
    self.var_e80ee03f4075c446 = undefined;

    if(isDefined(self.var_85c66c914a03e823)) {
      self.var_4cc69f5cde478bfb = self.var_85c66c914a03e823;
    }
  }
}

function function_fe7e5260a66cdd54(entity) {
  if(isDefined(entity)) {
    return entity utility::ent_flag("\xb4\xdc_X\x91\xd9\x85\x9bc\x95\x8c\xaf\x95\xb9e\xb6\xf2");
  }

  return 0;
}

function debugprintarmorhealth() {
  self notify("\xd4pf\x19\x8c\xdc\xcc\x98Vc3`\xccf3\x9a");
  self endon("\xd4pf\x19\x8c\xdc\xcc\x98Vc3`\xccf3\x9a");
  self endon("<dev string:x24>");
  dist_threshold = 1300;
  var_36d56f3ef3df5c5 = 1000;
  var_cef37d832a07d07c = 12000;

  while(true) {
    dist = distance(level.player.origin, self.origin);

    if(dist > var_cef37d832a07d07c) {
      continue;
    }

    if(dist < dist_threshold / 4) {
      dist = dist_threshold / 4;
    }

    text_size = 2 * dist / dist_threshold;
    displayhealthmax = self.maxhealth - (self.shadowarmormax ?? 0);
    displayhealth = self.health - (self.shadowarmor ?? 0);
    displayarmormax = 0;
    displayarmor = 0;
    var_f48c74b83c609bec = int((displayhealthmax - 1) / 1330) + 1;
    var_40caf914964bad50 = displayhealth % 1330 / 1330;

    if(var_40caf914964bad50 == 0) {
      var_40caf914964bad50 = 1;
    }

    if(isDefined(self.shadowarmormax) && self.shadowarmormax > 0) {
      displayarmormax = self.shadowarmormax;
      displayarmor = self.shadowarmor;
    }

    out = "<dev string:x2d>" + displayhealth;
    print3d(self.origin + (0, 0, -20), out, (0, 1, 0), 1, text_size, 1, 1);

    if(isDefined(self.shadowarmormax) && self.shadowarmormax > 0) {
      out = "<dev string:x2d>" + self.shadowarmor;
    } else {
      out = "<dev string:x31>";
    }

    print3d(self.origin + (0, 0, -24 - 10 * text_size), out, (0.517647, 0.937255, 0.964706), 1, text_size, 1, 1);
    waitframe();
  }
}

# /